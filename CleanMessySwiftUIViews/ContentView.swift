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
    static let examples: [User] = [ User(name: "John"), User(name: "Chloe")]
}


struct ContentView: View {
    @State private var users: [User] = [User.examples.randomElement()!]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    userRowView(user: user)
                }
            }
            .navigationTitle("Users")
            .toolbar {
                addButton
            }
        }
    }
    
    func userRowView(user: User) -> some View {
        HStack {
            profileImage(user: user)
            userName(user: user)
        }
    }
    
    func userName(user: User) -> some View {
        Text("\(user.name)")
            .font(.title)
            .padding(.leading)
            .bold()
    }
    
    func profileImage(user: User) -> some View {
        Image(user.name)
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.secondary)
            }
            .shadow(radius: 4, x:4, y:4)
    }
    
    var addButton: some View {
        Button {
            users.append(User.examples.randomElement()!)
        } label: {
            Image(systemName: "plus")
                .font(.title2)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
