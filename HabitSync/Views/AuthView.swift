import SwiftUI

struct AuthView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var isLoginMode = true

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text(isLoginMode ? "Welcome Back" : "Create an Account")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.primary)
                .padding(.top, 50)

            Spacer()

            // Input Fields
            VStack(spacing: 16) {
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 20)

            // Action Button
            Button(action: {
                if isLoginMode {
                    viewModel.login()
                } else {
                    viewModel.register()
                }
            }) {
                Text(isLoginMode ? "Login" : "Sign Up")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 20)

            // Toggle Mode Button
            Button(action: {
                isLoginMode.toggle()
            }) {
                Text(isLoginMode ? "Don't have an account? Sign Up" : "Already have an account? Login")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color.blue)
            }
            .padding(.bottom, 20)

            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}
