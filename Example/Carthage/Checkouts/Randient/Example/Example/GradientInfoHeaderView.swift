//
//  GradientInfoHeaderView.swift
//  Example
//
//  Created by Merrick Sapsford on 18/09/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

@IBDesignable class GradientInfoHeaderView: UIView {
    
    private let maskLayer = CAShapeLayer()
    @IBOutlet private(set) weak var nameLabel: UILabel!
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        layer.mask = maskLayer
    }
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        maskLayer.frame = self.bounds
        maskLayer.path = UIBezierPath(roundedRect: self.bounds,
                                      byRoundingCorners: [.bottomLeft, .bottomRight],
                                      cornerRadii: CGSize(width: 32, height: 32)).cgPath
    }
}

extension GradientInfoHeaderView: Themeable {
    
    func applyTheme(_ theme: Theme) {
        switch theme {
        case .light:
            backgroundColor = UIColor.white.withAlphaComponent(0.8)
            nameLabel.textColor = .black
        case .dark:
            backgroundColor = UIColor.black.withAlphaComponent(0.8)
            nameLabel.textColor = .white
        }
    }
}
