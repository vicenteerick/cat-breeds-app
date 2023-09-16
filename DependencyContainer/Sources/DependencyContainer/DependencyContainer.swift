public typealias HasDependencies = HasNetworkClient

protocol DependencyRegistrable {
    func register<Service>(type: Service.Type, service: @escaping () -> Service)
}

public final class DependencyContainer: DependencyRegistrable {

    private var services = [String: () -> Any]()

    public init() { }

    func register<Service>(type: Service.Type, service: @escaping () -> Service) {
        services["\(type)"] = service
    }
}

extension DependencyContainer {
    func resolve<Service>(type: Service.Type) -> Service? {
        services["\(type)"]?() as? Service
    }
}
