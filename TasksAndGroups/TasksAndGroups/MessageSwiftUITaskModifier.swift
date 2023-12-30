//
//  MessageSwiftUITaskModifier.swift
//  TasksAndGroups
//
//  Created by Brandon Johns on 12/29/23.
//

import SwiftUI

struct MessageSwiftUITaskModifier: View {
    @State private var messages = [Message]()
    @State private var selectedBox = "Inbox"
    let messageBoxes = ["Inbox", "Sent"]
    var body: some View {
        NavigationView {
            List(messages) { message in
                VStack (alignment: .leading) {
                    Text(message.from)
                        .font(.headline)
                    Text(message.text)
                }
            }
            .navigationTitle("Inbox")
            .task(id: selectedBox) {
                await fetchData()
                if selectedBox == messageBoxes[0] {
                    await loadMessages()
                }
            }
            .toolbar {
                Picker("Select a sent box", selection: $selectedBox) {
                    ForEach(messageBoxes, id: \.self, content: Text.init )
                }
                .pickerStyle(.segmented)
            }
        }
    }
    func loadMessages() async {
        do {
            let url = URL(string: "https://hws.dev/messages.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            messages = try JSONDecoder().decode([Message].self, from: data)
        } catch {
            messages = [
                Message(id: 0, from: "Failed to load inbox.", text: "Please try again later.")
            ]
        }
    }
    
    func fetchData() async {
        do {
                    let url = URL(string: "https://hws.dev/\(selectedBox.lowercased()).json")!
                    let (data, _) = try await URLSession.shared.data(from: url)
                    messages = try JSONDecoder().decode([Message].self, from: data)
                } catch {
                    messages = [
                        Message(id: 0, from: "Failed to load message box.", text: "Please try again later.")
                    ]
                }
            
    }

}

#Preview {
    MessageSwiftUITaskModifier()
}
