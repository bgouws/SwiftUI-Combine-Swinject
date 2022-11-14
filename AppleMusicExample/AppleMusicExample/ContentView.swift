//
//  ContentView.swift
//  AppleMusicExample
//
//  Created by Brandon Gouws on 2022/10/08.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel = SearchMusicViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.tracks, id: \.id) { track in
                    TrackCell(track: track)
                }
            }.onAppear {
                viewModel.fetchSearch(track: "led+zeplin")
            }
            .padding(.top, 1)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
