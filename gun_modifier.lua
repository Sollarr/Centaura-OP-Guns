-- Genocide Hub for Centaura
-- By VleisBeun (Revised & Optimized)
-- This is a Roblox script that creates a GUI hub with toggles for various features
-- Paste this into a Roblox exploit executor like Synapse X or Krnl to run it in the game Centaura.
-- Note: This is for educational purposes only. Using exploits can result in bans from Roblox. Use at your own risk.

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Cleanup previous instance if exists
if game.CoreGui:FindFirstChild("GenocideHub") then
    game.CoreGui:FindFirstChild("GenocideHub"):Destroy()
end

-- GUI Setup using Roblox's ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GenocideHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Main Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 320, 0, 450)
Frame.Position = UDim2.new(0.5, -160, 0.5, -225)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromRGB(255, 0, 0)
Frame.Active = true
Frame.Draggable = true -- Simple built-in draggable
Frame.Parent = ScreenGui

-- Add rounded corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = Frame

-- Title Bar
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.Text = "🔥 GENOCIDE HUB 🔥"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.BorderSizePixel = 0
Title.Parent = Frame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Credits
local Credits = Instance.new("TextLabel")
Credits.Size = UDim2.new(1, 0, 0, 25)
Credits.Position = UDim2.new(0, 0, 0, 50)
Credits.BackgroundTransparency = 1
Credits.Text = "By VleisBeun | Centaura Exploit"
Credits.TextColor3 = Color3.fromRGB(150, 150, 150)
Credits.TextSize = 14
Credits.Font = Enum.Font.Gotham
Credits.Parent = Frame

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Frame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Scroll Frame for toggles
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -85)
ScrollFrame.Position = UDim2.new(0, 10, 0, 75)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Parent = Frame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollFrame

-- Auto-resize canvas
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end)

-- Function to create toggle buttons
local function CreateToggle(name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = ScrollFrame

    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 6)
    FrameCorner.Parent = ToggleFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.65, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 16
    Label.Font = Enum.Font.GothamSemibold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0.28, 0, 0, 30)
    ToggleButton.Position = UDim2.new(0.68, 0, 0.5, -15)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ToggleButton.Text = "OFF"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 80, 80)
    ToggleButton.TextSize = 14
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Parent = ToggleFrame

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 5)
    ButtonCorner.Parent = ToggleButton

    local enabled = false
    ToggleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        ToggleButton.Text = enabled and "ON" or "OFF"
        ToggleButton.TextColor3 = enabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 80, 80)
        ToggleButton.BackgroundColor3 = enabled and Color3.fromRGB(40, 80, 40) or Color3.fromRGB(60, 60, 60)
        
        -- Visual feedback
        local originalSize = ToggleButton.Size
        ToggleButton.Size = UDim2.new(0.26, 0, 0, 28)
        wait(0.1)
        ToggleButton.Size = originalSize
        
        callback(enabled)
    end)
end

-- Gun Mod Script (Optimized)
local gunModEnabled = false
local originalGunSettings = {}

local function ToggleGunMod(enabled)
    gunModEnabled = enabled
    
    local success, err = pcall(function()
        local gunSettingsFolder = ReplicatedStorage:FindFirstChild("TREKModules")
        if gunSettingsFolder then
            gunSettingsFolder = gunSettingsFolder:FindFirstChild("GunSettings")
        end
        
        if not gunSettingsFolder then
            warn("⚠️ Gun settings folder not found! Path may be incorrect.")
            return
        end

        if enabled then
            print("🔫 Activating Gun Mod...")
            
            local newSettings = {
                MaxDamage = 999,
                MinDamage = 999,
                AmmoCount = 999,
                HeadshotMultiplier = 10,
                ReloadSpeed = 0.01,
                firerate = 0.01,
                spread = 0,
                crouchSpread = 0,
                Recoil = 0,
                Penetration = 999,
                Range = 99999,
                ShellsPerShot = 1,
                teamkill = false,
                Weight = -999,
                Suppression = 0
            }

            for _, gunModule in ipairs(gunSettingsFolder:GetChildren()) do
                if gunModule:IsA("ModuleScript") then
                    pcall(function()
                        local settings = require(gunModule)
                        
                        -- Store original settings for potential restoration
                        if not originalGunSettings[gunModule.Name] then
                            originalGunSettings[gunModule.Name] = {}
                            for key, value in pairs(newSettings) do
                                if settings[key] ~= nil then
                                    originalGunSettings[gunModule.Name][key] = settings[key]
                                end
                            end
                        end

                        -- Apply new settings
                        for key, value in pairs(newSettings) do
                            if settings[key] ~= nil then
                                settings[key] = value
                            end
                        end

                        print(string.format("✓ Modified: %s", gunModule.Name))
                    end)
                end
            end

            print("🔥 ALL WEAPONS OVERPOWERED! 🔥")
        else
            print("🔫 Deactivating Gun Mod (requires respawn to fully reset)...")
        end
    end)
    
    if not success then
        warn("❌ Gun Mod Error: " .. tostring(err))
    end
end

-- Fly Mode (Optimized)
local flyEnabled = false
local flySpeed = 100
local flyConnection

local function ToggleFly(enabled)
    flyEnabled = enabled
    
    if enabled then
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then
            warn("⚠️ Character not found!")
            return
        end
        
        local hrp = char.HumanoidRootPart
        
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "FlyVelocity"
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Parent = hrp

        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.Name = "FlyGyro"
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.P = 9e4
        bodyGyro.CFrame = hrp.CFrame
        bodyGyro.Parent = hrp

        flyConnection = RunService.RenderStepped:Connect(function()
            if not flyEnabled or not char or not hrp then
                return
            end
            
            local cam = Workspace.CurrentCamera
            local moveDirection = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then 
                moveDirection = moveDirection + (cam.CFrame.LookVector) 
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then 
                moveDirection = moveDirection - (cam.CFrame.LookVector) 
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then 
                moveDirection = moveDirection - (cam.CFrame.RightVector) 
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then 
                moveDirection = moveDirection + (cam.CFrame.RightVector) 
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then 
                moveDirection = moveDirection + Vector3.new(0, 1, 0) 
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then 
                moveDirection = moveDirection - Vector3.new(0, 1, 0) 
            end

            if moveDirection.Magnitude > 0 then
                moveDirection = moveDirection.Unit
            end
            
            bodyVelocity.Velocity = moveDirection * flySpeed
            bodyGyro.CFrame = cam.CFrame
        end)
        
        print("✈️ Fly Mode Activated! (W/A/S/D = Move, Space = Up, Shift = Down)")
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
            if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
        end
        
        print("✈️ Fly Mode Deactivated")
    end
end

-- Godmode (Optimized)
local godmodeEnabled = false
local godmodeConnection

local function ToggleGodmode(enabled)
    godmodeEnabled = enabled
    
    if enabled then
        godmodeConnection = RunService.Heartbeat:Connect(function()
            if godmodeEnabled then
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    local hum = char.Humanoid
                    if hum.Health < hum.MaxHealth then
                        hum.Health = hum.MaxHealth
                    end
                end
            end
        end)
        print("🛡️ Godmode Activated!")
    else
        if godmodeConnection then
            godmodeConnection:Disconnect()
            godmodeConnection = nil
        end
        print("🛡️ Godmode Deactivated")
    end
end

-- Speed Hack (Optimized)
local speedHackEnabled = false
local speedMultiplier = 3
local originalWalkSpeed = 16

local function ToggleSpeedHack(enabled)
    speedHackEnabled = enabled
    
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        
        if enabled then
            originalWalkSpeed = hum.WalkSpeed
            hum.WalkSpeed = originalWalkSpeed * speedMultiplier
            print(string.format("🏃 Speed Hack Activated! (Speed: %d)", hum.WalkSpeed))
        else
            hum.WalkSpeed = originalWalkSpeed
            print("🏃 Speed Hack Deactivated")
        end
    end
end

-- Aimbot (Optimized Silent Aim)
local aimbotEnabled = false
local aimbotConnection
local aimbotFOV = 500 -- Field of view radius for targeting

local function GetClosestEnemy()
    local closest = nil
    local closestDist = math.huge
    local cam = Workspace.CurrentCamera
    local camPos = cam.CFrame.Position
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local head = char:FindFirstChild("Head")
            
            -- Check if enemy (different team or no team)
            local isEnemy = player.Team ~= LocalPlayer.Team or player.Team == nil
            
            if isEnemy and head then
                local dist = (head.Position - camPos).Magnitude
                if dist < closestDist and dist < aimbotFOV then
                    closest = player
                    closestDist = dist
                end
            end
        end
    end
    
    return closest
end

local function ToggleAimbot(enabled)
    aimbotEnabled = enabled
    
    if enabled then
        aimbotConnection = RunService.RenderStepped:Connect(function()
            if aimbotEnabled then
                local enemy = GetClosestEnemy()
                if enemy and enemy.Character and enemy.Character:FindFirstChild("Head") then
                    local head = enemy.Character.Head
                    local cam = Workspace.CurrentCamera
                    cam.CFrame = CFrame.new(cam.CFrame.Position, head.Position)
                end
            end
        end)
        print("🎯 Aimbot Activated!")
    else
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end
        print("🎯 Aimbot Deactivated")
    end
end

-- ESP (Optimized Highlights)
local espEnabled = false
local espHighlights = {}

local function CreateESPForPlayer(player)
    if player == LocalPlayer then return end
    
    local function addHighlight(char)
        if espHighlights[player] then
            espHighlights[player]:Destroy()
        end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.Adornee = char
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        
        -- Color based on team
        if player.Team and player.Team == LocalPlayer.Team then
            highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Green for teammates
            highlight.OutlineColor = Color3.fromRGB(0, 200, 0)
        else
            highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Red for enemies
            highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
        end
        
        highlight.Parent = char
        espHighlights[player] = highlight
    end
    
    if player.Character then
        addHighlight(player.Character)
    end
    
    player.CharacterAdded:Connect(function(char)
        if espEnabled then
            addHighlight(char)
        end
    end)
end

local function ToggleESP(enabled)
    espEnabled = enabled
    
    if enabled then
        -- Add ESP to existing players
        for _, player in ipairs(Players:GetPlayers()) do
            CreateESPForPlayer(player)
        end
        
        -- Add ESP to new players
        Players.PlayerAdded:Connect(function(player)
            if espEnabled then
                CreateESPForPlayer(player)
            end
        end)
        
        print("👁️ ESP Activated!")
    else
        -- Remove all highlights
        for _, highlight in pairs(espHighlights) do
            if highlight then
                highlight:Destroy()
            end
        end
        espHighlights = {}
        print("👁️ ESP Deactivated")
    end
end

-- Auto-reconnect features on respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.5) -- Wait for character to fully load
    
    if flyEnabled then
        ToggleFly(false)
        wait(0.1)
        ToggleFly(true)
    end
    
    if speedHackEnabled then
        ToggleSpeedHack(false)
        wait(0.1)
        ToggleSpeedHack(true)
    end
end)

-- Create Toggles
CreateToggle("🔫 Gun Mod", ToggleGunMod)
CreateToggle("✈️ Fly Mode", ToggleFly)
CreateToggle("🛡️ Godmode", ToggleGodmode)
CreateToggle("🏃 Speed Hack", ToggleSpeedHack)
CreateToggle("🎯 Aimbot", ToggleAimbot)
CreateToggle("👁️ ESP", ToggleESP)

-- Notification
local function Notify(text)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Genocide Hub";
        Text = text;
        Duration = 3;
    })
end

Notify("Genocide Hub Loaded Successfully!")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🔥 GENOCIDE HUB LOADED 🔥")
print("By VleisBeun")
print("Toggle features in the GUI")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
