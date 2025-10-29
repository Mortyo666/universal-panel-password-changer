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
4. The script will automatically detect the control panel
5. The password will be changed automatically

### Typical Output

**Example output (URL found):**
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

**Example output (URL not found):**
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

## Использование (русский)

### Основной способ запуска (рекомендуемый)

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

### Пошаговая инструкция

1. Скопируйте одну из команд выше
2. Вставьте её в терминал вашего сервера
3. Нажмите Enter
4. Скрипт автоматически определит панель управления
5. Пароль будет изменён автоматически

### Типичный вывод

**Пример вывода (URL найден):**
```
╔════════════════════════════════════════╗
║  Control Panel Password Changer v3.0  ║
╚════════════════════════════════════════╝

ℹ Обнаружение панели управления...
✓ Обнаружено: HestiaCP

ℹ Генерация безопасного пароля...
✓ Пароль сгенерирован

ℹ Изменение пароля администратора HestiaCP...
✓ Пароль успешно изменён!

┌────────────────────────────────────────┐
│              УЧЁТНЫЕ ДАННЫЕ            │
├────────────────────────────────────────┤
│ Панель:   HestiaCP
│ URL:      https://192.168.1.100:8083
│ Логин:    admin
│ Пароль:   Xy8#mK2@pL9-vR4
└────────────────────────────────────────┘

✓ Сохраните эти учётные данные в безопасном месте!
```

**Пример вывода (URL не найден):**
```
┌────────────────────────────────────────┐
│              УЧЁТНЫЕ ДАННЫЕ            │
├────────────────────────────────────────┤
│ Панель:   FastPanel
│ Логин:    admin
│ Пароль:   Km9$pL2@vR8-Xy4
└────────────────────────────────────────┘

✓ Сохраните эти учётные данные в безопасном месте!
```

### Важные замечания

- Скрипт автоматически определяет установленную панель управления
- Генерируется безопасный случайный пароль длиной 15 символов
- Используются заглавные и строчные буквы, цифры и специальные символы
- Новые учётные данные отображаются сразу после выполнения
