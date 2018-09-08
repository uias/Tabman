//
//  ExtendedAreaBarViewContainer.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 08/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Tabman

extension TabmanViewController {
    
    func addBarWithExtendedBackground(_ bar: Bar,
                                      dataSource: BarDataSource,
                                      location: BarLocation,
                                      backgroundStyle: BarBackground.Style) {
        switch location {
        case .custom:
            addBar(bar, dataSource: dataSource, at: location)
            
        case .top, .bottom:
            let container = ExtendedAreaBarViewContainer.added(to: self.view,
                                                               at: location,
                                                               topLayoutGuide: self.topLayoutGuide,
                                                               bottomLayoutGuide: self.bottomLayoutGuide)
            addBar(bar, dataSource: dataSource, at: .custom(view: container.barArea))
            container.background.style = backgroundStyle
        }
    }
}

private final class ExtendedAreaBarViewContainer: UIView {
    
    class func added(to view: UIView,
                     at location: TabmanViewController.BarLocation,
                     topLayoutGuide: UILayoutSupport,
                     bottomLayoutGuide: UILayoutSupport) -> ExtendedAreaBarViewContainer {
        return ExtendedAreaBarViewContainer(referenceView: view,
                                            location: location,
                                            topLayoutGuide: topLayoutGuide,
                                            bottomLayoutGuide: bottomLayoutGuide)
    }
    
    // MARK: Properties
    
    let background = BarBackground(style: .clear)
    let barArea = UIView()
    
    // MARK: Init
    
    private init(referenceView: UIView,
                 location: TabmanViewController.BarLocation,
                 topLayoutGuide: UILayoutSupport,
                 bottomLayoutGuide: UILayoutSupport) {
        super.init(frame: .zero)
        
        referenceView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        layout(in: referenceView,
               at: location,
               topLayoutGuide: topLayoutGuide,
               bottomLayoutGuide: bottomLayoutGuide)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("ExtendedAreaBarViewContainer does not support storyboards")
    }
    
    // MARK: Layout
    
    private func layout(in view: UIView,
                        at location: TabmanViewController.BarLocation,
                        topLayoutGuide: UILayoutSupport,
                        bottomLayoutGuide: UILayoutSupport) {
        
        if #available(iOS 11, *) {
            print(view.safeAreaInsets)
        }
        
        addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.topAnchor.constraint(equalTo: topAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        addSubview(barArea)
        barArea.translatesAutoresizingMaskIntoConstraints = false
        
        switch location {
        case .top:
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                topAnchor.constraint(equalTo: view.topAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            
            if #available(iOS 11, *) {
                NSLayoutConstraint.activate([
                    barArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    barArea.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    barArea.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    barArea.bottomAnchor.constraint(equalTo: bottomAnchor)
                    ])
            } else {
                NSLayoutConstraint.activate([
                    barArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    barArea.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                    barArea.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    barArea.bottomAnchor.constraint(equalTo: bottomAnchor)
                    ])
            }
            
        case .bottom:
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bottomAnchor.constraint(equalTo: view.bottomAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            
            if #available(iOS 11, *) {
                NSLayoutConstraint.activate([
                    barArea.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    barArea.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    barArea.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    barArea.topAnchor.constraint(equalTo: topAnchor)
                    ])
            } else {
                NSLayoutConstraint.activate([
                    barArea.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    barArea.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
                    barArea.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    barArea.topAnchor.constraint(equalTo: topAnchor)
                    ])
            }
            
        default:
            break
        }
    }
}
