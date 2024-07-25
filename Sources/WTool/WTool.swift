// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public class WTool {
    public static func countryCode() -> String {
        return Locale.current.regionCode ?? "CN"
    }
}

public extension WTool {
    /// 返回合法的URL
    static func formatURL(_ string: String, withPrefix prefix: String) -> String {
        var urlString = string

        let httpRange = string.range(of: "http://")
        let httpsRange = string.range(of: "https://")

        if httpRange != nil {
            urlString.removeSubrange(httpRange!)
        } else if httpsRange != nil {
            urlString.removeSubrange(httpsRange!)
        }

        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)!

        urlString = "\(prefix)\(urlString)"

        return urlString
    }
}
