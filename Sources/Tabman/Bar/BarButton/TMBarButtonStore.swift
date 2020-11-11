//
//  TMBarButtonStore.swift
//  Tabman
//
//  Created by Merrick Sapsford on 11/11/2020.
//  Copyright © 2020 UI At Six. All rights reserved.
//

import UIKit

internal final class TMBarButtonStore<BarButton: TMBarButton> {
    
    typealias Area = TMBarLayout.LayoutArea
    
    struct Update {
        let area: Area
        let index: Int?
        let buttons: [BarButton]
    }
    
    // MARK: Properties
    
    private var areas = [Area: [BarButton]]()
    
    // MARK: Lifecycle
    
    @discardableResult
    func insert(contentsOf collection: [BarButton], at index: Int, isInfinite: Bool) -> [Update] {
        var updates = [Update]()
        updates.append(insert(contentsOf: collection, at: index, in: .main))
        
        if isInfinite {
            updates.append(insert(contentsOf: collection.deepCopy(), at: index, in: .leadingAuxiliary))
            updates.append(insert(contentsOf: collection.deepCopy(), at: index, in: .trailingAuxiliary))
        }
        
        return updates
    }
    
    @discardableResult
    func remove(_ collection: [BarButton]) -> [Update] {
        var updates = [Update]()
        if let main = remove(collection, from: .main) {
            updates.append(main)
        }
        
        if let leadingAuxiliary = areas[.leadingAuxiliary], !leadingAuxiliary.isEmpty {
            // TODO - Remove leadingAuxiliary matches
        }
        if let trailingAuxiliary = areas[.trailingAuxiliary], !trailingAuxiliary.isEmpty {
            // TODO - Remove trailingAuxiliary matches
        }
        
        return updates
    }
    
    @discardableResult func removeAll() -> [Update] {
        var updates = [Update]()
        if let main = removeAll(from: .main) {
            updates.append(main)
        }
        
        if let leadingAuxiliary = removeAll(from: .leadingAuxiliary) {
            updates.append(leadingAuxiliary)
        }
        if let trailingAuxiliary = removeAll(from: .trailingAuxiliary) {
            updates.append(trailingAuxiliary)
        }
        
        return updates
    }
    
    private func insert(contentsOf collection: [BarButton], at index: Int, in area: Area) -> Update {
        makeAreaIfNeeded(area)
        areas[area]?.insert(contentsOf: collection, at: index)
        return Update(area: area, index: index, buttons: collection)
    }
    
    private func remove(_ collection: [BarButton], from area: Area) -> Update? {
        guard areas[area] != nil else {
            return nil
        }
        areas[area]?.removeAll(where: { collection.contains($0) })
        return Update(area: area, index: nil, buttons: collection)
    }
    
    private func removeAll(from area: Area) -> Update? {
        guard let buttons = areas[area] else {
            return nil
        }
        areas[area]?.removeAll()
        return Update(area: area, index: nil, buttons: buttons)
    }
    
    // MARK: Utility
    
    private func makeAreaIfNeeded(_ area: Area) {
        guard areas[area] == nil else {
            return
        }
        areas[area] = []
    }
}

private extension Collection where Iterator.Element: TMBarButton {
    
    func deepCopy() -> [Iterator.Element] {
        return map({ (original) in
            let new = type(of: original).init(for: original.item, intrinsicSuperview: original.intrinsicSuperview)
            new.populate(for: original.item)
            new.update(for: original.selectionState)
            return new
        })
    }
}
