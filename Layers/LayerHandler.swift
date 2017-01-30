//
//  LayerHandler.swift
//  Layers
//
//  Created by Zach Eriksen on 6/26/15.
//  Copyright (c) 2015 Leif. All rights reserved.
//

import Foundation
import UIKit

let purple = UIColor(red: 115/255, green: 115/255, blue: 150/255, alpha: 1)
let blue =  UIColor(red: 102/255, green: 168/255, blue: 174/255, alpha: 1)
let lightGreen = UIColor(red: 196/255, green: 213/255, blue: 173/255, alpha: 1)
let darkGreen = UIColor(red: 107/255, green: 134/255, blue: 113/255, alpha: 1)
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

class LayerHandler : UIView{
    fileprivate let WarningLayer = [
        "WARNING: Layer limit of 8 hit",
        "WARNING: Default init will have frame of x: 0, y: 0, width: \(screenWidth), height: \(screenHeight)",
        "WARNING: You must have at least one layer!"
    ]
    var layers : [Layer] = [] {
        didSet{
            layerHeight = frame.height/CGFloat(layers.count)
            var y : CGFloat = 0
            for layer in layers{
                layer.frame = CGRect(x: layer.frame.origin.x, y: y, width: layer.frame.width, height: layerHeight!)
                layer.updateLayer()
                layer.layerHeight = layerHeight
                y += layerHeight!
            }
        }
    }
    fileprivate var y  : CGFloat = 0
    fileprivate var tagForLayers = 0
    fileprivate var layerHeight : CGFloat?
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        layerHeight = frame.height
        print(WarningLayer[1])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layerHeight = frame.height
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layerPressed(_ sender : AnyObject){
        var tag = sender.tag
        for layer in layers{
            if tag == 0{
                tag = -1
                 layer.animateBackToOriginalPosition()
            }else if tag == -1{
                layer.animateBackToOriginalPosition()
            }else if layer.tag == tag{
                layer.animateToMaximizedPosition()
            }else if layer.tag > tag!{
                layer.animateBackToOriginalPosition()
            }else {
                layer.animateToMinimizedPosition()
            }
        }
    }
    
    func resetLayersToOriginalPosition(){
        for layer in layers{
            layer.animateBackToOriginalPosition()
        }
    }
    
    func addLayer(_ color : UIColor, title : String) -> Layer?{
        if layers.count >= 8 {
            print(WarningLayer[0])
            return nil
        }
        resetLayersToOriginalPosition()
        let layer = Layer(y: y, color: color, title: title, tag: tagForLayers,layerWidth: frame.width, layerHeight : layerHeight!)
        tagForLayers += 1
        y += layerHeight!
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width, height: layerHeight!))
        button.addTarget(self, action: #selector(LayerHandler.layerPressed(_:)), for: UIControlEvents.touchUpInside)
        button.tag = layer.tag
        layer.addSubview(button)
        layer.sendSubview(toBack: button)
        layers.append(layer)
        addSubview(layer)
        return layer
    }
    
    func layerWithTitle(_ title : String) -> Layer? {
        for l in layers {
            if l.label?.text == title {
                return l
            }
        }
        return nil
    }
    
    func removeLayerWithTitle(_ title : String){
        if layers.count == 1 {
            print(WarningLayer[2])
            return
        }
        for l in layers {
            l.removeFromSuperview()
            if l.label?.text == title {
                layers.remove(at: l.tag)
            }
        }
        resetLayersTags()
    }
    
    func removeLayerWithTag(_ tag : UInt32){
        if layers.count == 1 {
           print(WarningLayer[2])
            return
        }
        for l in layers {
            l.removeFromSuperview()
            if UInt32(l.label!.tag) == tag {
                layers.remove(at: l.tag)
            }
        }
        resetLayersTags()
    }
    
    fileprivate  func resetLayersTags(){
        tagForLayers = 0
        for l in layers {
            l.tag = tagForLayers
            for sub in l.subviews {
                if let button : UIButton = sub as? UIButton {
                    button.frame = CGRect(x: 0, y: 0, width: l.frame.width, height: l.frame.height)
                    button.tag = tagForLayers
                    tagForLayers += 1
                }
            }
            addSubview(l)
        }
        resetLayersToOriginalPosition()
    }
}
