//
//  Button.swift
//  Caculator
//
//  Created by Jimmy Hoang on 12/23/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import UIKit

typealias highlightType = () -> ()

@IBDesignable
class Button: UIButton {

    var hightlightButton: highlightType = {}
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        borderWidth = 0.8
        borderColor = UIColor.gray
      
        hightlightButton = { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.8,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 17.0,
                           options: .allowUserInteraction,
                           animations: { [unowned self] in
                            self.transform = .identity
                            },
                           completion: nil)
        }
    }

}
