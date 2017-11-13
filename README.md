# IHTypeWriterLabel
A simple, UILabel subclass which poulates itself as if being typed. 

# HighLights
Written purely in SWIFT. Very simple and lightweight. Hardly 119 lines of Code. Works with both Auto Layout as well as as constraint based layouts.

# Getting Started

To begin using IHTypeWriterLabel you must first make sure you have the proper build requirements.

# Build Requirements

## iOS

8.0+

# Adding To Project

You can add IHTypeWriterLabel to your project in a few ways: 

The way to use IHTypeWriterLabel is to download the IHTypeWriterLabel class file in your project as is and use.

# ScreenShot
![labeldemo](https://user-images.githubusercontent.com/16992520/32742620-01b9cc32-c8d0-11e7-861f-6b01819cabf3.gif)
# Usage

## StoryBoard

Make the UIView a subclass of IHTypeWriterLabel, make its outlet and initialise or do it on the go in the Interface builder. :

# StoryBoard SetUp
![screen shot 2017-11-13 at 11 40 15 pm](https://user-images.githubusercontent.com/16992520/32741540-92d1509a-c8cc-11e7-9ef7-c9944d43dda2.png)

#Programatic setUp WithOut Constraints

    let ihLabel = IHTypeWriterLabel.init(frame: CGRect.init(x: 0, y: 100, width: 200, height: 300))
    self.view.addSubview(ihLabel)
    ihLabel.animationDuration = 5.0
    ihLabel.text = "Hello. Hope you like this implementation. Happy Coding. Have a nice day. Thank you. :)"
    ihLabel.numberOfLines = 0
        
