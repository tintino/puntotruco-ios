//
//  PTMatchstickGrid.swift
//  PuntoTruco
//
//  Created by Martin Gonzalez vega on 15/07/2018.
//  Copyright © 2018 T1incho. All rights reserved.
//

import UIKit
import Cartography

class PTMatchstickGrid: UIView {
    
    // MARK - private vars
    
    private static let tagBase = 100
    private var matches = [UIView]()
    private var maxPoints = 30
    public var points = 0
    
    // MARK - public vars
    
    public var onMaxPointsReached: (() -> Void)?
    
    // MARK - UIView methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }    
    
    override func updateConstraints() {
        
        
        for i in 0 ..< self.matches.count {
            
            if i <= 4 {
                //Just the first is relative to superview
                constrain(self.matches[i]) { matchView in
                    //Square images using height
                    let heightFactor: CGFloat = maxPoints <= 15 ? 3.5 : 6.4
                    
                    matchView.width == matchView.superview!.height / heightFactor
                    matchView.height == matchView.superview!.height / heightFactor
                    matchView.top == matchView.superview!.top + 5
                    matchView.centerX == matchView.superview!.centerX
                }
            } else {
                let referenceIndex: Int!
                // When finish the matchstick block move reference to last block
                if i <= 9 {
                    referenceIndex = 4
                } else if i <= 14 {
                    referenceIndex = 9
                } else if i <= 19 {
                    referenceIndex = 14
                } else if i <= 24 {
                    referenceIndex = 19
                } else {
                    referenceIndex = 24
                }
                
                constrain(self.matches[referenceIndex], self.matches[i]) { prevIconView, actualIconView in
                    actualIconView.width == prevIconView.width
                    actualIconView.height == prevIconView.height
                    actualIconView.top == prevIconView.bottom + (5)
                    actualIconView.centerX == prevIconView.centerX
                }
            }
        }
        
        super.updateConstraints()
    }
    
    // MARK - private methods
    
    private func commonInit() {
    }
    
    // MARK - public methods
    
    public func setTotal(withMaxValue max: Int) {
        maxPoints = max
    }
    
    public func reset() {
        matches = []
        
        for i in 0..<points {
            removeView(withTag: i + PTMatchstickGrid.tagBase)
        }
        points = 0
        updateConstraints()
    }
    
    public func setPoints(value: Int) {
        
        guard value >= 0 else { return }
        
        let alpha = abs(points - value)
        
        for _ in 0..<alpha {
            if value > points {
                add()
            } else {
                substract()
            }
        }
    }
    
    
    public func substract() {
        
        guard (points - 1) >= 0 else { return }
        
        points -= 1
        matches.removeLast()
        removeView(withTag: points + PTMatchstickGrid.tagBase)
        updateConstraints()
    }
    
    public func add() {
        
        guard (points + 1) <= maxPoints else { return }
        
        if (points + 1) == maxPoints {
            onMaxPointsReached?()
        }
        
        let mod = points % 5
        if let image = UIImage(named: "matchstick_\(mod)") {
            let imageView = UIImageView()
            imageView.image = image
            // To avoid remove rootview (tag = 0) use base points
            imageView.tag = points + PTMatchstickGrid.tagBase
            matches.append(imageView)
            addSubview(imageView)
        }
        points += 1
        updateConstraints()
    }
    
    private func removeView(withTag tag: Int) {
        if let viewWithTag = viewWithTag(tag) {
            viewWithTag.removeFromSuperview()
        }
    }
}
