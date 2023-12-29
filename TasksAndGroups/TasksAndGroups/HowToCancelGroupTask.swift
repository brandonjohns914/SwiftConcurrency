//
//  HowToCancelGroupTask.swift
//  TasksAndGroups
//
//  Created by Brandon Johns on 12/29/23.
//

import SwiftUI

enum ExampleError: Error {
    case badURL
}

struct HowToCancelGroupTask: View {
    @State private var stories = [NewsStory]()
    var body: some View {
        NavigationView {
            List(stories) { story in
                VStack(alignment: .leading) {
                    Text(story.title)
                        .font(.headline)
                    
                    Text(story.strap)
                }
            }
            .navigationTitle("Latest News")
        }
        .task {
            await loadStories()
        }
    }
    func loadStories() async {
        do {
            try await withThrowingTaskGroup(of: [NewsStory].self) { group -> Void in
                for i in 1...5 {
                    group.addTask {
                        let url = URL(string: "https://hws.dev/news-\(i).json")!
                        let (data, _) = try await URLSession.shared.data(from: url)
                        try Task.checkCancellation()
                        return try JSONDecoder().decode([NewsStory].self, from: data)
                    }
                }
                
                for try await result in group {
                    if result.isEmpty {
                        group.cancelAll()
                    } else {
                        stories.append(contentsOf: result)
                    }
                }
                
                stories.sort { $0.id < $1.id }
            }
        } catch {
            print("Failed to load stories: \(error.localizedDescription)")
        }
    }
    
    func printMessage() async {
        let result = await withThrowingTaskGroup(of: String.self) { group -> String in
            group.addTask{ return "Testing"}
            group.addTask { return "Group"}
            group.addTask{return "Cancellation"}
            group.addTask {
                try Task.checkCancellation()
                return "Testing"
            }
            
            group.cancelAll()
            
            var collected = [String]()
            
            do {
                for try await value in group {
                    collected.append(value)
                }
            } catch {
                print(error.localizedDescription)
            }
            return collected.joined(separator: " ")
        }
    }
    func testCancellation() async {
        do {
               try await withThrowingTaskGroup(of: Void.self) { group -> Void in
                   group.addTask {
                       try await Task.sleep(nanoseconds: 1_000_000_000)
                       throw ExampleError.badURL
                   }

                   group.addTask {
                       try await Task.sleep(nanoseconds: 2_000_000_000)
                       print("Task is cancelled: \(Task.isCancelled)")
                   }

                   try await group.next()
               }
           } catch {
               print("Error thrown: \(error.localizedDescription)")
           }
    }
}

#Preview {
    HowToCancelGroupTask()
}
