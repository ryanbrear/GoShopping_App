//
//  MallsViewController.swift
//  GoShopping
//
//  Created by Ryan Brear on 2019/04/17.
//  Copyright © 2019 Ryan Brear. All rights reserved.
//

import UIKit
import GoShoppingSwift

class MallsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var selectedCity: City!
    var viewData: [Mall] = []
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // remove blank rows from tableview
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        viewData = selectedCity.allMallsInCity()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mallCell")!
        let mall = viewData[indexPath.row]
        cell.textLabel?.text = mall.name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMall = viewData[indexPath.row]
        performSegue(withIdentifier: "segueToShopsInMall", sender: selectedMall)
    }
   
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToShopsInMall" {
            if let mall = sender as? Mall {
                if let dvc = segue.destination as? ShopsInMallViewController {
                    dvc.selectedMall = mall
                }
            }
        }
    }

}
