//
//  WeatherModel.swift
//  WeatherTask
//
//  Created by Valerii on 11/9/19.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
    
    var description: String
    var name: String
    var country: String
    var temp: Double
    var humidity: Double
    var pressure: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        var weather = try container.nestedUnkeyedContainer(forKey: .weather)
        let weatherContainer = try weather.nestedContainer(keyedBy: WeatherKey.self)
        self.description = try weatherContainer.decode(type(of: self.description), forKey: .description)
        let descriptionContainer = try container.nestedContainer(keyedBy: DescriptionsKeys.self, forKey: .main)
        self.temp = try descriptionContainer.decode(type(of: self.temp), forKey: .temp)
        self.pressure = try descriptionContainer.decode(type(of: self.pressure), forKey: .pressure)
        self.humidity = try descriptionContainer.decode(type(of: self.humidity), forKey: .humidity)
        let mainContainer = try decoder.container(keyedBy: MainKey.self)
        self.name = try mainContainer.decode(type(of: self.name), forKey: .name)
        let sysContainer = try container.nestedContainer(keyedBy: SysKey.self, forKey: .sys)
        self.country = try sysContainer.decode(type(of: self.country), forKey: .country)
    }
    
    enum RootKeys: CodingKey {
        case weather
        case main
        case sys
    }
    
    enum WeatherKey: CodingKey {
        case description
    }
    
    enum DescriptionsKeys: CodingKey {
        case temp
        case pressure
        case humidity
    }
    
    enum MainKey: CodingKey {
        case name
    }
    
    enum SysKey: CodingKey {
        case country
    }
}
