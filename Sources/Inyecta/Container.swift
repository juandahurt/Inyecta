//
//  Container.swift
//
//
//  Created by Juan David Hurtado on 8/09/24.
//

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

/// Describes a container.
public class Container {
    // TODO: find a proper way of a key for the dictionary
    // TODO: maybe we need to store the factory?
    var services: [UInt: Any] = [:]
}

// MARK: - Register
extension Container: ContainerRegistering {
    public func register<T>(_ factory: @escaping () -> T) {
        services[0] = factory()
    }
}

extension Container: ContainerResolving {
    public func resolve<T>(_ type: T.Type) -> T? {
        guard let service = services.first(where: { $0.value is T })?.value else {
            // TODO: check how to notify user of error
            return nil
        }
        return service as? T
    }
}
