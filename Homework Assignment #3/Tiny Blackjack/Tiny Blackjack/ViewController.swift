//
//  ViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 22/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit
import SwiftySound

class ViewController: UIViewController, BlackjackViewProtocol {

    private let cardToImageNameMapper: CardToImageNameMapper = CardToImageNameMapper()
    private let valueToChipMapper: ValueToChipMapper = ValueToChipMapper()
    private let imageCardFaceDown: UIImage = UIImage(named: Constants.Assets.FacedownCard)!
    private var gameEngine: GameEngine!
    private var shuffleSound: Sound?
    private var dealCardSound: Sound?

    private var addedCards: [UIImageView] = [UIImageView]()
    private var addedChips: [UIButton] = [UIButton]()

    @IBOutlet weak var deckCard: UIImageView!
    @IBOutlet weak var dealButton: BorderButton!
    @IBOutlet weak var splitButton: BorderButton!
    @IBOutlet weak var doubleButton: BorderButton!
    @IBOutlet weak var standButton: BorderButton!
    @IBOutlet weak var hitButton: BorderButton!
    @IBOutlet weak var playerValueLabel: UILabel!
    @IBOutlet weak var dealerValueLabel: UILabel!
    @IBOutlet weak var restartButton: BorderButton!
    @IBOutlet weak var playResultLabel: UILabel!

    @IBOutlet weak var darkBlueChip: UIButton!
    @IBOutlet weak var darkRedChip: UIButton!
    @IBOutlet weak var purpleChip: UIButton!
    @IBOutlet weak var lightBlueChip: UIButton!
    @IBOutlet weak var pinkChip: UIButton!
    @IBOutlet weak var lightRedChip: UIButton!

    @IBOutlet weak var playerBetLabel: UILabel!
    @IBOutlet weak var playerTotalLabel: UILabel!
    @IBOutlet weak var placeYourBetsTitle: UILabel!

    @IBAction func chipAddAction(_ sender: UIButton) {

        if gameEngine.getState() != GameStates.playersBetSelectPlayer {
            return
        }

        if let chipIdentifier = sender.titleLabel?.text {

            let chip: Chip = valueToChipMapper.map(chipIdentifier)

            if gameEngine.isLastChip(chip: chip) {
                sender.isHidden = true
            }

            gameEngine.addBet(chip: chip)
            let newChip: UIButton = copyAndAddChip(chipToCopy: sender)

            UIButton.animate(withDuration: Constants.Animation.PlaceBetDuraction, delay: 0, options: .curveEaseInOut, animations: {
                newChip.frame.origin.x = 20
                newChip.frame.origin.y = 100
            }, completion: { _ in
                    self.refreshWalletInformation()
                    Sound.play(file: "AddChip.wav")
                    newChip.shake(duration: 0.05)
                })
        }
    }

    @IBAction func chipRemoveAction(_ sender: UIButton) {

        // Remove the chip from the bets by animating it back to the wallet of the player
        if let title = sender.titleLabel?.text {

            let chip: Chip = valueToChipMapper.map(title)
            gameEngine.removeBet(chip: chip)

            if let originalChip = view.viewWithTag(ChipTag.create(chip)) {
                let newOrigin = originalChip.frame.origin
                UIButton.animate(withDuration: Constants.Animation.PlaceBetDuraction, delay: 0, options: .curveEaseInOut, animations: {
                    sender.frame.origin = newOrigin
                }, completion: { _ in
                        self.refreshWalletInformation()
                        self.addedChips.removeFirst()
                        sender.isHidden = true
                        originalChip.isHidden = false
                        sender.removeFromSuperview()
                        self.placeYourBetsTitle.isHidden = self.gameEngine.getPlayerBetTotal() > 0
                        self.dealButton.isHidden = !self.placeYourBetsTitle.isHidden
                        Sound.play(file: "AddChip.wav")
                        originalChip.shake(duration: 0.05)
                    })
            }
        }
    }

    func refreshWalletInformation() {

        self.placeYourBetsTitle.isHidden = self.gameEngine.getPlayerBetTotal() > 0
        self.dealButton.isHidden = !self.placeYourBetsTitle.isHidden        
        self.playerTotalLabel.text = String(self.gameEngine.getPlayerWalletTotal())
        let playerTotal: UInt = self.gameEngine.getPlayerBetTotal()
        self.playerBetLabel.text = String(playerTotal)
        self.playerBetLabel.isHidden = playerTotal <= 0

        darkBlueChip.isHidden = !self.gameEngine.walletContains(Chip.DarkBlue)
        darkRedChip.isHidden = !self.gameEngine.walletContains(Chip.DarkRed)
        purpleChip.isHidden = !self.gameEngine.walletContains(Chip.Purple)
        lightBlueChip.isHidden = !self.gameEngine.walletContains(Chip.LightBlue)
        pinkChip.isHidden = !self.gameEngine.walletContains(Chip.Pink)
        lightRedChip.isHidden = !self.gameEngine.walletContains(Chip.LightRed)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let shuffleSoundUrl = Bundle.main.url(forResource: "Shuffle", withExtension: "wav") {
            shuffleSound = Sound(url: shuffleSoundUrl)!
        }

        if let dealCardSoundUrl = Bundle.main.url(forResource: "Card1", withExtension: "wav") {
            dealCardSound = Sound(url: dealCardSoundUrl)!
        }

        // Do any additional setup after loading the view, typically from a nib.
        gameEngine = GameEngine(gameResultCalculator: GameResultCalculator(), blackjackView: self)
        self.organizeUiBasedOnState(state: GameStates.waitingForStart)
        DispatchQueue.main.async {
            self.gameEngine.start(numberOfPlayers: 1)
            self.organizeUiBasedOnState(state: GameStates.started)
        }
    }

    @IBAction func deal(_ sender: Any) {
        shuffleSound!.play(numberOfLoops: 0, completion: { _ in
            self.gameEngine.triggerEvent(GameEvents.betsPlaced)
            self.gameEngine.triggerEvent(GameEvents.dealCards)
        })
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
            dealButton.isHidden = false
            splitButton.isHidden = true
            doubleButton.isHidden = true
            hitButton.isHidden = true
            standButton.isHidden = true
            playerValueLabel.isHidden = true
            dealerValueLabel.isHidden = true
            restartButton.isHidden = true
            playResultLabel.isHidden = true
        case GameStates.started:
            self.placeYourBetsTitle.isHidden = self.gameEngine.getPlayerBetTotal() > 0
            self.dealButton.isHidden = !self.placeYourBetsTitle.isHidden
            self.restartButton.isHidden = true
            playResultLabel.isHidden = true
            playerValueLabel.isHidden = true
            dealerValueLabel.isHidden = true
            playerBetLabel.isHidden = true
        case GameStates.dealCards:
            playerValueLabel.isHidden = true
            dealerValueLabel.isHidden = true
            dealButton.isHidden = true
            splitButton.isHidden = true
            doubleButton.isHidden = true
            hitButton.isHidden = false
            standButton.isHidden = false
            restartButton.isHidden = true
            playResultLabel.isHidden = true

        case GameStates.distributeBets:
            dealButton.isHidden = true
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

        self.moveHand(handToMove: previousHand, xMove: -360, yMove: -130, completion: { _ in
            self.playerCardIndex = cardIndex
            self.showAndRefreshValues()
        })

        moveHand(handToMove: currentHand, xMove: 0, yMove: -210, completion: { _ in

        })

        // Move previous hand to side spot and move current to main spot
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
        for button in addedChips {
            button.removeFromSuperview()
        }
        addedChips.removeAll()
        self.refreshWalletInformation()
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

    func copyAndAddChip(chipToCopy: UIButton) -> UIButton {
        let newChip: UIButton = UIButton()
        if let image = chipToCopy.imageView?.image {
            newChip.setImage(image, for: UIControl.State.normal)
        }
        newChip.frame = chipToCopy.frame
        newChip.titleEdgeInsets.left = -128
        newChip.setTitleColor(chipToCopy.titleColor(for: UIControl.State.normal), for: UIControl.State.normal)
        newChip.setTitle(chipToCopy.title(for: UIControl.State.normal), for: UIControl.State.normal)
        newChip.titleLabel?.font = chipToCopy.titleLabel?.font

        newChip.addTarget(self, action: #selector(chipRemoveAction), for: .touchUpInside)
        view.addSubview(newChip)
        addedChips.append(newChip)
        return newChip
    }
}
