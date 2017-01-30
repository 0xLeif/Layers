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
    fileprivate let minimizedSize :CGFloat = 50
    fileprivate let animationDuration :TimeInterval = 0.45
    fileprivate var innerView : UIView?
    fileprivate var firstRect  : CGRect?
    var layerHeight : CGFloat?
    var label : UILabel?
    
    init(y : CGFloat, color : UIColor, title : String, tag : Int,layerWidth : CGFloat, layerHeight : CGFloat){
        let rect = CGRect(x: 0, y: y, width: layerWidth, height: layerHeight)
        super.init(frame: rect)
        
        self.tag = tag
        self.layerHeight = layerHeight
        self.firstRect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.backgroundColor = color
        self.innerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        innerView?.isHidden = true
        
        makeLabel(title)
        addSubview(label!)
        addSubview(innerView!)
        innerView?.sendSubview(toBack: label!)
    }
    
    func makeLabel(_ text : String) {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        label!.text = text
        label!.textAlignment = .center
    }
    
    func updateLayer(){
        let newRect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
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
    
    func addToInnerView(_ view : () -> UIView){
        innerView?.addSubview(view())
    }
    
    func addViewsToInnerView(_ view : () -> [UIView]){
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
        innerView?.frame = CGRect(x: 0,y: 0, width: self.frame.width, height: self.getMaximizedHeight())
        innerView?.isHidden = false
    }
    
    func hideInnerView(){
        innerView?.isHidden = true
    }
    
    func animateBackToOriginalPosition(){
        UIView.animate(withDuration: animationDuration, animations: {
            self.returnLabelToFirstLocation()
            self.frame = CGRect(x: 0, y: (CGFloat(self.tag)*self.layerHeight!), width: self.frame.width, height: self.layerHeight!)
            }, completion: { _ in
                self.hideInnerView()
        })
    }
    
    func animateToMinimizedPosition(){
        UIView.animate(withDuration: animationDuration, animations: {
            self.moveLabelToTop()
            self.frame = CGRect(x: 0, y: (CGFloat(self.tag)*self.minimizedSize), width: self.frame.width, height: self.minimizedSize)
            }, completion: { _ in
                self.hideInnerView()
        })
    }
    
    func animateToMaximizedPosition(){
        self.showInnerView()
        UIView.animate(withDuration: animationDuration, animations: {
            self.moveLabelToTop()
            self.frame = CGRect(x: 0, y: (CGFloat(self.tag)*self.minimizedSize), width: self.frame.width, height: self.getMaximizedHeight())
        })
    }
    
    func getMaximizedHeight() -> CGFloat{
        return (layerHeight!*CGFloat((tag+1)))-(minimizedSize*CGFloat(tag))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
