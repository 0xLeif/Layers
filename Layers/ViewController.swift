
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
    }
    
    func delete(){
        if handler.layers.count > 0 {
            let layerName = handler.layers[0].label!.text
            handler.removeLayerWithTitle(layerName!)
        }
    }
    
    func add() -> Layer?{
        func randomColor() -> UIColor{
            let red = arc4random_uniform(255)
            let blue = arc4random_uniform(255)
            let green = arc4random_uniform(255)
            return UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1)
        }
        return handler.addLayer(randomColor(), title: "\(arc4random_uniform(100))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: false)
    }
    
    func createLayers(){
        handler.addLayer(purple, title: "Title")
        handler.addLayer(blue, title: "Plan")
        handler.addLayer(lightGreen, title: "Budget")?.addToInnerView({
            let buttonSegue = UIButton(frame: CGRect(x: 30, y: 50, width: self.handler.layerWithTitle("Budget")!.frame.width-60, height: 50))
            buttonSegue.setTitle("Next", for: UIControlState())
            buttonSegue.addTarget(self, action: #selector(ViewController.segue(_:)), for: .touchUpInside)
            buttonSegue.titleLabel?.textAlignment = .center
            buttonSegue.titleLabel?.textColor = .black
            return buttonSegue
        })
        handler.addLayer(darkGreen, title: "Vehicles")
        handler.addLayer(UIColor(red: 200/255, green: 100/255, blue: 100/255, alpha: 1), title: "Definitions")
    }
    
    func segue(_ sender : AnyObject){
            performSegue(withIdentifier: "nextView", sender: nil)
            navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
