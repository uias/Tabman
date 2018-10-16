//
//  BarInteractiveOverlayView.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 16/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
@testable import Tabman

protocol BarInteractiveOverlayViewDelegate: class {
    
    func interactiveOverlayView(_ view: BarInteractiveOverlayView,
                                didRequestAdd bar: TMBar,
                                at location: TabmanViewController.BarLocation)
}

final class BarInteractiveOverlayView: UIView {
    
    // MARK: Defaults
    
    private struct Defaults {
        static let areaButtonHeight: CGFloat = 70.0
    }
    
    // MARK: Types
    
    enum Context {
        case add(bar: TMBar)
        case deletion
    }
    
    // MARK: Properties
    
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        return view
    }()
    
    private(set) var bar: TMBar?
    
    weak var delegate: BarInteractiveOverlayViewDelegate?
    
    // MARK: Init
    
    private init(for viewController: TabmanViewController,
                 context: Context) {
        super.init(frame: .zero)
        initialize()
        
        switch context {
        case .add(let bar):
            self.bar = bar
            renderInsertionAreas(for: bar, in: viewController)
            
        case .deletion:
            fatalError()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    private func initialize() {
        
        addSubview(overlayView)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    // MARK: Layout
    
    private func renderInsertionAreas(for bar: TMBar, in viewController: TabmanViewController) {
        
        let topAreaHeight = viewController.topBarContainer.frame.maxY
        let topAreaButton = makeAreaButton(for: .top)
        addSubview(topAreaButton)
        topAreaButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAreaButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            topAreaButton.topAnchor.constraint(equalTo: topAnchor, constant: topAreaHeight),
            topAreaButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            topAreaButton.heightAnchor.constraint(equalToConstant: Defaults.areaButtonHeight)
            ])
        topAreaButton.addTarget(self, action: #selector(topAreaButtonPressed(_:)), for: .touchUpInside)
        
        let bottomAreaHeight = viewController.view.frame.height - viewController.bottomBarContainer.frame.minY
        let bottomAreaButton = makeAreaButton(for: .bottom)
        addSubview(bottomAreaButton)
        bottomAreaButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomAreaButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomAnchor.constraint(equalTo: bottomAreaButton.bottomAnchor, constant: bottomAreaHeight),
            bottomAreaButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAreaButton.heightAnchor.constraint(equalToConstant: Defaults.areaButtonHeight)
            ])
        bottomAreaButton.addTarget(self, action: #selector(bottomAreaButtonPressed(_:)), for: .touchUpInside)
    }
    
    // MARK: Lifecycle
    
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0.0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    // MARK: Actions
    
    @objc private func topAreaButtonPressed(_ sender: UIButton) {
        guard let bar = self.bar else {
            return
        }
        delegate?.interactiveOverlayView(self, didRequestAdd: bar, at: .top)
        dismiss()
    }
    
    @objc private func bottomAreaButtonPressed(_ sender: UIButton) {
        guard let bar = self.bar else {
            return
        }
        delegate?.interactiveOverlayView(self, didRequestAdd: bar, at: .bottom)
        dismiss()
    }
}

extension BarInteractiveOverlayView {
    
    @discardableResult
    class func present(over viewController: TabmanViewController,
                       context: BarInteractiveOverlayView.Context) -> BarInteractiveOverlayView {
        let view = BarInteractiveOverlayView(for: viewController,
                                             context: context)
        view.alpha = 0.0
        
        let parent = viewController.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            view.topAnchor.constraint(equalTo: parent.topAnchor),
            view.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
            ])
        
        UIView.animate(withDuration: 0.25) {
            view.alpha = 1.0
        }
        return view
    }
}

private extension BarInteractiveOverlayView {
    
    func makeAreaButton(for location: TabmanViewController.BarLocation) -> UIButton {
        let button = UIButton()
        
        switch location {
        case .top:
            button.setTitle("Top", for: .normal)
        default:
            button.setTitle("Bottom", for: .normal)
        }
        
        button.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return button
    }
}
