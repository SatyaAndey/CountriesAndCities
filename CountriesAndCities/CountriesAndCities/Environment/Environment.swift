//
//  Environment.swift
//  CountriesAndCities
//
//  Created by Satya on 01/02/24.
//  Copyright © 2024 Satya. All rights reserved.
//

import UIKit

/// `AppEnvironment` get current App environment QA/Release properties
enum AppEnvironment: String {
    case QA
    case Release
    
    func getBaseURL() -> String {
        switch self {
        case .QA:
            return APP_QA_BASE_URL
        case .Release:
            return APP_RELEASE_BASE_URL
        }
    }
}
