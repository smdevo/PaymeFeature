//
//  ChildAccountView.swift
//  PaymeFeature
//
//  Created by Samandar on 25/04/25.
//

import SwiftUI

struct ChildAccountView: View {
    
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

                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Остаток лимита на день")
                            .font(.headline)
                        
                        Text("\(balance)")
                            .font(.largeTitle.bold())
                    }
                    
                    Spacer()
                    
                    CircleProgressView(progress: 1)
                        .frame(width: 70, height: 70)
                    
                }
                .padding(.bottom, 25)
                .padding(.trailing, 14)
                
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
    
                // Tasks
                VStack(alignment: .leading, spacing: 15) {
                    Text("Задачи")
                        .font(.title2.bold())
                    TaskRow(title: "Уборка комнаты", reward: 5000)
                    TaskRow(title: "Выполнение домашнего задания", reward: 8000)
                    TaskRow(title: "Складывание белья", reward: 4000)
                    TaskRow(title: "Кормление питомца", reward: 3000)
                    TaskRow(title: "Мойка посуды", reward: 6000)
                }
            }
            .padding(20)
            
            // Last expenses
            VStack(alignment: .leading, spacing: 20) {
                
                HStack{
                    Text("Последние траты")
                        .font(.title2.bold())
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }, label:   {Text("Все")})
                  
                }
             
                ExpenseRow(icon: "🍕", title: "Пицца", amount: "-50 000 сум")
                ExpenseRow(icon: "🚌", title: "Транспорт", amount: "-1500 сум")
                ExpenseRow(icon: "🎮", title: "Онлайн-игра", amount: "-80 000 сум")
            }
            .padding(20)
            
            
        }
        .refreshable {
            gvm.loadUserAndFamily()
        }
 
        }.padding(.vertical, 8)
        
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
    /// 0.0 to 1.0
    var progress: CGFloat
    /// Stroke width
    var lineWidth: CGFloat = 6
    /// Gradient colors around the circle
    var gradientColors: [Color] = [Color.blue, Color.purple]

    @State private var animatedProgress: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let radius = size / 2

            ZStack {
                // Background track
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)

                // Animated progress arc
                Circle()
                    .trim(from: 0, to: animatedProgress)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: gradientColors),
                            center: .center
                        ),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .shadow(color: .black.opacity(0.15), radius: 2, x: 1, y: 1)

                // End-cap dot
                Circle()
                    .fill(gradientColors.last ?? .blue)
                    .frame(width: lineWidth, height: lineWidth)
                    // offset by the radius so the dot sits on the circle’s edge
                    .offset(x: 0, y: -radius)
                    // then rotate around the center
                    .rotationEffect(.degrees(Double(animatedProgress) * 360))
                    .shadow(color: .black.opacity(0.15), radius: 1, x: 0.5, y: 0.5)

                // Percentage label
                Text("\(Int(animatedProgress * 100))%")
                    .font(.system(size: size * 0.25, weight: .bold, design: .rounded))
                    .foregroundColor(gradientColors.last)
            }
            .onAppear {
                withAnimation(.easeOut(duration: 1.0)) {
                    animatedProgress = progress
                }
            }
        }
        // keep it square
        .aspectRatio(1, contentMode: .fit)
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

struct TaskRow: View {
    var title: String
    var reward: Int
    @State private var isCompleted = false

    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                    isCompleted.toggle()
                }
            }) {
                Image(systemName: isCompleted ? "checkmark.seal.fill" : "seal")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(isCompleted ? .purple : .orange)
                    .rotationEffect(.degrees(isCompleted ? 360 : 0))
                    .scaleEffect(isCompleted ? 1.3 : 1.0)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(isCompleted ? "🎉 \(title)" : title)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(isCompleted ? .gray : .primary)
                    .strikethrough(isCompleted, color: .gray)

                Text("\(reward) сум")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(isCompleted ? .green : .orange)
                    .scaleEffect(isCompleted ? 1.2 : 1.0)
                    .animation(.easeInOut(duration: 0.3), value: isCompleted)
            }

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
        .frame(height: 80)
        .animation(.easeInOut(duration: 0.3), value: isCompleted)
    }
}


