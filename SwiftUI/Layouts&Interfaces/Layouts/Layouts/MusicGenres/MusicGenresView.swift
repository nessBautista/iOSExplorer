//
//  MusicGenresView.swift
//  Layouts
//
//  Created by Nestor Hernandez on 10/07/22.
//

import SwiftUI

struct MusicGenresView: View {
	@ObservedObject var viewModel: MusicGenresViewModel
	var coordinator: AppNavigation?
	@State var selectedGenre = Genre.list.first
	
    var body: some View {
		NavigationView {
			ScrollView {
				ScrollViewReader { proxy in
					LazyVStack {
						ForEach(viewModel.genres){ genre in
							VStack(alignment: .leading) {
								Text(genre.name).font(.title)
								ScrollView(.horizontal) {
									LazyHStack {
										ForEach(genre.subgenres) { subgenre in
											subgenre.view
										}
									}
									
								}
							}
							.id(genre)
							.onChange(of: self.selectedGenre) { genre in
								self.selectedGenre = nil
								withAnimation {
									proxy.scrollTo(genre, anchor: .topLeading)
								}
							}
						}
					}
				}
			}
			.navigationTitle("Music Genres")
		}
		.toolbar {
			ToolbarItem(placement:.navigationBarTrailing){
				Menu("Genres"){
					ForEach(viewModel.genres){ genre in
						Button(genre.name){
							self.selectedGenre = genre
						}
					}
				}

			}
		}
    }
}

struct MusicGenresView_Previews: PreviewProvider {
    static var previews: some View {
        MusicGenresView(viewModel: MusicGenresViewModel(), coordinator: nil)
    }
}
