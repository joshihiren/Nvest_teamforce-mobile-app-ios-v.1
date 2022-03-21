//
//  AsyncImageModel.swift
//  TeamForce
//
//  Created by Hiren Joshi on 06/02/21.
//

import Foundation
import Combine
import SwiftUI
import UIKit


class AsyncImageModel: ObservableObject {
    
    let willChange = PassthroughSubject<Void, Never>()
    fileprivate let imageCache = NSCache<NSString, UIImage>()
    
    @Published var isLoadingIMG = false
    @Published var imageIC: UIImageView = UIImageView.init() {
        willSet {
            willChange.send()
        }
    }
    
    private func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async() { () -> Void in
                let imageInset: CGFloat = self.imageIC.frame.size.height / 10
                self.imageIC.image = cachedImage.resizableImage(withCapInsets: UIEdgeInsets(top: imageInset, left: imageInset, bottom: imageInset, right: imageInset), resizingMode: .stretch)
                self.isLoadingIMG = true
            }
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else { return }
                DispatchQueue.main.async() { () -> Void in
                    self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    let imageInset: CGFloat = self.imageIC.frame.size.height / 10
                    self.imageIC.image = image.resizableImage(withCapInsets: UIEdgeInsets(top: imageInset, left: imageInset, bottom: imageInset, right: imageInset), resizingMode: .stretch)
                    self.isLoadingIMG = true
                }
            }.resume()
        }
    }
    
    func downloadedFrom(link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit, radious: CGFloat? = 0) {
        if link == nil || link?.count == 0 {
            return
        }
        guard let url = URL(string: link!) else { return }
        self.imageIC.clipsToBounds = true
        self.imageIC.layer.cornerRadius = radious!
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async() { () -> Void in
                let imageInset: CGFloat = self.imageIC.frame.size.height / 10
                self.imageIC.image = cachedImage.resizableImage(withCapInsets: UIEdgeInsets(top: imageInset, left: imageInset, bottom: imageInset, right: imageInset), resizingMode: .stretch)
                self.isLoadingIMG = true
            }
        } else {
            downloadedFrom(url: url, contentMode: mode)
        }
    }
    
}
