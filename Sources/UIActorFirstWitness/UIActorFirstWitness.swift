import UIActorFirstAPI

final class SwiftAttrCollisionSendableSecondWitness: SwiftAttrCollisionSendableSecond {
  func second(completionHandler: @Sendable (Int32) -> Void) {}
}
