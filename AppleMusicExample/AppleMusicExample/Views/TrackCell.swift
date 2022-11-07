//
//  TrackCell.swift
//  AppleMusicExample
//
//  Created by Brandon Gouws on 2022/10/08.
//

import SwiftUI

struct TrackCell: View {
    
    var track: TrackDetails
    
    var body: some View {
        VStack {
            HStack {
                URLImage(url: track.artworkUrl100 ?? "")
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                VStack(alignment: .leading) {
                    Text(track.trackName ?? "")
                        .bold()
                    Text(track.artistName ?? "")
                        .fontWeight(.light)
                }
                Spacer()
            }.padding()
            Spacer()
        }
    }
}

struct TrackCell_Previews: PreviewProvider {

    static var mockTrack = TrackDetails(artistName: "Mikey Ferrari",
                                        trackName: "Truth Is",
                                        artworkUrl100: "http")
    
    static var previews: some View {
        TrackCell(track: mockTrack)
    }
}
