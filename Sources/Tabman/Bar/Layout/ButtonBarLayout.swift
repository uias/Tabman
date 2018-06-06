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
    
    // MARK: Properties
    
    private let stackView = ScrollStackView()
    
    // MARK: Layout
    
    public override func performLayout(in view: UIView) {
        super.performLayout(in: view)
        
        container.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        stackView.spacing = 16.0
        for _ in 0 ..< 25 {
            let view = UIView()
            view.backgroundColor = .blue
            view.snp.makeConstraints { (make) in
                make.width.equalTo(70)
                make.height.equalTo(50)
            }
            stackView.addArrangedSubview(view)
        }
    }
    
    public func test() {
        
    }
}
