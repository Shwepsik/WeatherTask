//
//  MapModel.swift
//  WeatherTask
//
//  Created by Valerii on 11/9/19.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation

typealias Response = (_ result: WeatherModel) -> Void


class MapModel {
    
    private let dataFetcher: DataFetching
    
    init(dataFetcher: DataFetching) {
        self.dataFetcher = dataFetcher
    }
    
    func loadWeatherDescriptions(lat: Double, lon: Double, completion: @escaping(Response)) {
        dataFetcher.tryLoadWeather(lat: lat, lon: lon) { (response, error) in
            if let weatherModel = response as? WeatherModel {
                completion(weatherModel)
            }
        }
    }
}
