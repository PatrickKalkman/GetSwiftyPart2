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
    private let imageCardFaceDown: UIImage = UIImage(named: "Card.Facedown")!
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
        organizeUiBasedOnState()
    }

    @IBAction func startGame(_ sender: Any) {
        DispatchQueue.main.async {
            self.gameEngine.start(numberOfPlayers: 1)
        }
        startButton.isHidden = true
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        
        playerCardIndex = 2
        dealerCardIndex = 1
        startButton.isHidden = true
        restartButton.isHidden = true
        
        for subview in addedCards {
            subview.removeFromSuperview()
        }
        
        DispatchQueue.main.async {
            self.gameEngine.restart()
            self.organizeUiBasedOnState()
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

    func organizeUiBasedOnState() {
        let state: GameStates = gameEngine.getState()
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
        self.organizeUiBasedOnState()

        let imageName: String = cardToImageNameMapper.map(gameEngine.getPlayerCard(playerIndex: 0, handIndex: 0, cardIndex: 0))
        let imageCardFaceUp: UIImage = UIImage(named: imageName)!

        let player1CardImageView: UIImageView = UIImageView(image: imageCardFaceDown)
        player1CardImageView.frame = CGRect(x: deckCard.frame.origin.x, y: deckCard.frame.origin.y, width: deckCard.frame.size.width, height: deckCard.frame.size.height)

        let imageNameCard2: String = cardToImageNameMapper.map(self.gameEngine.getPlayerCard(playerIndex: 0, handIndex: 0, cardIndex: 1))
        let imageCard2FaceUp: UIImage = UIImage(named: imageNameCard2)!
        let player1Card2ImageView: UIImageView = UIImageView(image: imageCardFaceDown)

        player1Card2ImageView.frame = CGRect(x: self.deckCard.frame.origin.x, y: self.deckCard.frame.origin.y, width: self.deckCard.frame.size.width, height: self.deckCard.frame.size.height)
        view.addSubview(player1CardImageView)
        addedCards.append(player1CardImageView)

        let imageNameDealerCard1: String = cardToImageNameMapper.map(self.gameEngine.getDealerCard(cardIndex: 0))
        let dealerCard1FaceUp: UIImage = UIImage(named: imageNameDealerCard1)!

        UIImageView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
            player1CardImageView.frame.origin.y = 500
            player1CardImageView.frame.origin.x = 400
        }, completion: { _ in

                UIImageView.transition(with: player1CardImageView, duration: 0.5,
                    options: .transitionFlipFromLeft, animations: { player1CardImageView.image = imageCardFaceUp },
                    completion: { _ in

                        let dealerCard1ImageView: UIImageView = UIImageView(image: self.imageCardFaceDown)
                        dealerCard1ImageView.frame = CGRect(x: self.deckCard.frame.origin.x, y: self.deckCard.frame.origin.y, width: self.deckCard.frame.size.width, height: self.deckCard.frame.size.height)

                        self.view.addSubview(dealerCard1ImageView)
                        self.addedCards.append(dealerCard1ImageView)

                        UIImageView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
                            dealerCard1ImageView.frame.origin.y = 80
                            dealerCard1ImageView.frame.origin.x = 400
                        }, completion: { _ in

                                UIImageView.transition(with: dealerCard1ImageView,
                                    duration: 0.5, options: .transitionFlipFromLeft,
                                    animations: { dealerCard1ImageView.image = dealerCard1FaceUp },
                                    completion: { _ in

                                        self.view.addSubview(player1Card2ImageView)
                                        self.addedCards.append(player1Card2ImageView)

                                        UIImageView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
                                            player1Card2ImageView.frame.origin.y = 500
                                            player1Card2ImageView.frame.origin.x = 440
                                        }, completion: { _ in

                                                UIImageView.transition(with: player1Card2ImageView,
                                                    duration: 0.5, options: .transitionFlipFromLeft,
                                                    animations: { player1Card2ImageView.image = imageCard2FaceUp },
                                                    completion: { _ in
                                                        
                                                        self.dealerCard2ImageView = UIImageView(image: self.imageCardFaceDown)
                                                        self.dealerCard2ImageView.frame = CGRect(x: self.deckCard.frame.origin.x, y: self.deckCard.frame.origin.y, width: self.deckCard.frame.size.width, height: self.deckCard.frame.size.height)
                                                        
                                                        self.view.addSubview(self.dealerCard2ImageView)
                                                        self.addedCards.append(self.dealerCard2ImageView)
                                                        
                                                        UIImageView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
                                                            self.dealerCard2ImageView.frame.origin.y = 80
                                                            self.dealerCard2ImageView.frame.origin.x = 440
                                                        }, completion: { _ in
                                                            self.playerValueLabel.frame.origin.x = 450
                                                            self.playerValueLabel.frame.origin.y = 450
                                                            self.playerValueLabel.text = String(self.gameEngine.getPlayerValue(playerIndex: 0, handIndex: 0))
                                                            self.dealerValueLabel.text = String(self.gameEngine.getDealerValue())
                                                            self.dealerValueLabel.frame.origin.x = 450
                                                            self.dealerValueLabel.frame.origin.y = 20
                                                            self.playerValueLabel.isHidden = false
                                                            self.dealerValueLabel.isHidden = false
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
    }

    func selectHand() {
    }

    func playerGetChoice() {
    }

    var dealerCardIndex: Int = 1
    
    func dealerStart() {
        
        let imageNameDealerCard: String = cardToImageNameMapper.map(self.gameEngine.getDealerCard(cardIndex: dealerCardIndex))
        let dealerCardFaceUp: UIImage = UIImage(named: imageNameDealerCard)!
        
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
        let imageName: String = cardToImageNameMapper.map(gameEngine.getPlayerCard(playerIndex: 0, handIndex: 0, cardIndex: playerCardIndex))
        let imageCardFaceUp: UIImage = UIImage(named: imageName)!
        
        let playerCardImageView: UIImageView = UIImageView(image: imageCardFaceDown)
        playerCardImageView.frame = CGRect(x: deckCard.frame.origin.x, y: deckCard.frame.origin.y, width: deckCard.frame.size.width, height: deckCard.frame.size.height)
        
        view.addSubview(playerCardImageView)
        self.addedCards.append(playerCardImageView)

        UIImageView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
            playerCardImageView.frame.origin.y = 500
            playerCardImageView.frame.origin.x = CGFloat(400 + self.playerCardIndex * 40)
        }, completion: { _ in
            
            UIImageView.transition(with: playerCardImageView, duration: 0.5,
                                   options: .transitionFlipFromLeft, animations: { playerCardImageView.image = imageCardFaceUp },
                                   completion: { _ in
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
        let imageName: String = cardToImageNameMapper.map(gameEngine.getDealerCard(cardIndex: dealerCardIndex))
        let imageCardFaceUp: UIImage = UIImage(named: imageName)!
        
        let dealerCardImageView: UIImageView = UIImageView(image: imageCardFaceDown)
        dealerCardImageView.frame = CGRect(x: deckCard.frame.origin.x, y: deckCard.frame.origin.y, width: deckCard.frame.size.width, height: deckCard.frame.size.height)
        
        view.addSubview(dealerCardImageView)
        self.addedCards.append(dealerCardImageView)
        
        UIImageView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
            dealerCardImageView.frame.origin.y = 80
            dealerCardImageView.frame.origin.x = CGFloat(400 + self.dealerCardIndex * 40)
        }, completion: { _ in
            
            UIImageView.transition(with: dealerCardImageView, duration: 0.5,
                                   options: .transitionFlipFromLeft, animations: { dealerCardImageView.image = imageCardFaceUp },
                                   completion: { _ in
                                    self.dealerCardIndex += 1
                                    self.dealerValueLabel.text = String(self.gameEngine.getDealerValue())
                                    
            })
            
        })
    }

    func distributeBets() {
        organizeUiBasedOnState()
    }

}
