//
//  ButtonBarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/05/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

public final class ButtonBarLayout: BarLayout {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let interButtonSpacing: CGFloat = 8.0
    }
    
    // MARK: Properties
    
    private let stackView = ScrollStackView()
    
    // MARK: Layout
    
    public override func performLayout(in view: UIView) {
        super.performLayout(in: view)
        
        container.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.interButtonSpacing = Defaults.interButtonSpacing
    }
    
    // MARK: Lifecycle
    
    override func populate(with barButtons: [BarButton]) {
        barButtons.forEach({ stackView.addArrangedSubview($0) })
    }
    
    override func clear() {
        stackView.arrangedSubviews.forEach({ stackView.removeArrangedSubview($0) })
    }
}

// MARK: - Customization
public extension ButtonBarLayout {
    
    public var interButtonSpacing: CGFloat {
        set {
            stackView.spacing = newValue
        } get {
            return stackView.spacing
        }
    }
    
    public var isScrollEnabled: Bool {
        set {
            stackView.isScrollEnabled = newValue
        } get {
            return stackView.isScrollEnabled
        }
    }
}
