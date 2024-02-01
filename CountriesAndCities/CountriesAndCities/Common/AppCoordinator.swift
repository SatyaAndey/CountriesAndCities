//
//  AppCoordinator.swift
//  CountriesAndCities
//
//  Created by Satya on 01/02/24.
//  Copyright © 2024 Satya. All rights reserved.
//

import UIKit

/// `AppCoordinator` 
class AppCoordinator: NSObject {
   static let sharedInstance = AppCoordinator()
    
    func getAPPEnvironment() -> AppEnvironment {
        let environment = Bundle.main.object(forInfoDictionaryKey: APP_ENVIRONMENT_KEY) as? String ??  APP_ENVIRONMENT_KEY_QA
        return AppEnvironment(rawValue: environment) ?? .QA
    }
}
