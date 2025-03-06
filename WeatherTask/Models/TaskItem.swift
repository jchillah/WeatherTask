//
//  TaskItem.swift
//  WeatherTask
//
//  Created by Michael Winkler on 06.03.25.
//

import SwiftData
import Foundation

@Model
class TaskItem: Identifiable {
    @Attribute(.unique) var id: UUID
    var title: String
    var taskDescription: String
    var date: Date
    var weather: String?
    
    init(id: UUID = UUID(), title: String, taskDescription: String, date: Date, weather: String? = nil) {
        self.id = id
        self.title = title
        self.taskDescription = taskDescription
        self.date = date
        self.weather = weather
    }
}
