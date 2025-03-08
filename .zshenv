#
# ~/.zshenv
#
# Sourced on all shell invocations.
#
# Most commonly used for exported variables that should be available to other programs.
#

# Add to path:
# Cargo
path+=('$HOME/.cargo/bin')
path+=('$HOME/.cargo/env')
# Ruby gems
path+=('$HOME/computer/gems/bin')
path+=('$HOME/.local/share/gem/ruby/3.0.0/bin')
# Config binaries
path+=('$HOME/.config/bin')
# Cross-compiler
path+=('$HOME/opt/cross_i686-elf/bin')

# Get env vars
export $(envsubst <$HOME/.config/env)
