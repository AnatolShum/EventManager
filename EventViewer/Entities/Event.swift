//
//  Event.swift
//  EventManager
//
//  Created by Ilya Kharlamov on 6/17/22.
//

import Foundation

public struct Event: Identifiable {

    public let id: String
    public var parameters: ParameterSet
    public let createdAt: Date

    public init(id: String, parameters: ParameterSet = [:], createdAt: Date) {
        self.id = id
        self.parameters = parameters
        self.createdAt = createdAt
    }

}
