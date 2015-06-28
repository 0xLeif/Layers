# Layers

This app was designed to make a simple way to display data in seperate layers. These layers can be used to show a summary or the data on the next page or simply have the next page inside the layer.

##Start screen:

<a href="http://s357.photobucket.com/user/Zach_Eriksen/media/iOS%20Simulator%20Screen%20Shot%20Jun%2026%202015%2011.06.58%20AM_zps6o8lzntw.png.html" target="_blank"><img src="http://i357.photobucket.com/albums/oo13/Zach_Eriksen/iOS%20Simulator%20Screen%20Shot%20Jun%2026%202015%2011.06.58%20AM_zps6o8lzntw.png" border="0" alt=" photo iOS Simulator Screen Shot Jun 26 2015 11.06.58 AM_zps6o8lzntw.png"/></a>

##When you tap on a layer it will animate the ones above it to a minimized position and itself to it's maximized size:

<a href="http://s357.photobucket.com/user/Zach_Eriksen/media/iOS%20Simulator%20Screen%20Shot%20Jun%2026%202015%2011.07.01%20AM_zpso5qysjx5.png.html" target="_blank"><img src="http://i357.photobucket.com/albums/oo13/Zach_Eriksen/iOS%20Simulator%20Screen%20Shot%20Jun%2026%202015%2011.07.01%20AM_zpso5qysjx5.png" border="0" alt=" photo iOS Simulator Screen Shot Jun 26 2015 11.07.01 AM_zpso5qysjx5.png"/></a>

##You can also redirect to a new page inside the layer:

<a href="http://s357.photobucket.com/user/Zach_Eriksen/media/iOS%20Simulator%20Screen%20Shot%20Jun%2026%202015%2011.07.05%20AM_zps42pesy2t.png.html" target="_blank"><img src="http://i357.photobucket.com/albums/oo13/Zach_Eriksen/iOS%20Simulator%20Screen%20Shot%20Jun%2026%202015%2011.07.05%20AM_zps42pesy2t.png" border="0" alt=" photo iOS Simulator Screen Shot Jun 26 2015 11.07.05 AM_zps42pesy2t.png"/></a>

#To add a new layer:

##Step 1:

In func createLayers()
```
layers.addLayer(/*UIColor*/, title: "title")
```

##Step 2:

While adding layer you can add InnerViews
```
layers.addLayer(blue, title: "First").addToInnerView({
            let label = UILabel(frame: CGRectMake(20, 40, 100, 40))
            label.text = "Inside the First view!"
            label.sizeToFit()
            return label
        })
```

or

You can search for the layer by the title
```
layers.layerWithTitle("Second")?.addToInnerView({
            let buttonSegue = UIButton(frame: CGRectMake(30, 50, screenWidth-60, 50))
            buttonSegue.setTitle("Next", forState: UIControlState.Normal)
            buttonSegue.addTarget(self, action: "segue:", forControlEvents: .TouchUpInside)
            buttonSegue.titleLabel?.textAlignment = .Center
            buttonSegue.titleLabel?.textColor = .blackColor()
            return buttonSegue
        })
```


#License
MIT License

Copyright (c) 2015, Zach Eriksen All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
