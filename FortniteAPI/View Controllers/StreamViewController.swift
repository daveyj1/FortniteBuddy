//
//  StreamViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 3/21/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit

class StreamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var streams: [[String: Any]] = [[:]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        getStreams()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getStreams() {
        let urlString = URL(string: "https://api.twitch.tv/kraken/streams?game=Fortnite&first20")
        var req: URLRequest = URLRequest.init(url: urlString!)
        req.setValue("8n8shwx5zp0qa327r0i45o8vhabxn2", forHTTPHeaderField: "Client-ID")
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            guard let usableData = data else {
                return
            }

            guard let json = try! JSONSerialization.jsonObject(with: usableData, options: []) as? [String: Any] else {
                return
            }
            
            guard let temp = json["streams"] as? [[String: Any]] else {
                return
            }
            
            self.streams = temp
            
            /*
            guard let channels = self.streams[0] as? [String: Any] else {
                print("Bad Channel")
                return
            }
            guard let channelInfo = channels["channel"] as? [String: Any] else {
                print("Bad Info")
                return
            }
            */
            
            //print(channelInfo["url"])
            //dump(channelInfo)
            
            
            /*
            print(channels["name"])
            print(channels["url"])
            print(channels["viewers"])
            print(channels["profile_banner"])
            */
            
            /*
            for (key, _) in streams {
                print("d")
                print(key)
            }
            */
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        sleep(5)
        let cell = tableView.dequeueReusableCell(withIdentifier: "StreamCell") as! StreamCell
        print(self.streams)
        let channel = streams[indexPath.row] as? [String: Any]
        let channelInfo = channel!["channel"] as? [String: Any]
        //cell.nameLabel.text = channelInfo!["name"] as! String
        
        return cell
    }
}
