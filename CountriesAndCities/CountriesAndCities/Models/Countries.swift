//
//  Countries.swift
//  CountriesAndCities
//
//  Created by Satya on 01/02/24.
//  Copyright © 2024 Satya. All rights reserved.
//

import UIKit

// MARK: - Whole Response

struct CountryResponse: Decodable {
    
    let msg: String?
    let data: [CountryAndCities]?
    let error: Bool?
}

// MARK: - Data with Countries and cities

struct CountryAndCities: Decodable {
    
    let countryName: String
    let cities: [String]

    enum CodingKeys: String, CodingKey {
        case countryName = "country"
        case cities = "cities"

    }
}
