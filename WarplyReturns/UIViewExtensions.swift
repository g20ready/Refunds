//
//  UIViewExtensions.swift
//  WarplyReturns
//
//  Created by Marsel Tzatzo on 19/01/2017.
//  Copyright © 2017 Marsel Tzatzo. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult   // 1
    func fromNib<T : UIView>() -> T? {   // 2
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as? T else {    // 3
            // xib not loaded, or it's top view is of the wrong type
            return nil
        }
        self.addSubview(view)     // 4
        view.translatesAutoresizingMaskIntoConstraints = false   // 5
//        view.layoutAttachAll(to: self)   // 6
        return view   // 7
    }
    
    /**
     Rotate a view by specified degrees
     - parameter angle: angle in degrees
     */
    func rotate(_ angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat(M_PI)
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
    
}
