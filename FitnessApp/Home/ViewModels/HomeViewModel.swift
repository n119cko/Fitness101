//
//  HomeViewModel.swift
//  FitnessApp
//
//  Created by Nick van Tilburg on 30/9/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    var calories: Int = 123
    var active: Int = 52
    var stand: Int = 8
    
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
    
}
