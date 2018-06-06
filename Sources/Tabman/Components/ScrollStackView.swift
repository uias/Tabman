//
//  ScrollStackView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

internal final class ScrollStackView: UIView {
    
    // MARK: Properties
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutComponents()
    }
}

// MARK: - Layout
private extension ScrollStackView {
    
    func layoutComponents() {
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(self.snp.height)
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
}
