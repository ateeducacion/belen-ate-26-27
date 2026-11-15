import AppKit
let a = CommandLine.arguments; let out = a[1]; let files = Array(a[2...])
let cols = 7, cw = 260, ch = 320, rows = (files.count + cols - 1) / cols
let c = CGContext(data: nil, width: cols*cw, height: rows*ch, bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
NSGraphicsContext.current = NSGraphicsContext(cgContext: c, flipped: false)
NSColor.darkGray.setFill(); NSRect(x:0,y:0,width:cols*cw,height:rows*ch).fill()
for (i,f) in files.enumerated() {
  let im = NSImage(contentsOfFile: f)!; let x = (i%cols)*cw, y = (rows-1-i/cols)*ch
  let s = min(CGFloat(cw-8)/im.size.width, CGFloat(ch-40)/im.size.height)
  im.draw(in: NSRect(x: CGFloat(x+4), y: CGFloat(y+34), width: im.size.width*s, height: im.size.height*s))
  NSAttributedString(string: (f as NSString).lastPathComponent.components(separatedBy: "-").prefix(2).joined(separator: " "), attributes: [.font: NSFont.boldSystemFont(ofSize: 18), .foregroundColor: NSColor.white]).draw(at: NSPoint(x: x+6, y: y+6))
}
try NSBitmapImageRep(cgImage: c.makeImage()!).representation(using: .jpeg, properties: [.compressionFactor: 0.8])!.write(to: URL(fileURLWithPath: out))
