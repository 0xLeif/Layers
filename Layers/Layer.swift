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
    private let minimizedSize :CGFloat = 50
    private let animationDuration :NSTimeInterval = 0.45
    private var innerView : UIView?
    private var firstRect  : CGRect?
    var layerHeight : CGFloat?
    var label : UILabel?
    
    init(y : CGFloat, color : UIColor, title : String, tag : Int,layerWidth : CGFloat, layerHeight : CGFloat){
        let rect = CGRect(x: 0, y: y, width: layerWidth, height: layerHeight)
        super.init(frame: rect)
        
        self.tag = tag
        self.layerHeight = layerHeight
        self.firstRect = CGRectMake(0, 0, frame.width, frame.height)
        self.backgroundColor = color
        self.innerView = UIView(frame: CGRectMake(0, 0, frame.width, frame.height))
        innerView?.hidden = true
        
        makeLabel(title)
        addSubview(label!)
        addSubview(innerView!)
        innerView?.sendSubviewToBack(label!)
    }
    
    func makeLabel(text : String) {
        label = UILabel(frame: CGRectMake(0, 0, frame.width, frame.height))
        label!.text = text
        label!.textAlignment = .Center
    }
    
    func updateLayer(){
        let newRect = CGRectMake(0, 0, frame.width, frame.height)
        innerView?.frame = newRect
        label?.frame = newRect
        firstRect  = newRect
    }
    
    func moveLabelToTop(){
        label?.frame = CGRect(x: 0, y: 5, width: frame.width, height: minimizedSize-10)
    }
    
    func returnLabelToFirstLocation(){
        label?.frame = firstRect!
    }
    
    func addToInnerView(view : () -> UIView){
        innerView?.addSubview(view())
    }
    
    func addViewsToInnerView(view : () -> [UIView]){
        for v in view() {
            innerView?.addSubview(v)
        }
    }
    
    func removeSubviewsFromInnerView(){
        for sv in innerView!.subviews {
            sv.removeFromSuperview()
        }
    }
    
    func showInnerView(){
        innerView?.frame = CGRectMake(0,0, self.frame.width, self.getMaximizedHeight())
        innerView?.hidden = false
    }
    
    func hideInnerView(){
        innerView?.hidden = true
    }
    
    func animateBackToOriginalPosition(){
        UIView.animateWithDuration(animationDuration, animations: {
            self.returnLabelToFirstLocation()
            self.frame = CGRectMake(0, (CGFloat(self.tag)*self.layerHeight!), self.frame.width, self.layerHeight!)
            }, completion: { _ in
                self.hideInnerView()
        })
    }
    
    func animateToMinimizedPosition(){
        UIView.animateWithDuration(animationDuration, animations: {
            self.moveLabelToTop()
            self.frame = CGRectMake(0, (CGFloat(self.tag)*self.minimizedSize), self.frame.width, self.minimizedSize)
            }, completion: { _ in
                self.hideInnerView()
        })
    }
    
    func animateToMaximizedPosition(){
        self.showInnerView()
        UIView.animateWithDuration(animationDuration, animations: {
            self.moveLabelToTop()
            self.frame = CGRectMake(0, (CGFloat(self.tag)*self.minimizedSize), self.frame.width, self.getMaximizedHeight())
        })
    }
    
    func getMaximizedHeight() -> CGFloat{
        return (layerHeight!*CGFloat((tag+1)))-(minimizedSize*CGFloat(tag))
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
