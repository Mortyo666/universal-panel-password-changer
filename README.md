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
```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh)"
```

**Using wget:**
```bash
sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh)"
```

### Alternative Methods (If Needed)

If you are already logged in as root on the server:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh)"
```

```bash
bash -c "$(wget -qO- https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh)"
```

### Step-by-Step Instructions

1. Copy one of the commands above
2. Paste it into your server's terminal
3. Press Enter
4. The script will automatically detect the control panel (including FastPanel versions)
5. The password will be changed automatically

### Typical Output

**Example output (URL found):**

```
╔════════════════════════════════════════╗
║  Control Panel Password Changer v3.1  ║
╚════════════════════════════════════════╝

ℹ Detecting control panel...
✓ Detected: FastPanel2

ℹ Generating secure password...
✓ Password generated

ℹ Changing FastPanel2 password...
✓ Password changed successfully!

┌────────────────────────────────────────┐
│              CREDENTIALS               │
├────────────────────────────────────────┤
│ Panel:    FastPanel2
│ URL:      https://192.168.1.100:8888
│ Username: admin
│ Password: aB3#xY9$mN2!qR7
└────────────────────────────────────────┘

✓ Save these credentials securely!
```

## Version History

- **v3.1** - Added FastPanel2 support with proper version detection
- **v3.0** - Added auto port detection and improved output
- **v2.0** - Added multiple panel support
- **v1.0** - Initial release

## License

MIT License

## Author

GitHub: @Mortyo666
