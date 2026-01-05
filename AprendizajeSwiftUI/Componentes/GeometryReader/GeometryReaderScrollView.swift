//
//  GeometryReaderScrollView.swift
//  AprendizajeSwiftUI
//
//  Created by Luis Humberto Martinez Echegaray on 04/01/26.
//

import SwiftUI

let banks: [String] = [
    "BBVA", "Santander", "HSBC", "Banco Popular", "Scotiabank", "Nu", "Plata", "Banco de Chile", "Banco Internacional de Comercio", "Banco de México"
]
struct GeometryReaderScrollView: View {
    var body: some View {
        ScrollView {
            VStack {
                // Recorremos una colección de bancos (cada elemento debe ser Hashable y único
                // si usamos `id: \.self` — cuidado con valores duplicados).
                ForEach(banks, id: \.self) { bank in

                    /*
                     GeometryReader dentro de una ScrollView
                     -------------------------------------
                     Aquí usamos GeometryReader para leer la posición vertical (minY)
                     de cada celda respecto al sistema de coordenadas global.
                     Esto nos permite crear un efecto dependiente del scroll (parallax /
                     rotación 3D) según la posición en pantalla.
                     */
                    GeometryReader { proxy in
                        VStack {
                            // Línea de depuración: mostramos la coordenada minY global.
                            // En producción puede eliminarse.
                            Text("\(proxy.frame(in: .global).minY)")

                            Spacer()

                            // Contenido principal de la celda
                            Text(bank)
                                .frame(width: 370, height: 200) // tamaño fijo para la "carta"
                                .background(.cyan)
                                .cornerRadius(20)

                            Spacer()
                        }
                        .shadow(color: .gray, radius: 10, x: 0, y: 0)

                        /*
                         Efecto 3D dependiente de la posición vertical
                         ---------------------------------------------
                         .rotation3DEffect toma un Angle; aquí convertimos la posición
                         vertical a grados para rotar la vista en 3D.

                         - proxy.frame(in: .global).minY : la distancia desde la
                           esquina superior de la pantalla hasta la parte superior de la celda.
                         - Se resta 59: es un *offset arbitrario* (ajuste visual).
                           En lugar de restar un número "mágico", considera normalizar
                           y mapear la posición a un rango de ángulos.
                         - axis: (x: 0, y: 10, z: 10) define el vector del eje de rotación.
                           No es necesario que sea unitario; SwiftUI normaliza internamente.
                           Cambiar estos valores cambia la "dirección" de la rotación.
                         */
                        .rotation3DEffect(
                            Angle(degrees: Double(proxy.frame(in: .global).minY) - 59),
                            axis: (x: 0, y: 10, z: 10)
                        )
                    }
                    // Limitar el tamaño del GeometryReader evita que "se expanda" y
                    // asegura que proxy.size y proxy.frame sean consistentes.
                    .frame(width: 370, height: 300)
                }
            }
            .padding(.trailing)
        }
        .scrollIndicators(.hidden) // ocultar indicadores de scroll (visual)
        .padding(.trailing)
    }
}

/*
========================
Notas y explicaciones prácticas
========================

1) ¿Por qué usamos `.frame(width: 370, height: 300)` en el GeometryReader?
   - GeometryReader tiende a rellenar el espacio disponible. Al darle un frame fijo
     controlamos su tamaño y evitamos efectos indeseados en el layout.
   - Además facilita predecir el valor de proxy.frame(in:.global).minY.

2) ¿Qué es `proxy.frame(in: .global).minY`?
   - Es la coordenada Y mínima (top) del rectángulo de la vista respecto al
     sistema de coordenadas global (la pantalla). Al hacer scroll, este valor cambia.
   - Útil para efectos dependientes de la posición en pantalla (parallax, animaciones).

3) `rotation3DEffect` y el mapeo de valores:
   - Convertir directamente minY en grados funciona pero puede dar rotaciones
     demasiado grandes o bruscas.
   - Recomendación: normalizar/mapear minY a un rango razonable de ángulos,
     por ejemplo:
         let angle = (proxy.frame(in:.global).minY - center) / 10
         let clamped = min(max(angle, -20), 20)
     - De esta forma evitas rotaciones extremas.

4) Performance y buenas prácticas:
   - Colocar muchos GeometryReaders (uno por celda) puede impactar el rendimiento.
     Cada proxy recalcula en cada cambio de layout/scroll.
   - Alternativas más eficientes:
     • Usar un único GeometryReader sobre el ScrollView y calcular posiciones con PreferenceKey.
     • Usar `overlay` o `background` con GeometryReader para leer posiciones sin insertar
       un contenedor completo en cada celda.
     • Usar `onAppear`/`onDisappear` + lógica basada en offsets cuando sea suficiente.
   - Si necesitas alta frecuencia de actualización (ej. animaciones suaves), prueba a
     simplificar el trabajo hecho en cada ciclo de render.

5) Coordenadas y espacios nombrados:
   - En lugar de `.global`, puedes definir un espacio nombrado:
         .coordinateSpace(name: "scroll")
     y luego usar:
         proxy.frame(in: .named("scroll"))
     - Esto da más control (por ejemplo, ignorar offsets globales como safe area).

6) Precauciones con `ForEach(..., id: \.self)`:
   - Asegúrate que `banks` contiene valores únicos; si no, mejor usar un identificador único.

7) Debug vs producción:
   - `Text("\(proxy.frame(in: .global).minY)")` es útil para entender el comportamiento,
     pero quítalo en producción para no sobrecargar la UI.

========================
Cuándo usar este patrón
========================
- Sí: efectos visuales dependientes del scroll (parallax, rotaciones, scaling).
- No: layouts sencillos donde HStack/VStack/Spacer resuelven el problema; evitar
  GeometryReader cuando no necesitas la posición o el tamaño exacto.
*/


#Preview {
    GeometryReaderScrollView()
}
