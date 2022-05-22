//
//  MovieDetailViewModel.swift
//  MoviesApp
//
//  Created by Damodar Namala on 09/05/22.
//

import Foundation
import Combine

final class MovieDetailViewModel: ObservableObject {
    let movie: Movie
    private (set) var moviesDetailUseCase: MovieDetailBaseUseCase
    private var bag = Set<AnyCancellable>()
    
    @Published var fetchMovieDetailsState: RequestState = .none
    @Published private(set) var movieDetail: MovieDetail?
    
    var isLoading: Bool {
        self.fetchMovieDetailsState == .loading
    }
    
    var url: URL {
        URL(string: photo_URL + self.movie.poster_path)!
    }
   
    var movieTitle: String {
        self.movie.title
    }
    
    var releaseDate: String {
        self.movie.release_date ?? ""
    }
    
    init(movie: Movie, moviesDetailUseCase: MovieDetailBaseUseCase = MoviesDetailUseCase()) {
        self.movie = movie
        self.moviesDetailUseCase = moviesDetailUseCase
        self.fetchMovieDetails()
    }
    
    func fetchMovieDetails() {
        fetchMovieDetailsState = .loading
        self.moviesDetailUseCase.fetchMovieDetails(of: self.movie.id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    self.fetchMovieDetailsState = .finished
                case .failure(let error):
                    self.fetchMovieDetailsState = .error(error.localizedDescription)
                }
            } receiveValue: { movieDetail in
                self.movieDetail = movieDetail
            }
            .store(in: &bag)
    }
}
