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
                        "deleteWarning \(String(selectedEntry?.input ?? 0.0))",
                        isPresented: Binding(value: $selectedEntry), 
                        presenting: selectedEntry
                    ) { selectedEntry in
                        Button("cancel", role: .cancel) { }
                        Button("delete", role: .destructive) {
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
            goalData.last?.updateCurrent(input)
        } catch {
            fatalError()
        }
    }
    
    private func deleteSingleEntry(_ entry: Input) {
        modelContext.delete(entry)
        try? modelContext.save()
        goalData.last?.updateCurrent(input)
    }
}

#Preview {
    DashboardView()
}
