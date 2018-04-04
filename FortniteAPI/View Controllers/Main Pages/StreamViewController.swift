//
//  StreamViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 3/21/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit
import AlamofireImage

class StreamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
    var streams: [[String: Any]] = [[:]]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.layer.backgroundColor = UIColor.clear.cgColor
        getStreams()
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(StreamViewController.refresh(sender:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func refresh(sender:AnyObject) {
        getStreams()
        refreshControl.endRefreshing()
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
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streams.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StreamCell") as! StreamCell
        guard let channel = streams[indexPath.row] as? [String: Any] else {
            print("NO CHANNEL")
            return cell
        }
        guard let channelInfo = channel["channel"] as? [String: Any] else {
            print("NO INFO")
            return cell
        }
        
        let viewers = channel["viewers"]
        
        if let name = channelInfo["display_name"] as? String {
            cell.nameLabel.text = name
        }
        if let status = channelInfo["status"] as? String {
            cell.statusLabel.text = status
        }
        if let logo = channelInfo["logo"] as? String {
            let logoURL = URL(string: logo)!
            cell.profileImage.af_setImage(withURL: logoURL)
            cell.profileImage.layer.cornerRadius = 10
        }
        if viewers != nil {
            cell.viewerLabel.text = "\(String(describing: viewers!)) viewers"
        }
        if let url = channelInfo["url"] as? String {
            cell.streamLink = url
        } else {
            print("URL NOT SET")
        }
        cell.layer.backgroundColor = UIColor.clear.cgColor
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let cell2 = tableView.cellForRow(at: indexPath) as! StreamCell
            let vc = segue.destination as! TwitchViewController
            vc.urlString = cell2.streamLink
        }
        
    }
}
