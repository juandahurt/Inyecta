//
//  Container.swift
//
//
//  Created by Juan David Hurtado on 8/09/24.
//

import Foundation

public typealias Factory<T> = () -> T

struct ServiceKey {
    let id = UUID().uuidString
    /// The type of the service.
    let type: Any.Type
    /// Type of registration.
    let registrationType: RegistrationType
}

extension ServiceKey: Hashable {
    static func == (lhs: ServiceKey, rhs: ServiceKey) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// Describes the types of service registration.
public enum RegistrationType {
    /// The factory will be called only once. The instance will be stored and every time you try to access it
    /// you will get the same instance.
    case singleton
    /// The factory will be called every time you try to resolve the instance.
    /// You will get the value returned by the factory.
    case factory
}

struct ServiceValue {
    /// The actual service.
    let instance: Any?
    /// It's just the closure that returns the service.
    let factory: Factory<Any>?
    
    init(instance: Any? = nil, factory: Factory<Any>? = nil) {
        self.instance = instance
        self.factory = factory
    }
}

/// Describes a container.
public class Container {
    // TODO: maybe we need to store the factory?
    var services: [ServiceKey: ServiceValue] = [:]
}
