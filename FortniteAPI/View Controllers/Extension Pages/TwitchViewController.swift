//
//  TwitchViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 3/22/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit
import WebKit

class TwitchViewController: UIViewController {
    
    @IBOutlet weak var streamView: WKWebView!
    var urlString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: urlString)
        if let working = url {
            let request = URLRequest(url: working)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    if error == nil {
                        self.streamView.load(request)
                    } else {
                        print("ERROR: \(error)")
                    }
                }
            }
            task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
