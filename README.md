# Universal Control Panel Password Changer

A bash script that automatically detects your server control panel and changes the admin password to a randomly generated secure password.

## Supported Control Panels

- **HestiaCP**
- **VestaCP**
- **FastPanel**
- **aaPanel**
- **ISPmanager**

## Features

- Automatic control panel detection
- Generates secure 15-character random passwords
- Uses uppercase, lowercase, numbers, and special characters
- Simple one-command execution
- Clear success/failure feedback

## Requirements

⚠️ **This script MUST be run as root**

## Usage

Run this single command:

```bash
curl -sSL https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh | sudo bash
```

Alternatively, using wget:

```bash
wget -qO- https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh | sudo bash
```

## How It Works

1. The script checks if it's running with root privileges
2. Automatically detects which control panel is installed
3. Generates a random 15-character secure password
4. Changes the admin password using the panel's native command
5. Displays the new credentials

## Output Example

```
==========================================
Universal Control Panel Password Changer
==========================================

Detected: HestiaCP

✓ Password changed successfully!

Panel: HestiaCP
Username: admin
New Password: Ab3$xY9@mK2!pL5
==========================================
