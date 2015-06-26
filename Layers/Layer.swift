//
//  Layer.swift
//  Layers
//
//  Created by Zach Eriksen on 6/24/15.
//  Copyright (c) 2015 Leif. All rights reserved.
//

import Foundation
import UIKit

let purple = UIColor(red: 115/255, green: 115/255, blue: 150/255, alpha: 1)
let blue =  UIColor(red: 102/255, green: 168/255, blue: 174/255, alpha: 1)
let lightGreen = UIColor(red: 196/255, green: 213/255, blue: 173/255, alpha: 1)
let darkGreen = UIColor(red: 107/255, green: 134/255, blue: 113/255, alpha: 1)

class Layer : UIView {
    let width = UIScreen.mainScreen().bounds.width
    let minimizedSize :CGFloat = 40
    let animationDuration :NSTimeInterval = 0.5
    var label : UILabel?
    var innerView : UIView?
    var firstRect  : CGRect?
    var layerHeight : CGFloat?
    
    init(y : CGFloat, color : UIColor, title : String, tag : Int, layerHeight : CGFloat){
        let rect = CGRect(x: 0, y: y, width: width, height: layerHeight)
        super.init(frame: rect)
        self.tag = tag
        self.layerHeight = layerHeight
        firstRect = CGRectMake(0, 0, frame.width, frame.height)
        makeLabel(title)
        addSubview(label!)
        self.backgroundColor = color
        innerView = UIView(frame: rect)
        innerView?.hidden = true
        addSubview(label!)
        addSubview(innerView!)
    }
    
    func makeLabel(text : String) {
        label = UILabel(frame: CGRectMake(0, 0, frame.width, frame.height))
        label!.text = text
        label!.textAlignment = .Center
    }
    
    func updateLabel(){
        label?.frame = CGRectMake(0, 0, frame.width, frame.height)
        firstRect  = CGRectMake(0, 0, frame.width, frame.height)
    }
    
    func moveLabelToTop(){
        label?.frame = CGRect(x: 0, y: 10, width: frame.width, height: minimizedSize-10)
    }

    func returnLabelToFirstLocation(){
        label?.frame = firstRect!
    }
    
    func addToInnerView(view : () -> UIView){
        innerView?.addSubview(view())
    }
    
    func showInnerView(){
        innerView?.frame = CGRectMake(0, (CGFloat(self.tag)*self.minimizedSize), screenWidth, self.getMaximizedHeight())
        innerView?.hidden = false
    }
    
    func hideInnerView(){
        innerView?.hidden = true
    }
    
    func animateBackToOriginalPosition(){
        UIView.animateWithDuration(animationDuration, animations: {
            self.returnLabelToFirstLocation()
            self.frame = CGRectMake(0, (CGFloat(self.tag)*self.layerHeight!), screenWidth, self.layerHeight!)
        }, completion: { _ in
            self.hideInnerView()
        })
    }
    
    func animateToMinimizedPosition(){
        UIView.animateWithDuration(animationDuration, animations: {
            self.moveLabelToTop()
            self.frame = CGRectMake(0, (CGFloat(self.tag)*self.minimizedSize), screenWidth, self.minimizedSize)
        }, completion: { _ in
            self.hideInnerView()
        })
    }
    
    func animateToMaximizedPosition(){
        self.showInnerView()
        UIView.animateWithDuration(animationDuration, animations: {
                self.moveLabelToTop()
                self.frame = CGRectMake(0, (CGFloat(self.tag)*self.minimizedSize), screenWidth, self.getMaximizedHeight())
            })
    }
    
    func getMaximizedHeight() -> CGFloat{
        return (layerHeight!*CGFloat((tag+1)))-(minimizedSize*CGFloat(tag))
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}