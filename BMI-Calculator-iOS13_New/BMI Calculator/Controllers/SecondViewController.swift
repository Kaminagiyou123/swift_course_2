//
//  secondViewController.swift
//  BMI Calculator
//
//  Created by ran you on 2/12/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var bmiValue:Float = 0.0
    var guideText:String = ""
    var guideColor:UIColor = .blue
    
    @IBOutlet weak var BMILabel: UILabel!
    
    @IBOutlet weak var guideLabel: UILabel!
    
    override func viewDidLoad() {
        BMILabel.text = String (format: "%.1f",bmiValue)
        guideLabel.text = guideText
        view.backgroundColor = guideColor
    }
    
    @IBAction func recalculate(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
