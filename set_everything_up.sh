# This bash script should set up my custom configuration on a new machine. This entails three things:
# 1. Install oh-my-zsh
# 2. Set up symlinks in ~ to the appropriate dotfiles in ./dotfiles
# 3. Change the default shell to zsh



# 1. Install oh-my-zsh

# Backup existing zshrc if it exists
if [-e ~/.zshrc]
  then
    mv ~/.zshrc ./.zshrc_bak
fi

# Clone the repository
git clone git://github.com/robbyrussell/oh-my-zsh.git ./oh-my-zsh


# 2. Set up symlinks
ln -s ~/.custom_config/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.custom_config/dotfiles/.zshrc ~/.zshrc
ln -s ~/.custom_config/dotfiles/mytheme.zsh-theme ~/.custom_config/oh-my-zsh/themes/mytheme.zsh-theme

# 3. Change default shell to zsh, if it's installed

# Check to see if zsh if available
ZSH_LOCATIONS=`grep zsh /etc/shells` 
if $ZSH_LOCATIONS;
  then
    # Try all the possible zsh locations we found. Hopefully, nobody has been messing with our zsh binaries.
    for path in $ZSH_LOCATIONS
      do
        echo "Attempting to switch shell to zsh, at $path"
        if chsh -s $path;
          then
            # We're all done here.
            break
          else
            echo "Failed to switch shell to zsh, at $path"
        fi
      done
    chsh -s /bin/zsh

  else
    echo "No zsh installation found. Please install zsh, then rerun this script."
fi


