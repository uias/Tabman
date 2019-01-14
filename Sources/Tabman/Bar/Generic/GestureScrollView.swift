//
//  GestureScrollView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 25/10/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

protocol GestureScrollViewGestureDelegate: class {
    
    func scrollView(_ scrollView: GestureScrollView,
                    didReceiveSwipeTo direction: UISwipeGestureRecognizer.Direction)
}

/// Scroll view which provides enhanced scroll modes via gestures.
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
            removeSwipeGestureRecognizers()
        case .swipe:
            super.isScrollEnabled = false
            addSwipeGestureRecognizers()
        case .none:
            super.isScrollEnabled = false
            removeSwipeGestureRecognizers()
        }
    }
}

// MARK: - Gestures
private extension GestureScrollView {
    
    func addSwipeGestureRecognizers() {
        
        let negativeDirection: UISwipeGestureRecognizer.Direction = .left
        let positiveDirection: UISwipeGestureRecognizer.Direction = .right
        
        let negativeSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        negativeSwipeRecognizer.direction = negativeDirection
        addGestureRecognizer(negativeSwipeRecognizer)
        self.negativeSwipeRecognizer = negativeSwipeRecognizer
        
        let positiveSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        positiveSwipeRecognizer.direction = positiveDirection
        addGestureRecognizer(positiveSwipeRecognizer)
        self.positiveSwipeRecognizer = positiveSwipeRecognizer
    }
    
    func removeSwipeGestureRecognizers() {
        if let negativeSwipeRecognizer = negativeSwipeRecognizer {
            removeGestureRecognizer(negativeSwipeRecognizer)
        }
        if let positiveSwipeRecognizer = positiveSwipeRecognizer {
            removeGestureRecognizer(positiveSwipeRecognizer)
        }
    }
    
    @objc func didSwipe(_ recognizer: UISwipeGestureRecognizer) {
        gestureDelegate?.scrollView(self, didReceiveSwipeTo: recognizer.direction)
    }
}
