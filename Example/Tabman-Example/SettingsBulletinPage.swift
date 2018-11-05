//
//  SettingsBulletinPage.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 23/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import BLTNBoard
import Tabman
import Pageboy

protocol SettingsBulletinPageDelegate: class {
    
    func settingsBulletin(_ bulletin: SettingsBulletinPage, requiresPageInsertionAt index: PageboyViewController.PageIndex)
    
    func settingsBulletin(_ bulletin: SettingsBulletinPage, requiresPageDeletionAt index: PageboyViewController.PageIndex)
}

class SettingsBulletinPage: BLTNPageItem {
    
    // MARK: Options
    
    private enum Option {
        case addBar
        case removeBar
        case modification
        case infiniteScrolling
        
        var displayTitle: String {
            switch self {
            case .addBar:
                return "Add new Bar"
            case .removeBar:
                return "Remove a Bar"
            case .modification:
                return "Modify Pages"
            case .infiniteScrolling:
                return "Infinite Scrolling"
            }
        }
        
        var emoji: String {
            switch self {
            case .addBar:
                return "⚡️"
            case .removeBar:
                return "⛔️"
            case .modification:
                return "⚒"
            case .infiniteScrolling:
                return "🎡"
            }
        }
    }
    
    // MARK: Properties
    
    private weak var tabViewController: TabmanViewController!
    private weak var barDataSource: TMBarDataSource!
    
    private var addButtonOption: UIButton!
    private var removeButtonOption: UIButton!
    private var modificationOption: UIButton!
    private var infiniteScrollOption: UIButton!
    
    weak var delegate: SettingsBulletinPageDelegate?
    
    // MARK: Init
    
    init(title: String,
         tabViewController: TabmanViewController,
         barDataSource: TMBarDataSource) {
        self.tabViewController = tabViewController
        self.barDataSource = barDataSource
        super.init(title: title)
    }
    
    // MARK: Lifecycle
    
    override func tearDown() {
        addButtonOption.removeTarget(self, action: nil, for: .touchUpInside)
        removeButtonOption.removeTarget(self, action: nil, for: .touchUpInside)
        modificationOption.removeTarget(self, action: nil, for: .touchUpInside)
        infiniteScrollOption.removeTarget(self, action: nil, for: .touchUpInside)
    }
    
    override func makeViewsUnderTitle(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        let stack = interfaceBuilder.makeGroupStack(spacing: 16.0)
        
        let addBarOption = makeOptionButton(for: .addBar)
        addBarOption.addTarget(self, action: #selector(addBarOptionPressed(_:)), for: .touchUpInside)
        stack.addArrangedSubview(addBarOption)
        self.addButtonOption = addBarOption
        
        let removeBarOption = makeOptionButton(for: .removeBar)
        removeBarOption.addTarget(self, action: #selector(removeBarOptionPressed(_:)), for: .touchUpInside)
        stack.addArrangedSubview(removeBarOption)
        self.removeButtonOption = removeBarOption
        
        let pageboyDetail = makeDetailLabel()
        pageboyDetail.text = "Pageboy Settings"
        stack.addArrangedSubview(pageboyDetail)
        
        let modificationOption = makeOptionButton(for: .modification)
        modificationOption.addTarget(self, action: #selector(modificationOptionPressed(_:)), for: .touchUpInside)
        stack.addArrangedSubview(modificationOption)
        self.modificationOption = modificationOption
        
        let infiniteScrollOption = makeOptionToggleButton(for: .infiniteScrolling)
        infiniteScrollOption.addTarget(self, action: #selector(infiniteScrollToggled(_:)), for: .touchUpInside)
        infiniteScrollOption.isSelected = tabViewController.isInfiniteScrollEnabled
        stack.addArrangedSubview(infiniteScrollOption)
        self.infiniteScrollOption = infiniteScrollOption
        
        return [stack]
    }
    
    // MARK: Actions
    
    @objc private func addBarOptionPressed(_ sender: UIButton) {
        let addOptionPage = AddBarBulletinPage(title: Option.addBar.displayTitle,
                                               tabViewController: self.tabViewController,
                                               barDataSource: self.barDataSource)
        
        addOptionPage.appearance = appearance
        next = addOptionPage
        manager?.displayNextItem()
    }
    
    @objc private func removeBarOptionPressed(_ sender: UIButton) {
        manager?.dismissBulletin()
        tabViewController.startInteractiveDeletion()
    }
    
    @objc private func modificationOptionPressed(_ sender: UIButton) {
        let modificationPage = PageModificationBulletinPage(title: Option.modification.displayTitle,
                                                            pageViewController: tabViewController)
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
        tabViewController.isInfiniteScrollEnabled = sender.isSelected
    }
    
    @objc private func autoScrollToggled(_ sender: UIButton) {
        if sender.isSelected {
            tabViewController.autoScroller.enable()
        } else {
            tabViewController.autoScroller.disable()
        }
    }
    
    @objc private func scrollEnabledToggled(_ sender: UIButton) {
        tabViewController.isScrollEnabled = sender.isSelected
    }
}

extension SettingsBulletinPage {
    
    private func makeOptionButton(for option: Option) -> SettingsOptionButton {
        
        let button = SettingsOptionButton()
        button.setTitle("\(option.emoji) \(option.displayTitle)", for: .normal)
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
