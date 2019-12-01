//
//  Tag.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-28.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit

class Tag: UIImageView {
    
    init(string: String) {
        super.init(image: UIImage(named: "tag"))
        
        let l = UILabel()
        l.font = UIFont(name: "ProximaNova-Regular", size: 14)
        l.textColor = #colorLiteral(red: 0.4195591211, green: 0.4196358919, blue: 0.4195542336, alpha: 1)
        l.text = string
        l.addKerning(0.2)
        l.textAlignment = .center
        l.sizeToFit()
        
//        l.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        
        // Set the tag's width to the label's width plus some padding

        self.bounds.size.width = l.bounds.width + 20
        self.addSubview(l)
        l.center = self.midPoint
//        l.center.y += 1
        l.frame = l.frame.integral
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
