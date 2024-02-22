//
//  AuthViewController.swift
//  Spotify
//
//  Created by rauan on 2/22/24.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        handleWebURL()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        
    }
    
    private func handleWebURL() {
        guard let url = AuthManager.shared.signInURL else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func setupViews() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.title = "Sign In"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
        
    }
}
extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        let component = URLComponents(string: url.absoluteString)
        
        guard let code = component?.queryItems?.first(where: { $0.name == "code" })?.value else { return }
        print("code: \(code)")
    }
}
