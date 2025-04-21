//
//  MonitoringView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 10/04/25.
//

import SwiftUI

struct TransactionModel: Identifiable {
    let id = UUID()
    let date: String
    let time: String
    let amount: String
    let description: String
    let iconName: String?
}

struct MonitoringView: View {
    
    @EnvironmentObject var eVm: GlobalViewModel
    
    private var grouped: [(date: String, items: [TransactionModel])] {
        Dictionary(grouping: eVm.transactions) { $0.date }
            .map { (date: $0.key, items: $0.value) }
            .sorted { $0.date > $1.date }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                summarySection
                List {
                    ForEach(grouped, id: \.date) { section in
                        Section(header: sectionHeader(date: section.date)) {
                            ForEach(section.items) { tx in
                                TransactionRow(transaction: tx)
                                    .listRowBackground(Color.backgroundC)
                            }
                        }
                        .textCase(nil)
                    }
                }
                .listStyle(.plain)
                .background(Color.backgroundC)
            }
            .background(Color.backgroundC.edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Мониторинг", displayMode: .inline)
            .navigationBarItems(trailing:
                                    Button {
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(.primary)
            }
            )
        }
    }
    
    private var summarySection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Поступление")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(eVm.totalIncomeString)
                    .font(.headline)
                    .foregroundColor(.paymeC)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text("Расход")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(eVm.totalExpenseString)
                    .font(.headline)
                    .foregroundColor(.red)
            }
        }
        .padding(.horizontal, 32)
        .background(Color.backgroundC)
    }
    
    private func sectionHeader(date: String) -> some View {
        HStack {
            Text(date)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            
            Spacer()
            if let totalForDate = eVm.sectionTotals[date] {
                Text(totalForDate)
                    .font(.subheadline)
                    .foregroundColor(totalForDate.hasPrefix("-") ? .red : .paymeC)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        
        .background(.secondary.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: .spacing(.x3)))
        
    }
    
    
}

struct TransactionRow: View {
    let transaction: TransactionModel
    
    var body: some View {
        HStack(spacing: 12) {
            iconView
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(transaction.date) | \(transaction.time)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack {
                    Text(transaction.description)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                    Text("\(transaction.amount) сум")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal)
        .background(Color.backgroundC)
    }
    @ViewBuilder
    private var iconView: some View {
        if let name = transaction.iconName,
           !name.isEmpty,
           let uiImage = UIImage(named: name) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(8)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        } else {
            Image(systemName: "creditcard.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(8)
                .background(Color.blue.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundColor(.white)
        }
    }
    
    
}




#Preview{
    MonitoringView().environmentObject(GlobalViewModel())
}
