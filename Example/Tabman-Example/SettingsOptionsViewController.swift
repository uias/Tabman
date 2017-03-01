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
                               didSelectOption option: String)
}

class SettingsOptionsViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    weak var delegate: SettingsOptionsViewControllerDelegate?
    
    var indexPath: IndexPath?
    var selectedOption: String?
    var options: [String]? {
        didSet {
            guard self.tableView != nil else { return }
            self.tableView.reloadData()
        }
    }
    
    var selectedCell: UITableViewCell?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 1.0))
    }
}

extension SettingsOptionsViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        
        let option = self.options?[indexPath.row]
        cell?.textLabel?.text = option
        if self.selectedOption == option {
            cell?.accessoryType = .checkmark
            self.selectedCell = cell
        } else {
            cell?.accessoryType = .none
        }
        cell?.backgroundColor = .clear
        cell?.tintColor = self.navigationController?.navigationBar.tintColor

        let selectedView = UIView()
        selectedView.backgroundColor = self.navigationController?.navigationBar.tintColor.withAlphaComponent(0.3)
        cell?.selectedBackgroundView = selectedView
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let option = self.options?[indexPath.row] else { return }
        
        let selectedCell = tableView.cellForRow(at: indexPath)
        self.selectedCell?.accessoryType = .none
        selectedCell?.accessoryType = .checkmark
        
        self.delegate?.optionsViewController(self, didSelectOption: option)
    }
}
