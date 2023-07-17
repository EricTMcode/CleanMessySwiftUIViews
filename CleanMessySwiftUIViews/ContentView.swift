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
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    ForEach(users) { user in
                        userRowView(user: user)
                    }
                    .onDelete { users.remove(atOffsets: $0) }
                }
                .navigationTitle("Users")
                .toolbar {
                    addButton
                }
            }
            if users.isEmpty {
                userInstructions
            }
        }
    }
}

extension ContentView {
    var userInstructions: some View {
        
        var userInstructionText: some View {
            VStack {
                Text("There no users")
                Text("Please click the \"+\" button to add new user")
            }
            .foregroundColor(.secondary)
        }
        
        var animatedArrow: some View {
            VStack {
                HStack {
                    Spacer()
                    Image("diagonal-arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .offset(x: -40, y: 20)
                        .opacity(isAnimating ? 1.0 : 0.5)
                        .scaleEffect(isAnimating ? 1.0 : 0.5)
                        .animation(.linear(duration: 1.0).repeatForever(), value: isAnimating)
                        .onAppear {
                            isAnimating = true
                        }
                        .onDisappear {
                            isAnimating = false
                        }
                }
                Spacer()
            }
        }
        
        return ZStack {
            userInstructionText
            animatedArrow
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
