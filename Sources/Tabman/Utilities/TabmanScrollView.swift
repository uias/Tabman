//
//  TabmanScrollView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 21/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout

internal class TabmanScrollView: UIScrollView {
    
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
        
        let contentView = UIView(forAutoLayout:())
        self.addSubview(contentView)
        contentView.autoPinEdge(toSuperviewEdge: .leading)
        contentView.autoPinEdge(toSuperviewEdge: .top)
        contentView.autoPinEdge(toSuperviewEdge: .bottom)
        contentView.autoPinEdge(toSuperviewEdge: .trailing)
        
        self.contentView = contentView
    }
    
    //
    // MARK: Layout
    //
    
    func match(parent: UIView, onDimension dimension: Dimension) {
        switch dimension {
        case .height:
            self.contentView.autoMatch(.height, to: .height, of: parent)
            
        case .width:
            self.contentView.autoMatch(.width, to: .width, of: parent)
        }
    }
}
