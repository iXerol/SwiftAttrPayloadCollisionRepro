# SwiftAttr Payload Collision Repro

This is a minimal Swift Package reproducer for an Objective-C optional protocol
witness mismatch caused by a Clang `AttributedType` uniquing collision for
`swift_attr` type attributes.

The repro uses the currently selected Swift toolchain. It does not hard-code any
snapshot paths.

## Run

```bash
swift build
```

To run with a specific installed toolchain:

```bash
/path/to/toolchain/usr/bin/swift build
```

A fixed toolchain should build successfully.
An affected toolchain fails with `nearly matches optional requirement` promoted
to an error by `-warnings-as-errors`.

## Known Affected and Fixed Releases

Known affected public release:

- Xcode 26.3
- Swift 6.2.4

Known fixed public release:

- Xcode 26.4
- Swift 6.3

The fix entered Swift through the LLVM/Clang rebranch:

- Swift PR: [swiftlang/swift#84606](https://github.com/swiftlang/swift/pull/84606)
- Swift merge commit: [`03a599c5be57da27a9708bfb93f159bf0aa47a22`](https://github.com/swiftlang/swift/commit/03a599c5be57da27a9708bfb93f159bf0aa47a22)
- Commit subject: `Merge clang 21.x rebranch into main`

The underlying LLVM fix is:

- LLVM PR: [llvm/llvm-project#108631](https://github.com/llvm/llvm-project/pull/108631)
- LLVM commit: [`d3daa3c4435a54f7876d0ced81787fea92e77d08`](https://github.com/llvm/llvm-project/commit/d3daa3c4435a54f7876d0ced81787fea92e77d08)

The LLVM fix includes the `Attr *` in `AttributedType::Profile`, so two
`swift_attr` type attributes with the same Clang attribute kind but different
payloads no longer fold into the same `AttributedType`.

## Why This Reproduces the Bug

The package has two Objective-C header-only targets. Each target defines two
same-shaped block types in the same Clang AST context, but with different
`swift_attr` payloads:

```objc
- (void)firstWithCompletionHandler:
    (__attribute__((swift_attr("@Sendable"))) void (^)(int result))completionHandler;

- (void)secondWithCompletionHandler:
    (__attribute__((swift_attr("@UIActor"))) void (^)(int result))completionHandler;
```

Historically, `SwiftAttr` was a single Clang attribute kind and the
`AttributedType` uniquing key did not include the attribute payload. That meant
same-shaped block types with different Swift attributes could collide. The
payload created first won.

This package checks both declaration orders:

- `SendableFirstAPI` creates `@Sendable` first, then an optional requirement
  using `@UIActor`. The Swift witness uses `@MainActor @Sendable`.
- `UIActorFirstAPI` creates `@UIActor` first, then an optional requirement using
  `@Sendable`. The Swift witness uses only `@Sendable`.

Both directions matter because the historical failure was order-dependent.

The second protocol requirement is intentionally optional. Making it required can
also expose the same imported type mismatch on affected toolchains, but Swift may
also import a required completion-handler method as an additional `async`
requirement. Keeping the method optional preserves the focused user-visible
failure mode: `nearly matches optional requirement`.

The Swift witnesses intentionally omit `@escaping`. Many real completion-handler
APIs do escape, and adding `@escaping` still reproduces the bug, but escaping is
not part of the `swift_attr` payload collision. Omitting it keeps the diagnostic
focused on the imported `@MainActor` / `@Sendable` mismatch.
