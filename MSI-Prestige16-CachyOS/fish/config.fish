source /usr/share/cachyos-fish-config/cachyos-config.fish
set -x http_proxy http://127.0.0.1:7897; set -x https_proxy http://127.0.0.1:7897

# CUDA Toolkit (Arch Linux default location)
set -gx CUDA_HOME /opt/cuda

# Add CUDA binaries to PATH (persistent across sessions)
fish_add_path /opt/cuda/bin

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH



# Added by Antigravity CLI installer
set -gx PATH "/home/xc/.local/bin" $PATH
