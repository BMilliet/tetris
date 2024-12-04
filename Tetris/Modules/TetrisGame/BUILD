load(
    "@rules_swift//swift:swift.bzl",
    "swift_library",
)

swift_library(
    name = "tetris_game_module",
    deps = ["//Tetris/Modules/ViewCode:view_code_module"],
    srcs = glob(["Sources/**/*.swift"]),
    visibility = ["//visibility:public"],
    module_name = "TetrisGame",
)
