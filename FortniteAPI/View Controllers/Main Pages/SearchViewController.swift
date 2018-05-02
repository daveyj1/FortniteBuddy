//
//  SearchViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 2/26/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit
import Pastel
import Shimmer

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var acivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ggView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBox: UITextField!
    @IBOutlet weak var searchLabel: UIButton!
    
    @IBOutlet weak var goldScar: UIImageView!
    @IBOutlet weak var xboxButton: UIButton!
    @IBOutlet weak var psnButton: UIButton!
    @IBOutlet weak var pcButton: UIButton!
    
    let consoles = ["XBone", "PS4", "PC"]
    var chosenConsole = "XBone"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBox.delegate = self
        xboxButton.setImage(#imageLiteral(resourceName: "icons8-xbox-filled-50 (2)"), for: .normal)
        searchBox.layer.cornerRadius = 15
        goldScar.layer.shadowColor = UIColor.purple.cgColor
        goldScar.layer.shadowRadius = 4
        goldScar.layer.shadowOpacity = 0.9
        goldScar.layer.shadowOffset = CGSize.zero
        goldScar.layer.masksToBounds = false
        goldScar.startGlowingWithColor(color: UIColor.blue, intensity: 0.3)
        goldScar.startGlowingWithColor(color: UIColor.red, intensity: 0.3)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //textField code
        
        searchBox.resignFirstResponder()  //if desired
        performAction()
        return true
    }
    
    func performAction() {
        performSegue(withIdentifier: "searchSegue", sender: nil)
    }
    
    @IBAction func blah(_ sender: Any) {
        performSegue(withIdentifier: "ninjaSegue", sender: nil)
        
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
