//
//  DrawView.swift
//  Geometry
//
//  Created by Jimmy Hoang on 12/27/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import UIKit

protocol Share: class {
    func updateArea (area: String) -> Void
    func updatePerimeter (perimeter: String) -> Void
}

@IBDesignable
class DrawView: UIView {
    @IBInspectable var triangleTxtSide1: Double = 100.0 { didSet {setNeedsDisplay()} }
    @IBInspectable var triangleTxtSide2: Double = 100.0 { didSet {setNeedsDisplay()} }
    @IBInspectable var triangleTxtSide3: Double = 100.0 { didSet {setNeedsDisplay()} }
    
    @IBInspectable var rectWidth: CGFloat = 200.0 { didSet {setNeedsDisplay()} }
    @IBInspectable var rectHeight: CGFloat = 100.0 { didSet {setNeedsDisplay()} }
    
    @IBInspectable var arcRadius: CGFloat = 100.0 { didSet {setNeedsDisplay()} }
    @IBInspectable var arcDegree: Double = 90.0 { didSet {setNeedsDisplay()} }
    
    @IBInspectable var ellipseBigRadius: CGFloat = 100.0 { didSet {setNeedsDisplay()} }
    @IBInspectable var ellipseSmallRadius: CGFloat = 50.0 { didSet {setNeedsDisplay()} }
    @IBInspectable var lineWidth: CGFloat = 2.0 { didSet {setNeedsDisplay()} }
    @IBInspectable var scale: CGFloat = 0.5 { didSet {setNeedsDisplay()} }

    weak var delegate: Share?
    
    var area: Double = 0.0 { didSet{self.delegate?.updateArea(area: String(area)) } }
    var perimeter: Double = 0.0 { didSet{self.delegate?.updatePerimeter(perimeter: String(perimeter)) } }
    
    var segmentIndex: Int = 0 {
        didSet {setNeedsDisplay()}
    }
    
    override func draw(_ rect: CGRect) {
        switch segmentIndex {
        case Shape.Triangle.rawValue:
            drawTriangle()
        case Shape.Rectangle.rawValue:
            drawRectangle()
        case Shape.Arc.rawValue:
            drawArc()
        case Shape.Ellipse.rawValue:
            drawEllipse()
        default:
            break
        }
    }
    
    func drawTriangle() {
        let array = get_third_point_coordinates(side1: triangleTxtSide1, side2: triangleTxtSide2, side3: triangleTxtSide3)
        let thirdPoint = CGPoint(x: array[0] + 100, y: 100 - array[1])
        let path = UIBezierPath()
        let startPoint = CGPoint(x: 100, y: 100)
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: 100 + triangleTxtSide1, y: 100))
        path.addLine(to: thirdPoint)
        path.addLine(to: startPoint)
        path.close()
        path.apply(CGAffineTransform(scaleX: scale, y: scale))
        
        area = 0.5 * array[1] * triangleTxtSide1
        perimeter = triangleTxtSide1 + triangleTxtSide2 + triangleTxtSide3
        
        UIColor.black.setStroke()
        path.stroke()
        setNeedsDisplay()
    }
    
    func get_third_point_coordinates(side1: Double, side2: Double, side3: Double) -> [Double] {
        let a: Double = side1
        var b: Double = side2
        var c: Double = side3
        
        var array: [Double] = []
        let s = (a + b + c) / 2
        let area = sqrt(s*(s-a)*(s-b)*(s-c))
 
        if b < c {
            b = side3
            c = side2
        }
        
        let height = area / (a * 0.5)
        let smallSide = sqrt(pow(b, 2) - pow(height, 2))
        let dx = a - smallSide
        array.append(dx)
        array.append(height)
        return array
    }
    
    func drawRectangle() {
        let path = UIBezierPath(rect: CGRect(x: 5, y: 5, width: rectWidth * scale, height: rectHeight * scale))
        path.lineWidth = lineWidth
        path.close()
        UIColor.black.setStroke()
        path.stroke()
        setNeedsDisplay()
        area = Double(rectWidth) * Double(rectHeight)
        perimeter = 2 * (Double(rectHeight) + Double(rectWidth))
    }
    
    func drawArc() {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let path = UIBezierPath(arcCenter: center, radius: arcRadius * scale, startAngle: CGFloat((360 - arcDegree).degreesToRadians), endAngle: 0, clockwise: true)
        path.addLine(to: center)
        path.close()
        
        area = pow(Double(arcRadius), 2) / 2 * (180 / M_PI * arcDegree - sin(arcDegree))
        perimeter = 2 * M_PI * Double(arcRadius) * arcDegree / 360
        
        path.lineWidth = lineWidth
        UIColor.black.setStroke()
        path.stroke()
        setNeedsDisplay()
    }
    
    func drawEllipse() {
        let path = UIBezierPath(ovalIn: CGRect(x: self.frame.width * 0.2, y: self.frame.height * 0.2, width: ellipseBigRadius * scale, height: ellipseSmallRadius * scale))
        path.close()
        area = M_PI * Double(ellipseBigRadius) * Double(ellipseSmallRadius)
        perimeter = 2 * M_PI * sqrt((Double(ellipseSmallRadius) * Double(ellipseSmallRadius) + Double(ellipseBigRadius) * Double(ellipseBigRadius)) / 2)
        
        path.lineWidth = lineWidth
        UIColor.black.setStroke()
        path.stroke()
        setNeedsDisplay()

    }
    
}
