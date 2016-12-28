//
//  ViewController.swift
//  Geometry
//
//  Created by Jimmy Hoang on 12/26/16.
//  Copyright © 2016 Jimmy Hoang. All rights reserved.
//

import UIKit

enum Shape: Int {
    case Triangle = 0
    case Rectangle = 1
    case Arc = 2
    case Ellipse = 3
}

class ViewController: UIViewController {
    
    var triangleTxtSide1: UITextField!
    var triangleTxtSide2: UITextField!
    var triangleTxtSide3: UITextField!
    
    var rectWidth: UITextField!
    var rectHeight: UITextField!
    
    var arcRadius: UITextField!
    var arcDegree: UITextField!
    
    var ellipseBigRadius: UITextField!
    var ellipseSmallRadius: UITextField!
    
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var perimeterLabel: UILabel!
    @IBOutlet weak var textArea: UIView!
    @IBOutlet weak var DrawingView: DrawView!
    @IBOutlet weak var scale: UISlider!
    @IBOutlet weak var segmenOutlet: UISegmentedControl!
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        textArea.subviews.forEach{ $0.removeFromSuperview() }
        
        switch selectedIndex {
        case Shape.Triangle.rawValue:
            DrawingView.segmentIndex = selectedIndex
            addTriangleTextfield()
        case Shape.Rectangle.rawValue:
            DrawingView.segmentIndex = selectedIndex
            addRectangleTextfield()
        case Shape.Arc.rawValue:
            DrawingView.segmentIndex = selectedIndex
            addArcTextfield()
        case Shape.Ellipse.rawValue:
            DrawingView.segmentIndex = selectedIndex
            addEllipseTextfield()
        default:
            break
        }
    }
    
    @IBAction func scaleChange(_ sender: UISlider) {
        DrawingView.scale = CGFloat(sender.value)
    }
    
    @IBAction func Draw(_ sender: UIButton) {
        
        switch segmenOutlet.selectedSegmentIndex {
        case Shape.Triangle.rawValue:
            let side1 = Double(triangleTxtSide1.text!)
            let side2 = Double(triangleTxtSide2.text!)
            let side3 = Double(triangleTxtSide3.text!)
            DrawingView.triangleTxtSide1 = side1!
            DrawingView.triangleTxtSide2 = side2!
            DrawingView.triangleTxtSide3 = side3!
            setAreaPerimeter()
        case Shape.Rectangle.rawValue:
            let w = CGFloat(rectWidth.text!.toDouble)
            let h = CGFloat(rectHeight.text!.toDouble)
            DrawingView.rectWidth = w
            DrawingView.rectHeight = h
            setAreaPerimeter()
        case Shape.Arc.rawValue:
            let radius = CGFloat(arcRadius.text!.toDouble)
            let degree = arcDegree.text!.toDouble
            DrawingView.arcRadius = radius
            DrawingView.arcDegree = degree
            setAreaPerimeter()
            break
        case Shape.Ellipse.rawValue:
            let bigRad = CGFloat(ellipseBigRadius.text!.toDouble)
            let smallRad = CGFloat(ellipseSmallRadius.text!.toDouble)
            DrawingView.ellipseBigRadius = bigRad
            DrawingView.ellipseSmallRadius = smallRad
            setAreaPerimeter()
            break
        default:
            break
        }
    }
    
    func setAreaPerimeter() {
        areaLabel?.text = String(DrawingView.area)
        perimeterLabel?.text = String(DrawingView.perimeter)
    }
    
    func addTriangleTextfield() {
        UILabel.create(at: 5, text: "Side 1:", view: textArea)
        UILabel.create(at: 41, text: "Side 2:", view: textArea)
        UILabel.create(at: 77, text: "Side 3:", view: textArea)
        
        triangleTxtSide1 =  UITextField.create(at: 0, borderStyle: .roundedRect, view: textArea, text: "100")
        triangleTxtSide2 = UITextField.create(at: 36, borderStyle: .roundedRect, view: textArea, text: "100")
        triangleTxtSide3 = UITextField.create(at: 74, borderStyle: .roundedRect, view: textArea, text: "100")
    }
    
    func addRectangleTextfield() {
        UILabel.create(at: 5, text: "Width", view: textArea)
        UILabel.create(at: 41, text: "Height:", view: textArea)
        
        rectWidth = UITextField.create(at: 0, borderStyle: .roundedRect, view: textArea, text: "100")
        rectHeight = UITextField.create(at: 36, borderStyle: .roundedRect, view: textArea, text: "40")
    }
    
    func addArcTextfield() {
        UILabel.create(at: 5, text: "Radius:", view: textArea)
        UILabel.create(at: 41, text: "Degree:", view: textArea)
        
        arcRadius = UITextField.create(at: 0, borderStyle: .roundedRect, view: textArea, text: "100")
        arcDegree = UITextField.create(at: 36, borderStyle: .roundedRect, view: textArea, text: "90")
    }
    
    func addEllipseTextfield() {
        UILabel.create(at: 5, text: "Big Radius:", view: textArea)
        UILabel.create(at: 41, text: "Small Radius:", view: textArea)
        
        ellipseBigRadius = UITextField.create(at: 0, borderStyle: .roundedRect, view: textArea, text: "100")
        ellipseSmallRadius = UITextField.create(at: 36, borderStyle: .roundedRect, view: textArea, text: "50")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTriangleTextfield()
        DrawingView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch segmenOutlet.selectedSegmentIndex {
        case Shape.Triangle.rawValue:
            triangleTxtSide1.resignFirstResponder()
            triangleTxtSide2.resignFirstResponder()
            triangleTxtSide3.resignFirstResponder()
        case Shape.Rectangle.rawValue:
            rectWidth.resignFirstResponder()
            rectHeight.resignFirstResponder()
        case Shape.Arc.rawValue:
            arcRadius.resignFirstResponder()
            arcDegree.resignFirstResponder()
        case Shape.Ellipse.rawValue:
            ellipseBigRadius.resignFirstResponder()
            ellipseSmallRadius.resignFirstResponder()
        default:
            break
        }
    }
}

extension ViewController: Share {
    func updateArea(area: String) {
        self.areaLabel.text = area
    }
    
    func updatePerimeter(perimeter: String) {
        self.perimeterLabel.text = perimeter
    }
}

