//
//  GeometryReaderVista.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 04/01/26.
//

import SwiftUI

struct GeometryReaderVista: View {
    var body: some View {

        /*
         GeometryReader
         ----------------
         GeometryReader es un contenedor de SwiftUI que permite leer información
         sobre el espacio disponible que le asigna su vista padre.

         No se usa principalmente para mostrar contenido,
         sino para ADAPTAR la interfaz en función del tamaño o posición.
         */
        GeometryReader { proxy in
            /*
             proxy (GeometryProxy)
             ---------------------
             Es el objeto que nos da acceso a toda la información geométrica:
             - Tamaño disponible (width / height)
             - Posición de la vista
             - Sistema de coordenadas (local, global, custom)

             El valor de proxy depende SIEMPRE del layout que SwiftUI resuelva.
             */

            VStack {

                /*
                 proxy.size.width
                 ----------------
                 Representa el ancho total disponible para el GeometryReader.
                 No es el ancho del contenido, sino el espacio permitido por el padre.

                 En este caso será 300, porque más abajo se limita con .frame(width: 300)
                 */
                Text("Width: \(proxy.size.width)")
                    .background(.orange)
                    .padding()

                /*
                 proxy.size.height
                 -----------------
                 Representa la altura total disponible para el GeometryReader.
                 Al igual que el width, depende del layout del padre.
                 */
                Text("Height: \(proxy.size.height)")
                    .background(.orange)
                    .padding()

                /*
                 proxy.frame(in: .local)
                 -----------------------
                 Devuelve un CGRect que representa la posición y tamaño del
                 GeometryReader dentro de SU PROPIO sistema de coordenadas.

                 - El origen (0,0) siempre es la esquina superior izquierda
                 - Se usa cuando quieres medir cosas INTERNAS al contenedor
                 */
                Text("Coordinates Local \(proxy.frame(in: .local).debugDescription)")
                    .background(.orange)
                    .padding()

                /*
                 proxy.frame(in: .global)
                 ------------------------
                 Devuelve un CGRect relativo a TODA la pantalla.

                 - El origen (0,0) es la esquina superior izquierda del dispositivo
                 - Cambia según safe areas, navegación, scroll, etc.

                 Se usa para:
                 - Animaciones basadas en scroll
                 - Parallax
                 - Detectar visibilidad en pantalla
                 */
                Text("Coordinates Global \(proxy.frame(in: .global).debugDescription)")
                    .background(.orange)
                    .padding()
            }
        }
        /*
         Importante:
         GeometryReader siempre intenta ocupar TODO el espacio disponible.

         Si no se limita, puede expandirse y romper el layout.
         */
        .background(.red)

        /*
         Al definir un frame aquí, se controla el tamaño del GeometryReader,
         y por consecuencia:
         - proxy.size.width == 300
         - proxy.size.height == 300
         */
        .frame(width: 300, height: 300)
    }
}


#Preview {
    GeometryReaderVista()
}
