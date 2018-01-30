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
                TabmanTest(title: "UITableView",
                           storyboardId: "AutoInsetting",
                           viewControllerId: "AutoInsettingTableViewViewController",
                           instances: 3),
                TabmanTest(title: "UITableViewController",
                           storyboardId: "AutoInsetting",
                           viewControllerId: "AutoInsettingUITableViewController",
                           instances: 3),
                TabmanTest(title: "UIScrollView",
                           storyboardId: "AutoInsetting",
                           viewControllerId: "AutoInsettingScrollViewViewController",
                           instances: 3),
                TabmanTest(title: "UICollectionViewController",
                           storyboardId: "AutoInsetting",
                           viewControllerId: "AutoInsettingUICollectionViewController",
                           instances: 3),
                TabmanTest(title: "UINavigationController Pop",
                           storyboardId: "AutoInsetting",
                           viewControllerId: "AutoInsettingOnPopViewController",
                           instances: 3),
                TabmanTest(title: "Multiple UIScrollView",
                           storyboardId: "AutoInsetting",
                           viewControllerId: "AutoInsettingMultiScrollViewController",
                           instances: 3)
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
        
        var viewControllers = [UIViewController]()
        var titles = [String]()
        for index in 0 ..< test.instances {
            
            var viewController: UIViewController!
            if let storyboardId = test.storyboardId, let viewControllerId = test.viewControllerId {
                let storyboard = UIStoryboard(name: storyboardId, bundle: .main)
                viewController = storyboard.instantiateViewController(withIdentifier: viewControllerId)
            } else if let viewControllerType = test.viewControllerType {
                viewController = viewControllerType.init()
            }
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
