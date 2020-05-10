//
//  GameRules.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 18/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation

struct GameRules {
    enum GameType {
        case standard52
        case set
    }
    
    var numberOfCards: Int
    var gameType: GameType
    
    private init(numberOfCards: Int, gameType: GameType) {
        self.numberOfCards = numberOfCards
        self.gameType = gameType
    }
    
    static func standard52() -> GameRules {
        GameRules(numberOfCards: 2, gameType: .standard52)
    }
    
    static func set() -> GameRules {
        GameRules(numberOfCards: 3, gameType: .set)
    }
    
    func checkScore(cards: [Card]) -> (isMatch: Bool, score: Int16) {
        switch gameType {
        case .standard52:
            guard let first = cards[0] as? StandardCard,
                let second = cards[1] as? StandardCard else { return (isMatch: false, score: 0) }
            
            if cards.count != numberOfCards { return (isMatch: false, score: 0) }
            
            
            if first.rank == second.rank {
                return (isMatch: true, score: 16)
            } else if first.suit == second.suit {
                return (isMatch: true, score: 4)
            } else {
                return (isMatch: false, score: -2)
            }
            
        case .set:
            guard let first = cards[0] as? SetCard,
                let second = cards[1] as? SetCard,
                let third = cards[2] as? SetCard else { return (isMatch: false, score: 0) }
            
            if cards.count != numberOfCards { return (isMatch: false, score: 0) }
            
            if areAllSameOrDiferent(first: first.number, second: second.number, third: third.number),
                areAllSameOrDiferent(first: first.symbol, second: second.symbol, third: third.symbol),
                areAllSameOrDiferent(first: first.shading, second: second.shading, third: third.shading),
                areAllSameOrDiferent(first: first.color, second: second.color, third: third.color){
                return (isMatch: true, score: 16)
            }
            return (isMatch: false, score: -2)
        }
    }
    
    func newDeck() -> Deck {
        switch gameType {
        case .standard52:
            return Deck.standard52CardDeck()
        case .set:
            return Deck.setCardDeck()
        }
    }
    
    func checkIsGameOver(cards: [Card]) -> Bool {
        switch gameType {
        case .standard52:
            for firstCard in cards {
                for seccondCard in cards {
                    if firstCard == seccondCard { break }
                    if checkScore(cards: [firstCard, seccondCard]).isMatch {
                        return false
                    }
                }
            }
            return true
            
            
        case .set:
            for firstCard in cards {
                for seccondCard in cards {
                    for thirdCard in cards {
                        if firstCard == seccondCard ||
                            seccondCard == thirdCard ||
                            firstCard == thirdCard { break }
                        if checkScore(cards: [firstCard, seccondCard, thirdCard]).isMatch {
                            return false
                        }
                    }
                }
            }
            return true
        }
    }
    
    private func areAllSameOrDiferent<T: Comparable>(first: T, second: T, third: T) -> Bool {
        if (first == second && second == third && third == first) ||
            (first != second && second != third && third != first) {
            return true
        }
        return false
    }
}
