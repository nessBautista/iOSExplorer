//
//  ViewController.swift
//  OClock
//
//  Created by Nestor Hernandez on 29/07/22.
//

import UIKit
import Combine
class ViewController: UIViewController {
	private(set) var subscriptions = Set<AnyCancellable>()
	let viewModel = ViewModel()
	
	// UI
	var testView: TestView!
	let formatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeStyle = .medium
		return formatter
	}()
	
	override func loadView() {
		super.loadView()
		self.testView = TestView(frame: UIScreen.main.bounds)
		view = self.testView
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.timer
			.receive(on: RunLoop.main)
			.map{self.formatter.string(from: $0)}
			.sink { val in
				print(val)
				self.testView.angle -= (2.0 * CGFloat.pi / 60)
			}.store(in: &subscriptions)
	}


}

class ViewModel:ObservableObject {
	@Published var time: String = String()
	let timer = Timer.publish(every: 1.0, on: RunLoop.main, in: .default)
	let cancellable: Cancellable?
	init(){
					
		self.cancellable = timer.connect()
	}
}
