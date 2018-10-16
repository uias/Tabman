//
//  AddPageBulletinPage.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 16/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import BLTNBoard
import Tabman

final class AddPageBulletinPage: BLTNPageItem {
    
    enum BarType: String, CaseIterable {
        case buttonBar = "ButtonBar"
        case tabBar = "TabBar"
        case lineBar = "LineBar"
    }
    
    // MARK: Init
    
    override init(title: String) {
        super.init(title: title)
        
        self.requiresCloseButton = false
    }
    
    // MARK: Lifecycle
    
    override func makeViewsUnderTitle(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        let stack = interfaceBuilder.makeGroupStack(spacing: 16.0)
        
        for type in BarType.allCases {
            let label = makeTitleLabel(for: type)
            stack.addArrangedSubview(label)
            
            let button = makeBarOptionButton(for: type)
            stack.addArrangedSubview(button)
        }
        
        return [stack]
    }
}

private extension AddPageBulletinPage {
    
    func makeTitleLabel(for type: BarType) -> UILabel {
        let label = UILabel()
        label.text = type.rawValue
        return label
    }
    
    func makeBarOptionButton(for type: BarType) -> UIButton {
        let button: UIButton
        switch type {
        case .buttonBar:
            button = BarOptionButton<TMBar.ButtonBar>()
        case .tabBar:
            button = BarOptionButton<TMBar.TabBar>()
        case .lineBar:
            button = BarOptionButton<TMBar.LineBar>()
        }
        
        return button
    }
}
