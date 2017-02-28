//
//  SettingsOptionsViewController.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 28/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

protocol SettingsOptionsViewControllerDelegate: class {
    
    func optionsViewController(_ viewController: SettingsOptionsViewController,
                               didSelectOptionAtIndex index: Int)
}

class SettingsOptionsViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    weak var delegate: SettingsOptionsViewControllerDelegate?
    var options: [String]? {
        didSet {
            self.tableView.reloadData()
        }
    }
}

extension SettingsOptionsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Cell"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        return cell!
    }
}
