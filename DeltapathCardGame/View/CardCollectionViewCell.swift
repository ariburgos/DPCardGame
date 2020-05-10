//
//  CardCollectionViewCell.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 17/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    struct Constants {
        fileprivate static let cardDisabledAlpha: CGFloat = 0.55
    }
    
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    
    var isFaceDown: Bool = true
    var isAnimating: Bool = false
    var isEnable: Bool = true
    
    var card: Card? {
        didSet {
            frontView.isHidden = true
            backView.isHidden = false
            
            isFaceDown = true
            isAnimating = false
            isEnable = true
            
            contentView.alpha = 1
            
            if let standardCard = card as? StandardCard {
                mainLabel.text = (standardCard.rank.rawValue) + (standardCard.suit.rawValue)
            } else
                if let setCard = card as? SetCard {
                    mainLabel.font = UIFont(name: mainLabel.font.fontName, size: 16)
                    
                    mainLabel.text = "\(setCard.number.rawValue) \n\(setCard.shading.rawValue) \n\(setCard.symbol.rawValue)"
                    switch setCard.color {
                    case .blue:
                        mainLabel.textColor = UIColor.blue
                    case .green:
                        mainLabel.textColor = UIColor.darkGreen
                    case .red:
                        mainLabel.textColor = UIColor.red
                    }
            }
        }
    }
    
    func flipCard() {
        if isAnimating,
            !isEnable { return }
        
        isAnimating = true
        
        if isFaceDown {
            let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
            UIView.transition(with: contentView, duration: 1.0, options: transitionOptions, animations: {
                self.backView.isHidden = true
                self.frontView.isHidden = false
                
            })
            isFaceDown = false
        } else {
            let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
            UIView.transition(with: contentView, duration: 1.0, options: transitionOptions, animations: {
                self.frontView.isHidden = true
                self.backView.isHidden = false
                
            })
            isFaceDown = true
        }
        
        isAnimating = false
    }
    
    func disableCard() {
        contentView.alpha = Constants.cardDisabledAlpha
        isEnable = false
    }
}
