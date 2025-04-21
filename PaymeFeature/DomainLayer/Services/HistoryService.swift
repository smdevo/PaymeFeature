//
//  HistoryService.swift
//  PaymeFeature
//
//

import UIKit
import CoreData

protocol HistoryDataServiseProtocol {
    
    func fetchHistory() -> [MessageEntity]
    
//    func saveMessage(message: String, type: Sender)

}



final class HistoryDataServise: HistoryDataServiseProtocol {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchHistory() -> [MessageEntity] {
        let request: NSFetchRequest<MessageEntity> = MessageEntity.fetchRequest()
        do {
            let messages = try context.fetch(request)
            return messages
        } catch {
            print("Failed to fetch tasks: \(error)")
        }
        return []
    }
    
//    func saveMessage(message: String, type: Sender) {
//        let newMessage = MessageEntity(context: context)
//        newMessage.message = message
//        newMessage.type = type.rawValue
//        finalSave()
//    }
    
    
    private func finalSave() {
        do {
            try context.save()
        } catch {
            print("error-Saving data")
        }
    }
    
}
