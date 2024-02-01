//
//  CountriesViewModel.swift
//  CountriesAndCities
//
//  Created by Satya on 31/01/24.
//  Copyright © 2024 Satya. All rights reserved.
//

import UIKit

/// `CountriesViewModel` View model class for country list data opearations.
class CountriesViewModel: NSObject {
    /// `apiService` refernce variable for APIclient.
    private var apiService : APIService!
    /// `countryList` refernce variable for country list model.
    private(set) var countryList : [CountryAndCities]! {
        didSet {
            self.bindCountryListViewModelToController()
        }
    }
    
    var bindCountryListViewModelToController : (() -> ()) = {}
    var handleAPIError : ((String) -> ()) = {_ in }
    
    override init() {
        super.init()
        self.apiService =  APIService()
        getCountryList()
    }
    
    /// `getCountryList` middle layer method to fetch country list.
    func getCountryList() {
        self.apiService.getCountryList(completion: { (countries) in
            self.countryList = countries
        }) { (message) in
            self.handleAPIError(message)
        }
    }
}
