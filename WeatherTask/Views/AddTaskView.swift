//
//  AddTaskView.swift
//  WeatherTask
//
//  Created by Michael Winkler on 06.03.25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var taskDescription = ""
    @State private var date = Date()
    let viewModel: TaskViewModel
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Description", text: $taskDescription)
            DatePicker("Date", selection: $date, in: Date()...)
            Button("Add Task") {
                Task {
                    await viewModel.addTask(title: title, taskDescription: taskDescription, date: date)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddTaskView(viewModel: TaskViewModel())
}
