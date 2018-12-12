//
//  BarOptionButton.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 16/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
@testable import Tabman

private struct Defaults {
    static let barItemCount = 3
}

class BarOptionButton: UIButton {
    
    // MARK: Properties
    
    let bar: TMBar
    private weak var dataSource: TMBarDataSource!

    let barContainer = UIView()
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.25) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
            }
        }
    }
    
    
    override var tintColor: UIColor! {
        didSet {
            layer.borderColor = tintColor.cgColor
        }
    }
    
    // MARK: Init
    
    init(bar: TMBar, dataSource: TMBarDataSource) {
        self.bar = bar
        self.dataSource = dataSource
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    private func initialize() {
        
        addSubview(barContainer)
        barContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            barContainer.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            trailingAnchor.constraint(equalTo: barContainer.trailingAnchor, constant: 20.0),
            bottomAnchor.constraint(equalTo: barContainer.bottomAnchor, constant: 12.0)
            ])
        
        let barView = bar as! UIView
        barContainer.addSubview(barView)
        barView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barView.leadingAnchor.constraint(equalTo: barContainer.leadingAnchor),
            barView.topAnchor.constraint(equalTo: barContainer.topAnchor),
            barView.trailingAnchor.constraint(equalTo: barContainer.trailingAnchor),
            barView.bottomAnchor.constraint(equalTo: barContainer.bottomAnchor)
            ])
        
        bar.dataSource = dataSource
        bar.reloadData(at: 0 ... Defaults.barItemCount - 1,
                       context: .full)
        
        barContainer.isUserInteractionEnabled = false
        
        layer.borderColor = tintColor.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 12.0
        
        backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
    }
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bar.update(for: 0.0,
                   capacity: Defaults.barItemCount,
                   direction: .none,
                   animation: TMAnimation(isEnabled: false, duration: 0.0))
    }
}
