//
//  ContentViewScrollView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// UIScrollView with internally managed contentView.
internal class ContentViewScrollView: UIScrollView {
    
    // MARK: Types
    
    enum Dimension {
        case width
        case height
    }
    
    // MARK: Properties
    
    let contentView = UIView()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        
        self.addSubview(contentView)
        contentView.pinToSuperviewEdges()
    }
    
    // MARK: Layout
    
    func matchParent(_ parent: UIView, on dimension: UIView.Dimension) {
        switch dimension {
        case .height:
            contentView.match(.height, of: parent)
            
        case .width:
            contentView.match(.width, of: parent)
        }
    }
}
