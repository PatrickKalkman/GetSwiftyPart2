//
//  ViewController.swift
//  TinyTimer
//
//  Created by Patrick Kalkman on 08/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit

// The main and single view controller of the application
class ViewController: UIViewController, StopWatchElapsedDelegate {

   // Stopwatch labels
   @IBOutlet weak var hoursLabel: UILabel!
   @IBOutlet weak var hoursUnitLabel: UILabel!
   @IBOutlet weak var minutesLabel: UILabel!
   @IBOutlet weak var minutesUnitLabel: UILabel!
   @IBOutlet weak var secondsLabel: UILabel!
   @IBOutlet weak var secondUnitLabel: UILabel!
   @IBOutlet weak var pausedLabel: UILabel!
   @IBOutlet weak var tinyTimerDescriptionLabel: UILabel!
   
   // Stopwatch buttons
   @IBOutlet weak var startButton: UIButton!
   @IBOutlet weak var resumeButton: UIButton!
   @IBOutlet weak var stopButton: UIButton!
   @IBOutlet weak var resetButton: UIButton!

   // The model of the application
   var stopWatch : StopWatch = StopWatch()
   
   override func viewDidLoad() {
      stopWatch.setElapsedDelegate(stopWatchElapsedDelegate: self)
      refreshUI()
      super.viewDidLoad()
   }
   
   @IBAction func startAction(_ sender: UIButton) {
      stopWatch.start()
      refreshUI()
   }

   @IBAction func stopAction(_ sender: UIButton) {
      stopWatch.stop()
      refreshUI()
   }

   @IBAction func resumeAction(_ sender: UIButton) {
      stopWatch.start()
      refreshUI()
   }

   @IBAction func resetAction(_ sender: UIButton) {
      stopWatch.reset()
      refreshUI()
   }
   
   // The stopwatch model calls this method every second
   func elapsed() {
      refreshStopWatchView()
   }
   
   func refreshUI() {
      // Retrieve the state from the model
      let state: TinyTimerState = stopWatch.currentState

      // Reorganize the UI based on the state of the stopwatch model
      startButton.hideWithAnimation(hidden: state != TinyTimerState.Init)
      resetButton.hideWithAnimation(hidden: state != TinyTimerState.Paused)
      tinyTimerDescriptionLabel.hideWithAnimation(hidden: state != TinyTimerState.Init)
      pausedLabel.hideWithAnimation(hidden: state != TinyTimerState.Paused)
      resumeButton.hideWithAnimation(hidden: state != TinyTimerState.Paused)
      stopButton.hideWithAnimation(hidden: state != TinyTimerState.Running)
      showStopwatchTimer(isHidden: state == TinyTimerState.Init)

      refreshStopWatchView()
   }

   func refreshStopWatchView() {
      // refresh the stop watch view by retrieving the formatted values from
      // the model and animate to the next string
      let transitionTime : Double = 0.6
      secondsLabel.fadeTransition(transitionTime)
      secondsLabel.text = stopWatch.formattedSeconds()
      minutesLabel.fadeTransition(transitionTime)
      minutesLabel.text = stopWatch.formattedMinutes()
      hoursLabel.fadeTransition(transitionTime)
      hoursLabel.text = stopWatch.formattedHours()
   }

   func showStopwatchTimer(isHidden: Bool) {
      // Reorganize the timer UI
      hoursLabel.hideWithAnimation(hidden: isHidden)
      hoursUnitLabel.hideWithAnimation(hidden: isHidden)
      minutesLabel.hideWithAnimation(hidden: isHidden)
      minutesUnitLabel.hideWithAnimation(hidden: isHidden)
      secondsLabel.hideWithAnimation(hidden: isHidden)
      secondUnitLabel.hideWithAnimation(hidden: isHidden)
   }
}
