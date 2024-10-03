//
//  HealthManager.swift
//  FitnessApp
//
//  Created by Nick van Tilburg on 30/9/2024.
//

import Foundation
import HealthKit


// extension of the Date class
extension Date {
    // computed property that returns the start of the current day (i.e. midnight) for the current date and users timezone
    static var startOfDay: Date {
        let calendar = Calendar.current
        // Date() gets today's date
        return calendar.startOfDay(for: Date())
    }
}

class HealthManager {
    
    // create a singleton of the HealthManager so there exists only one instance of the class
    // this is done by:
        // 1. static global access point (shared)
        // 2. private initialiser
    
    // static means the property belongs to the class rather than an instance of it
    // this ensures that shared is a single class-wide instance that can be accessed from anywhere
    static let shared = HealthManager()
    
    // the main interface for interacting with HealthKit data
    let healthStore = HKHealthStore()
    
    // making the initialiser private ensures that HealthManager cannot be instantiated anywhere outside this file
    // this enforces the singleton pattern because the only way the HealthManager can be accessed is through the shared static property
    private init () {
        
        Task {
            do {
                // this creates the little pop-up asking for the user to allow access to HealthKit data
                try await requestHealthKitAccess()
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func requestHealthKitAccess() async throws {
        // a Set of all the data types to read from the user's health data
        let calories = HKQuantityType(.activeEnergyBurned)
        let exercise = HKQuantityType(.appleExerciseTime)
        let stand = HKCategoryType(.appleStandHour)
        let healthTypes: Set = [calories, exercise, stand]
        
        try await healthStore.requestAuthorization(toShare: [], read: healthTypes)

    }
    
    // completion: is a closure that uses Swift's Result type to handle the event of either a Double (.success) or Error (.failure)
    // the completion handler is called asynchronously once the query has finished executing
    func fetchTodayCaloriesBurned(completion: @escaping(Result<Double, Error>) -> Void) {
        
        let calories = HKQuantityType(.activeEnergyBurned)
        
        // the predicate (filter) defines the time range for the info to query from HealthKit
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        
        // the HKStatisticsQuery retrieves statistical data for a specific HKQuantity type (e.g. calories)
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) {_, results, error in
            // the results returned may be nil, so it is accessed through a guard let and made optional
            // if results are nil or sumQuantity() fails, the error is thrown by the completion handler
            // sumQuantity() will return the sum of all the calorie samples within the specified time period
            guard let quantity = results?.sumQuantity(), error == nil else {
                completion(.failure(NSError()))
                return
            }
            
            // if sumQuantity() is successful the result is then formatted to kilocalories
            // the completion handler returns the sucessful value to caller of the function
            let calorieCount = quantity.doubleValue(for: .kilocalorie())
            completion(.success(calorieCount))
        }
        // this is where the query is actually run, the completion handler is called after this
        healthStore.execute(query)
    }
    
    
    func fetchTodayExerciseTime(completion: @escaping(Result<Double, Error>) -> Void) {
        
        let exercise = HKQuantityType(.appleExerciseTime)
        
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: exercise, quantitySamplePredicate: predicate) {_, results, error in
            guard let quantity = results?.sumQuantity(), error == nil else {
                completion(.failure(NSError()))
                return
            }
            
            let exerciseTime = quantity.doubleValue(for: .minute())
            completion(.success(exerciseTime))
        }
        healthStore.execute(query)
    }
    
    
    func fetchTodayStandHours(completion: @escaping(Result<Int, Error>) -> Void) {
        
        let stand = HKCategoryType(.appleStandHour)
        
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        
        // the HKCategoryType requires a different type of query
        let query = HKSampleQuery(sampleType: stand, 
                                  predicate: predicate, 
                                  limit: HKObjectQueryNoLimit,
                                  sortDescriptors: nil) { _, results, error in
            guard let samples = results as? [HKCategorySample], error == nil else {
                completion(.failure(NSError()))
                return
            }
            
            // samples array returns an array that denotes a zero for each hour you were not sitting the whole time so we are just getting the count of all the ones equal to zero
            let standCount = samples.filter({ $0.value == 0}).count
            completion(.success(standCount))
        }
        
        healthStore.execute(query)
    }
    
}
