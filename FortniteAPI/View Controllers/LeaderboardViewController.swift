//
//  LeaderboardViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 3/26/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let players = ["Twitch_Ettnix", "Twitch_Svennoss", "WBG Strafesh0t", "Ninja", "Solary Kinstaar", "Uwatakashi.TV", "TSM_MYTH", "Zaccubus", "OC Woodpecker", "Infamous Uniq", "Moshy1", "Chambers-", "Twitch APEXENITH", "K - BOOGEYMAN", "Hamlinz", "OC LnNzera", "Dark", "Twitch_PuZiiyo", "KingRichard15", "StancodTV", "Miniding", "SypherPK", "quan_khi", "Infamous Thế Anh", "ReddCinema"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 115
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell") as! LeaderboardCell
        cell.usernameLabel.text = players[indexPath.row]
        cell.rankLabel.text = "#\(String(indexPath.row+1))"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ViewController
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let cell2 = tableView.cellForRow(at: indexPath) as! LeaderboardCell
            dvc.username = cell2.usernameLabel.text!
            dvc.console = "pc"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
