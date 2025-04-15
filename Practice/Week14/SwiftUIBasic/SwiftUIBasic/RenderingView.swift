//
//  RenderingView.swift
//  SwiftUIBasic
//
//  Created by 조다은 on 4/14/25.
//

import SwiftUI

struct RenderingView: View {
    
    @State var age = 20
    
    var body: some View {
        Text("Hue: \(age)")
            .font(.largeTitle)
            .padding()
            .background(Color.random())
        Jack(age: age)
        bran()
        den

        Button("Click Button") {
            print("button clicked")
            age = Int.random(in: 1...100)
        }
    }
    
    var den: some View {
        Text("Den: \(age)")
            .font(.largeTitle)
            .padding()
            .background(Color.random())
    }
    
    func bran() -> some View {
        Text("Bran: \(age)")
            .font(.largeTitle)
            .padding()
            .background(Color.random())
    }
    
    init() {
        print("RenderingView View Init")
    }
}

struct Jack: View {
    
    let age: Int
    var body: some View {
        Text("Jack: \(age)")
            .font(.largeTitle)
            .padding()
            .background(Color.random())
    }
    
    init(age: Int) {
        self.age = age
        print("Jack View Init")
    }
}

extension Color {
    static func random() -> Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1)
        )
    }
}

#Preview {
    RenderingView()
}
