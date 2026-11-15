// Hoja de referencia de rostros rotulada para editar escenas con IA.
// Uso: swift herramientas/hoja-caras.swift <salida.jpg> <carpeta> "id|Rótulo" ...
import AppKit

let a = CommandLine.arguments; let out = a[1], dir = a[2], items = Array(a[3...])
let cols = 3, cw = 520, ch = 640, rows = (items.count + cols - 1) / cols
let c = CGContext(data: nil, width: cols * cw, height: rows * ch, bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
NSGraphicsContext.current = NSGraphicsContext(cgContext: c, flipped: false)
NSColor(white: 0.93, alpha: 1).setFill(); NSRect(x: 0, y: 0, width: cols * cw, height: rows * ch).fill()

func bust(_ path: String) -> CGImage {
    let src = NSImage(contentsOfFile: path)!.cgImage(forProposedRect: nil, context: nil, hints: nil)!
    let w = src.width, h = src.height
    let ctx = CGContext(data: nil, width: w, height: h, bitsPerComponent: 8, bytesPerRow: w * 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
    ctx.draw(src, in: CGRect(x: 0, y: 0, width: w, height: h))
    let p = ctx.data!.bindMemory(to: UInt8.self, capacity: w * h * 4)
    var x0 = w, x1 = 0, y0 = h, y1 = 0  // y0 = fila superior en memoria
    for y in 0..<h { for x in 0..<w where p[(y * w + x) * 4 + 3] > 16 { x0 = min(x0, x); x1 = max(x1, x); y0 = min(y0, y); y1 = max(y1, y) } }
    let top = CGFloat(y1 - y0) * 0.42  // cabeza y torso: parte superior de la figura
    return src.cropping(to: CGRect(x: x0, y: y0, width: x1 - x0 + 1, height: Int(top)))!
}
for (i, item) in items.enumerated() {
    let parts = item.components(separatedBy: "|"); let img = bust("\(dir)/\(parts[0]).png")
    let x = (i % cols) * cw, y = (rows - 1 - i / cols) * ch
    let s = min(CGFloat(cw - 20) / CGFloat(img.width), CGFloat(ch - 90) / CGFloat(img.height))
    let w = CGFloat(img.width) * s, h = CGFloat(img.height) * s
    c.draw(img, in: CGRect(x: CGFloat(x) + (CGFloat(cw) - w) / 2, y: CGFloat(y + 80), width: w, height: h))
    let label = NSAttributedString(string: parts[1], attributes: [.font: NSFont.boldSystemFont(ofSize: 30), .foregroundColor: NSColor.black])
    label.draw(at: NSPoint(x: CGFloat(x) + (CGFloat(cw) - label.size().width) / 2, y: CGFloat(y + 22)))
}
try NSBitmapImageRep(cgImage: c.makeImage()!).representation(using: .jpeg, properties: [.compressionFactor: 0.88])!.write(to: URL(fileURLWithPath: out))
