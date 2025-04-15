//
//  PurpleBorderText.swift
//  SwiftUIBasic
//
//  Created by 조다은 on 4/14/25.
//

import SwiftUI

private struct PurpleBorderText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding(10)
            .asForeground(.yellow)
            .background(.purple)
            .clipShape(.capsule)
    }
}

extension View {
    func asPurpleBorderText() -> some View {
        modifier(PurpleBorderText())
    }
}
