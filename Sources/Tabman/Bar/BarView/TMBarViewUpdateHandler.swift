//
//  TMBarViewUpdateHandler.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/10/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

/// Handler for executing positional updates on bar view components.
///
/// Interprets and calculates appropriate values for updates dependent on component animation styles. All components which use
/// this must conform to `TMAnimateable`.
internal final class TMBarViewUpdateHandler<Layout: TMBarLayout, Button: TMBarButton, Indicator: TMBarIndicator> {
    
    /// Context which describes the current positional and focus values for the bar view.
    struct Context {
        
        let position: CGFloat
        let capacity: Int
        let direction: TMBarUpdateDirection
        
        let maxArea: CGRect
        let focusArea: CGRect
        let focusRect: TMBarViewFocusRect
        
        init(position: CGFloat,
             capacity: Int,
             direction: TMBarUpdateDirection,
             maxArea: CGRect,
             focusArea: CGRect,
             layoutDirection: UIUserInterfaceLayoutDirection) {
            self.position = position
            self.capacity = capacity
            self.direction = direction
            self.maxArea = maxArea
            self.focusArea = focusArea
            self.focusRect = TMBarViewFocusRect(rect: focusArea,
                                                maxRect: maxArea,
                                                at: position,
                                                capacity: capacity,
                                                layoutDirection: layoutDirection)
        }
    }
    
    private weak var barView: TMBarView<Layout, Button, Indicator>!
    private let position: CGFloat
    private let capacity: Int
    private let direction: TMBarUpdateDirection
    private let animation: TMAnimation
    
    private var focusArea: CGRect?
    
    // MARK: Init
    
    init(for barView: TMBarView<Layout, Button, Indicator>,
         at position: CGFloat,
         capacity: Int,
         direction: TMBarUpdateDirection,
         expectedAnimation: TMAnimation) {
        self.barView = barView
        self.position = position
        self.capacity = capacity
        self.direction = direction
        self.animation = expectedAnimation
    }
    
    /// Update a component.
    ///
    /// - Parameters:
    ///   - component: Component to update.
    ///   - action: Action closure with Component relevant context.
    func update(component: TMTransitionStyleable, action: @escaping (Context) -> Void) {
        let transitionStyle = component.transitionStyle
        let animation = makeAnimation(for: transitionStyle, expected: self.animation)

        let update = {
            let context = self.generateContext(for: transitionStyle)
            action(context)
        }
        
        if animation.isEnabled {
            UIView.animate(withDuration: animation.duration) {
                update()
            }
        } else {
            update()
        }
    }
    
    // MARK: Utility
    
    /// Generate a new context from an existing one, that takes account of animation style.
    ///
    /// - Parameters:
    ///   - transitionStyle: Animation style.
    /// - Returns: Context relevant for animation style.
    private func generateContext(for transitionStyle: TMTransitionStyle) -> Context {
        let focusArea = self.focusArea ?? makeFocusArea(for: position, capacity: capacity)
        return Context(position: makePosition(from: position, for: transitionStyle),
                       capacity: capacity,
                       direction: direction,
                       maxArea: CGRect(origin: .zero, size: barView.scrollView.contentSize),
                       focusArea: focusArea,
                       layoutDirection: UIView.userInterfaceLayoutDirection(for: barView.semanticContentAttribute))
    }
    
    /// Generate a new position dependending on animation style.
    ///
    /// - Parameters:
    ///   - position: Original position.
    ///   - transitionStyle: Animation style.
    /// - Returns: Position relevant for animation style.
    private func makePosition(from position: CGFloat, for animationStyle: TMTransitionStyle) -> CGFloat {
        switch animationStyle {
            
        case .snap, .none:
            return round(position)
            
        default:
            return position
        }
    }
    
    /// Make animation for an animation style.
    ///
    /// - Parameters:
    ///   - style: Style of animation.
    ///   - expected: Existing animation.
    /// - Returns: Animation relevant for style.
    private func makeAnimation(for style: TMTransitionStyle, expected: TMAnimation) -> TMAnimation {
        let isEnabled: Bool
        switch style {
        case .none:
            isEnabled = false
            
        case .progressive:
            isEnabled = expected.isEnabled
            
        case .snap:
            isEnabled = true
        }
        
        return TMAnimation(isEnabled: isEnabled, duration: expected.duration)
    }
    
    /// Make focus area.
    ///
    /// - Parameters:
    ///   - position: Position.
    ///   - capacity: Capacity.
    /// - Returns: Focus area.
    private func makeFocusArea(for position: CGFloat, capacity: Int) -> CGRect {
        let focusArea = barView.layoutGrid.convert(barView.layout.focusArea(for: position, capacity: capacity),
                                             from: barView.layout.view)
        self.focusArea = focusArea
        barView.layoutIfNeeded()
        return focusArea
    }
}
