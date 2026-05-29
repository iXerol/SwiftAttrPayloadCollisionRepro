import SendableFirstAPI

final class SwiftAttrCollisionUIActorSecondWitness: SwiftAttrCollisionUIActorSecond {
  func second(completionHandler: @MainActor @Sendable (Int32) -> Void) {}
}
