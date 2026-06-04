import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
func seedProcessInfoSendableBoolBlock() {
  ProcessInfo.processInfo.performExpiringActivity(withReason: "seed") { expired in
    _ = expired
  }
}
#endif
