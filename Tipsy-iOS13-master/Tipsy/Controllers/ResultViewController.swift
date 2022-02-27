//
//  ResultViewController.swift
//  Tipsy
//
//  Created by ran you on 2/27/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

import UIKit

class ResultViewController: UIViewController {
    
    var Result: Float = 0.00
    var Instruction : String = ""
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var instructionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = String (format: "%.2f", Result)
        instructionLabel.text = Instruction
    }
    
    
    @IBAction func recalculate(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
