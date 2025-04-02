import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = [
        Message(sender: .assistant, text: "Привет! Чем могу помочь?")
    ]
    
    private var apiService: APIService
    private let predefinedAnswers: [String: String] = [
        "Как изменить пароль?": "Чтобы изменить пароль, перейдите в настройки профиля и выберите 'Изменить пароль'.",
        "Что делать, если не могу войти?": "Попробуйте восстановить пароль или обратитесь в службу поддержки."
    ]
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func send(query: String) {
        let userMessage = Message(sender: .user, text: query)
        messages.append(userMessage)
        
        if let customAnswer = predefinedAnswers[query] {
            let assistantMessage = Message(sender: .assistant, text: customAnswer)
            messages.append(assistantMessage)
        } else {
            apiService.fetchResponse(for: query) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        let assistantMessage = Message(sender: .assistant, text: response)
                        self?.messages.append(assistantMessage)
                    case .failure(let error):
                        let errorMessage = Message(sender: .assistant, text: "Ошибка: \(error.localizedDescription)")
                        self?.messages.append(errorMessage)
                    }
                }
            }
        }
    }
}

