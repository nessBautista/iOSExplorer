//
//  MyView.swift
//  HitTestView
//
//  Created by Nestor Hernandez on 15/07/22.
//

import UIKit

class MyView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}
	
	//@available(*, unavailable, message: "Not implemented")
	required init?(coder: NSCoder) {
		fatalError("Nope")
	}

	func configure(){
		isUserInteractionEnabled = true
	}
	
	private var _parentView: UIView!
	
	var parentView: UIView {
		set{
			_parentView = newValue
		}
		get {
			return _parentView
		}
	}
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		// base case
		if !self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01{
			print("View invisible")
			return nil
		}
		
		// if point is inside, proceed to perform reverse DFS
		if self.point(inside: point, with: event){
			// reversed returns the last recently added view
			for view in self.subviews.reversed() {
				let convertedPoint = view.convert(point, from: self)
				if let innerView = view.hitTest(convertedPoint, with: event){
					print("selected Tag: \(innerView.tag)")
					return innerView
				}
			}
			
			// This is the last view added and there are no subviews on top
			print("selected Tag: \(self.tag)")
			return self
		}
		return nil
	}
	
	override func point(inside point: CGPoint,
						with event: UIEvent?) -> Bool {
		
		//print("tag:\(self.tag), \(point)")
		
		return super.point(inside: point, with: event)
	}
}
