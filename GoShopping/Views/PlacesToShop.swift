//
//  MallsAndShopsViewController.swift
//  GoShopping
//
//  Created by Ryan Brear on 2019/04/17.
//  Copyright © 2019 Ryan Brear. All rights reserved.
//

import UIKit
import GoShoppingSwift

class PlacesToShop: UIViewController {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var containerViewForShops: UIView!
    @IBOutlet weak var containerViewForMalls: UIView!
    var selectedCity: City!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = selectedCity.name
        segmentControl.selectedSegmentIndex = 0
        containerViewForShops.isHidden = true
        containerViewForMalls.isHidden = false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "embedSegueToMalls":
                let dvc = segue.destination as! MallsViewController
                dvc.selectedCity = selectedCity
            case "embedSegueToAllShops":
                let dvc = segue.destination as! AllShopsInCityViewController
                dvc.selectedCity = selectedCity
            default:
                break
            }
        }
    }
    
    
    @IBAction func segmentControlPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            containerViewForShops.isHidden = true
            containerViewForMalls.isHidden = false
        case 1:
            containerViewForShops.isHidden = false
            containerViewForMalls.isHidden = true
        default:
            break
        }
    }

}
