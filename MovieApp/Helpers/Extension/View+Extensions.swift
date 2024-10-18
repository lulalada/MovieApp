//
//  View+Extensions.swift
//  MovieApp
//
//  Created by Alua Sayabayeva on 18/10/2024.
//

import UIKit

// MARK: - apply shadows
extension UIView {
    func applyShadow() {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowRadius = 15
        clipsToBounds = false
    }
    
    func applyCustomShadow(width: Int, height: Int, radius: Int) {
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = CGFloat(radius)
        clipsToBounds = false
    }
}
