//
//  Extensions.swift
//  Franz
//
//  Created by Kellan Cummings on 1/14/16.
//  Copyright © 2016 Kellan Cummings. All rights reserved.
//

import Foundation


protocol VariableLengthDatable {
    var data: Data { get }
    init()
    static func fromBytes(_ bytes: [UInt8]) -> VariableLengthDatable
}


protocol FixedLengthDatable {
    init(_:Int)
    func toInt() -> Int
    var data: Data { get }
    init(bytes: [UInt8])
}


extension Int8: FixedLengthDatable {
    
    init(bytes: [UInt8]) {
        var bytes = bytes
        //let data = Data(bytes: UnsafePointer<UInt8>(&bytes), count: 1)
        let data = NSData(bytes: &bytes, length: 1)
        var out: Int8 = 0
        //(data as NSData).getBytes(&out, length: sizeof(Int8.self))
        data.getBytes(&out, length: MemoryLayout<Int8>.size)
        self.init(out)
    }

    func toInt() -> Int {
        return Int(self)
    }
    
    var data: Data {
        var bytes = self
        //return Data(bytes: UnsafePointer<UInt8>(&bytes), count: sizeof(type(of: self))
        return NSData(bytes: &bytes, length: MemoryLayout<UInt8>.size) as Data
    }
}

extension UInt8: FixedLengthDatable {

    init(bytes: [UInt8]) {
        var bytes = bytes
        //let data = Data(bytes: UnsafePointer<UInt8>(&bytes), count: 1)
        let data = NSData(bytes: &bytes, length: 1)
        var out: UInt8 = 0
        //(data as NSData).getBytes(&out, length: sizeof(UInt8.self))
        data.getBytes(&out, length: MemoryLayout<UInt8>.size)
        self.init(out)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    var data: Data {
        var bytes = self
        //return Data(bytes: UnsafePointer<UInt8>(&bytes), count: sizeof(type(of: self)))
        return NSData(bytes: &bytes, length: MemoryLayout<UInt8>.size) as Data
    }
}

extension Int16: FixedLengthDatable {

    init(bytes: [UInt8]) {
        var bytes = bytes
        //let data = Data(bytes: UnsafePointer<UInt8>(&bytes), count: 2)
        let data = NSData(bytes: &bytes, length: 2)
        var out: Int16 = 0
        //(data as NSData).getBytes(&out, length: sizeof(Int16.self))
        data.getBytes(&out, length: MemoryLayout<Int16>.size)
        self.init(out.bigEndian)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    var data: Data {
        var bytes = self.bigEndian
        //return Data(bytes: UnsafePointer<UInt8>(&bytes), count: sizeof(type(of: self)))
        return NSData(bytes: &bytes, length: MemoryLayout<UInt8>.size) as Data
    }
}

extension UInt16: FixedLengthDatable {
    
    init(bytes: [UInt8]) {
        var bytes = bytes
        //let data = Data(bytes: UnsafePointer<UInt8>(&bytes), count: 2)
        let data = NSData(bytes: &bytes, length: 2)
        var out: UInt16 = 0
        //(data as NSData).getBytes(&out, length: sizeof(UInt16.self))
        data.getBytes(&out, length: MemoryLayout<UInt16>.size)
        self.init(out.bigEndian)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    var data: Data {
        var bytes = self.bigEndian
        //return Data(bytes: UnsafePointer<UInt8>(&bytes), count: sizeof(type(of: self)))
        return NSData(bytes: &bytes, length: MemoryLayout<UInt8>.size) as Data
    }
}

extension Int32: FixedLengthDatable {

    init(bytes: [UInt8]) {
        var bytes = bytes
        //let data = Data(bytes: UnsafePointer<UInt8>(&bytes), count: 4)
        let data = NSData(bytes: &bytes, length: 4)
        var out: Int32 = 0
        //(data as NSData).getBytes(&out, length: sizeof(Int32.self))
        data.getBytes(&out, length: MemoryLayout<Int32>.size)
        self.init(out.bigEndian)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    var data: Data {
        var bytes = self.bigEndian
        //return Data(bytes: UnsafePointer<UInt8>(&bytes), count: sizeof(type(of: self)))
        return NSData(bytes: &bytes, length: MemoryLayout<UInt8>.size) as Data
        
    }
}

extension UInt32: FixedLengthDatable {

    init(bytes: [UInt8]) {
        var bytes = bytes
        //let data = Data(bytes: UnsafePointer<UInt8>(&bytes), count: 4)
        let data = NSData(bytes: &bytes, length: 4)
        var out: UInt32 = 0
        //(data as NSData).getBytes(&out, length: sizeof(UInt32.self))
        data.getBytes(&out, length: MemoryLayout<UInt32>.size)
        self.init(out.bigEndian)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    var data: Data {
        var bytes = self.bigEndian
        //return Data(bytes: UnsafePointer<UInt8>(&bytes), count: sizeof(type(of: self)))
        return NSData(bytes: &bytes, length: MemoryLayout<UInt8>.size) as Data
    }
}

extension Int: FixedLengthDatable {

    init(bytes: [UInt8]) {
        var bytes = bytes
        //let data = Data(bytes: UnsafePointer<UInt8>(&bytes), count: sizeof(Int.self))
        let data = NSData(bytes: &bytes, length: MemoryLayout<Int>.size)
        var out: Int = 0
        //(data as NSData).getBytes(&out, length: sizeof(Int.self))
        data.getBytes(&out, length: MemoryLayout<Int>.size)
        self.init(out.bigEndian)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
   
    init(_ value: FixedLengthDatable) {
        var dataBytes = value.data
        //let data = Data(bytes: UnsafePointer<UInt8>(&dataBytes), count: sizeof(FixedLengthDatable.self))
        let data = NSData(bytes: &dataBytes, length: MemoryLayout<FixedLengthDatable>.size)

        var out: Int = 0
        //(data as NSData).getBytes(&out, length: sizeof(Int.self))
        data.getBytes(&out, length: MemoryLayout<Int>.size)
        
        
        self.init(out.bigEndian)
    }
    
    var data: Data {
        var bytes = self.bigEndian
        //return Data(bytes: UnsafePointer<UInt8>(&bytes), count: sizeof(type(of: self)))
        return NSData(bytes: &bytes, length: MemoryLayout<UInt8>.size) as Data
    }
}

extension Int64: FixedLengthDatable {

    init(bytes: [UInt8]) {
        var bytes = bytes
        //let data = Data(bytes: UnsafePointer<UInt8>(&bytes), count: 8)
        let data = NSData(bytes: &bytes, length: 8)
        var out: Int64 = 0
        data.getBytes(&out, length: MemoryLayout<Int64>.size)
        self.init(out.bigEndian)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    var data: Data {
        var bytes = self.bigEndian
        //return Data(bytes: UnsafePointer<UInt8>(&bytes), count: sizeof(type(of: self)))
        return NSData(bytes: &bytes, length: MemoryLayout<UInt8>.size) as Data
    }
}

extension UInt64: FixedLengthDatable {

    init(bytes: [UInt8]) {
        var bytes = bytes
        //let data = Data(bytes: UnsafePointer<UInt8>(&bytes), count: 8)
        let data = NSData(bytes: &bytes, length: 8)
        var out: UInt64 = 0
        data.getBytes(&out, length: MemoryLayout<UInt64>.size)
        self.init(out.bigEndian)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    var data: Data {
        var bytes = self.bigEndian
        //return Data(bytes: UnsafePointer<UInt8>(&bytes), count: sizeof(type(of: self)))
        return NSData(bytes: &bytes, length: MemoryLayout<UInt8>.size) as Data
    }
}

extension String: VariableLengthDatable {

    static func fromBytes(_ bytes: [UInt8]) -> VariableLengthDatable {
        var bytes = bytes
        //let data = Data(bytes: UnsafePointer<UInt8>(&bytes), count: bytes.count)
        let data = NSData(bytes: &bytes, length: bytes.count)
        let string = String(data: (data as Data), encoding: String.Encoding.utf8) ?? ""
        
        return self.init(string)
    }
    
    var data: Data {
        return self.data(
            using: String.Encoding.utf8,
            allowLossyConversion: true
        ) ?? Data()
    }
}

extension Data: VariableLengthDatable {

    static func fromBytes(_ bytes: [UInt8]) -> VariableLengthDatable {
        var bytes = bytes
        //return Data(bytes: UnsafePointer<UInt8>(&bytes), count: bytes.count)
        return NSData(bytes: &bytes, length: bytes.count) as Data
    }
    
    var data: Data {
        return self
    }
}


extension Stream.Event {
    var description: String {
        switch self {
        case Stream.Event():
            return "None"
        case Stream.Event.openCompleted:
            return "Open Completed"
        case Stream.Event.hasBytesAvailable:
            return "Has Bytes Available"
        case Stream.Event.hasSpaceAvailable:
            return "Has Space Available"
        case Stream.Event.errorOccurred:
            return "Error Occurred"
        case Stream.Event.endEncountered:
            return "End Encountered"
        default:
            return ""
        }
    }
}

extension Stream.Status {
    var description: String {
        switch self {
        case Stream.Status.notOpen:
            return "Not Open"
        case Stream.Status.opening:
            return "Opening"
        case Stream.Status.open:
            return "Open"
        case Stream.Status.reading:
            return "Reading"
        case Stream.Status.writing:
            return "Writing"
        case Stream.Status.atEnd:
            return  "End"
        case Stream.Status.closed:
            return "Closed"
        case Stream.Status.error:
            return "Error"
        }
    }
}

extension Array {
    
    mutating func slice(_ offset: Int, length: Int) -> [Element] {
        var values = [Element]()
        if self.count >= offset + length {
            for _ in offset..<(offset + length) {
                let value = self.remove(at: offset)
                values.append(value)
            }
        }

        return values
    }
    
}
