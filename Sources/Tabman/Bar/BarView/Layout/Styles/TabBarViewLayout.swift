//
//  TabBarViewLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 26/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

public final class TabBarViewLayout: BarViewLayout {
    
    // MARK: Properties
    
    private let stackView = UIStackView()

    public override var contentMode: BarViewLayout.ContentMode {
        set {
            guard newValue == .fit else {
                fatalError("TabBarViewLayout only supports .fit contentMode")
            }
            super.contentMode = newValue
        } get {
            return super.contentMode
        }
    }
   
    
    // MARK: Lifecycle
    
    public override func performLayout(in view: UIView) {
        super.performLayout(in: view)
    
        stackView.distribution = .fillEqually
        contentMode = .fit
        
        container.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    public override func populate(with barButtons: [BarButton], at index: Int?) {
        barButtons.forEach({ stackView.addArrangedSubview($0) })
    }
    
    public override func clear() {
        
    }
    
    public override func barFocusRect(for position: CGFloat, capacity: Int) -> CGRect {
        return .zero
    }
}
