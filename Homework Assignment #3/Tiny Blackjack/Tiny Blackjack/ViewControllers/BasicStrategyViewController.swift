//
//  BasicStrategyViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 14/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit
import SwiftySound
import Hero

class BasicStrategyViewController: UIViewController, BlackjackViewProtocol {
    
    private let cardToImageNameMapper: CardToImageNameMapper = CardToImageNameMapper()
    private let proposedActionNotification: ProposedActionNotification = ProposedActionNotification()
    private let valueToChipMapper: ValueToChipMapper = ValueToChipMapper()
    private let imageCardFaceDown: UIImage = UIImage(named: Constants.Assets.FacedownCard)!
    private var gameEngine: GameEngine!
    private var shuffleSound: Sound?
    private var dealCardSound: Sound?
    
    private var addedCards: [UIImageView] = [UIImageView]()
    
    private var dealerCard2ImageView: UIImageView!
    
    @IBOutlet weak var deckCard: UIImageView!
    @IBOutlet weak var dealButton: BorderButton!
    @IBOutlet weak var splitButton: BorderButton!
    @IBOutlet weak var standButton: BorderButton!
    @IBOutlet weak var hitButton: BorderButton!
    @IBOutlet weak var playerValueLabel: UILabel!
    @IBOutlet weak var dealerValueLabel: UILabel!
    @IBOutlet weak var restartButton: BorderButton!
    @IBOutlet weak var playResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.hero.id = "test"
               
        self.navigationItem.title = "LEARN BASIC STRATEGY"
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
          statusBar.backgroundColor = UIColor.clear
        }
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:Constants.Colors.LightGreen]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        if let shuffleSoundUrl = Bundle.main.url(forResource: Constants.Assets.ShuffleSound, withExtension: Constants.Assets.SoundExtension) {
            shuffleSound = Sound(url: shuffleSoundUrl)!
            shuffleSound?.prepare()
        }
        
        if let dealCardSoundUrl = Bundle.main.url(forResource: Constants.Assets.CardSound, withExtension: Constants.Assets.SoundExtension) {
            dealCardSound = Sound(url: dealCardSoundUrl)!
            dealCardSound?.prepare()
        }
        
        gameEngine = GameEngine(gameResultCalculator: GameResultCalculator(), blackjackView: self)
        self.gameEngine.start(numberOfPlayers: 1)
        self.organizeUiBasedOnState(state: GameStates.started)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func deal(_ sender: Any) {
        if !Sound.enabled {
            self.gameEngine.triggerEvent(GameEvents.betsPlaced)
            self.gameEngine.triggerEvent(GameEvents.dealCards)
        } else {
            shuffleSound!.play(numberOfLoops: 0, completion: { _ in
                self.gameEngine.triggerEvent(GameEvents.betsPlaced)
                self.gameEngine.triggerEvent(GameEvents.dealCards)
            })
        }
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        playerCardIndex = 2
        dealerCardIndex = 1
        
        for subview in addedCards {
            subview.removeFromSuperview()
        }
        
        restartButton.isHidden = true
        self.organizeUiBasedOnState(state: GameStates.started)
        self.gameEngine.restart()
        self.deal(sender)
    }
    
    @IBAction func hitPlayer(_ sender: Any) {
        showLearningMessage(userAction: ProposedAction.hit)
        gameEngine.triggerEvent(GameEvents.hitPlayer)
    }
    
    @IBAction func standPlayer(_ sender: Any) {
        showLearningMessage(userAction: ProposedAction.stand)
        gameEngine.triggerEvent(GameEvents.standPlayer)
    }
    
    @IBAction func splitPlayer(_ sender: Any) {
        showLearningMessage(userAction: ProposedAction.split)
        gameEngine.triggerEvent(GameEvents.splitPlayerHand)
    }
    
    func showLearningMessage(userAction: ProposedAction) {
        if let basicStrategyProposedAction: ProposedAction = gameEngine.getProposedAction() {
            proposedActionNotification.showMessage(userAction: userAction, proposedAction: basicStrategyProposedAction)
        }
    }
    
    func organizeUiBasedOnState(state: GameStates) {
        print("Organizing UI for state: \(state)")
        switch state {
        case GameStates.waitingForStart:
            dealButton.isHidden = false
            splitButton.isHidden = true
            hitButton.isHidden = true
            standButton.isHidden = true
            playerValueLabel.isHidden = true
            dealerValueLabel.isHidden = true
            restartButton.isHidden = true
            playResultLabel.isHidden = true
            self.navigationItem.title = "LEARN BASIC STRATEGY"
        case GameStates.started:
            self.dealButton.isHidden = false
            self.restartButton.isHidden = true
            playResultLabel.isHidden = true
            playerValueLabel.isHidden = true
            dealerValueLabel.isHidden = true
        case GameStates.dealCards:
            playerValueLabel.isHidden = true
            dealerValueLabel.isHidden = true
            dealButton.isHidden = true
            splitButton.isHidden = true
            hitButton.isHidden = false
            standButton.isHidden = false
            restartButton.isHidden = true
            playResultLabel.isHidden = true
            self.navigationItem.title = ""
            
        case GameStates.distributeBets:
            dealButton.isHidden = true
            splitButton.isHidden = true
            hitButton.isHidden = true
            standButton.isHidden = true
            restartButton.isHidden = false
            playResultLabel.isHidden = false
            self.navigationItem.title = ""
        default:
            print("do nothing")
        }
    }
    
    func start() {
    }
    
    func shuffle() {
    }
    
    func placeBets() {
    }
    
    func enableSplit() {
        splitButton.isHidden = false
    }
    
    func dealCards() {
        
        // The game engine already has dealt the cards
        // Here we instruct the UI to show the dealing of the first cards using animation
        self.dealButton.isHidden = true
        self.organizeUiBasedOnState(state: GameStates.dealCards)
        
        let player1Card1ImageView: UIImageView = getNewCardFromDeckFaceDown()
        let card1: Card = gameEngine.getPlayerCard(playerIndex: 0, handIndex: 0, cardIndex: 0)
        player1Card1ImageView.tag = card1.index
        let imageCardFaceUp: UIImage = getCardImage(card1)
        
        let player1Card2ImageView: UIImageView = getNewCardFromDeckFaceDown()
        let card2: Card = self.gameEngine.getPlayerCard(playerIndex: 0, handIndex: 0, cardIndex: 1)
        player1Card2ImageView.tag = card2.index
        let imageCard2FaceUp: UIImage = getCardImage(card2)
        
        UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
            player1Card1ImageView.setOrigin(Constants.Positions.FirstPlayerCard)
        }, completion: { _ in
            
            UIImageView.transition(with: player1Card1ImageView, duration: Constants.Animation.FlipCardDuration,
                                   options: .transitionFlipFromLeft, animations: { player1Card1ImageView.image = imageCardFaceUp },
                                   completion: { _ in
                                    
                                    self.dealCardSound!.play(numberOfLoops: 0)
                                    
                                    let dealerCard1ImageView: UIImageView = self.getNewCardFromDeckFaceDown()
                                    let dealerCard1FaceUp: UIImage = self.getCardImage(self.gameEngine.getDealerCard(cardIndex: 0))
                                    
                                    UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
                                        dealerCard1ImageView.setOrigin(Constants.Positions.FirstDealerCard)
                                    }, completion: { _ in
                                        
                                        self.dealCardSound!.play(numberOfLoops: 0)
                                        UIImageView.transition(with: dealerCard1ImageView, duration: Constants.Animation.FlipCardDuration, options: .transitionFlipFromLeft,
                                                               animations: { dealerCard1ImageView.image = dealerCard1FaceUp },
                                                               completion: { _ in
                                                                
                                                                UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
                                                                    player1Card2ImageView.setOrigin(Constants.Positions.SecondPlayerCard)
                                                                }, completion: { _ in
                                                                    self.dealCardSound!.play(numberOfLoops: 0)
                                                                    UIImageView.transition(with: player1Card2ImageView,
                                                                                           duration: Constants.Animation.FlipCardDuration, options: .transitionFlipFromLeft,
                                                                                           animations: { player1Card2ImageView.image = imageCard2FaceUp },
                                                                                           completion: { _ in
                                                                                            
                                                                                            self.dealerCard2ImageView = self.getNewCardFromDeckFaceDown()
                                                                                            
                                                                                            UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0.1, options: .curveEaseInOut, animations: {
                                                                                                self.dealerCard2ImageView.setOrigin(Constants.Positions.SecondDealerCard)
                                                                                            }, completion: { _ in
                                                                                                
                                                                                                self.gameEngine.triggerEvent(GameEvents.dealt)
                                                                                                self.showAndRefreshValues()
                                                                                            })
                                                                    })
                                                                })
                                        })
                                    })
            })
        })
    }
    
    func showSplittedHand() {
        
        // Hand is already splitted, show the splitted hand
        let nextHand = gameEngine.getNextHand()
        moveHand(handToMove: nextHand, xMove: 0, yMove: 210, completion: { _ in
            let currentHand = self.gameEngine.getCurrentHand()
            self.moveHand(handToMove: currentHand, xMove: -40, yMove: 0, completion: { _ in
                self.gameEngine.triggerEvent(GameEvents.playerShowSplittedHandFinished)
                self.organizeUiBasedOnState(state: GameStates.dealCards)
                self.playerCardIndex = 1
            })
        })
    }
    
    func noMoreMoney() {
    }
    
    func dealerBlackjackTest() {
    }
    
    func selectPlayer() {
    }
    
    func calculateResult() {
        
        self.dealerValueLabel.text = self.gameEngine.getDealerValueString()
        // Calculate results
        let result: [HandResult] = gameEngine.getPlayResult()
        var resultString: String
        switch result[0].result {
        case GameResult.DealerWins:
            resultString = "The dealer wins"
        case GameResult.PlayerWins:
            resultString = "You win!"
        case GameResult.Push:
            resultString = "Push"
        case GameResult.PlayerWinsWithBlackjack:
            resultString = "You win (Blackjack!)"
        }
        playResultLabel.text = resultString
    }
    
    func selectHand(cardIndex: Int, previousHand: Hand?, currentHand: Hand?) {
        
        // Move previous hand to side spot and move current to main spot
        self.moveHand(handToMove: previousHand, xMove: -360, yMove: -130, completion: { _ in
            self.playerCardIndex = cardIndex
            self.showAndRefreshValues()
        })
        
        moveHand(handToMove: currentHand, xMove: 0, yMove: -210)
        
        print("Select hand with cardIndex \(cardIndex)")
        self.gameEngine.triggerEvent(GameEvents.playerHandSelected)
    }
    
    func playerGetChoice() {
    }
    
    var dealerCardIndex: Int = 1
    
    func dealerStart() {
        let dealerCardFaceUp: UIImage = getCardImage(self.gameEngine.getDealerCard(cardIndex: dealerCardIndex))
        self.dealCardSound!.play(numberOfLoops: 0)
        UIImageView.transition(with: dealerCard2ImageView, duration: Constants.Animation.FlipCardDuration,
                               options: .transitionFlipFromLeft, animations: { self.dealerCard2ImageView.image = dealerCardFaceUp },
                               completion: { _ in
                                self.dealerCardIndex += 1
                                self.showAndRefreshValues()
                                self.gameEngine.triggerEvent(GameEvents.turnDealerCardFaceUp)
        })
    }
    
    func showDealerHasBlackjack() {
        let dealerCardFaceUp: UIImage = getCardImage(self.gameEngine.getDealerCard(cardIndex: dealerCardIndex))
        
        UIImageView.transition(with: dealerCard2ImageView, duration: Constants.Animation.FlipCardDuration,
                               options: .transitionFlipFromLeft, animations: { self.dealerCard2ImageView.image = dealerCardFaceUp },
                               completion: { _ in
                                self.showAndRefreshValues()
                                self.gameEngine.triggerEvent(GameEvents.dealerHasBlackjackIsShown)
        })
    }
    
    func dealerGetChoice() {
    }
    
    var playerCardIndex: Int = 2
    
    func hitPlayer() {
        guard let currentHand = gameEngine.getCurrentHand() else { return }
        
        let newCard: Card = currentHand.getCard(cardIndex: playerCardIndex)
        let imageCardFaceUp: UIImage = getCardImage(newCard)
        let playerCardImageView: UIImageView = getNewCardFromDeckFaceDown()
        playerCardImageView.tag = newCard.index
        
        UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
            playerCardImageView.frame.origin.y = Constants.Positions.FirstCardY
            playerCardImageView.frame.origin.x = CGFloat(Constants.Positions.FirstCardX + CGFloat(self.playerCardIndex) * Constants.Positions.CardXDifference)
        }, completion: { _ in
            self.dealCardSound!.play(numberOfLoops: 0)
            UIImageView.transition(with: playerCardImageView, duration: Constants.Animation.FlipCardDuration, options: .transitionFlipFromLeft,
                                   animations: { playerCardImageView.image = imageCardFaceUp }, completion: { _ in
                                    
                                    self.playerCardIndex += 1
                                    self.showAndRefreshValues()
                                    self.gameEngine.triggerEvent(GameEvents.playerChoose)
            })
            
        })
    }
    
    func playerDoubleDown() {
    }
    
    func splitHand() {
    }
    
    func hitDealer() {
        let imageCardFaceUp: UIImage = getCardImage(gameEngine.getDealerCard(cardIndex: dealerCardIndex))
        let dealerCardImageView: UIImageView = getNewCardFromDeckFaceDown()
        
        UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
            dealerCardImageView.frame.origin.y = 80
            dealerCardImageView.frame.origin.x = CGFloat(400 + self.dealerCardIndex * 40)
        }, completion: { _ in
            self.dealCardSound!.play(numberOfLoops: 0)
            UIImageView.transition(with: dealerCardImageView, duration: Constants.Animation.FlipCardDuration,
                                   options: .transitionFlipFromLeft, animations: { dealerCardImageView.image = imageCardFaceUp },
                                   completion: { _ in
                                    self.dealerCardIndex += 1
                                    self.showAndRefreshValues()
                                    self.gameEngine.triggerEvent(GameEvents.dealerChoose)
                                    
            })
            
        })
    }
    
    func distributeBets() {
        organizeUiBasedOnState(state: GameStates.distributeBets)
    }
    
    func getNewCardFromDeckFaceDown() -> UIImageView {
        let cardImageView: UIImageView = UIImageView(image: imageCardFaceDown)
        cardImageView.frame = CGRect(x: deckCard.frame.origin.x, y: deckCard.frame.origin.y, width: deckCard.frame.size.width, height: deckCard.frame.size.height)
        addedCards.append(cardImageView)
        view.addSubview(cardImageView)
        return cardImageView
    }
    
    func getCardImage(_ card: Card) -> UIImage {
        let imageName: String = cardToImageNameMapper.map(card)
        return UIImage(named: imageName)!
    }
    
    func showAndRefreshValues() {
        self.playerValueLabel.text = self.gameEngine.getPlayerValueString()
        self.dealerValueLabel.text = self.gameEngine.getDealerValueString()
        self.playerValueLabel.isHidden = false
        self.dealerValueLabel.isHidden = false
    }
    
    func moveHand(handToMove: Hand?, xMove: CGFloat, yMove: CGFloat, completion: ((Bool) -> Void)? = nil) {
        if let hand = handToMove {
            let cardViewIndex: [Int] = hand.getAllCardsIndex()
            
            for cardIndex in cardViewIndex {
                if let cardImage = view.viewWithTag(cardIndex) as? UIImageView {
                    UIImageView.animate(withDuration: Constants.Animation.SplitMoveCardDuration, delay: 0, options: .curveEaseInOut, animations: {
                        cardImage.moveXY(xMove, yMove)
                    }, completion: { input in
                        if let complete = completion {
                            complete(input)
                        }
                    })
                }
            }
        }
    }

}
