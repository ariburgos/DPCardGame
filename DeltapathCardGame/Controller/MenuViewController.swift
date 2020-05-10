//
//  MenuViewController.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 17/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private var selectedGameRules = GameRules.set()
    
    @IBAction func didTapStandardGameButton(_ sender: Any) {
        selectedGameRules = GameRules.standard52()
        performSegue(withIdentifier: "DisplayBoardViewSegue", sender: nil)
    }

    @IBAction func didTapSetGameButton(_ sender: Any) {
        selectedGameRules = GameRules.set()
        performSegue(withIdentifier: "DisplayBoardViewSegue", sender: nil)
    }
    
    @IBAction func didTapHighScoresButton(_ sender: Any) {
        performSegue(withIdentifier: "DisplayHighScoresViewSegue", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DisplayBoardViewSegue") {
            let vc = segue.destination as! BoardViewController
            vc.gameRules = selectedGameRules
        }
    }
    
}
