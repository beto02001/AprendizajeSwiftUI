//
//  DragGesture.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 02/01/26.
//

import SwiftUI

struct DragGestureVista: View {
    
    @State var position: CGSize = .zero
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 100, height: 100)
            .foregroundColor(.orange)
            .overlay(Text("Drag me").bold().foregroundStyle(.white))
            .offset(position)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        position = value.translation
                    })
                    .onEnded { _ in
                        withAnimation(.spring) {
                            position = .zero
                        }
                    }
                    
            )
    }
}

#Preview {
    DragGestureVista()
}
