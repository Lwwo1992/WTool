
import UIKit
import SVProgressHUD

enum DCProgressHUDStatus {
    /// 成功
    case success
    /// 失败
    case error
    /// 叹号提示
    case info
    /// 等待
    case waitting
    /// 只显示文字
    case onlyText
    /// 过程
    case progress
}

public class HUD: NSObject {
    /// 纯文字提示
    static func showTipMessage(_ msg: String?) {
        showWithStatus(hudStatus: .onlyText, text: msg, progress: 0)
    }

    /// 带！图片的提示
    static func showInfoMsg(_ msg: String?) {
        showWithStatus(hudStatus: .info, text: msg, progress: 0)
    }

    /// 错误 带X的图片
    static func showFailure(_ msg: String?, toView: UIView?) {
        showWithStatus(hudStatus: DCProgressHUDStatus.error, text: msg, progress: 0)
    }

    /// 带图片 成功
    static func showSuccessWith(_ msg: String?, toView: UIView?) {
        showWithStatus(hudStatus: DCProgressHUDStatus.success, text: msg, progress: 0)
    }

    /// 显示加载
    static func showLoading(_ msg: String? = nil) {
        showWithStatus(hudStatus: .waitting, text: msg, progress: 0)
    }

    /// 显示进度
    static func showProgress(_ msg: String?, progress: CGFloat) {
        showWithStatus(hudStatus: .progress, text: msg, progress: progress)
    }

    static func hideNow() {
        SVProgressHUD.dismiss()
    }

    static func showWithStatus(hudStatus status: DCProgressHUDStatus, text msg: String?, progress: CGFloat) {
        let path = Bundle.main.path(forResource: "MyProgressBundle", ofType: "bundle")
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        switch status {
        case .success:
            let sucssPath = path?.appendingFormat("/%@", "hud_success.png")
            let img = UIImage(contentsOfFile: sucssPath!)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
            SVProgressHUD.setSuccessImage(img!)
            SVProgressHUD.showSuccess(withStatus: msg)
            SVProgressHUD.setMinimumSize(CGSize(width: 100, height: 80))
            SVProgressHUD.dismiss(withDelay: 1.5)
            break
        case .error:
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.none)
            let sucssPath = path?.appendingFormat("/%@", "hud_error.png")
            let img = UIImage(contentsOfFile: sucssPath!)
            SVProgressHUD.setErrorImage(img!)
            SVProgressHUD.showError(withStatus: msg)
            SVProgressHUD.dismiss(withDelay: 1.5)
            break
        case .info:
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.none)
            let sucssPath = path?.appendingFormat("/%@", "hud_info.png")
            let img = UIImage(contentsOfFile: sucssPath!)
            SVProgressHUD.setMinimumSize(CGSize(width: 100, height: 80))
            SVProgressHUD.setInfoImage(img ?? UIImage())
            SVProgressHUD.showInfo(withStatus: msg)
            SVProgressHUD.dismiss(withDelay: 1.5)
            break
        case .waitting:
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
            SVProgressHUD.show(withStatus: msg)
            break
        case .onlyText:
            /// 这种纯文字的显示时候文字会偏下，效果没有那么完美，可以用MBProgressHUDdle或Toast或找个swift的库
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.none)
            SVProgressHUD.setInfoImage(UIImage(named: "") ?? UIImage())
            SVProgressHUD.setImageViewSize(CGSize.zero)
            SVProgressHUD.setMinimumSize(CGSize(width: 10, height: 10))
            SVProgressHUD.setFont(UIFont.systemFont(ofSize: 16))
            SVProgressHUD.showInfo(withStatus: msg)
            SVProgressHUD.dismiss(withDelay: 1.5)
            break
        case .progress:
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.none)
            SVProgressHUD.showProgress(Float(progress), status: msg)
        }
    }
}
