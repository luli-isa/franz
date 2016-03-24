//
//  Extensions.swift
//  Franz
//
//  Created by Kellan Cummings on 1/14/16.
//  Copyright © 2016 Kellan Cummings. All rights reserved.
//

import Foundation


protocol VariableLengthDatable {
    var data: NSData { get }
    init()
    static func fromBytes(bytes: [UInt8]) -> VariableLengthDatable
}


protocol FixedLengthDatable {
    init(_:Int)
    func toInt() -> Int
    var data: NSData { get }
    init(bytes: [UInt8])
}


extension Int8: FixedLengthDatable {
    
    init(bytes: [UInt8]) {
        var bytes = bytes
        let data = NSData(bytes: &bytes, length: 1)
        var out: Int8 = 0
        data.getBytes(&out, length: sizeof(Int8.self))
        self.init(out)
    }

    func toInt() -> Int {
        return Int(self)
    }
    
    var data: NSData {
        var bytes = self
        return NSData(bytes: &bytes, length: sizeof(self.dynamicType))
    }
}

extension UInt8: FixedLengthDatable {

    init(bytes: [UInt8]) {
        var bytes = bytes
        let data = NSData(bytes: &bytes, length: 1)
        var out: UInt8 = 0
        data.getBytes(&out, length: sizeof(UInt8.self))
        self.init(out)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    var data: NSData {
        var bytes = self
        return NSData(bytes: &bytes, length: sizeof(self.dynamicType))
    }
}

extension Int16: FixedLengthDatable {

    init(bytes: [UInt8]) {
        var bytes = bytes
        let data = NSData(bytes: &bytes, length: 2)
        var out: Int16 = 0
        data.getBytes(&out, length: sizeof(Int16.self))
        self.init(out.bigEndian)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    var data: NSData {
        var bytes = self.bigEndian
        return NSData(bytes: &bytes, length: sizeof(self.dynamicType))
    }
}

extension UInt16: FixedLengthDatable {
    
    init(bytes: [UInt8]) {
        var bytes = bytes
        let data = NSData(bytes: &bytes, length: 2)
        var out: UInt16 = 0
        data.getBytes(&out, length: sizeof(UInt16.self))
        self.init(out.bigEndian)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    var data: NSData {
        var bytes = self.bigEndian
        return NSData(bytes: &bytes, length: sizeof(self.dynamicType))
    }
}

extension Int32: FixedLengthDatable {

    init(bytes: [UInt8]) {
        var bytes = bytes
        let data = NSData(bytes: &bytes, length: 4)
        var out: Int32 = 0
        data.getBytes(&out, length: sizeof(Int32.self))
        self.init(out.bigEndian)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    var data: NSData {
        var bytes = self.bigEndian
        return NSData(bytes: &bytes, length: sizeof(self.dynamicType))
    }
}

extension UInt32: FixedLengthDatable {

    init(bytes: [UInt8]) {
        var bytes = bytes
        let data = NSData(bytes: &bytes, length: 4)
        var out: UInt32 = 0
        data.getBytes(&out, length: sizeof(UInt32.self))
        self.init(out.bigEndian)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    var data: NSData {
        var bytes = self.bigEndian
        return NSData(bytes: &bytes, length: sizeof(self.dynamicType))
    }
}

extension Int: FixedLengthDatable {

    init(var bytes: [UInt8]) {
        let data = NSData(bytes: &bytes, length: sizeof(Int.self))
        var out: Int = 0
        data.getBytes(&out, length: sizeof(Int.self))
        self.init(out.bigEndian)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
   
    init(_ value: FixedLengthDatable) {
        var dataBytes = value.data
        let data = NSData(bytes: &dataBytes, length: sizeof(FixedLengthDatable.self))

        var out: Int = 0
        data.getBytes(&out, length: sizeof(Int.self))
        self.init(out.bigEndian)
    }
    
    var data: NSData {
        var bytes = self.bigEndian
        return NSData(bytes: &bytes, length: sizeof(self.dynamicType))
    }
}

extension Int64: FixedLengthDatable {

    init(var bytes: [UInt8]) {
        let data = NSData(bytes: &bytes, length: 8)
        var out: Int64 = 0
        data.getBytes(&out, length: sizeof(Int64.self))
        self.init(out.bigEndian)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    var data: NSData {
        var bytes = self.bigEndian
        return NSData(bytes: &bytes, length: sizeof(self.dynamicType))
    }
}

extension UInt64: FixedLengthDatable {

    init(var bytes: [UInt8]) {
        let data = NSData(bytes: &bytes, length: 8)
        var out: UInt64 = 0
        data.getBytes(&out, length: sizeof(UInt64.self))
        self.init(out.bigEndian)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    var data: NSData {
        var bytes = self.bigEndian
        return NSData(bytes: &bytes, length: sizeof(self.dynamicType))
    }
}

extension String: VariableLengthDatable {

    static func fromBytes(var bytes: [UInt8]) -> VariableLengthDatable {
        let data = NSData(bytes: &bytes, length: bytes.count)
        let string = String(data: data, encoding: NSUTF8StringEncoding) ?? ""
        return self.init(string)
    }
    
    var data: NSData {
        return self.dataUsingEncoding(
            NSUTF8StringEncoding,
            allowLossyConversion: true
        ) ?? NSData()
    }
}

extension NSData: VariableLengthDatable {

    static func fromBytes(var bytes: [UInt8]) -> VariableLengthDatable {
        return NSData(bytes: &bytes, length: bytes.count)
    }
    
    var data: NSData {
        return self
    }
}


extension NSStreamEvent {
    var description: String {
        switch self {
        case NSStreamEvent.None:
            return "None"
        case NSStreamEvent.OpenCompleted:
            return "Open Completed"
        case NSStreamEvent.HasBytesAvailable:
            return "Has Bytes Available"
        case NSStreamEvent.HasSpaceAvailable:
            return "Has Space Available"
        case NSStreamEvent.ErrorOccurred:
            return "Error Occurred"
        case NSStreamEvent.EndEncountered:
            return "End Encountered"
        default:
            return ""
        }
    }
}

extension NSStreamStatus {
    var description: String {
        switch self {
        case NSStreamStatus.NotOpen:
            return "Not Open"
        case NSStreamStatus.Opening:
            return "Opening"
        case NSStreamStatus.Open:
            return "Open"
        case NSStreamStatus.Reading:
            return "Reading"
        case NSStreamStatus.Writing:
            return "Writing"
        case NSStreamStatus.AtEnd:
            return  "End"
        case NSStreamStatus.Closed:
            return "Closed"
        case NSStreamStatus.Error:
            return "Error"
        }
    }
}

extension Array {
    
    mutating func slice(offset: Int, length: Int) -> [Element] {
        var values = [Element]()
        if self.count >= offset + length {
            for _ in offset..<(offset + length) {
                let value = self.removeAtIndex(offset)
                values.append(value)
            }
        }

        return values
    }
    
}