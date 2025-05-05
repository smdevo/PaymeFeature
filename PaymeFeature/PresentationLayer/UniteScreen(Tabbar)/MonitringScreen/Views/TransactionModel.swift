struct TransactionModel: Identifiable {
    let id = UUID()
    let date: String
    let time: String
    let amount: String
    let description: String
    let iconName: String?
    let category: String?
}