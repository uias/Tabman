//
//  SettingsViewController.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 27/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    //
    // MARK: Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.black]
        
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonPressed(_:)))
        self.navigationItem.leftBarButtonItem = closeButton
    }

    //
    // MARK: Actions
    //
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
