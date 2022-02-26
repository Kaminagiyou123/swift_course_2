//
//  ResultController.swift
//  BMI Calculator
//
//  Created by ran you on 2/26/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//


import UIKit

class ResultController: UIViewController {
    
    var bmiValue:Float = 0.0
    var adviceValue: String = ""
    var backgroundColor: UIColor = .clear
    
    @IBOutlet weak var bmiLabel: UILabel!

    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiLabel.text = String(format: " %.1f", bmiValue)
        adviceLabel.text = adviceValue
        view.backgroundColor = backgroundColor
    
        
    }

    @IBAction func reCalculatePressed(_ sender: UIButton) {
       dismiss(animated: true, completion:nil)
    }
    
}
