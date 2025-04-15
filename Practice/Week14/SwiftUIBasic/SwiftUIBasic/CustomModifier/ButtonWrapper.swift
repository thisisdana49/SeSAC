//
//  ButtonWrapper.swift
//  SwiftUIBasic
//
//  Created by 조다은 on 4/15/25.
//

import SwiftUI

private struct ButtonWrapper: ViewModifier {
    
    let action: () -> Void
    
    func body(content: Content) -> some View {
        Button (
            action: action,
            label: { content }
        )
        .foregroundStyle(.white)
        .padding()
        .background(Color.green)
        .clipShape(.capsule)
    }
    
}

extension View {
    
    func wrapToButton(action: @escaping () -> Void) -> some View {
        modifier(ButtonWrapper(action: action))
    }
    
}
