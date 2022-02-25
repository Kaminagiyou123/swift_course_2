//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var trueButton: UIButton!
    
    @IBOutlet weak var falseButton: UIButton!
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle!
        let userGotItRight = quizBrain.checkAnswer(userAnswer)
        if userGotItRight {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        quizBrain.nextQuestion()
        scoreLabel.text = quizBrain.getScore()
       
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
        self.updateUI()
        }
    }
    
    func updateUI(){
        questionLabel.text = quizBrain.getQuestiontext()
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        progressBar.progress = quizBrain.getProgress()
    }
    
}

