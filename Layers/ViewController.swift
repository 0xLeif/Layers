
//
//  ViewController.swift
//  Layers
//
//  Created by Zach Eriksen on 6/24/15.
//  Copyright (c) 2015 Leif. All rights reserved.
//

import UIKit

let layerHeight : CGFloat = (UIScreen.mainScreen().bounds.height)/4
let screenWidth = UIScreen.mainScreen().bounds.width
let screenHeight = UIScreen.mainScreen().bounds.height

class ViewController: UIViewController {
    var titleView : Layer?
    var firstView : Layer?
    var secondView : Layer?
    var thirdView : Layer?

    override func viewDidLoad() {
        super.viewDidLoad()
        createLayers()
        addLayerHandlers()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(navigationController?.navigationBarHidden == false, animated: false)
    }
    
    func createLayers(){
        var y  : CGFloat = 0
        var tag = 0
        func createLayer(color : UIColor, title : String) -> Layer{
            let layerToReturn = Layer(y: y, color: color, title: title, tag: tag++)
            y += layerHeight
            return layerToReturn
        }
        titleView = createLayer(purple, title: "Title")
        view.addSubview(titleView!)
        firstView = createLayer(blue, title: "First")
        firstView?.addToInnerView({
            let label = UILabel(frame: CGRectMake(20, 40, 100, 40))
            label.text = "Inside the First view!"
            label.sizeToFit()
            return label
        })
        view.addSubview(firstView!)
        secondView = createLayer(lightGreen, title: "Second")
        secondView?.addToInnerView({
            let scrollList = UIScrollView(frame: CGRectMake(0, 0, self.secondView!.frame.width, self.secondView!.getMaximizedHeight()))
            var finalY :CGFloat = 80
            for count in 0...20 {
                let label = UILabel(frame: CGRectMake(10, CGFloat(count*40), scrollList.frame.width-20, 40))
                finalY += 40
                label.textAlignment = .Center
                label.text  = "Look at this number: \(count)"
                scrollList.addSubview(label)
            }
            scrollList.contentSize = CGSizeMake(screenWidth, finalY)
            return scrollList
        })
        view.addSubview(secondView!)
        thirdView = createLayer(darkGreen, title: "Third")
        thirdView?.addToInnerView({
            let buttonSegue = UIButton(frame: CGRectMake(30, 50, screenWidth-60, 50))
            buttonSegue.setTitle("Next", forState: UIControlState.Normal)
            buttonSegue.addTarget(self, action: "segue:", forControlEvents: .TouchUpInside)
            buttonSegue.titleLabel?.textAlignment = .Center
            buttonSegue.titleLabel?.textColor = .blackColor()
            return buttonSegue
        })
        view.addSubview(thirdView!)
    }
    
    func segue(sender : AnyObject){
            performSegueWithIdentifier("nextView", sender: nil)
            navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func addLayerHandlers(){
        func makeButton(selector : Selector) -> UIButton{
            let button = UIButton(frame: CGRectMake(0, 0, screenWidth, layerHeight))
            button.addTarget(self, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
            return button
        }
        titleView?.addSubview(makeButton("titlePressed:"))
        firstView?.addSubview(makeButton("firstPressed:"))
        secondView?.addSubview(makeButton("secondPressed:"))
        thirdView?.addSubview(makeButton("thirdPressed:"))
    }
    
    func titlePressed(sender : AnyObject){
        print("Title Pressed!", appendNewline: false)
            self.titleView?.animateBackToOriginalPosition()
            self.firstView?.animateBackToOriginalPosition()
            self.secondView?.animateBackToOriginalPosition()
            self.thirdView?.animateBackToOriginalPosition()
    }
    
    func firstPressed(sender : AnyObject){
        print("First Pressed!", appendNewline: false)
           self.titleView?.animateToMinimizedPosition()
            self.firstView?.animateToMaximizedPosition()
            self.secondView?.animateBackToOriginalPosition()
            self.thirdView?.animateBackToOriginalPosition()
    }
    func secondPressed(sender : AnyObject){
        print("Second Pressed!", appendNewline: false)
            self.titleView?.animateToMinimizedPosition()
            self.firstView?.animateToMinimizedPosition()
            self.secondView?.animateToMaximizedPosition()
            self.thirdView?.animateBackToOriginalPosition()
    }
    func thirdPressed(sender : AnyObject){
        print("Third Pressed!", appendNewline: false)
            self.titleView?.animateToMinimizedPosition()
            self.firstView?.animateToMinimizedPosition()
            self.secondView?.animateToMinimizedPosition()
            self.thirdView?.animateToMaximizedPosition()
    }
}