//
//  SettingsBulletinPage.swift
//  Pageboy-Example
//
//  Created by Merrick Sapsford on 23/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import BLTNBoard
import Pageboy

protocol SettingsBulletinPageDelegate: class {
    
    func settingsBulletin(_ bulletin: SettingsBulletinPage, requiresPageInsertionAt index: PageboyViewController.PageIndex)
    
    func settingsBulletin(_ bulletin: SettingsBulletinPage, requiresPageDeletionAt index: PageboyViewController.PageIndex)
}

class SettingsBulletinPage: BLTNPageItem {
    
    // MARK: Options
    
    private enum Option {
        case modification
        case infiniteScrolling
        case autoScrolling
        case scrollEnabled
        
        var displayTitle: String {
            switch self {
            case .modification:
                return "⚒ Modify Pages"
            case .infiniteScrolling:
                return "🎡 Infinite Scrolling"
            case .autoScrolling:
                return "🏎 Auto Scrolling"
            case .scrollEnabled:
                return "👇 Scroll Enabled"
            }
        }
    }
    
    // MARK: Properties
    
    private weak var pageViewController: PageboyViewController!
    
    private var modificationOption: UIButton!
    private var infiniteScrollOption: UIButton!
    private var autoScrollOption: UIButton!
    private var scrollEnabledOption: UIButton!
    
    weak var delegate: SettingsBulletinPageDelegate?
    
    // MARK: Init
    
    init(title: String, pageViewController: PageboyViewController) {
        self.pageViewController = pageViewController
        super.init(title: title)
    }
    
    // MARK: Lifecycle
    
    override func tearDown() {
        modificationOption.removeTarget(self, action: nil, for: .touchUpInside)
        infiniteScrollOption.removeTarget(self, action: nil, for: .touchUpInside)
        autoScrollOption.removeTarget(self, action: nil, for: .touchUpInside)
        scrollEnabledOption.removeTarget(self, action: nil, for: .touchUpInside)
    }
    
    override func makeViewsUnderTitle(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        let stack = interfaceBuilder.makeGroupStack(spacing: 16.0)
        
        let modificationDetail = makeDetailLabel()
        modificationDetail.text = "⚠️ NEW: In Pageboy 3, you can insert and remove pages dynamically from the page view controller."
        stack.addArrangedSubview(modificationDetail)
        
        let modificationOption = makeOptionButton(for: .modification)
        modificationOption.addTarget(self, action: #selector(modificationOptionPressed(_:)), for: .touchUpInside)
        stack.addArrangedSubview(modificationOption)
        self.modificationOption = modificationOption
        
        let otherDetail = makeDetailLabel()
        otherDetail.text = "Other cool things..."
        stack.addArrangedSubview(otherDetail)
        
        let infiniteScrollOption = makeOptionToggleButton(for: .infiniteScrolling)
        infiniteScrollOption.addTarget(self, action: #selector(infiniteScrollToggled(_:)), for: .touchUpInside)
        infiniteScrollOption.isSelected = pageViewController.isInfiniteScrollEnabled
        stack.addArrangedSubview(infiniteScrollOption)
        self.infiniteScrollOption = infiniteScrollOption
        
        let autoScrollOption = makeOptionToggleButton(for: .autoScrolling)
        autoScrollOption.addTarget(self, action: #selector(autoScrollToggled(_:)), for: .touchUpInside)
        autoScrollOption.isSelected = pageViewController.autoScroller.isEnabled
        stack.addArrangedSubview(autoScrollOption)
        self.autoScrollOption = autoScrollOption
        
        let scrollOption = makeOptionToggleButton(for: .scrollEnabled)
        scrollOption.addTarget(self, action: #selector(scrollEnabledToggled(_:)), for: .touchUpInside)
        scrollOption.isSelected = pageViewController.isScrollEnabled
        stack.addArrangedSubview(scrollOption)
        self.scrollEnabledOption = scrollOption
        
        return [stack]
    }
    
    // MARK: Actions
    
    @objc private func modificationOptionPressed(_ sender: UIButton) {
        let modificationPage = PageModificationBulletinPage(title: Option.modification.displayTitle,
                                                            pageViewController: pageViewController)
        modificationPage.actionHandler = { [unowned self] item in
            item.manager?.dismissBulletin()
            switch modificationPage.modificationOption {
            case .insertion:
                self.delegate?.settingsBulletin(self, requiresPageInsertionAt: modificationPage.pageIndex)
            case .removal:
                self.delegate?.settingsBulletin(self, requiresPageDeletionAt: modificationPage.pageIndex)
            }
        }
        modificationPage.appearance = appearance
        next = modificationPage
        manager?.displayNextItem()
    }
    
    @objc private func infiniteScrollToggled(_ sender: UIButton) {
        pageViewController.isInfiniteScrollEnabled = sender.isSelected
    }
    
    @objc private func autoScrollToggled(_ sender: UIButton) {
        if sender.isSelected {
            pageViewController.autoScroller.enable()
        } else {
            pageViewController.autoScroller.disable()
        }
    }
    
    @objc private func scrollEnabledToggled(_ sender: UIButton) {
        pageViewController.isScrollEnabled = sender.isSelected
    }
}

extension SettingsBulletinPage {
    
    private func makeOptionButton(for option: Option) -> SettingsOptionButton {
        
        let button = SettingsOptionButton()
        button.setTitle(option.displayTitle, for: .normal)
        button.tintColor = appearance.actionButtonColor
        
        return button
    }
    
    private func makeOptionToggleButton(for option: Option) -> SettingsOptionButton {
        let button = makeOptionButton(for: option)
        button.isToggled = true
        return button
    }
    
    private func makeDetailLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }
}
