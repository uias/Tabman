//
//  TabmanViewController+InteractiveAdd.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 16/10/2018.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit
@testable import Tabman

extension TabmanViewController {
    
    func addBarInteractively(_ bar: TMBar,
                             dataSource: TMBarDataSource,
                             estimatedBarSize: CGSize = .zero) {
        bar.dataSource = dataSource
        let overlay = BarInteractiveOverlayView.present(over: self,
                                                        context: .add(bar: bar, estimatedSize: estimatedBarSize))
        overlay.delegate = self
    }
    
    func startInteractiveDeletion() {
        let overlay = BarInteractiveOverlayView.present(over: self, context: .deletion)
        overlay.delegate = self
    }
}

extension TabmanViewController: BarInteractiveOverlayViewDelegate {
    
    func interactiveOverlayView(_ view: BarInteractiveOverlayView,
                                didRequestAdd bar: TMBar,
                                at location: TabmanViewController.BarLocation) {
        addBar(TMSystemBar(for: bar),
               dataSource: bar.dataSource!,
               at: location)
    }
}
