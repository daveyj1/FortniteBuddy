//
//  ViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 1/24/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var survivalTimeLabel: UILabel!
    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var killDeathLabel: UILabel!
    @IBOutlet weak var KillsPerMatchLabel: UILabel!
    @IBOutlet weak var ScorePerMatchLabel: UILabel!
    @IBOutlet weak var matchTypeSelector: UISegmentedControl!
    
    var username = ""
    var console = ""
    var wins = ""
    var survivalTime = ""
    var kills = ""
    var score = ""
    var killDeath = ""
    var kpm = ""
    var spm = ""
    var working = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.white
        getSoloStats()
    }

    func getTheStuff() {
        activityIndicator.startAnimating()
        if username == "" {
            playerNotFound()
            activityIndicator.stopAnimating()
            return
        }
        let url = "https://fortnitebuddyapi.herokuapp.com/user/\(username)"
        let encoded = url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        guard let encodedAgain = encoded.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            return
        }
        guard let urlString = URL(string: encodedAgain) else {
            return
        }
        let req: URLRequest = URLRequest.init(url: urlString)
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                guard let usableData = data else {
                    return
                }
                guard let json = try! JSONSerialization.jsonObject(with: usableData, options: []) as? [String: Any] else {
                    return
                }
                if (json.isEmpty) {
                    self.playerNotFound()
                    OperationQueue.main.addOperation {
                        self.activityIndicator.stopAnimating()
                    }
                    return
                }
            }
        }
        task.resume()
    }
    
    func getSoloStats() {
        activityIndicator.startAnimating()
        if username == "" {
            playerNotFound()
            activityIndicator.stopAnimating()
            return
        }
        let url = "https://fortnitebuddyapi.herokuapp.com/user/\(username)"
        let encoded = url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        guard let encodedAgain = encoded.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            return
        }
        guard let urlString = URL(string: encodedAgain) else {
            return
        }
        let req: URLRequest = URLRequest.init(url: urlString)
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                guard let usableData = data else {
                    return
                }
                guard let json = try! JSONSerialization.jsonObject(with: usableData, options: []) as? [String: Any] else {
                    return
                }
                if (json.isEmpty) {
                    self.playerNotFound()
                    OperationQueue.main.addOperation {
                        self.activityIndicator.stopAnimating()
                    }
                    return
                }
                if (json["Solo"] == nil) {
                    OperationQueue.main.addOperation {
                        self.usernameLabel.text = self.username
                        self.winsLabel.text = "Wins: NA"
                        self.killsLabel.text = "Kills: NA"
                        self.survivalTimeLabel.text = "Matches: NA"
                        self.scoreLabel.text = "Score: NA"
                        self.killDeathLabel.text = "Kill/Death: NA"
                        self.KillsPerMatchLabel.text = "Kills per Match: NA"
                        self.ScorePerMatchLabel.text = "Win Percentage: NA"
                        self.activityIndicator.stopAnimating()
                    }
                    return
                }
                let solos = json["Solo"]! as! [String: Any]
                for (key, value) in solos {
                    if (key == "Wins") {
                        self.wins = value as! String
                    }
                    else if (key == "Matches") {
                        self.survivalTime = value as! String
                    }
                    else if (key == "Kills") {
                        self.kills = value as! String
                    }
                    else if (key == "Score") {
                        self.score = value as! String
                    }
                    else if (key == "K/D") {
                        self.killDeath = value as! String
                    }
                    else if (key == "K/match") {
                        self.kpm = value as! String
                    }
                    else if (key == "Win%") {
                        self.spm = value as! String
                    }
                    // removed score per min
                    // Highest Kill Game!!!!!!!!!!!!!!!!!!!!!!
                    // Longest win streak value!!!!!!!!!!!!!!!!
                    // Longest kill streak!!!!!!!!!!!!!!!!!!!!!
                    // Top 10/25!!!!!!!!!!!!!!!!!!!!
                }
            }
            
            OperationQueue.main.addOperation {
                if self.working {
                    self.usernameLabel.text = self.username
                    self.winsLabel.text = "Wins: \(self.wins)"
                    self.killsLabel.text = "Kills: \(self.kills)"
                    self.survivalTimeLabel.text = "Matches: \(self.survivalTime)"
                    self.scoreLabel.text = "Score: \(self.score)"
                    self.killDeathLabel.text = "Kill/Death: \(self.killDeath)"
                    self.KillsPerMatchLabel.text = "Kills per Match: \(self.kpm)"
                    self.ScorePerMatchLabel.text = "Win Percentage: \(self.spm)"
                } else {
                    self.usernameLabel.text = "Player Not Found"
                    self.winsLabel.text = "Wins: NA"
                    self.killsLabel.text = "Kills: NA"
                    self.survivalTimeLabel.text = "Matches: NA"
                    self.scoreLabel.text = "Score: NA"
                    self.killDeathLabel.text = "Kill/Death: NA"
                    self.KillsPerMatchLabel.text = "Kills per Match: NA"
                    self.ScorePerMatchLabel.text = "Win Percentage: NA"
                }
                self.activityIndicator.stopAnimating()
            }
        }
        task.resume()
    }
    
    func getDuoStats() {
        activityIndicator.startAnimating()
        if username == "" {
            playerNotFound()
            activityIndicator.stopAnimating()
            return
        }
        let url = "https://fortnitebuddyapi.herokuapp.com/user/\(username)"
        let encoded = url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        guard let encodedAgain = encoded.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            return
        }
        guard let urlString = URL(string: encodedAgain) else {
            return
        }
        let req: URLRequest = URLRequest.init(url: urlString)
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                guard let usableData = data else {
                    return
                }
                guard let json = try! JSONSerialization.jsonObject(with: usableData, options: []) as? [String: Any] else {
                    return
                }
                if (json.isEmpty) {
                    self.playerNotFound()
                    OperationQueue.main.addOperation {
                        self.activityIndicator.stopAnimating()
                    }
                    return
                }
                if (json["Duos"] == nil) {
                    OperationQueue.main.addOperation {
                        self.usernameLabel.text = self.username
                        self.winsLabel.text = "Wins: NA"
                        self.killsLabel.text = "Kills: NA"
                        self.survivalTimeLabel.text = "Matches: NA"
                        self.scoreLabel.text = "Score: NA"
                        self.killDeathLabel.text = "Kill/Death: NA"
                        self.KillsPerMatchLabel.text = "Kills per Match: NA"
                        self.ScorePerMatchLabel.text = "Win Percentage: NA"
                        self.activityIndicator.stopAnimating()
                    }
                    return
                }
                let duos = json["Duos"]! as! [String: Any]
                for (key, value) in duos {
                    if (key == "Wins") {
                        self.wins = value as! String
                    }
                    else if (key == "Matches") {
                        self.survivalTime = value as! String
                    }
                    else if (key == "Kills") {
                        self.kills = value as! String
                    }
                    else if (key == "Score") {
                        self.score = value as! String
                    }
                    else if (key == "K/D") {
                        self.killDeath = value as! String
                    }
                    else if (key == "K/match") {
                        self.kpm = value as! String
                    }
                    else if (key == "Win%") {
                        self.spm = value as! String
                    }
                    // removed score per min
                    // Highest Kill Game!!!!!!!!!!!!!!!!!!!!!!
                    // Longest win streak value!!!!!!!!!!!!!!!!
                    // Longest kill streak!!!!!!!!!!!!!!!!!!!!!
                    // Top 10/25!!!!!!!!!!!!!!!!!!!!
                }
            }
            
            OperationQueue.main.addOperation {
                if self.working {
                    self.usernameLabel.text = self.username
                    self.winsLabel.text = "Wins: \(self.wins)"
                    self.killsLabel.text = "Kills: \(self.kills)"
                    self.survivalTimeLabel.text = "Matches: \(self.survivalTime)"
                    self.scoreLabel.text = "Score: \(self.score)"
                    self.killDeathLabel.text = "Kill/Death: \(self.killDeath)"
                    self.KillsPerMatchLabel.text = "Kills per Match: \(self.kpm)"
                    self.ScorePerMatchLabel.text = "Win Percentage: \(self.spm)"
                } else {
                    self.usernameLabel.text = "Player Not Found"
                    self.winsLabel.text = "Wins: NA"
                    self.killsLabel.text = "Kills: NA"
                    self.survivalTimeLabel.text = "Matches: NA"
                    self.scoreLabel.text = "Score: NA"
                    self.killDeathLabel.text = "Kill/Death: NA"
                    self.KillsPerMatchLabel.text = "Kills per Match: NA"
                    self.ScorePerMatchLabel.text = "Win Percentage: NA"
                }
                self.activityIndicator.stopAnimating()
            }
        }
        task.resume()
    }
    
    func getSquadStats() {
        activityIndicator.startAnimating()
        if username == "" {
            playerNotFound()
            activityIndicator.stopAnimating()
            return
        }
        let url = "https://fortnitebuddyapi.herokuapp.com/user/\(username)"
        let encoded = url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        guard let encodedAgain = encoded.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            return
        }
        guard let urlString = URL(string: encodedAgain) else {
            return
        }
        let req: URLRequest = URLRequest.init(url: urlString)
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                guard let usableData = data else {
                    return
                }
                guard let json = try! JSONSerialization.jsonObject(with: usableData, options: []) as? [String: Any] else {
                    return
                }
                if (json.isEmpty) {
                    self.playerNotFound()
                    OperationQueue.main.addOperation {
                        self.activityIndicator.stopAnimating()
                    }
                    return
                }
                if (json["Squads"] == nil) {
                    OperationQueue.main.addOperation {
                        self.usernameLabel.text = self.username
                        self.winsLabel.text = "Wins: NA"
                        self.killsLabel.text = "Kills: NA"
                        self.survivalTimeLabel.text = "Matches: NA"
                        self.scoreLabel.text = "Score: NA"
                        self.killDeathLabel.text = "Kill/Death: NA"
                        self.KillsPerMatchLabel.text = "Kills per Match: NA"
                        self.ScorePerMatchLabel.text = "Win Percentage: NA"
                        self.activityIndicator.stopAnimating()
                    }
                    return
                }
                let squads = json["Squads"]! as! [String: Any]
                for (key, value) in squads {
                    if (key == "Wins") {
                        self.wins = value as! String
                    }
                    else if (key == "Matches") {
                        self.survivalTime = value as! String
                    }
                    else if (key == "Kills") {
                        self.kills = value as! String
                    }
                    else if (key == "Score") {
                        self.score = value as! String
                    }
                    else if (key == "K/D") {
                        self.killDeath = value as! String
                    }
                    else if (key == "K/match") {
                        self.kpm = value as! String
                    }
                    else if (key == "Win%") {
                        self.spm = value as! String
                    }
                    // removed score per min
                    // Highest Kill Game!!!!!!!!!!!!!!!!!!!!!!
                    // Longest win streak value!!!!!!!!!!!!!!!!
                    // Longest kill streak!!!!!!!!!!!!!!!!!!!!!
                    // Top 10/25!!!!!!!!!!!!!!!!!!!!
                }
            }
            
            OperationQueue.main.addOperation {
                if self.working {
                    self.usernameLabel.text = self.username
                    self.winsLabel.text = "Wins: \(self.wins)"
                    self.killsLabel.text = "Kills: \(self.kills)"
                    self.survivalTimeLabel.text = "Matches: \(self.survivalTime)"
                    self.scoreLabel.text = "Score: \(self.score)"
                    self.killDeathLabel.text = "Kill/Death: \(self.killDeath)"
                    self.KillsPerMatchLabel.text = "Kills per Match: \(self.kpm)"
                    self.ScorePerMatchLabel.text = "Win Percentage: \(self.spm)"
                } else {
                    self.usernameLabel.text = "Player Not Found"
                    self.winsLabel.text = "Wins: NA"
                    self.killsLabel.text = "Kills: NA"
                    self.survivalTimeLabel.text = "Matches: NA"
                    self.scoreLabel.text = "Score: NA"
                    self.killDeathLabel.text = "Kill/Death: NA"
                    self.KillsPerMatchLabel.text = "Kills per Match: NA"
                    self.ScorePerMatchLabel.text = "Win Percentage: NA"
                }
                self.activityIndicator.stopAnimating()
            }
        }
        task.resume()
    }
    
    func playerNotFound() {
        OperationQueue.main.addOperation {
            self.usernameLabel.text = "Player Not Found"
            self.winsLabel.text = "Wins: NA"
            self.killsLabel.text = "Kills: NA"
            self.survivalTimeLabel.text = "Average Match Time: NA"
            self.scoreLabel.text = "Score: NA"
            self.killDeathLabel.text = "Kill/Death: NA"
            self.KillsPerMatchLabel.text = "Kills per Match: NA"
            self.ScorePerMatchLabel.text = "Score per Match: NA"
        }
    }
    
    @IBAction func selectMatchType(_ sender: UISegmentedControl) {
        if matchTypeSelector.selectedSegmentIndex == 0 {
            getSoloStats()
        } else if matchTypeSelector.selectedSegmentIndex == 1 {
            getDuoStats()
        } else if matchTypeSelector.selectedSegmentIndex == 2 {
            getSquadStats()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

