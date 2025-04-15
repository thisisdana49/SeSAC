//
//  ComponentView.swift
//  SwiftUIBasic
//
//  Created by 조다은 on 4/14/25.
//

import SwiftUI

struct Genre: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let count: Int
}

struct ComponentView: View {
    @State var list: [Genre] = [
        Genre(name: "스릴러", count: 4),
        Genre(name: "SF", count: 64),
        Genre(name: "액션", count: 10),
        Genre(name: "액션", count: 10),
        Genre(name: "로맨스", count: 34)
    ]
    
    var body: some View {
        VStack {
            Button("추가하기") {
                print("추가")
                list.append(Genre(name: "test", count: Int.random(in: 1...100)))
            }
            .padding(50)
            .background(.green)
            ScrollView {
                LazyVStack {
                    ForEach(list, id: \.self) { item in
                        EventView(image: "star", name: item.name, count: item.count)
                    }
                }
            }
        }
    }
}

private struct EventView: View {
    let image: String
    let name: String
    let count: Int
    
    init(image: String, name: String, count: Int) {
        self.image = image
        self.name = name
        self.count = count
    }
    
    var body: some View {
        HStack {
            Image(systemName: "star")
            Text("\(name): \(count)")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

#Preview {
    ComponentView()
}
