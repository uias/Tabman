//
//  TransparentNavigationBar.swift
//  Pageboy-Example
//
//  Created by Merrick Sapsford on 15/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
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

        var titleTextAttributes: [NSAttributedStringKey : Any] = [.foregroundColor : UIColor.white]
        if #available(iOS 8.2, *) {
            titleTextAttributes[.font] = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.regular)
        }
        self.titleTextAttributes = titleTextAttributes

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
