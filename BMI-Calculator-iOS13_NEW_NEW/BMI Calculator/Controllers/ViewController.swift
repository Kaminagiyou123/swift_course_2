//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    var height:Float = 1.50
    var weight: Float = 100.0
    var bmi: Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        height =  sender.value
        heightLabel.text = String(format: " %.1fm", sender.value)
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        weight = sender.value
        weightLabel.text = String(format: " %.0fkg", sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
         bmi = weight/height/height
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToResult") {
            let VC = segue.destination as! ResultController
            
            VC.bmiValue = bmi
            
            let bmiBrain = BMIBrain(bmi: bmi)
            
            VC.adviceValue = bmiBrain.getAdvice()
            VC.backgroundColor = bmiBrain.getColor()
            
        }
    }
}

