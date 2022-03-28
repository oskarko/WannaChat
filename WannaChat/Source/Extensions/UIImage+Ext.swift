//
//  UIImage+Ext.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

extension UIImage {
    
    var isPortrait: Bool { size.height > size.width }
    var isLandscape: Bool { size.width > size.height }
    var breadth: CGFloat { min(size.width, size.height) }
    var breadthSize: CGSize { CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect { CGRect(origin: .zero, size: breadthSize) }
    
    var circleMasked: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        
        defer { UIGraphicsEndImageContext() }
        
        guard
            let cgImage = cgImage?.cropping(
                to: CGRect(
                    origin: CGPoint(
                        x: isLandscape ? floor((size.width - size.height) / 2) : 0,
                        y: isPortrait ? floor((size.height - size.width) / 2) : 0),
                    size: breadthSize
                )
            )
        else { return nil }
        
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage).draw(in: breadthRect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
