//
//  ShopsDetailViewController.swift
//  GoShopping
//
//  Created by Ryan Brear on 2019/04/17.
//  Copyright © 2019 Ryan Brear. All rights reserved.
//

import UIKit
import GoShoppingSwift

class AllShopsInCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var selectedCity: City!
    @IBOutlet weak var tableView: UITableView!
    var viewData: [Shop] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // remove blank rows from tableview
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        viewData = selectedCity.allShopsInCity()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopCell")!
        let shop = viewData[indexPath.row]
        cell.textLabel?.text = shop.name
        return cell
    }
    
    
}
