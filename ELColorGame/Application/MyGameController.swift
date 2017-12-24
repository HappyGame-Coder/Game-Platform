//
//  MyGameController.swift
//  ELColorGame
//
//  Created by tonny on 2017/12/23.
//  Copyright © 2017年 EL Passion. All rights reserved.
//

import UIKit

class MyGameController: UIViewController,UIWebViewDelegate {
    var gameId :String?
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let request:NSURLRequest;
        
        if (self.gameId?.hasPrefix("http"))! {
            request = NSURLRequest.init(url: NSURL.init(string: self.gameId!)! as URL)
        }else{
            request = NSURLRequest.init(url: NSURL.init(string: "http://\(self.gameId!)")! as URL)
        }
        self.webView.loadRequest(request as URLRequest)
        // Do any additional setup after loading the view.
    }

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
