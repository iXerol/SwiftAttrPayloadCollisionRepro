import SendableFirstAPI

final class SwiftAttrCollisionUIActorSecondWitness: SwiftAttrCollisionUIActorSecond {
  func second(completionHandler: @escaping @MainActor @Sendable (Int32) -> Void) {}
}
