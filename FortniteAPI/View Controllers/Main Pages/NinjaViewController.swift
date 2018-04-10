//
//  NinjaViewController.swift
//  FortniteAPI
//
//  Created by Joey Dafforn on 3/28/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit

class NinjaViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var youtubeWebView: UIWebView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        doTheThing()
        // Do any additional setup after loading the view.
    }

    func doTheThing() {
        youtubeWebView.loadRequest(NSURLRequest(url: NSURL(string: "https://www.youtube.com/results?search_query=fortnite")! as URL) as URLRequest)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.startAnimating()
    }// show indicator

    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    } // hide indicator

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
