import Foundation
import WebKit

final class ProcessInfoWebKitConfirmWitness: NSObject, WKUIDelegate {
  @MainActor
  func webView(
    _ webView: WKWebView,
    runJavaScriptConfirmPanelWithMessage message: String,
    initiatedByFrame frame: WKFrameInfo,
    completionHandler: @escaping @MainActor @Sendable (Bool) -> Void
  ) {}
}
