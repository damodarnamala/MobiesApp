//
//  MovieDetailUseCase.swift
//  MoviesApp
//
//  Created by Damodar Namala on 09/05/22.
//

import Foundation
import Combine



protocol MovieDetailBaseUseCase {
    func fetchMovieDetails(of id: Int) -> AnyPublisher <MovieDetail, Error>
}

struct MoviesDetailUseCase {
    init() {
        interactor = Interactor()
    }
    private let interactor: Interactor
}

extension MoviesDetailUseCase {
    ///
    /// `Interactor` connects to API and fetch data from API
    ///
    class Interactor {
        func movieDetails(with id: Int) -> AnyPublisher <MovieDetail, Error> {
            let moviesAPI = MoviesListAPI()
            let request = moviesAPI.request(router: .movieDetail(id: id))
            return URLSession.shared.get(request: request)
        }
    }
}


extension MoviesDetailUseCase: MovieDetailBaseUseCase {
    func fetchMovieDetails(of id: Int) -> AnyPublisher <MovieDetail, Error> {
        self.interactor.movieDetails(with: id)
    }
}

struct MoviesDetailUseCaseMock {}

extension MoviesDetailUseCaseMock: MovieDetailBaseUseCase {
    func fetchMovieDetails(of id: Int) -> AnyPublisher <MovieDetail, Error> {
        return Future {promise in
            promise(.success(MovieDetail.mocked))
        }.eraseToAnyPublisher()
    }
}

struct MoviesDetailUseCaseErrorMock {}
extension MoviesDetailUseCaseErrorMock: MovieDetailBaseUseCase {
    
    enum ErrorSome: Error {}
    func fetchMovieDetails(of id: Int) -> AnyPublisher <MovieDetail, Error> {
        return Future {promise in
            promise(.failure(ErrorSome.self as! Error))
        }.eraseToAnyPublisher()
    }
}
