//
//  LazyVGridVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 27/12/25.
//

import SwiftUI

struct LazyVGridVista: View {
    var body: some View {
        
        var elements = 1...500
        var gridItems: [GridItem] = [GridItem(.fixed(100)),
                                     GridItem(.adaptive(minimum: 30)),
                                     GridItem(.fixed(100))]
        ScrollView {
            //MARK: Para ocupar las vista Lazy necesitamos el ScrollView para poder hacer scroll
            LazyVGrid(columns: gridItems) {
                ForEach(elements, id: \.self) { element in
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
    LazyVGridVista()
}
