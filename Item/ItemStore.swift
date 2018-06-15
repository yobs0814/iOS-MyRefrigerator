//
//  ItemStore.swift
//  MyTable
//
//  Created by Jae Moon Lee on 2018. 4. 10..
//  Copyright © 2018년 Jae Moon Lee. All rights reserved.
//

import Foundation

// ItemStore.swift

class ItemStore {
    var items = [[Item]]()
    let section : [String] = ["냉장고","냉동고","실온"]
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as! [[Item]]? {
            items += archivedItems
        }
        
        for i in 0..<3{
            let item = [Item]()
            items.append(item)
        }
    }
    
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.arhive")
    }()

    
    func removeItem(_ index: Int,_ section: Int){
        items[section].remove(at: index)
    }
    
    func moveItemAtIndex(from: Int, to: Int, section:Int){
        let item = items[section][from]
        removeItem(from, section)
        items[section].insert(item, at: to)
    }
    
    
    func save() -> Bool {
        print("\(itemArchiveURL.path)")
        
        return NSKeyedArchiver.archiveRootObject(items, toFile: itemArchiveURL.path)
    }
}
