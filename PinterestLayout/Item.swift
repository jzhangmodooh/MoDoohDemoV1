//
//  Item.swift
//  PinterestLayout
//
//  Created by Jeremy Zhang on 2016-01-27.
//  Copyright © 2016 MoDooh Inc. All rights reserved.
//

import Foundation
import CoreLocation

struct ItemConstant {
    static let nameKey = "name"
    static let uuidKey = "uuid"
    static let majorKey = "major"
    static let minorKey = "minor"
}

class Item: NSObject, NSCoding {
    let name: String
    let uuid: NSUUID
    let majorValue: CLBeaconMajorValue
    let minorValue: CLBeaconMinorValue
    dynamic var lastSeenBeacon: CLBeacon?
    
    init(name: String, uuid: NSUUID, majorValue: CLBeaconMajorValue, minorValue: CLBeaconMinorValue) {
        self.name = name
        self.uuid = uuid
        self.majorValue = majorValue
        self.minorValue = minorValue
    }
    
    // MARK: NSCoding
    required init?(coder aDecoder: NSCoder) {
        if let aName = aDecoder.decodeObjectForKey(ItemConstant.nameKey) as? String {
            name = aName
        }
        else {
            name = ""
        }
        if let aUUID = aDecoder.decodeObjectForKey(ItemConstant.uuidKey) as? NSUUID {
            uuid = aUUID
        }
        else {
            uuid = NSUUID()
        }
        majorValue = UInt16(aDecoder.decodeIntegerForKey(ItemConstant.majorKey))
        minorValue = UInt16(aDecoder.decodeIntegerForKey(ItemConstant.minorKey))
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: ItemConstant.nameKey)
        aCoder.encodeObject(uuid, forKey: ItemConstant.uuidKey)
        aCoder.encodeInteger(Int(majorValue), forKey: ItemConstant.majorKey)
        aCoder.encodeInteger(Int(minorValue), forKey: ItemConstant.minorKey)
    }
    
}

func ==(item: Item, beacon: CLBeacon) -> Bool {
    return ((beacon.proximityUUID.UUIDString == item.uuid.UUIDString)
        && (Int(beacon.major) == Int(item.majorValue))
        && (Int(beacon.minor) == Int(item.minorValue)))
}



