//
//  RealmManager.swift
//  WorkOut
//
//  Created by d vasylenko on 17.04.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    private init() {}
    let localRealm = try! Realm()
    func saveWorkoutModel(model: WorkoutModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteWorkoutModel(model: WorkoutModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func updateSetsRepsWorkoutModel(model: WorkoutModel, sets: Int, reps: Int) {
        try! localRealm.write {
            model.workoutSets = sets
            model.workoutReps = reps
        }
    }
    
    func updateStatusWorkoutModel(model: WorkoutModel) {
        try! localRealm.write {
            model.workoutStatus = true
        }
    }
}
