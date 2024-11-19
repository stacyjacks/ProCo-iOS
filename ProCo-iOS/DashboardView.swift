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
    @Query(sort: [SortDescriptor(\Input.input, order: .forward)])
    var input: [Input]
    
    @State private var selectedEntry: Input?
    
    let radius: CGFloat = 130
    
    var body: some View {
        NavigationStack {
            ScaffoldView(title: "Today's goal", view: dashView)
        }
        .tint(.darkPurple)
    }
    
    var dashView: some View {
        VStack {
            NavigationLink {
                AddDataView(
                    screenType: ScreenType.AddGoal
                )
            } label: {
                CircularProgressView(
                    color: .darkPurple,
                    current: goalData.last?.current ?? 0.0,
                    goal: goalData.last?.goal ?? 0.0,
                    bottomText: "grams"
                )
                .padding(.bottom, .L)
            }
            .frame(maxWidth: .infinity, maxHeight: 300.0, alignment: .top)
            .foregroundColor(.black)
            
            ZStack(alignment: .center) {
                ForEach(
                    Array(input.enumerated()), id: \.element.id
                ) { index, entry in
                    BubbleButton(
                        action: {
                            selectedEntry = entry
                        },
                        value: entry.input
                    )
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
                    .position(
                        x: calculateX(count: input.count, index: index),
                        y: calculateY(count: input.count, index: index)
                    )
                }
            }
            .offset(CGSize(width: 0.0, height: 70.0))
            .frame(maxWidth: radius * 2)
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
    
    private func calculateX(count: Int, index: Int) -> CGFloat {
        let angle = Angle.degrees(Double(index) / Double(count) * 360)
        return radius * CGFloat(cos(angle.radians)) + radius
    }
    
    private func calculateY(count: Int, index: Int) -> CGFloat {
        let angle = Angle.degrees(Double(index) / Double(count) * 360)
        return radius * CGFloat(sin(angle.radians)) + radius
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: GoalData.self, Input.self, configurations: config
    )
    
    let input = Input(id: 0, input: 20.0, time: "")
    let input2 = Input(id: 1, input: 15.0, time: "")
    let input3 = Input(id: 2, input: 30.0, time: "")
    let input4 = Input(id: 3, input: 45.0, time: "")
    let goalData = GoalData(goal: 90, current: input.input)
    container.mainContext.insert(input)
    container.mainContext.insert(input2)
    container.mainContext.insert(input3)
    container.mainContext.insert(input4)
    container.mainContext.insert(goalData)
    
    return DashboardView().modelContainer(container)
}
