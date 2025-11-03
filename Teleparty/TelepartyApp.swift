//
//  TelepartyApp.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import SwiftUI

@main
struct TelepartyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    ReachabilityMonitor.shared.startMonitoring()
                }
        }
        
    }
}
