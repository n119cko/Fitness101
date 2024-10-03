//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Nick van Tilburg on 30/9/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    let healthManager = HealthManager.shared
    
    @Published var calories: Int = 0
    @Published var exercise: Int = 0
    @Published var stand: Int = 0
    
    var mockWorkouts = [
        Workout(id: 0,
                title: "Running",
                 image: "figure.run",
                 tintColor: .purple,
                 duration: "23 mins",
                 date: "Aug 3",
                 calories: "341 kCal"),
        Workout(id: 1,
                title: "Running",
                 image: "figure.run",
                 tintColor: .orange,
                 duration: "23 mins",
                 date: "Aug 3",
                 calories: "341 kCal"),
        Workout(id: 2,
                title: "Running",
                 image: "figure.run",
                 tintColor: .pink,
                 duration: "23 mins",
                 date: "Aug 3",
                 calories: "341 kCal"),
        Workout(id: 3,
                title: "Running",
                 image: "figure.run",
                 tintColor: .purple,
                 duration: "23 mins",
                 date: "Aug 3",
                 calories: "341 kCal")
        
    ]
    
    
    init() {
        
        Task {
            do {
                try await healthManager.requestHealthKitAccess()
                
                fetchTodayCalories()
                fetchTodayExerciseTime()
                fetchTodayStandHours()
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchTodayCalories() {
        healthManager.fetchTodayCaloriesBurned { result in
            switch result {
            case .success(let calories):
                DispatchQueue.main.async {
                    self.calories = Int(calories)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchTodayExerciseTime() {
        healthManager.fetchTodayExerciseTime { result in
            switch result {
            case .success(let exercise):
                DispatchQueue.main.async {
                    self.exercise = Int(exercise)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchTodayStandHours() {
        healthManager.fetchTodayStandHours { result in
            switch result {
            case .success(let hours):
                DispatchQueue.main.async {
                    self.stand = hours
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
