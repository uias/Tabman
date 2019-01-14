//
//  SettingsOptionButton.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 23/07/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

class SettingsOptionButton: UIButton {
    
    // MARK: Properties
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.alpha = self.isHighlighted ? 0.5 : 1.0
            }
        }
    }
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? tintColor : .clear
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            layer.borderColor = tintColor.cgColor
            setTitleColor(tintColor, for: .normal)
        }
    }
    
    var isToggled: Bool = false
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init()")
    }
    
    // MARK: Configuration
    
    private func configure() {
        
        layer.cornerRadius = 12.0
        layer.borderWidth = 2.0
        
        contentHorizontalAlignment = .center
        
        let heightConstraint = heightAnchor.constraint(equalToConstant: 54.0)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        
        layer.borderColor = tintColor.cgColor
        setTitleColor(tintColor, for: .normal)
        setTitleColor(.white, for: .selected)
        
        addTarget(self, action: #selector(updateToggleState(_:)), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc private func updateToggleState(_ sender: SettingsOptionButton) {
        guard isToggled else {
            return
        }
        
        self.isSelected = !isSelected
    }
}
