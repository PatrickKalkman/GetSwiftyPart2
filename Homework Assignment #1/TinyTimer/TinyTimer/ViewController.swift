//
//  ViewController.swift
//  TinyTimer
//
//  Created by Patrick Kalkman on 08/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentState : TinyTimerState = TinyTimerState.Init
    var timer: Timer = Timer()
   
    @IBOutlet weak var tinyTimerRunningLabel: UILabel!
    @IBOutlet weak var tinyTimerDescriptionLabel: UILabel!
    
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var hoursUnitLabel: UILabel!
    
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var minutesUnitLabel: UILabel!
    
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var secondUnitLabel: UILabel!
    @IBOutlet weak var pausedLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    override func viewDidLoad() {
        refreshUiState()
        super.viewDidLoad()
    }

    func showStopwatchTimer(isHidden: Bool) {
        hoursLabel.hideWithAnimation(hidden: isHidden)
        hoursUnitLabel.hideWithAnimation(hidden: isHidden)
        minutesLabel.hideWithAnimation(hidden: isHidden)
        minutesUnitLabel.hideWithAnimation(hidden: isHidden)
        secondsLabel.hideWithAnimation(hidden: isHidden)
        secondUnitLabel.hideWithAnimation(hidden: isHidden)
    }
   
   var stopWatchTime : TimeSpan = TimeSpan()
   
   @objc func UpdateTimer() {
      stopWatchTime.addSecond()
      refreshStopWatchView()
   }
   
   func refreshStopWatchView() {
      secondsLabel.fadeTransition(0.6)
      secondsLabel.text = String(format: "%02i", stopWatchTime.seconds)
      minutesLabel.fadeTransition(0.6)
      minutesLabel.text = String(format: "%02i", stopWatchTime.minutes)
      hoursLabel.fadeTransition(0.6)
      hoursLabel.text = String(format: "%02i", stopWatchTime.hours)
   }
   
    @IBAction func startAction(_ sender: UIButton) {
        currentState = TinyTimerState.Running
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        refreshUiState()
    }
    
    @IBAction func stopAction(_ sender: UIButton) {
        currentState = TinyTimerState.Init
        timer.invalidate()
        stopWatchTime.reset()
        refreshUiState()
    }
    
    @IBAction func pauseAction(_ sender: UIButton) {
        currentState = TinyTimerState.Paused
        timer.invalidate()
        refreshUiState()
    }
    
    @IBAction func resumeAction(_ sender: UIButton) {
        currentState = TinyTimerState.Running
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        refreshUiState()
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        currentState = TinyTimerState.Init
        timer.invalidate()
        stopWatchTime.reset()
        refreshUiState()
    }
   
   func refreshUiState()
   {
      switch currentState {
      case TinyTimerState.Init:
         refreshStopWatchView()
         tinyTimerDescriptionLabel.hideWithAnimation(hidden: false)
         startButton.hideWithAnimation(hidden: false)
         
         tinyTimerRunningLabel.hideWithAnimation(hidden: false)
         
         resumeButton.hideWithAnimation(hidden: true)
         stopButton.hideWithAnimation(hidden: true)
         resetButton.hideWithAnimation(hidden: true)
         pauseButton.hideWithAnimation(hidden: true)
         pausedLabel.hideWithAnimation(hidden: true)
         
         showStopwatchTimer(isHidden: true)
      case TinyTimerState.Running:
         refreshStopWatchView()
         tinyTimerDescriptionLabel.hideWithAnimation(hidden: true)
         startButton.hideWithAnimation(hidden: true)
         
         tinyTimerRunningLabel.hideWithAnimation(hidden: false)
   
         resumeButton.hideWithAnimation(hidden: true)
         stopButton.hideWithAnimation(hidden: false)
         resetButton.hideWithAnimation(hidden: true)
         pauseButton.hideWithAnimation(hidden: false)
         pausedLabel.hideWithAnimation(hidden: true)
         
         showStopwatchTimer(isHidden: false)
      case TinyTimerState.Paused:
         refreshStopWatchView()
         tinyTimerDescriptionLabel.hideWithAnimation(hidden: true)
         startButton.hideWithAnimation(hidden: true)
         
         tinyTimerRunningLabel.isHidden = false
         showStopwatchTimer(isHidden: false)
         
         pausedLabel.hideWithAnimation(hidden: false)
         resumeButton.hideWithAnimation(hidden: false)
         stopButton.hideWithAnimation(hidden: true)
         resetButton.hideWithAnimation(hidden: false)
         pauseButton.hideWithAnimation(hidden: true)
      }
   }
   
}


