import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EndoNutrition")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Impossibile caricare i CoreData store: \(error)")
            }
        }
        return container
    }()
    
    private init() {}
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Errore nel salvataggio del context: \(error)")
            }
        }
    }
    
    // MARK: - Generic CRUD Operations
    
    func create<T: NSManagedObject>(_ entity: T.Type) -> T {
        return T(context: context)
    }
    
    func fetch<T: NSManagedObject>(_ entity: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entity))
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Errore nel recupero delle entità \(entity): \(error)")
            return []
        }
    }
    
    func fetchFirst<T: NSManagedObject>(_ entity: T.Type, predicate: NSPredicate? = nil) -> T? {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entity))
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Errore nel recupero dell'entità \(entity): \(error)")
            return nil
        }
    }
    
    func delete<T: NSManagedObject>(_ object: T) {
        context.delete(object)
        saveContext()
    }
    
    func deleteAll<T: NSManagedObject>(_ entity: T.Type) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: entity))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: context)
        } catch {
            print("Errore nell'eliminazione di tutte le entità \(entity): \(error)")
        }
    }
    
    func count<T: NSManagedObject>(_ entity: T.Type, predicate: NSPredicate? = nil) -> Int {
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entity))
        fetchRequest.predicate = predicate
        
        do {
            return try context.count(for: fetchRequest)
        } catch {
            print("Errore nel conteggio delle entità \(entity): \(error)")
            return 0
        }
    }
    
    // MARK: - Reset All Data
    
    func resetAllData() {
        // Ottiene i nomi di tutte le entità nel modello
        let entityNames = persistentContainer.managedObjectModel.entities.compactMap { $0.name }
        
        // Elimina tutte le entità
        for entityName in entityNames {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: context)
            } catch {
                print("Errore nell'eliminazione delle entità \(entityName): \(error)")
            }
        }
        
        // Esegue un reset del context per assicurarsi che tutte le modifiche siano applicate
        context.reset()
        
        print("Tutti i dati sono stati eliminati dal database CoreData")
    }
    
    // MARK: - Query Helpers
    
    func createPredicate(format: String, arguments: [Any]) -> NSPredicate {
        return NSPredicate(format: format, argumentArray: arguments)
    }
    
    func createAndPredicate(predicates: [NSPredicate]) -> NSPredicate {
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
    
    func createOrPredicate(predicates: [NSPredicate]) -> NSPredicate {
        return NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
    }
    
    func createSortDescriptor(key: String, ascending: Bool = true) -> NSSortDescriptor {
        return NSSortDescriptor(key: key, ascending: ascending)
    }
}
