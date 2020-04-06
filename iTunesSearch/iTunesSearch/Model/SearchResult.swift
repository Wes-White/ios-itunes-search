//
//  SearchResult.swift
//  iTunesSearch
//
//  Created by Wesley Ryan on 4/5/20.
//  Copyright © 2020 Wesley Ryan. All rights reserved.
//

import Foundation


struct SearchResult: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
    
    let title: String
    let creator: String
    

}





struct iTunesResult: Codable {
    let results: [SearchResult]
}
