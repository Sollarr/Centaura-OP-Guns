# 🔫 Centaura Gun Settings Modifier

A Lua script for modifying weapon configurations in the Roblox game **[CENTAURA](https://www.roblox.com/games/8735521924/CENTAURA)** by VleisBeun.

## ⚠️ Disclaimer

- **Do NOT use this in public servers** as it may violate Roblox Terms of Service and game rules
- Using exploits/cheats can result in account bans
- This is provided as-is with no warranty
- Use at your own risk

## 📋 Description

This script automatically modifies all weapon settings in Centaura to create overpowered (OP) configurations. It accesses the game's gun settings modules and overwrites their properties with extreme values.

## ✨ Features

The script modifies the following weapon properties:

- **999 Damage** - One-shot kills on all targets
- **999 Ammo** - Near-infinite magazine capacity
- **0.01 Fire Rate** - Extremely fast shooting speed
- **0 Spread & Recoil** - Perfect accuracy with no kickback
- **999 Penetration** - Bullets penetrate through walls and multiple enemies
- **99999 Range** - Unlimited shooting distance
- **0.01 Reload Speed** - Near-instant reloads
- **-999 Weight** - Super speed movement
- **10x Headshot Multiplier** - Devastating headshot damage
- **Friendly Fire Disabled** - Cannot damage teammates

## 🚀 Installation

### For Executor Users

1. Copy the entire script from `gun_modifier.lua`
2. Open your Roblox executor
3. Join a Centaura game (preferably a private server)
4. Paste the script into your executor
5. Execute the script

### Script Execution
```lua
-- Simply execute the script and it will automatically:
-- 1. Find all gun configuration modules
-- 2. Modify their settings
-- 3. Print confirmation messages
```

## 📝 Usage

Once executed, the script will:

1. Locate the `TREKModules.GunSettings` folder in ReplicatedStorage
2. Iterate through all gun ModuleScripts
3. Override each weapon's properties with OP values
4. Print detailed logs showing which guns were modified

## 🎮 Tested On

- **Game:** CENTAURA by VleisBeun
- **Platform:** Roblox
- **Compatibility:** Works with current game version (as of December 2025)

## 🛠️ Technical Details

- **Language:** Lua
- **Game Service:** ReplicatedStorage
- **Module Path:** `TREKModules.GunSettings`
- **Error Handling:** Uses `pcall()` to prevent crashes if modules fail to load

## ⚖️ Legal Notice

This repository is for **educational purposes only**. The creator is not responsible for:
- Account bans or suspensions
- Violations of Roblox Terms of Service
- Negative impact on game experience for other players
- Any misuse of this script

**Please respect game developers and other players. Use responsibly.**

## 📄 License

This project is provided under the GNU License - see LICENSE file for details.

## 🤝 Contributing

Feel free to fork this repository and submit pull requests with improvements or additional features.

## 📧 Contact

For questions or issues, please open an issue on this repository.

---

**Remember:** The best way to enjoy Centaura is to play fairly and support the developers! 🎖️
