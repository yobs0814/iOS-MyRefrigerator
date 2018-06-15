//
//  Item.swift
//  MyTable
//
//  Created by Jae Moon Lee on 2018. 4. 10..
//  Copyright © 2018년 Jae Moon Lee. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding {
    
    // 데이터로 저장할 것들을 encode
    func encode(with aCoder: NSCoder) {
        // (저장할 변수, forKey: "key값")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(cnt, forKey: "cnt")
        aCoder.encode(expiredDate, forKey: "expiredDate")
        aCoder.encode(storageIndex, forKey:"storageIndex")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        //데이터로 읽어올 수 있는 것들을 decode
        name = aDecoder.decodeObject(forKey: "name") as! String
        // 정수만 decodeInteger(forKey: "키값")
        cnt = aDecoder.decodeObject(forKey: "cnt") as! String
        expiredDate = aDecoder.decodeObject(forKey: "expiredDate") as! String?
        storageIndex = aDecoder.decodeInteger(forKey: "storageIndex")
    }
    
    var name: String
    var expiredDate: String?
    var cnt: String
    var storageIndex: Int


    init(name: String, expiredDate: String?, cnt: String, storage: Int){
        
        self.name = name
        self.expiredDate = expiredDate
        self.cnt = cnt
        self.storageIndex = storage
        
        super.init()
    }
    
}

