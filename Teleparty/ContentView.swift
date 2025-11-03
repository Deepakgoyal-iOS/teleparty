//
//  ContentView.swift
//  Teleparty
//
//  Created by Deepak Goyal on 02/11/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            SearchVideoView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding()
        
    }
}

#Preview {
    ContentView()
}
