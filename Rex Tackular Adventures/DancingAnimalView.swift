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
    let largeBody = UIImageView()
    let head = UIImageView()
    var viewsByName: [String : UIView] = [:]
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 1136, height: 768))
    }

    func reset() {
        getNewAnimal()
        largeBody.image = getBodyImageFor(animal)
        largeBody.tintColor = animal.color
        footR.image = getFootImageFor(animal)
        footL.image = getFootImageFor(animal)
        head.image = getHeadImageFor(animal)
        addStandingAnimation()
    }

    func getNewAnimal() {
        animal = getRandomAnimal()
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
        
        getNewAnimal()
        footL.bounds = CGRect(x:0, y:0, width:464.0, height:406.0)
        let image = getFootImageFor(animal)
        footL.image = image
        footL.contentMode = .Center
        footL.layer.position = CGPoint(x:205.966, y:277.241)
        footL.transform = CGAffineTransformMakeScale(0.13, 0.13)
        self.addSubview(footL)
        viewsByName["FootL"] = footL


        footR.bounds = CGRect(x:0, y:0, width:464.0, height:406.0)
        footR.image = getFootImageFor(animal)
        footR.contentMode = .Center
        footR.tag = 1
        footR.layer.position = CGPoint(x:282.175, y:278.153)
        footR.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(3.14), -0.14, -0.14)
        self.addSubview(footR)
        viewsByName["FootR"] = footR


        largeBody.bounds = CGRect(x:0, y:0, width:1178.0, height:978.0)
        largeBody.layer.anchorPoint = CGPoint(x:0.497, y:0.481)

        largeBody.image = getBodyImageFor(animal)
        largeBody.contentMode = .Center
        largeBody.layer.position = CGPoint(x:249.257, y:185.372)
        largeBody.transform = CGAffineTransformMakeScale(1.5, 1.5)
        self.addSubview(largeBody)
        viewsByName["LargeBody"] = largeBody


        head.bounds = CGRect(x:0, y:0, width:80.0, height:80.0)
        head.image = getHeadImageFor(animal)
        head.contentMode = .Center
        head.layer.position = CGPoint(x:251.000, y:99.182)
        head.transform = CGAffineTransformMakeScale(2.78, 2.78)
        self.addSubview(head)
        viewsByName["Lion"] = head

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

        let largeBodyRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        largeBodyRotationAnimation.duration = 0.950
        largeBodyRotationAnimation.values = [0.000 as Float, 0.000 as Float, -0.035 as Float, -0.002 as Float]
        largeBodyRotationAnimation.keyTimes = [0.000 as Float, 0.174 as Float, 0.526 as Float, 1.000 as Float]
        largeBodyRotationAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        largeBodyRotationAnimation.repeatCount = HUGE
        largeBodyRotationAnimation.beginTime = beginTime
        largeBodyRotationAnimation.fillMode = fillMode
        largeBodyRotationAnimation.removedOnCompletion = removedOnCompletion
        self.viewsByName["LargeBody"]?.layer.addAnimation(largeBodyRotationAnimation, forKey:"Standing_Rotation")

        let largeBodyTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        largeBodyTranslationXAnimation.duration = 0.500
        largeBodyTranslationXAnimation.values = [0.000 as Float, 0.198 as Float, -1.000 as Float]
        largeBodyTranslationXAnimation.keyTimes = [0.000 as Float, 0.802 as Float, 1.000 as Float]
        largeBodyTranslationXAnimation.timingFunctions = [linearTiming, linearTiming]
        largeBodyTranslationXAnimation.repeatCount = HUGE
        largeBodyTranslationXAnimation.beginTime = beginTime
        largeBodyTranslationXAnimation.fillMode = fillMode
        largeBodyTranslationXAnimation.removedOnCompletion = removedOnCompletion
        self.viewsByName["LargeBody"]?.layer.addAnimation(largeBodyTranslationXAnimation, forKey:"Standing_TranslationX")

        let largeBodyTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        largeBodyTranslationYAnimation.duration = 1.000
        largeBodyTranslationYAnimation.values = [0.000 as Float, -3.010 as Float, -5.000 as Float, 0.000 as Float]
        largeBodyTranslationYAnimation.keyTimes = [0.000 as Float, 0.290 as Float, 0.500 as Float, 1.000 as Float]
        largeBodyTranslationYAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        largeBodyTranslationYAnimation.repeatCount = HUGE
        largeBodyTranslationYAnimation.beginTime = beginTime
        largeBodyTranslationYAnimation.fillMode = fillMode
        largeBodyTranslationYAnimation.removedOnCompletion = removedOnCompletion
        self.viewsByName["LargeBody"]?.layer.addAnimation(largeBodyTranslationYAnimation, forKey:"Standing_TranslationY")

        let lionRotationAnimation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        lionRotationAnimation.duration = 0.700
        lionRotationAnimation.values = [0.000 as Float, 0.004 as Float, -0.020 as Float, 0.004 as Float]
        lionRotationAnimation.keyTimes = [0.000 as Float, 0.537 as Float, 0.757 as Float, 1.000 as Float]
        lionRotationAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        lionRotationAnimation.repeatCount = HUGE
        lionRotationAnimation.beginTime = beginTime
        lionRotationAnimation.fillMode = fillMode
        lionRotationAnimation.removedOnCompletion = removedOnCompletion
        self.viewsByName["Lion"]?.layer.addAnimation(lionRotationAnimation, forKey:"Standing_Rotation")

        let lionTranslationXAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        lionTranslationXAnimation.duration = 0.680
        lionTranslationXAnimation.values = [0.000 as Float, 0.000 as Float, -1.000 as Float, 0.000 as Float]
        lionTranslationXAnimation.keyTimes = [0.000 as Float, 0.590 as Float, 0.779 as Float, 1.000 as Float]
        lionTranslationXAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        lionTranslationXAnimation.repeatCount = HUGE
        lionTranslationXAnimation.beginTime = beginTime
        lionTranslationXAnimation.fillMode = fillMode
        lionTranslationXAnimation.removedOnCompletion = removedOnCompletion
        self.viewsByName["Lion"]?.layer.addAnimation(lionTranslationXAnimation, forKey:"Standing_TranslationX")

        let lionTranslationYAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        lionTranslationYAnimation.duration = 0.680
        lionTranslationYAnimation.values = [0.000 as Float, 0.000 as Float, -2.000 as Float, 0.000 as Float]
        lionTranslationYAnimation.keyTimes = [0.000 as Float, 0.590 as Float, 0.779 as Float, 1.000 as Float]
        lionTranslationYAnimation.timingFunctions = [linearTiming, linearTiming, linearTiming]
        lionTranslationYAnimation.repeatCount = HUGE
        lionTranslationYAnimation.beginTime = beginTime
        lionTranslationYAnimation.fillMode = fillMode
        lionTranslationYAnimation.removedOnCompletion = removedOnCompletion
        self.viewsByName["Lion"]?.layer.addAnimation(lionTranslationYAnimation, forKey:"Standing_TranslationY")
    }

    func removeStandingAnimation() {
        self.viewsByName["FootR"]?.layer.removeAnimationForKey("Standing_TranslationY")
        self.viewsByName["LargeBody"]?.layer.removeAnimationForKey("Standing_Rotation")
        self.viewsByName["LargeBody"]?.layer.removeAnimationForKey("Standing_TranslationX")
        self.viewsByName["LargeBody"]?.layer.removeAnimationForKey("Standing_TranslationY")
        self.viewsByName["Lion"]?.layer.removeAnimationForKey("Standing_Rotation")
        self.viewsByName["Lion"]?.layer.removeAnimationForKey("Standing_TranslationX")
        self.viewsByName["Lion"]?.layer.removeAnimationForKey("Standing_TranslationY")
        self.animal = getRandomAnimal()
    }

}
