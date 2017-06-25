//
//  ViewController.swift
//  TempCalculator
//
//  Created by Suguru on 6/21/17.
//  Copyright © 2017 Suguru. All rights reserved.
//

import UIKit

//protocol UITextFieldDelegate: NSObjectProtocol {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
//}

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view.")
        textField.delegate = self
        updateCelsiusLabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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

    
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        // checks if there is value, then if it's a Double value
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            print("text: \(text)")
            print("number: \(number)")
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }


    @IBAction func dismissKeyboard(_ send: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentLocal = Locale.current
        let decimalSeparator = currentLocal.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeprator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        if existingTextHasDecimalSeprator != nil, replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }


}

