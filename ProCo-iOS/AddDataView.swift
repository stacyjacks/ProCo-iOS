//
//  AddDataView.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import SwiftUI
import SwiftData

struct AddDataView: View {
    let screenType: ScreenType
    @SwiftUI.Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) private var modelContext
    @Query var goalData: [GoalData]
    @Query var input: [Input]
    @Query var saved: [Saved]
    
    @State private var value: Float = 0.0
    @State private var name: String = ""
    
    var body: some View {
        ScaffoldView(title: screenType.title, view: addDataView)
    }
    
    var addDataView: some View {
        VStack(alignment: .center) {
            TextField(
                "",
                value: $value,
                format: .number
            )
            .onChange(
                of: $value
                    .wrappedValue, { _, newAmount in
                        value = newAmount
                }
            )
            .multilineTextAlignment(.center)
            .padding(.XL)
            .font(.system(size: 36, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            
            Text(
                "grams"
            )
            .padding(.XS)
            
            if screenType == ScreenType.AddGoal {
                Text("perDay")
                    .padding()
            }
            
            if (screenType == ScreenType.AddSaved) {
                TextField(
                    text: $name, 
                    label: {
                        Text("name")
                    }
                )
                .onChange(
                    of: $name
                        .wrappedValue, { _, newName in
                            name = newName
                    }
                )
                .padding(.M)
                .frame(maxWidth: .infinity)
            }
            
            ProCoButton(
                action: {
                    switch screenType {
                    case .AddGoal:
                        addGoalData(goal: value)
                        dismiss()
                    case .AddSaved:
                        addSaved(name: name, grams: value)
                        dismiss()
                    case .AddInput:
                        addInput(amount: value)
                        updateCurrent()
                        dismiss()
                    }
                },
                string: "save"
            )
            .padding(.XS)
            
            ProCoTextButton(
                action: { dismiss() },
                string: "cancel"
            )
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
    
    private func addGoalData(goal: Float) {
        let goal = GoalData(goal: goal, current: 0.0)
        modelContext.insert(goal)
        
        do {
            try modelContext.save()
        } catch {
            fatalError()
        }
    }
    
    private func addInput(amount: Float) {
        let input = Input(
            id: UUID().hashValue,
            input: amount,
            time: formattedDate
        )
                
        modelContext.insert(input)
        
        do {
            try modelContext.save()
        } catch {
            fatalError()
        }
    }
    
    private func addSaved(name: String, grams: Float) {
        let saved = Saved(
            id: UUID().hashValue,
            name: name,
            grams: grams
        )
        
        modelContext.insert(saved)
        
        do {
            try modelContext.save()
        } catch {
            fatalError()
        }
    }
    
    private func updateCurrent() {
        // to do update with modelcontext???
        goalData.last?.current =
        if input.isEmpty {
            0.0
        } else {
            self.input.map { $0.input }.reduce(0, +)
        }
    }
}

#Preview {
    AddDataView(screenType: ScreenType.AddSaved)
}
