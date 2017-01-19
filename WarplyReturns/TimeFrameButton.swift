//
//  TimeFrameButton.swift
//  WarplyReturns
//
//  Created by Marsel Tzatzo on 19/01/2017.
//  Copyright © 2017 Marsel Tzatzo. All rights reserved.
//

import UIKit

class TimeFrameButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setTitleColor(tintColor, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2)
    }
    
    override var isSelected: Bool {
        willSet(newValue) {
            if newValue {
                highlightButton()
            }else {
                unhighlightButton()
            }
        }
    }
    
    func highlightButton() {
        self.adjustsImageWhenHighlighted = false
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = tintColor.cgColor
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
    }
    
    func unhighlightButton() {
        self.layer.borderWidth = 0.0
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    

}
