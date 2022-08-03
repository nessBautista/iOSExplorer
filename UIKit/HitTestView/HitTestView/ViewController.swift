//
//  ViewController.swift
//  HitTestView
//
//  Created by Nestor Hernandez on 15/07/22.
//

import Foundation
import UIKit
class ViewController: UIViewController {
	weak var contentView: MyView!
	weak var view1: MyView!
	weak var view2: MyView!
	weak var view3: MyView!
	weak var view4: MyView!
	weak var view5: MyView!
	
	let side: CGFloat = 150
	let bounds = UIScreen.main.bounds
	 
	override func loadView() {
		super.loadView()
		self.placeViews()
	}
	
	func placeViews(){
		// Content View
		let contentView = MyView(frame: .zero)
		contentView.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(contentView)
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		contentView.backgroundColor = .purple
		self.contentView = contentView
		
		// view 1
		let view1 = MyView(frame: CGRect(origin: CGPoint(x: 1, y: 0),
										 size: CGSize(width: side, height: side)))
		self.contentView.addSubview(view1)
		view1.backgroundColor = .green
		view1.tag = 1
		self.view1 = view1
		
		let view2 = MyView(frame: CGRect(origin: CGPoint(x: side + 1, y: 0),
										 size: CGSize(width: side, height: side)))
		self.contentView.addSubview(view2)
		view2.backgroundColor = .orange
		view2.tag = 2
		self.view2 = view2
		
		let view3 = MyView(frame: CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 50, height: 50)))
		view3.tag = 3
		view3.backgroundColor = .red
		self.view3 = view3
		self.view2.addSubview(view3)
		
		let view4 = MyView(frame: CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 25, height: 25)))
		view4.tag = 4
		view4.backgroundColor = .yellow
		self.view4 = view4
		self.view2.addSubview(view4)
		
		
		let view5 = MyView(frame: CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 50, height: 50)))
		view5.tag = 5
		view5.backgroundColor = .black
		self.view5 = view5
		self.view1.addSubview(view5)
		
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
	}
}

