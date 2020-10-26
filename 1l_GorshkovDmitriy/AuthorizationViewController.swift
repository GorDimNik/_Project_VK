//
//  AuthorizationViewController.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 20.10.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit
import WebKit

class AuthorizationViewController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!{
        didSet{
            webview.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7635637"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webview.load(request)
        
    }

}

extension AuthorizationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        
        print("params : ", params)
        print("/n-----------------/n")
        
        let token = params["access_token"]
        let userId = params["user_id"]

        print("Token : ", token!)
        print("userId : ", userId!)
        Session.instance.token = token!
        Session.instance.userId = Int(userId!)!
        print("/n-----------------/n")
        
        
        print("Session.instance.token = ", Session.instance.token)
        print("Session.instance.userId = ", Session.instance.userId)
        
        
        decisionHandler(.cancel)
        performSegue(withIdentifier: "vkGo", sender: nil)
    }
}
