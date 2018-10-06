//
//  TabmanViewController+BarBackgroundExtension.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Tabman

public extension TabmanViewController {
    
    /// Add a bar to the view controller with an extended background.
    ///
    /// This will will extend background view beyond the safe area to the edge of the view controller.
    /// Useful for placing a bar at the top or bottom of a view controller with no navigational view above
    /// or below it.
    ///
    /// - Note: It is recommended you ensure that your `Bar` does not have any visible background before adding it.
    /// - Remark: If you use a `.custom(view:)` location this will have no effect.
    ///
    /// - Parameters:
    ///   - bar: Bar to add.
    ///   - dataSource: Data source to use for the bar.
    ///   - location: Location of the bar in the view controller.
    ///   - backgroundStyle: Background style to apply (and extend).
    public func addBarWithExtendingBackground(_ bar: TMBar,
                                              dataSource: TMBarDataSource,
                                              location: BarLocation,
                                              backgroundStyle: TMBarBackgroundView.Style) {
        switch location {
        case .custom:
            addBar(bar, dataSource: dataSource, at: location)
            
        case .top, .bottom:
            let container = ExtendedAreaBarViewContainer.added(to: self.view,
                                                               at: location,
                                                               topLayoutGuide: self.topLayoutGuide,
                                                               bottomLayoutGuide: self.bottomLayoutGuide)
            addBar(bar, dataSource: dataSource, at: .custom(view: container.safeAreaView, layout: nil))
            
            let background = TMBarBackgroundView(style: backgroundStyle)
            background.translatesAutoresizingMaskIntoConstraints = false
            container.insertSubview(background, at: 0)
            NSLayoutConstraint.activate([
                background.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                background.topAnchor.constraint(equalTo: container.topAnchor),
                background.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                background.bottomAnchor.constraint(equalTo: container.bottomAnchor)
                ])
        }
    }
}

/// A view which pins itself to the edges of a view but provides a `safeAreaView` that is constrained to the bounds of the superview safe area.
///
/// Remark: Backwards compatible < iOS 11.
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
    
    let safeAreaView = UIView()
    
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
        
        addSubview(safeAreaView)
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        
        switch location {
        case .top:
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                topAnchor.constraint(equalTo: view.topAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            
            if #available(iOS 11, *) {
                NSLayoutConstraint.activate([
                    safeAreaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    safeAreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    safeAreaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    safeAreaView.bottomAnchor.constraint(equalTo: bottomAnchor)
                    ])
            } else {
                NSLayoutConstraint.activate([
                    safeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    safeAreaView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                    safeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    safeAreaView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
                    safeAreaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                    safeAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                    safeAreaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                    safeAreaView.topAnchor.constraint(equalTo: topAnchor)
                    ])
            } else {
                NSLayoutConstraint.activate([
                    safeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    safeAreaView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
                    safeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    safeAreaView.topAnchor.constraint(equalTo: topAnchor)
                    ])
            }
            
        default:
            break
        }
    }
}
