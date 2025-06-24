# 🌈 JVL Progressbar v2.1.0

![FiveM](https://img.shields.io/badge/FiveM-Compatible-blue.svg)
![Lua](https://img.shields.io/badge/Lua-5.4-brightgreen.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)
![Version](https://img.shields.io/badge/Version-2.1.0-red.svg)

A **modern, clean, and fully configurable progress bar** for FiveM servers. Designed to be easy to use and integrate with any script based on **ESX**, **QBCore**, or other custom frameworks.

## ✨ Features

- ✅ Modern and clean design with smooth animations
- 🎨 Fully configurable colors and styling
- 🔄 **3 positions** available (center, top, bottom)
- 🧱 Optimized and exportable code
- 📱 **Responsive** to any screen resolution
- 📦 Lightweight and optimized
- ⚡ Compatible with **ESX**, **QBCore** and custom frameworks
- 🎮 Support for **character animations**
- ⌨️ **Cancellation** with ESC key
- 💾 **Callbacks** for completion and cancellation

## 🚀 Installation

1. Download or clone this repository
2. Place the `jvl_progressbar` folder in your `resources` directory
3. Add to your `server.cfg`:

```
ensure jvl_progressbar
```

4. Restart your server

## ⚙️ Configuration

Customize your progress bar by editing `config.lua`:

```lua
Config.Style = {
    -- Colors
    barColor = '#697FB3',          -- Bar color (grayish blue)
    bgColor = '#19212D',           -- Background color (dark gray)
    textColor = '#FFFFFF',         -- Text color (white)
    
    -- Dimensions
    width = '300px',               -- Bar width
    height = '40px',               -- Bar height
    position = 'center',           -- Position: 'center', 'top', 'bottom'
    
    -- Visual style
    borderRadius = '12px',         -- Rounded corners
    shadow = '0px 4px 15px rgba(0, 0, 0, 0.4)', -- Shadow
    
    -- Typography
    fontFamily = 'Poppins, sans-serif',
    fontSize = '14px',
    fontWeight = '600',
    
    -- Animation
    animationSpeed = 100           -- Update speed (ms)
}
```

### 🎨 Available positions

| Position | Description |
|----------|-------------|
| `center` | Center of screen |
| `top`    | Top (15% from top) |
| `bottom` | Bottom (15% from bottom)  |

## 🧩 Basic usage

### Simple export

```lua
exports['jvl_progressbar']:startProgressbar(5000, 'Processing...')
```

### With event

```lua
TriggerEvent('jvl_progressbar:start', 'Loading data...', 3000)
```

### Test command

```
/testprogress 5000 Testing the progress bar
```

## 🧩 Advanced usage

### With character animation and callbacks

```lua
exports['jvl_progressbar']:startProgressbar(
    5000,                          -- Duration in ms
    'Repairing vehicle...',        -- Text to display
    'mini@repair',                 -- Animation dictionary 
    'fixing_a_ped',                -- Animation name
    function()                     -- Callback on completion
        print('Repair completed!')
        -- Your code here
    end,
    function()                     -- Callback on cancellation
        print('Repair cancelled!')
        -- Your code here
    end
)
```

### Function parameters

| Parameter | Type | Description | Required |
|-----------|------|-------------|----------|
| `duration` | number | Duration in milliseconds | ✅ |
| `text`     | string | Text to display          | ✅ |
| `animDict` | string | Animation dictionary     | ❌ |
| `animName` | string | Animation name           | ❌ |
| `onFinish` | function | Callback on completion | ❌ |
| `onCancel` | function | Callback on cancellation | ❌ |

## 🎮 Integration examples

### With ESX

```lua
exports['jvl_progressbar']:startProgressbar(
    4000, 
    'Checking inventory...', 
    nil, 
    nil, 
    function()
        ESX.ShowNotification('Inventory checked successfully', 'success')
    end, 
    function()
        ESX.ShowNotification('Check cancelled', 'error')
    end
)
```

### With QBCore

```lua
exports['jvl_progressbar']:startProgressbar(
    3000, 
    'Counting money...', 
    'mp_common', 
    'givetake1_a',
    function()
        QBCore.Functions.Notify('Money counted successfully', 'success')
    end, 
    function()
        QBCore.Functions.Notify('Count cancelled', 'error')
    end
)
```

### With ox_lib

```lua
exports['jvl_progressbar']:startProgressbar(
    6000, 
    'Crafting item...', 
    'amb@prop_human_parking_meter@female@idle_a', 
    'idle_a',
    function()
        lib.notify({
            title = 'Success',
            description = 'Item crafted successfully',
            type = 'success'
        })
    end,
    function()
        lib.notify({
            title = 'Cancelled',
            description = 'Crafting interrupted',
            type = 'error'
        })
    end
)
```

## ⌨️ Controls

- **ESC** - Cancel the progress bar

## 🔧 Technical features

- **FiveM** updated required
- **Lua 5.4** compatible
- Uses FiveM's native **jQuery**
- Optimized **NUI**
- **Modular** and **clean** code

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| Bar doesn't appear | Verify the resource is started in `server.cfg` |
| Animation doesn't work | Check that dictionary and animation name are correct |
| Incorrect colors | Use valid HEX (#RRGGBB) or RGBA format in config.lua |
| Script not responding | Check F8 console for errors |

## 📝 Changelog

### v2.1.0 (Current)
- ✅ Completely rewritten and optimized code
- ✅ Simplified and improved NUI interface
- ✅ More intuitive configuration
- ✅ Better framework compatibility
- ✅ Fixed display bugs
- ✅ Complete documentation

### v2.0.0
- ✅ First stable version
- ✅ Configuration system implemented
- ✅ Support for animations and callbacks

## 🧑‍💻 Credits

Developed by **JVL Customs**  
With ❤️ for the FiveM community

## 🤝 Contributions

Contributions are welcome! If you find a bug or have a suggestion:

1. Fork the project
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📜 License

This project is under the MIT License. See `LICENSE` for more details.

## 💖 Like this script?

- ⭐ Give it a star on GitHub
- 🐞 Report bugs in Issues
- 🔄 Share with the community
- 💬 Leave us your feedback

---

### 📞 Support

If you need help or have questions:
- 📧 Open an Issue on GitHub
- 💬 Contact us on Discord: '[Join Server](https://discord.gg/9vg3bSWqM7)'
- 🌐 Visit our development server

**Thank you for using JVL Progressbar!** 🚀

