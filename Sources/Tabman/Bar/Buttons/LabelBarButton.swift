//
//  LabelBarButton.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

public final class LabelBarButton: BarButton {
    
    // MARK: Properties
    
    private let label = UILabel()
    
    // MARK: Lifecycle
    
    public override func performLayout(in view: UIView) {
        super.performLayout(in: view)
        
        label.text = "LabelBarButton"
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func populate(for item: BarItem) {
        super.populate(for: item)
        
        label.text = item.title
    }
}

// MARK: - Label manipulation
public extension LabelBarButton {
    
    public var text: String? {
        set {
            label.text = newValue
        } get {
            return label.text
        }
    }
}
