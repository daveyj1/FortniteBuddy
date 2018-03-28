//
//  EsportsViewController.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 3/27/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit
import GradientView

class EsportsViewController: UIViewController {
    
    @IBOutlet weak var opticView: UIView!
    @IBOutlet weak var opticBackgroundView: UIView!
    
    @IBOutlet weak var fazeView: UIView!
    @IBOutlet weak var fazeBackgroundView: UIView!
    
    @IBOutlet weak var tsmView: UIView!
    @IBOutlet weak var tsmBackgroundView: UIView!
    
    @IBOutlet weak var liquidView: UIView!
    @IBOutlet weak var liquidBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Optic View
        let gradientView1 = GradientView(frame: opticView.bounds)
        gradientView1.colors = [UIColor.green, UIColor.black]
        opticBackgroundView.addSubview(gradientView1)
        opticView.backgroundColor = UIColor.clear
        //----------
        
        //Faze View
        let gradientView2 = GradientView(frame: opticView.bounds)
        gradientView2.colors = [UIColor.red, UIColor.blue]
        fazeBackgroundView.addSubview(gradientView2)
        fazeView.backgroundColor = UIColor.clear
        //----------
        
        //TSM View
        let gradientView3 = GradientView(frame: opticView.bounds)
        gradientView3.colors = [UIColor.white, UIColor.darkGray]
        tsmBackgroundView.addSubview(gradientView3)
        tsmView.backgroundColor = UIColor.clear
        //----------
        
        //Liquid View
        let gradientView4 = GradientView(frame: opticView.bounds)
        gradientView4.colors = [UIColor.white, UIColor.cyan]
        liquidBackgroundView.addSubview(gradientView4)
        liquidView.backgroundColor = UIColor.clear
        //----------
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
