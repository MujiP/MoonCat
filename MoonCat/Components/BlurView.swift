//
//  BlurView.swift
//
//  Created by Muji Paracha on 2019-11-17.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import UIKit

class BlurView: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        self.addSubview(blur)
        blur.pinTo(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
