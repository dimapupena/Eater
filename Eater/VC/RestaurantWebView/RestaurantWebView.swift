//
//  RestaurantWebView.swift
//  Eater
//
//  Created by Dmitriy Pupena on 19.03.2021.
//

import Foundation
import WebKit

class RestaurantWebView: UIViewController, WKNavigationDelegate {
    
    var onFinish: (() -> Void)?

    private lazy var webView: WKWebView = {
      let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()

    let backButton: BackButton = {
        var backImage = BackButton()
        backImage.addTarget(self, action: #selector(backButtonClick), for: .touchUpInside)
        backImage.translatesAutoresizingMaskIntoConstraints = false
        return backImage
    }()

    override func viewDidLoad() {
        self.view.backgroundColor = .white

        webView.navigationDelegate = self
    }
    
    func setupView(_ link: String) {
        self.showLoaderView()
        updateWebLink(link)
        
        setupBackButton()
        setupWebView()
    }
    
    func updateWebLink(_ link: String) {
        guard let url = URL(string: link) else { print("sorry, but we can't find this webSite") ;return}
        webView.load(URLRequest(url: url))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideLoaderView()
    }
    
    private func setupBackButton() {
        self.view.addSubview(backButton)

        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
    }

    private func setupWebView() {
        self.view.addSubview(webView)

        webView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    @objc func backButtonClick() {
        self.onFinish?()
    }
}
