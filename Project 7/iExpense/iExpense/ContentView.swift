//
//  ContentView.swift
//  iExpense
//
//  Created by Варвара Уткина on 06.02.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    let currencyCode = Locale.current.currency?.identifier ?? "USD"
    
    private var personalItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    private var businessItems: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal expenses") {
                    ForEach(personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: currencyCode))
                                .foregroundColor(getColor(for: item.amount))
                        }
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, from: "Personal")
                    }
                }
                
                Section("Business expenses") {
                    ForEach(businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: currencyCode))
                                .foregroundColor(getColor(for: item.amount))
                        }
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, from: "Business")
                    }
                }
            }
            .navigationTitle("iExpense")
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses, currencyCode: currencyCode)
            }
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet, from type: String) {
        let filteredItems = type == "Personal" ? personalItems : businessItems
        let itemsToDelete = offsets.map { filteredItems[$0] }
        
        expenses.items.removeAll { item in
            itemsToDelete.contains(where: { $0.id == item.id })
        }
    }
    
    func getColor(for amount: Double) -> Color {
        switch amount {
        case ..<1000: .green
        case 1000..<10000: .orange
        default: .red
        }
    }
}

#Preview {
    ContentView()
}
