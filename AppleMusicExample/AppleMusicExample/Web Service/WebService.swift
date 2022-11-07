//
//  WebService.swift
//  AppleMusicExample
//
//  Created by Brandon Gouws on 2022/10/08.
//

import Foundation
import UIKit
import Combine

protocol WebServiceType {
    func searchFor(track: String ) -> AnyPublisher<TrackModel, Error>
}

final class WebService: WebServiceType {
    
    func searchFor(track: String) -> AnyPublisher<TrackModel, Error> {
        guard let url = URL(string: "https://itunes.apple.com/search/song&term=led+zeplin") else { fatalError("Could not create url") }
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: TrackModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func downloadImage(url: String) -> AnyPublisher<UIImage?, URLError> {
        guard let url = URL(string: url) else { fatalError("Could not create url") }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

struct TrackModel: Codable {
    
    var resultCount: Int?
    var results: [TrackDetails]?
}

struct TrackDetails: Codable, Identifiable {
    
    var id = UUID()
    var artistName: String?
    var trackName: String?
    var artworkUrl100: String?
}
