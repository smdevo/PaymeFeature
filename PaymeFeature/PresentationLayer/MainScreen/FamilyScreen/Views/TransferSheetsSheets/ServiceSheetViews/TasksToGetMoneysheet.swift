//
//  TasksToGetMoneysheet.swift
//  PaymeFeature
//
//  Created by Samandar on 23/04/25.
//


import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var reward: Int // in UZS
    var isCompleted: Bool = false
}

struct FulfillTheTaskAndGetTheMoneyScreen: View {
    
    @State private var tasks: [Task] = [
        Task(title: "Clean your room", reward: 500),
        Task(title: "Finish your homework", reward: 800, isCompleted: true),
        Task(title: "Fold the laundry", reward: 400),
        Task(title: "Feed the pet", reward: 300, isCompleted: true),
        Task(title: "Wash the dishes", reward: 600)
    ]
    
    @State private var showAddTaskSheet = false
    
    @Environment(\.dismiss) var dismiss
        
    let role = UserDefaults.standard.bool(forKey: "role")
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(tasks.indices, id: \.self) { index in
                            TaskCard(task: $tasks[index], role: role)
                        }
                    }
                    .padding()
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showAddTaskSheet = true
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.accentColor)
                                .clipShape(Circle())
                                .shadow(color: .accentColor.opacity(0.4), radius: 10, x: 0, y: 6)
                        }
                        .padding()
                        .accessibilityLabel("Add Task")
                    }
                }
            }
            .navigationTitle("Tasks")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showAddTaskSheet) {
                AddTaskSheet { newTask in
                    tasks.append(newTask)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
//                        evm.backgroundImange[id] = backGroundImage
                       // dismiss()
                    } label: {
                        Image("payme")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80)
                    }
                }
            }
        }
    }
}

struct TaskCard: View {
    @Binding var task: Task
    let role: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(task.title)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.primary)
                
                Text("Reward: \(task.reward.formattedWithSeparator()) UZS")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                task.isCompleted.toggle()
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(task.isCompleted ? Color.green : Color.gray.opacity(0.7))
                    .animation(.easeInOut, value: task.isCompleted)
                    .opacity(!role || task.isCompleted ? 1 : 0)
                    
            }
        }
        .disabled(role)
        .padding()
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 2)
    }
}

struct AddTaskSheet: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var rewardText: String = ""
    
    var onAdd: (Task) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Enter task title", text: $title)
                    TextField("Enter reward in UZS", text: $rewardText)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard let reward = Int(rewardText), !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        let task = Task(title: title.trimmingCharacters(in: .whitespaces), reward: reward)
                        onAdd(task)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty || Int(rewardText) == nil)
                }
            }
        }
    }
}

extension Int {
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}



#Preview {
    FulfillTheTaskAndGetTheMoneyScreen()
}
