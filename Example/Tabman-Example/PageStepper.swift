//
//  PageStepper.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 24/07/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

class PageStepper: UIControl {
    
    private enum ButtonType {
        case negative
        case positive
    }
    
    // MARK: Properties
    
    private var negativeButton: UIButton!
    private var positiveButton: UIButton!
    private var statusLabel: UILabel!
    
    var numberOfPages: Int = 0 {
        didSet {
            currentPage = 0
        }
    }
    private(set) var currentPage: Int = 0 {
        didSet {
            update(for: currentPage)
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            negativeButton.tintColor = tintColor
            positiveButton.tintColor = tintColor
        }
    }
    
    // MARK: Init
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        
        let negativeButton = makeStepperButton(for: .negative)
        negativeButton.addTarget(self, action: #selector(negativeButtonPressed(_:)), for: .touchUpInside)
        addSubview(negativeButton)
        negativeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            negativeButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            negativeButton.topAnchor.constraint(equalTo: topAnchor),
            negativeButton.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        self.negativeButton = negativeButton
        
        let positiveButton = makeStepperButton(for: .positive)
        positiveButton.addTarget(self, action: #selector(positiveButtonPressed(_:)), for: .touchUpInside)
        addSubview(positiveButton)
        positiveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            positiveButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            positiveButton.topAnchor.constraint(equalTo: topAnchor),
            positiveButton.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        self.positiveButton = positiveButton
        
        let statusLabel = makeStatusLabel()
        addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusLabel.leadingAnchor.constraint(equalTo: negativeButton.trailingAnchor),
            statusLabel.topAnchor.constraint(equalTo: topAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: positiveButton.leadingAnchor)
            ])
        self.statusLabel = statusLabel
        
        update(for: currentPage)
    }
    
    // MARK: Actions
    
    @objc private func positiveButtonPressed(_ sender: UIButton) {
        let candidate = currentPage + 1
        guard candidate < numberOfPages else {
            return
        }
        currentPage = candidate
    }
    
    @objc private func negativeButtonPressed(_ sender: UIButton) {
        let candidate = currentPage - 1
        guard candidate >= 0 else {
            return
        }
        currentPage = candidate
    }
    
    // MARK: Updates
    
    private func update(for currentPage: Int) {
        statusLabel.text = "\(currentPage)"
    }
}

extension PageStepper {
    
    private func makeStepperButton(for type: ButtonType) -> UIButton {
        let button = SettingsOptionButton()
        
        switch type {
        case .positive:
            button.setImage(#imageLiteral(resourceName: "ic_plus"), for: .normal)
        case .negative:
            button.setImage(#imageLiteral(resourceName: "ic_minus"), for: .normal)
        }
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 10.0, left: 28.0, bottom: 10.0, right: 28.0)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        
        return button
    }
    
    private func makeStatusLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }
}
