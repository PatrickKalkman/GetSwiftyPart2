//
//  ProposedActionMessageMapper.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 18/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import NotificationBannerSwift

class ProposedActionNotification {
    
    func showMessage(userAction: ProposedAction, proposedAction: ProposedAction) {
        var message: String
        var bannerStyle: BannerStyle
        var leftView: UIImageView
        var dismissInSeconds: Double
        if isCorrect(userAction, proposedAction) {
            message = "Correct! Basic Strategy says to \(map(proposedAction))"
            bannerStyle = BannerStyle.success
            leftView = UIImageView(image: #imageLiteral(resourceName: "checked"))
            dismissInSeconds = Double(SettingsBundleHelper.getNotificationTimeout())
        } else {
            message = "Basic Strategy says to \(map(proposedAction))"
            bannerStyle = BannerStyle.warning
            leftView = UIImageView(image: #imageLiteral(resourceName: "warning"))
            dismissInSeconds = Double(SettingsBundleHelper.getNotificationTimeout() + 1)
        }
        
        let banner = GrowingNotificationBanner(title: message, subtitle: "", leftView: leftView, style: bannerStyle)
        banner.show(bannerPosition: BannerPosition.bottom)
        
        Timer.scheduledTimer(withTimeInterval: dismissInSeconds, repeats: false) { _ in
            banner.dismiss()
        }
        
    }
    
    private func isCorrect(_ userAction: ProposedAction, _ proposedAction: ProposedAction) -> Bool {
        
        if proposedAction == ProposedAction.doubleOrHit {
            return userAction == ProposedAction.double || userAction == ProposedAction.hit
        }
        
        if proposedAction == ProposedAction.doubleOrStand {
            return userAction == ProposedAction.double || userAction == ProposedAction.stand
        }
        
        if proposedAction == ProposedAction.splitOrHit {
            return userAction == ProposedAction.split || userAction == ProposedAction.hit
        }

        if proposedAction == ProposedAction.surrenderOrHit {
            return userAction == ProposedAction.surrender || userAction == ProposedAction.hit
        }

        if proposedAction == ProposedAction.surrenderOrSplit {
            return userAction == ProposedAction.surrender || userAction == ProposedAction.split
        }

        if proposedAction == ProposedAction.surrenderOrStand {
            return userAction == ProposedAction.surrender || userAction == ProposedAction.stand
        }

        return userAction == proposedAction
        
    }
    
    func map(_ action: ProposedAction) -> String {
        
        var message: String
        
        switch action {
        case ProposedAction.blackjack:
            message = "Blackjack"
        case ProposedAction.bust:
            message = "Bust"
        case ProposedAction.dontknow:
            message = "Don't know"
        case ProposedAction.double:
            message = "Double"
        case ProposedAction.doubleOrHit:
            message = "Double or Hit"
        case ProposedAction.doubleOrStand:
            message = "Double or Stand"
        case ProposedAction.hit:
            message = "Hit"
        case ProposedAction.split:
            message = "Split"
        case ProposedAction.splitOrHit:
            message = "Split or Hit"
        case ProposedAction.stand:
            message = "Stand"
        case ProposedAction.surrender:
            message = "Surrender"
        case ProposedAction.surrenderOrHit:
            message = "Surrender or Hit"
        case ProposedAction.surrenderOrSplit:
            message = "Surrender or Split"
        case ProposedAction.surrenderOrStand:
            message = "Surrender or Stand"
        }
        
        return message
    }
}
