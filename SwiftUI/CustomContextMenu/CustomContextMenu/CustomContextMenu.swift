//
//  CustomContextMenu.swift
//  CustomContextMenu
//
//  Created by Nestor Hernandez on 28/07/22.
//

import SwiftUI

struct CustomContextMenu<Content: View, Preview: View>: View {
	
	var content: Content
	var preview: Preview
	// List of Actions
	var menu: UIMenu
	var onEnd:()->()
	
	init(@ViewBuilder content:@escaping()->Content,
		 @ViewBuilder preview:@escaping()->Preview,
		 actions: @escaping ()->UIMenu,
		 onEnd:@escaping ()->()){
		self.content = content()
		self.preview = preview()
		self.menu = actions()
		self.onEnd = onEnd
	}
    var body: some View {
		ZStack {
			content
				.hidden()
				.overlay(
					ContextMenuHelper(content: content,
									  preview: preview,
									  actions: menu,
									  onEnd: onEnd)
				)
		}
    }
}

struct CustomContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct ContextMenuHelper<Content: View, Preview: View>:UIViewRepresentable {
	var content: Content
	var preview: Preview
	var actions: UIMenu
	var onEnd:()->()
	
	init(content: Content,
		 preview: Preview,
		 actions: UIMenu,
		 onEnd:@escaping ()->()){
		self.content = content
		self.preview = preview
		self.actions = actions
		self.onEnd = onEnd
	}
	
	func makeCoordinator() -> Coordinator {
		return Coordinator(parent: self)
	}
	
	func makeUIView(context: Context) -> UIView {
		// View showing our preview
		let view = UIView(frame: .zero)
		view.backgroundColor = .clear
		let hostView = UIHostingController(rootView: content)
		hostView.view.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(hostView.view)
		
		NSLayoutConstraint.activate([
			hostView.view.topAnchor.constraint(equalTo: view.topAnchor),
			hostView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			hostView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			hostView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			hostView.view.widthAnchor.constraint(equalTo: view.widthAnchor),
			hostView.view.heightAnchor.constraint(equalTo: view.heightAnchor)
		])
		// Interaction showing our Preview
		let interaction = UIContextMenuInteraction(delegate: context.coordinator)
		view.addInteraction(interaction)
		return view
	}
	
	func updateUIView(_ uiView: UIView, context: Context) {
		
	}
	
	// Coordinator: handling Menu Interactions
	class Coordinator: NSObject, UIContextMenuInteractionDelegate {
		var parent: ContextMenuHelper
		
		init(parent: ContextMenuHelper){
			self.parent = parent
		}
		
		// Delegate Methods
		func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
									configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
			
			return UIContextMenuConfiguration(identifier: nil) {
				//The Content
				let previewController = UIHostingController(rootView: self.parent.preview)
				previewController.view.backgroundColor = .purple
				return previewController
				
			} actionProvider: { items in
				return self.parent.actions
			}
		}
		
		// if you need context menu to be expanded...
		func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
									willPerformPreviewActionForMenuWith
									configuration: UIContextMenuConfiguration,
									animator: UIContextMenuInteractionCommitAnimating) {
			
		}
		
		func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willEndFor configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
			self.parent.onEnd()
		}
	}
}
