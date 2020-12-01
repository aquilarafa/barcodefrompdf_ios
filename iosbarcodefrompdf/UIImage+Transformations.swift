//
//  UIImage+Transformations.swift
//  iosbarcodefrompdf
//
//  Created by Rafael Aquila on 01/12/20.
//

import Foundation


extension UIImage{
    
    func cropHalf() -> UIImage{
        let height = CGFloat(self.size.height / 2)
            let rect = CGRect(x: 0, y: self.size.height - height, width: self.size.width, height: height)
        let imageRef:CGImage = self.cgImage!.cropping(to: rect)!
            let croppedImage:UIImage = UIImage(cgImage:imageRef)
        
        
            return croppedImage
    }
    
    func newFromScale(scale:CGFloat) -> UIImage{
        if let cgImage = self.cgImage{
            return UIImage(cgImage: cgImage, scale: scale, orientation: self.imageOrientation)

        }
        return self
        

    }
    
    
}
