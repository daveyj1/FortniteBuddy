//
//  SearchViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 2/26/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var searchBox: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let consoles = ["XBone", "PS4", "PC"]
    var chosenConsole = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return consoles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return consoles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenConsole = consoles[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
