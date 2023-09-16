import Foundation
import Combine

public protocol ClientPublishing {
    func request<T: Decodable>(setup: Endpoint) -> AnyPublisher<T, ServiceError>
}

public class NetworkClient: ClientPublishing, ObservableObject {

    private var baseUrl: String
    private let session: URLSessionTaskable

    private var decoder: JSONDecoder = {
        let deconder = JSONDecoder()
        deconder.keyDecodingStrategy = .convertFromSnakeCase
        return deconder
    }()

    init(baseUrl: String, session: URLSessionTaskable = URLSession.shared) {
        self.baseUrl = baseUrl
        self.session = session
    }

    public func request<T>(setup: Endpoint) -> AnyPublisher<T, ServiceError> where T: Decodable {
        let request: URLRequest

        do {
            request = try URLRequest(baseUrl: baseUrl, setup: setup)
            print("REQUEST")
            print(request.description)
        } catch let error as ServiceError {
            print(error.localizedDescription)
            return AnyPublisher(Fail<T, ServiceError>(error: error))
        } catch let error {
            print(error.localizedDescription)
            return AnyPublisher(Fail<T, ServiceError>(error: ServiceError.unknown(error.localizedDescription)))
        }

        return session
            .dataTaskAnyPublisher(for: request)
            .tryMap { [weak self] element -> Data in
                guard let self = self else {
                    throw ServiceError.unknown("")
                }

                print("RESPONSE")
                print(element.response.description)
                print("\(String(data: element.data, encoding: .utf8) ?? "")")

                guard let urlResponse = element.response as? HTTPURLResponse else {
                    throw ServiceError.invalidHttpUrlResponse
                }

                if let error = self.handleStatusError(code: urlResponse.statusCode,
                                                      data: element.data) {
                    print(error.localizedDescription)
                    throw error
                }

                return element.data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                switch error {
                case let decodeError as DecodingError:
                    return ServiceError.responseDecondingFailure(decodeError.localizedDescription)
                case let serviceError as ServiceError:
                    return serviceError
                default:
                    return ServiceError.unknown(error.localizedDescription)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func handleStatusError(code: Int, data: Data) -> ServiceError? {
        switch code {
        case 200...299:
            return nil
        case 401:
            return .authenticationRequired
        case 404:
            return .hostNotFound
        case 409:
            return .alreadyExist
        case 500:
            return .badRequest
        default:
            return .requestFailure(data)
        }
    }
}
