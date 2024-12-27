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
import FlipBook
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    @IBOutlet weak var cameraView: CameraView!
    @IBOutlet weak var mainView: UIView!
    let flipBook = FlipBook()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flipBook.assetType = .video
        flipBook.shouldUseReplayKit = false
        cameraView.configCamera()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.flipBook.stop()
        }
    }
    
    private func configView() {
        let swiftUIView = CameraViewd()
        let hostingView = UIHostingController(rootView: swiftUIView)
        self.addChild(hostingView)
        hostingView.didMove(toParent: self)
        self.mainView.addSubview(hostingView.view)
        hostingView.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostingView.view.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            hostingView.view.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor),
            hostingView.view.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            hostingView.view.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
        ])
        
        flipBook.startRecording(view) { result in
            // Switch on result
            switch result {
            case .success(let asset):
                // Switch on the asset that's returned
                switch asset {
                case .video(let url):
                    // Do something with the video
                    print(url)
                    // We expect a video so do nothing for .livePhoto and .gif
                case .livePhoto, .gif:
                    break
                }
            case .failure(let error):
                // Handle error in recording
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
