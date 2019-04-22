//
//  CardCountingViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 14/04/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import UIKit

class CardCountingViewController: BlackjackViewControllerBase, BlackjackViewProtocol {
    
    func start() {
        
    }
    
    func shuffle() {
        
    }
    
    func placeBets() {
        
    }
    
    func dealCards() {
        
    }
    
    func dealerBlackjackTest() {
        
    }
    
    func showDealerHasBlackjack() {
        
    }
    
    func selectPlayer() {
        
    }
    
    func calculateResult() {
        
    }
    
    func selectHand(cardIndex: Int, previousHand: Hand?, currentHand: Hand?) {
        
    }
    
    func playerGetChoice() {
        
    }
    
    func dealerGetChoice() {
        
    }
    
    func hitPlayer() {
        
    }
    
    func playerDoubleDown() {
        
    }
    
    func enableSplit() {
        
    }
    
    func showSplittedHand() {
        
    }
    
    func splitHand() {
        
    }
    
    func hitDealer() {
        
    }
    
    func distributeBets() {
        
    }
    
    func dealerStart() {
        
    }
    
    func noMoreMoney() {
        
    }

    private let cardToImageNameMapper: CardToImageNameMapper = CardToImageNameMapper()
    private let imageCardFaceDown: UIImage = UIImage(named: Constants.Assets.FacedownCard)!
    private var addedCards: [UIImageView] = [UIImageView]()
    private var gameEngine: GameEngine!

    @IBOutlet weak var numberOfPlayersTitleLabel: UILabel!
    @IBOutlet weak var numberOfPlayersLabel: UILabel!
    @IBOutlet weak var numberOfPlayersStepper: UIStepper!

    @IBOutlet weak var numberOfDecksRemainingStepper: UIStepper!
    @IBOutlet weak var numberOfDecksRemainingTitleLabel: UILabel!
    @IBOutlet weak var numberOfDeckRemainingLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!

    @IBOutlet weak var selectCardsLabel: UILabel!
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
    
    var playerSelected: Bool = false
    var currentPlayerIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle("PRACTICE CARD COUNTING")
        if let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView {
            statusBar.backgroundColor = UIColor.init(hex: "#337440FF")
        }
        gameEngine = GameEngine(gameResultCalculator: GameResultCalculator(), blackjackView: self)
        initializePlayers()
        fillPlayerPoints()
        
        playerIndicatorButton = UIButton()
        playerIndicatorButton.setImage(UIImage(named: "Chip.LightRed"), for: UIControl.State.normal)
        let origin = playerStartPoints[0]
        playerIndicatorButton.frame = CGRect(x: origin.x, y: origin.y, width: 46, height: 46)
        playerIndicatorButton.isHidden = true
        playerIndicatorButton.addTarget(self, action: #selector(playerIndicatorPressed), for: .touchUpInside)
        view.addSubview(playerIndicatorButton)
        movePlayerIndicatorToCurrentPlayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if playerSelected {
            if !atDealer {
               dealCards(playerIndex: currentPlayerIndex)
            } else {
                dealDealerCard()
            }
            playerSelected = false
            playerIndicatorPressed(self)
        }
    }
    
    var atDealer: Bool = false
    
    @IBAction func playerIndicatorPressed(_ sender: Any) {
        if currentPlayerIndex < numberOfPlayers - 1 {
            currentPlayerIndex += 1
             movePlayerIndicatorToCurrentPlayer()
        } else {
            if !atDealer {
                movePlayerIndicatorToDealer()
                atDealer = true
            } else {
                atDealer = false
                currentPlayerIndex = 0
                movePlayerIndicatorToCurrentPlayer()
            }
        }
    }
    
    func movePlayerIndicatorToCurrentPlayer() {
        UIButton.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
            self.playerIndicatorButton.setOrigin(self.playerIndicatorStartPoints[self.currentPlayerIndex])
        }, completion: { _ in
            
        })
    }
    
    func movePlayerIndicatorToDealer() {
        UIButton.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
            self.playerIndicatorButton.setOrigin(self.dealerIndicatorStartPoint)
        }, completion: { _ in
            
        })
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
        numberOfPlayersTitleLabel.animate(fadeIn: false)
        numberOfPlayersLabel.animate(fadeIn: false)
        numberOfPlayersStepper.animate(fadeIn: false)

        numberOfDecksRemainingStepper.animate(fadeIn: false)
        numberOfDecksRemainingTitleLabel.animate(fadeIn: false)
        numberOfDeckRemainingLabel.animate(fadeIn: false)
        startButton.animate(fadeIn: false)
        selectCardsLabel.hideWithAnimation(hidden: false)
        
        gameEngine.start(numberOfPlayers: UInt8(numberOfPlayers))
        print(gameEngine.getState())
        gameEngine.triggerEvent(GameEvents.betsPlaced)
        print(gameEngine.getState())
        setTitle("")
        dealCardsButton.hideWithAnimation(hidden: false)
        playerIndicatorButton.hideWithAnimation(hidden: false)
    }

    func initializePlayers() {
        for playerIndex in 0...6 {
            playerCards[playerIndex] = [Card]()
        }
    }

    @IBAction func selectCards(_ sender: UIButton) {
        self.performSegue(withIdentifier: "selectCards", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectCardsViewController = segue.destination as? SelectCardsViewController {
            selectCardsViewController.selectedCards.removeAll()
            selectCardsViewController.playerIndex = currentPlayerIndex
            if atDealer {
                selectCardsViewController.maximumNumberOfCardsToSelect = 1
                selectCardsViewController.selectedCards.append(contentsOf: dealerCards)
            } else {
                selectCardsViewController.maximumNumberOfCardsToSelect = 2
                selectCardsViewController.selectedCards.append(contentsOf: playerCards[currentPlayerIndex]!)
            }
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
        
        dealerStartPoint = CGPoint(x: 475, y: 135)
        
        playerIndicatorStartPoints.append(CGPoint(x: 855, y: 375))
        playerIndicatorStartPoints.append(CGPoint(x: 733, y: 420))
        playerIndicatorStartPoints.append(CGPoint(x: 615, y: 445))
        playerIndicatorStartPoints.append(CGPoint(x: 488, y: 450))
        playerIndicatorStartPoints.append(CGPoint(x: 360, y: 440))
        playerIndicatorStartPoints.append(CGPoint(x: 240, y: 415))
        playerIndicatorStartPoints.append(CGPoint(x: 122, y: 375))
        
        dealerIndicatorStartPoint = CGPoint(x: 488, y: 75)
    }
    func dealDealerCard() {
        let card: Card = dealerCards[0]
        let cardPosition: CGPoint = dealerStartPoint
        
        animateCard(card, 0, cardPosition)
    }

    func dealCards(playerIndex: Int) {

        let card1: Card = playerCards[playerIndex]![0]
        let card2: Card = playerCards[playerIndex]![1]

        let firstCardPosition: CGPoint = playerStartPoints[playerIndex]
        let secondCardposition: CGPoint = CGPoint(x: firstCardPosition.x + 15, y: firstCardPosition.y)
        let angle: CGFloat = -CGFloat.pi / 8 + (CGFloat.pi / 8) / 3 * CGFloat(playerIndex)

        animateCards(card1, angle, firstCardPosition, card2, secondCardposition)
    }

    func animateCards(_ card1: Card, _ rotation: CGFloat, _ card1Pos: CGPoint, _ card2: Card, _ card2Pos: CGPoint) {

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
                                    completion: { _ in })
                            })

                    })
            })
    }
    
    func animateCard(_ card: Card, _ rotation: CGFloat, _ cardPos: CGPoint) {
        
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
                                    
            })
        })
    }

    func getCardImage(_ card: Card) -> UIImage {
        let imageName: String = cardToImageNameMapper.map(card)
        return UIImage(named: imageName)!
    }

    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        if let source = segue.source as? SelectCardsViewController {
            if source.selectedCards.count >= 1 {
                


                if !atDealer {
                    for previouslySelectedCard in playerCards[currentPlayerIndex]! {
                        view.viewWithTag(previouslySelectedCard.index)?.removeFromSuperview()
                    }
                    playerCards[currentPlayerIndex]!.removeAll()
                    playerCards[currentPlayerIndex]!.append(contentsOf: source.selectedCards)
                    playerSelected = true
                    gameEngine.dealtCards(playerIndex: currentPlayerIndex,
                            card1: source.selectedCards[0], card2: source.selectedCards[1])
                } else {
                    for previouslySelectedCard in dealerCards {
                        view.viewWithTag(previouslySelectedCard.index)?.removeFromSuperview()
                    }
                    dealerCards.removeAll()
                    dealerCards.append(contentsOf: source.selectedCards)
                    playerSelected = true
                }
            }
        }
    }

    func getNewCardFromDeckFaceDown() -> UIImageView {
        let cardImageView: UIImageView = UIImageView(image: imageCardFaceDown)
        cardImageView.frame = CGRect(x: deckCard.frame.origin.x, y: deckCard.frame.origin.y, width: deckCard.frame.size.width, height: deckCard.frame.size.height)
        addedCards.append(cardImageView)
        view.addSubview(cardImageView)
        return cardImageView
    }
}
