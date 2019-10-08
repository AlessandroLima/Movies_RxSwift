//
//  Movie.swift
//  Movies
//
//  Created by alessandro on 07/10/19.
//  Copyright © 2019 alessandro. All rights reserved.
//

import Foundation

struct Movie: Codable{
    
    let title:String
    let overview:String
    let duration:String
    let release_year:String
    let cover_url:String
    
}

struct Movies: Codable{
    let movies:[Movie]
}

extension Movies{

    static var all:Resource<Movies> = {
        let url = URL(string: "https://sky-exercise.herokuapp.com/api/Movies")!
        let resource = Resource<Movies>(url: url)
        return resource

    }()

}
