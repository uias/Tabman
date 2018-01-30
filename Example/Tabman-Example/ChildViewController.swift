//
//  ChildViewController.swift
//  Pageboy-Example
//
//  Created by Merrick Sapsford on 13/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController {

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
}
