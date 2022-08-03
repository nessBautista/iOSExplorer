//
//  MainViewModel.swift
//  Collections
//
//  Created by Nestor Hernandez on 08/07/22.
//

import Foundation
import Combine
import UIKit

public enum ScreenType: String, Equatable, CaseIterable {
	case home = "Home"
	case flowLayout = "Basic Flowlayout"
	case emojiCollection = "Emoji Collection"
	
	public static func ==(lhs: ScreenType, rhs: ScreenType)-> Bool {
		switch (lhs, rhs){
		case (.home, .home):
			return true
		case (.flowLayout, .flowLayout):
			return true
		case (.emojiCollection, .emojiCollection):
			return true
		default:
			return false
		}
	}
	
	public static var allCases: [ScreenType] {
		return [.home, .flowLayout, .emojiCollection]
	}
}
class MainViewModel: ObservableObject{
	@Published var screen: ScreenType = .home
}
protocol AppNavigation {
	func goTo(_ screen: ScreenType)
}

extension MainViewModel: AppNavigation {
	func goTo(_ screen: ScreenType){
		self.screen = screen
	}
}
