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
}

struct MonitoringView: View {
    
    @EnvironmentObject var eVm: GlobalViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // MARK: - Секция суммарных показателей
                summarySection
                
                // MARK: - Список транзакций или пустое состояние
                if eVm.transactions.isEmpty {
                    emptyHistoryView
                } else {
                    transactionsListView
                }
            }
            .navigationBarTitle("Мониторинг", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
            }, label: {
                Image(systemName: "slider.horizontal.3")
            }))
        }.background(.backgroundC)
    }
    
    private var summarySection: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Поступление")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("4000000")
                    .font(.headline)
                    .foregroundColor(.green)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Расход")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("1000000")
                    .font(.headline)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(.backgroundC)
    }
    
    private var emptyHistoryView: some View {
        VStack(spacing: 16) {
            Spacer(minLength: 40)
            Image(systemName: "tray")
                .font(.system(size: 50))
                .foregroundColor(.secondary)
            Text("История транзакций пока пуста")
                .font(.headline)
                .foregroundColor(.primary)
            Text("Когда появятся транзакции, вы увидите их здесь")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
    }
    
    private var transactionsListView: some View {
        List {
            ForEach(eVm.transactions) { transaction in
                TransactionRow(transaction: transaction)
            }
        }
        .listStyle(PlainListStyle())
        .background(.backgroundC)
    }
}

struct TransactionRow: View {
    let transaction: TransactionModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(transaction.date) | \(transaction.time)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack {
                Text(transaction.description)
                    .font(.subheadline)
                Spacer()
                Text(transaction.amount)
                    .font(.subheadline)
            }
        }
        .padding(.vertical, 6)
        .background(.backgroundC)
    }
}

