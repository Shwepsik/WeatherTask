//
//  PopupView.swift
//  WeatherTask
//
//  Created by Valerii on 11/9/19.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation
import UIKit

class PopupView: UIView {
    
    let mainWindow = UIApplication.shared.windows[0]
    private var maximumOverlayAlpha: CGFloat = 0.7
    private let animationDuration: TimeInterval = 0.3
    
    private var overlay: UIView = {
        $0.backgroundColor = .black
        $0.alpha = 0.0
        return $0
    }(UIView())
    
    static func create<T: UIView>() -> T {
        let view: T = T.fromNib()
        return view
    }
    
    func addGesture() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(hidePopup))
        swipeDown.direction = .down
        self.addGestureRecognizer(swipeDown)
    }
    
    func show() {
        overlay.frame = mainWindow.bounds
        mainWindow.addSubview(overlay)
        center.x = mainWindow.bounds.width / 2
        frame.origin.y = mainWindow.bounds.height
        mainWindow.addSubview(self)
        mainWindow.bringSubviewToFront(self)
        UIView.animate(withDuration: animationDuration) {
            self.overlay.alpha = self.maximumOverlayAlpha
            self.center = self.mainWindow.center
        }
    }
    
    @objc func hidePopup() {
        UIView.animate(withDuration: animationDuration, animations: {
            if let superview = self.superview {
                self.frame.origin.y = superview.frame.height
                self.overlay.alpha = 0.0
            }
        }, completion: { _ in
            self.overlay.removeFromSuperview()
            self.removeFromSuperview()
        })
    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
