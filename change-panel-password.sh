#!/bin/bash

# Universal Control Panel Password Changer
# Generates random 15-character password and changes admin password
# Supports: HestiaCP, VestaCP, FastPanel, aaPanel, ISPmanager

# Function to generate random 15-character password
generate_password() {
    # Generate password with uppercase, lowercase, numbers and special characters
    NEW_PASSWORD=$(tr -dc 'A-Za-z0-9!@#$%^&*()_+=' < /dev/urandom | head -c 15)
    echo "$NEW_PASSWORD"
}

# Function to detect control panel
detect_panel() {
    if [ -d "/usr/local/hestia" ]; then
        echo "hestia"
    elif [ -d "/usr/local/vesta" ]; then
        echo "vesta"
    elif [ -d "/usr/local/fastpanel" ]; then
        echo "fastpanel"
    elif [ -d "/www/server/panel" ]; then
        echo "aapanel"
    elif [ -f "/usr/local/mgr5/sbin/mgrctl" ] || [ -d "/usr/local/mgr5" ]; then
        echo "ispmanager"
    else
        echo "unknown"
    fi
}

# Function to change password based on panel type
change_password() {
    local panel=$1
    local password=$2
    
    case $panel in
        hestia)
            echo "Detected: HestiaCP"
            /usr/local/hestia/bin/v-change-user-password admin "$password"
            if [ $? -eq 0 ]; then
                echo "✓ Password changed successfully!"
                echo "Panel: HestiaCP"
                echo "Username: admin"
                echo "New Password: $password"
                return 0
            else
                echo "✗ Failed to change password for HestiaCP"
                return 1
            fi
            ;;
            
        vesta)
            echo "Detected: VestaCP"
            /usr/local/vesta/bin/v-change-user-password admin "$password"
            if [ $? -eq 0 ]; then
                echo "✓ Password changed successfully!"
                echo "Panel: VestaCP"
                echo "Username: admin"
                echo "New Password: $password"
                return 0
            else
                echo "✗ Failed to change password for VestaCP"
                return 1
            fi
            ;;
            
        fastpanel)
            echo "Detected: FastPanel"
            echo -e "$password\n$password" | passwd fastuser
            if [ $? -eq 0 ]; then
                echo "✓ Password changed successfully!"
                echo "Panel: FastPanel"
                echo "Username: fastuser"
                echo "New Password: $password"
                return 0
            else
                echo "✗ Failed to change password for FastPanel"
                return 1
            fi
            ;;
            
        aapanel)
            echo "Detected: aaPanel"
            cd /www/server/panel
            echo "$password" | python tools.py panel "$password"
            if [ $? -eq 0 ]; then
                echo "✓ Password changed successfully!"
                echo "Panel: aaPanel"
                echo "Username: (current username)"
                echo "New Password: $password"
                return 0
            else
                echo "✗ Failed to change password for aaPanel"
                return 1
            fi
            ;;
            
        ispmanager)
            echo "Detected: ISPmanager"
            echo -e "$password\n$password" | passwd root
            if [ $? -eq 0 ]; then
                echo "✓ Password changed successfully!"
                echo "Panel: ISPmanager"
                echo "Username: root"
                echo "New Password: $password"
                return 0
            else
                echo "✗ Failed to change password for ISPmanager"
                return 1
            fi
            ;;
            
        unknown)
            echo "✗ No supported control panel detected"
            echo "Supported panels: HestiaCP, VestaCP, FastPanel, aaPanel, ISPmanager"
            return 1
            ;;
    esac
}

# Main execution
main() {
    echo "=========================================="
    echo "Universal Control Panel Password Changer"
    echo "=========================================="
    echo ""
    
    # Check if running as root
    if [ "$EUID" -ne 0 ]; then
        echo "✗ This script must be run as root"
        exit 1
    fi
    
    # Detect panel
    PANEL=$(detect_panel)
    
    if [ "$PANEL" = "unknown" ]; then
        echo "✗ No supported control panel found"
        exit 1
    fi
    
    # Generate password
    PASSWORD=$(generate_password)
    
    # Change password
    change_password "$PANEL" "$PASSWORD"
    
    echo ""
    echo "=========================================="
}

# Run main function
main
