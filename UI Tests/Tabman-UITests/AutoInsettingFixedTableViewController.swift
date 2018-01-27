//
//  AutoInsettingFixedTableViewController.swift
//  Tabman-UITests
//
//  Created by Merrick Sapsford on 27/01/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

class AutoInsettingFixedTableViewController: TestViewController {
 
    @IBOutlet weak var tableView: UITableView!
}

extension AutoInsettingFixedTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Cell"
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell.textLabel?.text = "Row \(indexPath.row)"
        
        return cell
    }
}
