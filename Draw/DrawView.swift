//
//  DrawView.swift
//  Draw
//
//  Created by Damon Cricket on 20.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - DrawView

class DrawView: UIView {

    var point: CGPoint {
        set {
            drawLayer.point = newValue
        } get {
            return drawLayer.point
        }
    }
    
    var width: CGFloat {
        set {
            drawLayer.width = newValue
        } get {
            return drawLayer.width
        }
    }
    
    var color: UIColor {
        set {
            drawLayer.color = newValue.cgColor
        } get {
            return UIColor(cgColor: drawLayer.color)
        }
    }
    
    var drawLayer: DrawLayer {
        return layer as! DrawLayer
    }
    
    override open class var layerClass: AnyClass {
        return DrawLayer.self
    }
}
