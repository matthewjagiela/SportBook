//
//  Model.swift
//  SportBook
//
//  Created by Matthew Jagiela on 4/24/21.
//

import Foundation

// MARK: - Results
struct Results: Codable {
    let f1Results: [F1Result]
    let nbaResults: [NbaResult]
    let tennis: [Tennis]

    enum CodingKeys: String, CodingKey {
        case f1Results, nbaResults
        case tennis = "Tennis"
    }
}

// MARK: - F1Result
struct F1Result: Codable {
    let publicationDate: String
    let seconds: Double
    let tournament, winner: String
}

// MARK: - NbaResult
struct NbaResult: Codable {
    let gameNumber: Int
    let looser, mvp, publicationDate, tournament: String
    let winner: String
}

// MARK: - Tennis
struct Tennis: Codable {
    let looser: String
    let numberOfSets: Int
    let publicationDate, tournament, winner: String
}

