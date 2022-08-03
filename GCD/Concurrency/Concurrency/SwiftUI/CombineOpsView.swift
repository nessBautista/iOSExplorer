//
//  CombineOpsView.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 13/07/22.
//

import SwiftUI

struct CombineOpsView: View {
	@ObservedObject var viewModel: CombineOpsViewModel
    var body: some View {
		ScrollView {
			LazyVStack {
				ForEach(viewModel.data){item in
	//				Text("\(item.imageURL.path)")
					CellView(viewModel: ImageCellViewModel(url: item.imageURL))
				}
			}
		}

		
    }
}

struct CellView: View {
	@ObservedObject var viewModel: ImageCellViewModel
	var body: some View {
		if let image = viewModel.image{
			image
				.resizable()
				.frame(width: 275, height: 275, alignment: .center)
		} else {
			Image(uiImage: UIImage(named:"mountains")!)
				.resizable()
				.frame(width: 275, height: 275, alignment: .center)
		}
			
	}
}
struct CombineOpsView_Previews: PreviewProvider {
    static var previews: some View {
        CombineOpsView(viewModel: CombineOpsViewModel())
    }
}
