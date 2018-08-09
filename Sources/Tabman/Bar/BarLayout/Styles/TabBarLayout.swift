//
//  TabBarLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 26/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

public final class TabBarLayout: BarLayout {
    
    // MARK: Properties
    
    private let stackView = UIStackView()

    public override var contentMode: BarLayout.ContentMode {
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    public override func insert(buttons: [BarButton], at index: Int) {
        var currentIndex = index
        for button in buttons {
            if index >= stackView.arrangedSubviews.count { // just add
                stackView.addArrangedSubview(button)
            } else {
                stackView.insertArrangedSubview(button, at: currentIndex)
            }
            currentIndex += 1
        }
    }
    
    public override func remove(buttons: [BarButton]) {
        for button in buttons {
            stackView.removeArrangedSubview(button)
        }
    }
    
    public override func barFocusRect(for position: CGFloat, capacity: Int) -> CGRect {
        return .zero
    }
}
