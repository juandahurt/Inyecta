//
//  Container.swift
//
//
//  Created by Juan David Hurtado on 8/09/24.
//

import Foundation

// TODO: check if we might need to return something here
// TODO: add register options: singleton and factory
// Describes the register capabitlity
public protocol ContainerRegistering {
    /// Registers an instance.
    /// - Parameter factory: closure that returns the instace.
    func register<T>(_ factory: @escaping () -> T)
}

public protocol ContainerResolving {
    /// Searchs for the required instance.
    ///
    /// - warning: It might return nil if it's not found in the container.
    /// - Parameter type: The type of the instance.
    /// - Returns: Return the required instance.
    func resolve<T>(_ type: T.Type) -> T?
}

struct ServiceKey {
    let id = UUID().uuidString
    let type: Any.Type
    // TODO: add options
}

extension ServiceKey: Hashable {
    static func == (lhs: ServiceKey, rhs: ServiceKey) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

/// Describes a container.
public class Container {
    // TODO: maybe we need to store the factory?
    var services: [ServiceKey: Any] = [:]
}

// MARK: - Register
extension Container: ContainerRegistering {
    public func register<T>(_ factory: @escaping () -> T) {
        services[.init(type: T.self)] = factory()
    }
}

extension Container: ContainerResolving {
    public func resolve<T>(_ type: T.Type) -> T? {
        guard let service = services.first(where: { $0.key.type == type })?.value else {
            // TODO: check how to notify user of error
            return nil
        }
        return service as? T
    }
}
