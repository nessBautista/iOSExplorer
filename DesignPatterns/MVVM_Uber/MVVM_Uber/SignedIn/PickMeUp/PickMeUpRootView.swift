//
//  PickMeUpRootView.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 02/08/22.
//

import Foundation
import UIKit
class PickMeUpRootView: NiblessView{
	let viewModel: PickMeUpViewModel
	let whereToButton: UIButton = {
		let button = UIButton()
		button.setTitle("Where to", for: .normal)
		button.backgroundColor = .white
		button.setTitleColor(AppColor.darkTextColor, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 20, weight: .light)
		button.layer.shadowRadius = 10.0
		button.layer.shadowOffset = CGSize(width: 0, height: 2)
		button.layer.shadowColor = UIColor.black.cgColor
		button.layer.shadowOpacity = 0.5
		return button
	}()
	
	init(frame: CGRect = .zero,
		 viewModel: PickMeUpViewModel){
		// Initialize
		self.viewModel = viewModel
		super.init(frame: frame)
		// add button
		addSubview(whereToButton)
		// Bind
		self.setUpBindings()
		//self.backgroundColor = .orange
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		let width = bounds.width
		let margin = CGFloat(50)
		let buttonWidth = width - (margin * 2)
		self.whereToButton.frame = CGRect(x: 50, y: 100, width: buttonWidth, height: 50)
		self.whereToButton.layer.shadowPath = UIBezierPath(rect: whereToButton.bounds).cgPath
	}
	
	override func didAddSubview(_ subview: UIView) {
		super.didAddSubview(subview)
		bringSubviewToFront(whereToButton)
	}
	
	private func setUpBindings(){
		self.whereToButton.addTarget(viewModel,
									 action:#selector(PickMeUpViewModel
														.showSelectDropoffLocationView),
									 for: .touchUpInside)
	}
}
