# Layers

This app was designed to make a simple way to display data in seperate layers. These layers can be used to show a summary or the data on the next page or simply have the next page inside the layer.

##Start screen:

<a href="http://s357.photobucket.com/user/Zach_Eriksen/media/iOS%20Simulator%20Screen%20Shot%20Jun%2026%202015%2011.06.58%20AM_zps6o8lzntw.png.html" target="_blank"><img src="http://i357.photobucket.com/albums/oo13/Zach_Eriksen/iOS%20Simulator%20Screen%20Shot%20Jun%2026%202015%2011.06.58%20AM_zps6o8lzntw.png" border="0" alt=" photo iOS Simulator Screen Shot Jun 26 2015 11.06.58 AM_zps6o8lzntw.png"/></a>

##When you tap on a layer it will animate the ones above it to a minimized position and itself to it's maximized size:

<a href="http://s357.photobucket.com/user/Zach_Eriksen/media/iOS%20Simulator%20Screen%20Shot%20Jun%2026%202015%2011.07.01%20AM_zpso5qysjx5.png.html" target="_blank"><img src="http://i357.photobucket.com/albums/oo13/Zach_Eriksen/iOS%20Simulator%20Screen%20Shot%20Jun%2026%202015%2011.07.01%20AM_zpso5qysjx5.png" border="0" alt=" photo iOS Simulator Screen Shot Jun 26 2015 11.07.01 AM_zpso5qysjx5.png"/></a>

##You can also redirect to a new page inside the layer:

<a href="http://s357.photobucket.com/user/Zach_Eriksen/media/iOS%20Simulator%20Screen%20Shot%20Jun%2026%202015%2011.07.05%20AM_zps42pesy2t.png.html" target="_blank"><img src="http://i357.photobucket.com/albums/oo13/Zach_Eriksen/iOS%20Simulator%20Screen%20Shot%20Jun%2026%202015%2011.07.05%20AM_zps42pesy2t.png" border="0" alt=" photo iOS Simulator Screen Shot Jun 26 2015 11.07.05 AM_zps42pesy2t.png"/></a>

#To add a new layer: (Will simplify)

##Step 1:
```
let layerHeight : CGFloat = (UIScreen.mainScreen().bounds.height)/4
```
Change the number 4 (Number of current views) to what number of views you want

##Step 2:
```
class ViewController: UIViewController {
    var titleView : Layer?
    var firstView : Layer?
    var secondView : Layer?
    var thirdView : Layer?
    //Add new layer here
    ```
##Step 3:

In func createLayers()
```
 //create and store it in the var you made
 titleView = createLayer(purple, "Title")
 //add it to the view!
 view.addSubview(titleView!)
 ```
##Step 4:

In func addLayerHandlers()
```
   /*var name here*/?.addSubview(makeButton("/*var name here*/Pressed:"))
   ```
##Step 5: (Annoying will fix! :D)

Create func/selector with format:
```
  func /*var name here*/Pressed(sender: AnyObject){
        self.titleView?.animateBackToOriginalPosition()
        self.firstView?.animateBackToOriginalPosition()
        self.secondView?.animateBackToOriginalPosition()
        self.thirdView?.animateBackToOriginalPosition()
  }
 ``` 
  
