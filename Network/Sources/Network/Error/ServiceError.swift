import Foundation

public enum ServiceError: Error, Equatable {
    case authenticationRequired
    case hostNotFound
    case badRequest
    case invalidHttpUrlResponse
    case invalidBaseUrl
    case invalidUrl
    case alreadyExist
    case parameterUrlEncodingNotFound
    case parameterJsonEncodingFailure(String)
    case brokenData(Int)
    case notConnectedToInternet(String)
    case requestFailure(Data)
    case responseDecondingFailure(String)
    case unknown(String)
}
