//
//  ViewControllerExtension.swift
//  PicSnapping
//
//  Created by Yao Shun-Huai on 2019/7/22.
//  Copyright © 2019 Yao Shun-Huai. All rights reserved.
//
import UIKit
import Foundation

extension ViewController {
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        let fileView = sender.view!
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: fileView, sender: sender)
        default:
            break
        }
    }
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        guard abs(velocity.x) > minVelocityThreshold || abs(velocity.y) > minVelocityThreshold else {
            snapping(view: view, sender: sender)
            return
        }
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    func snapping(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        var xAnchors = getAnchors(view: view, axis: "X")
        var yAnchors = getAnchors(view: view, axis: "Y")
        // check if there are other images on canvas
        guard xAnchors.count > 0 && yAnchors.count > 0 else {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
            return
        }
        // get the closest xAnchor
        xAnchors = xAnchors.filter { (i) -> Bool in
            return distance(x: view.center.x, y: i!) < minDistanceThreshold
        }
        // get the closest yAnchor
        yAnchors = yAnchors.filter { (i) -> Bool in
            return distance(x: view.center.y, y: i!) < minDistanceThreshold
        }
        // set view center to anchor point
        if let xAnchor = xAnchors.first, let yAnchor = yAnchors.first {
            view.center = CGPoint(x: xAnchor!, y: yAnchor!)
        } else if let xAnchor = xAnchors.first {
            view.center = CGPoint(x: xAnchor!, y: view.center.y + translation.y)
        } else if let yAnchor = yAnchors.first{
            view.center = CGPoint(x: view.center.x + translation.x, y: yAnchor!)
        } else {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        sender.setTranslation(CGPoint.zero, in: view)
    }
    func getAnchors(view: UIView, axis: String) -> [CGFloat?]{
        var anchors = [CGFloat?]()
        guard let allPictures = canvas?.pictures else {
            return anchors
        }
        for picture in allPictures {
            if view != picture!.imageView {
                if axis == "X" {
                    anchors.append(picture!.imageView.center.x)
                    anchors.append(picture!.imageView.center.x + picture!.imageView.frame.width/2 + view.frame.width/2)
                    anchors.append(picture!.imageView.center.x - picture!.imageView.frame.width/2 - view.frame.width/2)
                } else {
                    anchors.append(picture!.imageView.center.y)
                    anchors.append(picture!.imageView.center.y + picture!.imageView.frame.height/2 + view.frame.height/2)
                    anchors.append(picture!.imageView.center.y - picture!.imageView.frame.height/2 - view.frame.height/2)
                }
            }
        }
        return anchors
    }
    func distance(x: CGFloat, y: CGFloat) -> CGFloat {
        return abs(x-y)
    }
}
