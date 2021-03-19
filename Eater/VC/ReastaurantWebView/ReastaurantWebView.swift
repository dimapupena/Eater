//
//  ReastaurantWebView.swift
//  Eater
//
//  Created by Dmitriy Pupena on 19.03.2021.
//

import Foundation
import WebKit

class ReastaurantWebView: UIViewController, WKNavigationDelegate {
    
    var onFinish: (() -> Void)?

    private lazy var webView: WKWebView = {
      let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        let url = URL(string: "https://www.amsterdamster.com.ua")!
        webView.load(URLRequest(url: url))
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
        setupBackButton()
        setupWebView()
    }

    func setupBackButton() {
        self.view.addSubview(backButton)

        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
    }

    func setupWebView() {
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
