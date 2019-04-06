//
//  ViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 22/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BlackjackViewProtocol {

    private let cardToImageNameMapper: CardToImageNameMapper = CardToImageNameMapper()
    private let imageCardFaceDown: UIImage = UIImage(named: Constants.Assets.FacedownCard)!
    private var gameEngine: GameEngine!

    private var addedCards: [UIImageView] = [UIImageView]()

    @IBOutlet weak var deckCard: UIImageView!
    @IBOutlet weak var startButton: BorderButton!
    @IBOutlet weak var splitButton: BorderButton!
    @IBOutlet weak var doubleButton: BorderButton!
    @IBOutlet weak var standButton: BorderButton!
    @IBOutlet weak var hitButton: BorderButton!
    @IBOutlet weak var playerValueLabel: UILabel!
    @IBOutlet weak var dealerValueLabel: UILabel!
    @IBOutlet weak var restartButton: BorderButton!
    @IBOutlet weak var playResultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gameEngine = GameEngine(gameResultCalculator: GameResultCalculator(), blackjackView: self)
        self.organizeUiBasedOnState(state: GameStates.waitingForStart)
    }

    @IBAction func startGame(_ sender: Any) {
        DispatchQueue.main.async {
            self.gameEngine.start(numberOfPlayers: 1)
            self.organizeUiBasedOnState(state: GameStates.started)
        }
    }

    @IBAction func restartGame(_ sender: UIButton) {
        playerCardIndex = 2
        dealerCardIndex = 1

        for subview in addedCards {
            subview.removeFromSuperview()
        }

        DispatchQueue.main.async {
            self.gameEngine.restart()
            self.organizeUiBasedOnState(state: GameStates.started)
        }
    }

    @IBAction func hitPlayer(_ sender: Any) {
        gameEngine.triggerEvent(GameEvents.hitPlayer)
    }

    @IBAction func doublePlayer(_ sender: Any) {
        gameEngine.triggerEvent(GameEvents.doubleDownPlayer)
    }

    @IBAction func standPlayer(_ sender: Any) {
        gameEngine.triggerEvent(GameEvents.standPlayer)
    }

    @IBAction func splitPlayer(_ sender: Any) {
        gameEngine.triggerEvent(GameEvents.splitPlayerHand)
    }

    func organizeUiBasedOnState(state: GameStates) {
        print("Organizing UI for state: \(state)")
        switch state {
        case GameStates.waitingForStart:
            startButton.isHidden = false
            splitButton.isHidden = true
            doubleButton.isHidden = true
            hitButton.isHidden = true
            standButton.isHidden = true
            playerValueLabel.isHidden = true
            dealerValueLabel.isHidden = true
            restartButton.isHidden = true
            playResultLabel.isHidden = true
        case GameStates.dealCards:
            playerValueLabel.isHidden = true
            dealerValueLabel.isHidden = true
            startButton.isHidden = true
            splitButton.isHidden = true
            doubleButton.isHidden = true
            hitButton.isHidden = false
            standButton.isHidden = false
            restartButton.isHidden = true
            playResultLabel.isHidden = true
        case GameStates.distributeBets:
            startButton.isHidden = true
            splitButton.isHidden = true
            doubleButton.isHidden = true
            hitButton.isHidden = true
            standButton.isHidden = true
            restartButton.isHidden = false
            playResultLabel.isHidden = false
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

    var dealerCard2ImageView: UIImageView!

    func dealCards() {

        self.startButton.isHidden = true
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

                        let dealerCard1ImageView: UIImageView = self.getNewCardFromDeckFaceDown()
                        let dealerCard1FaceUp: UIImage = self.getCardImage(self.gameEngine.getDealerCard(cardIndex: 0))

                        UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
                            dealerCard1ImageView.setOrigin(Constants.Positions.FirstDealerCard)
                        }, completion: { _ in

                                UIImageView.transition(with: dealerCard1ImageView, duration: Constants.Animation.FlipCardDuration, options: .transitionFlipFromLeft,
                                    animations: { dealerCard1ImageView.image = dealerCard1FaceUp },
                                    completion: { _ in

                                        UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
                                            player1Card2ImageView.setOrigin(Constants.Positions.SecondPlayerCard)
                                        }, completion: { _ in

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

        // Hand is splitted
        let nextHand = gameEngine.getNextHand()
        moveHand(handToMove: nextHand, xMove: 0, yMove: 210, completion: { _ in
            self.gameEngine.triggerEvent(GameEvents.playerShowSplittedHandFinished)
            self.organizeUiBasedOnState(state: GameStates.dealCards)
            self.playerCardIndex = 1
        })
        
        let currentHand = gameEngine.getCurrentHand()
        moveHand(handToMove: currentHand, xMove: -40, yMove: 0)
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
        }
        playResultLabel.text = resultString
    }

    func selectHand(cardIndex: Int, previousHand: Hand?, currentHand: Hand?) {
        playerCardIndex = cardIndex

        moveHand(handToMove: previousHand, xMove: -360, yMove: -130)
        
        moveHand(handToMove: currentHand, xMove: 0, yMove: -190, completion: { _ in
            self.showAndRefreshValues()
        })

        // Move previous hand to side spot and move current to main spot
        print("Select hand with cardIndex \(cardIndex)")
    }
    


    func playerGetChoice() {
    }

    var dealerCardIndex: Int = 1

    func dealerStart() {

        let dealerCardFaceUp: UIImage = getCardImage(self.gameEngine.getDealerCard(cardIndex: dealerCardIndex))

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
        cardImageView.frame = CGRect(x: deckCard.frame.origin.x, y: deckCard.frame.origin.y, width: deckCard.frame.size.width,
            height: deckCard.frame.size.height)
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
