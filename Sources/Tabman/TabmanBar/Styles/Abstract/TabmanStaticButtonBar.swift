//
//  TabmanStaticButtonBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 23/03/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit
import PureLayout
import Pageboy


extension UIButton {
    func alignVertical(spacing: CGFloat = 6.0) {
        guard let imageSize = self.imageView?.image?.size,
            let text = self.titleLabel?.text,
            let font = self.titleLabel?.font
            else { return }
        
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [NSAttributedStringKey.font: font])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
    }
}

/// Abstract class for static (non-scrolling) button bars.
internal class TabmanStaticButtonBar: TabmanButtonBar {

    //
    // MARK: Properties
    //
    
    public override var interItemSpacing: CGFloat {
        didSet {
            let insets = UIEdgeInsets(top: 0.0, left: interItemSpacing / 2, bottom: 0.0, right: interItemSpacing / 2)
            self.updateButtons(withContext: .all) { (button) in
               
                if self.appearance.layout.itemAlignment == .horizontal {
                    button.titleEdgeInsets = insets
                    button.imageEdgeInsets = insets
                }
                else {
                    button.alignVertical(spacing: interItemSpacing / 2)
                }
            }
        }
    }
    
    override var color: UIColor {
        didSet {
            guard color != oldValue else {
                return
            }
            
            self.updateButtons(withContext: .unselected) { (button) in
                button.tintColor = color
                button.setTitleColor(color, for: .normal)
            }
        }
    }
    
    override var selectedColor: UIColor {
        didSet {
            guard selectedColor != oldValue else {
                return
            }
            
            self.updateButtons(withContext: .target) { (button) in
                button.tintColor = selectedColor
                button.setTitleColor(selectedColor, for: .normal)
            }
        }
    }
    
    override public var itemCountLimit: Int? {
        return 5
    }
    
    //
    // MARK: Lifecycle
    //
    
    override func defaultIndicatorStyle() -> TabmanIndicator.Style {
        return .line
    }
    
    override func indicatorTransitionType() -> TabmanIndicatorTransition.Type? {
        return TabmanStaticBarIndicatorTransition.self
    }
    
    //
    // MARK: TabmanBar Lifecycle
    //
    
    public override func add(indicator: TabmanIndicator, to contentView: UIView) {
        
        contentView.addSubview(indicator)
        indicator.autoPinEdge(toSuperviewEdge: .bottom)
        self.indicatorLeftMargin = indicator.autoPinEdge(toSuperviewEdge: .leading)
        self.indicatorWidth = indicator.autoSetDimension(.width, toSize: 0.0)
    }
    
    //
    // MARK: Content
    //
    
    func addAndLayoutBarButtons(toView view: UIView,
                                items: [TabmanBar.Item],
                                customize: TabmanButtonBarItemCustomize) {
        let insets = UIEdgeInsets(top: 0.0,
                                  left: self.interItemSpacing / 2,
                                  bottom: 0.0,
                                  right: self.interItemSpacing / 2)
        self.addBarButtons(toView: view, items: items) { (button, previousButton) in
            
            button.tintColor = self.color
            button.setTitleColor(self.color, for: .normal)
            button.setTitleColor(self.color.withAlphaComponent(0.3), for: .highlighted)
            button.titleEdgeInsets = insets
            button.imageEdgeInsets = insets
            
            if let previousButton = previousButton {
                button.autoMatch(.width, to: .width, of: previousButton)
            }
            
            customize(button, previousButton)
        }
    }
}
