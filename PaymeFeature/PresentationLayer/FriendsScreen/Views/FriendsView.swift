//
//  FriendsView.swift
//  PaymeFeature
//
//  Created by Dmitriy An on 04/04/25.
//

import SwiftUI

struct FriendsView: View {
    @StateObject var viewModel: FriendsViewModel
    @State private var searchCardNumber: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(viewModel.friends) { friend in
                            VStack {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Text(String(friend.name.prefix(1)))
                                            .foregroundColor(.white)
                                            .font(.title)
                                    )
                                Text(friend.name)
                                    .font(.caption)
                            }
                        }
                    }
                    .padding()
                }
                
                HStack {
                    TextField("Введите номер карты", text: $searchCardNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Добавить") {
                        viewModel.addFriend(byCardNumber: searchCardNumber)
                        searchCardNumber = ""
                    }
                    .padding(.horizontal, 8)
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Друзья")
        }
    }
}


extension FriendsViewModel {
    func updateFriends() {
        if let currentUser = LoginManager.shared.loggedInUser {
            self.friends = currentUser.friends ?? []
        }
    }
}


import SwiftUI

struct FriendsViewContainer: View {
    @ObservedObject var authManager = LoginManager.shared
    
    var body: some View {
        if let currentUser = authManager.loggedInUser {
            let friendsVM = FriendsViewModel(currentUser: currentUser, allUsers: authManager.users)
            FriendsView(viewModel: friendsVM)
        } else {
            Text("Пожалуйста, войдите, чтобы увидеть друзей")
                .foregroundColor(.gray)
        }
    }
}
