//
//  StreamViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 3/21/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit

class StreamViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getStreams()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getStreams() {
        let urlString = URL(string: "https://api.twitch.tv/kraken/streams/game=Fortnite")
        var req: URLRequest = URLRequest.init(url: urlString!)
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            guard let usableData = data else {
                return
            }
            
            guard let json = try! JSONSerialization.jsonObject(with: usableData, options: []) as? [String: Any] else {
                return
            }
            
            print(json)
        }
        task.resume()
    }
}
