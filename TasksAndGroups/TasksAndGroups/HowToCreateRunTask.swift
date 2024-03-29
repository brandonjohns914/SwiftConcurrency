//
//  HowToCreateRunTask.swift
//  TasksAndGroups
//
//  Created by Brandon Johns on 12/28/23.
//

import SwiftUI

struct NewsItem: Decodable {
    
    let id: Int
    let title: String
    let url: URL
    
}

struct HighScore: Decodable {
    let name: String
    let score: Int
}

func fetchUpdates() async {
    let newTask = Task { () -> [NewsItem] in
        let url = URL(string: "https://hws.dev/headlines.json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([NewsItem].self, from: data)
    }
    
    let highScoreTask = Task { () -> [HighScore] in
        let url = URL(string: "https://hws.dev/scores.json")!
                let (data, _) = try await URLSession.shared.data(from: url)
                return try JSONDecoder().decode([HighScore].self, from: data)
    }
    
    do {
        let news = try await newTask.value
        let highScores = try await highScoreTask.value
        print("Latest news loaded with \(news.count) items")
        
        if let topScore = highScores.first {
            print("\(topScore.name) has the highest score with \(topScore.score), out of \(highScores.count) total results.")
        }
    } catch {
        print("Error loading data")
    }
    
}

func updates() async {
    await fetchUpdates()
}


struct HowToCreateRunTask: View {
    @State private var messages = [Message]()
    var body: some View {
        NavigationView {
            Group {
                if messages.isEmpty {
                    Button("Load messages") {
                        Task { 
                            await loadMessages()
                        }
                    }
                } else {
                    List(messages) { message in
                        VStack(alignment: .leading) {
                            Text(message.from)
                                .font(.headline)
                            
                            Text(message.text)
                        }
                    }
                }
            }
            .navigationTitle("Inbox")
        }
    }
    func loadMessages() async {
        do {
            let url = URL(string: "https://hws.dev/messages.json")!
                      let (data, _) = try await URLSession.shared.data(from: url)
                      messages = try JSONDecoder().decode([Message].self, from: data)
        } catch {
            messages = [
                Message(id: 0, from: "FAiled to load inbox", text: " please try again ")
            ]
        }
    }
}

#Preview {
    HowToCreateRunTask()
}
