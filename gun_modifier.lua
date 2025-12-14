local gunSettingsFolder = game:GetService("ReplicatedStorage").TREKModules.GunSettings

local newSettings = {
    MaxDamage = 999,             -- Massive damage
    MinDamage = 999,             -- Consistent one-shot kills
    AmmoCount = 999,             -- Nearly infinite magazine
    HeadshotMultiplier = 10,     -- 10x headshot damage

    ReloadSpeed = 0.01,          -- Instant reload
    firerate = 0.01,             -- Extremely fast fire rate (lower = faster)
    spread = 0,                  -- Perfect accuracy
    crouchSpread = 0,            -- Perfect accuracy when crouching
    Recoil = 0,                  -- No recoil

    -- Bullet properties
    Penetration = 999,           -- Penetrates through everything
    Range = 99999,               -- Unlimited range
    ShellsPerShot = 1,           -- Single bullet per shot (changed from 50)

    teamkill = false,            -- Disable friendly fire (protect teammates)

    Weight = -999,               -- Negative weight = super speed
    Suppression = 0              -- No suppression penalty
}

for _, gunModule in ipairs(gunSettingsFolder:GetChildren()) do
    if gunModule:IsA("ModuleScript") then
        pcall(function()
            local settings = require(gunModule)

            print("⚡ MAKING OP: " .. gunModule.Name)

            settings.MaxDamage = newSettings.MaxDamage
            settings.MinDamage = newSettings.MinDamage
            settings.AmmoCount = newSettings.AmmoCount
            settings.HeadshotMultiplier = newSettings.HeadshotMultiplier
            settings.ReloadSpeed = newSettings.ReloadSpeed
            settings.firerate = newSettings.firerate
            settings.spread = newSettings.spread
            settings.crouchSpread = newSettings.crouchSpread
            settings.Recoil = newSettings.Recoil
            settings.Penetration = newSettings.Penetration
            settings.Range = newSettings.Range
            settings.ShellsPerShot = newSettings.ShellsPerShot
            settings.teamkill = newSettings.teamkill
            settings.Weight = newSettings.Weight
            settings.Suppression = newSettings.Suppression

            print(string.format(" ✓ Damage: %d-%d | Ammo: %d | Fire Rate: %.2f | Penetration: %d | Shells/Shot: %d",
                settings.MinDamage, settings.MaxDamage, settings.AmmoCount, settings.firerate, settings.Penetration, settings.ShellsPerShot))
            print("------------------------------------------------------")
        end)
    end
end

print("🔥 ALL WEAPONS ARE NOW OVERPOWERED! 🔥")
