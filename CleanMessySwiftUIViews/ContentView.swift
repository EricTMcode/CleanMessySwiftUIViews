//
//  ContentView.swift
//  CleanMessySwiftUIViews
//
//  Created by Eric on 17/07/2023.
//
// Clean up messy SwiftUI View
// 1. computed var
// 2. functions
// 3. extensions
//
// Users, Add, Delete.
// Animated user instruction

import SwiftUI

struct User: Identifiable {
    var id = UUID()
    var name = ""
    static let example: [User] = [ User(name: "John"), User(name: "Chloe")]
}


struct ContentView: View {
    @State private var users: [User] = [User.example.randomElement()!]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    HStack {
                        Text("\(user.name)")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
