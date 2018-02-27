//
//  SearchViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 2/26/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBox: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! ViewController
        detailViewController.username = searchBox.text!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
