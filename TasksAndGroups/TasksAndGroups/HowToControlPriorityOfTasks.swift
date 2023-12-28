//
//  HowToControlPriorityOfTasks.swift
//  TasksAndGroups
//
//  Created by Brandon Johns on 12/28/23.
//

import SwiftUI

struct HowToControlPriorityOfTasks: View {
    @State private var jokeText = ""
    @State private var quoteText = ""
    var body: some View {
        VStack {
            Text(jokeText)
            Button("Fetch new Joke", action: fetchJoke)
            
           
        }
    }

    func fetchJoke()  {
        Task {
                   let url = URL(string: "https://icanhazdadjoke.com")!
                   var request = URLRequest(url: url)
                   request.setValue("Swift Concurrency by Example", forHTTPHeaderField: "User-Agent")
                   request.setValue("text/plain", forHTTPHeaderField: "Accept")

                   let (data, _) = try await URLSession.shared.data(for: request)

                   if let jokeString = String(data: data, encoding: .utf8) {
                       jokeText = jokeString
                   } else {
                       jokeText = "Load failed."
                   }
               }
           }
    
}

#Preview {
    HowToControlPriorityOfTasks()
}
