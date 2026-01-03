//
//  LazyHGridVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 27/12/25.
//

import SwiftUI

struct LazyHGridVista: View {
    var body: some View {
        let items = 1...500
        let rows: [GridItem] = [.init(.fixed(100)), .init(.flexible(minimum: 10, maximum: 70)), .init(.fixed(100))]
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(items, id: \.self) { element in
                    VStack {
                        Circle()
                            .frame( height: 50)
                            .foregroundStyle(.blue)
                        Text("\(element)")
                    }
                }
            }
        }
    }
}

#Preview {
    LazyHGridVista()
}
