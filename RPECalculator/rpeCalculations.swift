//
//  rpeCalculations.swift
//  RPECalculator
//
//  Created by michele Miller on 11/07/17.
//
//

import Foundation

class rpeMax: NSObject{
    var oneRepMax: Double = 0
    var reps: Double = 0
    var rpe: Double = 0
    let rpeScale = rpeScales()
    
    func calculateDesiredWeight() -> Double{
        let index = (((10 - rpe) + reps) - 1)
        let rtsMultiplier = rpeScale.rtsScaleDic[index]!
        print("One rep max: \(oneRepMax) for \(reps) reps @ \(rpe) rpe which is a \(rtsMultiplier) multiplier = \(oneRepMax * rtsMultiplier)")
        let roundedWeight = roundWeight(weight: oneRepMax*rtsMultiplier)
        return (roundedWeight)
    }
    
    func calculateOneRepMax(weight: Double, completedReps: Double, atRpe: Double){
        print("Old oneRepMax \(oneRepMax)")
        let index = (((10 - atRpe) + completedReps) - 1)
        let rtsMultiplier = rpeScale.rtsScaleDic[index]
        let tempOneRepMax = weight / rtsMultiplier!
        oneRepMax = roundWeight(weight: tempOneRepMax)
        print("New oneRepMax: \(oneRepMax)")
    }
    
    func roundWeight(weight: Double) -> Double{
        let rounding = UserDefaults.standard.double(forKey: "rounding")
        let roundingDirection = UserDefaults.standard.string(forKey: "roundingDirection")
        let roundedWeight = weight.rounded(viaRoundingNumber: rounding, direction: roundingDirection!)
        print("Original Weight \(weight) vs Rounded Weight \(roundedWeight)")
        return roundedWeight
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(viaRoundingNumber number:Double, direction: String) -> Double {
        if(number <= 0){
            return self
        }
        let mod = Int(self/number)
        let baseNumber = Double(mod) * number
        if(baseNumber == self){
            return self
        }
        if(direction == "UP"){
            return baseNumber + number
        }else if(direction == "DOWN"){
            return baseNumber
        }
        
        if(self - baseNumber < number/2){
            return baseNumber
        }else{
            return baseNumber + number
        }
    }
}


struct rpeScales{
    let rtsScale = [1, 0.98, 0.96, 0.94, 0.92, 0.91, 0.89, 0.88, 0.86, 0.85, 0.84, 0.82, 0.81, 0.80, 0.79, 0.77, 0.76, 0.75, 0.74, 0.72, 0.71, 0.69, 0.68, 0.67, 0.65]
    //Reps Left vs RTS Mutliplier
    var rtsScaleDic: [Double : Double] = [
        0:1,
        0.5:0.98,
        1:0.96,
        1.5:0.94,
        2:0.92,
        2.5:0.91,
        3:0.89,
        3.5:0.88,
        4:0.86,
        4.5:0.85,
        5:0.85,
        5.5:0.84,
        6:0.82,
        6.5:0.81,
        7:0.80,
        7.5:0.79,
        8:0.77,
        8.5:0.76,
        9:0.75,
        9.5:0.74,
        10:0.72,
        10.5:0.71,
        11:0.69,
        11.5:0.68,
        12:0.67,
        12.5:0.65]
    
}






