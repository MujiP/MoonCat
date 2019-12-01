//
//  Header.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-28.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit

class Header: UITableViewHeaderFooterView {
    
    var label: UILabel!

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
//        self.contentView.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
        
        let label = UILabel()
        label.font = UIFont(name: "ProximaNova-Regular", size: 20)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.2783971429, green: 0.2784510255, blue: 0.2783937454, alpha: 1)
        self.label = label
        self.contentView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
