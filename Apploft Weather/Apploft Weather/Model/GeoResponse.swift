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
}

typealias GeoResponse = [GeoElement]
