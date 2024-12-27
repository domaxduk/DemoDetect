//
//  Permission.swift
//  DemoDetect
//
//  Created by Duc apple  on 27/12/24.
//

import Foundation
import CoreLocation
import AVFoundation

class Permission {
    static var grantedLocation: Bool {
        let locationManager = CLLocationManager()
        let status = locationManager.authorizationStatus
        return status == .authorizedWhenInUse || status == .authorizedAlways
    }
    
    static var grantedCamera: Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }
    
    static func requestCamera() {
        AVCaptureDevice.requestAccess(for: .video) { _ in
            
        }
    }
    
    static func requestLocation() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
}
