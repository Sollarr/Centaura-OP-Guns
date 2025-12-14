-- Genocide Hub for Centaura
-- By VleisBeun
-- This is a Roblox script that creates a GUI hub with toggles for various features including the Gun Mod, Fly Mode, Godmode, Speed Hack, Aimbot, and ESP.
-- Paste this into a Roblox exploit executor like Synapse X or Krnl to run it in the game Centaura.
-- Note: This is for educational purposes only. Using exploits can result in bans from Roblox. Use at your own risk.

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- GUI Setup using Roblox's BillboardGui or ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GenocideHub"
ScreenGui.Parent = game.CoreGui  -- Use CoreGui to make it visible in exploits

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "Genocide Hub - Centaura"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 24
Title.Font = Enum.Font.SourceSansBold
Title.Parent = Frame

local Credits = Instance.new("TextLabel")
Credits.Size = UDim2.new(1, 0, 0, 30)
Credits.Position = UDim2.new(0, 0, 0, 50)
Credits.BackgroundTransparency = 1
Credits.Text = "By VleisBeun"
Credits.TextColor3 = Color3.fromRGB(200, 200, 200)
Credits.TextSize = 16
Credits.Parent = Frame

-- Function to create toggle buttons
local function CreateToggle(name, positionY, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
    ToggleFrame.Position = UDim2.new(0, 0, 0, 80 + positionY * 40)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 18
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0.3, 0, 1, 0)
    ToggleButton.Position = UDim2.new(0.7, 0, 0, 0)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleButton.Text = "OFF"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    ToggleButton.Parent = ToggleFrame

    local enabled = false
    ToggleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        ToggleButton.Text = enabled and "ON" or "OFF"
        ToggleButton.TextColor3 = enabled ? Color3.fromRGB(0, 255, 0) : Color3.fromRGB(255, 0, 0)
        callback(enabled)
    end)
end

-- Gun Mod Script (integrated)
local gunModEnabled = false
local function ToggleGunMod(enabled)
    gunModEnabled = enabled
    if enabled then
        local gunSettingsFolder = ReplicatedStorage.TREKModules.GunSettings

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
    else
        -- Note: Disabling would require resetting to original values, but since originals aren't stored, this just prints a message.
        print("Gun Mod Disabled (Reset game to revert changes)")
    end
end

-- Fly Mode
local flyEnabled = false
local flySpeed = 50
local function ToggleFly(enabled)
    flyEnabled = enabled
    if enabled then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent = LocalPlayer.Character.HumanoidRootPart

        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyGyro.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
        bodyGyro.Parent = LocalPlayer.Character.HumanoidRootPart

        RunService:BindToRenderStep("Fly", Enum.RenderPriority.Input.Value, function()
            if flyEnabled then
                local moveDirection = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + Vector3.new(0, 0, -1) end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection + Vector3.new(0, 0, 1) end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection + Vector3.new(1, 0, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + Vector3.new(-1, 0, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDirection = moveDirection + Vector3.new(0, -1, 0) end

                bodyVelocity.Velocity = (Workspace.CurrentCamera.CFrame * moveDirection).Unit * flySpeed
                bodyGyro.CFrame = Workspace.CurrentCamera.CFrame
            end
        end)
    else
        RunService:UnbindFromRenderStep("Fly")
        if LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then
            for _, obj in ipairs(LocalPlayer.Character.HumanoidRootPart:GetChildren()) do
                if obj:IsA("BodyVelocity") or obj:IsA("BodyGyro") then
                    obj:Destroy()
                end
            end
        end
    end
end

-- Godmode (Infinite Health)
local godmodeEnabled = false
local function ToggleGodmode(enabled)
    godmodeEnabled = enabled
    if enabled then
        RunService.Heartbeat:Connect(function()
            if godmodeEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
            end
        end)
    end
end

-- Speed Hack
local speedHackEnabled = false
local speedMultiplier = 5
local function ToggleSpeedHack(enabled)
    speedHackEnabled = enabled
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = enabled ? 16 * speedMultiplier : 16
    end
end

-- Aimbot (Simple silent aim)
local aimbotEnabled = false
local function GetClosestEnemy()
    local closest = nil
    local closestDist = math.huge
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team and player.Character and player.Character:FindFirstChild("Head") then
            local dist = (player.Character.Head.Position - Workspace.CurrentCamera.CFrame.Position).Magnitude
            if dist < closestDist then
                closest = player
                closestDist = dist
            end
        end
    end
    return closest
end

local function ToggleAimbot(enabled)
    aimbotEnabled = enabled
    if enabled then
        RunService.RenderStepped:Connect(function()
            if aimbotEnabled then
                local enemy = GetClosestEnemy()
                if enemy and enemy.Character and enemy.Character:FindFirstChild("Head") then
                    Workspace.CurrentCamera.CFrame = CFrame.new(Workspace.CurrentCamera.CFrame.Position, enemy.Character.Head.Position)
                end
            end
        end)
    end
end

-- ESP (Highlights players)
local espEnabled = false
local espHighlights = {}
local function ToggleESP(enabled)
    espEnabled = enabled
    if enabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                highlight.Parent = player.Character
                espHighlights[player] = highlight
            end
        end
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(char)
                if espEnabled then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                    highlight.Parent = char
                    espHighlights[player] = highlight
                end
            end)
        end)
    else
        for _, highlight in pairs(espHighlights) do
            highlight:Destroy()
        end
        espHighlights = {}
    end
end

-- Create Toggles
CreateToggle("Gun Mod", 0, ToggleGunMod)
CreateToggle("Fly Mode", 1, ToggleFly)
CreateToggle("Godmode", 2, ToggleGodmode)
CreateToggle("Speed Hack", 3, ToggleSpeedHack)
CreateToggle("Aimbot", 4, ToggleAimbot)
CreateToggle("ESP", 5, ToggleESP)

-- Make GUI draggable
local dragging = false
local dragInput, dragStart, startPos

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

print("Genocide Hub Loaded! Press the toggles to enable features. UwU")
