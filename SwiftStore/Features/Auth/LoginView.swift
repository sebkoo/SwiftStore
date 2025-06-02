//
//  LoginView.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var loggedIn = false

    var body: some View {
        if loggedIn {
            MainView()
        } else {
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .bold()

                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }

                Button("Log In") {
                    viewModel.login { success in
                        loggedIn = success
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
