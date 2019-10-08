//
//  MovieViewModel.swift
//  Movies
//
//  Created by alessandro on 07/10/19.
//  Copyright © 2019 alessandro. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa

struct MovieViewModel{
    let movie:Movie
    
    init(_ movie:Movie) {
        self.movie = movie
    }
    
    var title: Observable<String> {
        return Observable<String>.just(movie.title.capitalized)
    }
    var overview: Observable<String> {
        return Observable<String>.just(movie.overview.capitalized)
    }
    var duration: Observable<String> {
        return Observable<String>.just(movie.duration)
    }
    var release_year: Observable<String> {
        return Observable<String>.just(movie.release_year)
    }
    var cover_url: Observable<String> {
        return Observable<String>.just(movie.cover_url)
    }

}

struct MoviesListViewModel {
    let moviesVM:[MovieViewModel]
    
    init(_ movies:[Movie]) {
        self.moviesVM = movies.compactMap(MovieViewModel.init)
    }
    
    func moviesAt(_ index:Int) -> MovieViewModel {
        return self.moviesVM[index]
    }
}

