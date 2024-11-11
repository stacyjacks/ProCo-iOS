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
            .shadow(radius: 20)
            .foregroundColor(.black)

            VStack {
                ForEach(input, id: \.id) { entry in
                    Button {
                        selectedEntry = entry
                    } label: {
                        Text("\(String(entry.input)) gr")
                            .padding(.S)
                            .fontWeight(.bold)
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
                    .foregroundColor(Color("darkPurple"))
                    .background(
                        RoundedRectangle(cornerRadius: 20.0).fill(.white).shadow(radius: 10)
                    )
                }
                
            }
            .padding(.vertical)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .padding(.M)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                HStack {
                    NavigationLink {
                        SavedView()
                    } label: {
                        ProCoNavButton(icon: "list.star")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(.darkPurple)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                    
                    NavigationLink {
                        AddDataView(
                            screenType: ScreenType.AddInput
                        )
                    } label: {
                        ProCoNavButton(icon: "plus")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(.darkPurple)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                    
                    ProCoButton(
                        action: {
                            resetCurrentData()
                        },
                        icon: "trash.fill"
                    )
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(.darkPurple)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                }
                .shadow(radius: 10)
                .padding(.XS)
            }
        }
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
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: GoalData.self, Input.self, configurations: config
    )
    
    let input = Input(id: 0, input: 20.0, time: "")
    let goalData = GoalData(goal: 90, current: input.input)
    container.mainContext.insert(input)
    container.mainContext.insert(goalData)
    
    return DashboardView().modelContainer(container)
}
