//
//  AdminAPI.swift
//  Franz
//
//  Created by Kellan Cummings on 1/19/16.
//  Copyright © 2016 Kellan Cummings. All rights reserved.
//

import Foundation

class ListGroupsRequest: KafkaRequest {
    init() {
        super.init(apiKey: ApiKey.ListGroupsRequest)
    }
}


class ListGroupsResponse: KafkaResponse {
    
    private var _errorCode: KafkaInt16
    private var _groups: KafkaArray<ListedGroup>
    
    var error: KafkaErrorCode? {
        return KafkaErrorCode(rawValue: _errorCode.value)
    }
    
    var groups: [String: String] {
        var groups = [String: String]()
        
        for group in _groups.values {
            groups[group.id] = group.groupProtocolType
        }
        
        return groups
    }
    
    required init(inout bytes: [UInt8]) {
        _errorCode = KafkaInt16(bytes: &bytes)
        _groups = KafkaArray(bytes: &bytes)
        super.init(bytes: &bytes)
    }
    
    lazy var length: Int = {
        return self._errorCode.length +
            self._groups.length
    }()
    
    lazy var data: NSData = {
        let data = NSMutableData(capacity: self.length)!
        data.appendData(self._errorCode.data)
        data.appendData(self._groups.data)
        return data
    }()
    
    override var description: String {
        return "LIST GROUPS RESPONSE:\n" +
            "\tERROR CODE: \(self.error?.code ?? 0)\n" +
            "\tERROR DESCRIPTION: \(self.error?.description ?? String())\n" +
            "\tGROUPS(\(self._groups.length)):\n" +
            _groups.description
    }
}


class ListedGroup: KafkaClass {
    private var _groupId: KafkaString
    private var _protocolType: KafkaString
    
    var id: String {
        return _groupId.value ?? String()
    }
    
    var groupProtocolType: String {
        return _protocolType.value ?? String()
    }
    
    required init(inout bytes: [UInt8]) {
        _groupId = KafkaString(bytes: &bytes)
        _protocolType = KafkaString(bytes: &bytes)
    }
    
    
    lazy var length: Int = {
        return  self._groupId.length +
            self._protocolType.length
        
    }()
    
    lazy var data: NSData = {
        let data = NSMutableData(capacity: self.length)!
        data.appendData(self._groupId.data)
        data.appendData(self._protocolType.data)
        return data
    }()
    
    lazy var description: String = {
        return "\t\tGROUP ID(\(self._groupId.length)): \(self.id) => \(self._groupId.data)\n" +
        "\t\tPROTOCOL TYPE(\(self._protocolType.length)): \(self.groupProtocolType) => \(self._protocolType.data)\n"
    }()
}


class DescribeGroupsRequest: KafkaRequest {

    convenience init(id: String) {
        self.init(value: DescribeGroupsRequestMessage(groupIds: [id]))
    }

    convenience init(ids: [String]) {
        self.init(value: DescribeGroupsRequestMessage(groupIds: ids))
    }

    init(value: DescribeGroupsRequestMessage) {
        super.init(apiKey: ApiKey.DescribeGroupsRequest, value: value)
    }
}


class DescribeGroupsRequestMessage: KafkaClass {
    private var _groupIds: KafkaArray<KafkaString>
    
    init(groupIds: [String]) {
        var values = [KafkaString]()
        for value in groupIds {
            values.append(KafkaString(value: value))
        }
        _groupIds = KafkaArray(values: values)
    }
    
    required init(inout bytes: [UInt8]) {
        _groupIds = KafkaArray(bytes: &bytes)
    }
    
    lazy var length: Int = {
        return  self._groupIds.length
    }()
    
    lazy var data: NSData = {
        let data = NSMutableData(capacity: self.length)!
        data.appendData(self._groupIds.data)
        return data
    }()
    
    lazy var description: String = {
        return "GROUP ID(\(self._groupIds.length)): \(self._groupIds.values) => \(self._groupIds.data)"
    }()
}


class DescribeGroupsResponse: KafkaResponse {
    private var _groups: KafkaArray<GroupStateResponse>
    
    var states: [GroupStateResponse] {
        return _groups.values
    }
    
    required init(inout bytes: [UInt8]) {
        _groups = KafkaArray(bytes: &bytes)
        super.init(bytes: &bytes)
    }
    
    lazy var length: Int = {
        return self._groups.length
    }()
    
    lazy var data: NSData = {
        let data = NSMutableData(capacity: self.length)!
        data.appendData(self._groups.data)
        return data
    }()
    
    override var description: String {
        return "DESCRIBE GROUP RESPONSE:\n" +
            "\tGROUPS:\n" + self._groups.description
    }
}


class GroupStateResponse: KafkaClass {
    private var _errorCode: KafkaInt16
    private var _groupId: KafkaString
    private var _state: KafkaString
    private var _protocolType: KafkaString
    private var _protocol: KafkaString
    private var _members: KafkaArray<GroupMemberResponse>
    
    var id: String? {
        return _groupId.value
    }
    
    var kafkaProtocol: String? {
        return _protocol.value
    }
    
    var protocolType: GroupProtocol? {
        if let type = _protocolType.value {
            if type == "consumer" {
                return GroupProtocol.Consumer
            } else {
                return GroupProtocol.Custom(name: type)
            }
        } else {
            return nil
        }
    }

    var error: KafkaErrorCode? {
        return KafkaErrorCode(rawValue: _errorCode.value)
    }
    
    var state: GroupState? {
        if let state = _state.value {
            return GroupState(rawValue: state)
        } else {
            return nil
        }
    }
    
    var members: [GroupMemberResponse] {
        return _members.values
    }

    required init(inout bytes: [UInt8]) {
        _errorCode = KafkaInt16(bytes: &bytes)
        _groupId = KafkaString(bytes: &bytes)
        _state = KafkaString(bytes: &bytes)
        _protocolType = KafkaString(bytes: &bytes)
        _protocol = KafkaString(bytes: &bytes)
        _members = KafkaArray(bytes: &bytes)
    }
    
    
    lazy var length: Int = {
        return self._errorCode.length +
            self._groupId.length +
            self._state.length +
            self._protocolType.length +
            self._protocol.length +
            self._members.length
    }()
    
    lazy var data: NSData = {
        let data = NSMutableData(capacity: self.length)!
        data.appendData(self._groupId.data)
        data.appendData(self._protocolType.data)
        return data
    }()
    
    lazy var description: String = {
        return "\tERROR CODE: \(self.error?.code ?? 0)\n" +
            "\tERROR DESCRIPTION: \(self.error?.description ?? String())\n" +
            "\tGROUP ID(\(self._groupId.length)): \(self.id) => \(self._groupId.data)\n" +
            "\tSTATE(\(self._state.length)): \(self.state) => \(self._state.data)\n" +
            "\tPROTOCOL TYPE(\(self._protocolType.length)): \(self._protocolType.value) => \(self._protocolType.data)\n" +
            "\tPROTOCOL(\(self._protocol.length)): \(self.kafkaProtocol) => \(self._protocol.data)\n" +
            "\tMEMBERS(\(self._members.length)):\n" +
            self._members.description
    }()
}


class GroupMemberResponse: KafkaClass {
    private var _memberId: KafkaString
    private var _clientId: KafkaString
    private var _clientHost: KafkaString
    private var _memberMetadata: KafkaBytes
    private var _memberAssignment: KafkaBytes
    
    var memberId: String {
        return _memberId.value ?? String()
    }

    var clientId: String {
        return _clientId.value ?? String()
    }
    
    var host: String {
        return _clientHost.value ?? String()
    }
    
    required init(inout bytes: [UInt8]) {
        _memberId = KafkaString(bytes: &bytes)
        _clientId = KafkaString(bytes: &bytes)
        _clientHost = KafkaString(bytes: &bytes)
        _memberMetadata = KafkaBytes(bytes: &bytes)
        _memberAssignment = KafkaBytes(bytes: &bytes)
    }
    
    
    lazy var length: Int = {
        return self._memberId.length +
            self._clientId.length +
            self._clientHost.length +
            self._memberMetadata.length +
            self._memberAssignment.length
    }()
    
    lazy var data: NSData = {
        let data = NSMutableData(capacity: self.length)!
        return data
    }()
    
    lazy var description: String = {
        return "\t\tMEMBER ID: \(self.memberId)\n" +
            "\t\tCLIENT ID: \(self.clientId)\n" +
            "\t\tCLIENT HOST: \(self.host)\n" +
            "\t\tMEMBER METADATA: \(self._memberMetadata.value)\n" +
            "\t\tMEMBER METADATA: \(self._memberAssignment.value)\n"
    }()
}
