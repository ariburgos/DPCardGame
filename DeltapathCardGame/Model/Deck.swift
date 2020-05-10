//
//  Deck.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 17/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation

struct Deck {
    fileprivate var cards: [Card]

    public static func standard52CardDeck() -> Deck {
        let suits: [Suit] = [.spades, .hearts, .diamonds, .clubs]
        let ranks: [Rank] = [.two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king, .ace]

        var cards: [Card] = []
        for rank in ranks {
            for suit in suits {
                cards.append(StandardCard(rank: rank, suit: suit))
            }
        }

        return Deck(cards: cards)
    }
    
    public static func setCardDeck() -> Deck {
        let numbers: [Number] = [.one, .two, .three]
        let symbols: [Symbol] = [.diamond, .oval, .squiggle]
        let shadings: [Shading] = [.open, .solid, .striped]
        let colors: [Color] = [.blue, .green, .red]

        var cards: [Card] = []
        for number in numbers {
            for symbol in symbols {
                for shading in shadings {
                    for color in colors {
                        cards.append(SetCard(number: number, symbol: symbol, shading: shading, color: color))
                    }
                }
            }
        }

        return Deck(cards: cards)
    }

    public mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func pickCard() -> Card? {
        guard let card = cards.first else { return nil }
        cards.removeFirst()
        return card
    }
}
