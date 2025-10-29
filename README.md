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
Основной способ запуска (рекомендуемый):
**С использованием curl:**
```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh)"
```
**С использованием wget:**
```bash
sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh)"
```
### Альтернативные способы (при необходимости)
Если вы уже авторизованы как root на сервере:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh)"
```
```bash
bash -c "$(wget -qO- https://raw.githubusercontent.com/Mortyo666/universal-panel-password-changer/main/change-panel-password.sh)"
```
**Преимущества sudo подхода:**
- Универсальность — работает из любой учетной записи
- Безопасность — явное повышение привилегий
- Удобство — не требует переключения пользователя
- Аудит — четко видно, что команда требует root доступа
## How It Works
1. The script checks if it's running with root privileges
2. Automatically detects which control panel is installed
3. Generates a random 15-character secure password
4. Changes the admin password using the panel's native command
5. Displays the new credentials
## Output Example

**Пример вывода (URL найден):**
```
╔════════════════════════════════════════╗
║  Control Panel Password Changer v3.0  ║
╚════════════════════════════════════════╝

ℹ Detecting control panel...
✓ Detected: HestiaCP

ℹ Generating secure password...
✓ Password generated

ℹ Changing HestiaCP admin password...
✓ Password changed successfully!

┌────────────────────────────────────────┐
│              CREDENTIALS               │
├────────────────────────────────────────┤
│ Panel:    HestiaCP
│ URL:      https://192.168.1.100:8083
│ Username: admin
│ Password: Xy8#mK2@pL9-vR4
└────────────────────────────────────────┘

✓ Save these credentials securely!
```

**Пример вывода (URL не найден):**
```
┌────────────────────────────────────────┐
│              CREDENTIALS               │
├────────────────────────────────────────┤
│ Panel:    FastPanel
│ Username: admin
│ Password: Km9$pL2@vR8-Xy4
└────────────────────────────────────────┘

✓ Save these credentials securely!
```
