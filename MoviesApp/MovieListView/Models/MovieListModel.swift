//
//  MovieListModel.swift
//  MoviesApp
//
//  Created by Damodar Namala on 06/05/22.
//

import Foundation
 
struct Movie: Hashable,Codable, Identifiable {
    let title: String
    let vote_average: Double
    let release_date: String?
    let poster_path: String
    let id: Int
}

extension Movie {
    static var testVar: Movie {
        Movie(title: "Test Movie", vote_average: 5, release_date: "20-10-2022", poster_path: "", id: 1)
    }
}


struct MoviesResponse: Codable {
    let page: Int
    let total_pages: Int
    let results: [Movie]
}

struct MovieDetail: Decodable {
    let runtime: Int
    let poster_path: String
    let title: String
    let overview: String
    let release_date: String
    let id: Int
    let genres: [Genre]
}

extension MovieDetail {
    static var mocked: MovieDetail {
        return MovieDetail(runtime: 1, poster_path: "some", title: "Hero", overview: "Static overview", release_date: "20-10-2022", id: 1,
                           genres: [ Genre(id: 1, name: "Static gerne")])
    }
}

struct Genre: Codable{
    let id: Int
    let name: String
}


extension MoviesResponse {
    static var mocked: MoviesResponse {
        MoviesResponse(page: 1,
                       total_pages: 1,
                       results: [
            Movie(title: "RRR", vote_average: 4, release_date: "20-05-2022", poster_path: "/neMZH82Stu91d3iqvLdNQfqPPyl", id: 752623)
        ])
    }
}
