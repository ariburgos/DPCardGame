//
//  HighScoresViewController.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 17/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import UIKit

class HighScoresViewController: UIViewController {
    struct Constants {
        fileprivate static let headerHeight: CGFloat = 60
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var players: [Player] = []
    
    override func viewWillAppear(_ animated: Bool) {
        players = StorageManager.shared.getAllOrderedByScore()
    }
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension HighScoresViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreTableViewCell", for: indexPath) as! HighScoreTableViewCell
        cell.rankLabel.text = String(indexPath.row + 1)
        cell.nameLabel.text = players[indexPath.row].name
        cell.scoreLabel.text = String(players[indexPath.row].score)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableCell(withIdentifier: "HighScoreHeaderTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.headerHeight
    }
}
