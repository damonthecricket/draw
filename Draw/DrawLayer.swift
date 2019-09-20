//
//  DrawLayer.swift
//  Draw
//
//  Created by Damon Cricket on 20.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - DrawLayer

class DrawLayer: CALayer {

    var point: CGPoint = .zero {
        didSet {
            points.append(point)
            setNeedsDisplay()
        }
    }
    
    var points: [CGPoint] = []
    
    var width: CGFloat = 0.0
    
    var color: CGColor = UIColor.clear.cgColor
    
    // MARK: - Draw
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        guard points.count > 1 else {
            return
        }
        
        UIGraphicsPushContext(ctx)
        
        ctx.setLineWidth(width)
        
        let path = CGMutablePath()
        
        let firstPoint = points.first!
        
        path.move(to: firstPoint)
        
        for idx in 0 ..< points.count {
            let pnt = points[idx]
            path.addLine(to: pnt)
        }
        
        ctx.addPath(path)
        
        ctx.setStrokeColor(color)
        
        ctx.setFillColor(UIColor.clear.cgColor)
        
        ctx.strokePath()
        
        UIGraphicsPopContext()
    }
}
