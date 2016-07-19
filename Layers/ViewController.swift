
//
//  ViewController.swift
//  Layers
//
//  Created by Zach Eriksen on 6/24/15.
//  Copyright (c) 2015 Leif. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    var handler = LayerHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLayers()
        view.addSubview(handler)
//        let addButton = UIButton(frame: CGRectMake(200, screenHeight/3, screenWidth-200, 40))
//        addButton.titleLabel?.textAlignment = .Center
//        addButton.setTitle("Add", forState: .Normal)
//        addButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        addButton.addTarget(self, action: "add", forControlEvents: .TouchUpInside)
//        view.addSubview(addButton)
//        let deleteRandomLayer = UIButton(frame: CGRectMake(200,(screenHeight/3)*2, screenWidth-200, 40))
//        deleteRandomLayer.titleLabel?.textAlignment = .Center
//        deleteRandomLayer.setTitle("Delete", forState: .Normal)
//        deleteRandomLayer.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        deleteRandomLayer.addTarget(self, action: "delete", forControlEvents: .TouchUpInside)
//        view.addSubview(deleteRandomLayer)
    }
    
    func delete(){
        if handler.layers.count > 0 {
            let layerName = handler.layers[0].label!.text
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
        handler.addLayer(blue, title: "Plan")
        handler.addLayer(lightGreen, title: "Budget")
        handler.layerWithTitle("Budget")?.addToInnerView({
            let buttonSegue = UIButton(frame: CGRectMake(30, 50, self.handler.layerWithTitle("Budget")!.frame.width-60, 50))
            buttonSegue.setTitle("Next", forState: UIControlState.Normal)
            buttonSegue.addTarget(self, action: #selector(ViewController.segue(_:)), forControlEvents: .TouchUpInside)
            buttonSegue.titleLabel?.textAlignment = .Center
            buttonSegue.titleLabel?.textColor = .blackColor()
            return buttonSegue
        })
        handler.addLayer(darkGreen, title: "Vehicles")
        handler.addLayer(UIColor(red: 200/255, green: 100/255, blue: 100/255, alpha: 1), title: "Definitions")
    }
    
    func segue(sender : AnyObject){
            performSegueWithIdentifier("nextView", sender: nil)
            navigationController?.setNavigationBarHidden(false, animated: true)
    }
}