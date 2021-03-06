//
//  AddItemViewController.swift
//  PinterestLayout
//
//  Created by Jeremy Zhang on 2016-01-27.
//  Copyright © 2016 MoDooh Inc. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var uuidTextField: UITextField!
    @IBOutlet weak var majorIdTextField: UITextField?
    @IBOutlet weak var minorIdTextField: UITextField?
    
    var uuidRegex = try! NSRegularExpression(pattern: "^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", options: .CaseInsensitive)
    var nameFieldValid = false
    var UUIDFieldValid = false
    var newItem: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBarButtonItem.enabled = false
        
        nameTextField.addTarget(self, action: "nameTextFieldChanged:", forControlEvents: .EditingChanged)
        uuidTextField.addTarget(self, action: "uuidTextFieldChanged:", forControlEvents: .EditingChanged)
    }
    
    func nameTextFieldChanged(textField: UITextField) {
        nameFieldValid = (textField.text!.characters.count > 0)
        saveBarButtonItem.enabled = (UUIDFieldValid && nameFieldValid)
    }
    
    func uuidTextFieldChanged(textField: UITextField) {
        let numberOfMatches = uuidRegex.numberOfMatchesInString(textField.text!, options: [], range: NSMakeRange(0, textField.text!.characters.count))
        UUIDFieldValid = (numberOfMatches > 0)
        
        saveBarButtonItem.enabled = (UUIDFieldValid && nameFieldValid)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveItemSegue" {
            let uuid = NSUUID(UUIDString: uuidTextField.text!)
            let major = UInt16(Int(majorIdTextField!.text!)!)
            let minor = UInt16(Int(minorIdTextField!.text!)!)
            
            newItem = Item(name: nameTextField.text!, uuid: uuid!, majorValue: major, minorValue: minor)
        }
    }
}

