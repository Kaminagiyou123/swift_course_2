//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billLabel: UITextField!
    @IBOutlet weak var zeroP: UIButton!
    @IBOutlet weak var TenP: UIButton!
    @IBOutlet weak var twentyP: UIButton!
    @IBOutlet weak var personLabel: UILabel!
    
    var tip: Float = 0.1
    var bill: Float = 0.0
    var person:Int = 2
    var result:Float = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroP.isSelected = false
        TenP.isSelected = false
        twentyP.isSelected = false
        
        sender.isSelected = true
        
        if sender.titleLabel!.text == "0%" {
            tip = 0.0
        } else if sender.titleLabel!.text == "10%" {
            tip = 0.1
        } else {
            tip = 0.2
        }
        
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        person = Int(sender.value)
        personLabel.text = String(Int(sender.value))
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
 
        if let bill = Float(billLabel.text!){
            result = bill*tip/Float(person)
        }
        performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let resultVC = segue.destination as! ResultViewController
            let tipString = String(format:"%.0f",tip*100 )
            
            resultVC.Result = result
            resultVC.Instruction = "Split between \(person) people, with \(tipString)% tip."
        }
    }
    
}

