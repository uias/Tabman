//
//  SeparatorView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/03/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal class SeparatorView: UIView {
    
    // MARK: Properties
    
    private var leftPinConstraint: NSLayoutConstraint?
    private var rightPinConstraint: NSLayoutConstraint?
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.0, height: height)
    }
    
    override var tintColor: UIColor! {
        didSet {
            self.color = tintColor
        }
    }
    /// The color of the separator.
    var color: UIColor = .clear {
        didSet {
            self.backgroundColor = color
        }
    }
    /// The height of the separator.
    var height: CGFloat = 0.5 {
        didSet {
            invalidateIntrinsicContentSize()
            superview?.setNeedsLayout()
            superview?.layoutIfNeeded()
        }
    }
    /// The distance to inset the separator from it's superview (X-axis only).
    var edgeInsets: UIEdgeInsets = .zero {
        didSet {
            leftPinConstraint?.constant = edgeInsets.left
            rightPinConstraint?.constant = -edgeInsets.right
            superview?.layoutIfNeeded()
        }
    }
    
    // MARK: Init
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initSeparator()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSeparator()
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    private func initSeparator() {
        
        self.backgroundColor = self.color
    }
    
    // MARK: Layout
    
    func addAsSubview(to parent: UIView) {
        
        parent.addSubview(self)
        pinToSuperviewEdge(.bottom)
        leftPinConstraint = pinToSuperviewEdge(.leading)
        rightPinConstraint = pinToSuperviewEdge(.right)
    }
}
