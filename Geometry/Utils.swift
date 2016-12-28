//
//  Utils.swift
//  Geometry
//
//  Created by Jimmy Hoang on 12/26/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import UIKit

extension UITextField {
    static func create(at height: Int, borderStyle: UITextBorderStyle, view: UIView, text: String ) -> UITextField {
        let textfield = UITextField(frame: CGRect(x: 130, y: height, width: 97, height: 30))
        textfield.borderStyle = borderStyle
        textfield.text = text
        textfield.keyboardType = .decimalPad
        view.addSubview(textfield)
        return textfield
    }
}

extension UILabel {
    static func create (at height: Int, text: String, view: UIView) {
        let label = UILabel(frame: CGRect(x: 8, y: height, width: 120, height: 30))
        label.text = text
        view.addSubview(label)
    }
}

extension String {
    var toDouble: Double { return Double(self)! }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / .pi }
}

extension Double {
    var degreesToRadians: Double { return self * .pi / 180 }
    var radiansToDegrees: Double { return self * 180 / .pi }
}

