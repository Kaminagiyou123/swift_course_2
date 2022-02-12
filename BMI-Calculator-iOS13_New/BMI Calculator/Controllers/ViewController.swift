//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var height :Float = 1.5
    var weight :Float = 100.0
    var bmi : Float = 0.0
    

    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSliderMoved(_ sender: UISlider) {
        height = sender.value
        heightLabel.text = String(format: "%.2f",sender.value)+"m"
    }
    
    @IBAction func weightSliderMoved(_ sender: UISlider) {
        weight = sender.value
        weightLabel.text = String(format: "%.0f",sender.value)+"Kg"
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        
        bmi =  weight/height/height
       
        self.performSegue(withIdentifier: "gotoBMI", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoBMI"{
           let destination = segue.destination as! SecondViewController
            destination.bmiValue = bmi
            if bmi < 20 {
                destination.guideText = "EAT SOME SNACKs"
                destination.guideColor = .blue
            } else if bmi > 25 {
                destination.guideText = "EXERCISE MORE"
                destination.guideColor = .red
            } else {
                destination.guideText = "YOU LOOK GREAT"
                destination.guideColor = .green
            }
        }
    }
    
}

