//
//  MovieResponse.swift
//  FilmBox
//
//  Created by Ahmet Enes Irmak on 4.01.2022.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int?
    let results: [Response]?
    let totalPages, totalResults: Int?
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
