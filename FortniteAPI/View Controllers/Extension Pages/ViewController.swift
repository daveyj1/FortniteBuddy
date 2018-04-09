//
//  ViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 1/24/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit

//import Alamofire

class ViewController: UIViewController {
    
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
    
    //var games:
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
        getSoloStats()
        //getDuoStats()
        //getSquadStats()
        //getStats()
    }
    
    func getSoloStats() {
        if username == "" {
            playerNotFound()
            return
        }
        print(username)
        let url = "https://api.fortnitetracker.com/v1/profile/\(console)/\(username)"
        let encoded = url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        print(encoded)
        guard let urlString = URL(string: encoded) else {
            print("https://api.fortnitetracker.com/v1/profile/\(console)/\(username)")
            return
        }
        var req: URLRequest = URLRequest.init(url: urlString)
        req.setValue("7c57a9c5-6600-4e0f-a292-74a02cc1bcb6", forHTTPHeaderField: "TRN-Api-Key")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                guard let usableData = data else {
                    return
                }
                guard let json = try! JSONSerialization.jsonObject(with: usableData, options: []) as? [String: Any] else {
                    return
                }
                
                if let error = json["error"] as? String {
                    if error == "Player Not Found" {
                        print("player not found")
                        self.working = false
                        self.playerNotFound()
                    }
                }
                
                guard let soloJSON = json["stats"] as? [String: Any] else {
                   return
                }
                guard let currP2 = soloJSON["curr_p2"] as? [String: Any] else {
                    return
                }
                
                //GETTING ALL THE VALUES FOR THE LABELS
                //=====================================
                if let user = json["epicUserHandle"]! as? String {
                    self.username = user
                }
                
                guard let wins = currP2["top1"] as? [String: Any] else {
                    return
                }
                self.wins = wins["displayValue"]! as! String
                
                guard let avgPlay = currP2["avgTimePlayed"] as? [String: Any] else {
                    return
                }
                self.survivalTime = avgPlay["displayValue"]! as! String
                
                guard let kills = currP2["kills"] as? [String: Any] else {
                    return
                }
                self.kills = kills["displayValue"]! as! String
                
                guard let score = currP2["score"] as? [String: Any] else {
                    return
                }
                self.score = score["displayValue"]! as! String
                
                guard let killDeath = currP2["kd"] as? [String: Any] else {
                    return
                }
                self.killDeath = killDeath["displayValue"]! as! String
                
                guard let kpm = currP2["kpg"] as? [String: Any] else {
                    return
                }
                self.kpm = kpm["displayValue"]! as! String
                
                guard let spm = currP2["scorePerMatch"] as? [String: Any] else {
                    return
                }
                self.spm = spm["displayValue"]! as! String
                //==================================
                
                /*
                for (key, _) in currP2 {
                    print(key)
                }
                */
            }
            OperationQueue.main.addOperation {
                if self.working {
                    self.usernameLabel.text = self.username
                    self.winsLabel.text = "Wins: \(self.wins)"
                    self.killsLabel.text = "Kills: \(self.kills)"
                    self.survivalTimeLabel.text = "Average Match Time: \(self.survivalTime)"
                    self.scoreLabel.text = "Score: \(self.score)"
                    self.killDeathLabel.text = "Kill/Death: \(self.killDeath)"
                    self.KillsPerMatchLabel.text = "Kills per Match: \(self.kpm)"
                    self.ScorePerMatchLabel.text = "Score per Match: \(self.spm)"
                } else {
                    self.usernameLabel.text = "Player Not Found"
                    self.winsLabel.text = "Wins: NA"
                    self.killsLabel.text = "Kills: NA"
                    self.survivalTimeLabel.text = "Survival Time: NA"
                    self.scoreLabel.text = "Score: NA"
                    self.killDeathLabel.text = "Kill/Death: NA"
                    self.KillsPerMatchLabel.text = "Kills per Match: NA"
                    self.ScorePerMatchLabel.text = "Score per Match: NA"
                }
            }
        }
        task.resume()
    }
    
    func getDuoStats() {
        if username == "" {
            playerNotFound()
            return
        }
        let url = "https://api.fortnitetracker.com/v1/profile/\(console)/\(username)"
        let encoded = url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        guard let urlString = URL(string: encoded) else {
            return
        }
        var req: URLRequest = URLRequest.init(url: urlString)
        req.setValue("7c57a9c5-6600-4e0f-a292-74a02cc1bcb6", forHTTPHeaderField: "TRN-Api-Key")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                guard let usableData = data else {
                    return
                }
                
                guard let json = try! JSONSerialization.jsonObject(with: usableData, options: []) as? [String: Any] else {
                    return
                }
                
                if let error = json["error"] as? String {
                    if error == "Player Not Found" {
                        print("player not found")
                        self.working = false
                        self.playerNotFound()
                    }
                }
                
                guard let soloJSON = json["stats"] as? [String: Any] else {
                    return
                }
                guard let currP2 = soloJSON["curr_p10"] as? [String: Any] else {
                    return
                }
                
                //GETTING ALL THE VALUES FOR THE LABELS
                //=====================================
                if let user = json["epicUserHandle"]! as? String {
                    self.username = user
                }
                
                guard let wins = currP2["top1"] as? [String: Any] else {
                    return
                }
                self.wins = wins["displayValue"]! as! String
                
                guard let avgPlay = currP2["avgTimePlayed"] as? [String: Any] else {
                    return
                }
                self.survivalTime = avgPlay["displayValue"]! as! String
                
                guard let kills = currP2["kills"] as? [String: Any] else {
                    return
                }
                self.kills = kills["displayValue"]! as! String
                
                guard let score = currP2["score"] as? [String: Any] else {
                    return
                }
                self.score = score["displayValue"]! as! String
                
                guard let killDeath = currP2["kd"] as? [String: Any] else {
                    return
                }
                self.killDeath = killDeath["displayValue"]! as! String
                
                guard let kpm = currP2["kpg"] as? [String: Any] else {
                    return
                }
                self.kpm = kpm["displayValue"]! as! String
                
                guard let spm = currP2["scorePerMatch"] as? [String: Any] else {
                    return
                }
                self.spm = spm["displayValue"]! as! String
                //==================================
                
                /*
                 for (key, _) in currP2 {
                 print(key)
                 }
                 */
            }
            OperationQueue.main.addOperation {
                if self.working {
                    self.usernameLabel.text = self.username
                    self.winsLabel.text = "Wins: \(self.wins)"
                    self.killsLabel.text = "Kills: \(self.kills)"
                    self.survivalTimeLabel.text = "Average Match Time: \(self.survivalTime)"
                    self.scoreLabel.text = "Score: \(self.score)"
                    self.killDeathLabel.text = "Kill/Death: \(self.killDeath)"
                    self.KillsPerMatchLabel.text = "Kills per Match: \(self.kpm)"
                    self.ScorePerMatchLabel.text = "Score per Match: \(self.spm)"
                } else {
                    self.usernameLabel.text = "Player Not Found"
                    self.winsLabel.text = "Wins: NA"
                    self.killsLabel.text = "Kills: NA"
                    self.survivalTimeLabel.text = "Survival Time: NA"
                    self.scoreLabel.text = "Score: NA"
                    self.killDeathLabel.text = "Kill/Death: NA"
                    self.KillsPerMatchLabel.text = "Kills per Match: NA"
                    self.ScorePerMatchLabel.text = "Score per Match: NA"
                }
            }
        }
        task.resume()
    }
    
    func getSquadStats() {
        if username == "" {
            playerNotFound()
            return
        }
        let url = "https://api.fortnitetracker.com/v1/profile/\(console)/\(username)"
        let encoded = url.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        guard let urlString = URL(string: encoded) else {
            return
        }
        var req: URLRequest = URLRequest.init(url: urlString)
        req.setValue("7c57a9c5-6600-4e0f-a292-74a02cc1bcb6", forHTTPHeaderField: "TRN-Api-Key")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                guard let usableData = data else {
                    return
                }
                
                guard let json = try! JSONSerialization.jsonObject(with: usableData, options: []) as? [String: Any] else {
                    return
                }
                
                if let error = json["error"] as? String {
                    if error == "Player Not Found" {
                        print("player not found")
                        self.working = false
                        self.playerNotFound()
                    }
                }
                
                guard let soloJSON = json["stats"] as? [String: Any] else {
                    return
                }
                guard let currP2 = soloJSON["curr_p9"] as? [String: Any] else {
                    return
                }
                
                //GETTING ALL THE VALUES FOR THE LABELS
                //=====================================
                if let user = json["epicUserHandle"]! as? String {
                    self.username = user
                }
                
                guard let wins = currP2["top1"] as? [String: Any] else {
                    return
                }
                self.wins = wins["displayValue"]! as! String
                
                guard let avgPlay = currP2["avgTimePlayed"] as? [String: Any] else {
                    return
                }
                self.survivalTime = avgPlay["displayValue"]! as! String
                
                guard let kills = currP2["kills"] as? [String: Any] else {
                    return
                }
                self.kills = kills["displayValue"]! as! String
                
                guard let score = currP2["score"] as? [String: Any] else {
                    return
                }
                self.score = score["displayValue"]! as! String
                
                guard let killDeath = currP2["kd"] as? [String: Any] else {
                    return
                }
                self.killDeath = killDeath["displayValue"]! as! String
                
                guard let kpm = currP2["kpg"] as? [String: Any] else {
                    return
                }
                self.kpm = kpm["displayValue"]! as! String
                
                guard let spm = currP2["scorePerMatch"] as? [String: Any] else {
                    return
                }
                self.spm = spm["displayValue"]! as! String
                //==================================
                
                /*
                 for (key, _) in currP2 {
                 print(key)
                 }
                 */
            }
            OperationQueue.main.addOperation {
                if self.working {
                    self.usernameLabel.text = self.username
                    self.winsLabel.text = "Wins: \(self.wins)"
                    self.killsLabel.text = "Kills: \(self.kills)"
                    self.survivalTimeLabel.text = "Average Match Time: \(self.survivalTime)"
                    self.scoreLabel.text = "Score: \(self.score)"
                    self.killDeathLabel.text = "Kill/Death: \(self.killDeath)"
                    self.KillsPerMatchLabel.text = "Kills per Match: \(self.kpm)"
                    self.ScorePerMatchLabel.text = "Score per Match: \(self.spm)"
                } else {
                    self.usernameLabel.text = "Player Not Found"
                    self.winsLabel.text = "Wins: NA"
                    self.killsLabel.text = "Kills: NA"
                    self.survivalTimeLabel.text = "Survival Time: NA"
                    self.scoreLabel.text = "Score: NA"
                    self.killDeathLabel.text = "Kill/Death: NA"
                    self.KillsPerMatchLabel.text = "Kills per Match: NA"
                    self.ScorePerMatchLabel.text = "Score per Match: NA"
                }
            }
        }
        task.resume()
    }
    
    func getStats() {
        let url = "https://api.fortnitetracker.com/v1/profile/\(console)/\(username)"
        let encoded = url.replacingOccurrences(of: " ", with: "%", options: .literal, range: nil)
        guard let urlString = URL(string: encoded) else {
            return
        }
        var req: URLRequest = URLRequest.init(url: urlString)
        req.setValue("7c57a9c5-6600-4e0f-a292-74a02cc1bcb6", forHTTPHeaderField: "TRN-Api-Key")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                if let usableData = data {
                    do{
                        if let json = try! JSONSerialization.jsonObject(with: usableData, options: .allowFragments) as? [String: Any] {
                            //print(json)
                            if let error = json["error"] as? String {
                                if error == "Player Not Found" {
                                    print("player not found")
                                    self.working = false
                                }
                            } else {
                                if let user = json["epicUserHandle"]! as? String {
                                    self.username = user
                                }
                                if let lifetimeStats = json["lifeTimeStats"] as? [[String: Any]] {
                                    for stat in lifetimeStats {
                                        if (stat["key"] as! String) == "Wins" {
                                            self.wins = stat["value"]! as! String
                                        }
                                        else if (stat["key"] as! String) == "Avg Survival Time" {
                                            self.survivalTime = stat["value"]! as! String
                                        }
                                        else if (stat["key"] as! String) == "Kills" {
                                            self.kills = stat["value"]! as! String
                                        }
                                    }
                                }
                            }
                        }
                    } catch {
                        print("error in JSONSerialization")
                    }
                }
            }
            OperationQueue.main.addOperation {
                if self.working {
                    self.usernameLabel.text = self.username
                    //self.usernameLabel.font = "BurbankBigCondensed-Bold" as! UIFont
                    self.winsLabel.text = "Wins: \(self.wins)"
                    self.killsLabel.text = "Kills: \(self.kills)"
                    self.survivalTimeLabel.text = "Survival Time: \(self.survivalTime)"
                } else {
                    self.usernameLabel.text = "Player Not Found"
                    self.winsLabel.text = "Wins: NA"
                    self.killsLabel.text = "Kills: NA"
                    self.survivalTimeLabel.text = "Survival Time: NA"
                }
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
            print("Solo Stats")
        } else if matchTypeSelector.selectedSegmentIndex == 1 {
            getDuoStats()
            print("Duo Stats")
        } else if matchTypeSelector.selectedSegmentIndex == 2 {
            getSquadStats()
            print("Squad Stats")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

