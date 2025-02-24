//
//  UIImage.swift
//  SearchFlix
//
//  Created by Mine Rala on 24.02.2025.
//

import UIKit

extension UIImage {
    static func fromData(_ imageData: Data?) -> UIImage {
        guard let data = imageData, let image = UIImage(data: data) else {
            return UIImage(named: "na") ?? UIImage()
        }
        return image
    }
}
