//
//  CountriesTableViewDatasource.swift
//  CountriesAndCities
//
//  Created by Satya on 31/01/24.
//  Copyright © 2024 Satya. All rights reserved.
//

import UIKit

/// `CountriesTableViewDatasource` Data source class to Tableview
class CountriesTableViewDatasource <CELL : UITableViewCell> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String!
    private var items : [CountryAndCities]!
    var configureCell : (CELL, String) -> () = {_,_ in }
    
    /// `init` initialization and registering of tableview cell
    init(cellIdentifier : String, items : [CountryAndCities], configureCell : @escaping (CELL, String) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    // ----------------------------------
    // MARK: - Tableview datasource and delegate methods -
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.items[section].countryName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = self.items[section]
        return item.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        let item = self.items[indexPath.section]
        self.configureCell(cell, item.cities[indexPath.row])
        return cell
    }
}
