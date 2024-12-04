
build:
	bazel build //Tetris/Tetris:tetris-app

run:
	bazel run //Tetris/Tetris:tetris-app

xcode:
	bazel run //Tetris/Tetris:xcodeproj
	open Tetris/Tetris/Tetris.xcodeproj
