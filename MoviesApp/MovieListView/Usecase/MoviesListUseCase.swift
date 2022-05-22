//
//  MoviesListUseCase.swift
//  CS_iOS_Assignment
//
//  Created by Damodar Namala on 06/05/22.
//  Copyright © 2022 Backbase. All rights reserved.
//

import Foundation
import Combine

protocol MovieListBaseUseCase {
    func fetchAllMovies(of page: Int) -> AnyPublisher <MoviesResponse, Error>
    func fetchPlayingNowMovies() -> AnyPublisher <MoviesResponse, Error>
}

struct MoviesListUseCase {
    init() {
        interactor = Interactor()
    }
    private let interactor: Interactor
}

extension MoviesListUseCase: MovieListBaseUseCase {
    /// `func playingNow` to fecthing playing movies from API
    /// - Returns:
    ///     - pageNumber  takes and Int and returns `MoviesResponse`
    ///
    func fetchPlayingNowMovies() -> AnyPublisher <MoviesResponse, Error> {
        self.interactor.playingNow().eraseToAnyPublisher()
    }
    
    /// `func popularMovies` to fecthing popular movies from API
    /// - Parameters:
    ///     - pageNumber  takes and Int and returns response
    ///
    
    func fetchAllMovies(of page: Int) -> AnyPublisher <MoviesResponse, Error> {
        self.interactor.popularMovies(with: page).eraseToAnyPublisher()
    }
}

extension MoviesListUseCase {
    ///
    /// `Interactor` connects to API and fetch data from API
    ///
    class Interactor {
        func popularMovies(with pageNumber: Int) -> AnyPublisher <MoviesResponse, Error> {
            let moviesAPI = MoviesListAPI()
            let request = moviesAPI.request(router: .mostPopular(page: pageNumber))
            return URLSession.shared.get(request: request)
                .eraseToAnyPublisher()
        }
        
        func playingNow() -> AnyPublisher <MoviesResponse, Error> {
            let moviesAPI = MoviesListAPI()
            let request = moviesAPI.request(router: .nowPlaying)
            return URLSession.shared.get(request: request)
        }
    }
}

extension MoviesListUseCase {
    struct APIError: Error {
        static var invalidRequest = "Please contact administrator "
    }
}

/// Mocking `MovieListBaseUseCase`
/// sending static data
///
struct MoviesListUseCaseMock: MovieListBaseUseCase {
    func fetchAllMovies(of page: Int) -> AnyPublisher <MoviesResponse, Error> {
        return Future {promise in
            promise(.success(.mocked))
        }.eraseToAnyPublisher()
    }
    
    func fetchPlayingNowMovies( )-> AnyPublisher <MoviesResponse, Error> {
        return Future {promise in
            promise(.success(.mocked))
        }.eraseToAnyPublisher()
    }
}
