import Cocoa

protocol Exercise : CustomStringConvertible {
    var name: String { get }
    var caloriesBurned: Double { get }
    var minutes: Double { get }
    var title: String { get }
}

extension Exercise {
    var description: String {
        return "Exercise(\(name), burned \(caloriesBurned) calories in \(minutes) minutes)"
    }
    var title: String {
        return "\(name) - \(minutes) muntures"
    }
}

struct EllipticalWorkout:Exercise {
    let name = "Elliptical Workout"
    let caloriesBurned: Double
    let minutes: Double
}

let ellipticalWorkOut = EllipticalWorkout(caloriesBurned: 335, minutes: 30)

struct TreadmillWorkout: Exercise {
    let name = "Treadmill Workout"
    let caloriesBurned: Double
    let minutes: Double
    let laps: Double
}

extension TreadmillWorkout {
    var description: String {
        return "Treadmill(\(caloriesBurned) calories and \(laps) laps in \(minutes) minutes)"
    }
}

let runningWorkout = TreadmillWorkout(caloriesBurned: 350, minutes: 25, laps: 10.5)

extension Exercise {
    var caloriesBurnedPerMinute:Double {
        return caloriesBurned / minutes
    }
}


print(ellipticalWorkOut.caloriesBurnedPerMinute)
print(runningWorkout.caloriesBurnedPerMinute)

print(ellipticalWorkOut)
print(runningWorkout)

extension Sequence where Iterator.Element == Exercise {
    func totalCaloriesBurned() -> Double {
        var total: Double = 0
        for exercise in self {
            total += exercise.caloriesBurned
        }
        return total
    }
}

let mondayWorkout:[Exercise] = [ellipticalWorkOut, runningWorkout]
print(mondayWorkout.totalCaloriesBurned())

for exercise in mondayWorkout {
    print(exercise.title)
}
