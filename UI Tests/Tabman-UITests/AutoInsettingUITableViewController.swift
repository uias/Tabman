//
//  AutoInsettingUITableViewController.swift
//  Tabman-Tests
//
//  Created by Merrick Sapsford on 16/08/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import UIKit

class AutoInsettingUITableViewController: UITableViewController {
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Cell"
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell.textLabel?.text = "Row \(indexPath.row + 1)"
        
        return cell
    }
}
