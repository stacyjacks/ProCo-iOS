//
//  ContentView.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var goalData: [GoalData]
    @Query var input: [Input]
    
    var body: some View {
        NavigationStack {
            ScaffoldView(title: "Today's goal", view: dashView)
        }
    }
    
    var dashView: some View {
        VStack {
            NavigationLink {
                AddDataView(
                    screenType: ScreenType.AddGoal
                )
            } label: {
                ProgressBarView(
                    goal: goalData.last?.goal ?? 0.0,
                    current: goalData.last?.current ?? 0.0,
                    goalText: ""
                )
            }
            .frame(alignment: .top)
            .foregroundColor(.black)
            
            HStack {
                ForEach(input, id: \.self) { entry in
                    Text(String(entry.input))
                }
            }
            .padding(.S)
            
            HStack {
                NavigationLink {
                    SavedView()
                } label: {
                    ProCoNavButton(icon: "list.bullet.circle.fill")
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                
                NavigationLink {
                    AddDataView(
                        screenType: ScreenType.AddInput
                    )
                } label: {
                    ProCoNavButton(string: "plus")
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                
                ProCoButton(
                    action: {
                        resetCurrentData()
                    },
                    icon: "trash.fill"
                )
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .padding(.M)
    }
    
    func resetCurrentData() {
        do {
            try modelContext.delete(model: Input.self)
            goalData.last?.current = 0.0 // to do update with modelcontext???
        } catch {
            fatalError()
        }
    }
}

#Preview {
    DashboardView()
}
