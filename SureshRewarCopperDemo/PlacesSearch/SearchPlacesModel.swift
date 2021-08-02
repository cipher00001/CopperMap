//
//  SearchPlacesModel.swift
//  SureshRewarCopperDemo
//
//  Created by Suresh Rewar on 01/08/21.
//

import Foundation
// MARK: - PlacesBaseModel
struct PlacesBaseModel: Codable {
    let results: [Result]
    let status: String
}

// MARK: - Result
struct Result: Codable {
    let geometry: Geometry
    let icon: String
    let name: String
    let opening_hours: OpeningHours?
    let photos: [Photo]
    let place_id, reference: String
    let types: [String]
    let vicinity: String
}

// MARK: - Geometry
struct Geometry: Codable {
    let location: Location
}

// MARK: - Location
struct Location: Codable {
    let lat, lng: Double
}

// MARK: - OpeningHours
struct OpeningHours: Codable {
    let open_now: Bool
}

// MARK: - Photo
struct Photo: Codable {
    let height: Int
    let photo_reference: String
    let width: Int
}
