//
//  AuthScreen.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    
    let historyService = HistoryDataServise()
    
    private var apiService: APIService
    
    @Published var messages: [Message] = []
    
    private let predefinedAnswers: [String: String] = [
        "Как изменить пароль?":
        "Чтобы изменить пароль, перейдите в настройки профиля и выберите 'Изменить пароль'.",
    ]
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
        
        
        messages = historyService.fetchHistory().map({ mesEnt in
            let message = Message(sender: Sender(rawValue: mesEnt.type ?? "assistant")!, text: mesEnt.message ?? "Message")
            return message
        })
        
        messages.append(Message(sender: .assistant, text: "Привет! Чем могу помочь?"))
    }
    
    func send(query: String) {
        let userMessage = Message(sender: .user, text: query)
        messages.append(userMessage)
        historyService.saveMessage(message: userMessage.text, type: Sender(rawValue: userMessage.sender.rawValue) ?? .user)
        
        if let customAnswer = predefinedAnswers[query] {
            let assistantMessage = Message(sender: .assistant, text: customAnswer)
            messages.append(assistantMessage)
            historyService.saveMessage(message: assistantMessage.text, type: Sender(rawValue: assistantMessage.sender.rawValue) ?? .assistant)
        } else {
            apiService.fetchResponse(for: query) { [weak self] result in
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success(let response):
                        let assistantMessage = Message(sender: .assistant, text: response)
                        self?.messages.append(assistantMessage)
                        self?.historyService.saveMessage(message: assistantMessage.text, type: .assistant)
                    case .failure(let error):
                        let errorMessage = Message(sender: .assistant, text: "Ошибка: \(error.localizedDescription)")
                        self?.messages.append(errorMessage)
                        self?.historyService.saveMessage(message: errorMessage.text, type: .assistant)
                    }
                }
            }
        }
        
    
    }
}

