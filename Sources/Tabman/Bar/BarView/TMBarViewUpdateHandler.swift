//
//  TMBarViewUpdateHandler.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// Handler for executing positional updates on bar view components.
///
/// Interprets and calculates appropriate values for updates dependent on component animation styles. All components which use
/// this must conform to `TMAnimateable`.
internal final class TMBarViewUpdateHandler<LayoutType: TMBarLayout, ButtonType: TMBarButton, IndicatorType: TMBarIndicator> {
    
    /// Context which describes the current positional and focus values for the bar view.
    struct Context {
        
        let position: CGFloat
        let capacity: Int
        let direction: TMBarUpdateDirection
        
        let focusArea: CGRect
        let focusRect: TMBarViewFocusRect
        
        fileprivate let animation: TMAnimation
        
        init(position: CGFloat,
             capacity: Int,
             direction: TMBarUpdateDirection,
             focusArea: CGRect,
             animation: TMAnimation) {
            self.position = position
            self.capacity = capacity
            self.direction = direction
            self.focusArea = focusArea
            self.focusRect = TMBarViewFocusRect(rect: focusArea, at: position, capacity: capacity)
            self.animation = animation
        }
    }
    
    private weak var barView: TMBarView<LayoutType, ButtonType, IndicatorType>!
    let context: Context
    
    // MARK: Init
    
    init(for barView: TMBarView<LayoutType, ButtonType, IndicatorType>,
         at position: CGFloat,
         capacity: Int,
         direction: TMBarUpdateDirection,
         expectedAnimation: TMAnimation) {
        self.barView = barView
        
        let focusArea = barView.grid.convert(barView.layout.focusArea(for: position, capacity: capacity),
                                             from: barView.layout.view)
        self.context = Context(position: position,
                               capacity: capacity,
                               direction: direction,
                               focusArea: focusArea,
                               animation: expectedAnimation)
    }
    
    /// Update a component.
    ///
    /// - Parameters:
    ///   - component: Component to update.
    ///   - action: Action closure with Component relevant context.
    func update(component: TMTransitionStyleable, action: @escaping (Context) -> Void) {
        let animationStyle = component.transitionStyle
        let context = generateContext(from: self.context, animationStyle: animationStyle)
        
        if context.animation.isEnabled {
            UIView.animate(withDuration: context.animation.duration) {
                action(context)
            }
        } else {
            action(context)
        }
    }
    
    // MARK: Utility
    
    /// Generate a new context from an existing one, that takes account of animation style.
    ///
    /// - Parameters:
    ///   - context: Original context.
    ///   - transitionStyle: Animation style.
    /// - Returns: Context relevant for animation style.
    private func generateContext(from context: Context, animationStyle: TMTransitionStyle) -> Context {
        let position = makePosition(from: context.position, for: animationStyle)
        let focusArea = makeFocusArea(for: position, capacity: context.capacity)
        let animation = makeAnimation(for: animationStyle, expected: context.animation)
        return Context(position: position,
                       capacity: context.capacity,
                       direction: context.direction,
                       focusArea: focusArea,
                       animation: animation)
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
        return barView.grid.convert(barView.layout.focusArea(for: position, capacity: capacity),
                                    from: barView.layout.view)
    }
}
