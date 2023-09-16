import Foundation

public enum DependencyError: Error, Equatable {
    case resolveError(String)
}
