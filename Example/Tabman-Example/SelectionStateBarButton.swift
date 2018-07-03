//
//  SelectionStateBarButton.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 03/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Tabman
import SnapKit

class SelectionStateBarButton: BarButton {
    
    let label = UILabel()
    
    override func performLayout(in view: UIView) {
        super.performLayout(in: view)
        
        label.text = selectionState.description
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func populate(for item: BarItem) {
    }
    
    override func update(for selectionState: BarButton.SelectionState) {
        label.text = selectionState.description
    }
}

extension BarButton.SelectionState: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .unselected:
            return "Selected: 0.0"
        case .selected:
            return "Selected: 1.0"
        case .partial(let delta):
            return "Selected " + String(format: "%.1f", delta)
        }
    }
}
