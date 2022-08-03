//
//  GettingUsersLocationRootView.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
import UIKit

class GettingUsersLocationRootView: NiblessView{
	let viewModel: GettingUsersLocationViewModel
	
	let appLogoImageView: UIImageView = {
	  let imageView = UIImageView(image: UIImage(named: "roo_logo"))
	  imageView.backgroundColor = AppColor.background
	  return imageView
	}()
	
	let gettingLocationLabel: UILabel = {
		let locationLabel = UILabel()
		locationLabel.font = .boldSystemFont(ofSize: 24)
		locationLabel.text = "Finding your Location..."
		locationLabel.textColor = .white
		
		return locationLabel
	}()
	
	init(frame: CGRect = .zero,
		 viewModel: GettingUsersLocationViewModel){
		self.viewModel = viewModel
		super.init(frame: frame)
		self.viewModel.getCurrentLocation()
	}
	
	
	override func didMoveToWindow() {
		super.didMoveToWindow()
		self.backgroundColor = AppColor.background
		self.buildHierarchy()
		self.activateConstraints()
	}
	
	private func buildHierarchy(){
		addSubview(appLogoImageView)
		addSubview(gettingLocationLabel)
	}
	
	private func activateConstraints(){
		self.activateConstraintsAppLogo()
		self.activateConstraintsLocationLabel()
	}
	
	private func activateConstraintsAppLogo() {
		self.appLogoImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			self.appLogoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			self.appLogoImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}
	
	private func activateConstraintsLocationLabel() {
		self.gettingLocationLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			self.gettingLocationLabel.topAnchor.constraint(equalTo: self.appLogoImageView.bottomAnchor, constant: 30),
			self.gettingLocationLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
			
		])
	}
}
