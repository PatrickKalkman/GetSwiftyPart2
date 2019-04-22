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
    @IBOutlet weak var playerIndicatorButton: UIButton!
    
    var numberOfPlayers: UInt = 7
    var numberOfDecksRemaining: UInt = 8

    var playerCards: [Int: [Card]] = [Int: [Card]]()
    var playerStartPoints: [CGPoint] = [CGPoint]()
    var playerIndicatorStartPoints: [CGPoint] = [CGPoint]()
    
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
    }


    override func viewDidAppear(_ animated: Bool) {
        if playerSelected {
            dealCards(playerIndex: currentPlayerIndex)
            playerSelected = false
        }
    }
    
    @IBAction func playerIndicatorPressed(_ sender: Any) {
        if currentPlayerIndex < 6 {
            currentPlayerIndex += 1
        } else {
            currentPlayerIndex = 0
        }
        movePlayerIndicatorToCurrentPlayer()
    }
    
    func movePlayerIndicatorToCurrentPlayer() {
        UIImageView.animate(withDuration: Constants.Animation.DealCardDuraction, delay: 0, options: .curveEaseInOut, animations: {
            self.playerIndicatorButton.setOrigin(self.playerIndicatorStartPoints[self.currentPlayerIndex])
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
            selectCardsViewController.selectedCards.append(contentsOf: playerCards[currentPlayerIndex]!)
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
        
        playerIndicatorStartPoints.append(CGPoint(x: 855, y: 375))
        playerIndicatorStartPoints.append(CGPoint(x: 733, y: 420))
        playerIndicatorStartPoints.append(CGPoint(x: 615, y: 445))
        playerIndicatorStartPoints.append(CGPoint(x: 488, y: 450))
        playerIndicatorStartPoints.append(CGPoint(x: 360, y: 440))
        playerIndicatorStartPoints.append(CGPoint(x: 240, y: 415))
        playerIndicatorStartPoints.append(CGPoint(x: 122, y: 375))
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
            playerCard1ImageView.transform = CGAffineTransform(rotationAngle: rotation)
        }, completion: { _ in
                UIImageView.transition(with: playerCard1ImageView, duration: Constants.Animation.FlipCardDuration,
                    options: .transitionFlipFromLeft, animations: { playerCard1ImageView.image = imageCard1FaceUp },
                    completion: { _ in

                        let playerCard2ImageView: UIImageView = self.getNewCardFromDeckFaceDown()
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

    func getCardImage(_ card: Card) -> UIImage {
        let imageName: String = cardToImageNameMapper.map(card)
        return UIImage(named: imageName)!
    }

    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        if let source = segue.source as? SelectCardsViewController {
            if source.selectedCards.count == 2 {
                playerCards[currentPlayerIndex]!.removeAll()
                playerCards[currentPlayerIndex]!.append(contentsOf: source.selectedCards)
                playerSelected = true
                gameEngine.dealtCards(playerIndex: currentPlayerIndex,
                        card1: source.selectedCards[0], card2: source.selectedCards[1])
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
