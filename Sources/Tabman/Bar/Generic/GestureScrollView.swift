//
//  GestureScrollView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 25/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

protocol GestureScrollViewGestureDelegate: class {
    
    func scrollView(_ scrollView: GestureScrollView,
                    didReceiveSwipeTo direction: UISwipeGestureRecognizer.Direction)
}

internal final class GestureScrollView: UIScrollView {
    
    // MARK: Types
    
    enum ScrollMode: Int {
        case interactive
        case swipe
        case none
    }
    
    // MARK: Properties
    
    @available(*, unavailable)
    override var isScrollEnabled: Bool {
        didSet {}
    }
    var scrollMode: ScrollMode = .interactive {
        didSet {
            guard scrollMode != oldValue else {
                return
            }
            update(for: scrollMode)
        }
    }
    
    weak var gestureDelegate: GestureScrollViewGestureDelegate?
    
    private var negativeSwipeRecognizer: UIGestureRecognizer?
    private var positiveSwipeRecognizer: UIGestureRecognizer?

    // MARK: Updates
    
    private func update(for scrollMode: ScrollMode) {
        switch scrollMode {
        case .interactive:
            super.isScrollEnabled = true
        case .swipe:
            super.isScrollEnabled = false
            addSwipeGestureRecognizers()
        case .none:
            super.isScrollEnabled = false
        }
    }
}

// MARK: - Gestures
private extension GestureScrollView {
    
    func addSwipeGestureRecognizers() {
        let negativeSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        negativeSwipeRecognizer.direction = .left
        addGestureRecognizer(negativeSwipeRecognizer)
        self.negativeSwipeRecognizer = negativeSwipeRecognizer
        
        let positiveSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        positiveSwipeRecognizer.direction = .right
        addGestureRecognizer(positiveSwipeRecognizer)
        self.negativeSwipeRecognizer = positiveSwipeRecognizer
    }
    
    @objc func didSwipe(_ recognizer: UISwipeGestureRecognizer) {
        gestureDelegate?.scrollView(self, didReceiveSwipeTo: recognizer.direction)
    }
}
