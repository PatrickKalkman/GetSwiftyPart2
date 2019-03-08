//
//  ViewController.swift
//  TinyTimer
//
//  Created by Patrick Kalkman on 08/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit

enum TinyTimerState
{
    case Init
    case Running
    case Paused
}

class ViewController: UIViewController {

    var currentState : TinyTimerState = TinyTimerState.Init
    
    @IBOutlet weak var tinyTimerTitleLabel: UILabel!
    @IBOutlet weak var tinyTimerRunningLabel: UILabel!
    @IBOutlet weak var tinyTimerDescriptionLabel: UILabel!
    
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var hoursUnitLabel: UILabel!
    
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var minutesUnitLabel: UILabel!
    
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var secondUnitLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    override func viewDidLoad() {
        refreshUiState()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func refreshUiState()
    {
        switch currentState {
        case TinyTimerState.Init:
         tinyTimerTitleLabel.isHidden = false
         tinyTimerDescriptionLabel.isHidden = false
         startButton.isHidden = false
         
         tinyTimerRunningLabel.isHidden = true
         showStopwatchTimer(isHidden: true)
         
         resumeButton.isHidden = true
         stopButton.isHidden = true
         resetButton.isHidden = true
         pauseButton.isHidden = true
            
            
        case TinyTimerState.Running:
            tinyTimerTitleLabel.isHidden = true
            tinyTimerDescriptionLabel.isHidden = true
            startButton.isHidden = true
            
            tinyTimerRunningLabel.isHidden = false
            showStopwatchTimer(isHidden: false)
            
            resumeButton.isHidden = true
            stopButton.isHidden = false
            resetButton.isHidden = true
            pauseButton.isHidden = false
        case TinyTimerState.Paused:
            tinyTimerTitleLabel.isHidden = true
            tinyTimerDescriptionLabel.isHidden = true
            startButton.isHidden = true
            
            tinyTimerRunningLabel.isHidden = false
            showStopwatchTimer(isHidden: false)
            
            resumeButton.isHidden = false
            stopButton.isHidden = true
            resetButton.isHidden = false
            pauseButton.isHidden = true
        }
    }
    
    func showStopwatchTimer(isHidden: Bool) {
        hoursLabel.isHidden = isHidden
        hoursUnitLabel.isHidden = isHidden
        minutesLabel.isHidden = isHidden
        minutesUnitLabel.isHidden = isHidden
        secondsLabel.isHidden = isHidden
        secondUnitLabel.isHidden = isHidden
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        currentState = TinyTimerState.Running
        refreshUiState()
    }
    
    @IBAction func stopAction(_ sender: UIButton) {
        currentState = TinyTimerState.Init
        refreshUiState()
    }
    
    @IBAction func pauseAction(_ sender: UIButton) {
        currentState = TinyTimerState.Paused
        refreshUiState()
    }
    
    @IBAction func resumeAction(_ sender: UIButton) {
        currentState = TinyTimerState.Running
        refreshUiState()
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        currentState = TinyTimerState.Init
        refreshUiState()
    }
}

