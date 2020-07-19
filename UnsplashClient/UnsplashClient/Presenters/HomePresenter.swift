//
//  HomePresenter.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 07/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit

protocol HomePresenterProtocol: AnyObject {
    var homeUseCase:HomeUseCasesProtocol {get}
    var delegate:HomePresenterDelegate? {get set}
    var photos:[PhotoVM] {get set}
    var currentCount:Int {get}
    var totalCount:Int {get}
    func getPhoto(at indexPath:IndexPath) -> PhotoVM?
    func likePhoto(id:String, onCompletion:@escaping(String?)->Void)
    func startSearchingPhoto(query:String)
    func searchPhoto()
    
    func loadFeed(isSearching:Bool)
    func cancelFeedLoad(for indexPaths:[IndexPath])
    func downloadImageWithURLSession(at indexPath:IndexPath, with url:URL)
    func downloadWithGlobalQueue(at indexPath:IndexPath, with url:URL)
    func startOperation(at indexPath:IndexPath)
    
}

class HomePresenter:HomePresenterProtocol {
    private var currentPage = 0
    private var isFetchInProgress = false
    private var searchQuery:String = String()
    var homeUseCase:HomeUseCasesProtocol
    unowned var delegate:HomePresenterDelegate?
    var photos:[PhotoVM] = []
    let pendingOperations:PendingOperations
    var currentCount: Int {
        return self.photos.count
    }
    var totalCount: Int {
      return 200
    }
    
    init(homeUseCase:HomeUseCasesProtocol, pendingOperations:PendingOperations){
        self.homeUseCase = homeUseCase
        self.pendingOperations = pendingOperations        
    }
    
    func getPhoto(at indexPath:IndexPath) -> PhotoVM? {
        guard indexPath.row < self.photos.count else {return nil}
        return photos[indexPath.row]
    }
    
    func likePhoto(id:String, onCompletion:@escaping(String?)->Void){
        self.homeUseCase.likePhoto(id: id){ response in
            onCompletion(response)
        }
    }
    
    func loadFeed(isSearching:Bool = false){
        
        guard isSearching == false else {
            self.searchPhoto()
            return
        }
        
        //Check for isFetchInProgress
        guard self.isFetchInProgress == false else {return}
        //set the lock on future threads
        self.isFetchInProgress = true
        
        //proceed to load feed
        self.homeUseCase.loadFeed(page:self.currentPage) { newPagePhotos, error in
            defer{self.isFetchInProgress = false}
            
            //handle error
            guard error == nil else {
                self.delegate?.loadFeedDidFail(message: error!)
                return
            }
            //handle success
            self.currentPage += 1
            
            guard let newPhotos = newPagePhotos else {return}
            self.photos.append(contentsOf:newPhotos)
            
            
            DispatchQueue.main.async {
                if self.currentPage > 1 {
                    let indexPathToReload = self.calculateIndexPathsToReload(from: newPhotos)
                    self.delegate?.didLoadFeed(with: indexPathToReload)
                } else {
                    self.delegate?.didLoadFeed(with: nil)
                }
            }
        }
    }
    
    func startSearchingPhoto(query:String){
        guard query.isEmpty == false else {return}
        self.searchQuery = query
        if self.photos.isEmpty == false {
            self.photos.removeAll()
            self.currentPage = 1
        }
        
        self.searchPhoto()
    }
    
    func searchPhoto(){
        
        //Check for isFetchInProgress
        guard self.isFetchInProgress == false else {return}
        //set the lock on future threads
        self.isFetchInProgress = true
        
        //proceed to load feed
        self.homeUseCase.searchPhoto(query: self.searchQuery, page: self.currentPage) { (resultPhotos, error) in
            defer{self.isFetchInProgress = false}
            //handle error
            guard error == nil else {
                self.delegate?.loadFeedDidFail(message: error!)
                return
            }
            
            //handle success
            self.currentPage += 1
            
            guard let newPhotos = resultPhotos else {return}
            self.photos.append(contentsOf:newPhotos)
            
            DispatchQueue.main.async {
                if self.currentPage > 2 {
                    let indexPathToReload = self.calculateIndexPathsToReload(from: newPhotos)
                    self.delegate?.didLoadFeed(with: indexPathToReload)
                } else {
                    self.delegate?.didLoadFeed(with: nil)
                }
            }
        }
    }
    
    func cancelFeedLoad(for indexPaths:[IndexPath]){
        self.pendingOperations.cancelOperations(for: indexPaths)
    }
    
    func downloadImageWithURLSession(at indexPath:IndexPath, with url:URL){
        URLSession.shared.dataTask(with: url){ [weak self] data, response, error in
            guard let self = self,
                let data = data,
                let image = UIImage(data:data) else {return}
            self.photos[indexPath.row].thumbImg = image
            DispatchQueue.main.async {
                self.delegate?.didLoadImage(for: indexPath)
            }
            
        }.resume()
    }
    
    func downloadWithGlobalQueue(at indexPath:IndexPath, with url:URL){
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self,
            let data = try? Data(contentsOf: url),
            let image = UIImage(data:data) else {return}
            self.photos[indexPath.row].thumbImg = image
            
            DispatchQueue.main.async {
                self.delegate?.didLoadImage(for: indexPath)
            }
        }
    }
    
    
}
//MARK: UI UTILITIES RELATED
extension HomePresenter {
    private func calculateIndexPathsToReload(from newPhotos: [PhotoVM]) -> [IndexPath] {
        let startIndex = self.photos.count - newPhotos.count
      let endIndex = startIndex + newPhotos.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
//MARK: OPERATIONS RELATED
extension HomePresenter{
    func startOperation(at indexPath:IndexPath) {
        if let photo = self.getPhoto(at: indexPath){
            //Check if image is downloaded
            switch photo.state {
            case .new:
                startDownload(photo: photo, at: indexPath)
            case .downloaded:
                break
            case .failed:
                break
            }
            //Check if profile image is downloaded
            if photo.user.state == .new {
                startProfileImageDownload(photo: photo.user, at: indexPath)
            }
        }
        
        
    }
    
    fileprivate func startDownload(photo:URLImageProvider, at indexPath:IndexPath){
        //Check if the operation already exist
        guard self.pendingOperations.downloadsInProgress[indexPath] == nil else {return}
        //Create download operations and configure completion block
        let downloadOp = ImageDownloadOperation(photo)
        downloadOp.completionBlock = { [weak self] in
            //get photoVM object from operation and set it to our array
            if let op = self?.pendingOperations.getOperation(at:indexPath) as? ImageDownloadOperation,
                let photo = op.imageURLProvider as? PhotoVM {
                self?.photos[indexPath.row] = photo
            }
            //remove operation from register
            self?.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
            
            //Broadcast to UI that operation has finished
            DispatchQueue.main.async {
                self?.delegate?.didLoadImage(for: indexPath)
            }
        }
        //add operations to register
        self.pendingOperations.downloadsInProgress[indexPath] = downloadOp
        //start operation
        self.pendingOperations.downloadQueue.addOperation(downloadOp)
    }
    
    fileprivate func startProfileImageDownload(photo:URLImageProvider,at indexPath: IndexPath){
        //Check if the operation already exist
        guard self.pendingOperations.profileImageDownloadsInProgress[indexPath] == nil else {return}
        //Create download operations and configure completion block
        let downloadOp = ImageDownloadOperation(photo)
        downloadOp.completionBlock = { [weak self] in
            //get photoVM object from operation and set it to our array
            if let op = self?.pendingOperations.profileImageDownloadsInProgress[indexPath] as? ImageDownloadOperation,
                let profile = op.imageURLProvider as? UserVM {
                self?.photos[indexPath.row].user = profile
            }
            //remove operation from register
            self?.pendingOperations.profileImageDownloadsInProgress.removeValue(forKey: indexPath)
            
            //Broadcast to UI that operation has finished
            DispatchQueue.main.async {
                self?.delegate?.didLoadFeed(with: [indexPath])
            }
        }
        //add operations to register
        self.pendingOperations.profileImageDownloadsInProgress[indexPath] = downloadOp
        //start operation
        self.pendingOperations.downloadQueue.addOperation(downloadOp)
    }
}

//Ouput

protocol HomePresenterDelegate: AnyObject {
    func didReceivePhotos(photos:[PhotoVM])
    func didLoadFeed(with newIndexPathsToReload:[IndexPath]?)
    func loadFeedDidFail(message:String)
    
    func didLoadImage(for indexPath:IndexPath)
}
