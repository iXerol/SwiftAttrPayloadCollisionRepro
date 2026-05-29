#define SWIFT_SENDABLE __attribute__((__swift_attr__("@Sendable")))
#define SWIFT_UI_ACTOR __attribute__((swift_attr("@UIActor")))

@protocol SwiftAttrCollisionSendableFirst
- (void)firstWithCompletionHandler:(SWIFT_SENDABLE void (^)(int result))completionHandler;
@end

@protocol SwiftAttrCollisionUIActorSecond
@optional
- (void)secondWithCompletionHandler:(SWIFT_UI_ACTOR void (^)(int result))completionHandler;
@end
