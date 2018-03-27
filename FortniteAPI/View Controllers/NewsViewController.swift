//
//  NewsViewController.swift
//  FortniteAPI
//
//  Created by Joey Dafforn on 3/23/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var newsWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.epicgames.com/fortnite/en-US/news")
        //let url = URL(string: "https://stormshield.one/pvp")
        if let unwrappedURL = url {
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        self.newsWebView.loadRequest(request)
                    }
                }
                else {
                    print("Error: \(error?.localizedDescription)")
                }
            }
            task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
