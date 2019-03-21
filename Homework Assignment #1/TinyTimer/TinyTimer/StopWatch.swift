//
//  StopWatch.swift
//  Tiny Timer
//
//  Created by Patrick Kalkman on 08/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import RxSwift

// The model of the application
class StopWatch {
   
   private let disposeBag = DisposeBag()
   
   var currentState : TinyTimerState = TinyTimerState.Init
   var currentTime : TimeSpan = TimeSpan()
   var stopWatchElapsedDelegate: StopWatchElapsedDelegate?
   
   var timerO: Observable<Int>
   
   init() {
      // create the timer
      timerO = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
      
      timerO.subscribe { (_) in
         if self.currentState == TinyTimerState.Running {
            self.currentTime.addSecond()
            // If no delegate is set we do nothing, otherwise we call the elapsed
            // function on the delegate
            if let delegate = self.stopWatchElapsedDelegate {
               delegate.elapsed()
            }
         }
      }
   }
   
   func setElapsedDelegate(stopWatchElapsedDelegate: StopWatchElapsedDelegate) {
      self.stopWatchElapsedDelegate = stopWatchElapsedDelegate
   }
   
   func start() {
     currentState = TinyTimerState.Running
   }
   
   func stop() {
      currentState = TinyTimerState.Paused
   }
   
   func reset() {
      currentState = TinyTimerState.Init
      currentTime.hours = 0
      currentTime.minutes = 0
      currentTime.seconds = 0
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
