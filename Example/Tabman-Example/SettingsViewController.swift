//
//  SettingsViewController.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 27/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    weak var tabViewController: TabViewController?
    fileprivate var sections = [SettingsSection]()
    
    var selectedIndexPath: IndexPath?
    var selectedItem: SettingsItem?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.black]
        
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonPressed(_:)))
        self.navigationItem.leftBarButtonItem = closeButton
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50.0
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 1.0))
        
        self.sections = self.addItems()
        self.tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let optionsViewController = segue.destination as? SettingsOptionsViewController {
            optionsViewController.navigationItem.title = self.selectedItem?.title
            optionsViewController.delegate = self
            
            guard let selectedItem = self.selectedItem else { return }
            if case let .options(values, selectedValue) = selectedItem.type {
                optionsViewController.indexPath = self.selectedIndexPath
                optionsViewController.selectedOption = selectedValue()
                optionsViewController.options = values
            }
        }
    }
    
    // MARK: Actions
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = self.sections[indexPath.section].item(atIndex: indexPath.row) else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: item.type.reuseIdentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.tintColor = self.navigationController?.navigationBar.tintColor
        
        let selectedView = UIView()
        selectedView.backgroundColor = self.navigationController?.navigationBar.tintColor.withAlphaComponent(0.3)
        cell.selectedBackgroundView = selectedView
        
        if let toggleCell = cell as? SettingsToggleCell {
            toggleCell.titleLabel.text = item.title
            toggleCell.descriptionLabel.text = item.description
            toggleCell.toggle.isOn =  (item.value as? Bool) ?? false
            toggleCell.delegate = item
            
        } else if let optionCell = cell as? SettingsOptionCell {
            optionCell.titleLabel.text = item.title
            if case let .options(_, selectedValue) = item.type {
                optionCell.valueLabel.text = selectedValue()
            }
            cell.selectionStyle = .default
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return self.sections[section].title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        
        headerView.contentView.backgroundColor = self.navigationController?.navigationBar.tintColor
        headerView.textLabel?.textColor = .white
        headerView.textLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightMedium)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedIndexPath = indexPath
        self.selectedItem = self.sections[indexPath.section].item(atIndex: indexPath.row)
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingsViewController: SettingsOptionsViewControllerDelegate {
    
    func optionsViewController(_ viewController: SettingsOptionsViewController,
                               didSelectOption option: String) {
        let _ = self.navigationController?.popViewController(animated: true)
        
        if let selectedIndexPath = self.selectedIndexPath,
            let cell = self.tableView.cellForRow(at: selectedIndexPath) as? SettingsOptionCell {
            cell.valueLabel?.text = option
        }
        
        self.selectedItem?.update(option)
        self.selectedItem = nil
    }
}

extension SettingsViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return SettingsPushTransitionController()

        case .pop:
            return SettingsPopTransitionController()
            
        default:
            return nil
        }
    }
}
