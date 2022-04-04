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
    private let appTG = "TG-624b545692fb51001b3d79ba-162557220"
    
    private let url = "https://api.mercadolibre.com/oauth/token"
    
    private let headers: HTTPHeaders = [
        "Accept": "application/json",
        "Content-Type":"application/x-www-form-urlencoded"
    ]
    
    // Lazy var to be able to use appTG.
    
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
//        if let refreshToken = refreshToken {
        return [
            "grant_type": "refresh_token",
            "client_id": "6883177076370857",
            "client_secret": "MZesx4z0qmpFh1yQpNr5nmpan4xOwTXI",
            "refresh_token": self.refreshToken,
        ]
//        }
//        return [String:Any]()
    }()
    
    private let apiClient = AlamofireAPIClient()
    
    // MARK: Methods
    func getToken(completion: @escaping (String) -> Void) {
        // TODO: Refresh token.
        apiClient.post(url: self.url, parameters: self.parameters, headers: self.headers) { response in
            switch response {
            case .success(let data):
                do {
                    if let dataOK = data {
                        print(dataOK)
                        let receivedToken = try JSONDecoder().decode(Token.self, from: dataOK)
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
                    completion("Error getting token")
                }
            case .failure(let error):
                print(error)
                completion("Error getting token.")
            }
        }
    }
    
    func getRefreshToken(completion: @escaping (String, String) -> Void) {
//        if self.refreshToken != nil {
            apiClient.post(url: self.url, parameters: self.refreshParameters, headers: self.headers) { response in
                switch response {
                case .success(let data):
                    do {
                        if let dataOK = data {
                            print(dataOK)
                            let receivedToken = try JSONDecoder().decode(Token.self, from: dataOK)
                            if let message = receivedToken.message, let refreshT = receivedToken.refresh_token {
                                completion(message, refreshT)
                            }
                            if let accessToken = receivedToken.access_token, let refreshT = receivedToken.refresh_token {
                                self.saveTokens(accessToken, refreshT)
                                self.refreshToken = refreshT
                                completion(accessToken, refreshT)
                            }
                        }
                    } catch {
                        print(error)
                        completion("Error getting token", "asdasd")
                        }
                case .failure(let error):
                    print(error)
                    completion("Error getting token.","asdasd")
                    }
            }
//        }
    }
    
    private func saveTokens(_ accessToken: String,_ refreshToken: String) {
        let defaults = UserDefaults.standard
        defaults.set(accessToken, forKey: "accessToken")
        defaults.set(refreshToken, forKey: "refreshToken")
    }
}
