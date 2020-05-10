//
//  BoardViewController.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 17/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import UIKit

class BoardViewController: UIViewController {
    struct Constants {
        fileprivate static let collectionViewSpacing: CGFloat = 12
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var gameRules: GameRules? 
    private var deck: Deck?
    private var selectedCards: [CardCollectionViewCell] = []
    private var isFinished = false
    
    private var score: Int16 = 0 {
        didSet {
            scoreLabel.text = "Score: \(String(score))"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {

        deck = gameRules?.newDeck()
        deck?.shuffle()
    }
    
    @IBAction func didTapRestartButton(_ sender: Any) {
        resetGame()
    }
    
    @IBAction func didTapFinishButton(_ sender: Any) {
        finishGame()
    }
    
    private func resetGame() {
        score = 0
        deck = gameRules?.newDeck()
        deck?.shuffle()
        selectedCards = []
        isFinished = false
        collectionView.reloadData()
    }
    
    private func checkIsGameOver(cards: [Card]) -> Bool {
        return gameRules?.checkIsGameOver(cards: cards) ?? true
    }
    
    private func finishGame() {
        isFinished = true
        
        let alertView = UIAlertController(title: "High score: \(String(score))", message: "Insert your name", preferredStyle: .alert)
        
        alertView.addTextField { (textfield) in
            textfield.placeholder = "name"
        }
        
        let saveAction = UIAlertAction(title: "Done", style: .default) { (alertAction) in
            if let name = alertView.textFields?.first?.text,
                !name.isEmpty {
                StorageManager.shared.create(name: String(name.prefix(20)), score: self.score)
            }
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alertView.addAction(saveAction)
        alertView.addAction(cancelAction)
        
        self.present(alertView, animated: true, completion: nil)
    }
}

// MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension BoardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 * 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        cell.card = deck?.pickCard()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let gameRules = gameRules else { return }
        
        if isFinished { return }
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        if !cell.isEnable { return }
        cell.flipCard()
        
        if selectedCards.count < gameRules.numberOfCards - 1 {
            // There aren't selected card.
            score -= 1
            selectedCards.append(cell)
            return
        }
        
        // Check if tap selected card.
        for selectedCard in selectedCards {
            if selectedCard.card == cell.card {
                // Is it the same card. (did tap selected card)
                self.selectedCards.removeAll(where: { $0.card == cell.card})
                return
            }
        }
        
        score -= 1
        
        // Check if score.
        let cards = selectedCards + [cell]
        let scoreData = gameRules.checkScore(cards: cards.compactMap({
            guard let card = $0.card else { return  nil }
            return card
        }))
        
        score += scoreData.score
        
        if !scoreData.isMatch {
            // It is not a match.
            selectedCards.forEach({$0.flipCard()})
            selectedCards = []
            selectedCards.append(cell)
            return
        }
        
        // It is a match.
        selectedCards.forEach({$0.disableCard()})
        cell.disableCard()
        self.selectedCards = []
        
        // Check if the game is over.
        if checkIsGameOver(cards: collectionView.visibleCells.compactMap({
            let cell = $0 as! CardCollectionViewCell
            if cell.isEnable { return cell.card }
            return nil
        })) {
            finishGame()
        }
    }
    
    override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()

      guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
        return
      }
        
      flowLayout.invalidateLayout()
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension BoardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIApplication.shared.statusBarOrientation.isLandscape {
            let width = collectionView.bounds.width/8.0 - Constants.collectionViewSpacing
            let height = 3/2 * width
            return CGSize(width: width, height: height)
            
            
        } else {
            let width = collectionView.bounds.width/4.0 - Constants.collectionViewSpacing
            let height = 3/2 * width
            return CGSize(width: width, height: height)
            
        }
    }
}
