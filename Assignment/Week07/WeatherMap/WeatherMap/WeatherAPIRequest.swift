//
//  WeatherAPIRequest.swift
//  WeatherMap
//
//  Created by 조다은 on 2/3/25.
//

import Foundation
import Alamofire

enum WeatherAPIRequest {
    case currentWeather(lat: Double, lon: Double)
    
    var endPoint: String {
        switch self {
        case .currentWeather:
            return Config.baseURL
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters {
        switch self {
        case .currentWeather(let lat, let lon):
            return [
                "appid": Key.appID,
                "lat": lat,
                "lon": lon,
                "units": "metric"
            ]
        }
    }
}
