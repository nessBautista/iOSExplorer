//
//  TestView.swift
//  OClock
//
//  Created by Nestor Hernandez on 29/07/22.
//

import UIKit

class TestView: NibblesView{
	let lineWidth: CGFloat = 2
	let side: CGFloat = 300
	var counter: Int = 0
	var coeff:CGFloat = 1 
	
	var angle: CGFloat = CGFloat.pi / 2 {
		didSet{
			print(angle)
			counter += 1
			print(counter)
			if angle <= (-CGFloat.pi / 2) * 60 {
				angle = CGFloat.pi / 2
				counter = 0
			}
			self.setNeedsDisplay()
		}
	}
	override init(frame: CGRect = .zero) {
		super.init(frame: frame)
	}
	
	override func draw(_ rect: CGRect) {
		// Background
		UIColor.orange.setFill()
		UIRectFill(rect)
		
		// Circle
		let center = CGPoint(x: rect.midX, y: rect.midY)
		let path = UIBezierPath(ovalIn: CGRect(x: center.x - (side/2),
											   y: center.y - (side/2),
											   width: side*coeff,
											   height: side*coeff))
		path.lineWidth = self.lineWidth
		UIColor.blue.setFill()
		path.fill()
		UIColor.black.setStroke()
		path.stroke()
		
		UIColor.green.setStroke()
		let line = UIBezierPath()
		line.move(to: CGPoint(x: rect.midX, y: rect.midY))
		let endPoint = getEndOfLineCoordinates(length: 150,
											   center: center ,
											   angle: self.angle)
		line.addLine(to: endPoint)
		line.close()
		line.lineWidth = 10
		line.stroke()
	}
	
	func getEndOfLineCoordinates(length: CGFloat,
								 center: CGPoint,
								 angle: CGFloat)-> CGPoint {
		let x = center.x + length * cos(angle)
		let y = center.y - length * sin(angle)
		return CGPoint(x: x, y: y)
	}
}
