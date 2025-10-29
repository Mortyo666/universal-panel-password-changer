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

1. Download the script:
```bash
wget https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh
```

2. Make it executable:
```bash
chmod +x change-panel-password.sh
```

3. Run as root:
```bash
sudo ./change-panel-password.sh
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
```

## Security Notes

- Always run this script in a secure environment
- Save the generated password immediately
- The password is displayed only once
- Generated passwords include special characters for enhanced security

## Default Usernames by Panel

- **HestiaCP**: admin
- **VestaCP**: admin
- **FastPanel**: fastuser
- **aaPanel**: (current username)
- **ISPmanager**: root

## Troubleshooting

If the script doesn't detect your panel:
- Ensure the panel is properly installed
- Verify you're running the script as root
- Check that the panel's installation directory exists

## License

MIT License - Feel free to use and modify
