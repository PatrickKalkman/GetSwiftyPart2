//
//  SoundManager.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 19/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import SwiftySound

class SoundManager {

    private var shuffleSound: Sound?
    private var dealCardSound: Sound?
    private var chipSound: Sound?

    func prepare() {

        if let shuffleSoundUrl = Bundle.main.url(forResource: Constants.Assets.ShuffleSound, withExtension: Constants.Assets.SoundExtension) {
            shuffleSound = Sound(url: shuffleSoundUrl)!
            shuffleSound?.prepare()
        }

        if let dealCardSoundUrl = Bundle.main.url(forResource: Constants.Assets.CardSound, withExtension: Constants.Assets.SoundExtension) {
            dealCardSound = Sound(url: dealCardSoundUrl)!
            dealCardSound?.prepare()
        }

        if let chipSoundUrl = Bundle.main.url(forResource: Constants.Assets.AddChipSound, withExtension: Constants.Assets.SoundExtension) {
            chipSound = Sound(url: chipSoundUrl)!
            chipSound?.prepare()
        }
    }

    func isEnabled() -> Bool {
        return Sound.enabled
    }

    func playCard() {
        self.dealCardSound!.play(numberOfLoops: 0)
    }

    func playShuffle(completion: ((Bool) -> ())? = nil) {
        if let cmpl = completion {
            if Sound.enabled {
                self.shuffleSound!.play(numberOfLoops: 0, completion: cmpl)
            } else {
                cmpl(true)
            }
        } else {
            self.shuffleSound!.play(numberOfLoops: 0)
        }
    }

    func playChip() {
        self.chipSound!.play(numberOfLoops: 0)
    }

}
