//
//  DevExtensions.swift
//
//  Created by Muji Paracha on 2019-07-28.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setReferenceImage(name: String) {
        /*
         Pass the name of a reference image.
         Then you can tap to toggle its visibility for comparison.
         */
        
        let imv = UIImageView(image: UIImage(named: name))
        imv.center = self.view.midPoint
        self.view.addSubview(imv)
        imv.tag = 99
        imv.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleReferenceImage))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func toggleReferenceImage() {
        let v = self.view.viewWithTag(99)!
        v.isHidden = !v.isHidden
        print("Reference Image: \(v.isHidden ? "OFF" : "ON")")
    }
    
}
