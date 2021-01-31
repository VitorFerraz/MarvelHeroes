import CoreData

class DatabaseController {
    
    fileprivate static let instanceName: String = "CoreData"
    
    static var context: NSManagedObjectContext {
        return DatabaseController.persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: instanceName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func saveContext () {
        
        if DatabaseController.context.hasChanges {
            do {
                try DatabaseController.context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func delete(object : NSManagedObject) {
        DatabaseController.context.delete(object)
        saveContext()
    }
}
