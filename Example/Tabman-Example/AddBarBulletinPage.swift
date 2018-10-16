//
//  AddBarBulletinPage.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 16/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import BLTNBoard
import Tabman

final class AddBarBulletinPage: BLTNPageItem {
    
    enum BarType: String, CaseIterable {
        case buttonBar = "ButtonBar"
        case tabBar = "TabBar"
        case lineBar = "LineBar"
    }
    
    // MARK: Properties
    
    var barTypeButtons = [UIButton: BarType]()
    
    // MARK: Init
    
    override init(title: String) {
        super.init(title: title)
        
        self.requiresCloseButton = false
    }
    
    // MARK: Lifecycle
    
    override func makeViewsUnderTitle(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        
        let scrollView = UIScrollView()
        scrollView.layer.cornerRadius = 18.0
        
        let scrollWrapper = interfaceBuilder.wrapView(scrollView,
                                                      width: nil,
                                                      height: 300,
                                                      position: .pinnedToEdges)
        
        let stack = interfaceBuilder.makeGroupStack(spacing: 16.0)
        scrollView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16.0),
            stack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: 16.0),
            stack.widthAnchor.constraint(equalTo: scrollWrapper.widthAnchor)
            ])
        
        for type in BarType.allCases {
            let label = makeTitleLabel(for: type)
            stack.addArrangedSubview(label)
            
            let button = makeBarOptionButton(for: type)
            button.addTarget(self, action: #selector(optionButtonPressed(_:)), for: .touchUpInside)
            barTypeButtons[button] = type
            stack.addArrangedSubview(button)
        }
        
        return [scrollWrapper]
    }
    
    override func tearDown() {
        super.tearDown()
        
        for button in barTypeButtons.keys {
            button.removeTarget(self, action: nil, for: .touchUpInside)
        }
    }
    
    // MARK: Actions
    
    @objc private func optionButtonPressed(_ sender: UIButton) {
        guard let type = barTypeButtons[sender] else {
            return
        }
        
        dump(type)
        manager?.dismissBulletin()
    }
}

private extension AddBarBulletinPage {
    
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
