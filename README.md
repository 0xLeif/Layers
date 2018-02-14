# Layers

This app was designed to make a simple way to display data in seperate layers. These layers can be used to show a summary or the data on the next page or simply have the next page inside the layer.


##When you tap on a layer it will animate the ones above it to a minimized position and itself to it's maximized size:

##You can also redirect to a new page inside the layer:

#To add a new layer:

##Step 1:

```
var handler = LayerHandler() //Will default to fullscreen
handler.frame = frame
```
or
```
var handler = LayerHandler(frame: frame)
```

##Step 2:

```
handler.addLayer(color, title: "title")
```

##Step 3:

While adding layer you can add InnerViews
```
handler.addLayer(blue, title: "First").addToInnerView({
            let label = UILabel(frame: CGRectMake(20, 40, 100, 40))
            label.text = "Inside the First view!"
            label.sizeToFit()
            return label
        })
```

or

You can search for the layer by the title
```
handler.layerWithTitle("Second")?.addToInnerView({
            let buttonSegue = UIButton(frame: CGRectMake(30, 50, screenWidth-60, 50))
            buttonSegue.setTitle("Next", forState: UIControlState.Normal)
            buttonSegue.addTarget(self, action: "segue:", forControlEvents: .TouchUpInside)
            buttonSegue.titleLabel?.textAlignment = .Center
            buttonSegue.titleLabel?.textColor = .blackColor()
            return buttonSegue
        })
```
##Step 4:

```
view.addSubview(handler)
```

#License
MIT License

Copyright (c) 2015, Zach Eriksen All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
