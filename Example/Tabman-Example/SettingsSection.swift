//
//  SettingsSection.swift
//  Tabman-Example
//
//  Created by Merrick Sapsford on 27/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

class SettingsSection: NSObject {
    
    // MARK: Properties
    
    let title: String
    private var items = [SettingsItem]()
    
    var itemsCount: Int {
        return self.items.count
    }
    
    // MARK: Init
    
    init(title: String) {
        self.title = title
    }
    
    func add(item: SettingsItem) {
        self.items.append(item)
    }
    
    func item(atIndex index: Int) -> SettingsItem? {
        guard index < self.items.count else { return nil }
        
        return self.items[index]
    }
}

extension SettingsSection: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
