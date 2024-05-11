//
//  ImageViewModel.swift
//  ImageLoaderCache
//
//  Created by Sachin Kanojia on 11/05/24.
//

import Foundation

class ImageViewModel {
    var model: ImageModel?
    
    init(model: ImageModel? = nil) {
        self.model = model
    }
    
    func getImageUrls() async throws -> ImageModel? {
        let data = try await ApiManager.shared.fetchImages()
        do {
            model = try JSONDecoder().decode(ImageModel.self, from: data)
        } catch let err {
            print(err)
        }
        return model ?? nil
    }
} 
