//
//  ScrollStackView.swift
//  Tabman
//
//  Created by Merrick Sapsford on 06/06/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import SnapKit

internal final class ScrollStackView: UIView {
    
    // MARK: Properties
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutComponents()
        configureComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutComponents()
        configureComponents()
    }
}

// MARK: - Layout
private extension ScrollStackView {
    
    func layoutComponents() {
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(self.snp.height)
        }
    }
    
    func configureComponents() {
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
    }
}

// MARK: - Stack View manipulation
extension ScrollStackView {
    
    var spacing: CGFloat {
        set {
            stackView.spacing = newValue
        } get {
            return stackView.spacing
        }
    }
    
    var arrangedSubviews: [UIView] {
        return stackView.arrangedSubviews
    }
    
    func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
    
    func removeArrangedSubview(_ view: UIView) {
        stackView.removeArrangedSubview(view)
    }
    
    func insertArrangedSubview(_ view: UIView, at index: Int) {
        stackView.insertArrangedSubview(view, at: index)
    }
}

// MARK: - Scroll View manipulation
extension ScrollStackView {
    
    var contentOffset: CGPoint {
        set {
            scrollView.contentOffset = newValue
        } get {
            return scrollView.contentOffset
        }
    }
    
    var contentInset: UIEdgeInsets {
        set {
            scrollView.contentInset = newValue
        } get {
            return scrollView.contentInset
        }
    }
    
    weak var delegate: UIScrollViewDelegate? {
        set {
            scrollView.delegate = newValue
        } get {
            return scrollView.delegate
        }
    }
}
