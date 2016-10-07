//
//  DancingAnimalView.swift
//  Rex Tackular Adventures
//
//  Created by P D Leonard on 8/12/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//
import UIKit

class DancingAnimalView : UIView {
    var animal = getRandomAnimal()
    let footR = UIImageView()
    let footL = UIImageView()
    let body = UIImageView()
    let head = UIImageView()
    var viewsByName: [String : UIView] = [:]
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 250, height: 283))
        setupDancingAnimal()
    }
    
    func reset() {
        animal = getRandomAnimal()
        body.image = getBodyImageFor(animal: animal)
        body.tintColor = animal.color
        footR.image = getFootImageFor(animal: animal)
        footL.image = getFootImageFor(animal: animal)
        head.image = getHeadImageFor(animal: animal)
        addStandingAnimation()
    }

    func getThisAnimalDancing(dissOne: Animal) {
        animal = dissOne
        body.image = getBodyImageFor(animal: animal)
        body.tintColor = animal.color
        footR.image = getFootImageFor(animal: animal)
        footL.image = getFootImageFor(animal: animal)
        head.image = getHeadImageFor(animal: animal)
        addStandingAnimation()
        print("Getting this animal named: ", animal.name)
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
            guard let theImage = UIImage(named: "FelineBody")?.withRenderingMode(.alwaysTemplate) else { assertionFailure("No FelineBody Image for \(animal.name)"); return UIImage() }
            return theImage
        default:
            guard let theImage = UIImage(named: "LargeBody")?.withRenderingMode(.alwaysTemplate) else { assertionFailure("No Image for LargBody")
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

        footR.bounds = CGRect(x:0, y:0, width:464.0, height:406.0)
        footL.bounds = CGRect(x:0, y:0, width:464.0, height:406.0)
        body.bounds  = CGRect(x:0, y:0, width:1178.0, height:978.0)
        head.bounds  = CGRect(x:0, y:0, width:80.0, height:80.0)

        footL.contentMode = .center
        footR.contentMode = .center
        body.contentMode  = .center
        head.contentMode  = .center

        body.layer.anchorPoint = CGPoint(x:0.497, y:0.481)

        //Position
        footR.layer.position = CGPoint(x:162.175, y:258.153)
        footL.layer.position = CGPoint(x:85.966, y:257.241)
        body.layer.position = CGPoint(x:128.561, y:165.372)
        head.layer.position = CGPoint(x:130.000, y:79.182)

        //Image
        footL.image = getFootImageFor(animal: animal)
        footR.image = getFootImageFor(animal: animal)
        body.image  = getBodyImageFor(animal: animal)
        head.image  = getHeadImageFor(animal: animal)

        // Scale
        body.transform  = CGAffineTransform(scaleX: 1.8, y: 1.8)
        footR.transform = CGAffineTransform(rotationAngle: 3.14).scaledBy(x: -0.14, y: -0.14)
        footL.transform = CGAffineTransform(scaleX: 0.13, y: 0.13)
        head.transform  = CGAffineTransform(scaleX: 2.78, y: 2.78)

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
        addStandingAnimationWithBeginTime(beginTime: 0, fillMode: kCAFillModeBoth, removedOnCompletion: false)
    }

    func addStandingAnimation(removedOnCompletion: Bool) {
        addStandingAnimationWithBeginTime(beginTime: 0, fillMode: removedOnCompletion ? kCAFillModeRemoved : kCAFillModeBoth, removedOnCompletion: removedOnCompletion)
    }

    func addStandingAnimationWithBeginTime(beginTime: CFTimeInterval, fillMode: String, removedOnCompletion: Bool) {

        let linearTiming = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)

        let footRTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        footRTranslationYAnimation.duration = 1.150
        footRTranslationYAnimation.values = [0.000 as Float, -10.000 as Float, 0.000 as Float]
        footRTranslationYAnimation.keyTimes = [0, 0.348, 1]
        footRTranslationYAnimation.timingFunctions = [linearTiming, linearTiming]
        footRTranslationYAnimation.repeatCount = HUGE
        footRTranslationYAnimation.beginTime = beginTime
        footRTranslationYAnimation.fillMode = fillMode
        footRTranslationYAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["FootR"]?.layer.add(footRTranslationYAnimation, forKey:"Standing_TranslationY")

        let bodyRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        bodyRotationAnimation.duration = 0.950
        bodyRotationAnimation.values = [0.000 as Float, 0.000 as Float, -0.035 as Float, -0.002 as Float]
        bodyRotationAnimation.keyTimes =  [0, 0.174, 1]
        bodyRotationAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        bodyRotationAnimation.repeatCount = HUGE
        bodyRotationAnimation.beginTime = beginTime
        bodyRotationAnimation.fillMode = fillMode
        bodyRotationAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["body"]?.layer.add(bodyRotationAnimation, forKey:"Standing_Rotation")

        let bodyTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        bodyTranslationXAnimation.duration = 0.500
        bodyTranslationXAnimation.values = [0.000 as Float, 0.198 as Float, -1.000 as Float]
        bodyTranslationXAnimation.keyTimes = [0, 0.802, 1]
        bodyTranslationXAnimation.timingFunctions = [linearTiming, linearTiming]
        bodyTranslationXAnimation.repeatCount = HUGE
        bodyTranslationXAnimation.beginTime = beginTime
        bodyTranslationXAnimation.fillMode = fillMode
        bodyTranslationXAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["body"]?.layer.add(bodyTranslationXAnimation, forKey:"Standing_TranslationX")

        let bodyTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        bodyTranslationYAnimation.duration = 1.000
        bodyTranslationYAnimation.values = [0.000 as Float, -3.010 as Float, -5.000 as Float, 0.000 as Float]
        bodyTranslationYAnimation.keyTimes = [0, 0.500, 1]
        bodyTranslationYAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        bodyTranslationYAnimation.repeatCount = HUGE
        bodyTranslationYAnimation.beginTime = beginTime
        bodyTranslationYAnimation.fillMode = fillMode
        bodyTranslationYAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["body"]?.layer.add(bodyTranslationYAnimation, forKey:"Standing_TranslationY")

        let HeadRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        HeadRotationAnimation.duration = 0.700
        HeadRotationAnimation.values = [0.000 as Float, 0.004 as Float, -0.020 as Float, 0.004 as Float]
        HeadRotationAnimation.keyTimes = [0, 0.537, 0.757, 1]
        HeadRotationAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        HeadRotationAnimation.repeatCount = HUGE
        HeadRotationAnimation.beginTime = beginTime
        HeadRotationAnimation.fillMode = fillMode
        HeadRotationAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["Head"]?.layer.add(HeadRotationAnimation, forKey:"Standing_Rotation")

        let HeadTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        HeadTranslationXAnimation.duration = 0.680
        HeadTranslationXAnimation.values = [0.000 as Float, 0.000 as Float, -1.000 as Float, 0.000 as Float]
        HeadTranslationXAnimation.keyTimes = [0, 0.590, 0.779, 1]
        HeadTranslationXAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        HeadTranslationXAnimation.repeatCount = HUGE
        HeadTranslationXAnimation.beginTime = beginTime
        HeadTranslationXAnimation.fillMode = fillMode
        HeadTranslationXAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["Head"]?.layer.add(HeadTranslationXAnimation, forKey:"Standing_TranslationX")

        let HeadTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        HeadTranslationYAnimation.duration = 0.680
        HeadTranslationYAnimation.values = [0.000 as Float, 0.000 as Float, -2.000 as Float, 0.000 as Float]
        HeadTranslationYAnimation.keyTimes = [0, 0.590, 0.779, 1]
        HeadTranslationYAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        HeadTranslationYAnimation.repeatCount = HUGE
        HeadTranslationYAnimation.beginTime = beginTime
        HeadTranslationYAnimation.fillMode = fillMode
        HeadTranslationYAnimation.isRemovedOnCompletion = removedOnCompletion
        self.viewsByName["Head"]?.layer.add(HeadTranslationYAnimation, forKey:"Standing_TranslationY")
    }

    func removeStandingAnimation() {
        self.viewsByName["FootR"]?.layer.removeAnimation(forKey: "Standing_TranslationY")
        self.viewsByName["body"]?.layer.removeAnimation(forKey: "Standing_Rotation")
        self.viewsByName["body"]?.layer.removeAnimation(forKey: "Standing_TranslationX")
        self.viewsByName["body"]?.layer.removeAnimation(forKey: "Standing_TranslationY")
        self.viewsByName["Head"]?.layer.removeAnimation(forKey: "Standing_Rotation")
        self.viewsByName["Head"]?.layer.removeAnimation(forKey: "Standing_TranslationX")
        self.viewsByName["Head"]?.layer.removeAnimation(forKey: "Standing_TranslationY")
    }

}
