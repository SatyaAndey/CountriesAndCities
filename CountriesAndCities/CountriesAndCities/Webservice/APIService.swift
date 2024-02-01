//
//  APIService.swift
//  CountriesAndCities
//
//  Created by Satya on 31/01/24.
//  Copyright © 2023 Satya. All rights reserved.
//

import UIKit

/// `API APIService Manager`
class APIService: NSObject {
    /// web service call to fetch country list.
    func getCountryList( completion: @escaping([CountryAndCities]) -> Void, failure: @escaping(String) -> Void) {
        if let url = URL(string: APIEndPoints.getCountries.getAPIURL()) {
            let request = URLRequest(url: url)
            let task = URLSession(configuration: .default).dataTask(with: request) { ( data, response , error) in
                do {
                    if let data = data {
                        if let strData =  String(data: data, encoding: .ascii)  {
                            let data = strData.data(using: .utf8)
                            /// API Response mapping to data model
                            let model =  try JSONDecoder().decode(CountryResponse.self, from: data!)
                            if let countries = model.data {
                                completion(countries)
                            } else {
                                failure(error?.localizedDescription ?? API_ERROR_MESSAGE)
                            }
                        } else {
                            failure(error?.localizedDescription ?? API_ERROR_MESSAGE)
                        }
                    } else {
                        failure(error?.localizedDescription ?? API_ERROR_MESSAGE)
                    }
                } catch let exception {
                    failure(exception.localizedDescription)
                    print(exception)
                }
                
            }
            task.resume()
        } else {
            failure(API_ERROR_MESSAGE)
        }
    }
    
}
