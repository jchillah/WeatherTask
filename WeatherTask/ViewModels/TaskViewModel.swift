//
//  TaskViewModel.swift
//  WeatherTask
//
//  Created by Michael Winkler on 06.03.25.
//

import Combine
import Foundation

@MainActor
class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let db = DatabaseManager.shared
    
    /// Lädt die Tasks asynchron aus der Datenbank.
    func loadTasks() async {
        isLoading = true
        errorMessage = nil
        do {
            tasks = try await db.fetchTasks()
        } catch {
            errorMessage = "Failed to load tasks: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    /// Fügt eine neue Task hinzu und lädt anschließend die Tasks neu.
    func addTask(title: String, taskDescription: String, date: Date) async {
        let newTask = TaskItem(title: title, taskDescription: taskDescription, date: date)
        do {
            try await db.saveTask(newTask)
            await loadTasks()
        } catch {
            errorMessage = "Failed to add task: \(error.localizedDescription)"
        }
    }
    
    /// Löscht eine Task und lädt anschließend die Tasks neu.
    func deleteTask(_ task: TaskItem) async {
        do {
            try await db.deleteTask(task)
            await loadTasks()
        } catch {
            errorMessage = "Failed to delete task: \(error.localizedDescription)"
        }
    }
}


//class TaskViewModel: ObservableObject {
//    @Published var tasks: [TaskItem] = []
//    private let db = DatabaseManager.shared
//    
//    @MainActor func loadTasks() {
//        tasks = db.fetchTasks()
//    }
//    
//    @MainActor func addTask(
//        title: String,
//        taskDescription: String,
//        date: Date
//    ) {
//        let newTask = TaskItem(title: title, taskDescription: taskDescription, date: date)
//        db.saveTask(newTask)
//        loadTasks()
//    }
//    
//    @MainActor func deleteTask(_ task: TaskItem) {
//        db.deleteTask(task)
//        loadTasks()
//    }
//}
