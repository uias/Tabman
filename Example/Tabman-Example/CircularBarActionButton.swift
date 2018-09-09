//
//  CircularBarActionButton.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 08/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

final class CircularBarActionButton: UIControl {
    
    // MARK: Types
    
    enum Action {
        case add
        case delete
    }
    
    // MARK: Defaults
    
    private struct Defaults {
        static let circleSize = CGSize(width: 26, height: 26)
    }
    
    // MARK: Properties
    
    let action: Action
    private let shapeLayer = CAShapeLayer()
    private let iconLayer = CAShapeLayer()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 40.0, height: 40.0)
    }
    
    override var tintColor: UIColor! {
        didSet {
            shapeLayer.backgroundColor = tintColor.cgColor
        }
    }
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.alpha = self.isHighlighted ? 0.5 : 1.0
            }
        }
    }
    
    // MARK: Init
    
    init(action: Action) {
        self.action = action
        super.init(frame: .zero)
        initialize()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func initialize() {
        
        widthAnchor.constraint(equalTo: heightAnchor).isActive = true

        shapeLayer.backgroundColor = tintColor.cgColor
        iconLayer.fillRule = .evenOdd
        
        layer.addSublayer(shapeLayer)
        layer.mask = iconLayer
    }
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        superview?.layoutIfNeeded()
        
        shapeLayer.bounds.size = Defaults.circleSize
        shapeLayer.frame.origin = CGPoint(x: (self.bounds.size.width - Defaults.circleSize.width) / 2,
                                          y: (self.bounds.size.height - Defaults.circleSize.height) / 2)
        shapeLayer.cornerRadius = shapeLayer.bounds.size.width / 2
        
        let path = UIBezierPath(rect: shapeLayer.bounds)
        path.append(action.path(in: shapeLayer.bounds))
        iconLayer.path = path.cgPath
        
        iconLayer.frame = shapeLayer.frame
    }
}

private extension CircularBarActionButton.Action {
    
    func path(in frame: CGRect, width: CGFloat = 3.0) -> UIBezierPath {
        let inset = min(frame.size.height, frame.size.width) * 0.2
        switch self {
        case .add:
            return makePlusSignPath(in: frame, width: width, inset: inset)
            
        case .delete:
            return makeMinusSignPath(in: frame, width: width, inset: inset)
        }
    }
    
    private func makePlusSignPath(in frame: CGRect, width: CGFloat, inset: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: (frame.size.width / 2) - (width / 2),
                              y: inset))
        path.addLine(to: CGPoint(x: (frame.size.width / 2) + (width / 2),
                                 y: inset))
        path.addLine(to: CGPoint(x: (frame.size.width / 2) + (width / 2),
                                 y: (frame.size.height / 2) - (width / 2)))
        path.addLine(to: CGPoint(x: frame.size.width - inset,
                                 y: (frame.size.height / 2) - (width / 2)))
        path.addLine(to: CGPoint(x: frame.size.width - inset,
                                 y: (frame.size.height / 2) + (width / 2)))
        path.addLine(to: CGPoint(x: (frame.size.width / 2) + (width / 2),
                                 y: (frame.size.height / 2) + (width / 2)))
        path.addLine(to: CGPoint(x: (frame.size.width / 2) + (width / 2),
                                 y: frame.size.height - inset))
        path.addLine(to: CGPoint(x: (frame.size.width / 2) - (width / 2),
                                 y: frame.size.height - inset))
        path.addLine(to: CGPoint(x: (frame.size.width / 2) - (width / 2),
                                 y: (frame.size.height / 2) + (width / 2)))
        path.addLine(to: CGPoint(x: inset,
                                 y: (frame.size.height / 2) + (width / 2)))
        path.addLine(to: CGPoint(x: inset,
                                 y: (frame.size.height / 2) - (width / 2)))
        path.addLine(to: CGPoint(x: (frame.size.width / 2) - (width / 2),
                                 y: (frame.size.height / 2) - (width / 2)))
        path.close()
        return path
    }
    
    private func makeMinusSignPath(in frame: CGRect, width: CGFloat, inset: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: inset,
                              y: (frame.size.height / 2) - (width / 2)))
        path.addLine(to: CGPoint(x: frame.size.width - inset,
                                 y: (frame.size.height / 2) - (width / 2)))
        path.addLine(to: CGPoint(x: frame.size.width - inset,
                                 y: (frame.size.height / 2) + (width / 2)))
        path.addLine(to: CGPoint(x: inset,
                                 y: (frame.size.height / 2) + (width / 2)))
        path.close()
        return path
    }
}
