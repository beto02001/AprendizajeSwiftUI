//
//  TapGesture.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 01/01/26.
//

import SwiftUI

struct TapGestureVista: View {

    @State var counter: Int = 0
    
    //MARK: Opcioón 2
    var doubleTapGesture: some Gesture {
        TapGesture()
            .onEnded { counter += 2 }
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: 200, height: 200)
            .foregroundStyle(.indigo)
            //MARK: Opcioón 1
            /*.gesture(
                TapGesture()
                    .onEnded({ _ in
                        counter += 1
                    })
            )*/
        
            //MARK: Opcioón 2
            //.gesture(doubleTapGesture)
        
            //MARK: Opcioón 3 la más fácil de hacer
            .onTapGesture {
                counter += 3
            }
        Text("\(counter) taps")
    }
}

#Preview {
    TapGestureVista()
}
