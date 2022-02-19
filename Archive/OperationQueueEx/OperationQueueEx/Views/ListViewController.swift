import UIKit
import CoreImage

let dataSourceURL = URL(string:"http://www.raywenderlich.com/downloads/ClassicPhotosDictionary.plist")!

class ListViewController: UITableViewController {
    //lazy var photos = NSDictionary(contentsOf: dataSourceURL)!
    lazy var photos:[PhotoRecord] = []
    let pendingOperations = PendingOperations()
        
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Classic Photos"
    self.tableView.register(ImageCell.self, forCellReuseIdentifier: "CellIdentifier")
    self.fetchPhotoDetails()
  }
    
    func fetchPhotoDetails() {
        let request = URLRequest(url: dataSourceURL)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let task = URLSession(configuration: .default).dataTask(with: request) { (data, response, error) in
            defer {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                
            }
            
            let alert = UIAlertController(title: "Oops!", message: "There was an error fetching", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(action)
            
            
            if let data = data {
                do{
                    let datasourceDictionary = try PropertyListSerialization.propertyList(from: data,
                    options: [], format: nil) as! [String:String]
                    for (name, value) in datasourceDictionary {
                        if let url = URL(string: value) {
                            let photo = PhotoRecord(name: name, url: url)
                            self.photos.append(photo)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            
            if error != nil  {
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
        task.resume()
    }
  
  // MARK: - Table view data source

  override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
    return photos.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
    if cell.accessoryView == nil {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        cell.accessoryView = indicator
    }
    let indicator = cell.accessoryView as! UIActivityIndicatorView
    let photo = photos[indexPath.row]
    cell.imageView?.image = photo.image
    print("name:\(photo.name) status:\(photo.state)")
    cell.textLabel?.text = photo.name
   
    switch photo.state {
    case .new, .downloaded:
        indicator.startAnimating()
        self.startOperations(for: photos[indexPath.row], at: indexPath)
    case .filtered:
        indicator.stopAnimating()
    case .failed:
        cell.textLabel?.text = "Operation failed"
        indicator.stopAnimating()
    
    }
    return cell
  }
  
  // MARK: - image processing

  func applySepiaFilter(_ image:UIImage) -> UIImage? {
    let inputImage = CIImage(data:image.pngData()!)
    let context = CIContext(options:nil)
    let filter = CIFilter(name:"CISepiaTone")
    filter?.setValue(inputImage, forKey: kCIInputImageKey)
    filter!.setValue(0.8, forKey: "inputIntensity")

    guard let outputImage = filter!.outputImage,
      let outImage = context.createCGImage(outputImage, from: outputImage.extent) else {
        return nil
    }
    return UIImage(cgImage: outImage)
  }
    
    func startOperations(for photo:PhotoRecord, at indexPath:IndexPath){
        switch photo.state {
        case .new:
            startDownload(for: photo, at: indexPath)
        case .downloaded:
            startFiltration(for: photo, at: indexPath)
        default:
            NSLog("do nothing")
        }
    }
    
    fileprivate func startDownload(for photoRecord: PhotoRecord, at indexPath:IndexPath){
        //Check if there is already an operation on it
        guard pendingOperations.downloadsInProgress[indexPath] == nil else {
            return
        }
        //if not, create an ImageDownloader
        let downloader = ImageDownloader(photoRecord)
        //This completion block will be called even if the operation is cancelled.
        //Check if its cancelled before doing anything
        //You don't haver any guarantee to know which thread your operation ended up.
        //You will need to use GCD to continue your workflow
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            ///-------
            let photoRecord = (self.pendingOperations.downloadsInProgress[indexPath] as? ImageDownloader)?.photoRecord
            self.photos[indexPath.row] = photoRecord!
            ///-------
            //first remove your operation from your register
            self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }
        //Add the operation to the downloadsInProgress to keep track of it
        pendingOperations.downloadsInProgress[indexPath] = downloader
        //Add the operation to the OperationQueue.
        //This is how you actually get these operations to start running
        //The OperationQueue takes care of the scheduling for you
        pendingOperations.downloadQueue.addOperation(downloader)
    }
    
    fileprivate func startFiltration(for photoRecord: PhotoRecord, at indexPath: IndexPath) {
      guard pendingOperations.filtrationsInProgress[indexPath] == nil else {
          return
      }
          
      let filterer = ImageFiltration(photoRecord)
      filterer.completionBlock = {
        if filterer.isCancelled {
          return
        }
        
        DispatchQueue.main.async {
            ///-------
            let photoRecord = (self.pendingOperations.filtrationsInProgress[indexPath] as? ImageFiltration)?.photoRecord
            self.photos[indexPath.row] = photoRecord!
            ///-------
          self.pendingOperations.filtrationsInProgress.removeValue(forKey: indexPath)
          self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
      }
      pendingOperations.filtrationsInProgress[indexPath] = filterer
      pendingOperations.filtrationQueue.addOperation(filterer)
    }
}
