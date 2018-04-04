//
//  NewsViewController.swift
//  FortniteAPI
//
//  Created by Joey Dafforn on 3/23/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    var refController:UIRefreshControl = UIRefreshControl()
    @IBOutlet weak var newsWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebpage()
        refController.bounds = CGRectMake(0, 50, refController.bounds.size.width, refController.bounds.size.height)
        refController.addTarget(self, action: #selector(NewsViewController.mymethodforref(refresh:)), for: UIControlEvents.valueChanged)
        refController.attributedTitle = NSAttributedString(string: "Pull to refresh")
        newsWebView.scrollView.addSubview(refController)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    @objc func mymethodforref(refresh:UIRefreshControl){
        loadWebpage()
        refController.endRefreshing()
    }
    
    func loadWebpage() {
        let url = URL(string: "https://www.epicgames.com/fortnite/en-US/news")
        if let unwrappedURL = url {
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    DispatchQueue.main.async {
                        self.newsWebView.loadRequest(request)
                    }
                }
                else {
                    print("Error: \(error?.localizedDescription)")
                }
            }
            task.resume()
        }
    }
    
//    func webViewDidFinishLoad(webView: UIWebView) {
//        UIApplication.sharedApplication.networkActivityIndicatorVisible = false
//    }
//
//    func webViewDidStartLoad(webView: UIWebView) {
//        UIApplication.sharedApplication.networkActivityIndicatorVisible = true
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
