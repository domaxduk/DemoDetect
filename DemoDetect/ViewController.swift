//
//  ViewController.swift
//  DemoDetect
//
//  Created by Duc apple  on 24/12/24.
//

import UIKit
import Network
import iOSMagnetometer
import SwiftyPing
import SwiftUI

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configView()
    }
    
    private func configView() {
        let swiftUIView = HomeView(detector: .shared)
        let hostingView = UIHostingController(rootView: swiftUIView)
        self.addChild(hostingView)
        hostingView.didMove(toParent: self)
        self.view.addSubview(hostingView.view)
        hostingView.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostingView.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            hostingView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            hostingView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            hostingView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}
