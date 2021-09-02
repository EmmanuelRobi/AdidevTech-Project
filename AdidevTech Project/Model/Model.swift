//
//  Model.swift
//  AdidevTech Project
//
//  Created by Emmanuel on 9/1/21.
//

import Foundation



struct Results: Codable {
    let results: [Artist]
    let resultCount: Int
}

struct Artist: Codable {
    let artistName, trackName, releaseDate, primaryGenreName: String
    let trackPrice: Double
}

