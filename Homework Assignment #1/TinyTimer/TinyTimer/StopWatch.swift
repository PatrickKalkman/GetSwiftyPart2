//
//  StopWatch.swift
//  Tiny Timer
//
//  Created by Patrick Kalkman on 08/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

// The model of the application
class StopWatch {
   
   var currentState : TinyTimerState = TinyTimerState.Init
   var currentTime : TimeSpan = TimeSpan()
   var timer : Timer = Timer()
   var stopWatchElapsedDelegate: StopWatchElapsedDelegate?
   
   init() {
   }
   
   func setElapsedDelegate(stopWatchElapsedDelegate: StopWatchElapsedDelegate) {
      self.stopWatchElapsedDelegate = stopWatchElapsedDelegate
   }
   
   func start() {
     currentState = TinyTimerState.Running
     timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
   }
   
   func stop() {
      currentState = TinyTimerState.Paused
      timer.invalidate()
   }
   
   func reset() {
      currentState = TinyTimerState.Init
      timer.invalidate()
      currentTime.reset()
   }
   
   @objc func UpdateTimer() {
      currentTime.addSecond()
      // If no delegate is set we do nothing, otherwise we call the elapsed
      // function on the delegate
      if let delegate = self.stopWatchElapsedDelegate {
         delegate.elapsed()
      }
   }
   
   func formattedSeconds() -> String {
      return String(format: "%02i", currentTime.seconds)
   }

   func formattedMinutes() -> String {
      return String(format: "%02i", currentTime.minutes)
   }
   
   func formattedHours() -> String {
      return String(format: "%02i", currentTime.hours)
   }
}
