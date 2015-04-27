//
//  ViewController.swift
//  Converter
//
//  Created by Christian A. Rodriguez on 4/27/15.
//  Copyright (c) 2015 Mai Apps. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var fromBaseField: UITextField!
    @IBOutlet weak var toBaseField: UITextField!
    @IBOutlet weak var numberTextfield: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var basePicker: UIPickerView!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var dimView: UIView!

    
    var selected = "from"
    
    let bases = ["Decimal", "Binary", "Octal", "Hexadecimal"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basePicker.hidden = true
        fromBaseField.text = bases[0]
        toBaseField.text = bases[1]
        
        basePicker.delegate = self
        fromBaseField.delegate = self
        toBaseField.delegate = self
        numberTextfield.delegate = self
        
        let singleTap = UITapGestureRecognizer(target: self, action: "dismissPicker")
        self.dimView.addGestureRecognizer(singleTap)
    }

    @IBAction func convertNumber(sender: AnyObject) {
        
    }
    
    func dismissPicker() {
        basePicker.hidden = true
        dimView.hidden = false
        UIView.animateWithDuration(0.4) {
            self.dimView.alpha = 0.0
        }
    }

    // MARK: UIPickerViewDelegate
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int{
        return bases.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return bases[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if selected == "from" {
            fromBaseField.text = bases[row]
        }
        if selected == "to" {
            toBaseField.text = bases[row]
        }
        selected = ""
        convertNumber(self)
        basePicker.hidden = true
        
        dimView.hidden = false
        UIView.animateWithDuration(0.4) {
            self.dimView.alpha = 0.0
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.tag == 1 {
            selected = "from"
        }
        if textField.tag == 2 {
            selected = "to"
        }
        if textField.tag == 3 {
            selected = ""
            return true
        }
        creditLabel.hidden = true
        
        dimView.hidden = false
        UIView.animateWithDuration(0.4) {
            self.dimView.alpha = 0.6
        }
        
        basePicker.hidden = false
        return false
    }
    

}

