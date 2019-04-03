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
    private let imageCardFaceDown: UIImage = UIImage(named: Constant.Assets.FacedownCard)!
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
        case GameStates.dealCards:
            startButton.isHidden = true
            splitButton.isHidden = true
            doubleButton.isHidden = true
            hitButton.isHidden = false
            standButton.isHidden = false
            restartButton.isHidden = true
        case GameStates.distributeBets:
            startButton.isHidden = true
            splitButton.isHidden = true
            doubleButton.isHidden = true
            hitButton.isHidden = true
            standButton.isHidden = true
            restartButton.isHidden = false
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

    var dealerCard2ImageView: UIImageView!

    func dealCards() {
        
        self.startButton.isHidden = true
        self.organizeUiBasedOnState(state: GameStates.dealCards)

        let player1Card1ImageView: UIImageView = getNewCardFromDeckFaceDown()
        let imageCardFaceUp: UIImage = getCardImage(gameEngine.getPlayerCard(playerIndex: 0, handIndex: 0, cardIndex: 0))

        let player1Card2ImageView: UIImageView = getNewCardFromDeckFaceDown()
        let imageCard2FaceUp: UIImage = getCardImage(self.gameEngine.getPlayerCard(playerIndex: 0, handIndex: 0, cardIndex: 1))

        UIImageView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
            player1Card1ImageView.setOrigin(Constants.Positions.FirstPlayerCard)
        }, completion: { _ in

                UIImageView.transition(with: player1CardImageView, duration: Constants.Animation.FlipCardDuration,
                    options: .transitionFlipFromLeft, animations: { player1CardImageView.image = imageCardFaceUp },
                    completion: { _ in

                        let dealerCard1ImageView: UIImageView = getNewCardFromDeckFaceDown()
                        let dealerCard1FaceUp: UIImage = getCardImage(self.gameEngine.getDealerCard(cardIndex: 0))

                        UIImageView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: { 
                            dealerCard1.setOrigin(Constants.Positions.FirstDealerCard)
                        }, completion: { _ in

                                UIImageView.transition(with: dealerCard1ImageView, duration: 0.5, options: .transitionFlipFromLeft,
                                    animations: { dealerCard1ImageView.image = dealerCard1FaceUp },
                                    completion: { _ in

                                        UIImageView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
                                            player1Card2ImageView.setOrigin(Constants.Positions.SecondPlayerCard)
                                        }, completion: { _ in

                                                UIImageView.transition(with: player1Card2ImageView,
                                                    duration: Constants.Animation.FlipCardDuration, options: .transitionFlipFromLeft,
                                                    animations: { player1Card2ImageView.image = imageCard2FaceUp },
                                                    completion: { _ in
                                                        
                                                        self.dealerCard2ImageView = getNewCardFromDeckFaceDown()
                                                        
                                                        UIImageView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
                                                            self.dealerCard2ImageView.setOrigin(Constants.Positions.SecondDealerCard)
                                                        }, completion: { _ in
                                                            self.playerValueLabel.setOrigin(Constants.Positions.PlayerValueLabel)
                                                            self.dealerValueLabel.setOrigin(Constants.Positions.DealerValueLabel)
                                                            self.playerValueLabel.text = String(self.gameEngine.getPlayerValue(playerIndex: 0, handIndex: 0))
                                                            self.dealerValueLabel.text = String(self.gameEngine.getDealerValue())
                                                            self.playerValueLabel.isHidden = false
                                                            self.dealerValueLabel.isHidden = false
                                                            self.gameEngine.triggerEvent(GameEvents.dealt)
                                                        })
                                                    })
                                            })
                                    })
                            })
                    })
            })
    }

    func dealerBlackjackTest() {
    }

    func selectPlayer() {
    }

    func calculateResult() {
        // Calculate results


    }

    func selectHand() {
    }

    func playerGetChoice() {
    }

    var dealerCardIndex: Int = 1
    
    func dealerStart() {
        
        let dealerCardFaceUp: UIImage = getCardImage(self.gameEngine.getDealerCard(cardIndex: dealerCardIndex))
        
        UIImageView.transition(with: dealerCard2ImageView, duration: 0.5,
                               options: .transitionFlipFromLeft, animations: { self.dealerCard2ImageView.image = dealerCardFaceUp },
                               completion: { _ in
                        self.dealerCardIndex += 1
                        self.dealerValueLabel.text = String(self.gameEngine.getDealerValue())
                        self.gameEngine.triggerEvent(GameEvents.turnDealerCardFaceUp)
        })
        
    }
    
    func dealerGetChoice() {
    }

    var playerCardIndex: Int = 2
    
    func hitPlayer() {
        let imageCardFaceUp: UIImage = getCardImage(gameEngine.getPlayerCard(playerIndex: 0, handIndex: 0, cardIndex: playerCardIndex))
        let playerCardImageView: UIImageView = getNewCardFromDeckFaceDown()

        UIImageView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
            playerCardImageView.frame.origin.y = 500
            playerCardImageView.frame.origin.x = CGFloat(400 + self.playerCardIndex * 40)
        }, completion: { _ in
            
            UIImageView.transition(with: playerCardImageView, duration: 0.5, options: .transitionFlipFromLeft, 
                                   animations: { playerCardImageView.image = imageCardFaceUp }, completion: { _ in
                                    self.playerCardIndex += 1
                                    self.playerValueLabel.text = String(self.gameEngine.getPlayerValue(playerIndex: 0, handIndex: 0))
                                    
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
        
        UIImageView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
            dealerCardImageView.frame.origin.y = 80
            dealerCardImageView.frame.origin.x = CGFloat(400 + self.dealerCardIndex * 40)
        }, completion: { _ in
            
            UIImageView.transition(with: dealerCardImageView, duration: 0.5,
                                   options: .transitionFlipFromLeft, animations: { dealerCardImageView.image = imageCardFaceUp },
                                   completion: { _ in
                                    self.dealerCardIndex += 1
                                    self.dealerValueLabel.text = String(self.gameEngine.getDealerValue())
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
    }

    func getCardImage(_ card: Card) -> UIImageView {
        let imageName: String = cardToImageNameMapper.map(card: card)
        return UIImage(named: imageName)!
    }
}
