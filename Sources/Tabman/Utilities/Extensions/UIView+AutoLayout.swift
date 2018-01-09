//
//  UIView+AutoLayout.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/01/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

// MARK: - AutoLayout helpers
internal extension UIView {
    
    enum Edge {
        case top
        case leading
        case bottom
        case trailing
        case left
        case right
    }
    
    enum Dimension {
        case width
        case height
    }
    
    @available (iOS 11, *)
    @discardableResult
    func pinToSafeArea(layoutGuide: UILayoutGuide) -> [NSLayoutConstraint] {
        return addConstraints { () -> [NSLayoutConstraint] in
            return [
                self.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
                self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
                self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
                self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
            ]
        }
    }
    
    @discardableResult
    func pinToSuperviewEdges() -> [NSLayoutConstraint] {
        guard let superview = self.superview else {
            fatalError("No superview for view \(self)")
        }
        
        return addConstraints { () -> [NSLayoutConstraint] in
            return [
                self.topAnchor.constraint(equalTo: superview.topAnchor),
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ]
        }
    }
    
    @discardableResult
    func pinToSuperviewEdge(_ edge: Edge, inset: CGFloat = 0.0) -> NSLayoutConstraint {
        guard let superview = self.superview else {
            fatalError("No superview for view \(self)")
        }
        
        let constraints = addConstraints { () -> [NSLayoutConstraint] in
            switch edge {
            case .top:
                return [self.topAnchor.constraint(equalTo: superview.topAnchor)]
            case .leading:
                return [self.leadingAnchor.constraint(equalTo: superview.leadingAnchor)]
            case .bottom:
                return [self.bottomAnchor.constraint(equalTo: superview.bottomAnchor)]
            case .trailing:
                return [self.trailingAnchor.constraint(equalTo: superview.trailingAnchor)]
            case .left:
                return [self.leftAnchor.constraint(equalTo: superview.leftAnchor)]
            case .right:
                return [self.rightAnchor.constraint(equalTo: superview.rightAnchor)]
            }
        }
        guard let constraint = constraints.first else {
            fatalError("Failed to add constraint for some reason")
        }
        
        constraint.constant = actualInset(for: edge, value: inset)
        return constraint
    }
    
    @discardableResult
    func match(_ dimension: Dimension, of view: UIView) -> NSLayoutConstraint {
        let constraints = addConstraints({ () -> [NSLayoutConstraint] in
            let attribute: NSLayoutAttribute = (dimension == .width) ? .width : .height
            return [NSLayoutConstraint(item: self, attribute: attribute,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: attribute,
                                       multiplier: 1.0,
                                       constant: 0.0)]
        })
        return constraints.first!
    }
    
    @discardableResult
    func set(_ dimension: Dimension, to value: CGFloat) -> NSLayoutConstraint {
        return addConstraints({ () -> [NSLayoutConstraint] in
            switch dimension {
            case .width:
                return [self.widthAnchor.constraint(equalToConstant: value)]
            case .height:
                return [self.heightAnchor.constraint(equalToConstant: value)]
            }
        }).first!
    }
    
    // MARK: Utilities
    
    private func prepareForAutoLayout(_ completion: () -> Void) {
        self.translatesAutoresizingMaskIntoConstraints = false
        completion()
    }
    
    @discardableResult
    private func addConstraints(_ completion: () -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        let constraints = completion()
        prepareForAutoLayout {
            NSLayoutConstraint.activate(constraints)
        }
        return constraints
    }
    
    private func actualInset(for edge: Edge, value: CGFloat) -> CGFloat {
        switch edge {
        case .trailing, .right, .bottom:
            return -value
            
        default:
            return value
        }
    }
}
