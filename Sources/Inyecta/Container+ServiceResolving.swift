//
//  Container+ServiceResolving.swift
//
//
//  Created by Juan David Hurtado on 9/09/24.
//

public protocol ContainerResolving {
    /// Searchs for the required instance.
    ///
    /// - warning: It might return nil if it's not found in the container.
    /// - Parameter type: The type of the instance.
    /// - Returns: Return the required instance.
    func resolve<T>(_ type: T.Type) -> T?
}

extension Container: ContainerResolving {
    func _resolveSingleton<T>(from dictElement: Dictionary<ServiceKey, ServiceValue>.Element) -> T? {
        dictElement.value.instance as? T
    }
    
    func _resolveFactory<T>(from dictElement: Dictionary<ServiceKey, ServiceValue>.Element) -> T? {
        dictElement.value.factory?() as? T
    }
    
    public func resolve<T>(_ type: T.Type) -> T? {
        guard let dictElement = services.first(where: { $0.key.type == type }) else {
            // TODO: check how to notify user of error
            return nil
        }
        switch dictElement.key.registrationType {
        case .factory:
            return _resolveFactory(from: dictElement)
        case .singleton:
            return _resolveSingleton(from: dictElement)
        }
    }
}
