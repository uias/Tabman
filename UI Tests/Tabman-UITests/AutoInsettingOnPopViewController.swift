//
//  AutoInsettingOnPopViewController.swift
//  Tabman-UITests
//
//  Created by Merrick Sapsford on 28/11/2017.
//  Copyright © 2017 UI At Six. All rights reserved.
//

import UIKit

class AutoInsettingOnPopViewController: AutoInsettingUITableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.delegate = self
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension AutoInsettingOnPopViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        navigationController.popViewController(animated: true)
        navigationController.delegate = nil
    }
}

