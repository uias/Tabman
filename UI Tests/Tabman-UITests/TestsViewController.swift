//
//  TestsViewController.swift
//  Tabman-Tests
//
//  Created by Merrick Sapsford on 13/08/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import UIKit

class TestsViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    private(set) var sections: [TabmanTestSection]?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sections = [
            TabmanTestSection(title: "Auto Insetting", tests: [
                TabmanTest(title: "UITableView", storyboardId: "AutoInsetting", viewControllerId: "AutoInsettingTableViewController", instances: 3),
                TabmanTest(title: "UITableViewController", storyboardId: "AutoInsetting", viewControllerId: "AutoInsettingUITableViewController", instances: 3)
                ])
        ]
    }
}

extension TestsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections?[section].tests.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "TestCell"
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        let test = sections?[indexPath.section].tests[indexPath.row]
        
        cell.textLabel?.text = test?.title
        
        return cell
    }
}

extension TestsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections?[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let test = sections?[indexPath.section].tests[indexPath.row] else { return }
        
        let storyboard = UIStoryboard(name: test.storyboardId, bundle: .main)
        
        var viewControllers = [UIViewController]()
        var titles = [String]()
        for index in 0 ..< test.instances {
            let viewController = storyboard.instantiateViewController(withIdentifier: test.viewControllerId)
            titles.append("\(test.title) \(index + 1)")
            viewControllers.append(viewController)
        }
        
        let containerViewController = TabmanContainerViewController(with: viewControllers,
                                                                    titles: titles,
                                                                    for: test)
        
        viewControllers.forEach { (viewController) in
            if let testViewController = viewController as? TestViewController {
                testViewController.test = test
            }
        }
        
        navigationController?.pushViewController(containerViewController, animated: true)
    }
}
