
load("@rules_swift//swift:swift.bzl", "swift_library")
load("@rules_apple//apple:ios.bzl", "ios_application")

swift_library(
    name = "tetris_module",
    deps = ["//Tetris/Modules/TetrisGame:tetris_game_module"],
    srcs = glob(["Tetris/*.swift"]),
    visibility = ["//visibility:private"],
    module_name = "TetrisApp",
)

ios_application(
    name = "tetris-app",
    bundle_id = "com.example.tetris",
    families = ["iphone"],
    infoplists = ["Tetris/Info.plist"],
    resources = glob(["Tetris/Base.lproj/**/*", "Tetris/Assets.xcassets/**/*"]),
    minimum_os_version = "16.2",
    visibility = ["//visibility:public"],
    deps = [":tetris_module"],
)
