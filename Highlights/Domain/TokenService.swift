//
//  TokenService.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 04/04/2022.
//

import Foundation
import Alamofire

class TokenService {
    
    // MARK: Properties
    private struct Token: Decodable {
        let access_token: String?
        let token_type: String?
        let expires_in: Int?
        let scope: String?
        let user_id: Int?
        let refresh_token: String?
        let message: String?
    }
    
    // MARK: APP TG
    private let appTG = "TG-624c3f6f10a237001cfff77c-162557220"
    
    private let url = "https://api.mercadolibre.com/oauth/token"
    
    private let headers: HTTPHeaders = [
        "Accept": "application/json",
        "Content-Type":"application/x-www-form-urlencoded"
    ]
    
    // Lazy vars to be able to use stored properties.
    private lazy var parameters: Parameters = {
        return [
            "grant_type": "authorization_code",
            "client_id": "6883177076370857",
            "client_secret": "MZesx4z0qmpFh1yQpNr5nmpan4xOwTXI",
            "code": self.appTG,
            "redirect_uri": "https://www.google.com.ar"
        ]
    }()
    
    private lazy var refreshToken: String = {
        let defaults = UserDefaults.standard
        guard let token = defaults.object(forKey: "refreshToken") as? String else { return "" }
        return token
    }()
    
    private lazy var refreshParameters: Parameters = {
        return [
            "grant_type": "refresh_token",
            "client_id": "6883177076370857",
            "client_secret": "MZesx4z0qmpFh1yQpNr5nmpan4xOwTXI",
            "refresh_token": self.refreshToken,
        ]
    }()
    
    private let apiClient = AlamofireAPIClient()
    
    // MARK: Methods
    func getToken(completion: @escaping (String) -> Void) {
        apiClient.post(url: self.url, parameters: self.parameters, headers: self.headers) { response in
            switch response {
            case .success(let data):
                do {
                    if let jsonData = data {
                        let receivedToken = try JSONDecoder().decode(Token.self, from: jsonData)
                        if let message = receivedToken.message {
                            completion(message)
                        }
                        if let accessToken = receivedToken.access_token, let refreshT = receivedToken.refresh_token {
                            self.saveTokens(accessToken, refreshT)
                            self.refreshToken = refreshT
                            completion(accessToken)
                        }
                    }
                } catch {
                    print(error)
                    completion("Error decoding token")
                }
            case .failure(let error):
                print(error)
                completion("Error getting token.")
            }
        }
    }
    
    // Get another token using refresh token
    func getRefreshToken(completion: @escaping (String) -> Void) {
            apiClient.post(url: self.url, parameters: self.refreshParameters, headers: self.headers) { response in
                switch response {
                case .success(let data):
                    do {
                        if let jsonData = data {
                            let receivedToken = try JSONDecoder().decode(Token.self, from: jsonData)
                            if let message = receivedToken.message {
                                completion(message)
                            }
                            if let accessToken = receivedToken.access_token, let refreshT = receivedToken.refresh_token {
                                self.saveTokens(accessToken, refreshT)
                                self.refreshToken = refreshT
                                completion(accessToken)
                            }
                        }
                    } catch {
                        print(error)
                        completion("Error decoding refresh token")
                        }
                case .failure(let error):
                    print(error)
                    completion("Error getting refresh token.")
                    }
            }
    }
    
    // Save tokens to User Defaults
    private func saveTokens(_ accessToken: String,_ refreshToken: String) {
        let defaults = UserDefaults.standard
        defaults.set(accessToken, forKey: "accessToken")
        defaults.set(refreshToken, forKey: "refreshToken")
    }
    
}

// MARK: Public
extension TokenService {
    
    public func testToken(_ token: String, completion: @escaping (Bool) -> Void) {
        let authHeader = HTTPHeader(name: "Authorization", value: "Bearer \(token)")
        let headers = HTTPHeaders([authHeader])
        
        let url = "https://api.mercadolibre.com/highlights/MLA/category/MLA428934"
        apiClient.get(url: url, headers: headers) { response in
            switch response {
            case .success(let data):
                do {
                    if let jsonData = data {
                        let receivedData = try JSONDecoder().decode(Highlights.self, from: jsonData)
                        if receivedData.message == "invalid_token" {
                            completion(false)
                        } else {
                            //print(receivedData) // Used for testing purposes
                            completion(true)
                        }
                    }
                } catch {
                    print("Error decoding test Categories")
                    print(error)
                }
            case .failure(let error):
                print("Error getting test Categories")
                print(error)
            }
        }
    }
    
}
