//
//  AddBarBulletinPage.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 16/10/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit
import BLTNBoard
import Tabman

final class AddBarBulletinPage: BLTNPageItem {
    
    enum BarType: String, CaseIterable {
        case buttonBar = "ButtonBar"
        case tabBar = "TabBar"
        case lineBar = "LineBar"
        case blockButtonBar = "BlockButtonBar"
    }
    
    // MARK: Properties
    
    private weak var tabViewController: TabmanViewController!
    private weak var barDataSource: TMBarDataSource!
    
    var barTypeButtons = [UIButton: BarType]()
    
    // MARK: Init
    
    init(title: String,
         tabViewController: TabmanViewController,
         barDataSource: TMBarDataSource) {
        self.tabViewController = tabViewController
        self.barDataSource = barDataSource
        super.init(title: title)
        
        self.requiresCloseButton = false
    }
    
    // MARK: Lifecycle
    
    override func makeViewsUnderTitle(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        
        let scrollView = FadingScrollView()
        scrollView.showsVerticalScrollIndicator = false
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
    
    @objc private func optionButtonPressed(_ sender: BarOptionButton) {
        guard let type = barTypeButtons[sender] else {
            return
        }
        let barView = sender.bar as! UIView
        tabViewController.addBarInteractively(makeBar(for: type),
                                              dataSource: barDataSource,
                                              estimatedBarSize: barView.bounds.size)
        
        manager?.dismissBulletin()
    }
}

private extension AddBarBulletinPage {
    
    func makeTitleLabel(for type: BarType) -> UILabel {
        let label = UILabel()
        label.text = type.rawValue
        label.textColor = appearance.actionButtonColor
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        return label
    }
    
    func makeBarOptionButton(for type: BarType) -> BarOptionButton {
        let button = BarOptionButton(bar: makeBar(for: type), dataSource: barDataSource)
        button.tintColor = appearance.actionButtonColor
        return button
    }
}

private extension AddBarBulletinPage {
    
    func makeBar(for type: BarType) -> TMBar {
        switch type {
        case .buttonBar:
            return makeButtonBar()
        case .tabBar:
            return makeTabBar()
        case .lineBar:
            return makeLineBar()
        case .blockButtonBar:
            return makeBlockButtonBar()
        }
    }
    
    private func makeButtonBar() -> TMBar {
        let bar = TMBar.ButtonBar()
        bar.indicator.tintColor = appearance.actionButtonColor
        bar.buttons.customize { (button) in
            button.selectedTintColor = self.appearance.actionButtonColor
        }
        return bar
    }
    
    private func makeTabBar() -> TMBar {
        let bar = TMBar.TabBar()
        bar.buttons.customize { (button) in
            button.selectedTintColor = self.appearance.actionButtonColor
        }
        return bar
    }
    
    private func makeLineBar() -> TMBar {
        let bar = TMBar.LineBar()
        bar.indicator.tintColor = appearance.actionButtonColor
        return bar
    }
    
    private func makeBlockButtonBar() -> TMBar {
        let bar = TMBarView<TMHorizontalBarLayout, TMLabelBarButton, TMBlockBarIndicator>()
        bar.indicator.backgroundColor = appearance.actionButtonColor
        bar.indicator.cornerStyle = .rounded
        bar.layout.contentInset = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
        bar.buttons.customize { (button) in
            button.tintColor = .black
            button.selectedTintColor = .white
            button.contentInset.left = 8.0
            button.contentInset.right = 8.0
        }
        return bar
    }
}
