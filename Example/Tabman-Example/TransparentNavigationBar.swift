//
//  TransparentNavigationBar.swift
//  Pageboy-Example
//
//  Created by Merrick Sapsford on 15/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class TransparentNavigationBar: UINavigationBar {
    
    private var separatorView: UIView!
    
    override var tintColor: UIColor! {
        didSet {
            guard self.separatorView != nil else {
                return
            }
            
            self.separatorView.backgroundColor = tintColor.withAlphaComponent(0.8)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.white,
                                    NSAttributedStringKey.font.rawValue : UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.regular)]
        self.tintColor = UIColor.white.withAlphaComponent(0.7)
        
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        
        let separatorView = UIView()
        separatorView.backgroundColor = self.tintColor.withAlphaComponent(0.8)
        self.addSubview(separatorView)
        separatorView.frame = CGRect(x: 0.0,
                                     y: self.bounds.size.height - 1.0,
                                     width: self.bounds.size.width, height: 0.5)
        self.separatorView = separatorView
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard self.separatorView != nil else {
            return
        }
        
        self.separatorView.frame = CGRect(x: 0.0,
                                          y: self.bounds.size.height - 1.0,
                                          width: self.bounds.size.width, height: 0.5)
    }
    
}
