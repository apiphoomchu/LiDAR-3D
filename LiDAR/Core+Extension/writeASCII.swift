//
//  writeASCII.swift
//  LiDAR
//
//  Created by Apiphoom Chuenchompoo on 17/2/2566 BE.
//

import Foundation

func writeAscii(file: URL, cpuParticlesBuffer: inout [CPUParticle]) throws  -> Void {
    var vertexStrings = ""
    for particle in cpuParticlesBuffer {
        if particle.confidence != 2 { continue }
        let colors = particle.color
        let red = Int(colors.x)
        let green = Int(colors.y)
        let blue = Int(colors.z)
        let x = particle.position.x
        let y = particle.position.y
        let z = particle.position.z
        let pValue =  "\(x) \(y) \(z) \(red) \(green) \(blue) 255" + "\r\n"
        vertexStrings += pValue
    }
    
    let fileHandle = try FileHandle(forWritingTo: file)
    fileHandle.seekToEndOfFile()
    fileHandle.write(vertexStrings.data(using: .ascii)!)
    fileHandle.closeFile()
}
