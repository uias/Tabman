//
//  TMBarButtonStore.swift
//  Tabman
//
//  Created by Merrick Sapsford on 11/11/2020.
//  Copyright © 2020 UI At Six. All rights reserved.
//

import UIKit

internal final class TMBarButtonStore<BarButton: TMBarButton> {
    
    static var didUpdateNotification: Notification.Name {
        Notification.Name("com.uias.tabman.TMBarButtonStore.didUpdate")
    }
    
    typealias Area = TMBarLayout.LayoutArea
    
    struct Update {
        let area: Area
        let index: Int?
        let buttons: [BarButton]
    }
    
    // MARK: Properties
    
    private var areas = [Area: [BarButton]]()
    
    var all: [BarButton] {
        return areas.values.reduce([], +)
    }
    
    // MARK: Lifecycle
    
    @discardableResult
    func insert(contentsOf collection: [BarButton], at index: Int, isInfinite: Bool) -> [Update] {
        var updates = [Update]()
        updates.append(insert(contentsOf: collection, at: index, in: .main))
        
        if isInfinite {
            updates.append(insert(contentsOf: collection.deepCopy(), at: index, in: .leadingAuxiliary))
            updates.append(insert(contentsOf: collection.deepCopy(), at: index, in: .trailingAuxiliary))
        }
        
        if !updates.isEmpty {
            NotificationCenter.default.post(name: TMBarButtonStore.didUpdateNotification, object: self)
        }
        
        return updates
    }
    
    @discardableResult
    func remove(_ collection: [BarButton]) -> [Update] {
        let collection = collection.map({ $0.index })
        var updates = [Update]()
        if let main = remove(collection, from: .main) {
            updates.append(main)
        }
        if let leadingAuxiliary = remove(collection, from: .leadingAuxiliary) {
            updates.append(leadingAuxiliary)
        }
        if let trailingAuxiliary = remove(collection, from: .trailingAuxiliary) {
            updates.append(trailingAuxiliary)
        }
        
        if !updates.isEmpty {
            NotificationCenter.default.post(name: TMBarButtonStore.didUpdateNotification, object: self)
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
    
    private func remove(_ indexes: [Int], from area: Area) -> Update? {
        guard areas[area] != nil else {
            return nil
        }
        let matches = areas[area]?.filter({ indexes.contains($0.index) }) ?? []
        guard !matches.isEmpty else {
            return nil
        }
        areas[area]?.removeAll(where: { matches.contains($0) })
        return Update(area: area, index: nil, buttons: matches)
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
            let new = type(of: original).init(for: original.item, index: original.index, intrinsicSuperview: original.intrinsicSuperview)
            new.populate(for: original.item)
            new.update(for: original.selectionState)
            return new
        })
    }
}
