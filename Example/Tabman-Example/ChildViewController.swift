//
//  ChildViewController.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 13/02/2017.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit
import Tabman

class ChildViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var promptLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateIndexLabel()
    }
    
    private func updateIndexLabel() {
        if let index = pageboyPageIndex {
            label.text = "Page " + String(index + 1)
            
            let isFirstPage = index == 0
            
            var prompt = "(Index \(index))"
            if isFirstPage {
                prompt.append("\n\nswipe me >")
            }
            promptLabel.text = prompt
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
}
