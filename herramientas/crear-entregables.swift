import AppKit
import ImageIO

struct Person: Decodable { let id: String; let name: String; let ref: String; let roleEs: String }
struct Production: Decodable { let records: [Person] }
let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let data = try Data(contentsOf: root.appendingPathComponent("output/production.json"))
let persons = try JSONDecoder().decode(Production.self, from: data).records
precondition(persons.count == 18 && Set(persons.map { $0.id }).count == 18)
let cream = NSColor(calibratedRed: 0.98, green: 0.97, blue: 0.93, alpha: 1)
let green = NSColor(calibratedRed: 0.07, green: 0.18, blue: 0.16, alpha: 1)
let gold = NSColor(calibratedRed: 0.7, green: 0.55, blue: 0.31, alpha: 1)
let a4 = CGSize(width: 595.276, height: 841.89)

func image(_ path: String) -> NSImage {
    guard let result = NSImage(contentsOf: root.appendingPathComponent(path)) else { fatalError("Falta \(path)") }
    return result
}
func text(_ value: String, _ y: CGFloat, _ size: CGFloat, _ font: String = "Times-Roman", _ width: CGFloat = 595.276, _ color: NSColor = green) {
    let str = NSAttributedString(string: value, attributes: [.font: NSFont(name: font, size: size) ?? NSFont.systemFont(ofSize: size), .foregroundColor: color])
    str.draw(at: NSPoint(x: (width-str.size().width)/2, y: y))
}
func fit(_ img: NSImage, _ rect: CGRect) {
    let scale = min(rect.width/img.size.width, rect.height/img.size.height)
    let size = CGSize(width: img.size.width*scale, height: img.size.height*scale)
    img.draw(in: CGRect(x: rect.midX-size.width/2, y: rect.minY, width: size.width, height: size.height))
}
func page(_ ctx: CGContext, _ draw: () -> Void) {
    ctx.beginPDFPage(nil)
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(cgContext: ctx, flipped: false)
    draw()
    NSGraphicsContext.restoreGraphicsState()
    ctx.endPDFPage()
}
func pdf(_ path: String) -> CGContext {
    var box = CGRect(origin: .zero, size: a4)
    guard let consumer = CGDataConsumer(url: root.appendingPathComponent(path) as CFURL), let ctx = CGContext(consumer: consumer, mediaBox: &box, nil) else { fatalError("No se puede escribir \(path)") }
    return ctx
}
func border() {
    cream.setFill(); NSBezierPath(rect: CGRect(origin: .zero, size: a4)).fill()
    gold.setStroke(); let line = NSBezierPath(rect: CGRect(x: 25, y: 25, width: a4.width-50, height: a4.height-50)); line.lineWidth=0.6; line.stroke()
}
func sheet(_ person: Person, realistic: Bool = false) {
    let suffix = realistic ? "-realista" : ""
    let ctx = pdf("output/laminas/\(person.id)\(suffix)-a4.pdf")
    page(ctx) {
        border()
        text("BELÉN DE ATE", 784, 11, "Helvetica")
        text(person.name, 741, 32)
        text(person.roleEs, 713, 17, "Times-Italic")
        fit(image(realistic ? "output/figuras/realistas/\(person.id).png" : "output/figuras/\(person.id).png"), CGRect(x: 65, y: 123, width: 465, height: 561))
        text("ATE les desea Feliz Navidad", 78, 19, "Times-Italic")
        text("\(person.ref) · \(realistic ? "Realista" : "Figurita") · Navidad 2026–2027", 47, 8, "Helvetica")
    }
    ctx.closePDF()
}
for person in persons { sheet(person) }
for person in persons { sheet(person, realistic: true) }

let summary = pdf("output/resumen/belen-ate-dos-paginas.pdf")
for n in 0..<2 {
    page(summary) {
        border()
        text("BELÉN ATE", 779, 29)
        text("\(n+1) · \(n == 0 ? "A1–A9" : "B1–B9")", 754, 13, "Times-Italic")
        let group = n == 0 ? Array(persons.prefix(9)) : Array(persons.suffix(9))
        for (i, person) in group.enumerated() {
            let col = i%3, row = i/3
            let x = CGFloat(col)*173+38, y = CGFloat(2-row)*218+87
            fit(image("output/figuras/\(person.id).png"), CGRect(x:x+6,y:y+45,width:157,height:169))
            NSGraphicsContext.saveGraphicsState()
            NSGraphicsContext.current!.cgContext.translateBy(x:x,y:0)
            text(person.name,y+24,15,"Times-Bold",169)
            text(person.roleEs,y+9,10,"Times-Italic",169)
            NSGraphicsContext.restoreGraphicsState()
        }
        text("ATE les desea Feliz Navidad", 47, 12, "Times-Italic")
    }
}
summary.closePDF()

func bitmap(_ path: String, _ width: Int, _ height: Int, _ draw: () -> Void) {
    let ctx = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
    NSGraphicsContext.saveGraphicsState(); NSGraphicsContext.current = NSGraphicsContext(cgContext: ctx, flipped: false)
    draw()
    NSGraphicsContext.restoreGraphicsState()
    let out = NSBitmapImageRep(cgImage: ctx.makeImage()!)
    try! out.representation(using: .png, properties: [:])!.write(to: root.appendingPathComponent(path))
}
// Composición determinista: reutiliza los PNG aprobados sin volver a generar sus caras.
let width: CGFloat = 3840, height: CGFloat = 2160
let positions: [(String, CGFloat, CGFloat, CGFloat)] = [
    ("luz",2450,1120,460),("yanira",3150,1150,460),
    ("rosy",480,410,390),("leo",780,420,400),("roser",1050,390,420),("carlos",1320,380,420),("elisa",1570,390,410),
    ("ivonne",2570,445,560),("cristian",3130,445,560),
    ("humberto",3330,330,500),("celeste",3500,240,500),("berta",3240,120,560),
    ("fran",2080,80,530),("ernesto",3660,70,560),("francis",2440,75,540),
    ("alfredo",280,100,620),("luis",650,120,590),("santi",1020,145,570)
]
precondition(Set(positions.map{$0.0}) == Set(persons.map{$0.id}))
bitmap("output/video/capas/fondo.png", 3840, 2160) {
    image("web/assets/background.png").draw(in: CGRect(x:0,y:0,width:width,height:height))
}
bitmap("output/belen/belen-ate-16-9.png", 3840, 2160) {
    image("output/video/capas/fondo.png").draw(in: CGRect(x:0,y:0,width:width,height:height))
    NSColor(calibratedRed:0.035,green:0.12,blue:0.11,alpha:0.22).setFill(); NSBezierPath(rect:CGRect(x:0,y:0,width:width,height:height)).fill()
    text("ATE les desea Feliz Navidad", 1840, 122, "Times-Italic", width, .white)
    text("Un belén, muchas historias", 1735, 44, "Times-Roman", width, .white)
    for (id,x,y,h) in positions {
        fit(image("output/figuras/\(id).png"),CGRect(x:x-210,y:y,width:420,height:h))
    }
    fit(image("output/figuras/nino.png"),CGRect(x:2690,y:405,width:310,height:260))
}
bitmap("output/preview/todas-las-figuras.png", 1680, 1500) {
    cream.setFill(); NSBezierPath(rect:CGRect(x:0,y:0,width:1680,height:1500)).fill()
    for (i,p) in persons.enumerated() {
        let x=CGFloat(i%6)*280, y=CGFloat(2-i/6)*500
        fit(image("output/figuras/\(p.id).png"),CGRect(x:x+10,y:y+55,width:260,height:430))
        NSGraphicsContext.saveGraphicsState();NSGraphicsContext.current!.cgContext.translateBy(x:x,y:0)
        text(p.name,y+23,22,"Times-Roman",280);NSGraphicsContext.restoreGraphicsState()
    }
}
print("Generados 18 A4, resumen de 2 páginas, escena 3840 × 2160 y vista general")
