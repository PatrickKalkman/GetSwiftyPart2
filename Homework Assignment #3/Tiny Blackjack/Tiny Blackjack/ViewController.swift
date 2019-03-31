//
//  ViewController.swift
//  Tiny Blackjack
//
//  Created by Patrick Kalkman on 22/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BlackjackViewProtocol {


    private var gameEngine: GameEngine!
    
    @IBOutlet weak var deckCard: UIImageView!
    @IBOutlet weak var startButton: BorderButton!
    @IBOutlet weak var splitButton: BorderButton!
    @IBOutlet weak var doubleButton: BorderButton!
    @IBOutlet weak var standButton: BorderButton!
    @IBOutlet weak var hitButton: BorderButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gameEngine = GameEngine(gameResultCalculator: GameResultCalculator(), blackjackView: self)
        organizeUiBasedOnState()
    }
    
    @IBAction func startGame(_ sender: Any) {
        gameEngine.start(numberOfPlayers: 1)
    }
    
    @IBAction func hitPlayer(_ sender: Any) {
    }
    
    @IBAction func doublePlayer(_ sender: Any) {
    }
    
    @IBAction func standPlayer(_ sender: Any) {
    }
    
    @IBAction func splitPlayer(_ sender: Any) {
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
    
    func dealCards() {
        
        let cardToImageNameMapper: CardToImageNameMapper = CardToImageNameMapper()
        let imageName: String = cardToImageNameMapper.map(gameEngine.getPlayerCard(playerIndex: 0, handIndex: 0, cardIndex: 0))
        let imageCardFaceUp: UIImage = UIImage(named: imageName)!
        
        let imageCardFaceDown: UIImage = UIImage(named: "Card.Facedown")!
        
        let player1CardImageView: UIImageView = UIImageView(image: imageCardFaceDown)
        
        player1CardImageView.frame = CGRect(x: deckCard.frame.origin.x, y: deckCard.frame.origin.y, width: deckCard.frame.size.width, height: deckCard.frame.size.height)
        
        view.addSubview(player1CardImageView)
        
        UIImageView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
            player1CardImageView.frame.origin.y = 500
            player1CardImageView.frame.origin.x = 400
        }, completion: { _ in
            UIImageView.transition(with: player1CardImageView,
                                   duration: 0.5,
                                   options: .transitionFlipFromLeft,
                                   animations: { player1CardImageView.image = imageCardFaceUp },
                                   completion: {_ in
                                    
                                    let imageNameCard2: String = cardToImageNameMapper.map(self.gameEngine.getPlayerCard(playerIndex: 0, handIndex: 0, cardIndex: 1))
                                    let imageCard2FaceUp: UIImage = UIImage(named: imageNameCard2)!
                                    
                                    let player1Card2ImageView: UIImageView = UIImageView(image: imageCardFaceDown)
                                    
                                    player1Card2ImageView.frame = CGRect(x: self.deckCard.frame.origin.x, y: self.deckCard.frame.origin.y, width: self.deckCard.frame.size.width, height: self.deckCard.frame.size.height)
                                    
                                    self.view.addSubview(player1Card2ImageView)
                                    
                                    UIImageView.animate(withDuration: 1, delay: 0.1, options: .curveEaseInOut, animations: {
                                        player1Card2ImageView.frame.origin.y = 500
                                        player1Card2ImageView.frame.origin.x = 450
                                    }, completion: { _ in
                                        UIImageView.transition(with: player1Card2ImageView,
                                                               duration: 0.5,
                                                               options: .transitionFlipFromLeft,
                                                               animations: { player1Card2ImageView.image = imageCard2FaceUp },
                                                               completion: nil)
                                    }
                                    )
                                    
                                    
                                    
                                    
            })
        }
        )
        

        


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
    
    func dealerGetChoice() {
    }
    
    func hitPlayer() {
    }
    
    func playerDoubleDown() {
    }
    
    func splitHand() {
    }
    
    func hitDealer() {
    }
    
    func distributeBets() {
    }
    
    
    
}
