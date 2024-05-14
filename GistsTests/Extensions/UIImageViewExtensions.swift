//
//  UIImageViewExtensions.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 13/05/24.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func cacheImage(url: URL, defaultImage: UIImage?) {
        image = defaultImage
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.setImage(fade: true, image: imageFromCache)
            return
        }
        
        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    guard let imageToCache =  UIImage(data: response) else { return }
                    imageCache.setObject(imageToCache, forKey: url.absoluteString as AnyObject)
                    self.setImage(fade: true, image: imageToCache)
                }
            }
        }.resume()
    }
    
    private func setImage(fade: Bool, image: UIImage?) {
        if fade {
            self.alpha = 0
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.image = image
                self?.alpha = 1
            }
        } else {
            self.image = image
        }
    }
}
