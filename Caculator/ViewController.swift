//
//  ViewController.swift
//  Caculator
//
//  Created by Jimmy Hoang on 12/23/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    var mathSign = ""
    var isTyping = false
    var clickedMathSign: Button?
    var triggerCaculateAfterMathSignPressed = false
    var isEqualPressed = false
    
    var width: CGFloat {
        return self.view.frame.size.width
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func numberPressed(_ sender: Button) {
        let digit = sender.currentTitle
        
        // Button pressed effect
        sender.hightlightButton()
        
        if isTyping {
            let addedNumber = display.text! + digit!
            display.text = addedNumber
        } else {
            display.text = digit
        }
        
        if isEqualPressed {
            model.result = 0.0
            model.inputMathSign = ""
            isEqualPressed = false
        }
        
        model.inputNumber = Double(display.text!)!
        print("inputNumer: \(model.inputNumber)")
        isTyping = true
    }
    
    let model = CaculatorModel()
    
    @IBAction func mathSignsPressed(_ sender: Button) {
        guard display.text != nil else {
            return
        }
        
        clickedMathSign?.borderColor = UIColor.gray
        
        highlightMathSignButton(button: sender)
        isTyping = false
        
        // Set input math sign to model
        
        
        model.performCaculate()
        model.inputMathSign = sender.currentTitle!
        display.text = String(model.result)
        print("result: \(model.result)")
        
    }
    
    var resultFromModel: Double {
        get {
            return Double(display.text!)!
        }
        
        set {
            display.text = String(newValue)
        }
    }
    
    @IBAction func PosNegaPressed(_ sender: Button) {
        guard display.text != "0" else {
            return
        }
        sender.hightlightButton()
        
        let PosNega = -Double(display.text!)!
        model.inputNumber = PosNega
        display.text = String(PosNega)
    }
    
    @IBAction func equalPressed(_ sender: Button) {
        guard display.text != nil else {
            return
        }
        
        isEqualPressed = true
        
        sender.hightlightButton()
        unhighlightMathSignButton(button: sender)
        isTyping = false
        
        // Do the caculation
        model.performCaculate()
        model.inputMathSign = "nothing"
        // Get result from model & display on View
        resultFromModel = model.result
    }
    
    func highlightMathSignButton(button: Button) {
        button.borderColor = UIColor.black
        clickedMathSign = button
    }
    
    func unhighlightMathSignButton(button: Button) {
        clickedMathSign?.borderColor = UIColor.gray
        clickedMathSign = nil
    }
    
    @IBAction func erase(_ sender: Button) {
        clickedMathSign?.borderColor = UIColor.gray
        display.text = "0"
        model.reset()
        isTyping = false
    }
}


