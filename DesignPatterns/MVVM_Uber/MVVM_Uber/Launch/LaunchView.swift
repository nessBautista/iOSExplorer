//
//  LaunchView.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
import UIKit

class LaunchView: NiblessView{
	let viewModel: LaunchViewModel
	
	init(frame:CGRect = .zero,
		 viewModel: LaunchViewModel){
		self.viewModel = viewModel
		super.init(frame: frame)
		styleView()
		loadUserSession()
	}
	
	private func styleView() {
		//backgroundColor = UIColor.orange
		let messageLabel = UILabel()
		messageLabel.text = "LaunchView"
		messageLabel.font = UIFont.systemFont(ofSize: 24)
		messageLabel.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(messageLabel)
		NSLayoutConstraint.activate([
			messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			messageLabel.topAnchor.constraint(equalTo: self.topAnchor),
			messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
	
	private func loadUserSession() {
	  viewModel.loadUserSession()
	}
}
