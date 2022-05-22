//
//  MoviesDetailViewModelSpec.swift
//  MoviesAppTests
//
//  Created by Damodar Namala on 09/05/22.
//

import Foundation
@testable import MoviesApp
import Quick
import Nimble
import Combine

class MovieDetailViewModelSpec: QuickSpec {
    override func spec() {
        describe("Testing MovieDetailViewModel") {
            context("When MovieDetailViewModel Created") {
                let moviesListViewModel = MovieDetailViewModel(movie: Movie.testVar, moviesDetailUseCase: MoviesDetailUseCaseMock())
                it("It should have isLoading == true") {
                    expect(moviesListViewModel.isLoading).to(equal(true))
                }
                
                it("It should have movieDetail nil ") {
                    expect(moviesListViewModel.movieDetail).to(beNil())
                }
                it("It should have movieDetail nil ") {
                    expect(moviesListViewModel.movieTitle).to(equal("Test Movie"))
                }
                
                it("It should have gerne nil ") {
                    expect(moviesListViewModel.movieDetail?.genres).to(beNil())
                }
            }
            
            context(" after movieDetailViewModel details fetched") {
                var moviesListViewModel: MovieDetailViewModel?
                var bag = Set<AnyCancellable>()
                
                beforeEach {
                    moviesListViewModel = MovieDetailViewModel(movie: Movie.testVar, moviesDetailUseCase: MoviesDetailUseCaseMock())
                    moviesListViewModel?.fetchMovieDetails()
                }
                
                moviesListViewModel?.$movieDetail.sink(receiveCompletion: { _ in
                    
                }, receiveValue: { details in
                    it("It should have gerne ") {
                        expect(moviesListViewModel?.movieDetail?.genres).toNot(beNil())
                    }
                })
                    .store(in: &bag)
            }
            
            context(" after movieDetailViewModel details failed") {
                var moviesListViewModel: MovieDetailViewModel?
                var bag = Set<AnyCancellable>()
                
                beforeEach {
                    moviesListViewModel = MovieDetailViewModel(movie: Movie.testVar, moviesDetailUseCase: MoviesDetailUseCaseErrorMock())
                    moviesListViewModel?.fetchMovieDetails()
                }
                
                moviesListViewModel?.$movieDetail.sink(receiveCompletion: { _ in
                    
                }, receiveValue: { details in
                    it("It should have gerne ") {
                        expect(moviesListViewModel?.movieDetail?.genres).to(beNil())
                    }
                    it("It should have state finingshed ") {
                        expect(moviesListViewModel?.fetchMovieDetailsState).to(equal(.finished))
                    }
                })
                    .store(in: &bag)
            }
        }
    }
}
