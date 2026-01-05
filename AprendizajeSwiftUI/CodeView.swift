import SwiftUI

struct CodeView: View {
    let code: String
    @State private var lineNumbers: [String] = []
    
    var body: some View {
        ScrollView([.vertical, .horizontal]) {
            HStack(alignment: .top, spacing: 0) {
                // Números de línea
                VStack(alignment: .trailing, spacing: 0) {
                    ForEach(lineNumbers, id: \.self) { lineNum in
                        Text(lineNum)
                            .font(.system(.callout, design: .monospaced))
                            .foregroundColor(Color(hex: "6C7986"))
                            .frame(minWidth: 40, alignment: .trailing)
                            .padding(.trailing, 8)
                    }
                }
                .padding(.vertical, 16)
                .background(Color(hex: "292A30"))
                
                // Divisor
                Rectangle()
                    .fill(Color(hex: "1F1F24"))
                    .frame(width: 1)
                
                // Código con resaltado
                Text(highlightSwift(code))
                    .font(.system(.callout, design: .monospaced))
                    .textSelection(.enabled)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background(Color(hex: "1F1F24"))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "393A40"), lineWidth: 1)
        )
        .padding()
        .onAppear {
            lineNumbers = code.components(separatedBy: "\n")
                .enumerated()
                .map { String($0.offset + 1) }
        }
    }
}

func highlightSwift(_ code: String) -> AttributedString {
    var attributed = AttributedString(code)
    
    // Colores estilo Xcode (tema oscuro)
    let keywordColor = Color(hex: "FC5FA3")      // Rosa/Magenta
    let stringColor = Color(hex: "FC6A5D")       // Rojo
    let commentColor = Color(hex: "6C7986")      // Gris verdoso
    let typeColor = Color(hex: "67B7A4")         // Cyan/Verde agua
    let numberColor = Color(hex: "D0BF69")       // Amarillo
    let functionColor = Color(hex: "67B7A4")     // Cyan
    let attributeColor = Color(hex: "D0A8FF")    // Púrpura claro
    let modifierColor = Color(hex: "B281EB")     // Morado (modificadores)
    let defaultColor = Color(hex: "DFDFE0")      // Blanco grisáceo
    
    // Establecer color por defecto
    attributed.foregroundColor = defaultColor
    
    // Palabras clave de Swift
    let keywords = [
        "import", "struct", "class", "enum", "protocol", "extension",
        "let", "var", "func", "return", "init", "deinit",
        "if", "else", "guard", "switch", "case", "default",
        "for", "while", "repeat", "break", "continue", "fallthrough",
        "in", "where", "do", "catch", "throw", "try", "throws",
        "static", "private", "public", "internal", "fileprivate", "open",
        "mutating", "nonmutating", "override", "final", "lazy",
        "weak", "unowned", "self", "super", "nil", "true", "false",
        "as", "is", "associatedtype", "typealias", "inout", "async", "await"
    ]
    
    // Tipos comunes
    let types = [
        "String", "Int", "Double", "Float", "Bool", "Character",
        "Array", "Dictionary", "Set", "Optional", "Any", "AnyObject",
        "View", "State", "Binding", "ObservedObject", "Published",
        "UIColor", "Color", "Text", "Button", "VStack", "HStack", "ZStack"
    ]
    
    // Orden correcto: primero comentarios y strings (para no colorear palabras dentro)
    applyRegexPattern(#"//.*"#, color: commentColor, to: &attributed)
    applyRegexPattern(#"/\*[\s\S]*?\*/"#, color: commentColor, to: &attributed)
    applyRegexPattern(#""[^"]*""#, color: stringColor, to: &attributed)
    applyRegexPattern(##"#"[^"]*"#"##, color: stringColor, to: &attributed)
    
    // Números
    applyRegexPattern(#"\b\d+\.?\d*\b"#, color: numberColor, to: &attributed)
    
    // Atributos (@State, @Binding, etc.)
    applyRegexPattern(#"@\w+"#, color: attributeColor, to: &attributed)
    
    // Nombres de funciones (antes de modificadores para que estos los sobrescriban)
    applyRegexPattern(#"\b[a-z]\w*(?=\()"#, color: functionColor, to: &attributed)
    
    // Modificadores (.font, .padding, .foregroundColor, etc.)
    applyRegexPattern(#"\.\w+(?=\()"#, color: modifierColor, to: &attributed)
    
    // Aplicar palabras clave y tipos
    for keyword in keywords {
        applyWordColor(keyword, color: keywordColor, to: &attributed)
    }
    for type in types {
        applyWordColor(type, color: typeColor, to: &attributed)
    }
    
    return attributed
}

// Aplica color a palabras completas (con límites de palabra)
func applyWordColor(_ word: String, color: Color, to text: inout AttributedString) {
    guard !word.isEmpty else { return }
    let pattern = "\\b\(NSRegularExpression.escapedPattern(for: word))\\b"
    applyRegexPattern(pattern, color: color, to: &text)
}

// Aplica color usando expresiones regulares
func applyRegexPattern(_ pattern: String, color: Color, to text: inout AttributedString) {
    let string = String(text.characters)
    guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return }
    
    let matches = regex.matches(in: string, range: NSRange(location: 0, length: string.utf16.count))
    
    for match in matches {
        // Convertir NSRange a Range<String.Index>
        guard let range = Range(match.range, in: string) else { continue }
        
        // Convertir Range<String.Index> a Range<AttributedString.Index>
        let startIndex = AttributedString.Index(range.lowerBound, within: text)
        let endIndex = AttributedString.Index(range.upperBound, within: text)
        
        guard let start = startIndex, let end = endIndex else { continue }
        
        text[start..<end].foregroundColor = color
    }
}

// Extension para colores hexadecimales
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    CodeView(code: """
import SwiftUI

struct ButtonVista: View {
    @State private var counter = 0
    let title: String
    
    var body: some View {
        VStack {
            // Este es un comentario
            Text("Contador: \\(counter)")
                .font(.headline)
            
            Button(title) {
                counter += 1
                print("Tap: \\(counter)")
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}
""")
        .preferredColorScheme(.dark)
}
