//
//  Forecast.swift
//  WeatherAPIParse
//
//  Created by Vic on 29.01.2024.
//

import Foundation

struct Metar: Codable {
    let icaoId: String
    let reportTime: String
    let rawOb: String
    let name: String
}

struct Taf: Codable {
    let icaoId: String
    let rawTAF: String
    let name: String
}
