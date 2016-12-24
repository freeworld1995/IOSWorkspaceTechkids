//
//  CaculatorModel.swift
//  Caculator
//
//  Created by Jimmy Hoang on 12/23/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import UIKit

protocol TwoNumber {
    func caculateTwoNumber (num1: Double, num2: Double) -> Double
}

class CaculatorModel{
    
    var mathSignClicked = false
    var inputMathSign = ""
    var inputNumber = 0.0
    
    var result = 0.0
    
    let Operation = [
        "÷" : MathSigns.divide,
        "×" : MathSigns.multiply,
        "-" : MathSigns.subtract,
        "+" : MathSigns.addition,
        "=" : MathSigns.equal,
        "%" : MathSigns.percent
    ]
    
    enum MathSigns {
        case divide
        case multiply
        case subtract
        case addition
        case equal
        case percent
    }
    
    func performCaculate() {
        
        if inputMathSign == "" {
            result = inputNumber
        }
        
        if let mathSign = Operation[inputMathSign] {
            
            switch mathSign {
            case .divide:
                result = result / inputNumber
            case .multiply:
                result = result * inputNumber
            case .subtract:
                result = result - inputNumber
            case .addition:
                result = result + inputNumber
            case .percent:
                result = result / 100
            default:
                break
            }
        }
    }
    
    func reset() {
        result = 0.0
        inputNumber = 0.0
        inputMathSign = ""
    }
    
}


