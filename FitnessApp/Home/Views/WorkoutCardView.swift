//
//  WorkoutCardView.swift
//  FitnessApp
//
//  Created by Nick van Tilburg on 29/9/2024.
//

import SwiftUI

struct WorkoutCardView: View {
    
    @State var workout: Workout
    
    
    var body: some View {
        HStack {
            Image(systemName: workout.image)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .foregroundColor(workout.tintColor)
            // the padding will give it the space for the nice background colour frame below
                .padding()
                .background(Color(uiColor: .systemGray6))
                .cornerRadius(10)
            
            VStack(spacing: 16) {
                HStack {
                    Text(workout.title)
                        .font(.title3)
                        .bold()
                    
                    Spacer()
                    
                    Text(workout.duration)
                    
                }
                
                HStack {
                    Text(workout.date)
                    
                    Spacer()
                    
                    Text(workout.calories)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    WorkoutCardView(workout: Workout(id: 0,
                                     title: "Running",
                                     image: "figure.run",
                                     tintColor: .purple,
                                     duration: "23 mins",
                                     date: "Aug 3",
                                     calories: "341 kCal"))
}
