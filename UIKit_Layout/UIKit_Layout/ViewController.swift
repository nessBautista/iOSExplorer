//
//  ViewController.swift
//  UIKit_Layout
//
//  Created by Nestor Hernandez on 07/01/21.
//

import UIKit

class ViewController: UIViewController {
    let kRedViewSize = 50  //RedView will be the reference for all the template
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let redView = UIView()
        redView.backgroundColor = .red
        let blueView = UIView()
        blueView.backgroundColor = .blue
        let greenView = UIView()
        greenView.backgroundColor = .green
        
        [redView, blueView, greenView].forEach({view.addSubview($0)})
        
        
        
        redView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                       leading: nil,
                       trailing: view.safeAreaLayoutGuide.trailingAnchor,
                       bottom: nil,
                       padding: .init(top: 0, left: 0, bottom: 0, right: 12),
                       size: .init(width: kRedViewSize, height: 0))
        redView.heightAnchor.constraint(equalTo: redView.widthAnchor).isActive = true
        
        blueView.anchor(top: redView.bottomAnchor,
                        leading: nil,
                        trailing: redView.trailingAnchor,
                        bottom: nil,
                        padding: .init(top: 12, left: 0, bottom: 0, right: 0))
        blueView.widthAnchor.constraint(equalTo: redView.widthAnchor).isActive = true
        blueView.heightAnchor.constraint(equalTo: blueView.widthAnchor).isActive = true
        
        greenView.anchor(top: redView.topAnchor,
                         leading: view.safeAreaLayoutGuide.leadingAnchor,
                         trailing: redView.leadingAnchor,
                         bottom: blueView.bottomAnchor,
                         padding: .init(top: 0, left: 12, bottom: 0, right: 12))
    }
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        //Size
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
}

