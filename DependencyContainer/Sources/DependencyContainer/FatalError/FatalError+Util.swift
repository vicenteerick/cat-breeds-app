import Foundation

func fatalError(_ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) -> Never {
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
}

enum FatalErrorUtil {
    typealias FatalErrorClosureType = (String, StaticString, UInt) -> Never

    static var fatalErrorClosure: FatalErrorClosureType = defaultFatalErrorClosure

    private static let defaultFatalErrorClosure: FatalErrorClosureType = { Swift.fatalError($0, file: $1, line: $2) }

    static func replaceFatalError(closure: @escaping FatalErrorClosureType) {
        fatalErrorClosure = closure
    }

    static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}
