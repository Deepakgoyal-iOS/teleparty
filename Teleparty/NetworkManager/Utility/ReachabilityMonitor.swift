//
//  ReachabilityMonitor.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import Foundation
import Network

final class ReachabilityMonitor {
    
    /// Possible Connection Types
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    static let shared = ReachabilityMonitor()

    private let queue = DispatchQueue.global()

    private let monitor: NWPathMonitor
    
    /// Connection status bool
    public private(set) var isConnected: Bool = true
    
    /// Connection type indicator
    public private(set) var connectionType: ConnectionType = .unknown
    

    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        
        if path.usesInterfaceType(.wifi) {
            self.connectionType = .wifi
            
        } else if path.usesInterfaceType(.cellular) {
            self.connectionType = .cellular
            
        } else if path.usesInterfaceType(.wiredEthernet) {
            self.connectionType = .ethernet
            
        } else {
            self.connectionType = .unknown
            
        }
    }
}
