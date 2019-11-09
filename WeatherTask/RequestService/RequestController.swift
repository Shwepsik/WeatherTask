//
//  RequestController.swift
//  WeatherTask
//
//  Created by Valerii on 11/9/19.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation
import Alamofire

typealias JSON = [String: AnyObject]
typealias ResponseBlock = (_ result: Any?, _ error: Error?)
    -> Void


protocol DataFetching {
    func tryLoadWeather(lat: Double,
                        lon: Double,
                        completion: @escaping(ResponseBlock)
    )
}

class RequestController: DataFetching {
    
    let baseUrl: String = "https://api.openweathermap.org/data/2.5/"
    
    func tryLoadInfo(method: HTTPMethod, params: Parameters?, headers: HTTPHeaders?, path: String, responseBlock: @escaping ResponseBlock) {
        
        let fullPath: String = baseUrl + path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        if let url: URL = URL(string: fullPath) {
            
            request(url, method: method, parameters: params, headers: headers).validate().responseJSON { (responseJSON) in
                switch responseJSON.result {
                case .success:
                    guard let jsonArray = responseJSON.result.value as? JSON else {
                        return
                    }
                    responseBlock(jsonArray,nil)
                    
                    
                case .failure(let error):
                    responseBlock(nil,error)
                    
                }
            }
        }
    }
    
    func tryLoadWeather(lat: Double, lon: Double, completion: @escaping(ResponseBlock)) {
        
        let params: [String: Any] = [
            "lat": lat,
            "lon": lon,
            "appid": "fc22b8e7f202e3d8eb3672de7c0c84e5"
        ]

        tryLoadInfo(method: .get, params: params, headers: nil, path: "weather") { (response, error) in
            if let json = response {
                do {
                   let model = try JSONDecoder().decode(WeatherModel.self, from: self.jsonToNSData(json: json)!)
                    completion(model, error)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    
    func jsonToNSData(json: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json,options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
}
