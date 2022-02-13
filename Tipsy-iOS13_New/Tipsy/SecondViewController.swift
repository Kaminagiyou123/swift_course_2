//
//  SecondViewController.swift
//  Tipsy
//
//  Created by ran you on 2/12/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//


import UIKit

class SecondViewController: UIViewController {
    
    var tipPP : Double = 0.0
    var note: String = ""
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var noteLabel: UILabel!
    
    override func viewDidLoad() {
        amountLabel.text = String (format: "%.2f", tipPP)
        noteLabel.text = note
    }
    
    
    @IBAction func reCal(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
