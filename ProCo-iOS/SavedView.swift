//
//  SavedView.swift
//  ProCo-iOS
//
//  Created by Anastasia on 19/9/24.
//

import SwiftUI
import SwiftData

struct SavedView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: [SortDescriptor(\Saved.grams, order: .forward)])
    var saved: [Saved]
    
    @Query var input: [Input]
    @Query var goalData: [GoalData]
    
    var body: some View {
        ScaffoldView(title: "Saved presets", view: savedView)
    }
    
    var savedView: some View {
        VStack {
            List {
                ForEach(saved) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                            Text(String(item.grams))
                        }
                        
                        Text("plus")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .multilineTextAlignment(.trailing)
                            .onTapGesture {
                                addSavedToInput(amount: item.grams)
                                goalData.last?.updateCurrent(input)
                            }
                    }
                    .padding(.XS)
                }
                .onDelete(perform: { indexSet in
                    deleteSavedItem(at: indexSet)
                })
                .listRowBackground(Color.clear)
                .frame(maxHeight: .infinity)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            
            NavigationLink {
                AddDataView(
                    screenType: ScreenType.AddSaved
                )
            } label: {
                ProCoNavButton(string: "plus")
            }
            .frame(
                maxWidth: .infinity,
                alignment: .bottom
            )
            .padding(.M)
        }
    }
    
    private func deleteSavedItem(at offsets: IndexSet) {
        for offset in offsets {
            let savedItem = saved[offset]
            
            modelContext.delete(savedItem)
        }
    }
    
    private func addSavedToInput(amount: Float) {
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
}

#Preview {
    SavedView()
}
