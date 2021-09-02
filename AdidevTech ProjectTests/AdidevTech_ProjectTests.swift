//
//  AdidevTech_ProjectTests.swift
//  AdidevTech ProjectTests
//
//  Created by Emmanuel on 9/1/21.
//

import Foundation

import XCTest
@testable import AdidevTech_Project

class AdidevTech_ProjectTests: XCTestCase {

    // Negative Track Price
    func NegativeTrackPrice() {
        let results = Artist.init(artistName: "Drake", trackName: "Hotline Bling", releaseDate: "July 31, 2015", primaryGenreName: "Pop", trackPrice: -2.99)
        XCTAssertLessThan(0, results.trackPrice)
    }
    
    // Artist Name Short
    func ShortArtistName() {
        let results = Artist.init(artistName: "D", trackName: "Hotline Bling", releaseDate: "July 31, 2015", primaryGenreName: "Pop", trackPrice: 2.99)
        XCTAssertLessThanOrEqual(1, results.artistName.count)
    }
    
        
}
