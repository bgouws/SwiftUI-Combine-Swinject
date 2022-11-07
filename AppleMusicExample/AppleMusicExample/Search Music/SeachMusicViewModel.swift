//
//  SeachMusicViewModel.swift
//  AppleMusicExample
//
//  Created by Brandon Gouws on 2022/10/08.
//

import Foundation
import Combine
import UIKit

class SearchMusicViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    private var imageCancellable: AnyCancellable?
    let repository = WebService()
    @Published var tracks = [TrackDetails]()
    @Published var image = UIImage()
    
    func fetchSearch(track: String) {
        cancellable = repository.searchFor(track: "Drake")
            .sink(receiveCompletion: { _ in }, receiveValue: { value in
                self.tracks = value.results!
            })
    }
    
    func fetchAlbumArt(url: String) {
        imageCancellable = repository.downloadImage(url: url)
            .sink(receiveCompletion: { _ in }, receiveValue: { value in
                self.image = value ?? UIImage()
            })
    }
}

extension SearchMusicViewModel {
    
    func track(at index: Int) -> TrackDetails? {
        return tracks[index]
    }
    
    var trackCount: Int {
        return tracks.count
    }
}
