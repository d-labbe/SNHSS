//
//  webPageController.swift
//  SNHSS
//
//  Created by dlabbe on 9/1/17.
//  Copyright © 2017 Southern NH Snow Slickers. All rights reserved.
//

import UIKit

class webPageController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webPageTItles: UINavigationItem!
  
    @IBOutlet weak var webPageTitle: UINavigationBar!
    @IBOutlet weak var webView: UIWebView!

    var loadingIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webPageTItles.title = urlString[urlSel!]
        webView.delegate = self
        customLoadingIndicator(self.view, startAnimate: true)
        webView.allowsInlineMediaPlayback = true
        
        let urlAdd = URL(string: urlS[urlSel!])
        let urlRequest = URLRequest(url: urlAdd!)

        webView.scrollView.zoomScale = 1
        webView.scalesPageToFit = true
        webView.loadRequest(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func customLoadingIndicator(_ viewContainer: UIView, startAnimate:Bool? = true) {
        
        let mainContainer: UIView = UIView(frame: viewContainer.frame)
        mainContainer.center = viewContainer.center
        mainContainer.backgroundColor = UIColor.lightGray
        mainContainer.alpha = 0.5
        mainContainer.tag = 8675309
        mainContainer.isUserInteractionEnabled = false
        
        let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
        viewBackgroundLoading.center = viewContainer.center
        viewBackgroundLoading.backgroundColor = UIColor.white
        viewBackgroundLoading.alpha = 0.5
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 15
        
        let loadingImage: UIImageView = UIImageView()
        loadingImage.frame = CGRect(x:0.0,y: 0.0,width: 60.0, height: 60.0)
        loadingImage.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
        loadingImage.animationDuration = 0.75
        loadingImage.animationImages = [UIImage(named: "loading1")!,UIImage(named: "loading2")!,UIImage(named: "loading3")!,UIImage(named: "loading4")!,UIImage(named: "loading5")!,UIImage(named: "loading6")!,UIImage(named: "loading7")!,UIImage(named: "loading8")!]
        
        if startAnimate!{
            viewBackgroundLoading.addSubview(loadingImage)
            mainContainer.addSubview(viewBackgroundLoading)
            viewContainer.addSubview(mainContainer)
            loadingImage.startAnimating()
            
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        loadingIndicator.stopAnimating()
        loadingIndicator.isHidden = true
        webView.isUserInteractionEnabled = true
        UIApplication.shared.endIgnoringInteractionEvents()
        
        
        for v in view.subviews{
            if v.tag == 8675309{
                v.removeFromSuperview()
            }
            
        }
        
    }

}
