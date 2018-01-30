//
//  AutoInsettingMultiScrollViewController.swift
//  Tabman-UITests
//
//  Created by Merrick Sapsford on 29/01/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import PureLayout

class AutoInsettingMultiScrollViewController: TestViewController {

    let tableView = UITableView()
    let secondTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        secondTableView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        
        view.addSubview(tableView)
        tableView.autoPinEdge(toSuperviewEdge: .top)
        tableView.autoPinEdge(toSuperviewEdge: .leading)
        tableView.autoPinEdge(toSuperviewEdge: .trailing)
        tableView.autoSetDimension(.height, toSize: 300)
        
        view.addSubview(secondTableView)
        
        secondTableView.autoPinEdge(toSuperviewEdge: .leading)
        secondTableView.autoPinEdge(toSuperviewEdge: .trailing)
        secondTableView.autoPinEdge(.top, to: .bottom, of: tableView)
        secondTableView.autoPinEdge(toSuperviewEdge: .bottom)
        
        tableView.dataSource = self
        secondTableView.dataSource = self
    }
}

extension AutoInsettingMultiScrollViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Cell"
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell.textLabel?.text = "Row \(indexPath.row)"
        cell.backgroundColor = .clear
        
        return cell
    }
}
