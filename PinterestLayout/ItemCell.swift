//
//  ItemCell.swift
//  PinterestLayout
//
//  Created by Jeremy Zhang on 2016-01-27.
//  Copyright © 2016 MoDooh Inc. All rights reserved.
//

import UIKit
import CoreLocation

class ItemCell: UITableViewCell {
    @IBOutlet weak var valueTextView: UITextView!
    
    var item: Item? = nil {
        willSet {
            if let thisItem = item {
                thisItem.removeObserver(self, forKeyPath: "lastSeenBeacon")
            }
        }
        didSet {
            item?.addObserver(self, forKeyPath: "lastSeenBeacon", options: .New, context: nil)
            
            textLabel!.text = item?.name
        }
    }
    
    deinit {
        item?.removeObserver(self, forKeyPath: "lastSeenBeacon")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        item = nil
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func nameForProximity(proximity: CLProximity) -> String {
        switch proximity {
        case .Unknown:
            return "Unknown"
        case .Immediate:
            return "Immediate"
        case .Near:
            return "Near"
        case .Far:
            return "Far"
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let anItem = object as? Item {
            if anItem == item && keyPath == "lastSeenBeacon" {
                let proximity = nameForProximity(anItem.lastSeenBeacon!.proximity)
                let accuracy = NSString(format: "%.2f", anItem.lastSeenBeacon!.accuracy)
                detailTextLabel!.text = "Location: \(proximity) (approx. \(accuracy)m)"
            }
        }
    }
}


