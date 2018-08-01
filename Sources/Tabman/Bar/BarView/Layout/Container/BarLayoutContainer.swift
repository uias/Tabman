//
//  BarLayoutContainer.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

final class BarLayoutContainer: UIView {
    
    // MARK: Properties
    
    private let contentView = UIView()
    
    private var contentViewPins: Constraint?
    public var contentInset: UIEdgeInsets = .zero {
        didSet {
            contentViewPins?.update(inset: contentInset)
        }
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            self.contentViewPins = make.edges.equalToSuperview().constraint
        }
    }
    
    // MARK: Lifecycle
    
    override func addSubview(_ view: UIView) {
        if view === contentView {
            super.addSubview(view)
        } else {
            contentView.addSubview(view)
        }
    }
}
