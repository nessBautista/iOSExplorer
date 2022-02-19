//
//  CollectionViewController.swift
//  DispatchQueues_ImageCollectionExample
//
//  Created by Ness Bautista on 06/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit

final class CollectionViewController: UICollectionViewController {
  private let cellSpacing: CGFloat = 1
  private let columns: CGFloat = 3

  private var cellSize: CGFloat?
  private var urls: [URL] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    guard let plist = Bundle.main.url(forResource: "Photos", withExtension: "plist"),
          let contents = try? Data(contentsOf: plist),
          let serial = try? PropertyListSerialization.propertyList(from: contents, format: nil),
          let serialUrls = serial as? [String] else {
      print("Something went horribly wrong!")
      return
    }

    urls = serialUrls.compactMap { URL(string: $0) }
  }

  private func downloadWithGlobalQueue(at indexPath: IndexPath) {
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      guard let self = self else {return}
      
      if let data = try? Data(contentsOf: self.urls[indexPath.item]) {
        let image = UIImage(data: data)
        DispatchQueue.main.async {
          if let cell = self.collectionView.cellForItem(at: indexPath) as? PhotoCell {
            cell.display(image: image)
          }
        }
      }
    }
    // Step 2a: Set up the utility global dispatch queue
    // Step 2b: Capture self (code fragment 1)
    // Step 2c: Move if-closure from cellForItemAt here and fix urls capture error
    // Step 2d: Define cell (code fragment 2)
    // Step 2e: Dispatch UI tasks to main queue
  }

  private func downloadWithUrlSession(at indexPath: IndexPath) {
    URLSession.shared.dataTask(with: urls[indexPath.item]) {[weak self] data,response,error in
      guard let self = self,
      let data = data,
      let image = UIImage(data:data) else {return}
      
      DispatchQueue.main.async {
        if let cell = self.collectionView.cellForItem(at: indexPath) as? PhotoCell {
          cell.display(image: image)
        }
      }
      
    }.resume()
  }
}

// MARK: - Data source
extension CollectionViewController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    urls.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "normal", for: indexPath) as! PhotoCell
    
    
    // Step 3: Keep only the next line; delete the rest of this if-else block
    cell.display(image: nil)
    
    // Step 1: Uncomment the next line
    //downloadWithGlobalQueue(at: indexPath)
    downloadWithUrlSession(at: indexPath)
    
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if cellSize == nil {
      let layout = collectionViewLayout as! UICollectionViewFlowLayout
      let emptySpace = layout.sectionInset.left + layout.sectionInset.right + (columns * cellSpacing - 1)
      cellSize = (view.frame.size.width - emptySpace) / columns
    }

    return CGSize(width: cellSize!, height: cellSize!)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    cellSpacing
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    cellSpacing
  }
}

