
//
//  ViewController.swift
//  Layers
//
//  Created by Zach Eriksen on 6/24/15.
//  Copyright (c) 2015 Leif. All rights reserved.
//

import UIKit

let navBarHeight : CGFloat = 64
let layerHeight : CGFloat = (UIScreen.mainScreen().bounds.height-navBarHeight)/4
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createLayers(){
        var y  : CGFloat = navBarHeight
        titleView = Layer(y: y,color : UIColor(red: 115/255, green: 115/255, blue: 150/255, alpha: 1), title: "Title", tag : 0)
        view.addSubview(titleView!)
        y += layerHeight
        firstView = Layer(y: y,color : UIColor(red: 102/255, green: 168/255, blue: 174/255, alpha: 1), title: "First" , tag : 1)
        let test = UILabel(frame: CGRectMake(20, 40, 100, 40))
        test.text = "Test Label!"
        firstView?.addToInnerView(test)
        view.addSubview(firstView!)
        y += layerHeight
        secondView = Layer(y: y,color : UIColor(red: 196/255, green: 213/255, blue: 173/255, alpha: 1), title: "Second", tag : 2)
        let scrollList = UIScrollView(frame: CGRectMake(0, 0, secondView!.frame.width, secondView!.getMaximizedHeight()))
        var finalY :CGFloat = 80
        for testStuff in 0...20 {
            let testLabel = UILabel(frame: CGRectMake(10, CGFloat(testStuff*40), scrollList.frame.width-20, 40))
            finalY += 40
            testLabel.textAlignment = .Center
            testLabel.text  = "Look at this number: \(testStuff)"
            scrollList.addSubview(testLabel)
        }
        scrollList.contentSize = CGSizeMake(screenWidth, finalY)
        secondView?.addToInnerView(scrollList)
        view.addSubview(secondView!)
        y += layerHeight
        thirdView = Layer(y: y,color : UIColor(red: 107/255, green: 134/255, blue: 113/255, alpha: 1), title: "Third", tag : 3)
        let segueToCool = UIButton(frame: CGRectMake(30, 50, screenWidth-60, 50))
        segueToCool.setTitle("Next", forState: UIControlState.Normal)
        segueToCool.addTarget(self, action: "segue:", forControlEvents: .TouchUpInside)
        segueToCool.titleLabel?.textAlignment = .Center
        segueToCool.titleLabel?.textColor = .blackColor()
        thirdView?.addToInnerView(segueToCool)
        view.addSubview(thirdView!)
    }
    
    func segue(sender : AnyObject){
            performSegueWithIdentifier("nextView", sender: nil)
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

