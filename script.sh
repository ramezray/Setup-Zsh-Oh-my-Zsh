#!/bin/bash

# Check for existing ZSH installation
if ! command -v zsh &> /dev/null; then
  echo "Installing ZSH..."
  sudo apt install zsh
fi

# Verify ZSH installation
zsh_version=$(zsh --version)
if [[ -z "$zsh_version" ]]; then
  echo "Failed to install ZSH. Please check the installation process."
  exit 1
fi

# Set ZSH as default shell (with user confirmation)
echo "Do you want to set ZSH as your default shell? (y/N)"
read -r set_zsh
if [[ "<span class="math-inline">set\_zsh" \=\~ ^\(\[Yy\]\)</span> ]]; then
  chsh -s /usr/bin/zsh
  echo "ZSH is now your default shell."
else
  echo "Skipping setting ZSH as default shell."
fi

# Verify ZSH is the default shell
current_shell=$(echo $SHELL)
if [[ "<span class="math-inline">current\_shell" \!\= "/usr/bin/zsh" \]\]; then
echo "ZSH is not your default shell\. Please set it manually if desired\."
fi
\# Install Oh My Zsh \(with progress bar\)
echo "Installing Oh My Zsh\.\.\."
sh \-c "</span>(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)" &> /dev/null | pv -l 512

# Set Agnoster theme (user can customize later)
echo "Setting ZSH theme to 'agnoster' (you can change this later)."
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc

# Install Powerlevel10k theme fonts
echo "Installing Powerlevel10k theme fonts..."
sudo apt install fonts-powerline

# Install Powerlevel10k theme
echo "Installing Powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Set Powerlevel10k theme (user can customize later)
echo "Setting ZSH theme to 'powerlevel10k/powerlevel10k' (you can change this later)."
sed -i 's/ZSH_THEME="agnoster"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# Install dconf configuration tool
echo "Installing dconf-cli..."
sudo apt install dconf-cli

# Instructions for manual terminal profile configuration (Dracula theme)
echo "**Manual Setup Required for Dracula Terminal Theme**"
echo "Please follow these steps in your terminal window and press Enter when done:"
echo "1. Right-click in the terminal and choose Preferences."
echo "2. In Preferences, choose 'Add profiles' (the + button on the right)."
echo "3. Fill the new profile name (e.g., dracula)."
echo "4. In the Colors tab, uncheck 'Use colors from system theme' for Text and Background Color."
echo "5. Close the Preferences window."
read -r dracula_config_done

# Install Dracula terminal theme (after user configuration)
if [[ "<span class="math-inline">dracula\_config\_done" \=\~ ^\(\[Yy\]\)</span> ]]; then
  echo "Installing Dracula terminal theme..."
  git clone https://github.com/dracula/gnome-terminal
  cd gnome-terminal
  ./install.sh
  cd ..
  
  # Set Dracula profile as default (after user configuration)
  echo "Setting Dracula as default terminal profile (after user configuration)."
  echo "Please set the Dracula profile as default in your terminal preferences."
  read -r dracula_default_done
fi

# Install ZSH plugins (autosuggestions, syntax highlighting)
echo "Installing ZSH plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# Enable ZSH plugins
echo "Enabling ZSH plugins (autosuggestions, syntax highlighting)..."
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
echo "you are set, happy coding...."
