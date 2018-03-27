//
//  SearchViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 2/26/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit
import Pastel

class SearchViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBox: UITextField!
    @IBOutlet weak var searchLabel: UIButton!
    
    @IBOutlet weak var xboxButton: UIButton!
    @IBOutlet weak var psnButton: UIButton!
    @IBOutlet weak var pcButton: UIButton!
    
    
    let consoles = ["XBone", "PS4", "PC"]
    var chosenConsole = "XBone"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xboxButton.setImage(#imageLiteral(resourceName: "icons8-xbox-filled-50 (2)"), for: .normal)
        searchLabel.layer.shadowOpacity = 15
        titleLabel.layer.shadowOpacity = 15
        searchBox.layer.cornerRadius = 15
        
        /*
        let pastelView = PastelView(frame: view.bounds)
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        // Custom Duration
        pastelView.animationDuration = 3.0
        // Custom Color
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 175/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0)])
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
        */
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if searchBox.text! == "" {
            return
        }
        let detailViewController = segue.destination as! ViewController
        detailViewController.username = searchBox.text!
        if chosenConsole == "XBone" {
            detailViewController.console = "xbl"
        }
        if chosenConsole == "PS4" {
            detailViewController.console = "psn"
        }
        if chosenConsole == "PC" {
            detailViewController.console = "pc"
        }
    }
    
    @IBAction func pickXbox(_ sender: UIButton) {
        chosenConsole = "XBone"
        xboxButton.setImage(#imageLiteral(resourceName: "icons8-xbox-filled-50 (2)"), for: .normal)
        pcButton.setImage(#imageLiteral(resourceName: "icons8-windows8-filled-50"), for: .normal)
        psnButton.setImage(#imageLiteral(resourceName: "icons8-playstation-filled-50"), for: .normal)
    }
    
    @IBAction func pickPSN(_ sender: UIButton) {
        chosenConsole = "PS4"
        xboxButton.setImage(#imageLiteral(resourceName: "icons8-xbox-filled-50"), for: .normal)
        pcButton.setImage(#imageLiteral(resourceName: "icons8-windows8-filled-50"), for: .normal)
        psnButton.setImage(#imageLiteral(resourceName: "icons8-playstation-filled-50 (2)"), for: .normal)
    }
    
    
    @IBAction func pickPC(_ sender: UIButton) {
        chosenConsole = "PC"
        xboxButton.setImage(#imageLiteral(resourceName: "icons8-xbox-filled-50"), for: .normal)
        pcButton.setImage(#imageLiteral(resourceName: "icons8-windows8-filled-50 (2)"), for: .normal)
        psnButton.setImage(#imageLiteral(resourceName: "icons8-playstation-filled-50"), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
