//
//  LayerHandler.swift
//  Layers
//
//  Created by Zach Eriksen on 6/26/15.
//  Copyright (c) 2015 Leif. All rights reserved.
//

import Foundation
import UIKit

class LayerHandler : UIView{
    var layers : [Layer] = [] {
        didSet{
            if layers.count > 8 {
                println("\(ErrorLayers[0])")
            }
            layerHeight = frame.height/CGFloat(layers.count)
            var y : CGFloat = 0
            for layer in layers{
                layer.frame = CGRectMake(layer.frame.origin.x, y, layer.frame.width, layerHeight!)
                layer.updateLayer()
                layer.layerHeight = layerHeight
                y += layerHeight!
            }
        }
    }
    var y  : CGFloat = 0
    var tagForLayers = 0
    var layerHeight : CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         layerHeight = frame.height
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layerPressed(sender : AnyObject){
        var tag = sender.tag
        for layer in layers{
            if tag == 0{
                tag = -1
                 layer.animateBackToOriginalPosition()
            }else if tag == -1{
                layer.animateBackToOriginalPosition()
            }else if layer.tag == tag{
                layer.animateToMaximizedPosition()
            }else if layer.tag > tag{
                layer.animateBackToOriginalPosition()
            }else {
                layer.animateToMinimizedPosition()
            }
        }
    }
    
    func addLayer(color : UIColor, title : String) -> Layer{
        let layer = Layer(y: y, color: color, title: title, tag: tagForLayers++,layerWidth: frame.width, layerHeight : layerHeight!)
        y += layerHeight!
        let button = UIButton(frame: CGRectMake(0, 0, frame.width, layerHeight!))
        button.addTarget(self, action: "layerPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        button.tag = layer.tag
        layer.addSubview(button)
        layer.sendSubviewToBack(button)
        layers.append(layer)
        addSubview(layer)
        return layer
    }
    
    func layerWithTitle(title : String) -> Layer? {
        for l in layers {
            if l.label?.text == title {
                return l
            }
        }
        return nil
    }
}

let ErrorLayers = [
    "WARNING: You are putting a lot of layers, might not work right or look nice :)"
]