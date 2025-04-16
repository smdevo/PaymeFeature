////
////  AuthScreen.swift
////  PaymeFeature
////
////  Created by Dmitriy An on 04/04/25.
////
//
//import SwiftUI
//
//struct SupportView: View {
//    @StateObject private var viewModel = GlobalViewModel()
//    @State private var inputText: String = ""
//    @State private var popularQueries: [String] = [
//        "Как изменить пароль?",
//        "Как изменить пароль?",
//        "Как изменить пароль?",
//        "Как изменить пароль?"
//    ]
//    
//    var body: some View {
//        //MARK: - dialogue
//        VStack(spacing: 0) {
//            ScrollViewReader { item in
//                ScrollView {
//                    VStack(alignment: .leading, spacing: 10) {
//                        ForEach(viewModel.messages) { message in
//                            MessageView(message: message)
//                                .id(message.id)
//                        }
//                    }
//                    .padding(.vertical)
//                }
//                .background(Color(.systemGray6))
//                .onAppear {
//                       if let lastMessage = viewModel.messages.last {
//                           DispatchQueue.main.async {
//                               withAnimation {
//                                   item.scrollTo(lastMessage.id, anchor: .bottom)
//                               }
//                           }
//                       }
//                   }
//                .onChange(of: viewModel.messages.count) { newValue, oldValue in
//                    if let lastMessage = viewModel.messages.last {
//                        DispatchQueue.main.async {
//                            withAnimation {
//                                item.scrollTo(lastMessage.id, anchor: .bottom)
//                            }
//                        }
//                    }
//                }
//
//
//            }
//            .background(Color(.systemGray6))
//            
//            Divider()
//            
//            // MARK: - autoQuerie
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 10) {
//                    ForEach(popularQueries, id: \.self) { query in
//                        Button(action: {
//                            viewModel.send(query: query)
//                        }) {
//                            Text(query)
//                                .padding(8)
//                                .background(Color.cyan.opacity(0.2))
//                                .cornerRadius(8)
//                        }
//                    }
//                }
//                .padding()
//                .background(Color.clear)
//            }
//          
//            Divider()
//            
//            // MARK: - message
//            HStack {
//                TextField("Введите сообщение...", text: $inputText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                
//                Button(action: {
//                    guard !inputText.isEmpty else { return }
//                    viewModel.send(query: inputText)
//                    inputText = ""
//                }) {
//                    Text("Отправить")
//                }
//                .padding(.horizontal, 8)
//            }
//            .padding(8)
//            .background(Color(.systemBackground))
//        }
//    }
//}
