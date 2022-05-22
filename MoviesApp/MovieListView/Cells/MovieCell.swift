//
//  MovieCell.swift
//  MoviesApp
//
//  Created by Damodar Namala on 06/05/22.
//

import Foundation
import SwiftUI
import Kingfisher

struct MovieCell: View {
    var viewModel: MovieCellViewModel
    init(model: MovieCellViewModel) {
        self.viewModel = model
    }
    var body: some View {
        HStack {
            KFImage(viewModel.url)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(2)
            
            VStack(alignment: .leading,spacing: 8) {
                Text(viewModel.title)
                    .font(.headline)
                Text(viewModel.releaseData)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, idealHeight: 100, alignment: .leading)
    }
}

struct MovieCellViewModel {

    var movie: Movie
    var title: String { movie.title }
    var url: URL {
        URL(string: photo_URL + movie.poster_path )!
    }
    var releaseData: String { movie.release_date ?? "" }
}

