/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and souºrce code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

final class NetworkImageOperation: AsyncOperation {
  var image: UIImage?
  private var task: URLSessionDataTask?

  private let url: URL
  private let completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

  init(url: URL, completionHandler: ((Data?, URLResponse?, Error?) -> Void)? = nil) {
    self.url = url
    self.completionHandler = completionHandler

    super.init()
  }

  convenience init?(string: String, completionHandler: ((Data?, URLResponse?, Error?) -> Void)? = nil) {
    guard let url = URL(string: string) else { return nil }
    self.init(url: url, completionHandler: completionHandler)
  }

  override func main() {
    self.task = URLSession.shared.dataTask(with: url) { [weak self]
      data, response, error in

      guard let self = self else { return }

      defer { self.state = .finished }
      //Check if the operation hasn't been cancel while performing the network call
      guard self.isCancelled == false else {
        //you already download the image
        //you may store it to avoid any waste bandwidth and user's data
        print(">>>>>>NetworkImageOperation Cancelled: Do something here")
        return
      }
      if let completionHandler = self.completionHandler {
        completionHandler(data, response, error)
        return
      }

      guard error == nil, let data = data else { return }

      self.image = UIImage(data: data)
    }
    self.task?.resume()
  }
  
  override func cancel() {
    super.cancel()
    self.task?.cancel()
  }
}

extension NetworkImageOperation: ImageDataProvider {
  
}
