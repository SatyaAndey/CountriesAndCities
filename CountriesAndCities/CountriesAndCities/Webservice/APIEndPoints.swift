//
//  APIEndPoints.swift
//  CountriesAndCities
//
//  Created by Satya on 01/02/24.
//  Copyright © 2024 Satya. All rights reserved.
//

import UIKit
/// `APIEndPoints`
enum APIEndPoints {
    case getCountries
    /// This method will return complete url for the country list API.
    func getAPIURL() -> String {
        switch self {
        case .getCountries:
            return  AppCoordinator.sharedInstance.getAPPEnvironment().getBaseURL() + "/countries"
        }
    }
}
