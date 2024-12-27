//
//  CameraView.swift
//  DemoDetect
//
//  Created by Duc apple  on 27/12/24.
//

import Foundation
import UIKit
import AVFoundation

class CameraView: UIView {
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var cameraOutput: AVCaptureVideoDataOutput!
    private var context: CIContext!
    private var filter: CIFilter!
    
    func configCamera() {
        // Thiết lập session camera
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        // Thiết lập camera (sử dụng camera sau)
        guard let videoDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        // Thiết lập input
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            return
        }
        
        if captureSession.canAddInput(videoDeviceInput) {
            captureSession.addInput(videoDeviceInput)
        }
        
        // Thiết lập output
        cameraOutput = AVCaptureVideoDataOutput()
        if captureSession.canAddOutput(cameraOutput) {
            captureSession.addOutput(cameraOutput)
        
            // Thiết lập queue cho output
            let queue = DispatchQueue(label: "cameraQueue")
            cameraOutput.setSampleBufferDelegate(self, queue: queue)
        }
        
        // Thiết lập context CoreImage
        context = CIContext()
        
        // Thiết lập filter (ví dụ filter sepia)
        filter = CIFilter(name: "CISepiaTone")
        filter.setValue(0.8, forKey: kCIInputIntensityKey)
        
        // Thiết lập preview layer để hiển thị camera
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = self.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        self.layer.insertSublayer(previewLayer, at: 0)
        
        // Bắt đầu capture session
        DispatchQueue.global().async {
            self.captureSession.startRunning()
        }
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
extension CameraView: AVCaptureVideoDataOutputSampleBufferDelegate {
    
}
