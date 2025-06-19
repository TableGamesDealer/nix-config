#!/bin/bash

languages=("bash" "c" "cpp" "c-sharp" "cmake" "css" "fish" "go" "haskell" "html" "java" "javascript" "just" "json" "lua" "markdown" "nix" "nu" "ocaml" "odin" "python" "ruby" "rust" "swift" "toml" "typescript" "yaml" "zig")

for lang in "${languages[@]}"; do
	echo "Checking health for $lang:"
	hx --health "$lang"
	echo "----------------"
done | sed -r 's/\x1B\[[0-9;]*[mK]//g' | hx -
