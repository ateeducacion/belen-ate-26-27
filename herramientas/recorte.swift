// Recorta la cara N (misma detección y orden que caras.swift) a resolución completa.
// uso: recorte salida.jpg entrada.jpg N
import AppKit
import Vision

let a = CommandLine.arguments
let out = a[1], inp = a[2], idx = Int(a[3])! - 1
let ns = NSImage(contentsOfFile: inp)!
let r0 = ns.representations.first!
let w0 = CGFloat(r0.pixelsWide), h0 = CGFloat(r0.pixelsHigh)

func render(_ s: CGFloat) -> CGImage {
  let W = Int(w0 * s), H = Int(h0 * s)
  let c = CGContext(data: nil, width: W, height: H, bitsPerComponent: 8, bytesPerRow: 0,
                    space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
  NSGraphicsContext.current = NSGraphicsContext(cgContext: c, flipped: false)
  ns.draw(in: NSRect(x: 0, y: 0, width: W, height: H))
  return c.makeImage()!
}
// Detección sobre la misma versión de 1800 px que generó las hojas numeradas.
let small = render(1800 / max(w0, h0))
let req = VNDetectFaceRectanglesRequest()
try VNImageRequestHandler(cgImage: small).perform([req])
let faces = (req.results ?? []).filter { $0.boundingBox.width * CGFloat(small.width) > 28 }
  .sorted { $0.boundingBox.midX < $1.boundingBox.midX }
let b = faces[idx].boundingBox

let full = render(1)
let FW = CGFloat(full.width), FH = CGFloat(full.height)
// Margen: 2,6 veces la cara, algo desplazado hacia arriba para incluir pelo y hombros.
let side = max(b.width * FW, b.height * FH) * 2.6
let cx = b.midX * FW, cy = (1 - b.midY) * FH - side * 0.05
var rect = CGRect(x: cx - side / 2, y: cy - side / 2, width: side, height: side * 1.15)
rect = rect.intersection(CGRect(x: 0, y: 0, width: FW, height: FH))
let crop = full.cropping(to: rect)!
let rep = NSBitmapImageRep(cgImage: crop)
try rep.representation(using: .jpeg, properties: [.compressionFactor: 0.92])!.write(to: URL(fileURLWithPath: out))
print("\(out): \(crop.width)x\(crop.height)")
