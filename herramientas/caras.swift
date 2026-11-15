// Detecta caras (sin reconocerlas) y dibuja recuadros numerados.
// uso: swift caras.swift salida.jpg entrada.jpg
import AppKit
import Vision

let args = CommandLine.arguments
let out = args[1], inp = args[2]
guard let ns = NSImage(contentsOfFile: inp) else { fatalError("no se puede abrir \(inp)") }
// Render respetando la orientación EXIF, a 1800 px de lado mayor.
let rep0 = ns.representations.first!
let w0 = CGFloat(rep0.pixelsWide), h0 = CGFloat(rep0.pixelsHigh)
let s = 1800 / max(w0, h0)
let W = Int(w0 * s), H = Int(h0 * s)
let ctx = CGContext(data: nil, width: W, height: H, bitsPerComponent: 8, bytesPerRow: 0,
                    space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
NSGraphicsContext.current = NSGraphicsContext(cgContext: ctx, flipped: false)
ns.draw(in: NSRect(x: 0, y: 0, width: W, height: H))
let cg = ctx.makeImage()!

let req = VNDetectFaceRectanglesRequest()
try VNImageRequestHandler(cgImage: cg).perform([req])
// Orden de lectura: de izquierda a derecha.
let faces = (req.results ?? []).filter { $0.boundingBox.width * CGFloat(W) > 28 }
  .sorted { $0.boundingBox.midX < $1.boundingBox.midX }

ctx.setLineWidth(4)
for (i, f) in faces.enumerated() {
  let b = f.boundingBox
  let r = CGRect(x: b.minX * CGFloat(W), y: b.minY * CGFloat(H), width: b.width * CGFloat(W), height: b.height * CGFloat(H))
  ctx.setStrokeColor(NSColor.yellow.cgColor); ctx.stroke(r)
  let label = NSAttributedString(string: " \(i + 1) ", attributes: [
    .font: NSFont.boldSystemFont(ofSize: 44), .foregroundColor: NSColor.black, .backgroundColor: NSColor.yellow])
  label.draw(at: NSPoint(x: r.minX, y: r.maxY + 4))
}
let rep = NSBitmapImageRep(cgImage: ctx.makeImage()!)
try rep.representation(using: .jpeg, properties: [.compressionFactor: 0.85])!.write(to: URL(fileURLWithPath: out))
print("\(faces.count) caras -> \(out)")
