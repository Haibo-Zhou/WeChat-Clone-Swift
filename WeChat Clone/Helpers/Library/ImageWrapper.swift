//
//  ImageWrapper.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/14.
//

import UIKit

struct ImageWrapper: Codable, Hashable {
    let image: UIImage
    
    enum CodingKeys: String, CodingKey {
        case imageX
    }
    
    init(image: UIImage) {
        self.image = image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: CodingKeys.imageX)
        guard let image = UIImage(data: data) else {
            throw StorageError.decodingFailed
        }
        self.image = image
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        guard let data = image.cache_toData() else {
            throw StorageError.encodingFailed
        }
        
        try container.encode(data, forKey: CodingKeys.imageX)
    }
}
