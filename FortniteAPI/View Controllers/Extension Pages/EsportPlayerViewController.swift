//
//  EsportPlayerViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 3/27/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit

class EsportPlayerViewController: UIViewController {
    
    @IBOutlet weak var teamLabel: UILabel!
    
    var teamName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamLabel.text = teamName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
