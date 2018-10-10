//
//  ChildViewController.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 13/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var promptLabel: UILabel!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateIndexLabel()
    }
    
    private func updateIndexLabel() {
        if let index = (parentPageboy as? TabPageViewController)?.viewControllers.index(of: self) {
            label.text = "Page " + String(index + 1)
            
            let isFirstPage = index == 0
            
            var prompt = "(Index \(index))"
            if isFirstPage {
                prompt.append("\n\nswipe me >")
            }
            promptLabel.text = prompt
        }
    }
}

extension ChildViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 75
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
