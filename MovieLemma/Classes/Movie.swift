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
        movieList.append(Movie(title: "The Godfather", movieId: 1, posterUrlStr: "/rPdtLWNsZmAtoZl9PK7S2wE3qiS.jpg", releaseDate: 1972))
        movieList.append(Movie(title: "Pulp Fiction", movieId: 2, posterUrlStr: "/dM2w364MScsjFf8pfMbaWUcWrR.jpg", releaseDate: 1994))
        movieList.append(Movie(title: "Forest Gump", movieId: 3, posterUrlStr: "/yE5d3BUhE8hCnkMUJOo1QDoOGNz.jpg", releaseDate: 1994))
        movieList.append(Movie(title: "The Dark Knight", movieId: 4, posterUrlStr: "/qJ2tW6WMUDux911r6m7haRef0WH.jpg", releaseDate: 1994))
        movieList.append(Movie(title: "The Lord of the Rings: The Return of the King", movieId: 5, posterUrlStr: "/rCzpDGLbOoPwLjy3OAm5NUPOTrC.jpg", releaseDate: 2003))
        movieList.append(Movie(title: "The Empire Strikes Back", movieId: 6, posterUrlStr: "/9SKDSFbaM6LuGqG1aPWN3wYGEyD.jpg", releaseDate: 1980))
        movieList.append(Movie(title: "Avengers: Endgame", movieId: 7, posterUrlStr: "/or06FN3Dka5tukK1e9sl16pB3iy.jpg", releaseDate: 2019))
        movieList.append(Movie(title: "The Pianist", movieId: 8, posterUrlStr: "/hfMeo073RxKKjZZV4gSGema1yog.jpg", releaseDate: 2002))
        
        return movieList
    }
}
