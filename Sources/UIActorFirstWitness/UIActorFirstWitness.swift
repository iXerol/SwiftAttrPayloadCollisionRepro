import UIActorFirstAPI

final class SwiftAttrCollisionSendableSecondWitness: SwiftAttrCollisionSendableSecond {
  func second(completionHandler: @escaping @Sendable (Int32) -> Void) {}
}
