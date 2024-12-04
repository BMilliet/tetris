# load(
#     "@rules_apple//apple:ios.bzl",
#     "ios_application",
# )

# load(
#     "@rules_swift//swift:swift.bzl",
#     "swift_library",
# )

# swift_library(
#     name = "view_code_module",
#     srcs = glob(["Modules/ViewCode/Sources/**/*.swift"]),
#     visibility = ["//visibility:private"],
#     module_name = "ViewCode"
# )

# swift_library(
#     name = "tetris_game_module",
#     deps = [":view_code_module"],
#     srcs = glob(["Modules/TetrisGame/Sources/**/*.swift"]),
#     visibility = ["//visibility:private"],
#     module_name = "TetrisGame"
# )

# swift_library(
#     name = "tetris",
#     deps = [":tetris_game_module"],
#     srcs = glob(["Tetris/Tetris/*.swift"]),
#     visibility = ["//visibility:private"],
#     module_name = "TetrisApp"
# )

# ios_application(
#     name = "tetris-app",
#     bundle_id = "com.example.tetris",
#     families = [
#         "iphone",
#     ],
#     infoplists = ["Tetris/Tetris/Info.plist"],
#     resources = glob(["Tetris/Tetris/Assets.xcassets/**"]),
#     minimum_os_version = "16.2",
#     visibility = ["//visibility:public"],
#     deps = [":tetris"],
# )



load("@rules_apple//apple:ios.bzl", "ios_application")

ios_application(
    name = "tetris-app",
    bundle_id = "com.example.tetris",
    families = ["iphone"],
    infoplists = [
        "//Tetris/Tetris:Info.plist"
        ],
    resources = glob([
        "//Tetris/Tetris:Assets.xcassets/**/*",
        "//Tetris/Tetris:Base.lproj/**/*"
        ]),
    minimum_os_version = "16.2",
    visibility = ["//visibility:public"],
    deps = ["//Tetris/Tetris:tetris_module"],  # Referência ao módulo Tetris em Tetris/Tetris/BUILD
)
