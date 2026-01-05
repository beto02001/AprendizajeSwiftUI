//
//  GeometryReaderStack.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 04/01/26.
//

import SwiftUI

struct GeometryReaderStack: View {
    var body: some View {
        VStack {
            GeometryReader { proxy in
                VStack {
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.cyan)
                            .overlay(Text("BBVA").foregroundColor(.white))
                            .frame(width: proxy.size.width/2, height: proxy.size.height/2)
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.red)
                            .overlay(Text("Santander").foregroundColor(.white))
                            .frame(width: proxy.size.width/2, height: proxy.size.height/2)
                    }
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.purple)
                        .overlay(Text("Nu").foregroundColor(.white))
                        .frame(width: proxy.size.width, height: proxy.size.height*0.33)
                }
            }
            .background(.gray)
        }
    }
}

#Preview {
    GeometryReaderStack()
}
