#define SWIFT_SENDABLE __attribute__((__swift_attr__("@Sendable")))
#define SWIFT_UI_ACTOR __attribute__((swift_attr("@UIActor")))

@protocol SwiftAttrCollisionUIActorFirst
- (void)firstWithCompletionHandler:(SWIFT_UI_ACTOR void (^)(int result))completionHandler;
@end

@protocol SwiftAttrCollisionSendableSecond
@optional
- (void)secondWithCompletionHandler:(SWIFT_SENDABLE void (^)(int result))completionHandler;
@end
