//
//  ImageLoader.swift
//  ReelProject
//
//  Created by Ganesh Joshi on 03/08/24.
//

import UIKit

//class ImageLoader {
//    static let shared = ImageLoader()
//
//    private let imageCache = NSCache<NSString, UIImage>()
//
//    private init() {}
//
//    func loadImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
//        // Check if the image is already cached
//        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
//            completion(.success(cachedImage))
//            return
//        }
//
//        // Convert the URL string to a URL object
//        guard let url = URL(string: urlString) else {
//            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
//            return
//        }
//
//        // Fetch the image from the network
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(NSError(domain: "Invalid image data", code: 0, userInfo: nil)))
//                return
//            }
//
//            DispatchQueue.global(qos: .utility).async {
//                if let image = UIImage(data: data) {
//                    self?.imageCache.setObject(image, forKey: urlString as NSString)
//                    completion(.success(image))
//                } else {
//                    completion(.failure(NSError(domain: "Invalid image data", code: 0, userInfo: nil)))
//                }
//            }
//        }
//
//        task.resume()
//    }
//}

//Trial1

class ImageLoader {
    static let shared = ImageLoader()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func loadImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        // Check if the image is already cached
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(.success(cachedImage))
            return
        }
        
        // Convert the URL string to a URL object
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        // Fetch the image from the network
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid image data", code: 0, userInfo: nil)))
                return
            }
            
            // Perform image decoding on a background thread
            DispatchQueue.global(qos: .userInitiated).async {
                if let image = UIImage(data: data) {
                    self?.imageCache.setObject(image, forKey: urlString as NSString)
                    completion(.success(image))
                } else {
                    completion(.failure(NSError(domain: "Invalid image data", code: 0, userInfo: nil)))
                }
            }
        }
        
        task.resume()
    }
}



