//
//  TimeSpan.swift
//  TinyTimer
//
//  Created by Patrick Kalkman on 08/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

struct TimeSpan {
   var hours: UInt8
   var minutes: UInt8
   var seconds: UInt8
   
   init() {
      seconds = 0
      minutes = 0
      hours = 0
   }
   
   mutating func addSecond()
   {
      seconds = seconds + 1;
      if (seconds > 59) {
         minutes = minutes + 1;
         seconds = 0
         if (minutes > 60) {
            minutes = 0
            hours = hours + 1
            if (hours > 99) {
               hours = 0
            }
         }
      }
   }
   
   mutating func reset() {
      seconds = 0
      minutes = 0
      hours = 0
   }
}
