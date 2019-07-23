# PicSnapping

## Architecture
<img src="https://github.com/shunhuaiyao/PicSnapping/blob/master/architecture.png">

* Model  
  
  We have two structures:
  * _Canvas_ that contains own id, view, and all pictures on the canvas.
  * _Picture_ that contains own id, and image view.

* View  
  
  UI rendered by ViewController. It allows user to interact with views.

* Controller  
  
  We have a ViewController as a mediator between Model and View:
  * _Handle Pan Gesture_: Handles pan gesture from View, and then updates views' frame.
  * _Auto-alignment_: When the action is considered to align moving picture to nearby pictures, _Auto-alignment_ will call _Get Anchors from Other Pictures_, and then set the moving picture to an anchor position.
  * _Get Anchors from Other Pictures_: Gets possible anchors from Model.

In this way, we can keep all the pictures' frame in Model, and easily get possible anchor points through Controller.

## Snapping Rules
* When the velocity of the moving picture is lower than the minimum velocity threshold we define, the intention of the action will be regarded as aligning the moving picture to some positions.
* We then get the nearest possible anchor position from other static pictures.
* Check if the nearest possible anchor position is close enough to the minimum distance threshold we define. If yes, we set the position of the moving picture to the anchor position.

## How to Utilize Snapping Rules and Data Structures
We use an array of Struct Canvas to store all Struct Pictures on the canvas. First, when we start aligning the picture, we fetch possible X and Y anchor points from other pictures on the canvas. From each X and Y anchor candidates, we select the nearest X and Y anchor points that are close enough to the center of the moving picture. If the nearest X and Y points exist, we set the center of the moving picture to the points.
