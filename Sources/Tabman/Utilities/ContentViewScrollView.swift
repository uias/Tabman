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
    
    //
    // MARK: Types
    //
    
    enum Dimension {
        case width
        case height
    }
    
    //
    // MARK: Properties
    //
    
    private(set) var contentView: UIView!
    
    //
    // MARK: Init
    //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initContentView()
    }
    
    init() {
        super.init(frame: .zero)
        self.initContentView()
    }
    
    private func initContentView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let contentView = UIView()
        self.addSubview(contentView)
        contentView.pinToSuperviewEdges()
        
        self.contentView = contentView
    }
    
    //
    // MARK: Layout
    //
    
    func matchParent(_ parent: UIView, on dimension: UIView.Dimension) {
        switch dimension {
        case .height:
            contentView.match(.height, of: parent)
            
        case .width:
            contentView.match(.width, of: parent)
        }
    }
}
