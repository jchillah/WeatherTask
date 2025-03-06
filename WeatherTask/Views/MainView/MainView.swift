//
//  MainView.swift
//  WeatherTask
//
//  Created by Michael Winkler on 17.02.25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    @StateObject var viewModel: TaskViewModel
    @State private var isAddTaskSheetPresented = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Current Temperature: \(weatherViewModel.temperature)")
                    .font(.headline)
                    .padding()
                
                List {
                    ForEach(viewModel.tasks) { task in
                        NavigationLink(destination: TaskDetailView(task: task)) {
                            Text(task.title)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            Task {
                                await viewModel.deleteTask(viewModel.tasks[index])
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("Tasks")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            isAddTaskSheetPresented = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $isAddTaskSheetPresented) {
                    AddTaskView(viewModel: TaskViewModel())
                }
                .onAppear {
                    Task {
                        await viewModel.loadTasks()
                        await weatherViewModel.fetchWeather()
                    }
                }
            }
        }
    }
}

#Preview {
    MainView(viewModel: TaskViewModel())
}
