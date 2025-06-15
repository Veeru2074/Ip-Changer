#!/data/data/com.termux/files/usr/bin/bash

# Define ANSI color codes
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

# Define the installation directory
IPCHANGER="$PREFIX/share/ip-changer"

# Function to check and install packages
install_packages() {
    packages=("git" "curl" "tor" "privoxy" "netcat-openbsd")
    for pkg in "${packages[@]}"; do
        if ! dpkg -s $pkg &> /dev/null; then
            echo -e "${YELLOW}🚀 Installing $pkg...${NC}"
            pkg install $pkg -y
        else
            echo -e "${GREEN}✅ $pkg is already installed.${NC}"
        fi
    done
}

# Install required packages
echo -e "${CYAN}🛠️ Checking and installing required packages...${NC}"
install_packages

# Clone the repository
echo -e "${CYAN}📦 Cloning Ip-Changer repository...${NC}"
if [ -d "$IPCHANGER" ]; then
    echo -e "${YELLOW}📂 Directory $IPCHANGER already exists. Updating repository...${NC}"
    cd "$IPCHANGER"
    git pull origin master
else
    git clone https://github.com/Veeru2074/Ip-Changer.git "$IPCHANGER"
    echo -e "${GREEN}✅ Repository cloned successfully!${NC}"
fi

# Create the launcher script
LAUNCHER_SCRIPT="$PREFIX/bin/ip-changer"
echo -e "${CYAN}📝 Creating launcher script at $LAUNCHER_SCRIPT...${NC}"
cat << EOF > "$LAUNCHER_SCRIPT"
#!/data/data/com.termux/files/usr/bin/bash
cd "$IPCHANGER"
bash ip-changer.sh "\$@"
EOF

# Make the launcher script executable
chmod +x "$LAUNCHER_SCRIPT"
echo -e "${GREEN}✅ Launcher script created and made executable!${NC}"

# Final message
echo -e "${BLUE}🎉 Installation complete! You can now run 'ip-changer' from anywhere in Termux.${NC}"
echo -e "${CYAN}🚀 Just type ${GREEN}ip-changer${CYAN} to start using the tool.${NC}"
