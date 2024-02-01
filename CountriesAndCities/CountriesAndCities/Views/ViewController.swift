//
//  ViewController.swift
//  CountriesAndCities
//
//  Created by Satya on 31/01/24.
//  Copyright © 2024 Satya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /// `countryListTableView` reference variable from storyboard to viewcontroller.
    @IBOutlet weak var countryListTableView: UITableView!
    /// `countriesViewModel` reference variable  for countries data view model.
    var countriesViewModel : CountriesViewModel!
    /// `dataSource` reference variable for tableview datasource.
    var dataSource : CountriesTableViewDatasource<CountryCityTableViewCell>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
     /// `viewDidLoad` viewcontroller life cycle method.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = SCREEN_TITLE
        callToViewModelForUIUpdate()
        configureUI()
    }
    /// `configureUI` UI configurations.
    func configureUI() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.callToViewModelForUIUpdate), for: .valueChanged)
        self.countryListTableView.refreshControl = refreshControl
    }
    
    /// `callToViewModelForUIUpdate` viewmodel binding to view controller.
    @objc func callToViewModelForUIUpdate() {
        self.countryListTableView.isHidden = true
        self.countryListTableView.refreshControl?.endRefreshing()
        self.countriesViewModel =  CountriesViewModel()
        self.countriesViewModel.bindCountryListViewModelToController = {
            DispatchQueue.main.async {
                self.countryListTableView.isHidden = false
            }
            self.updateDataSource()
        }
        self.countriesViewModel.handleAPIError = {(message) in
            DispatchQueue.main.async {
                self.showAlert(message)
                self.countryListTableView.isHidden = false
                self.countryListTableView.refreshControl?.endRefreshing()
            }
        }
    }
    
     /// `updateDataSource` call back methods from viewmodel.
    func updateDataSource() {
        self.dataSource = CountriesTableViewDatasource(cellIdentifier: TABLEVIEW_CELL_IDENTIFIER, items: self.countriesViewModel.countryList, configureCell: { (cell, cityName) in
            cell.textLabel?.text = cityName
        })
        
        DispatchQueue.main.async {
            self.countryListTableView.dataSource = self.dataSource
            self.countryListTableView.reloadData()
        }
    }
    
}

