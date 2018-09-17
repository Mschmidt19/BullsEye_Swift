//
//  ViewController.swift
//  BullsEye
//
//  Created by Marek Schmidt on 9/17/18.
//  Copyright © 2018 Marek Schmidt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0;
    var targetValue = 0;
    var sliderStartValue = 50;
    var score = 0;
    var round = 0;
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
        let roundedValue = slider.value.rounded();
        currentValue = Int(roundedValue);
        startNewGame();
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }

    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue);
        var points = 100 - difference;
        let title: String;
        
        if difference == 0 {
            title = "Perfect!";
            points += 100;
        } else if difference == 1 {
            title = "One away!";
            points += 50;
        } else if difference < 4 {
            title = "So close!";
        } else if difference < 9 {
            title = "Not Bad";
        } else if difference < 16 {
            title = "You can do better";
        } else {
            title = "Not even close..."
        }
        
        score += points;
        
        let message = "You scored \(points) points";
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        });
        
        alert.addAction(action);
        
        present(alert, animated: true, completion: nil);
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        
        let roundedValue = slider.value.rounded();
        
        currentValue = Int(roundedValue);
    }
    
    func startNewRound() {
        round += 1;
        targetValue = Int.random(in: 1...100);
        currentValue = sliderStartValue;
        slider.value = Float(currentValue);
        updateLabels();
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue);
        scoreLabel.text = String(score);
        roundLabel.text = String(round);
    }
    
    @IBAction func startNewGame() {
        score = 0;
        round = 0;
        startNewRound();
    }
    
}

