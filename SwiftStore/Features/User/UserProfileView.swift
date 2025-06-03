//
//  UserProfileView.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        VStack {
            if let profile = viewModel.profile {
                VStack(spacing: 16) {
                    AsyncImage(url: URL(string: profile.avatar)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())

                    Text(profile.name)
                        .font(.title)
                        .bold()

                    Text(profile.email)
                        .foregroundColor(.gray)

                    Text("Role: \(profile.role)")
                        .font(.subheadline)
                }
                .padding()
            } else if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let error = viewModel.error {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            }
        }
        .task {
            await viewModel.fetchProfile()
        }
        .navigationTitle("My Profile")
    }
}

#Preview {
    UserProfileView()
}
