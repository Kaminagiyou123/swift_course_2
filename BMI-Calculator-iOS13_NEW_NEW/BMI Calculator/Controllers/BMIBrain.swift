//
//  BMIBrain.swift
//  BMI Calculator
//
//  Created by ran you on 2/26/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct BMIBrain {
    var bmi: Float
    
    func getColor()-> UIColor {
        
        if bmi<20 {
        
           return .blue
            
        }else if bmi>24{
           
            return .red
            
        } else {
           
            return.green
        }
        
    }
    
    func getAdvice()-> String {
        
        if bmi<20 {
        
           return "EAT SOME SNACKS"
            
        }else if bmi>24{
           
            return "DO MORE EXERCISE"
            
        } else {
           
            return "YOU LOOK GOOD"
        }
        
    }
    
}
