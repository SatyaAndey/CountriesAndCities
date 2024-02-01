//
//  CountriesAndCitiesTests.swift
//  CountriesAndCitiesTests
//
//  Created by Satya on 31/01/24.
//  Copyright © 2024 Satya. All rights reserved.
//

import XCTest
@testable import CountriesAndCities

class CountriesAndCitiesTests: XCTestCase {
   var sut: ViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Test case for API Service call for country list with viewmodel
       
    func testApiCallWithProperRequest() {
        // we have to check with different urls and offline and online conditions
        //Given
        sut.countriesViewModel = CountriesViewModel()
        let promise = expectation(description: "country list fetched successfully")
        
        //When
        sut.countriesViewModel.getCountryList()
        
        // then
        sut.countriesViewModel.bindCountryListViewModelToController = {
            promise.fulfill()
        }
        sut.countriesViewModel.handleAPIError = {(message) in
            XCTFail("Error: \(message)")
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    // Test case for Local data mapping with country response model.
    func testMapLocalDataWithCountryResponseModel() {
        //Given
        if let jsonPath = Bundle(for: self.classForCoder).path(forResource: "countryList", ofType: "json") {
            if let data = NSData(contentsOfFile: jsonPath) {
                do {
                    if let stringResponse =  String(data: data as Data, encoding: .ascii)  {
                        //When
                        do {
                            if let dataLocal = stringResponse.data(using: .utf8) {
                                let countries =  try JSONDecoder().decode( CountryResponse.self, from: dataLocal as Data)
                                
                                //Then
                                XCTAssert(countries.data?.count ?? 0 > 0)
                            }
                        } catch let exception {
                            XCTFail("Error: \(exception.localizedDescription)")
                        }
                    }
                }
            }}
    }
       
   // Test case for data source mapping with tableview.
    func testTablewDatasource() {
        //Given
        var countries = CountryResponse(msg: nil, data: nil, error: false)
        if let jsonPath = Bundle(for: self.classForCoder).path(forResource: "countryList", ofType: "json") {
            if let data = NSData(contentsOfFile: jsonPath) {
                do {
                    if let stringResponse =  String(data: data as Data, encoding: .ascii)  {
                        do {
                            if let dataLocal = stringResponse.data(using: .utf8) {
                                countries =  try JSONDecoder().decode( CountryResponse.self, from: dataLocal as Data)
                            }
                        } catch let exception {
                            XCTFail("Error: \(exception.localizedDescription)")
                        }
                    }
                }
            }}
        //When
        let dataSource = CountriesTableViewDatasource(cellIdentifier: "CountryCityTableViewCell", items: countries.data ?? [CountryAndCities](), configureCell: { (cell, cityName) in
        })
        
        DispatchQueue.main.async {
            let tableview = UITableView()
            tableview.dataSource = dataSource
            tableview.reloadData()
            //Then
            XCTAssert(tableview.numberOfRows(inSection: 0) > 0, "There are no cells in Tableview")
        }
        
    }

}
