//
//  MoviesAppTests.swift
//  MoviesAppTests
//
//  Created by Damodar Namala on 06/05/22.
//

@testable import MoviesApp
import Quick
import Nimble
import Combine

class MoviesListViewModelSpec: QuickSpec {
    override func spec() {
        describe("Testing ViewModel") {
            context("When MoviesListViewModel Created") {
                let moviesListViewModel = MoviesListViewModel(moviesListUseCase: MoviesListUseCaseMock())
                it("It should have isLoading == false") {
                    expect(moviesListViewModel.isLoading).to(equal(false))
                }
                it("It should have popularMoviesState should be .none") {
                    expect(moviesListViewModel.popularMoviesState).to(equal(RequestState.none))
                }
                it("It should have playingNowMoviesState should be .none") {
                    expect(moviesListViewModel.playingNowMoviesState).to(equal(RequestState.none))
                }
                it("It should have movies shoud be empty") {
                    expect(moviesListViewModel.popularMoviesList.count).to(equal(0))
                }
                it("It should have movies shoud be empty") {
                    expect(moviesListViewModel.playingNowMoviesList.count).to(equal(0))
                }
            }
            
            context("When MoviesListViewModel Loading movies") {
                let moviesListViewModel = MoviesListViewModel(moviesListUseCase: MoviesListUseCaseMock())
                beforeEach {
                    moviesListViewModel.fetchPopularMovieList()
                }
                it("It should have popularMoviesState should be .loading") {
                    expect(moviesListViewModel.popularMoviesState).to(equal(RequestState.loading))
                }
                it("It should have movies shoud not be empty") {
                    expect(moviesListViewModel.popularMoviesList.count).to(equal(0))
                }
            }
            
            context("When popularMoviesState Loading playin now movies") {
                let moviesListViewModel = MoviesListViewModel(moviesListUseCase: MoviesListUseCaseMock())
                beforeEach {
                    moviesListViewModel.fetchPlayingNowMovieList()
                }
                it("It should have popularMoviesState should be .loading") {
                    expect(moviesListViewModel.playingNowMoviesState).to(equal(RequestState.loading))
                }
                it("It should have movies shoud not be empty") {
                    expect(moviesListViewModel.playingNowMoviesList.count).to(equal(0))
                }
            }
            
            context("When fetching PlayingNowMovieList called") {
                var moviesListViewModel: MoviesListViewModel?
                var bag = Set<AnyCancellable>()
                beforeEach {
                    moviesListViewModel = MoviesListViewModel(moviesListUseCase: MoviesListUseCaseMock())
                    moviesListViewModel?.fetchPlayingNowMovieList()
                }
                
                moviesListViewModel?.$playingNowMoviesList.sink(receiveCompletion: { _ in },
                                                                receiveValue: { movies in
                    it("playingNowMoviesState should be .finished ") {
                        expect(moviesListViewModel?.playingNowMoviesState).to(equal(RequestState.finished))
                    }
                    it("movies.count should not be zero") {
                        expect(moviesListViewModel?.playingNowMoviesList.count).toNot(equal(0))
                    }
                }).store(in: &bag)
            }
            
            context("When fetching fetchPopularMovieList called") {
                var moviesListViewModel: MoviesListViewModel?
                var bag = Set<AnyCancellable>()
                beforeEach {
                    moviesListViewModel = MoviesListViewModel(moviesListUseCase: MoviesListUseCaseMock())
                    moviesListViewModel?.fetchPopularMovieList()
                }
                
                moviesListViewModel?.$popularMoviesList.sink(receiveCompletion: { values in
                    
                }, receiveValue: { movies in
                    it("playingNowMoviesState should be .finished ") {
                        expect(moviesListViewModel?.popularMoviesState).to(equal(RequestState.finished))
                    }
                    it("movies.count should not be zero") {
                        expect(moviesListViewModel?.popularMoviesList.count).toNot(equal(0))
                    }
                }).store(in: &bag)
            }
           
        }
    }
}
