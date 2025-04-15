//
//  ContentView.swift
//  SwiftUIBasic
//
//  Created by 조다은 on 4/9/25.
//

struct User {
    
    var nickname = "고래밥"
    
    var introduce: String {
        mutating get {
            nickname = "칙촉"
            return "안녕하세요 \(nickname) 입니다"
        }
    }
}

import SwiftUI

struct ContentView: View {
    @State var nickname = "고래밥"
    
    var body: some View {
        get {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                Button("버튼") {
//                    nickname = "칙촉"
//                    print("\(nickname)이 클릭 되었습니다")
                    let value = type(of: self.body)
                    print(value)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
