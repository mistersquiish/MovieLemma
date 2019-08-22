//
//  Movie.swift
//  MovieLemma
//
//  Created by Henry Vuong on 8/22/19.
//  Copyright © 2019 Henry Vuong. All rights reserved.
//

import Foundation

class Movie {
    var title: String?
    var movieId: Int?
    var posterUrl: URL?
    var releaseDate: Int?

    init(title: String, movieId: Int, posterUrlStr: String, releaseDate: Int) {
        self.title = title
        self.movieId = movieId
        self.posterUrl = URL(string: "https://image.tmdb.org/t/p/w500" + posterUrlStr)
        self.releaseDate = releaseDate
    }
    
    class func generateMovie() -> [Movie] {
        var movieList: [Movie] = []
        movieList.append(Movie(title: "The Godfather", movieId: 238, posterUrlStr: "/rPdtLWNsZmAtoZl9PK7S2wE3qiS.jpg", releaseDate: 1972))
        movieList.append(Movie(title: "Pulp Fiction", movieId: 680, posterUrlStr: "/dM2w364MScsjFf8pfMbaWUcWrR.jpg", releaseDate: 1994))
        movieList.append(Movie(title: "Forest Gump", movieId: 13, posterUrlStr: "/yE5d3BUhE8hCnkMUJOo1QDoOGNz.jpg", releaseDate: 1994))
        
        return movieList
    }
}
