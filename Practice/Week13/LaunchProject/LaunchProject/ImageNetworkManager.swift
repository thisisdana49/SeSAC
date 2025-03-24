//
//  ImageNetworkManager.swift
//  LaunchProject
//
//  Created by 조다은 on 3/19/25.
//

import UIKit

/*
 GCD vs Swift Concurrency
  - completion handler
  - 비동기를 동기처럼
  
  - Thread Explosion
  - Context Switching
  -> 코어의 수와 쓰레드의 수를 같게
  -> 같은 쓰레드 내에서 Continuation 전환 형식으로 방식을 변경
  
  - async throws / try await : 비동기를 동기처럼
  - Task : 비동기 함수와 동기 함수를 연결
  - async let, taskGroup : (ex. dispatchGroup)
 */

enum JackError: Error {
    case invalidResponse
    case unknown
    case invalidImage
}

class ImageNetworkManager {
    
    static let shared = ImageNetworkManager()
    private init() { }
    
    static let url = URL(string: "https://picsum.photos/200/300")!
    
    func fetchThumbnail(completion: @escaping (UIImage) -> Void) {
        
        
        DispatchQueue.global().async {
            
            if let data = try? Data(contentsOf: ImageNetworkManager.url) {
                
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
    
    func fetchThumbnailURLSession(
        completion: @escaping (Result<UIImage, JackError>) -> Void) {
            let request = URLRequest(url: ImageNetworkManager.url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data else {
                    completion(.failure(.unknown))
                    return
                }
                
                guard error == nil else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    completion(.failure(.invalidImage))
                    return
                }
                
                completion(.success(image))
                
            }.resume()
            
        }
    
    func fetchAsyncAwait() async throws -> UIImage { // 오로지 성공 데이터
        let request = URLRequest(url: ImageNetworkManager.url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5)
        
        // async: data~~ 함수는 비동기로 동작할 함수입니다. (== DispatchQueue.global.async
        // await: 비동기 함수가 동작할 예정이니, 응답이 올 때까지 이 코드에서 기다리세요.
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw JackError.invalidResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw JackError.invalidImage
        }
        
        return UIImage(data: data)!
    }
    
    func fetchAsyncLet() async throws -> [UIImage] {
        async let one = ImageNetworkManager.shared.fetchAsyncAwait()
        async let two = ImageNetworkManager.shared.fetchAsyncAwait()
        async let three = ImageNetworkManager.shared.fetchAsyncAwait()
        
        return try await [one, two, three]
        // 하지만 통신 요청 수가 유동적일 경우 활용할 수 없음.
    }
    
    func fetchTaskGroup() async throws -> [UIImage] {
        
        return try await withThrowingTaskGroup(of: UIImage.self) { group in
            for item in 0..<10 {
                group.addTask {
                    try await self.fetchAsyncAwait()
                }
            }
            
            var resultImages: [UIImage] = []
            
            for try await item in group {
                resultImages.append(item)
            }
            return resultImages
        }
    }
    
}
