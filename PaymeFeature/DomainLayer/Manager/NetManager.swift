//
//  NetManager.swift
//  PaymeFeature
//
//
//




import Foundation
import Combine




private let SERVER = "https://67ecf2e64387d9117bbb9a32.mockapi.io/"


class NetManager {
    
    static let shared = NetManager()
    private var cancellables = Set<AnyCancellable>()
    

    init() {
        print("NetManager init")
    }
    
    
    // MARK: - GET Request
    func get<T: Decodable>(url: String, handler: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: SERVER + url) else {
            print("Invalid url")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    handler(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { data in
                handler(.success(data))
            })
            .store(in: &cancellables)
    }
    
    // MARK: - POST Request
    func post<T: Decodable, P: Encodable>(url: String, params: P, handler: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: SERVER + url) else {
            print("Error: Invalid URL")
            return
        }
        
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(params)
        } catch {
            handler(.failure(error))
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    handler(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { data in
                handler(.success(data))
            })
            .store(in: &cancellables)
    }
    
    // MARK: - PUT Request
    func put<T: Decodable, P: Encodable>(url: String, params: P, handler: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: SERVER + url) else {
            print("Error: Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(params)
        } catch {
            handler(.failure(error))
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    handler(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { data in
                handler(.success(data))
            })
            .store(in: &cancellables)
    }
    
    // MARK: - DELETE Request
    func delete<T: Decodable>(url: String, isComments: Bool, handler: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: SERVER + url) else {
            print("Error: Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    handler(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { data in
                handler(.success(data))
            })
            .store(in: &cancellables)
    }
}

// MARK: - Parameter Helper Functions
extension NetManager {
    static func paramsUser(user: UserModel) -> [String: AnyCodable] {
        return [
            "name": AnyCodable(user.name),
            "number": AnyCodable(user.number),
            "password": AnyCodable(user.password),
            "date": AnyCodable(user.date),
            "familyId": AnyCodable(user.familyId),
            "role": AnyCodable(user.role),
            "balance": AnyCodable(user.balance),
            "id": AnyCodable(user.id),
            "invitation": AnyCodable(user.invitation)
        ]
    }
    
    
    static func paramFamily(family: FamilyModel) -> [String: AnyCodable] {
        return [
            "name": AnyCodable(family.name),
            "members": AnyCodable(family.members),
            "virtualcard": AnyCodable(family.virtualcard),
            "id": AnyCodable(family.id),
        ]
    }
    
    
    static func paramsEmpty() -> [String: Any] {
        return [:]
    }
}

//MARK: API's

extension NetManager {
    
    static let API_Users = "users/"
    static let API_Families = "families/"
        
    
}



