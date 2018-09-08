//
//  PageStatusView.swift
//  Pageboy-Example
//
//  Created by Merrick Sapsford on 18/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

class PageStatusView: UIView {
    
    // MARK: Properties
    
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var positionLabel: UILabel!
    @IBOutlet private weak var indexLabel: UILabel!
    
    var numberOfPages: Int = 0 {
        didSet {
            countLabel.text = "Page Count: \(numberOfPages)"
        }
    }
    var currentPosition: CGFloat = 0.0 {
        didSet {
            positionLabel.text = "Current Position: \(String(format: "%.3f", currentPosition))"
        }
    }
    var currentIndex: Int = 0 {
        didSet {
            currentPosition = CGFloat(currentIndex)
            indexLabel.text = "Current Page: \(currentIndex)"
        }
    }
    
    // MARK: Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        numberOfPages = 0
        currentPosition = 0.0
        currentIndex = 0
    }
}
