#!/bin/bash
# ============================================
# Universal Control Panel Password Changer
# Version: 3.1
# Author: GitHub @YOUR_USERNAME
# ============================================
# Features:
# - Auto-detects control panels
# - Finds custom ports automatically
# - Generates secure 15-char passwords
# - Supports: HestiaCP, VestaCP, FastPanel, FastPanel2, aaPanel, ISPmanager
# ============================================
set -e
# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
# Function to print colored output
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }
print_info() { echo -e "${YELLOW}ℹ${NC} $1"; }
# Generate secure random password
generate_password() {
    tr -dc 'A-Za-z0-9!@#$%^&*()-_=+' < /dev/urandom | head -c 15
}
# Get server public IP
get_server_ip() {
    local ip
    ip=$(curl -s --max-time 3 ifconfig.me 2>/dev/null || \
         curl -s --max-time 3 icanhazip.com 2>/dev/null || \
         curl -s --max-time 3 ipinfo.io/ip 2>/dev/null || \
         hostname -I | awk '{print $1}')
    echo "$ip"
}
# Detect installed control panel
detect_panel() {
    if [ -d "/usr/local/hestia" ]; then
        echo "hestia"
    elif [ -d "/usr/local/vesta" ]; then
        echo "vesta"
    elif [ -d "/usr/local/fastpanel2" ] || [ -f "/usr/local/fastpanel2/fastpanel" ] || [ -f "/usr/local/fastpanel2-nginx/settings/fastpanel.conf" ]; then
        echo "fastpanel2"
    elif [ -d "/usr/local/fastpanel" ] || [ -f "/usr/local/fastpanel/fastpanel" ]; then
        echo "fastpanel"
    elif [ -d "/www/server/panel" ]; then
        echo "aapanel"
    elif [ -f "/usr/local/mgr5/sbin/mgrctl" ] || [ -d "/usr/local/mgr5" ]; then
        echo "ispmanager"
    else
        echo "unknown"
    fi
}
# Find actual listening port for service
find_listening_port() {
    local service_name=$1
    local default_port=$2
    
    # Try multiple methods to find port
    local port
    
    # Method 1: netstat
    port=$(netstat -tlnp 2>/dev/null | grep "$service_name" | grep -oP ':\K[0-9]+' | head -1)
    
    # Method 2: ss command
    if [ -z "$port" ]; then
        port=$(ss -tlnp 2>/dev/null | grep "$service_name" | grep -oP ':\K[0-9]+' | head -1)
    fi
    
    # Method 3: lsof
    if [ -z "$port" ]; then
        port=$(lsof -i -P -n 2>/dev/null | grep "$service_name" | grep LISTEN | grep -oP ':\K[0-9]+' | head -1)
    fi
    
    # Fallback to default
    if [ -z "$port" ]; then
        port=$default_port
    fi
    
    echo "$port"
}
# Get panel URL with auto port detection
get_panel_url() {
    local panel=$1
    local ip=$2
    local port
    local url
    
    case $panel in
        hestia)
            if [ -f "/usr/local/hestia/nginx/conf/nginx.conf" ]; then
                port=$(grep -oP 'listen\s+\K[0-9]+' /usr/local/hestia/nginx/conf/nginx.conf | head -1)
            fi
            if [ -z "$port" ]; then
                port=$(find_listening_port "hestia" "8083")
            fi
            url="https://${ip}:${port}"
            ;;
        vesta)
            if [ -f "/usr/local/vesta/nginx/conf/nginx.conf" ]; then
                port=$(grep -oP 'listen\s+\K[0-9]+' /usr/local/vesta/nginx/conf/nginx.conf | head -1)
            fi
            if [ -z "$port" ]; then
                port=$(find_listening_port "vesta" "8083")
            fi
            url="https://${ip}:${port}"
            ;;
        fastpanel2)
            port=$(find_listening_port "fastpanel" "8888")
            url="https://${ip}:${port}"
            ;;
        fastpanel)
            port=$(find_listening_port "fastpanel" "8888")
            url="https://${ip}:${port}"
            ;;
        aapanel)
            if [ -f "/www/server/panel/data/port.pl" ]; then
                port=$(cat /www/server/panel/data/port.pl)
            else
                port=$(find_listening_port "BT-Panel" "7800")
            fi
            local security_path=""
            if [ -f "/www/server/panel/data/admin_path.pl" ]; then
                security_path=$(cat /www/server/panel/data/admin_path.pl)
            fi
            if [ -n "$security_path" ]; then
                url="http://${ip}:${port}${security_path}"
            else
                url="http://${ip}:${port}"
            fi
            ;;
        ispmanager)
            port=$(find_listening_port "ispmgr" "1500")
            url="https://${ip}:${port}"
            ;;
        *)
            url=""
            ;;
    esac
    echo "$url"
}
# Change password for detected panel
change_password() {
    local panel=$1
    local password=$2
    case $panel in
        hestia)
            print_info "Changing HestiaCP admin password..."
            if /usr/local/hestia/bin/v-change-user-password admin "$password" >/dev/null 2>&1; then
                return 0
            else
                return 1
            fi
            ;;
        vesta)
            print_info "Changing VestaCP admin password..."
            if /usr/local/vesta/bin/v-change-user-password admin "$password" >/dev/null 2>&1; then
                return 0
            else
                return 1
            fi
            ;;
        fastpanel2)
            print_info "Changing FastPanel2 password..."
            # Determine FastPanel2 username via users list, fallback to fastuser
            local fp2_user
            if command -v /usr/local/fastpanel2/fastpanel >/dev/null 2>&1; then
                fp2_user=$(/usr/local/fastpanel2/fastpanel users list 2>/dev/null | grep -Eo '^(fastuser|admin)$' | head -1)
            fi
            if [ -z "$fp2_user" ]; then
                fp2_user="fastuser"
            fi
            if echo "$fp2_user:$password" | chpasswd >/dev/null 2>&1; then
                return 0
            fi
            return 1
            ;;
        fastpanel)
            print_info "Changing FastPanel password..."
            if [ -f "/usr/local/fastpanel/fastpanel" ]; then
                if /usr/local/fastpanel/fastpanel set --password="$password" >/dev/null 2>&1; then
                    return 0
                fi
            fi
            if echo "$password" | /usr/local/fastpanel/admin.sh password >/dev/null 2>&1; then
                return 0
            fi
            return 1
            ;;
        aapanel)
            print_info "Changing aaPanel password..."
            cd /www/server/panel || return 1
            if echo "$password" | python tools.py panel "$password" >/dev/null 2>&1; then
                return 0
            else
                return 1
            fi
            ;;
        ispmanager)
            print_info "Changing ISPmanager password..."
            local username=""
            if /usr/local/mgr5/sbin/mgrctl -m ispmgr user.edit name=admin passwd="$password" confirm="$password" >/dev/null 2>&1; then
                username="admin"
                return 0
            fi
            if /usr/local/mgr5/sbin/mgrctl -m ispmgr user.edit name=root passwd="$password" confirm="$password" >/dev/null 2>&1; then
                username="root"
                return 0
            fi
            return 1
            ;;
        *)
            return 1
            ;;
    esac
}
# Get username for panel
get_panel_username() {
    local panel=$1
    case $panel in
        hestia|vesta)
            echo "admin"
            ;;
        fastpanel2)
            echo "fastuser"
            ;;
        fastpanel)
            echo "admin"
            ;;
        aapanel)
            echo "admin"
            ;;
        ispmanager)
            if /usr/local/mgr5/sbin/mgrctl -m ispmgr user 2>/dev/null | grep -q "admin"; then
                echo "admin"
            else
                echo "root"
            fi
            ;;
        *)
            echo "admin"
            ;;
    esac
}
# Get panel name for display
get_panel_name() {
    local panel=$1
    case $panel in
        hestia) echo "HestiaCP" ;;
        vesta) echo "VestaCP" ;;
        fastpanel2) echo "FastPanel2" ;;
        fastpanel) echo "FastPanel" ;;
        aapanel) echo "aaPanel" ;;
        ispmanager) echo "ISPmanager" ;;
        *) echo "Unknown" ;;
    esac
}
# Main execution
main() {
    echo "╔════════════════════════════════════════╗"
    echo "║  Control Panel Password Changer v3.1  ║"
    echo "╚════════════════════════════════════════╝"
    echo ""
    if [ "$EUID" -ne 0 ]; then
        print_error "This script must be run as root (use sudo)"
        exit 1
    fi
    print_info "Detecting control panel..."
    PANEL=$(detect_panel)
    if [ "$PANEL" = "unknown" ]; then
        print_error "No supported control panel detected"
        echo ""
        echo "Supported: HestiaCP, VestaCP, FastPanel, FastPanel2, aaPanel, ISPmanager"
        exit 1
    fi
    PANEL_NAME=$(get_panel_name "$PANEL")
    print_success "Detected: $PANEL_NAME"
    echo ""
    print_info "Generating secure password..."
    PASSWORD=$(generate_password)
    print_success "Password generated"
    echo ""
    if change_password "$PANEL" "$PASSWORD"; then
        print_success "Password changed successfully!"
        echo ""
        SERVER_IP=$(get_server_ip)
        PANEL_URL=$(get_panel_url "$PANEL" "$SERVER_IP")
        USERNAME=$(get_panel_username "$PANEL")
        echo "┌────────────────────────────────────────┐"
        echo "│              CREDENTIALS               │"
        echo "├────────────────────────────────────────┤"
        echo "│ Panel:    $PANEL_NAME"
        if [ -n "$PANEL_URL" ] && [ -n "$SERVER_IP" ]; then
            echo "│ URL:      $PANEL_URL"
        fi
        echo "│ Username: $USERNAME"
        echo "│ Password: $PASSWORD"
        echo "└────────────────────────────────────────┘"
        echo ""
        print_success "Save these credentials securely!"
    else
        echo ""
        print_error "Failed to change password"
        print_info "Please check if the panel is properly installed"
        exit 1
    fi
}
# Run main function
main
