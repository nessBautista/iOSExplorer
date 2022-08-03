//
//  LazyLayoutView.swift
//  Layouts
//
//  Created by Nestor Hernandez on 09/07/22.
//

import SwiftUI

struct LazyLayoutView: View {
	var coordinator: AppNavigation?
	
	let formatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeStyle = .medium
		return formatter
	}()
	
	@State var selectedGenre = Genre.list.first
	
    var body: some View {
		NavigationView {
			ScrollView{
				ScrollViewReader { proxy in
					LazyVStack {
						ForEach(Genre.list){ genre in
							genre.subgenres.randomElement()!.view
								.id(genre)
						}
						.onChange(of: selectedGenre) { genre in
							self.selectedGenre = nil
							withAnimation {
								proxy.scrollTo(genre, anchor: .top)
							}
						}
					}
				}
			}
			.navigationBarTitleDisplayMode(.inline)
			.navigationTitle("Genres")
			.toolbar {
				ToolbarItem(placement:.navigationBarLeading) {
					Button("Go Home1") {
						self.coordinator?.navigateTo(.home)
					}
				}
				ToolbarItem {
					Menu("Genres"){
						ForEach(Genre.list){ genre in
							Button(genre.name){
								self.selectedGenre = genre
							}
						}
					}
				}
				
			}
		}

    }
}


struct LazyLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        LazyLayoutView()
    }
}
