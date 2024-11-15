import Alamofire
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?

    private let baseURL = "http://your-backend-url.com/api/auth"

    func login() {
        let parameters: [String: String] = ["email": email, "password": password]

        AF.request("\(baseURL)/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                        print("Welcome, \(user.email)")
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                        print("Login failed: \(error.localizedDescription)")
                    }
                }
            }
    }

    func register() {
        let parameters: [String: String] = ["email": email, "password": password]

        AF.request("\(baseURL)/register", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    DispatchQueue.main.async {
                        print("Registration successful")
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                        print("Registration failed: \(error.localizedDescription)")
                    }
                }
            }
    }
}
