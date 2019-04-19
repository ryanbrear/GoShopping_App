//
//  LoadingIndicator.swift
//  GoShopping
//
//  Created by Ryan Brear on 2019/04/19.
//  Copyright © 2019 Ryan Brear. All rights reserved.
//

import UIKit

internal struct ActivityIndicatorManager {
    
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    let holder = UIView(frame: CGRect(x: 0, y: 0, width: 78, height: 78))
    
    init () {
        self.setUpActivityIndicator()
    }
    
    func setUpActivityIndicator () {
        // holder
        holder.isHidden = true
        holder.alpha = CGFloat(0.7)
        holder.backgroundColor = UIColor.black
        holder.layer.cornerRadius = CGFloat(9.75)
        holder.clipsToBounds = true
        // spinner
        spinner.hidesWhenStopped = true
    }
    
    func centerEverything (currentView: UIViewController) {
        // centre holder in main view
        let vCSize = currentView.view.frame.size
        holder.center = CGPoint(x: vCSize.width/2, y: vCSize.height/2)
        let holderSize = holder.frame.size
        spinner.center = CGPoint(x: holderSize.width/2, y: holderSize.height/2)
    }
    
    func toggleFor(_ currentView: UIViewController?, isOn: Bool) {
        if isOn == true {
            holder.isHidden = false
            if currentView != nil {
                currentView!.view.addSubview(holder)
                holder.addSubview(spinner)
                centerEverything(currentView: currentView!)
                spinner.startAnimating()
            }
        } else if isOn == false {
            if currentView != nil {
                holder.isHidden = true
                spinner.stopAnimating()
                holder.removeFromSuperview()
            }
        }
    }
    
}
