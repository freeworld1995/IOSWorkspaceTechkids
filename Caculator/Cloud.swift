//
//  Cloud.swift
//  Caculator
//
//  Created by Jimmy Hoang on 12/24/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import UIKit

class Cloud: UIImageView {
    
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let vc = ViewController()
        
        UIView.animate(withDuration: 10,
                       delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: {
                        self.center.x += (vc.width + 100)
                        },
                       completion: nil
        )
        
    }
}
