//
//  ContentView.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import SwiftUI
import SwiftData
import WidgetKit

struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query var goalData: [GoalData]
    @Query var input: [Input]
    
    @State private var selectedEntry: Input?
    
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
                ForEach(input, id: \.id) { entry in
                    Button {
                        selectedEntry = entry
                    } label: {
                        Text(String(entry.input))
                    }
                    .alert(
                        "You're about to delete entry: \(String(selectedEntry?.input ?? 0.0))",
                        isPresented: Binding(value: $selectedEntry), 
                        presenting: selectedEntry
                    ) { selectedEntry in
                        Button("Cancel", role: .cancel) { }
                        Button("Delete", role: .destructive) {
                            deleteSingleEntry(selectedEntry)
                        }
                    }
                    .foregroundColor(.black)
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
    
    private func deleteSingleEntry(_ entry: Input) {
        modelContext.delete(entry)
        updateCurrent()
    }
    
    private func updateCurrent() { // to do reuse???? it's the same in 3 classes
        // to do update with modelcontext???
        goalData.last?.current =
        if input.isEmpty {
            0.0
        } else {
            self.input.map { $0.input }.reduce(0, +)
        }
        
        WidgetCenter.shared.reloadAllTimelines()
    }
}

#Preview {
    DashboardView()
}
