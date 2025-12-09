#!/usr/bin/env bash

# ==========================================
# CONFIGURATION // SIGNALIS THEME
# ==========================================
set -e # Exit immediately if a command exits with a non-zero status

# Colors
RED='\033[0;31m'
B_RED='\033[1;31m'
WHITE='\033[1;37m'
GREY='\033[0;90m'
NC='\033[0m' # No Color

# Speed of the typewriter effect (seconds)
TYPE_SPEED=0.01

# ==========================================
# UTILITIES
# ==========================================

# Function for slow, typewriter-style printing
print_slow() {
    text="$1"
    color="${2:-$NC}"
    printf "${color}"
    for ((i=0; i<${#text}; i++)); do
        printf "${text:$i:1}"
        sleep $TYPE_SPEED
    done
    printf "${NC}\n"
}

# Function for immediate warnings
print_warn() {
    printf "${B_RED}>> WARNING: $1${NC}\n"
}

divider() {
    printf "${RED}------------------------------------------------------------${NC}\n"
}

clear
# ==========================================
# PHASE 1: INITIALIZATION
# ==========================================

echo -e "${RED}"
cat << "EOF"
 ▄████▄   ██▀███ ▓██   ██▓ ▒█████  ▒███████▒▓█████  ███▄    █  ██▓▒██   ██▒
▒██▀ ▀█  ▓██ ▒ ██▒▒██  ██▒▒██▒  ██▒▒ ▒ ▒ ▄▀░▓█   ▀  ██ ▀█   █ ▓██▒▒▒ █ █ ▒░
▒▓█    ▄ ▓██ ░▄█ ▒ ▒██ ██░▒██░  ██▒░ ▒ ▄▀▒░ ▒███   ▓██  ▀█ ██▒▒██▒░░  █   ░
▒▓▓▄ ▄██▒▒██▀▀█▄   ░ ▐██▓░▒██   ██░  ▄▀▒   ░▒▓█  ▄ ▓██▒  ▐▌██▒░██░ ░ █ █ ▒ 
▒ ▓███▀ ░░██▓ ▒██▒ ░ ██▒▓░░ ████▓▒░▒███████▒░▒████▒▒██░   ▓██░░██░▒██▒ ▒██▒
░ ░▒ ▒  ░░ ▒▓ ░▒▓░  ██▒▒▒ ░ ▒░▒░▒░ ░▒▒ ▓░▒░▒░░ ▒░ ░░ ▒░   ▒ ▒ ░▓  ▒▒ ░ ░▓ ░
  ░  ▒     ░▒ ░ ▒░▓██ ░▒░   ░ ▒ ▒░ ░░▒ ▒ ░ ▒ ░ ░  ░░ ░░   ░ ▒░ ▒ ░░░   ░▒ ░
░          ░░   ░ ▒ ▒ ░░  ░ ░ ░ ▒  ░ ░ ░ ░ ░   ░      ░   ░ ░  ▒ ░ ░    ░  
░ ░         ░     ░ ░         ░ ░    ░ ░       ░  ░         ░  ░   ░    ░  
░                 ░ ░              ░                                       
EOF
echo -e "${NC}"

print_slow "INITIATING REPLIKA INSTALLATION SEQUENCE..." "$WHITE"
print_slow "THE SHORES OF OBLIVION AWAIT." "$GREY"
sleep 1

divider

# ==========================================
# PHASE 2: GESTALT SELECTION (Host)
# ==========================================

print_slow "IDENTIFY CONFIGURATION :" "$RED"
ls -1 ./heimat/ | grep ".nix" | sed 's/^/  > /'
echo ""

while true; do
    read -r -p "$(echo -e ${RED}"INPUT DESIGNATION: "${NC})" FLAKE_HOST
    if [[ -d "./hosts/$FLAKE_HOST" ]]; then
        print_slow "TARGET ACQUIRED: $FLAKE_HOST" "$WHITE"
        break
    else
        print_warn "GESTALT NOT FOUND. RETRY."
    fi
done

divider

# ==========================================
# PHASE 3: SUBSTRATE SELECTION (Disk)
# ==========================================

print_slow "SCANNING PHYSICAL MEMORY ..." "$RED"
sleep 1

# List disks with sizes and models
lsblk -d -n -o NAME,SIZE,MODEL,TYPE | grep "disk" | awk '{print "  > /dev/" $1 " [" $2 "] " $3}'

echo ""
print_slow "SELECT TARGET SUBSTRATE (e.g., nvme0n1 or sda):" "$RED"
print_warn "THIS ACTION WILL ERASE ALL MEMORY. COMMIT TO THE VOID."

while true; do
    read -r -p "$(echo -e ${RED}"INPUT DEVICE NAME (without /dev/): "${NC})" DISK_NAME
    TARGET_DISK="/dev/$DISK_NAME"
    
    if lsblk | grep -q "$DISK_NAME"; then
        print_slow "SUBSTRATE CONFIRMED: $TARGET_DISK" "$WHITE"
        break
    else
        print_warn "SUBSTRATE UNREACHABLE. RETRY."
    fi
done

divider

# ==========================================
# PHASE 4: RECONFIGURATION (Modify Disko)
# ==========================================

DISKO_CONFIG="./hosts/$FLAKE_HOST/disko-config.nix"

if [[ ! -f "$DISKO_CONFIG" ]]; then
    print_warn "DISKO CONFIGURATION MISSING AT $DISKO_CONFIG"
    print_slow "INITIATING EMERGENCY EXIT..." "$GREY"
    exit 1
fi

print_slow "INJECTING PARAMETERS INTO REALITY..." "$GREY"

# Uses sed to look for 'device = "..."' and replace it with the selected disk
# NOTE: This assumes the standard disko format where device is defined explicitly.
sed -i "s|device = \".*\";|device = \"$TARGET_DISK\";|g" "$DISKO_CONFIG"

sleep 0.5
print_slow "CONFIGURATION ALTERED. DISK TARGET SET TO: $TARGET_DISK" "$WHITE"

divider

# ==========================================
# PHASE 5: THE FINAL RITUAL (Install)
# ==========================================

print_slow "PREPARING FOR SYSTEM GENERATION..." "$RED"
print_slow "LAST CHANCE TO ABORT CYCLE." "$GREY"
print_slow "HOST: $FLAKE_HOST" "$WHITE"
read -r -p "$(echo -e ${WHITE}"PRESS [ENTER] TO DESCEND..."${NC})" key

# 1. Generate Hardware Config
print_slow "EXTRACTING HARDWARE SIGNATURES..." "$GREY"
sudo nixos-generate-config --no-filesystems --show-hardware-config > "./hosts/$FLAKE_HOST/hardware-configuration.nix"
read -r -p "$(echo -e ${WHITE}"[ENTER] THE HOLE?"${NC})" key
# 2. Run Disko (Destroy/Format)
print_slow "OBLITERATING OLD DATA STRUCTURES..." "$RED"
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount "$DISKO_CONFIG" --yes-wipe-all-disks

# 3. Install NixOS
print_slow "INSTALLING GESTALT IMAGE..." "$WHITE"
sudo nixos-install --flake ".#$FLAKE_HOST"

divider

# ==========================================
# PHASE 6: SYNCHRONIZATION (Git Push)
# ==========================================

print_slow "SYSTEM INSTALLED." "$WHITE"

echo -e "${RED}"
cat << "EOF"
 ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ _________ ____ ____ ____ _________ ____ ____ ____ ____ ____ ____ ____ ____ ____ 
||T |||h |||e |||       |||S |||y |||s |||t |||e |||m |||       |||w |||a |||s |||       |||i |||n |||s |||t |||a |||l |||l |||e |||d ||
||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||_______|||__|||__|||__|||_______|||__|||__|||__|||__|||__|||__|||__|||__|||__||
|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/_______\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|/__\|
EOF
echo -e "${NC}"
echo ""
print_slow "DO YOU WISH TO SYNCHRONIZE CHANGES TO THE REMOTE REPOSITORY?" "$RED"
print_slow "This ensures the disk ID injection is preserved." "$GREY"

read -r -p "$(echo -e ${RED}"SYNCHRONIZE? [y/N]: "${NC})" GIT_CONFIRM

if [[ "$GIT_CONFIRM" =~ ^[Yy]$ ]]; then
    print_slow "COMMITTING TO THE FLESH..." "$WHITE"
    
    # Check if inside git repo
    if git rev-parse --git-dir > /dev/null 2>&1; then
        git add .
        git commit -m "feat($FLAKE_HOST): re-image on $TARGET_DISK | signalis-install"
        
        print_slow "PUSHING TO REMOTE..." "$GREY"
        if git push; then
            print_slow "SYNCHRONIZATION SUCCESSFUL." "$WHITE"
        else
            print_warn "REMOTE REJECTED CONNECTION. CHANGES SAVED LOCALLY."
        fi
    else
        print_warn "NOT A GIT REPOSITORY. SKIPPING."
    fi
else
    print_slow "LOCAL STATE PRESERVED. NO TRANSMISSION." "$GREY"
fi

echo ""
echo -e "${RED}WAKE UP.${NC}"
