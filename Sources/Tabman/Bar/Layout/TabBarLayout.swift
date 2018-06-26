//
//  TabBarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 26/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

public final class TabBarLayout: BarLayout {
    
    // MARK: Properties
    
    private let stackView = UIStackView()
    
    // MARK: Lifecycle
    
    public override func performLayout(in view: UIView) {
        super.performLayout(in: view)
    
        stackView.distribution = .fillEqually
        
        container.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(presentingView.snp.width)
        }
    }
    
    override func populate(with barButtons: [BarButton]) {
        barButtons.forEach({ stackView.addArrangedSubview($0) })
    }
    
    override func clear() {
        
    }
    
    override func barFocusRect(for position: CGFloat, capacity: Int) -> CGRect {
        return .zero
    }
}
