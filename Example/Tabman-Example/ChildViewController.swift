//
//  ChildViewController.swift
//  Pageboy-Example
//
//  Created by Merrick Sapsford on 13/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var promptLabel: UILabel!

    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let index = self.index {
            self.label.text = "Page " + String(index)
            self.promptLabel.isHidden = index != 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
}
