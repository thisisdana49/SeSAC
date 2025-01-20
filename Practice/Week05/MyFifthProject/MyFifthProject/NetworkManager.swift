//
//  NetworkManager.swift
//  MyFifthProject
//
//  Created by 조다은 on 1/20/25.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    static let url = URL(string: "https://picsum.photos/200/300")! // Instance X, Type O
    
    private init() { }
    
    func fetchImage(completionHandler: @escaping (UIImage) -> Void) {
        print(#function)
        
        DispatchQueue.global().async {
            // Data(contentsOf: url)은 동기 처리 작업
            if let data = try? Data(contentsOf: NetworkManager.url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completionHandler(image)
                    }
                }
            }
        }
    }
}
