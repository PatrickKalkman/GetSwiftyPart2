//
//  TinyTimerState.swift
//  TinyTimer
//
//  Created by Patrick Kalkman on 08/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

// All the states of Tiny Timer
enum TinyTimerState
{
   // The timer is not running
   case Init
   // The timer is running
   case Running
   // The timer is running but is currently paused
   case Paused
}
