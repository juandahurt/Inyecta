//
//  Container+ServiceRegistration.swift
//
//
//  Created by Juan David Hurtado on 9/09/24.
//

// Describes the register capabitlity
public protocol ServiceRegistration {
    /// Registers an instance.
    /// - Parameter registrationType: The kind of registration for the instance. Singleton by default.
    /// - Parameter factory: Closure that returns the instance.
    func register<T>(_ registrationType: RegistrationType, _ factory: @escaping Factory<T>)
}

// MARK: - Register
extension Container: ServiceRegistration {
    func _registerSingleton<T>(using factory: Factory<T>) {
        services[.init(type: T.self, registrationType: .singleton)] = .init(instance: factory())
    }
    
    func _registerFactory<T>(_ factory: @escaping Factory<T>) {
        services[.init(type: T.self, registrationType: .factory)] = .init(factory: factory)
    }
    
    public func register<T>(_ registrationType: RegistrationType = .singleton, _ factory: @escaping Factory<T>) {
        switch registrationType {
        case .factory:
            _registerFactory(factory)
        case .singleton:
            _registerSingleton(using: factory)
        }
    }
}
