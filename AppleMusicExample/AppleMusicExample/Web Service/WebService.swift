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
    func downloadImage(url: String) -> AnyPublisher<UIImage?, URLError>
}

final class WebService: WebServiceType {
    
    func searchFor(track: String) -> AnyPublisher<TrackModel, Error> {
        #if DEBUG
        if let isStubbed = Bundle.main.object(forInfoDictionaryKey: "iSStubbed") as? Bool,
           isStubbed {
            return Bundle.main.decodeable(fileName: "SearchTrack.json")
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } else {
            guard let url = URL(string: "https://itunes.apple.com/search/song&term=led+zeplin") else { fatalError("Could not create url") }
            return URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: RunLoop.main)
                .map(\.data)
                .decode(type: TrackModel.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
        #else
        guard let url = URL(string: "https://itunes.apple.com/search/song&term=led+zeplin") else { fatalError("Could not create url") }
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .decode(type: TrackModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        #endif
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
    
    let id = UUID()
    var artistName: String?
    var trackName: String?
    var artworkUrl100: String?
}

extension Bundle {
    
    func readFile(file: String) -> AnyPublisher<Data, Error> {
        self.url(forResource: file, withExtension: nil)
            .publisher
            .tryMap{ string in
                guard let data = try? Data(contentsOf: string) else {
                    fatalError("Failed to load \(file) from bundle.")
                }
                return data
            }
            .mapError { error in
                return error
            }.eraseToAnyPublisher()
    }
    
    func decodeable(fileName: String) -> AnyPublisher<TrackModel, Error> {
        readFile(file: fileName)
            .decode(type: TrackModel.self, decoder: JSONDecoder())
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
