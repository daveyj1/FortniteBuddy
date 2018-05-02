//
//  LeaderboardViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 3/26/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit
import SwiftSoup


class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var players = [""]

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.white
        scrapeHTML()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 115
        
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func scrapeHTML() -> Void {
        activityIndicator.startAnimating()
        let url = "https://fortnitebuddyapi.herokuapp.com/leaderboards/pc/1"
        guard let urlString = URL(string: url) else {
            return
        }
        let req: URLRequest = URLRequest.init(url: urlString)
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            if error != nil {
                print(error)
            }
            else {
                guard let usableData = data else {
                    return
                }
                guard let json = try! JSONSerialization.jsonObject(with: usableData, options: []) as? [String: Any] else {
                    return
                }
                let arrayAsdf = json["leaderboard"]! as? [[String: Any]]
                self.players.removeAll()
                for player in arrayAsdf! {
                    if let username = player["username"] as? String {
                        var dataenc = username.data(using: String.Encoding.nonLossyASCII)
                        var encodevalue = String(data: dataenc!, encoding: String.Encoding.utf8)
                        var datadec  = encodevalue?.data(using: String.Encoding.utf8)
                        var decodevalue = String(data: datadec!, encoding: String.Encoding.nonLossyASCII)
                        //print(decodevalue!)
                        self.players.append(decodevalue!)
                    }
                }
            }
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()

            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell") as! LeaderboardCell
        cell.usernameLabel.text = players[indexPath.row]
        //print(players[indexPath.row])
        cell.rankLabel.text = "#\(String(indexPath.row+1))"
        cell.layer.backgroundColor = UIColor.clear.cgColor
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
