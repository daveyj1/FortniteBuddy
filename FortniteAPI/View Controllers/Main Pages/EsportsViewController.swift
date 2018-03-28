//
//  EsportsViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 3/27/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit
import GradientView
import Pastel

class EsportsViewController: UIViewController {
    
    @IBOutlet weak var opticView: UIView!
    @IBOutlet weak var opticBackgroundView: UIView!
    
    @IBOutlet weak var fazeView: UIView!
    @IBOutlet weak var fazeBackgroundView: UIView!
    
    @IBOutlet weak var tsmView: UIView!
    @IBOutlet weak var tsmBackgroundView: UIView!
    
    
    @IBOutlet weak var opfaView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        opticView.backgroundColor = UIColor.clear
        fazeView.backgroundColor = UIColor.clear
        tsmView.backgroundColor = UIColor.clear
        
        let pastelView1 = PastelView(frame: opticView.bounds)
        // Custom Direction
        pastelView1.startPastelPoint = .bottomLeft
        pastelView1.endPastelPoint = .topRight
        // Custom Duration
        pastelView1.animationDuration = 3.0
        // Custom Color
        pastelView1.setColors([UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0),
                              UIColor(red: 158/255, green: 198/255, blue: 73/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)])
        pastelView1.startAnimation()
        opticBackgroundView.insertSubview(pastelView1, at: 0)
        
        let pastelView2 = PastelView(frame: opticView.bounds)
        // Custom Direction
        pastelView2.startPastelPoint = .bottomLeft
        pastelView2.endPastelPoint = .topRight
        // Custom Duration
        pastelView2.animationDuration = 3.0
        // Custom Color
        pastelView2.setColors([UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0),
                               UIColor(red: 215/255, green: 55/255, blue: 50/255, alpha: 1.0),
                               UIColor(red: 255/255, green: 255/255, blue:255/255, alpha: 1.0)])
        pastelView2.startAnimation()
        fazeBackgroundView.insertSubview(pastelView2, at: 0)
        
        let pastelView3 = PastelView(frame: tsmView.bounds)
        // Custom Direction
        pastelView3.startPastelPoint = .bottomLeft
        pastelView3.endPastelPoint = .topRight
        // Custom Duration
        pastelView3.animationDuration = 3.0
        // Custom Color
        pastelView3.setColors([UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0),
                               UIColor(red: 35/255, green: 72/255, blue: 211/255, alpha: 1.0),
                               UIColor(red: 255/255, green: 255/255, blue:255/255, alpha: 1.0)])
        pastelView3.startAnimation()
        tsmBackgroundView.insertSubview(pastelView3, at: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination as! EsportPlayerViewController
        if segue.identifier == "opticSegue" {
            detailViewController.teamName = "Optic Gaming"
        } else if segue.identifier == "fazeSegue" {
            detailViewController.teamName = "Faze Clan"
        } else if segue.identifier == "liquidSegue" {
            detailViewController.teamName = "Team Liquid"
        } else if segue.identifier == "tsmSegue" {
            detailViewController.teamName = "Team Solo Mid"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
