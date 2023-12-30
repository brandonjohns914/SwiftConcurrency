//
//  ActorHopping.swift
//  Actors
//
//  Created by Brandon Johns on 12/29/23.
//

import SwiftUI

struct User: Identifiable {
    let id: Int
}


actor Database {
    func loadUsers(ids: [Int]) -> [User] {
        // complex work to load users from the database
        // happens here; we'll just send back examples
        ids.map { User(id: $0) }
    }
}

@MainActor
class DataModel: ObservableObject {
    @Published var users = [User]()
    var database = Database()

    func loadUsers() async {
        let ids = Array(1...100)

        // Load all users in one hop
        let newUsers = await database.loadUsers(ids: ids)

        // Now back on the main actor, update the UI
        users.append(contentsOf: newUsers)
    }
}


struct ActorHopping: View {
    @StateObject var model = DataModel()

       var body: some View {
           List(model.users) { user in
               Text("User \(user.id)")
           }
           .task {
               await model.loadUsers()
           }
       }
}

#Preview {
    ActorHopping()
}

actor NumberGenerator {
    var lastNumber = 1

    func getNext() -> Int {
        defer { lastNumber += 1 }
        return lastNumber
    }

    @MainActor func run() async {
        for _ in 1...100 {
            let nextNumber = await getNext()
            print("Loading \(nextNumber)")
        }
    }
}
