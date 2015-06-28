
//
//  ViewController.swift
//  Layers
//
//  Created by Zach Eriksen on 6/24/15.
//  Copyright (c) 2015 Leif. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.mainScreen().bounds.width
let screenHeight = UIScreen.mainScreen().bounds.height

class ViewController: UIViewController {
    var layers = LayerHandler()
    override func viewDidLoad() {
        super.viewDidLoad()
        layers.frame = CGRectMake(0, 0, 200, screenHeight)
        createLayers()
        view.addSubview(layers)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: false)
    }
    
    func createLayers(){
        layers.addLayer(purple, title: "Title")
        layers.addLayer(blue, title: "First").addToInnerView({
            let label = UILabel(frame: CGRectMake(0, 0, 100, 40))
            label.text = "Inside the First view!"
            label.sizeToFit()
            return label
        })
        layers.addLayer(lightGreen, title: "Second")
        layers.layerWithTitle("Second")?.addToInnerView({
            let buttonSegue = UIButton(frame: CGRectMake(30, 50, self.layers.layerWithTitle("Second")!.frame.width-60, 50))
            buttonSegue.setTitle("Next", forState: UIControlState.Normal)
            buttonSegue.addTarget(self, action: "segue:", forControlEvents: .TouchUpInside)
            buttonSegue.titleLabel?.textAlignment = .Center
            buttonSegue.titleLabel?.textColor = .blackColor()
            return buttonSegue
        })
        layers.addLayer(darkGreen, title: "Third")
    }
    
    func segue(sender : AnyObject){
            performSegueWithIdentifier("nextView", sender: nil)
            navigationController?.setNavigationBarHidden(false, animated: true)
    }
}