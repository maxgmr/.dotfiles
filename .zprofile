# Inherit .zshrc
if [ -f /home/$USER/.zshrc ]; then
    source /home/$USER/.zshrc
else
    print "404: /home/$USER/.zshrc not found :c"
fi

# Show fastfetch on startup for fun
fastfetch --logo-color-1 cyan --logo-color-2 cyan --color cyan
