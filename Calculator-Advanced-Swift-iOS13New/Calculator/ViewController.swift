//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    var isFinishedTyping = true
    
    var toBeCalculated: (Double,String) = (0,"")
    
    var labelValue:Double {
        get {
            return Double(displayLabel.text!)!
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    

    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        isFinishedTyping = true
        if sender.currentTitle == "AC"{
            labelValue = 0
        }
        else if sender.currentTitle == "+/-"{
            labelValue = -labelValue
        }
        else if sender.currentTitle == "%"{
            labelValue = 0.01*labelValue
        } else if sender.currentTitle == "="{
            if toBeCalculated.1 == "+" {
                labelValue = toBeCalculated.0+labelValue
            } else if toBeCalculated.1 == "-" {
                labelValue = toBeCalculated.0-labelValue
            } else if toBeCalculated.1 == "×" {
                labelValue = toBeCalculated.0 * labelValue
            } else {
                labelValue = toBeCalculated.0 / labelValue
            }
            
            
        } else {
            toBeCalculated = (labelValue,sender.currentTitle!)
        }
    
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        if sender.currentTitle == ".", floor(labelValue) != labelValue {
            return
        }
        
        if isFinishedTyping == false {
            displayLabel.text!.append (sender.currentTitle!)
        } else {
            displayLabel.text = sender.currentTitle!
            isFinishedTyping = false
        }
    
    }

}

