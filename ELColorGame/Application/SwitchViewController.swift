//
//  SwitchViewController.swift
//  Caculate
//
//  Created by tonny on 2017/11/27.
//  Copyright © 2017年 tonny. All rights reserved.
//

import UIKit

let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height


class SwitchViewController: UIViewController ,UIWebViewDelegate,UIScrollViewDelegate{

    var webUrl: String?
    lazy var webView:UIWebView = {
        ()->UIWebView in
        let tempWebView = UIWebView()
        tempWebView.delegate=self;
        tempWebView.scrollView.delegate=self
        return tempWebView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: width, height: height))
        if height == 480 {
            self.webView.frame = CGRect.init(x: 0, y: 20, width: width, height: height)
        }
        let request:NSURLRequest;
        
        if (self.webUrl?.hasSuffix("http"))! {
           request = NSURLRequest.init(url: NSURL.init(string: self.webUrl!)! as URL)
        }else{
           request = NSURLRequest.init(url: NSURL.init(string: "http://\(self.webUrl!)")! as URL)
        }
        self.webView.loadRequest(request as URLRequest)
        self.view.addSubview(self.webView)
        
        // Do any additional setup after loading the view.
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

