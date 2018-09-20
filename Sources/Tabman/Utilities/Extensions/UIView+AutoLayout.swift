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
    
    enum Axis {
        case horizontal
        case vertical
    }
    
    @available (iOS 11, *)
    @discardableResult
    func pinToSafeArea(layoutGuide: UILayoutGuide) -> [NSLayoutConstraint] {
        return addConstraints(priority: .required, { () -> [NSLayoutConstraint] in
            return [
                self.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
                self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
                self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
                self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
            ]
        })
    }
    
    @discardableResult
    func pinToSuperviewEdges(priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        let superview = guardForSuperview()

        return addConstraints(priority: priority, { () -> [NSLayoutConstraint] in
            return [
                self.topAnchor.constraint(equalTo: superview.topAnchor),
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
            ]
        })
    }
    
    @discardableResult
    func pinToSuperviewEdge(_ edge: Edge, inset: CGFloat = 0.0, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let superview = guardForSuperview()        
        return pinEdge(edge, to: edge, of: superview, inset: inset, priority: priority)
    }
    
    @discardableResult
    func pinEdge(_ edge: Edge,
                 to otherEdge: Edge,
                 of view: UIView,
                 inset: CGFloat = 0.0,
                 priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        
        let constraints = addConstraints(priority: priority, { () -> [NSLayoutConstraint] in
            switch edge {
            case .top:
                return [self.topAnchor.constraint(equalTo: yAnchor(for: otherEdge, of: view))]
            case .leading:
                return [self.leadingAnchor.constraint(equalTo: xAnchor(for: otherEdge, of: view))]
            case .bottom:
                return [self.bottomAnchor.constraint(equalTo: yAnchor(for: otherEdge, of: view))]
            case .trailing:
                return [self.trailingAnchor.constraint(equalTo: xAnchor(for: otherEdge, of: view))]
            case .left:
                return [self.leftAnchor.constraint(equalTo: xAnchor(for: otherEdge, of: view))]
            case .right:
                return [self.rightAnchor.constraint(equalTo: xAnchor(for: otherEdge, of: view))]
            }
        })
        guard let constraint = constraints.first else {
            fatalError("Failed to add constraint for some reason")
        }
        
        constraint.constant = actualInset(for: edge, value: inset)
        return constraint
    }
    
    @discardableResult
    func match(_ dimension: Dimension, of view: UIView, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraints = addConstraints(priority: priority, { () -> [NSLayoutConstraint] in
            let attribute: NSLayoutConstraint.Attribute = (dimension == .width) ? .width : .height
            return [NSLayoutConstraint(item: self,
                                       attribute: attribute,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: attribute,
                                       multiplier: 1.0,
                                       constant: 0.0)]
        })
        return constraints.first!
    }
    
    @discardableResult
    func set(_ dimension: Dimension, to value: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        return addConstraints(priority: priority, { () -> [NSLayoutConstraint] in
            switch dimension {
            case .width:
                return [self.widthAnchor.constraint(equalToConstant: value)]
            case .height:
                return [self.heightAnchor.constraint(equalToConstant: value)]
            }
        }).first!
    }
    
    @discardableResult
    func alignToSuperviewAxis(_ axis: Axis, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let superview = guardForSuperview()

        return addConstraints(priority: priority, { () -> [NSLayoutConstraint] in
            let attribute: NSLayoutConstraint.Attribute = (axis == .horizontal) ? .centerY : .centerX
            return [NSLayoutConstraint(item: self,
                                       attribute: attribute,
                                       relatedBy: .equal,
                                       toItem: superview,
                                       attribute: attribute,
                                       multiplier: 1.0,
                                       constant: 0.0)]
        }).first!
    }
    
    func setContentCompressionResistance(for axis: Axis, to priority: UILayoutPriority) {
        let axis: NSLayoutConstraint.Axis = (axis == .horizontal) ? .horizontal : .vertical
        self.setContentCompressionResistancePriority(priority, for: axis)
    }
    
    // MARK: Utilities
    
    private func prepareForAutoLayout(_ completion: () -> Void) {
        self.translatesAutoresizingMaskIntoConstraints = false
        completion()
    }
    
    @discardableResult
    private func addConstraints(priority: UILayoutPriority, _ completion: () -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        let constraints = completion()
        constraints.forEach({ $0.priority = priority })
        prepareForAutoLayout {
            NSLayoutConstraint.activate(constraints)
        }
        return constraints
    }
    
    private func guardForSuperview() -> UIView {
        guard let superview = self.superview else {
            fatalError("No superview for view \(self)")
        }
        return superview
    }
    
    private func actualInset(for edge: Edge, value: CGFloat) -> CGFloat {
        switch edge {
        case .trailing, .right, .bottom:
            return -value
            
        default:
            return value
        }
    }
    
    private func yAnchor(for edge: Edge, of view: UIView) -> NSLayoutAnchor<NSLayoutYAxisAnchor> {
        switch edge {
        case .top:
            return view.topAnchor
        case .bottom:
            return view.bottomAnchor
        default:
            fatalError("Not a valid Y axis anchor")
        }
    }
    
    private func xAnchor(for edge: Edge, of view: UIView) -> NSLayoutAnchor<NSLayoutXAxisAnchor> {
        switch edge {
        case .leading:
            return view.leadingAnchor
        case .trailing:
            return view.trailingAnchor
        case .left:
            return view.leftAnchor
        case .right:
            return view.rightAnchor
        default:
            fatalError("Not a valid X axis anchor")
        }
    }
}
