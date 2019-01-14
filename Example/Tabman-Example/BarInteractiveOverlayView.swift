//
//  BarInteractiveOverlayView.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 16/10/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
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
        case add(bar: TMBar, estimatedSize: CGSize)
        case deletion
    }
    
    // MARK: Properties
    
    private weak var viewController: TabmanViewController!
    
    private let overlayView: UIView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        return view
    }()
    private var removalButtons: [UIButton: TMBar]?
    private let overlayMaskLayer = CAShapeLayer()
    
    private(set) var bar: TMBar?
    
    weak var delegate: BarInteractiveOverlayViewDelegate?
    
    // MARK: Init
    
    private init(for viewController: TabmanViewController,
                 context: Context) {
        self.viewController = viewController
        super.init(frame: .zero)
        initialize()
        
        switch context {
        case .add(let bar, let estimatedSize):
            self.bar = bar
            renderInsertionAreas(for: bar, estimatedSize: estimatedSize)
            
        case .deletion:
            renderDeletionAreas(for: viewController.bars)
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
        
        overlayMaskLayer.fillColor = UIColor.black.cgColor
        overlayView.layer.mask = overlayMaskLayer
    }
    
    // MARK: Layout
    
    private func renderInsertionAreas(for bar: TMBar,
                                      estimatedSize: CGSize) {
        
        let barHeight: CGFloat
        if estimatedSize != .zero {
            barHeight = estimatedSize.height
        } else {
            barHeight = Defaults.areaButtonHeight
        }
        
        // top area
        let topAreaInset: CGFloat
        let topAreaHeight: CGFloat
        if viewController.topBarContainer.frame.size.height != 0.0 {
            topAreaInset = viewController.topBarContainer.frame.maxY
            topAreaHeight = barHeight
        } else {
            topAreaInset = 0.0
            topAreaHeight = barHeight + viewController.topBarContainer.frame.maxY
        }
        let topAreaButton = makeAreaButton(for: .top)
        addSubview(topAreaButton)
        topAreaButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAreaButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            topAreaButton.topAnchor.constraint(equalTo: topAnchor, constant: topAreaInset),
            topAreaButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            topAreaButton.heightAnchor.constraint(equalToConstant: topAreaHeight)
            ])
        topAreaButton.addTarget(self, action: #selector(topAreaButtonPressed(_:)), for: .touchUpInside)
        
        // bottom area
        let bottomAreaInset: CGFloat
        let bottomAreaHeight: CGFloat
        if viewController.bottomBarContainer.frame.size.height != 0.0 {
            bottomAreaInset = viewController.view.frame.height - viewController.bottomBarContainer.frame.minY
            bottomAreaHeight = barHeight
        } else {
            bottomAreaInset = 0.0
            bottomAreaHeight = barHeight + (viewController.view.frame.height - viewController.bottomBarContainer.frame.minY)
        }
        let bottomAreaButton = makeAreaButton(for: .bottom)
        addSubview(bottomAreaButton)
        bottomAreaButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomAreaButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomAnchor.constraint(equalTo: bottomAreaButton.bottomAnchor, constant: bottomAreaInset),
            bottomAreaButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAreaButton.heightAnchor.constraint(equalToConstant: bottomAreaHeight)
            ])
        bottomAreaButton.addTarget(self, action: #selector(bottomAreaButtonPressed(_:)), for: .touchUpInside)
        
        // Text
        let textArea = UIView()
        addSubview(textArea)
        textArea.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            textArea.topAnchor.constraint(equalTo: topAreaButton.bottomAnchor),
            textArea.trailingAnchor.constraint(equalTo: trailingAnchor),
            textArea.bottomAnchor.constraint(equalTo: bottomAreaButton.topAnchor)
            ])
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        textArea.addGestureRecognizer(tapRecognizer)
        
        let topAreaLabel = makeAreaLabel(For: .top)
        textArea.addSubview(topAreaLabel)
        topAreaLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAreaLabel.leadingAnchor.constraint(equalTo: textArea.leadingAnchor),
            topAreaLabel.trailingAnchor.constraint(equalTo: textArea.trailingAnchor),
            topAreaLabel.topAnchor.constraint(equalTo: textArea.topAnchor, constant: 8.0)
            ])
        
        let bottomAreaLabel = makeAreaLabel(For: .bottom)
        textArea.addSubview(bottomAreaLabel)
        bottomAreaLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomAreaLabel.leadingAnchor.constraint(equalTo: textArea.leadingAnchor),
            bottomAreaLabel.trailingAnchor.constraint(equalTo: textArea.trailingAnchor),
            textArea.bottomAnchor.constraint(equalTo: bottomAreaLabel.bottomAnchor, constant: 8.0)
            ])
        
        let promptLabel = makePromptLabel()
        textArea.addSubview(promptLabel)
        promptLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            promptLabel.leadingAnchor.constraint(equalTo: textArea.leadingAnchor),
            promptLabel.trailingAnchor.constraint(equalTo: textArea.trailingAnchor),
            promptLabel.centerYAnchor.constraint(equalTo: textArea.centerYAnchor)
            ])
    }
    
    private func renderDeletionAreas(for bars: [TMBar]) {
        
        let removalArea = UIView()
        addSubview(removalArea)
        removalArea.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            removalArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            removalArea.topAnchor.constraint(equalTo: topAnchor),
            removalArea.trailingAnchor.constraint(equalTo: trailingAnchor),
            removalArea.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        removalArea.addGestureRecognizer(tapRecognizer)
        
        var removalButtons = [UIButton: TMBar]()
        for bar in bars {
            let barView = bar as! UIView
            let frame = barView.superview!.convert(barView.frame, to: viewController.view)
            
            let removalButton = UIButton()
            removalButton.addTarget(self, action: #selector(removalButtonPressed(_:)), for: .touchUpInside)
            removalArea.addSubview(removalButton)
            removalButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                removalButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: frame.origin.x),
                removalButton.topAnchor.constraint(equalTo: topAnchor, constant: frame.minY),
                removalButton.widthAnchor.constraint(equalToConstant: frame.size.width),
                removalButton.heightAnchor.constraint(equalToConstant: frame.size.height)
                ])
            
            removalButtons[removalButton] = bar
        }
        self.removalButtons = removalButtons
    }
    
    // MARK: Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        overlayMaskLayer.frame = bounds
        let path = UIBezierPath(rect: overlayView.bounds)

        if let removalButtons = removalButtons {
            for button in removalButtons.keys {
                path.append(UIBezierPath(rect: button.frame).reversing())
            }
        }
        
        overlayMaskLayer.path = path.cgPath
    }
    
    @objc func dismiss() {
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
    
    @objc private func removalButtonPressed(_ sender: UIButton) {
        guard let bar = removalButtons?[sender] else {
            return
        }
        
        viewController.removeBar(bar)
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
        button.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return button
    }
    
    func makePromptLabel() -> UILabel {
        let promptLabel = UILabel()
        promptLabel.text = "Select location"
        promptLabel.textColor = .white
        promptLabel.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        promptLabel.textAlignment = .center
        return promptLabel
    }
    
    func makeAreaLabel(For location: TabmanViewController.BarLocation) -> UILabel {
        let areaLabel = UILabel()
        switch location {
        case .top:
            areaLabel.text = "Top"
        default:
            areaLabel.text = "Bottom"
        }
        areaLabel.textColor = .white
        areaLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        areaLabel.textAlignment = .center
        return areaLabel
    }
}
