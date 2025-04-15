//
//  PickerView.swift
//  SwiftUIBasic
//
//  Created by 조다은 on 4/15/25.
//

import SwiftUI

struct PickerView: View {
    let array = ["로맨스", "액션", "스릴러"]
    @State var selectedValue = "로맨스"
    var body: some View {
        VStack {
            Text("Selected Genre: \(selectedValue)")
                .padding()
            HStack {
                Button {
                    selectedValue = "로맨스"
                } label: {
                    Text("로맨스")
                }
                Button {
                    selectedValue = "액션"
                } label: {
                    Text("액션")
                }
                Button {
                    selectedValue = "스릴러"
                } label: {
                    Text("스릴러")
                }
            }
        }
    }
}

#Preview {
    PickerView()
}
