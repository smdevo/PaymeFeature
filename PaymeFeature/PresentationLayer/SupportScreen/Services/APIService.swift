import Foundation

struct APIService {
    // Используйте ваш токен Hugging Face
    let accessToken: String = "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"
    // URL для модели GPT-2 через Hugging Face Inference API
    let baseURL: URL = URL(string: "https://api-inference.huggingface.co/models/openai-community/gpt2 ")!
    
    func fetchResponse(for query: String, completion: @escaping (Result<String, Error>) -> Void) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let payload: [String: Any] = ["inputs": query]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let err = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Нет данных в ответе"])
                completion(.failure(err))
                return
            }
            
            
            do {
                // GPT-2 возвращает ответ в виде массива словарей
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let firstResponse = jsonArray.first,
                   let generatedText = firstResponse["generated_text"] as? String {
                    completion(.success(generatedText))
                } else {
                    let err = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Неверный формат ответа"])
                    completion(.failure(err))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
