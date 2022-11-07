//
//  RemoteImageView.swift
//  AppleMusicExample
//
//  Created by Brandon Gouws on 2022/10/09.
//

import Foundation

class ImageLoader: ObservableObject {
    
    @Published var downloadedData: Data?
    
    func downloadImage(url: String) {
        
        guard let imageURL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.downloadedData = data
            }
        }.resume()
    }
}
