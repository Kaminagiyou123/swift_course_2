//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var billTotal :Double = 0.0
    var tipPercent :Float = 0.1
    var peopleNum : Int = 2
    var tipP : Double = 0.0
    
    @IBOutlet weak var billLabel: UITextField!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.minimumValue = 1
    }
    

    @IBAction func tipChosen(_ sender: UIButton) {
        
        
        
        if sender.currentTitle == "10%" {
            tipPercent = 0.1
        } else if  sender.currentTitle == "0%" {
            tipPercent = 0.0
        }
        else if  sender.currentTitle == "20%" {
            tipPercent = 0.2
        }
        sender.backgroundColor = .green
        sender.tintColor = .white
    }
    
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        valueLabel.text = String (format: "%.0f", sender.value)
        peopleNum = Int(sender.value)
    }
    
    @IBAction func calculate(_ sender: UIButton) {
   
        if let billTotal = Double(billLabel.text!) {
        
        tipP = billTotal * Double(tipPercent) / Double(peopleNum)
            print(tipP)
            self.performSegue(withIdentifier: "goToResult", sender: self)
            
        }
    }
        
     override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "goToResult" {

                    let destinationVC = segue.destination as! SecondViewController
                    destinationVC.tipPP = tipP
                    destinationVC.note = "Split between \(peopleNum) people, with \(tipPercent * 100)% tip."
                }
            }
      }
    

        


