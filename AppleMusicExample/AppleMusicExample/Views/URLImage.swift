//
//  URLImage.swift
//  AppleMusicExample
//
//  Created by Brandon Gouws on 2022/10/09.
//

import SwiftUI

struct URLImage: View {
    
    let url: String
    @ObservedObject var imageLoader = ImageLoader()
    
    init(url: String) {
        self.url = url
        imageLoader.downloadImage(url: self.url)
    }
    
    var body: some View {
        if let data = imageLoader.downloadedData {
            Image(uiImage: UIImage(data: data) ?? UIImage()).resizable()
                .cornerRadius(8)
        } else {
            Image("placeholder")
                .resizable()
                .cornerRadius(8)
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        
        URLImage(url: "")
    }
}
