{pkgs}:
with pkgs; [
  git
  gh
  helix
  zellij
  yazi
  fzf
  zoxide
  eza
  bat
  ripgrep
  gitui
  gh-dash
  bottom
  dust
  oh-my-posh
  remarshal
  sc-im
  viu

  # libs
  # libiconv

  # emulation
  qemu

  # below is a collection of language and lsps that I may not need

  # English spellchecker
  ltex-ls

  # nix
  nil # nix lsp
  alejandra # nix formatter

  # bash
  bash
  bash-language-server # bash lsp
  shfmt # bash formatter

  # c/c++
  gcc # c compiler
  clang-tools # c lsp

  # c#
  mono # c-sharp compilers mcs and csc
  omnisharp-roslyn # c-sharp lsp
  netcoredbg # c-sharp debugger
  csharpier # formatter

  # cmake
  cmake # cmake program
  cmake-language-server # cmake lsp
  cmake-format # cmake formatter

  # css
  vscode-langservers-extracted # HTML/CSS/JSON/ESLint language servers extracted from vscode

  # fish
  fish
  fish-lsp

  # go
  go # go compiler
  gopls # go lsp
  gofumpt # go formatter
  delve # go debugger

  # haskell
  ghc # haskell compiler
  haskell-language-server # haskell lsp
  ormolu # haskell formatter

  # html
  superhtml

  # java
  jdk # Open-source Java Development Kit
  jdt-language-server # java lsp
  google-java-format # java formatter

  # javascript
  nodejs # javascript tooling
  nodePackages.prettier # general formatter
  typescript-language-server # javascript lsp

  # just
  just
  just-lsp # just lsp
  just-formatter # just formatter

  # lua
  lua # lua lang
  lua-language-server # lua lsp
  stylua # lua formatter

  # markdown
  markdown-oxide
  typos-lsp

  # nu
  nushell
  nufmt

  # ocaml
  ocaml
  ocamlPackages.ocaml-lsp
  ocamlPackages.ocamlformat

  # odin
  odin
  ols # also provides odinfmt

  # python
  python3
  basedpyright
  ruff # formatter and linter?

  # ruby
  ruby
  rubyPackages.solargraph # ruby lsp
  rubyPackages.rubocop # ruby formatter

  # rust
  rustup

  # steel
  steel

  # toml
  taplo

  # yaml-language-server
  yaml-language-server

  #zig
  zig
  zls

  # llvm debuger
  lldb_20
]
