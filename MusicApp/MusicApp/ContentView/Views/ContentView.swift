//
//  ContentView.swift
//  MusicApp
//
//  Created by Admin on 20/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var contentViewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        TabView(selection: $contentViewModel.selectedTab) {
            Tab(value: 0){
                HomeView()
            } label: {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            Tab(value: 1){
                Text("Explore Page")
            } label: {
                Image(systemName: "safari")
                Text("Explore")
            }
            
            Tab(value: 2){
                Text("Library Page")
            } label: {
                Image(systemName: "square.on.square")
                Text("Library")
            }
            
            Tab(value: 3){
                Text("Settings Page")
            } label: {
                Image(systemName: "gearshape")
                Text("Settings")
            }
        }
        .tint(.purple)
    }
}

#Preview {
    ContentView()
}


