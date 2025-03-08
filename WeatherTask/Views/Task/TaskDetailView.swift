//
//  TaskDetailView.swift
//  WeatherTask
//
//  Created by Michael Winkler on 06.03.25.
//

import SwiftUI

struct TaskDetailView: View {
    let task: TaskItem
    
    var body: some View {
        VStack {
            Text(task.title).font(.largeTitle)
            Text(task.taskDescription).padding()
            Text("Date: \(task.date, style: .date)")
            if let weather = task.weather {
                Text("Weather: \(weather)")
            }
        }
        .navigationTitle("Task Details")
    }
}

#Preview {
    TaskDetailView(task: TaskItem(title: "", taskDescription: "", date: Date(), weather: nil))
}
