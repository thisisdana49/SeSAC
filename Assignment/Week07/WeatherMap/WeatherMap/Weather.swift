//
//  Weather.swift
//  WeatherMap
//
//  Created by 조다은 on 2/3/25.
//

import Foundation

struct Weather: Decodable {
    let main: WeatherMain
    let wind: WeatherWind
    let dt: Int
}

struct WeatherMain: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct WeatherWind: Decodable {
    let speed: Double
}
