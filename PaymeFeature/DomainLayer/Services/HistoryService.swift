//
//  HistoryService.swift
//  PaymeFeature
//
//

import UIKit
import CoreData

protocol HistoryDataServiseProtocol {
    
    func fetchHistory() -> [MessageEntity]
    
    func saveMessage(message: String, type: Sender)
//
//    func removeCalculation(indexPath: Int, items: [MessageEntity])
//    
//    func clearHistory()
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
    
    func saveMessage(message: String, type: Sender) {
        let newMessage = MessageEntity(context: context)
        //newCalculation.date = Date()
        newMessage.message = message
        newMessage.type = type.rawValue
        finalSave()
    }
    
    
//    func removeCalculation(indexPath: Int, items: [Calculation]) {
//        let dataToRemove = items[indexPath]
//        context.delete(dataToRemove)
//        finalSave()
//    }
//    
//    func clearHistory() {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Calculation.fetchRequest()
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        
//        do {
//            try context.execute(deleteRequest)
//            try context.save()
//        } catch {
//            print("Failed to delete history: \(error)")
//        }
//    }
    
    private func finalSave() {
        do {
            try context.save()
        } catch {
            print("error-Saving data")
        }
    }
    
}
