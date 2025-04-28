//
//  ChildCardsView2.swift
//  PaymeFeature
//
//  Created by Samandar on 25/04/25.
//

import SwiftUI

struct ChildCardsView: View {
    
    @EnvironmentObject var gvm: GlobalViewModel
    @State var balance = 0
    @State var name: String = ""
    
    
    var body: some View {
        
        NavigationStack {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Greeting
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Привет, \(name.split(separator: " ").first ?? "")!👋")
                            .font(.largeTitle.bold())
                        Spacer()
                        
                        Button {
                            logOut()
                        } label: {
                            Image("Child")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                        }
                        
                    }
//                    Text("Ты молодец — вчера сэкономил 12 000 сум")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
                }
                
                // Balance
                HStack {
                    VStack(alignment: .leading) {
                        Text("Твой баланс:")
                            .font(.headline)
                        Text(balance.formattedWithSeparator())
                            .font(.largeTitle.bold())
                        
                    }
                    
                    Spacer()
                    
                    // Circle Progress
                    balance.formattedWithSeparator() == "0" ? CircleProgressView(progress: 0).frame(width: 70, height: 70) :
                    CircleProgressView(progress: CGFloat(100000-Int(balance)))
                        .frame(width: 70, height: 70)
                }
                .padding(.bottom, 25)
                
                LazyVStack {
                    ForEach(gvm.cards.filter { $0.isFamilyCard }) { card in
                        ChildCardView(bankCard: card)
                            .padding(.horizontal,-10)
                            .onAppear {
                                balance = Int(card.sum) ?? 0
                                name = card.ownerName
                            }
                    }
                    
                }
                .padding(.bottom,30)
                
                
                
                
                
                // Weekly goal
                VStack(alignment: .leading, spacing: 15) {
                    Text("Цель недели")
                        .font(.title2.bold())
                    
                    HStack {
                        Text("🌟 Потратить меньше 50 000 сум")
                        Spacer()
                        Button(action: {
                            // Action for reward
                        }) {
                            Text("→ Получи награду 🏅")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(.bottom, 25)
                
                
                
                // Tasks
                VStack(alignment: .leading, spacing: 15) {
                    Text("Задачи")
                        .font(.title2.bold())
                    
                    TaskRow(title: "Копить на велосипед")
                    TaskRow(title: "Сделать домашнее задание")
                    TaskRow(title: "Помочь по дому")
                }
                
                
                
                // Last expenses
                VStack(alignment: .leading, spacing: 20) {
                    Text("Последние траты")
                        .font(.title2.bold())
                    
                    ExpenseRow(icon: "🍕", title: "Пицца", amount: "-900 сум")
                    ExpenseRow(icon: "🚌", title: "Транспорт", amount: "-1500 сум")
                    ExpenseRow(icon: "🎮", title: "Онлайн-игра", amount: "-500 сум")
                }
                .padding(.bottom, 25)
            }
            .padding(20)
        }
//        .toolbar(content: {
//            ToolbarItem(placement: .navigation) {
//                VStack{
//                    HStack {
//                        Text("Привет, \(name.split(separator: " ").first ?? "")!👋")
//                            .font(.largeTitle.bold())
//                        
//                        Spacer()
//                        
//                        Button {
//                            logOut()
//                        } label: {
//                            Image("Child")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 60, height: 60)
//                                .clipShape(Circle())
//                        }
//                        
//                    }
//                    .padding(.leading,10)
//                    
//                    Text("")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                }
//            }
//        })
        .refreshable {
            gvm.loadUserAndFamily()
        }
    }
        
    }
}


func logOut() {
    UserDefaults.standard.removeObject(forKey: "userId")
    UserDefaults.standard.removeObject(forKey: "userFamilyId")
    
    switchToLogin()
}

func switchToLogin() {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let window = windowScene.windows.first {
        let hostingController = UIHostingController(rootView: LoginView())
        window.rootViewController = hostingController
        window.makeKeyAndVisible()
    }
    
}//Class


// MARK: - Components

struct CircleProgressView: View {
    var progress: CGFloat // 0.0 to 1.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 8)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.blue, lineWidth: 8)
                .rotationEffect(.degrees(-90))
        }
    }
}

struct ExpenseRow: View {
    var icon: String
    var title: String
    var amount: String
    
    var body: some View {
        HStack {
            Text(icon)
            Text(title)
            Spacer()
            Text(amount)
                .foregroundColor(.red)
        }
        .font(.headline)
    }
}

import SwiftUI

struct TaskRow: View {
    var title: String
    @State private var isCompleted = false

    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.5)) {
                    isCompleted.toggle()
                }
            }) {
                Image(systemName: isCompleted ? "checkmark.seal.fill" : "seal")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(isCompleted ? .purple : .orange)
                    .rotationEffect(.degrees(isCompleted ? 360 : 0))
                    .scaleEffect(isCompleted ? 1.3 : 1.0)
                    .animation(.easeInOut(duration: 0.3), value: isCompleted)
            }

            Text(isCompleted ? "🎉 \(title)" : title)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(isCompleted ? .gray : .primary)
                .strikethrough(isCompleted, color: .gray)
                .animation(.easeInOut(duration: 0.3), value: isCompleted)

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isCompleted ? Color.purple.opacity(0.2) : Color.orange.opacity(0.1))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isCompleted ? Color.purple : Color.orange, lineWidth: 2)
        )
        .frame(height: 60)
        //.padding(.horizontal)
    }
}



// MARK: - Preview

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        ChildCardsView()
    }
}

