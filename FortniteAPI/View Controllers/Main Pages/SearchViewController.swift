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

class SearchViewController: UIViewController {
    
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
        let gview = UIView(frame: CGRect(x: 0, y: 65, width: 400, height: 400))
    
        let pastelView1 = PastelView(frame: view.bounds)
        // Custom Direction
        pastelView1.startPastelPoint = .topLeft
        pastelView1.endPastelPoint = .topRight
        // Custom Duration
        pastelView1.animationDuration = 3.0
        // Custom Color
        pastelView1.setColors([UIColor(red: 113/255, green: 41/255, blue: 159/255, alpha: 1.0),
                               UIColor(red: 16/255, green: 33/255, blue: 123/255, alpha: 1.0),
                               UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1.0)])
        pastelView1.startAnimation()
        // add the gradient layer to the views layer for rendering
        gview.insertSubview(pastelView1, at: 0)
        gview.mask = titleLabel
        view.addSubview(gview)
        gview.isUserInteractionEnabled = false
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
    
    @IBAction func arViewThing(_ sender: Any) {
        performSegue(withIdentifier: "arSegue", sender: nil)
    }
    @IBAction func blah(_ sender: Any) {
        performSegue(withIdentifier: "ninjaSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ninjaSegue")
        {
            //performSegue(withIdentifier: "ninjaSegue", sender: nil)
        }
        else {
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
