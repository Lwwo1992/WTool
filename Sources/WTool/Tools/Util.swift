//
//  Util.swift
//  WTool
//
//  Created by xyxy on 2024/10/8.
//

import UIKit

public class Util {
    @available(iOSApplicationExtension, unavailable)
    public static func getKeyWindow() -> UIWindow? {
        if #available(iOS 13.0, *),
           UIApplication.shared.supportsMultipleScenes {
            return UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .compactMap { $0 as? UIWindowScene }
                .first?.windows
                .first(where: { $0.isKeyWindow })
        } else {
            // Fallback for iOS versions below 13.0
            return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        }
    }

    @available(iOSApplicationExtension, unavailable)
    public static func topViewController() -> UIViewController {
        return topViewControllerOptional()!
    }

    @available(iOSApplicationExtension, unavailable)
    public static func topViewControllerOptional() -> UIViewController? {
        guard let rootViewController = getKeyWindow()?.rootViewController else {
            return nil
        }
        return getTopViewController(from: rootViewController)
    }

    @available(iOSApplicationExtension, unavailable)
    public static func getTopViewController(from viewController: UIViewController) -> UIViewController {
        if let presented = viewController.presentedViewController {
            return getTopViewController(from: presented)
        } else if let nav = viewController as? UINavigationController, let top = nav.topViewController {
            return getTopViewController(from: top)
        } else if let tab = viewController as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(from: selected)
        }
        return viewController
    }

    /// 是否横竖屏，用户界面横屏了才会返回true
    @available(iOSApplicationExtension, unavailable)
    public static var isLandscape: Bool {
        if #available(iOS 13.0, *) {
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return false // Or return a default orientation, like `false` for portrait
            }
            return scene.interfaceOrientation.isLandscape
        } else {
            // Fallback for iOS versions before 13.0
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }

    /// 屏幕宽度，跟横竖屏无关
    @available(iOSApplicationExtension, unavailable)
    public static let deviceWidth = isLandscape ? UIScreen.main.bounds.height : UIScreen.main.bounds.width

    /// 屏幕高度，跟横竖屏无关
    @available(iOSApplicationExtension, unavailable)
    public static let deviceHeight = isLandscape ? UIScreen.main.bounds.width : UIScreen.main.bounds.height
}

public extension Util {
    /// 验证手机号码
    public static func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = "^[0-9]{10}$" // 这是一个简单的正则表达式，只匹配10位数字（你可以根据需要进行调整）
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }

    /// 验证邮箱地址
    public static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return !emailTest.evaluate(with: email)
    }
}

public extension Util {
    /// 获取版本号
    static func appVersion() -> String {
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    }

}
