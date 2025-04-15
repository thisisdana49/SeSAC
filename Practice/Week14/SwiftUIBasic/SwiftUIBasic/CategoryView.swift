//
//  CategoryView.swift
//  SwiftUIBasic
//
//  Created by 조다은 on 4/15/25.
//

import SwiftUI

struct CategoryView: View {
    // State가 달라지면 body Rendering
    // View의 상태를 저장하고 변화를 관찰해 View를 업데이트 하는 것이 State의 역할
    @State private var genre = "로맨스"
    // : Why private?
    // -> Being for current 'View', therefore It must be private that can't be accessed outside of View
    // Source Of Truth
    
    var body: some View {
        VStack {
            Text("선택 장르: \(genre)")
            HStack {
                
                HStack{
                    Image(systemName: "heart.fill")
                    Text("로맨스")
                }
                .wrapToButton {
                    genre = "로맨스"
                }

                HStack {
                    Image(systemName: "heart.fill")
                    Text("액션")
                }
                .wrapToButton {
                    genre = "액션"
                }


                HStack {
                    Image(systemName: "heart.fill")
                    Text("스릴러")
                }
                .wrapToButton {
                    genre = "스릴러"
                }
                
            }
        }
    }
}

#Preview {
    CategoryView()
}
