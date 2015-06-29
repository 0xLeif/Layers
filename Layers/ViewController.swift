
//
//  ViewController.swift
//  Layers
//
//  Created by Zach Eriksen on 6/24/15.
//  Copyright (c) 2015 Leif. All rights reserved.
//

import UIKit


let purple = UIColor(red: 115/255, green: 115/255, blue: 150/255, alpha: 1)
let blue =  UIColor(red: 102/255, green: 168/255, blue: 174/255, alpha: 1)
let lightGreen = UIColor(red: 196/255, green: 213/255, blue: 173/255, alpha: 1)
let darkGreen = UIColor(red: 107/255, green: 134/255, blue: 113/255, alpha: 1)
let screenWidth = UIScreen.mainScreen().bounds.width
let screenHeight = UIScreen.mainScreen().bounds.height

class ViewController: UIViewController {
    var handler = LayerHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handler.frame = CGRectMake(0, 0, 200, screenHeight)
        createLayers()
        view.addSubview(handler)
        let addButton = UIButton(frame: CGRectMake(200, screenHeight/3, screenWidth-200, 40))
        addButton.titleLabel?.textAlignment = .Center
        addButton.setTitle("Add", forState: .Normal)
        addButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        addButton.addTarget(self, action: "add", forControlEvents: .TouchUpInside)
        view.addSubview(addButton)
        let deleteRandomLayer = UIButton(frame: CGRectMake(200,(screenHeight/3)*2, screenWidth-200, 40))
        deleteRandomLayer.titleLabel?.textAlignment = .Center
        deleteRandomLayer.setTitle("Delete", forState: .Normal)
        deleteRandomLayer.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        deleteRandomLayer.addTarget(self, action: "delete", forControlEvents: .TouchUpInside)
        view.addSubview(deleteRandomLayer)
    }
    
    func delete(){
        if handler.layers.count > 0 {
            let layerRandom = arc4random_uniform(UInt32(handler.layers.count))
            var layerName = handler.layers[0].label!.text
            handler.removeLayerWithTitle(layerName!)
        }
    }
    
    func add(){
        func randomColor() -> UIColor{
            let red = arc4random_uniform(255)
            let blue = arc4random_uniform(255)
            let green = arc4random_uniform(255)
            return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1)
        }
        handler.addLayer(randomColor(), title: "\(arc4random_uniform(100))")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: false)
    }
    
    func createLayers(){
        handler.addLayer(purple, title: "Title")
        handler.addLayer(blue, title: "First")!.addToInnerView({
            let label = UILabel(frame: CGRectMake(0, 0, 100, 40))
            label.text = "Inside the First view!"
            label.sizeToFit()
            return label
        })
        handler.addLayer(lightGreen, title: "Second")
        handler.layerWithTitle("Second")?.addToInnerView({
            let buttonSegue = UIButton(frame: CGRectMake(30, 50, self.handler.layerWithTitle("Second")!.frame.width-60, 50))
            buttonSegue.setTitle("Next", forState: UIControlState.Normal)
            buttonSegue.addTarget(self, action: "segue:", forControlEvents: .TouchUpInside)
            buttonSegue.titleLabel?.textAlignment = .Center
            buttonSegue.titleLabel?.textColor = .blackColor()
            return buttonSegue
        })
        handler.addLayer(darkGreen, title: "Third")
    }
    
    func segue(sender : AnyObject){
            performSegueWithIdentifier("nextView", sender: nil)
            navigationController?.setNavigationBarHidden(false, animated: true)
    }
}