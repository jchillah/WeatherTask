//
//  DatabaseManager.swift
//  WeatherTask
//
//  Created by Michael Winkler on 06.03.25.
//

import Foundation
import SwiftData

class DatabaseManager {
    static let shared = DatabaseManager()
    private let container: ModelContainer
    
    private init() {
        let schema = Schema([TaskItem.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        // Sicherstellen, dass der Container erfolgreich erstellt wird
        do {
            self.container = try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Fehler beim Erstellen des ModelContainers: \(error.localizedDescription)")
        }
    }
    
    @MainActor func fetchTasks() async throws -> [TaskItem] {
        let context = container.mainContext
        let fetchDescriptor = FetchDescriptor<TaskItem>()
        do {
            // Versuche, die Tasks zu laden
            return try context.fetch(fetchDescriptor)
        } catch {
            // Fehlerbehandlung: Logge den Fehler und gib ein leeres Array zurück
            print("Fehler beim Laden der Tasks: \(error.localizedDescription)")
            return []
        }
    }
    
    @MainActor func saveTask(_ task: TaskItem) async throws{
        let context = container.mainContext
        context.insert(task)
        do {
            // Versuche, die Daten zu speichern
            try context.save()
        } catch {
            // Fehlerbehandlung: Logge den Fehler
            print("Fehler beim Speichern der Aufgabe: \(error.localizedDescription)")
        }
    }
    
    @MainActor func deleteTask(_ task: TaskItem) async throws{
        let context = container.mainContext
        context.delete(task)
        do {
            // Versuche, die Aufgabe zu löschen
            try context.save()
        } catch {
            // Fehlerbehandlung: Logge den Fehler
            print("Fehler beim Löschen der Aufgabe: \(error.localizedDescription)")
        }
    }
}
