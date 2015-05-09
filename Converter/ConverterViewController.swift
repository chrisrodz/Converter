//
//  ViewController.swift
//  Converter
//
//  Created by Christian A. Rodriguez on 4/27/15.
//  Copyright (c) 2015 Mai Apps. All rights reserved.
//

import UIKit
import Darwin

// Code from: http://stackoverflow.com/questions/26790660/how-to-convert-a-binary-to-decimal-in-swift
extension String {
    var hexToInt      : Int    { return Int(strtoul(self, nil, 16))    }
    var hexToDouble   : Double { return Double(strtoul(self, nil, 16)) }
    var hexToBinary   : String { return String(hexToInt, radix: 2)    }
    var intToHex      : String { return String(toInt()!, radix: 16)    }
    var intToBinary    : String { return String(toInt()!, radix: 2)     }
    var binaryToInt    : Int    { return Int(strtoul(self, nil, 2))     }
    var binaryToDouble : Double { return Double(strtoul(self, nil, 2))  }
    var binaryToHex   : String { return String(binaryToInt, radix: 16) }
}

extension Int {
    var binaryString: String { return String(self, radix: 2)  }
    var hexString  : String { return String(self, radix: 16) }
    var doubleValue : Double { return Double(self) }
}


class ConverterViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var fromBaseField: UITextField!
    @IBOutlet weak var toBaseField: UITextField!
    @IBOutlet weak var numberTextfield: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    
    let bases = ["Decimal", "Binary", "Hexadecimal"]
    
    let binaryCharacters : [Character] = ["0", "1"]
    let decimalCharacters : [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let hexadecimalCharacters : [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let basePicker = UIPickerView(frame: CGRectMake(0, 200, view.frame.width, 300))
        basePicker.showsSelectionIndicator = true
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.Default
        toolbar.translucent = true
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        
        fromBaseField.inputView = basePicker
        fromBaseField.inputAccessoryView = toolbar
        toBaseField.inputView = basePicker
        toBaseField.inputAccessoryView = toolbar

        fromBaseField.text = bases[0]
        toBaseField.text = bases[1]
        
        basePicker.delegate = self
        fromBaseField.delegate = self
        toBaseField.delegate = self
        numberTextfield.delegate = self
        
        fromBaseField.borderStyle = UITextBorderStyle.RoundedRect
        toBaseField.borderStyle = UITextBorderStyle.RoundedRect
        numberTextfield.borderStyle = UITextBorderStyle.RoundedRect
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }

    @IBAction func convertNumber(sender: AnyObject) {
        let number: String! = numberTextfield.text
        let toBase = toBaseField.text
        let fromBase = fromBaseField.text
        
        if numberIsValidInBase(number.lowercaseString, base: fromBase) {
            if fromBase == "Decimal" && toBase == "Binary" {
                resultLabel.text = number.toInt()?.binaryString
            } else if fromBase == "Decimal" && toBase == "Hexadecimal" {
                resultLabel.text = number.toInt()?.hexString
            } else if fromBase == "Binary" && toBase == "Hexadecimal" {
                resultLabel.text = number.binaryToHex
            } else if fromBase == "Binary" && toBase == "Decimal" {
                resultLabel.text = String(number.binaryToInt)
            } else if fromBase == "Hexadecimal" && toBase == "Decimal" {
                resultLabel.text = String(number.hexToInt)
            } else if fromBase == "Hexadecimal" && toBase == "Binary" {
                resultLabel.text = number.hexToBinary
            } else if toBase == fromBase {
                let alert = UIAlertController(title: "Same bases", message: "Choose different bases", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(alert, animated: false, completion: nil)
            } else {
                let alert = UIAlertController(title: "Unknown error", message: "Something weird happened. Sorry.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(alert, animated: false, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: number + " is not in base " + fromBase, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: false, completion: nil)
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
        var textFields = [fromBaseField, toBaseField]
        
        for field in textFields {
            if field.isFirstResponder() {
                field.text = bases[row]
                break;
            }
        }
    }
    
    func donePicker() {
        view.endEditing(true)
    }
    
    func numberIsValidInBase(number: String, base: String) -> Bool {
        if base == "Decimal" {
            for character in number {
                if contains(decimalCharacters, character) == false {
                    return false
                }
            }
        } else if base == "Binary" {
            for character in number {
                if contains(binaryCharacters, character) == false {
                    return false
                }
            }
        } else if base == "Hexadecimal" {
            for character in number {
                if contains(hexadecimalCharacters, character) == false {
                    return false
                }
            }
        }
        return true
    }

}

