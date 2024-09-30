//
//  HomeView.swift
//  FitnessApp
//
//  Created by Nick van Tilburg on 29/9/2024.
//

import SwiftUI


struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        
        // embed the main view in a navigation stack so the navigation link works
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Welcome")
                        .font(.largeTitle)
                        .padding()
                    
                    HStack {
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Calories")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.red)
                                
                                Text("\(viewModel.calories)")
                                    .bold()
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Active")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.green)
                                
                                Text("\(viewModel.active)")
                                    .bold()
                            }
                            .padding(.bottom)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Stand")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.blue)
                                
                                Text("\(viewModel.stand)")
                                    .bold()
                            }
                        }
                        
                        Spacer()
                        
                        ZStack {
                            ProgressCircleView(progress: $viewModel.calories,
                                               goal: 600,
                                               color: .red)
                            
                            ProgressCircleView(progress: $viewModel.active,
                                               goal: 60,
                                               color: .green)
                                .padding(.all, 20)
                            
                            ProgressCircleView(progress: $viewModel.stand,
                                               goal: 12,
                                               color: .blue)
                                .padding(.all, 40)
                            
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text("Fitness Activity")
                            .font(.title2)
                        
                        Spacer()
                        
                        Button {
                            print("show more")
                        } label: {
                            Text("Show more")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(.purple)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                        
                        ActivityCardView(activity: Activity(id: 0,
                                                            title: "Today's Steps",
                                                            subtitle: "Goal 10,000",
                                                            image: "figure.walk",
                                                            tintColor: .purple,
                                                            amount: "9812"))
                        ActivityCardView(activity: Activity(id: 0,
                                                            title: "Today's Steps",
                                                            subtitle: "Goal 10,000",
                                                            image: "figure.walk",
                                                            tintColor: .purple,
                                                            amount: "9812"))
                        ActivityCardView(activity: Activity(id: 0,
                                                            title: "Today's Steps",
                                                            subtitle: "Goal 10,000",
                                                            image: "figure.walk",
                                                            tintColor: .purple,
                                                            amount: "9812"))
                        ActivityCardView(activity: Activity(id: 0,
                                                            title: "Today's Steps",
                                                            subtitle: "Goal 10,000",
                                                            image: "figure.walk",
                                                            tintColor: .purple,
                                                            amount: "9812"))
         
                    }
                    .padding(.horizontal)
                    
                    
                    HStack {
                        Text("Recent Workouts")
                            .font(.title2)
                        
                        Spacer()
                        
                        NavigationLink {
                            EmptyView()
                        } label: {
                            Text("Show more")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(.purple)
                                .cornerRadius(20)
                        }

                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    LazyVStack {
                        ForEach(viewModel.mockWorkouts, id: \.id) { workout in
                            WorkoutCardView(workout: workout)
                        }
                    }
                    .padding(.bottom)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
