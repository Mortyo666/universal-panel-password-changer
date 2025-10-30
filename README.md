# Universal Control Panel Password Changer
A bash script that automatically detects your server control panel and changes the admin password to a randomly generated secure password.

## Supported Control Panels
- **HestiaCP**
- **VestaCP**
- **FastPanel** (version 1)
- **FastPanel2** (version 2)
- **aaPanel**
- **ISPmanager**

> The script correctly detects both FastPanel versions (FastPanel and FastPanel2) and applies the appropriate password change method for each.

### FastPanel2 note
For FastPanel2, the password is changed via the system user using chpasswd. The script determines the username from `fastpanel users list` (preferring `fastuser` or `admin`) and then runs:

```
echo "<username>:<new_password>" | chpasswd
```

This approach is reliable and does not use deprecated FastPanel2 commands.

## Features
- Automatic control panel detection (including FastPanel and FastPanel2)
- Generates secure 15-character random passwords
- Uses uppercase, lowercase, numbers, and special characters
- Simple one-command execution
- Clear success/failure feedback
- Auto-detects custom ports
- Beautiful formatted output

## Requirements
⚠️ **This script MUST be run as root**

## Usage (English)
### Primary Launch Method (Recommended)
**Using curl:**
```
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh)"
```
**Using wget:**
```
sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh)"
```

### Alternative Methods (If Needed)
If you are already logged in as root on the server:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh)"
```
```
bash -c "$(wget -qO- https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh)"
```
