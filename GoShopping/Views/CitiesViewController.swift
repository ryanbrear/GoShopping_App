//
//  ViewController.swift
//  GoShopping
//
//  Created by Ryan Brear on 2019/04/17.
//  Copyright © 2019 Ryan Brear. All rights reserved.
//

import UIKit
import GoShoppingSwift

class CitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    // the loading indicator
    var activityIndicator = ActivityIndicatorManager()
    var refreshControl = UIRefreshControl()
    var goShoppingDataManager = GoShoppingDataManager()
    var viewData: [City] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // remove blank rows from tableview
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        addRefreshControl()
        registerForNotifications()
        getLatestDataAndRefreshView()
    }
    
    // MARK: TableView methods
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell")
        let city = viewData[indexPath.row]
        cell?.textLabel?.text = city.name
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = viewData[indexPath.row]
        performSegue(withIdentifier: "segueFromCitiesToPlacesToShop", sender: selectedCity)
    }
    
    
    func addRefreshControl() {
        // Add target for pull to refresh
        refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)),                                                                                                 for: UIControl.Event.valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    
    func getLatestDataAndRefreshView() {
        // turn activity indicator on
        activityIndicator.toggleFor(self, isOn: true)
        goShoppingDataManager.getLatestData { success in
            // turn activity indicator off
            DispatchQueue.main.async {
                // stop an loading indicators
                self.activityIndicator.toggleFor(self, isOn: false)
                self.refreshControl.endRefreshing()
            }
            if success {
                // update the view model from the data cache
                self.viewData = self.goShoppingDataManager.allCities()
                DispatchQueue.main.async {
                    self.refreshView()
                }
            } else {
                DispatchQueue.main.async {
                    AlertManager().showAlertWithOneAction(view: self, title: "Something went wrong", message: nil, firstActionTitle: "Ok", firstActionCompletion: nil)
                }
            }
        }
    }
    
    
    func refreshView() {
        self.tableView.reloadData()
    }
    
    
    @objc func pullToRefresh(_ sender: AnyObject) {
        getLatestDataAndRefreshView()
    }
    
    // MARK: Methods
    
    /// Method registers to be notified when the app comes into foreground so can refresh data and view.
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshBecauseOfWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: UIApplication.shared)
    }
    
    
    /// Method is called when the app comes into the foreground
    @objc func refreshBecauseOfWillEnterForeground() {
        getLatestDataAndRefreshView()
    }
    
    // MARK: Navigations
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueFromCitiesToPlacesToShop" {
            if let city = sender as? City {
                if let dvc = segue.destination as? PlacesToShop {
                    dvc.selectedCity = city
                }
            }
        }
    }

}

