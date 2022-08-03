//
//  DemoFlowLayoutViewModel.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 30/06/22.
//

import Foundation
import Combine
class DemoFlowLayoutViewModel: ObservableObject {
	@Published var data:[[Int]] = []
	let root: Node
	
	init(){
		self.root = DemoFlowLayoutViewModel.buildTree()
	}
	
	func treeLevels(){
		var output:[[Int]] = []
		var level: Int = 0
		
		func dfs(_ node: Node?){
			guard node != nil else {return}
			if level > output.count - 1 {
				output.append([])
			}
			
			level += 1
			dfs(node?.left)
			level -= 1
			if level < output.count {
				output[level].append(node!.value)
			}
		
			level += 1
			dfs(node?.right)
			level -= 1
			
		}
		dfs(self.root)
		print(output)
		self.data = output
	}
	
	static func buildTree()->Node {
		let node1 = Node(1)
		let node2 = Node(2)
		let node3 = Node(3)
		let node4 = Node(4)
		let node5 = Node(5)
		let node6 = Node(6)
		let node7 = Node(7)
		node1.left = node2
		node1.right = node3
		node2.left = node4
		node2.right = node5
		node3.left = node6
		node3.right = node7
		
		return node1
	}
	
}

class Node {
	var value: Int
	var left: Node?
	var right: Node?
	init(_ value: Int){
		self.value = value
	}
}



