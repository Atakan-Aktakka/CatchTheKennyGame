//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Atakan Aktakka on 1.09.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var haydo1: UIImageView!
    @IBOutlet weak var haydo2: UIImageView!
    @IBOutlet weak var haydo3: UIImageView!
    @IBOutlet weak var haydo4: UIImageView!
    @IBOutlet weak var haydo5: UIImageView!
    @IBOutlet weak var haydo6: UIImageView!
    @IBOutlet weak var haydo7: UIImageView!
    @IBOutlet weak var haydo8: UIImageView!
    @IBOutlet weak var haydo9: UIImageView!
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var haydoArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scoreLabel.text="Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil{
            highScore = 0
            highscoreLabel.text = "Highscore: \(self.highScore)"
        }
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highscoreLabel.text = "Highscore: \(self.highScore)"
        }
        
        haydo1.isUserInteractionEnabled = true
        haydo2.isUserInteractionEnabled = true
        haydo3.isUserInteractionEnabled = true
        haydo4.isUserInteractionEnabled = true
        haydo5.isUserInteractionEnabled = true
        haydo6.isUserInteractionEnabled = true
        haydo7.isUserInteractionEnabled = true
        haydo8.isUserInteractionEnabled = true
        haydo9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        haydo1.addGestureRecognizer(recognizer1)
        haydo2.addGestureRecognizer(recognizer2)
        haydo3.addGestureRecognizer(recognizer3)
        haydo4.addGestureRecognizer(recognizer4)
        haydo5.addGestureRecognizer(recognizer5)
        haydo6.addGestureRecognizer(recognizer6)
        haydo7.addGestureRecognizer(recognizer7)
        haydo8.addGestureRecognizer(recognizer8)
        haydo9.addGestureRecognizer(recognizer9)
        
        haydoArray = [haydo1, haydo2, haydo3, haydo4, haydo5, haydo6, haydo7, haydo8, haydo9]
        //Timers
        counter = 10
        timeLabel.text = "Timer: \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        hideKenny()
        
            }
    @objc func hideKenny(){
        
        for haydo in haydoArray{
            haydo.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(haydoArray.count - 1)))
        haydoArray[random].isHidden = false
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text="Score: \(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = "Timer: \(counter)"
        
        if counter == 0{
            timer.invalidate()
            hideTimer.invalidate()
            
            for haydo in haydoArray{
                haydo.isHidden = true
            }
            
            //High Score
            
            if self.score > self.highScore{
                
                self.highScore = self.score
                highscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            let alert = UIAlertController(title: "Time is up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                //replay button
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = "Timer: \(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true,completion: nil)
        }
        
    }

}

