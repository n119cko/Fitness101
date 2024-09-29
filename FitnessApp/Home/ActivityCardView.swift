//
//  ActivityCardView.swift
//  FitnessApp
//
//  Created by Nick van Tilburg on 29/9/2024.
//

import SwiftUI

struct Activity {
    let id: Int
    let title: String
    let subtitle: String
    let image: String
    let tintColor: Color
    let amount: String
}

struct ActivityCardView: View {
    
    @State var activity: Activity
    
    var body: some View {
        
        ZStack {
            // using the uiColor means it will change depending on light/dark
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(activity.title)
                        
                        Text(activity.subtitle)
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    Image(systemName: activity.image)
                        .foregroundColor(activity.tintColor)
                }
                
                Text(activity.amount)
                    .font(.title)
                    .bold()
                    .padding()
            }
            .padding()
        }
    }
}

#Preview {
    ActivityCardView(activity: Activity(id: 0,
                                        title: "Today's Steps",
                                        subtitle: "Goal 10,000",
                                        image: "figure.walk",
                                        tintColor: .purple,
                                        amount: "9812"))
}
