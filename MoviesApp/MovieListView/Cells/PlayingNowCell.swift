//
//  PlayingNowCell.swift
//  MoviesApp
//
//  Created by Damodar Namala on 06/05/22.
//

import Foundation
import SwiftUI
import Kingfisher

struct PlayingNowCell: View {
    var viewModel: PlayingNowViewModel
    init(model: PlayingNowViewModel) {
        self.viewModel = model
    }
    var body: some View {
        KFImage(viewModel.url)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(2)
    }
}

struct PlayingNowViewModel {
    var movie: Movie
    var url: URL {
        URL(string: photo_URL + movie.poster_path )!
    }
}
