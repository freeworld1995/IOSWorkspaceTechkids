//
//  WarmUpViewController.swift
//  Caculator
//
//  Created by Jimmy Hoang on 12/24/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import UIKit
import GameplayKit

class WarmUpViewController: UIViewController {

    var increment = 0
    @IBOutlet weak var randLabel: UILabel!
    
    @IBAction func touchMe(_ sender: UIButton) {
        increment += 1
        sender.setTitle(String(increment), for: .normal)
    }
    
    @IBAction func random(_ sender: UIButton) {
        let randNumber = GKRandomDistribution(randomSource: GKARC4RandomSource(), lowestValue: 0, highestValue: 999)
        randLabel.text = String(randNumber.nextInt())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
