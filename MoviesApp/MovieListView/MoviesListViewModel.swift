//
//  MoviesListViewModel.swift
//  MoviesApp
//
//  Created by Damodar Namala on 06/05/22.
//

import Foundation
import Combine

final class MoviesListViewModel: ObservableObject {
    private (set) var moviesListUsecase: MovieListBaseUseCase
    @Published var popularMoviesState: RequestState = .none
    @Published var playingNowMoviesState: RequestState = .none
    private var bag = Set<AnyCancellable>()
    @Published var popularMoviesList: [Movie] = []
    @Published var playingNowMoviesList: [Movie] = []
    
    var isLoading: Bool {
       return playingNowMoviesState == .loading && popularMoviesState == .loading
    }
    
    init(moviesListUseCase: MovieListBaseUseCase = MoviesListUseCase() ) {
        self.moviesListUsecase = moviesListUseCase
    }
    
    func fetchPopularMovieList() {
        self.popularMoviesState = .loading
        self.moviesListUsecase
            .fetchAllMovies(of: 1)
            .receive(on: DispatchQueue.main)
            .sink { completion in
            } receiveValue: { reponse in
                self.popularMoviesList = reponse.results
                self.popularMoviesState = .finished
            }.store(in: &bag)
    }
    
    func fetchPlayingNowMovieList() {
        self.playingNowMoviesState = .loading
        self.moviesListUsecase
            .fetchPlayingNowMovies()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
            } receiveValue: { reponse in
                self.playingNowMoviesList = reponse.results
                self.playingNowMoviesState = .finished
            }.store(in: &bag)
    }
}

enum RequestState: Equatable {
    case none
    case loading
    case finished
    case error(String?)
}
