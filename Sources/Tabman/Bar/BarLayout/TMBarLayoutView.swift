//
//  TMBarLayoutView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/11/2020.
//  Copyright © 2020 UI At Six. All rights reserved.
//

import UIKit

public final class TMBarLayoutView: UIView, LayoutContainerViewDelegate {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let spacing: CGFloat = 8.0
    }
    
    // MARK: Types
    
    public enum Container: Int, CaseIterable {
        case leadingAuxiliary
        case leadingAccessory
        case main
        case trailingAccessory
        case trailingAuxiliary
    }
    
    // MARK: Properties
    
    private let stack = UIStackView()
    private var containers: [UIView]!
    
    public var spacing: CGFloat {
        get {
            stack.spacing
        }
        set {
            stack.spacing = newValue
        }
    }
    
    // MARK: Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        layoutContents()
        
        containers = Container.allCases.map({ LayoutContainerView(container: $0, delegate: self) })
    }
    
    // MARK: Lifecycle
    
    @available(*, unavailable)
    public override func addSubview(_ view: UIView) {
        fatalError("TMBarLayoutView does not allow subviews to be added, please use a container within the view.")
    }
    
    public func container(_ container: Container) -> UIView {
        containers[container.rawValue]
    }
    
    // MARK: LayoutContainerViewDelegate
    
    fileprivate func containerViewDidAddSubview(_ container: LayoutContainerView) {
        let index = container.container.rawValue
        let insertionIndex = stack.arrangedSubviews.compactMap({ $0 as? LayoutContainerView }).filter({ $0.container.rawValue < index }).count
        stack.insertArrangedSubview(container, at: insertionIndex)
    }
    
    fileprivate func containerViewDidRemoveAllSubviews(_ container: LayoutContainerView) {
        stack.removeArrangedSubview(container)
        container.removeFromSuperview()
    }
}

extension TMBarLayoutView {
    
    private func layoutContents() {
        stack.spacing = Defaults.spacing
        super.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            bottomAnchor.constraint(equalTo: stack.bottomAnchor)
        ])
    }
}

private class LayoutContainerView: UIView {
    
    // MARK: Properties
    
    let container: TMBarLayoutView.Container
    private weak var delegate: LayoutContainerViewDelegate?
    
    // MARK: Init
    
    init(container: TMBarLayoutView.Container, delegate: LayoutContainerViewDelegate) {
        self.container = container
        self.delegate = delegate
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Lifecycle
    
    override func addSubview(_ view: UIView) {
        delegate?.containerViewDidAddSubview(self)
        super.addSubview(view)
    }
    
    override func willRemoveSubview(_ subview: UIView) {
        super.willRemoveSubview(subview)
        
        if subviews.count == 1 {
            delegate?.containerViewDidRemoveAllSubviews(self)
        }
    }
}

private protocol LayoutContainerViewDelegate: class {
    
    func containerViewDidRemoveAllSubviews(_ container: LayoutContainerView)
    
    func containerViewDidAddSubview(_ container: LayoutContainerView)
}
