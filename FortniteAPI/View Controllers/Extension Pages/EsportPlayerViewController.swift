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
    @IBOutlet weak var firstLabel: UIButton!
    @IBOutlet weak var secondLabel: UIButton!
    @IBOutlet weak var thirdLabel: UIButton!
    @IBOutlet weak var fourthLabel: UIButton!
    @IBOutlet weak var imageLabel: UIImageView!
    
    var tsmPlayers = ["Hamlinz", "TSM_Myth", "TSM_CaMiLLS", "Daequan"]
    var opticPlayers = ["H3CZ", "CouRageJD", "BigTymer8", "OpticScumpii"]
    var fazePlayers = ["Faze SpaceLyon", "Faze Jaomock", "Faze Cloak", "ItsCizzorz"]
    var teamName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamLabel.text = teamName
        if teamLabel.text == "Optic Gaming" {
            firstLabel.setTitle(opticPlayers[0], for: UIControlState.normal)
            secondLabel.setTitle(opticPlayers[1], for: UIControlState.normal)
            thirdLabel.setTitle(opticPlayers[2], for: UIControlState.normal)
            fourthLabel.setTitle(opticPlayers[3], for: UIControlState.normal)
            imageLabel.image = #imageLiteral(resourceName: "optic logo")
        } else if teamLabel.text == "Faze Clan" {
            firstLabel.setTitle(fazePlayers[0], for: UIControlState.normal)
            secondLabel.setTitle(fazePlayers[1], for: UIControlState.normal)
            thirdLabel.setTitle(fazePlayers[2], for: UIControlState.normal)
            fourthLabel.setTitle(fazePlayers[3], for: UIControlState.normal)
            imageLabel.image = #imageLiteral(resourceName: "Fazelogo")
        } else {
            firstLabel.setTitle(tsmPlayers[0], for: UIControlState.normal)
            secondLabel.setTitle(tsmPlayers[1], for: UIControlState.normal)
            thirdLabel.setTitle(tsmPlayers[2], for: UIControlState.normal)
            fourthLabel.setTitle(tsmPlayers[3], for: UIControlState.normal)
            imageLabel.image = #imageLiteral(resourceName: "TSMlogo")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ViewController
        if segue.identifier == "firstPlayerSegue" {
            if teamLabel.text == "Optic Gaming" {
                dvc.username = opticPlayers[0]
                dvc.console = "pc"
            } else if teamLabel.text == "Faze Clan" {
                dvc.username = fazePlayers[0]
                dvc.console = "pc"
            } else {
                dvc.username = tsmPlayers[0]
                dvc.console = "pc"
            }
        } else if segue.identifier == "secondPlayerSegue" {
            if teamLabel.text == "Optic Gaming" {
                dvc.username = opticPlayers[1]
                dvc.console = "pc"
            } else if teamLabel.text == "Faze Clan" {
                dvc.username = fazePlayers[1]
                dvc.console = "pc"
            } else {
                dvc.username = tsmPlayers[1]
                dvc.console = "pc"
            }
        } else if segue.identifier == "thirdPlayerSegue" {
            if teamLabel.text == "Optic Gaming" {
                dvc.username = opticPlayers[2]
                dvc.console = "pc"
            } else if teamLabel.text == "Faze Clan" {
                dvc.username = fazePlayers[2]
                dvc.console = "pc"
            } else {
                dvc.username = tsmPlayers[2]
                dvc.console = "pc"
            }
        } else if segue.identifier == "fourthPlayerSegue" {
            if teamLabel.text == "Optic Gaming" {
                dvc.username = opticPlayers[3]
                dvc.console = "pc"
            } else if teamLabel.text == "Faze Clan" {
                dvc.username = fazePlayers[3]
                dvc.console = "pc"
            } else {
                dvc.username = tsmPlayers[3]
                dvc.console = "pc"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
