//
//  MoviesListView.swift
//  MoviesApp
//
//  Created by Damodar Namala on 06/05/22.
//

import Foundation
import SwiftUI

struct MovieList {
    static func build() -> MoviesListView {
        MoviesListView(viewModel: MoviesListViewModel())
    }
}

struct MoviesListView: View {
    @ObservedObject var viewModel: MoviesListViewModel
    @State var showDetailPage = false
    
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: .constant(viewModel.isLoading)) {
                loadView()
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(.primary)
        .onReceive(viewModel.$popularMoviesList) { list in
            print(list)
        }
        .onAppear {
            viewModel.fetchPlayingNowMovieList()
            viewModel.fetchPopularMovieList()
        }
    }
    
    @ViewBuilder
    func loadView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            if viewModel.playingNowMoviesState == .finished {
                Section("Currently Playing movies") {
                    playingNowList()
                }
            }
            if viewModel.popularMoviesState == .finished {
                movieList()
            }
        }
    }
    
    @ViewBuilder
    func movieList() -> some View {
        Section("Popular movies ") {
            List(viewModel.popularMoviesList) { movie in
                NavigationLink(destination: MovieDetailPage.build(with: movie),
                               isActive: $showDetailPage) {
                    MovieCell(model: MovieCellViewModel(movie: movie))
                        .onTapGesture {
                            showDetailPage = true
                        }
                }    .listRowBackground(Color.clear)
            }
        }
    }
    
    func playingNowList() -> some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(viewModel.playingNowMoviesList) { movie in
                    NavigationLink(destination: MovieDetailPage.build(with: movie),
                                   isActive: $showDetailPage) {
                        PlayingNowCell(model: PlayingNowViewModel(movie: movie))
                            .onTapGesture {
                                showDetailPage = true
                            }
                    }
                }
            }
        }
        .frame(height: 140, alignment: .leading)
    }
    
    func errorPage(_ message: String) -> some View {
        // ToastMessageView(state: .error(message))
        Text("")
    }
    
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(viewModel: .init())
    }
}
