//
//  OrderBookViewController.swift
//  LaunchProject
//
//  Created by 조다은 on 3/26/25.
//

import UIKit

class WebSocketManager {
    static let shared = WebSocketManager()
    
    private var webSocket: URLSessionWebSocketTask?
    
    private init() { }
    
    func connect() {
        guard let url = URL(string: "wss://api.upbit.com/websocket/v1") else { return }
        
        let session = URLSession(configuration: .default)
        webSocket = session.webSocketTask(with: url)
        // 터널 연결
        webSocket?.resume()
        receiveMessage()
    }
    
    // 1. 터널 만드는...
    // 2. 어떤 정보를 원하는데?
    func send() {
        webSocket?.send(.string(
            "[{\"ticket\":\"test\"},{\"type\":\"orderbook\",\"codes\":[\"KRW-BTC\"]}]"
            ), completionHandler: { error in
            if let error = error {
                print("Send Error", error)
            }
            print(#function)
        })
    }
    
    func receiveMessage() {
        webSocket?.receive(completionHandler: { result in
            print("result", result)
            
            switch result {
            case .success(let success):
                switch success {
                    
                case .data(let value):
                    print("DATA RESULT", value) // Decoding -> Struct
                case .string(let value):
                    print("STRING RESULT", value)
                @unknown default:
                    print("unknown default")
                }
            case .failure(let failure):
                print(failure)
            }
            
            self.receiveMessage()
        })
    }
    
    func disconnect() {
        // 터널 해제
        webSocket?.cancel(with: .goingAway, reason: nil)
        webSocket = nil
    }
}

class OrderBookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        WebSocketManager.shared.connect()
        WebSocketManager.shared.send()
    }

}
