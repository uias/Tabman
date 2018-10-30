//
//  TMBarViewUpdateHandler.swift
//  Tabman
//
//  Created by Merrick Sapsford on 30/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal final class TMBarViewUpdateHandler<LayoutType: TMBarLayout, ButtonType: TMBarButton, IndicatorType: TMBarIndicator> {
    
    struct Context {
        
        let position: CGFloat
        let capacity: Int
        let direction: TMBarUpdateDirection
        
        let focusArea: CGRect
        let focusRect: TMBarViewFocusRect
        
        fileprivate let animation: TMBarAnimation
        
        init(position: CGFloat,
             capacity: Int,
             direction: TMBarUpdateDirection,
             focusArea: CGRect,
             animation: TMBarAnimation) {
            self.position = position
            self.capacity = capacity
            self.direction = direction
            self.focusArea = focusArea
            self.focusRect = TMBarViewFocusRect(rect: focusArea, at: position, capacity: capacity)
            self.animation = animation
        }
    }
    
    let barView: TMBarView<LayoutType, ButtonType, IndicatorType>
    let context: Context
    
    // MARK: Init
    
    init(for barView: TMBarView<LayoutType, ButtonType, IndicatorType>,
         at position: CGFloat,
         capacity: Int,
         direction: TMBarUpdateDirection,
         expectedAnimation: TMBarAnimation) {
        self.barView = barView
        
        let focusArea = barView.grid.convert(barView.layout.focusArea(for: position, capacity: capacity),
                                             from: barView.layout.view)
        self.context = Context(position: position,
                               capacity: capacity,
                               direction: direction,
                               focusArea: focusArea,
                               animation: expectedAnimation)
    }
    
    func update(component: TMAnimatable, action: @escaping (Context) -> Void) {
        let animationStyle = component.animationStyle
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
    
    private func generateContext(from context: Context, animationStyle: TMAnimationStyle) -> Context {
        let position = makePosition(from: context.position, for: animationStyle)
        let focusArea = makeFocusArea(for: position, capacity: context.capacity)
        let animation = makeAnimation(for: animationStyle, expected: context.animation)
        return Context(position: position,
                       capacity: context.capacity,
                       direction: context.direction,
                       focusArea: focusArea,
                       animation: animation)
    }
    
    private func makePosition(from position: CGFloat, for animationStyle: TMAnimationStyle) -> CGFloat {
        switch animationStyle {
            
        case .snap:
            return round(position)
            
        default:
            return position
        }
    }
    
    private func makeAnimation(for style: TMAnimationStyle, expected: TMBarAnimation) -> TMBarAnimation {
        let isEnabled: Bool
        switch style {
        case .none:
            isEnabled = false
            
        case .progressive:
            isEnabled = expected.isEnabled
            
        case .snap:
            isEnabled = true
        }
        
        return TMBarAnimation(isEnabled: isEnabled, duration: expected.duration)
    }
    
    private func makeFocusArea(for position: CGFloat, capacity: Int) -> CGRect {
        return barView.grid.convert(barView.layout.focusArea(for: position, capacity: capacity),
                                    from: barView.layout.view)
    }
}
