//
//  Layer.swift
//  Layers
//
//  Created by Zach Eriksen on 6/24/15.
//  Copyright (c) 2015 Leif. All rights reserved.
//

import Foundation
import UIKit

class Layer : UIView {
    let width = UIScreen.mainScreen().bounds.width
    let minimizedSize :CGFloat = 40
    let animationDuration :NSTimeInterval = 0.5
    var label : UILabel?
    var innerView : UIView?
    var firstRect  : CGRect?
    
    init(y : CGFloat, color : UIColor, title : String, tag : Int){
        let rect = CGRect(x: 0, y: y, width: width, height: layerHeight)
        super.init(frame: rect)
        self.tag = tag
        firstRect = CGRectMake(0, 0, frame.width, frame.height)
        label = makeLabel(title)
        addSubview(label!)
        self.backgroundColor = color
        innerView = UIView(frame: rect)
        innerView?.hidden = true
        addSubview(innerView!)
    }
    
    func makeLabel(text : String) -> UILabel{
        let label = UILabel(frame: CGRectMake(0, 0, frame.width, frame.height))
        label.text = text
        label.textAlignment = .Center
        return label
    }
    
    func moveLabelToTop(){
        label?.frame = CGRect(x: 0, y: 10, width: frame.width, height: minimizedSize-10)
    }

    func returnLabelToFirstLocation(){
        label?.frame = firstRect!
    }
    
    func addToInnerView(subView : UIView){
        innerView?.addSubview(subView)
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
            self.frame = CGRectMake(0, (CGFloat(self.tag)*layerHeight+navBarHeight), screenWidth, layerHeight)
        }, completion: { _ in
            self.hideInnerView()
        })
    }
    
    func animateToMinimizedPosition(){
        UIView.animateWithDuration(animationDuration, animations: {
            self.moveLabelToTop()
            self.frame = CGRectMake(0, (CGFloat(self.tag)*self.minimizedSize+navBarHeight), screenWidth, self.minimizedSize)
        }, completion: { _ in
            self.hideInnerView()
        })
    }
    
    func animateToMaximizedPosition(){
        self.showInnerView()
        UIView.animateWithDuration(animationDuration, animations: {
                self.moveLabelToTop()
                self.frame = CGRectMake(0, (CGFloat(self.tag)*self.minimizedSize+navBarHeight), screenWidth, self.getMaximizedHeight())
            })
    }
    
    func getMaximizedHeight() -> CGFloat{
        return (layerHeight*CGFloat((tag+1)))-(minimizedSize*CGFloat(tag))
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}