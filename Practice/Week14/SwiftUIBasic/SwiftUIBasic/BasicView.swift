//
//  BasicView.swift
//  SwiftUIBasic
//
//  Created by 조다은 on 4/14/25.
//

import SwiftUI

struct BasicView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .asPurpleBorderText()
        Image(systemName: "star")
    }
}

#Preview {
    BasicView()
}

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}
