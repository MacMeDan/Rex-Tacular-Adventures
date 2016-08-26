//
//  DancingAnimalView.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 8/12/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//
import UIKit

class DancingAnimalView : UIView {
    var animal: Animal!
    let footR = UIImageView()
    let footL = UIImageView()
    let body = UIImageView()
    let head = UIImageView()
    var viewsByName: [String : UIView] = [:]
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 1136, height: 768))
        setupDancingAnimal()
    }
    
    func reset() {
        getNewAnimal()
        body.image = getBodyImageFor(animal)
        body.tintColor = animal.color
        footR.image = getFootImageFor(animal)
        footL.image = getFootImageFor(animal)
        head.image = getHeadImageFor(animal)
        addStandingAnimation()
    }

    func getNewAnimal() {
        animal = getRandomAnimal()
        print(animal.name)
    }

    //Image Helpers

    func getFootImageFor(animal: Animal) -> UIImage {
        switch animal.type {
        case .feline:
            guard let theImage = UIImage(named: "FelineFoot") else { assertionFailure("No FelineFoot Image for \(animal.name)"); return UIImage() }
            return theImage
        default:
            guard let theImage = UIImage(named: "Foot") else { assertionFailure("No Image for \(animal.name)Foot")
                return UIImage()
            }
            return theImage
        }
    }

    func getBodyImageFor(animal: Animal) -> UIImage {
        switch animal.type {
        case .feline:
            guard let theImage = UIImage(named: "FelineBody") else { assertionFailure("No FelineBody Image for \(animal.name)"); return UIImage() }
            return theImage
        default:
            guard let theImage = UIImage(named: "LargeBody") else { assertionFailure("No Image for LargBody")
                return UIImage()
            }
            return theImage
        }
    }

    func getHeadImageFor(animal: Animal) -> UIImage {
        if let image = UIImage(named: "\(animal.name)") {
            return image
        } else { return UIImage() }
    }

    func getArmImageFor(animal: Animal) -> UIImage {
        guard let image = UIImage(named: "\(animal.name)Arm") else { assertionFailure("No Image for \(animal.name)Arm"); return UIImage() }
        return image
    }

    func setupDancingAnimal() {
        let yOffset: CGFloat = 300
        let xOffset: CGFloat = 200

        getNewAnimal()

        footR.bounds = CGRect(x:0, y:0, width:464.0, height:406.0)
        footL.bounds = CGRect(x:0, y:0, width:464.0, height:406.0)
        body.bounds  = CGRect(x:0, y:0, width:1178.0, height:978.0)
        head.bounds  = CGRect(x:0, y:0, width:80.0, height:80.0)

        footL.contentMode = .Center
        footR.contentMode = .Center
        body.contentMode  = .Center
        head.contentMode  = .Center

        body.layer.anchorPoint = CGPoint(x:0.497, y:0.481)

        //Position
        footR.layer.position = CGPoint(x: xOffset + 82.175, y: yOffset + 188.153)
        footL.layer.position = CGPoint(x: xOffset + 5.966, y: yOffset + 187.241)
        body.layer.position  = CGPoint(x: xOffset + 49.257, y: yOffset + 85.372)
        head.layer.position  = CGPoint(x: xOffset + 51.000, y: yOffset - 1.9)

        //Image
        footL.image = getFootImageFor(animal)
        footR.image = getFootImageFor(animal)
        body.image  = getBodyImageFor(animal)
        head.image  = getHeadImageFor(animal)

        // Scale
        body.transform  = CGAffineTransformMakeScale(1.8, 1.8)
        footR.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(3.14), -0.14, -0.14)
        footL.transform = CGAffineTransformMakeScale(0.13, 0.13)
        head.transform  = CGAffineTransformMakeScale(2.78, 2.78)

        // adding to the view

        self.addSubview(body)
        self.addSubview(footL)
        self.addSubview(footR)
        self.addSubview(head)

        viewsByName["FootL"] = footL
        viewsByName["FootR"] = footR
        viewsByName["body"] = body
        viewsByName["Head"] = head
    }

    // - MARK: Standing

    func addStandingAnimation() {
        addStandingAnimationWithBeginTime(0, fillMode: kCAFillModeBoth, removedOnCompletion: false)
    }

    func addStandingAnimation(removedOnCompletion removedOnCompletion: Bool) {
        addStandingAnimationWithBeginTime(0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion)
    }

    func addStandingAnimationWithBeginTime(beginTime: CFTimeInterval, fillMode: String, removedOnCompletion: Bool) {

        let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)

        let footRTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        footRTranslationYAnimation.duration = 1.150
        footRTranslationYAnimation.values = [0.000 as Float, -10.000 as Float, 0.000 as Float]
        footRTranslationYAnimation.keyTimes = [0.000 as Float, 0.348 as Float, 1.000 as Float]
        footRTranslationYAnimation.timingFunctions = [linearTiming, linearTiming]
        footRTranslationYAnimation.repeatCount = HUGE
        footRTranslationYAnimation.beginTime = beginTime
        footRTranslationYAnimation.fillMode = fillMode
        footRTranslationYAnimation.removedOnCompletion = removedOnCompletion
        self.viewsByName["FootR"]?.layer.addAnimation(footRTranslationYAnimation, forKey:"Standing_TranslationY")

        let bodyRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        bodyRotationAnimation.duration = 0.950
        bodyRotationAnimation.values = [0.000 as Float, 0.000 as Float, -0.035 as Float, -0.002 as Float]
        bodyRotationAnimation.keyTimes = [0.000 as Float, 0.174 as Float, 0.526 as Float, 1.000 as Float]
        bodyRotationAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        bodyRotationAnimation.repeatCount = HUGE
        bodyRotationAnimation.beginTime = beginTime
        bodyRotationAnimation.fillMode = fillMode
        bodyRotationAnimation.removedOnCompletion = removedOnCompletion
        self.viewsByName["body"]?.layer.addAnimation(bodyRotationAnimation, forKey:"Standing_Rotation")

        let bodyTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        bodyTranslationXAnimation.duration = 0.500
        bodyTranslationXAnimation.values = [0.000 as Float, 0.198 as Float, -1.000 as Float]
        bodyTranslationXAnimation.keyTimes = [0.000 as Float, 0.802 as Float, 1.000 as Float]
        bodyTranslationXAnimation.timingFunctions = [linearTiming, linearTiming]
        bodyTranslationXAnimation.repeatCount = HUGE
        bodyTranslationXAnimation.beginTime = beginTime
        bodyTranslationXAnimation.fillMode = fillMode
        bodyTranslationXAnimation.removedOnCompletion = removedOnCompletion
        self.viewsByName["body"]?.layer.addAnimation(bodyTranslationXAnimation, forKey:"Standing_TranslationX")

        let bodyTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        bodyTranslationYAnimation.duration = 1.000
        bodyTranslationYAnimation.values = [0.000 as Float, -3.010 as Float, -5.000 as Float, 0.000 as Float]
        bodyTranslationYAnimation.keyTimes = [0.000 as Float, 0.290 as Float, 0.500 as Float, 1.000 as Float]
        bodyTranslationYAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        bodyTranslationYAnimation.repeatCount = HUGE
        bodyTranslationYAnimation.beginTime = beginTime
        bodyTranslationYAnimation.fillMode = fillMode
        bodyTranslationYAnimation.removedOnCompletion = removedOnCompletion
        self.viewsByName["body"]?.layer.addAnimation(bodyTranslationYAnimation, forKey:"Standing_TranslationY")

        let HeadRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        HeadRotationAnimation.duration = 0.700
        HeadRotationAnimation.values = [0.000 as Float, 0.004 as Float, -0.020 as Float, 0.004 as Float]
        HeadRotationAnimation.keyTimes = [0.000 as Float, 0.537 as Float, 0.757 as Float, 1.000 as Float]
        HeadRotationAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        HeadRotationAnimation.repeatCount = HUGE
        HeadRotationAnimation.beginTime = beginTime
        HeadRotationAnimation.fillMode = fillMode
        HeadRotationAnimation.removedOnCompletion = removedOnCompletion
        self.viewsByName["Head"]?.layer.addAnimation(HeadRotationAnimation, forKey:"Standing_Rotation")

        let HeadTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        HeadTranslationXAnimation.duration = 0.680
        HeadTranslationXAnimation.values = [0.000 as Float, 0.000 as Float, -1.000 as Float, 0.000 as Float]
        HeadTranslationXAnimation.keyTimes = [0.000 as Float, 0.590 as Float, 0.779 as Float, 1.000 as Float]
        HeadTranslationXAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        HeadTranslationXAnimation.repeatCount = HUGE
        HeadTranslationXAnimation.beginTime = beginTime
        HeadTranslationXAnimation.fillMode = fillMode
        HeadTranslationXAnimation.removedOnCompletion = removedOnCompletion
        self.viewsByName["Head"]?.layer.addAnimation(HeadTranslationXAnimation, forKey:"Standing_TranslationX")

        let HeadTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        HeadTranslationYAnimation.duration = 0.680
        HeadTranslationYAnimation.values = [0.000 as Float, 0.000 as Float, -2.000 as Float, 0.000 as Float]
        HeadTranslationYAnimation.keyTimes = [0.000 as Float, 0.590 as Float, 0.779 as Float, 1.000 as Float]
        HeadTranslationYAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        HeadTranslationYAnimation.repeatCount = HUGE
        HeadTranslationYAnimation.beginTime = beginTime
        HeadTranslationYAnimation.fillMode = fillMode
        HeadTranslationYAnimation.removedOnCompletion = removedOnCompletion
        self.viewsByName["Head"]?.layer.addAnimation(HeadTranslationYAnimation, forKey:"Standing_TranslationY")
    }

    func removeStandingAnimation() {
        self.viewsByName["FootR"]?.layer.removeAnimationForKey("Standing_TranslationY")
        self.viewsByName["body"]?.layer.removeAnimationForKey("Standing_Rotation")
        self.viewsByName["body"]?.layer.removeAnimationForKey("Standing_TranslationX")
        self.viewsByName["body"]?.layer.removeAnimationForKey("Standing_TranslationY")
        self.viewsByName["Head"]?.layer.removeAnimationForKey("Standing_Rotation")
        self.viewsByName["Head"]?.layer.removeAnimationForKey("Standing_TranslationX")
        self.viewsByName["Head"]?.layer.removeAnimationForKey("Standing_TranslationY")
        self.animal = getRandomAnimal()
    }

}
