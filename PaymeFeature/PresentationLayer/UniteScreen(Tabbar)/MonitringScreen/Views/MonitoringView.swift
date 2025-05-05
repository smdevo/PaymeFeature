//
//  MonitoringView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 10/04/25.
//

import SwiftUI


struct MonitoringView: View {
    
    
        //MARK: MONITORING
    @State var transactions: [TransactionModel] = [
            TransactionModel(date: "9 апреля 2025", time: "12:34", amount: "-300 000", description: "Перевод с карты", iconName: "", category: "Kids"),
            TransactionModel(date: "8 апреля 2025", time: "11:22", amount: "-25 000", description: "Перевод с карты", iconName: "", category: "Kids"),
            TransactionModel(date: "8 апреля 2025", time: "11:22", amount: "-500 000", description: "Оплата", iconName: "uzum", category: "Оплата"),
            TransactionModel(date: "9 апреля 2025", time: "12:34", amount: "-10 000", description: "Оплата", iconName: "safia", category: "Kids"
    ),
            TransactionModel(date: "8 апреля 2025", time: "11:22", amount: "-500 000", description: "Оплата", iconName: "safia", category: "Оплата"),
            TransactionModel(date: "9 апреля 2025", time: "12:34", amount: "-300 000", description: "Связь", iconName: "ucell", category: "Ucell"),
            TransactionModel(date: "8 апреля 2025", time: "11:22", amount: "-500 000", description: "Услуги", iconName: "", category: "Оплата"),
            TransactionModel(date: "9 апреля 2025", time: "12:34", amount: "-13 000", description: "Оплата", iconName: "makro", category: "Оплата"),
            TransactionModel(date: "8 апреля 2025", time: "11:22", amount: "+500 000", description: "Перевод", iconName: "", category: "Перевод")
        ]
        
        var totalIncomeString: String {
            let sum = transactions
                .compactMap { Int($0.amount.replacingOccurrences(of: " ", with: "")) }
                .filter { $0 > 0 }
                .reduce(0, +)
            return format(sum)
        }

        var totalExpenseString: String {
            let sum = transactions
                .compactMap { Int($0.amount.replacingOccurrences(of: " ", with: "")) }
                .filter { $0 < 0 }
                .reduce(0, +)
            return format(sum)
        }

        var sectionTotals: [String: String] {
            Dictionary(grouping: transactions, by: \.date)
                .mapValues { items in
                    let sum = items
                        .compactMap { Int($0.amount.replacingOccurrences(of: " ", with: "")) }
                        .reduce(0, +)
                    return format(sum)
                }
        }
    
    private func format(_ value: Int) -> String {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.groupingSeparator = " "
        fmt.maximumFractionDigits = 0
        let absString = fmt.string(from: .init(value: abs(value))) ?? "0"
        return (value >= 0 ? "+" : "-") + absString
    }
    
    
    private var grouped: [(date: String, items: [TransactionModel])] {
        Dictionary(grouping: transactions) { $0.date }
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
                Text(totalIncomeString)
                    .font(.headline)
                    .foregroundColor(.paymeC)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text("Расход")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(totalExpenseString)
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
            if let totalForDate = sectionTotals[date] {
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
                
                
//                Text("\(transaction.date) | \(transaction.time)")
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//                
                HStack {
                    Text(transaction.description)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                    Text("\(transaction.amount) сум")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                
                Text(transaction.category ?? "Оплата")
                    .foregroundStyle(transaction.category == "Kids" ? Color.white: Color.black)
                    .fontWeight(transaction.category == "Kids" ? .semibold : .light)
                    .font(.caption2)
                    .padding(3)
                    .padding(.horizontal, 7)
                    .frame(width: transaction.category == "Kids" ? 60 : 70)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(transaction.category == "Kids" ? Color.theme.paymeC : Color.gray.opacity(0.2))
                            
                    )
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

  

