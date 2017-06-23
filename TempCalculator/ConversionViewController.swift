//
//  ViewController.swift
//  TempCalculator
//
//  Created by Suguru on 6/21/17.
//  Copyright © 2017 Suguru. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view.")
        updateCelsiusLabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    // variable
    // a Measurement variable for fahrenheight
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    // a Measurement variable for celsius
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheightValue = fahrenheitValue {
            return fahrenheightValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    // number formatter variable
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    // method that detects the change of text
    @IBAction func fairenheitFieldEditingChanged(_ sender: Any) {
        // checks if there is value, then if it's a Double value
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }

    @IBAction func dismissKeyboard(_ send: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    

    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        var retVal: Bool?
//        
//        return retVal!
//    }
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        
//    }
//    
//    func textFieldShouldEndEditing(_textField: UITextField) -> Bool {
//        var retVal: Bool?
//        
//        return retVal!
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        
//    }
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        var retVal: Bool?
//        
//        return retVal!
//    }
//    
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        var retVal: Bool?
//        
//        return retVal!
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        var retVal: Bool?
//        
//        return retVal!
//    }
    


}

