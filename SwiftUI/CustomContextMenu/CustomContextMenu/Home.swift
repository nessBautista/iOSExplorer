//
//  Home.swift
//  CustomContextMenu
//
//  Created by Nestor Hernandez on 28/07/22. 1
//

import SwiftUI

struct Home: View {
	@State var onEnded = false
    var body: some View {
		NavigationView {
			ZStack {
				CustomContextMenu{
					// Content
					Label {
						Text("Unlock Me")
					} icon: {
						Image(systemName: "lock.fill")
					}
					.font(.title2)
					.foregroundColor(.white)
					.padding(.vertical, 12)
					.padding(.horizontal, 20)
					.background(.purple)
					.cornerRadius(8)
				} preview: {
					Image("mountains")
						.resizable()
						.aspectRatio(contentMode: .fill)
				} actions: {
					let like = UIAction(title: "Like",
										image: UIImage(systemName: "suit.heart.fill")){ _ in
						print("Like")
					}
					let share = UIAction(title: "share",
										image: UIImage(systemName: "square.and.arrow.up.fill")){ _ in
						print("share")
					}
					return UIMenu(title: "", children:[like, share])
				} onEnd: {
					print("Ended")
					withAnimation {
						onEnded.toggle()
					}
				}
				if onEnded {
					GeometryReader{proxy in
						let size = proxy.size
						
						Image("mountains")
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: size.width, height: size.height)
							.cornerRadius(1 )
					}
					.ignoresSafeArea(.all, edges: .bottom)
					// removing opacity animation
					.transition(.identity)
					.toolbar {
						ToolbarItem(placement: .navigationBarTrailing){
							Button("Close"){
								withAnimation {
									onEnded.toggle()
								}
							}
						}
					}
				}
			}
			.navigationTitle(onEnded ? "Unlocked":"Custom Context Menu")
			.navigationBarTitleDisplayMode(onEnded ? .inline : .large)
		}
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
