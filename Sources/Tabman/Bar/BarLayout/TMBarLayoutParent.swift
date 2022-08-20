//
//  TMBarLayoutParent.swift
//  Tabman
//
//  Created by Merrick Sapsford on 08/08/2018.
//  Copyright © 2022 UI At Six. All rights reserved.
//

import UIKit

/// The object that acts as a parent to a `TMBarLayout`.
///
/// This is expected to be a view that can directly maniuplate the frames that the layout is
/// contained within to handle content inset and other properties that are accessible from the
/// layout but expected that a parent view is responsible for.
internal protocol TMBarLayoutParent: TMTransitionStyleable {
    
    /// Content inset that is applied to the frame of the layout.
    var contentInset: UIEdgeInsets { get set }
    
    /// Alignment that is applied to the layout.
    var alignment: TMBarLayout.Alignment { get set }
    
    /// Bar layout requires a reload of its contents.
    ///
    /// - Parameter layout: Layout.
    func layout(needsReload layout: TMBarLayout)
}
