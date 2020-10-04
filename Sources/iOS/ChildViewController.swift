//
//  ChildViewController.swift
//  Example
//
//  Created by Merrick Sapsford on 04/10/2020.
//

import UIKit

class ChildViewController: UIViewController {

    // MARK: Properties
    
    let page: Int
    
    // MARK: Init
    
    init(page: Int) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        label.text = "Page \(page)"
    }
}
