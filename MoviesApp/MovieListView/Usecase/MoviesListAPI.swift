//
//  MoviesListAPI.swift
//  CS_iOS_Assignment
//
//  Created by Damodar Namala on 06/05/22.
//  Copyright © 2022 Backbase. All rights reserved.
//

import Foundation

let photo_URL = "https://image.tmdb.org/t/p/w500/"

struct MoviesListAPI {
    private
    struct Constants {
        static let baseUrl = "https://api.themoviedb.org/3/movie/"
        static let token = "55957fcf3ba81b137f8fc01ac5a31fb5"
    }
    
    enum MoviesRouter {
        case nowPlaying
        case mostPopular(page: Int)
        case movieDetail(id: Int)
    }
    
    func request(router: MoviesRouter) -> URLRequest {
        var request = URLRequest(url: getUrl(of: router))
        request.addDefaultSettings()
        return request
    }
}

extension MoviesListAPI {
    private
    func getUrl(of type: MoviesRouter) -> URL {
        var string = ""
        switch type {
        case .nowPlaying:
            string = "\(Constants.baseUrl)now_playing?language=en-US&page=undefined&api_key=\(Constants.token)"
        case .mostPopular(let page):
            string = "\(Constants.baseUrl)popular?api_key=\(Constants.token)&language=en-US&page=\(page)"
        case .movieDetail(let id):
            string = "\(Constants.baseUrl)\(id)?api_key=\(Constants.token)&language=en-US"
        }
        return URL(string: string)!
    }
}

extension URLRequest {
    mutating func addDefaultSettings() {
        self.cachePolicy = .returnCacheDataElseLoad
        self.httpShouldHandleCookies = false
        self.allowsCellularAccess = true
        self.timeoutInterval = 30
    }
}
