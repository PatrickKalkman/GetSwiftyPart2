//
//  CardCountingViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 14/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit

class CardCountingViewController: BlackjackViewControllerBase, CardCountingViewProtocol {

    private let cardToImageNameMapper: CardToImageNameMapper = CardToImageNameMapper()
    private let imageCardFaceDown: UIImage = UIImage(named: Constants.Assets.FacedownCard)!
    private var addedCards: [UIImageView] = [UIImageView]()
    private var gameEngine: CardCountingGameEngine!

    @IBOutlet weak var numberOfPlayersTitleLabel: UILabel!
    @IBOutlet weak var numberOfPlayersLabel: UILabel!
    @IBOutlet weak var numberOfPlayersStepper: UIStepper!

    @IBOutlet weak var numberOfDecksRemainingStepper: UIStepper!
    @IBOutlet weak var numberOfDecksRemainingTitleLabel: UILabel!
    @IBOutlet weak var numberOfDeckRemainingLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!

    @IBOutlet weak var playInputPanel: UIView!
    @IBOutlet weak var playPanel: UIView!
    @IBOutlet weak var playNextRoundPanel: UIView!
    @IBOutlet weak var calculatorPanel: UIView!
    
    @IBOutlet weak var trueCountValueLabel: UILabel!
    @IBOutlet weak var bettingUnitsValueLabel: UILabel!
    @IBOutlet weak var runningCountLabel: UILabel!
    
    @IBOutlet weak var strategyLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var deckCard: UIImageView!
    @IBOutlet weak var dealCardsButton: UIButton!
    @IBOutlet weak var splitButton: UIButton!

    @IBOutlet weak var standButton: UIButton!
    @IBOutlet weak var hitButton: UIButton!

    var playerIndicatorButton: UIButton!
    var numberOfPlayers: UInt = 7
    var numberOfDecksRemaining: UInt = 8

    var playerCards: [Int: [Card]] = [Int: [Card]]()
    var dealerCards: [Card] = [Card]()
    var playerStartPoints: [CGPoint] = [CGPoint]()
    var dealerStartPoint: CGPoint = CGPoint()
    var playerIndicatorStartPoints: [CGPoint] = [CGPoint]()
    var dealerIndicatorStartPoint: CGPoint = CGPoint()

    var cardIndex: Int = 2
    var dealerCardIndex: Int = 0
    var playerSelectedCards: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle("PRACTICE CARD COUNTING")
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            statusBar.backgroundColor = UIColor.init(hex: "#337440FF")
        }
        gameEngine = CardCountingGameEngine(view: self)
        initializePlayerCardsArrays()
        fillPlayerPoints()
        playInputPanel.setBorder(radius: 10, color: UIColor.white)
        playPanel.setBorder(radius: 10, color: UIColor.white)
        playNextRoundPanel.setBorder(radius: 10, color: UIColor.white)
        calculatorPanel.setBorder(radius: 10, color: UIColor.white)

        playerIndicatorButton = UIButton()
        playerIndicatorButton.setImage(UIImage(named: "Chip.LightRed"), for: UIControl.State.normal)
        playerIndicatorButton.frame = CGRect(x: 300, y: -400, width: 46, height: 46)
        playerIndicatorButton.isHidden = true
        view.addSubview(playerIndicatorButton)
    }

    override func viewDidAppear(_ animated: Bool) {
        if playerSelectedCards {
            if gameEngine.IsPlayerDealing() {
                dealCards(playerIndex: gameEngine.playerIndex, completion: {
                    if self.gameEngine.playersLeft() {
                        if let cardsOfCurrentPlayer = self.playerCards[self.gameEngine.playerIndex] {
                            self.gameEngine.gotPlayersDeal(self.gameEngine.playerIndex, cardsOfCurrentPlayer)
                        }
                    } else {
                        self.gameEngine.gotAllPlayersDeal()
                    }
                    self.refreshCalculatorValues()
                })
            } else if gameEngine.IsDealerDealing() {
                dealDealerCard(completion: {
                    self.gameEngine.gotDealersDeal(self.dealerCards[0])
                    self.dealerCardIndex += 1
                    self.refreshCalculatorValues()
                })
            } else if gameEngine.isHit() {
                dealCard(playerIndex: gameEngine.playerIndex, completion: {
                    let card: Card = self.playerCards[self.gameEngine.playerIndex]![self.cardIndex]
                    self.gameEngine.gotPlayerCard(card)
                    self.cardIndex += 1
                    self.strategyLabel.text = self.gameEngine.getStrategyMessage().1
                    self.refreshCalculatorValues()
                })
            } else if gameEngine.isSecondDealerCard() {
                dealDealerCard(completion: {
                    self.gameEngine.gotDealersSecondCard(self.dealerCards[self.dealerCardIndex])
                    self.dealerCardIndex += 1
                    self.refreshCalculatorValues()
                })
            } else if gameEngine.isDealerHit() {
                dealDealerCard(completion: {
                    self.gameEngine.gotDealerCard(self.dealerCards[self.dealerCardIndex])
                    self.dealerCardIndex += 1
                    self.refreshCalculatorValues()
                })
            }
        }
        playerSelectedCards = false
    }


    @IBAction func numberOfPlayersChanged(_ sender: UIStepper) {
        numberOfPlayers = UInt(sender.value)
        numberOfPlayersLabel.text = String(numberOfPlayers)
    }

    @IBAction func numberOfDecksChanged(_ sender: UIStepper) {
        numberOfDecksRemaining = UInt(sender.value)
        numberOfDeckRemainingLabel.text = String(numberOfDecksRemaining)
    }

    @IBAction func startPlaying(_ sender: UIButton) {
        playInputPanel.animate(fadeIn: false)
        playInputPanel.hideWithAnimation(hidden: true)
        playPanel.hideWithAnimation(hidden: false)
        refreshCalculatorValues()
        calculatorPanel.hideWithAnimation(hidden: false)
        gameEngine.start(numberOfPlayers: numberOfPlayers, numberOfDecksRemaining: numberOfDecksRemaining)
    }
    
    @IBAction func startNextRound(_ sender: Any) {
        gameEngine.nextRound()
    }

    @IBAction func selectCards(_ sender: UIButton) {
        self.performSegue(withIdentifier: "selectCards", sender: sender)
    }

    @IBAction func hit(_ sender: UIButton) {
        gameEngine.hit()
        self.performSegue(withIdentifier: "selectCards", sender: sender)
    }

    @IBAction func stand(_ sender: UIButton) {
        gameEngine.stand()
    }

    @IBAction func split(_ sender: UIButton) {
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let selectCardsViewController = segue.destination as? SelectCardsViewController {
            if gameEngine.IsPlayerDealing() {
                selectCardsViewController.maximumNumberOfCardsToSelect = 2
                selectCardsViewController.playerIndex = gameEngine.playerIndex
                selectCardsViewController.selectedCards.removeAll()
            } else if gameEngine.IsDealerDealing() {
                selectCardsViewController.maximumNumberOfCardsToSelect = 1
                selectCardsViewController.selectedCards.removeAll()
            } else if gameEngine.isPlayerPlaying() {
                selectCardsViewController.maximumNumberOfCardsToSelect = 1
                selectCardsViewController.selectedCards.removeAll()
            }
        }
    }

    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {

        if let selectCardsViewController = segue.source as? SelectCardsViewController {
            let cards: [Card] = selectCardsViewController.selectedCards
            if gameEngine.IsPlayerDealing() {
                if cards.count == 2 {
                    playerSelectedCards = true
                    playerCards[gameEngine.playerIndex]?.removeAll()
                    playerCards[gameEngine.playerIndex]?.append(contentsOf: cards)
                }
            } else if gameEngine.IsDealerDealing() {
                if cards.count == 1 {
                    playerSelectedCards = true
                    dealerCards.removeAll()
                    dealerCards.append(contentsOf: cards)
                }
            } else if gameEngine.isHit() {
                if cards.count == 1 {
                    playerSelectedCards = true
                    playerCards[gameEngine.playerIndex]?.append(contentsOf: cards)
                }
            } else if gameEngine.isSecondDealerCard() {
                if cards.count == 1 {
                    playerSelectedCards = true
                    dealerCards.append(contentsOf: cards)
                }
            } else if gameEngine.isDealerHit() {
                if cards.count == 1 {
                    playerSelectedCards = true
                    dealerCards.append(contentsOf: cards)
                }
            }
        }
    }

    func initializePlayerCardsArrays() {
        for cardIndex in 0...6 {
            playerCards[cardIndex] = [Card]()
        }
    }

    func fillPlayerPoints() {

        playerStartPoints.append(CGPoint(x: 870, y: 425))
        playerStartPoints.append(CGPoint(x: 735, y: 475))
        playerStartPoints.append(CGPoint(x: 600, y: 500))
        playerStartPoints.append(CGPoint(x: 465, y: 510))
        playerStartPoints.append(CGPoint(x: 330, y: 500))
        playerStartPoints.append(CGPoint(x: 195, y: 475))
        playerStartPoints.append(CGPoint(x: 60, y: 425))

        dealerStartPoint = CGPoint(x: 475, y: 115)

        playerIndicatorStartPoints.append(CGPoint(x: 855, y: 375))
        playerIndicatorStartPoints.append(CGPoint(x: 733, y: 420))
        playerIndicatorStartPoints.append(CGPoint(x: 615, y: 445))
        playerIndicatorStartPoints.append(CGPoint(x: 488, y: 450))
        playerIndicatorStartPoints.append(CGPoint(x: 360, y: 440))
        playerIndicatorStartPoints.append(CGPoint(x: 240, y: 415))
        playerIndicatorStartPoints.append(CGPoint(x: 122, y: 375))

        dealerIndicatorStartPoint = CGPoint(x: 488, y: 55)
    }

    func dealDealerCard(completion: @escaping (() -> Void)) {
        let card: Card = dealerCards[dealerCardIndex]
        let cardPosition: CGPoint = CGPoint(x: dealerStartPoint.x + CGFloat(dealerCardIndex * 15), y: dealerStartPoint.y)
        animateCard(card, 0, cardPosition, completion: completion)
    }

    func dealCards(playerIndex: Int, completion: @escaping (() -> Void)) {

        let card1: Card = playerCards[playerIndex]![0]
        let card2: Card = playerCards[playerIndex]![1]

        let firstCardPosition: CGPoint = playerStartPoints[playerIndex]
        let secondCardposition: CGPoint = CGPoint(x: firstCardPosition.x + 15, y: firstCardPosition.y)
        let angle: CGFloat = -CGFloat.pi / 8 + (CGFloat.pi / 8) / 3 * CGFloat(playerIndex)

        animateCards(card1, angle, firstCardPosition, card2, secondCardposition, completion: completion)
    }

    func dealCard(playerIndex: Int, completion: @escaping (() -> Void)) {

        let card: Card = playerCards[playerIndex]![cardIndex]

        let firstCardPosition: CGPoint = playerStartPoints[playerIndex]
        let cardposition: CGPoint = CGPoint(x: firstCardPosition.x + CGFloat(cardIndex * 15), y: firstCardPosition.y)
        let angle: CGFloat = -CGFloat.pi / 8 + (CGFloat.pi / 8) / 3 * CGFloat(playerIndex)

        animateCard(card, angle, cardposition, completion: completion)
    }

    func animateCards(_ card1: Card, _ rotation: CGFloat, _ card1Pos: CGPoint, _ card2: Card, _ card2Pos: CGPoint, completion: (() -> Void)? = nil) {

        let playerCard1ImageView: UIImageView = getNewCardFromDeckFaceDown()
        let imageCard1FaceUp: UIImage = getCardImage(card1)

        UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
            playerCard1ImageView.setOrigin(card1Pos)
            playerCard1ImageView.tag = card1.index
            playerCard1ImageView.transform = CGAffineTransform(rotationAngle: rotation)
        }, completion: { _ in
                UIImageView.transition(with: playerCard1ImageView, duration: Constants.Animation.FlipCardDuration,
                    options: .transitionFlipFromLeft, animations: { playerCard1ImageView.image = imageCard1FaceUp },
                    completion: { _ in

                        let playerCard2ImageView: UIImageView = self.getNewCardFromDeckFaceDown()
                        playerCard2ImageView.tag = card2.index
                        let imageCard2FaceUp: UIImage = self.getCardImage(card2)

                        UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
                            playerCard2ImageView.setOrigin(card2Pos)
                            playerCard2ImageView.transform = CGAffineTransform(rotationAngle: rotation)
                        }, completion: { _ in
                                UIImageView.transition(with: playerCard2ImageView, duration: Constants.Animation.FlipCardDuration,
                                    options: .transitionFlipFromLeft, animations: { playerCard2ImageView.image = imageCard2FaceUp },
                                    completion: { _ in
                                        if let funcToCallWhenComplete = completion {
                                            funcToCallWhenComplete()
                                        }
                                    })
                            })

                    })
            })
    }

    func animateCard(_ card: Card, _ rotation: CGFloat, _ cardPos: CGPoint, completion: (() -> Void)? = nil) {

        let playerCardImageView: UIImageView = getNewCardFromDeckFaceDown()
        let imageCardFaceUp: UIImage = getCardImage(card)

        UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
            playerCardImageView.setOrigin(cardPos)
            playerCardImageView.tag = card.index
            playerCardImageView.transform = CGAffineTransform(rotationAngle: rotation)
        }, completion: { _ in
                UIImageView.transition(with: playerCardImageView, duration: Constants.Animation.FlipCardDuration,
                    options: .transitionFlipFromLeft, animations: { playerCardImageView.image = imageCardFaceUp },
                    completion: { _ in
                        if let funcToCallWhenComplete = completion {
                            funcToCallWhenComplete()
                        }
                    })
            })
    }

    func getCardImage(_ card: Card) -> UIImage {
        let imageName: String = cardToImageNameMapper.map(card)
        return UIImage(named: imageName)!
    }

    func getNewCardFromDeckFaceDown() -> UIImageView {
        let cardImageView: UIImageView = UIImageView(image: imageCardFaceDown)
        cardImageView.frame = CGRect(x: deckCard.frame.origin.x, y: deckCard.frame.origin.y, width: deckCard.frame.size.width, height: deckCard.frame.size.height)
        addedCards.append(cardImageView)
        view.addSubview(cardImageView)
        return cardImageView
    }

    func animatePlayerIndicatorToCurrentPlayer(completion: (() -> Void)? = nil) {
        UIButton.animate(withDuration: 2.0, delay: 0, options: .curveEaseInOut, animations: {
            self.playerIndicatorButton.setOrigin(self.playerIndicatorStartPoints[self.gameEngine.playerIndex])
        }, completion: { _ in
                if let completion = completion {
                    completion()
                }
            })
    }

    func animatePlayerIndicatorToDealer(completion: (() -> Void)? = nil) {
        UIButton.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
            self.playerIndicatorButton.setOrigin(self.dealerIndicatorStartPoint)
        }, completion: { _ in
                if let completion = completion {
                    completion()
                }
            })
    }

    func getNextPlayerDeal() {
        strategyLabel.hideWithAnimation(hidden: true)
        instructionLabel.text = "Select the two cards that were dealt to player: \(gameEngine.playerNumber())"
        if instructionLabel.isHidden {
            instructionLabel.hideWithAnimation(hidden: false)
        }
        if self.playerIndicatorButton.isHidden {
            self.playerIndicatorButton.hideWithAnimation(hidden: false)
        }
        animatePlayerIndicatorToCurrentPlayer(completion: {
            if self.dealCardsButton.isHidden {
                self.dealCardsButton.hideWithAnimation(hidden: false)
            }
            self.dealCardsButton.shake(duration: 1.0)
        })
    }

    func getDealersDeal() {
        strategyLabel.hideWithAnimation(hidden: true)
        instructionLabel.text = "Select the card that was dealt to the dealer"
        animatePlayerIndicatorToDealer(completion: {
            self.dealCardsButton.hideWithAnimation(hidden: false)
            self.dealCardsButton.shake(duration: 1.0)
        })
    }
    
    func getDealersSecondCard() {
        strategyLabel.hideWithAnimation(hidden: true)
        instructionLabel.text = "Select the second card that was dealt to the dealer"
        self.standButton.hideWithAnimation(hidden: true)
        self.splitButton.hideWithAnimation(hidden: true)
        self.hitButton.hideWithAnimation(hidden: false)
        animatePlayerIndicatorToDealer(completion: {
            self.standButton.shake(duration: 1.0)
        })
    }

    func presentOptions() {
        instructionLabel.fadeTransition(0.9)
        instructionLabel.text = "Select the action of player: \(gameEngine.playerIndex + 1)"
        strategyLabel.text = gameEngine.getStrategyMessage().1
        strategyLabel.hideWithAnimation(hidden: false)
        dealCardsButton.hideWithAnimation(hidden: true)
        splitButton.hideWithAnimation(hidden: true)
        standButton.hideWithAnimation(hidden: false)
        hitButton.hideWithAnimation(hidden: false)

        animatePlayerIndicatorToCurrentPlayer()
    }
    
    func presentDealerOptions() {
        instructionLabel.fadeTransition(0.9)
        instructionLabel.text = "Select the action of the dealer"
        strategyLabel.hideWithAnimation(hidden: true)
        dealCardsButton.hideWithAnimation(hidden: true)
        splitButton.hideWithAnimation(hidden: true)
        standButton.hideWithAnimation(hidden: false)
        hitButton.hideWithAnimation(hidden: false)
        animatePlayerIndicatorToDealer()
    }
    
    func presentNextRound() {
        for cardView in addedCards {
            cardView.removeFromSuperview()
        }
        playerIndicatorButton.frame = CGRect(x: 300, y: -400, width: 46, height: 46)
        playerIndicatorButton.isHidden = true
        splitButton.isHidden = true
        standButton.isHidden = true
        hitButton.isHidden = true
        dealerCardIndex = 0
        cardIndex = 2
        
        playPanel.hideWithAnimation(hidden: true)
        playNextRoundPanel.hideWithAnimation(hidden: false)
    }
    
    func refreshCalculatorValues() {
        let runningCount: Int = self.gameEngine.calculateRunningCount()
        let trueCount: Int = self.gameEngine.calculateTrueCount()
        let bettingUnits: UInt = self.gameEngine.getBettingUnits()
        
        runningCountLabel.text = String(runningCount)
        trueCountValueLabel.text = String(trueCount)
        bettingUnitsValueLabel.text = String(bettingUnits)
    }
    
    func resetCardIndex() {
        self.cardIndex = 2
    }
}
