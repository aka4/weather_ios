//
//  GeoResponse.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 28.03.23.
//

import Foundation

struct GeoElement: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    static let emptyElement = GeoElement(name: "", lat: 0, lon: 0, country: "")
}

typealias GeoResponse = [GeoElement]
