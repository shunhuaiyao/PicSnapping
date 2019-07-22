//
//  ViewController.swift
//  PicSnapping
//
//  Created by Yao Shun-Huai on 2019/7/21.
//  Copyright © 2019 Yao Shun-Huai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: UIView!
    let minThreshold = CGFloat(5)
    var canvas: Canvas?
    var tableImage: Picture?
    var clockImage: Picture?
    var clock2Image: Picture?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addMockData()
    }
    func addMockData() {
        // add table image
        tableImage = createPicture(name: "table.png", frame: CGRect(x: 0, y: 0, width: 250, height: 125))
        addPanGesture(view: tableImage!.imageView)
        // add clock image
        clockImage = createPicture(name: "clock.png", frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        addPanGesture(view: clockImage!.imageView)
        // add clock image
        clock2Image = createPicture(name: "clock.png", frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        addPanGesture(view: clock2Image!.imageView)
        // add table and clocks into canvas
        canvas = Canvas(id: UUID(), pictures: Array([tableImage, clockImage, clock2Image]))
    }
    func createPicture(name: String, frame: CGRect) -> Picture{
        let imageView = UIImageView(image: UIImage(named: name))
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        canvasView.addSubview(imageView)
        return Picture(id: UUID(), imageView: imageView)
    }
    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanGesture(sender:)))
        view.addGestureRecognizer(pan)
    }

}

