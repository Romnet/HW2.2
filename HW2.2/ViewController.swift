//
//  ViewController.swift
//  HW2.2
//
//  Created by Роман on 01.02.2020.
//  Copyright © 2020 Romnet. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var labelValueRed: UILabel!
    @IBOutlet var labelValueGreen: UILabel!
    @IBOutlet var labelValueBlue: UILabel!
    
    @IBOutlet var sliderRed: UISlider!
    @IBOutlet var sliderGreen: UISlider!
    @IBOutlet var sliderBlue: UISlider!
    
    @IBOutlet var textfieldRed: UITextField!
    @IBOutlet var textfieldGreen: UITextField!
    @IBOutlet var textfieldBlue: UITextField!
    
    @IBOutlet var viewColor: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderRed.minimumTrackTintColor = .red
        sliderGreen.minimumTrackTintColor = .green
        sliderBlue.minimumTrackTintColor = .blue
        
        for textfield in [textfieldRed, textfieldGreen, textfieldBlue] {
            textfield?.keyboardType = .decimalPad
            textfield?.delegate = self
            addDoneButtonOnKeyboard(for: textfield!)
        }
        
        addTapGestureToHideKeyboard()
    }
    
    @IBAction func sliderRedChanged() {
        let stringValue = String(format: "%.2f", sliderRed.value)
        labelValueRed.text = stringValue
        textfieldRed.placeholder = stringValue
        changeViewColor()
    }
    @IBAction func sliderGreenChanged() {
        let stringValue = String(format: "%.2f", sliderGreen.value)
        labelValueGreen.text = stringValue
        textfieldGreen.placeholder = stringValue
        changeViewColor()
    }
    @IBAction func sliderBlueChanged() {
        let stringValue = String(format: "%.2f", sliderBlue.value)
        labelValueBlue.text = stringValue
        textfieldBlue.placeholder = stringValue
        changeViewColor()
    }
    
    @IBAction func doneAction() {
        view.endEditing(true)
        
        // Замена запятую на точку - чтобы работало на устройстве с русской локалью
        if let valueRed = Float(textfieldRed.text?.replacingOccurrences(of: ",", with: ".") ?? ""), 0...1 ~= valueRed {
            sliderRed.setValue(valueRed, animated: true)
            sliderRedChanged()
        }
        if let valueGreen = Float(textfieldGreen.text?.replacingOccurrences(of: ",", with: ".") ?? ""), 0...1 ~= valueGreen {
            sliderGreen.setValue(valueGreen, animated: true)
            sliderGreenChanged()
        }
        if let valueBlue = Float(textfieldBlue.text?.replacingOccurrences(of: ",", with: ".") ?? ""), 0...1 ~= valueBlue {
            sliderBlue.setValue(valueBlue, animated: true)
            sliderBlueChanged()
        }
        
        textfieldRed.text = ""
        textfieldGreen.text = ""
        textfieldBlue.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let value = Float(textField.text?.replacingOccurrences(of: ",", with: ".") ?? ""), 0.0...1.0 ~= value {
            return true
        } else {
            showAlert(with: "Incorrect input", and: "Enter a number from 0 to 1")
            return false
        }
    }

    private func changeViewColor() {
        viewColor.backgroundColor = UIColor(
            red: CGFloat(sliderRed.value),
            green: CGFloat(sliderGreen.value),
            blue: CGFloat(sliderBlue.value),
            alpha: 1
        )
    }
    
    private func addDoneButtonOnKeyboard(for textField: UITextField) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = UIBarStyle.default

        doneToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
        ]

        doneToolbar.sizeToFit()
        textField.inputAccessoryView = doneToolbar
    }
    
    private func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(doneAction))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

