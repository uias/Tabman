//
//  TabmanScrollingButtonBar.swift
//  Tabman
//
//  Created by Merrick Sapsford on 17/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Pageboy

/// A bar with scrolling buttons and line indicator.
///
/// Akin to Android ViewPager etc.
internal class TabmanScrollingButtonBar: TabmanButtonBar {

    // MARK: Properties

    internal var scrollView: ContentViewScrollView = {
        let scrollView = ContentViewScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    internal var fadeGradientLayer: CAGradientLayer?

    private var itemMinimumWidthConstraints: [NSLayoutConstraint]?

    /// Whether scroll is enabled on the bar.
    public var isScrollEnabled: Bool {
        set(isScrollEnabled) {
            guard isScrollEnabled != self.scrollView.isScrollEnabled else {
                return
            }

            self.scrollView.isScrollEnabled = isScrollEnabled
            UIView.animate(withDuration: 0.3, animations: { // reset scroll position
                self.transitionStore?.indicatorTransition(forBar: self)?.updateForCurrentPosition()
            })
        }
        get {
            return self.scrollView.isScrollEnabled
        }
    }

    override var color: UIColor {
        didSet {
            guard color != oldValue else {
                return
            }

            self.updateButtons(withContext: .unselected, update: { button in
                button.setTitleColor(color, for: .normal)
                button.setTitleColor(color.withAlphaComponent(0.3), for: .highlighted)
                button.tintColor = color
            })
        }
    }
    override var selectedColor: UIColor {
        didSet {
            guard selectedColor != oldValue else {
                return
            }

            self.focussedButton?.setTitleColor(selectedColor, for: .normal)
            self.focussedButton?.tintColor = selectedColor
        }
    }

    // MARK: Lifecycle

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.fadeGradientLayer?.frame = self.bounds

        self.transitionStore?.indicatorTransition(forBar: self)?.updateForCurrentPosition()
    }

    public override func defaultIndicatorStyle() -> TabmanIndicator.Style {
        return .line
    }

    override func indicatorTransitionType() -> TabmanIndicatorTransition.Type? {
        return TabmanScrollingBarIndicatorTransition.self
    }

    // MARK: TabmanBar Lifecycle

    public override func construct(in contentView: UIView, for items: [TabmanBar.Item]) {
        super.construct(in: contentView, for: items)

        // add scroll view
        self.contentView.addSubview(scrollView)
        scrollView.pinToSuperviewEdges()
        scrollView.matchParent(self, on: .height)
        scrollView.contentView.removeAllSubviews()
        scrollView.isScrollEnabled = self.appearance.interaction.isScrollEnabled ?? false

        var itemMinimumWidthConstraints = [NSLayoutConstraint]()
        self.addBarButtons(toView: self.scrollView.contentView, items: items)
        { (button, _) in
            self.buttons.append(button)

            button.setTitleColor(self.color, for: .normal)
            button.setTitleColor(self.color.withAlphaComponent(0.3), for: .highlighted)
            button.addTarget(self, action: #selector(tabButtonPressed(_:)), for: .touchUpInside)

            let defaultAppearance = TabmanBar.Appearance.defaultAppearance
            // add a minimum width constraint to button
            let minimumItemWidth = self.appearance.layout.minimumItemWidth ?? defaultAppearance.layout.minimumItemWidth!
            let minWidthConstraint = NSLayoutConstraint(item: button,
                                                        attribute: .width,
                                                        relatedBy: .greaterThanOrEqual,
                                                        toItem: nil,
                                                        attribute: .notAnAttribute,
                                                        multiplier: 1.0,
                                                        constant: minimumItemWidth)
            itemMinimumWidthConstraints.append(minWidthConstraint)
            button.addConstraint(minWidthConstraint)
        }

        self.itemMinimumWidthConstraints = itemMinimumWidthConstraints
        self.scrollView.layoutIfNeeded()
    }

    public override func add(indicator: TabmanIndicator, to contentView: UIView) {

        self.scrollView.contentView.addSubview(indicator)
        indicator.pinToSuperviewEdge(.bottom)
        self.indicatorLeftMargin = indicator.pinToSuperviewEdge(.left)
        self.indicatorWidth = indicator.set(.width, to: 0.0)
    }

    override func updateForCurrentPosition(bounds: CGRect? = nil) {
        super.updateForCurrentPosition(bounds: bounds)

        // reset minimum item width constraints
        let minimumItemWidth = appearance.layout.minimumItemWidth ?? Appearance.defaultAppearance.layout.minimumItemWidth!
        self.itemMinimumWidthConstraints?.forEach({ $0.constant = minimumItemWidth })
        layoutIfNeeded()

        let itemDistribution = appearance.layout.itemDistribution ?? Appearance.defaultAppearance.layout.itemDistribution!

        // prevent visual glitch when scrolling between items when normal font and selected font differ
        if self.textFont != self.selectedTextFont, let items = items, let itemMinimumWidthConstraints = itemMinimumWidthConstraints {
            for (item, minWidthConstraint) in zip(items, itemMinimumWidthConstraints) {
                guard let title = item.title else { continue }
                let constrainedHeight = self.contentView.bounds.height
                let normalWidth = title.width(withConstrainedHeight: constrainedHeight, font: self.textFont)
                let selectedWidth = title.width(withConstrainedHeight: constrainedHeight, font: self.selectedTextFont)
                minWidthConstraint.constant = max(normalWidth, selectedWidth, minimumItemWidth)
            }
            layoutIfNeeded()
        }

        // in fill item distribution add additional padding to items if content doesn't use the full width of the bar
        if itemDistribution == .fill, scrollView.contentView.bounds.width < scrollView.bounds.width, let itemCount = items?.count, let itemMinimumWidthConstraints = itemMinimumWidthConstraints {
            let extraSpace = scrollView.bounds.width - scrollView.contentView.bounds.width
            let widthPadding = extraSpace / CGFloat(itemCount)
            for (button, minWidthConstraint) in zip(buttons, itemMinimumWidthConstraints) {
                minWidthConstraint.constant = button.bounds.width + widthPadding
            }
            layoutIfNeeded()
        }

        indicator?.invalidateIntrinsicContentSize()
        layoutIfNeeded()
    }

    override public func update(forAppearance appearance: Appearance, defaultAppearance: Appearance) {
        super.update(forAppearance: appearance, defaultAppearance: defaultAppearance)

        let isScrollEnabled = appearance.interaction.isScrollEnabled
        self.isScrollEnabled = isScrollEnabled ?? defaultAppearance.interaction.isScrollEnabled!

        self.updateEdgeFade(visible: appearance.style.showEdgeFade ?? false)

        // dont allow for centered item distribution if indicator is progressive
        let isProgressive = appearance.indicator.isProgressive ?? defaultAppearance.indicator.isProgressive!
        var itemDistribution = appearance.layout.itemDistribution ?? defaultAppearance.layout.itemDistribution!
        if itemDistribution == .centered && isProgressive {
            itemDistribution = .leftAligned
            print("TabmanScrollingButtonBar Error - 'centered' item distribution is not supported when using a progressive indicator.")
        }

        update(for: itemDistribution)
    }
}

internal extension TabmanScrollingButtonBar {

    /// Updates the visibility of the alpha fade at the edge of scroll view bounds.
    ///
    /// - Parameter visible: Whether to show the fade.
    func updateEdgeFade(visible: Bool) {
        if visible {

            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.locations = [0.02, 0.05, 0.95, 0.98]
            self.contentView.layer.mask = gradientLayer
            self.fadeGradientLayer = gradientLayer

        } else {
            self.contentView.layer.mask = nil
            self.fadeGradientLayer = nil
        }
    }

    /// Updates scroll view contentInset for an itemDistribution style.
    ///
    /// - Parameter itemDistribution: The itemDistribution style.
    func update(for itemDistribution: TabmanBar.Appearance.Layout.ItemDistribution) {

        var contentInset = scrollView.contentInset
        switch itemDistribution {

        case .leftAligned, .fill:
            contentInset.left = 0.0
            contentInset.right = 0.0

        case .centered:
            let indicatorWidth = indicator?.bounds.size.width ?? 0.0
            let boundsWidth = bounds.size.width - (2 * edgeInset)
            let inset = (boundsWidth - indicatorWidth) / 2.0
            contentInset.left = inset
            contentInset.right = inset

        }

        scrollView.contentInset = contentInset
        self.updateForCurrentPosition()
    }
}
