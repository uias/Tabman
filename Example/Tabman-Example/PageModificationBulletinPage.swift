//
//  PageModificationBulletinPage.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 23/07/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import BLTNBoard
import Pageboy

class PageModificationBulletinPage: BLTNPageItem {
    
    // MARK: Types
    
    enum ModificationOption: String, CaseIterable {
        case insertion = "Insert"
        case removal = "Remove"
    }
    
    // MARK: Properties
    
    private var pageStepper: PageStepper!
    private var optionSegmentedControl: UISegmentedControl!
    
    private weak var pageViewController: PageboyViewController!
    
    var modificationOption: ModificationOption {
        return ModificationOption.allCases[optionSegmentedControl.selectedSegmentIndex]
    }
    var pageIndex: Int {
        return pageStepper.currentPage
    }
    
    // MARK: Init
    
    init(title: String, pageViewController: PageboyViewController) {
        self.pageViewController = pageViewController
        super.init(title: title)
        
        self.actionButtonTitle = "Confirm"
        self.requiresCloseButton = false
    }
    
    // MARK: Lifecycle
    
    override func makeViewsUnderTitle(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        let stack = interfaceBuilder.makeGroupStack(spacing: 16.0)
        
        let intentPrompt = makePromptLabel()
        intentPrompt.text = "I want to"
        stack.addArrangedSubview(intentPrompt)
        
        let optionSegmentedControl = makeOptionSegmentedControl(for: ModificationOption.allCases)
        optionSegmentedControl.addTarget(self, action: #selector(modificationOptionUpdated(_:)), for: .valueChanged)
        stack.addArrangedSubview(optionSegmentedControl)
        self.optionSegmentedControl = optionSegmentedControl
        
        let indexPrompt = makePromptLabel()
        indexPrompt.text = "at page index"
        stack.addArrangedSubview(indexPrompt)
        
        let stepper = makePageStepper()
        stack.addArrangedSubview(stepper)
        self.pageStepper = stepper
        updateNumberOfPages(for: .insertion)
        
        return [stack]
    }
    
    // MARK: Actions
    
    @objc private func modificationOptionUpdated(_ sender: UISegmentedControl) {
        let option = ModificationOption.allCases[sender.selectedSegmentIndex]
        updateNumberOfPages(for: option)
    }
    
    private func updateNumberOfPages(for option: ModificationOption) {
        guard let pageCount = pageViewController.pageCount else {
            pageStepper.numberOfPages = 0
            return
        }
        
        switch option {
        case .insertion:
            pageStepper.numberOfPages = pageCount + 1
        case .removal:
            pageStepper.numberOfPages = pageCount
        }
    }
}

extension PageModificationBulletinPage {
    
    private func makePromptLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }
    
    private func makePageStepper() -> PageStepper {
        let stepper = PageStepper()
        stepper.tintColor = appearance.actionButtonColor
        return stepper
    }
    
    private func makeOptionSegmentedControl(for options: [ModificationOption]) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: options.map({ $0.rawValue }))
        
        segmentedControl.tintColor = appearance.actionButtonColor
        segmentedControl.selectedSegmentIndex = 0
        
        let constraint = segmentedControl.heightAnchor.constraint(equalToConstant: 40.0)
        constraint.isActive = true
        
        return segmentedControl
    }
}
