//
//  TimeTriggeredDelegate.swift
//  Tiny Timer
//
//  Created by Patrick Kalkman on 09/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation

// The protocol that a class can implement to let the Stopwatch call the class
// when a second has elapsed
protocol StopWatchElapsedDelegate {
   func elapsed()
}
