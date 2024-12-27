//
//  HomeView.swift
//  DemoDetect
//
//  Created by Duc apple  on 27/12/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var detector: LocalNetworkDetector
    var body: some View {
        ScrollView {
            VStack {
                ForEach(detector.devices, id: \.id) { device in
                    DeviceItemView(device: device)
                }
            }
            .padding()
            .onAppear(perform: {
                detector.start()
            })
        }
    }
    
    func text(_ content: String) -> some View {
        HStack {
            Text(content)
                .multilineTextAlignment(.leading)
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            Spacer()
        }
    }
    
}

struct DeviceItemView: View {
    @ObservedObject var device: Device
    
    var body: some View {
        VStack {
            text("ip: " + (device.ipAddress))
            text("name: " + device.name())
            text("hostname: " + (device.hostName ?? ""))
            text("SERVICES: ")
            
            ForEach(device.services, id: \.type) { service in
                text(service.full)
            }
            
            Color.black.frame(height: 1)
           
        }
    }
    
    func text(_ content: String) -> some View {
        HStack {
            Text(content)
                .font(.system(size: 10))
                .multilineTextAlignment(.leading)
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            Spacer()
        }
    }
}

#Preview {
    HomeView(detector: .shared)
}
