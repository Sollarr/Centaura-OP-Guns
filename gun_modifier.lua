-- Genocide Hub for Centaura (Mobile Optimized with Icon & Ammo Fix)
-- By VleisBeun (Revised & Optimized)
-- Features: Draggable, Minimizable, Mobile-Friendly, Ammo Bug Fixed

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

-- Cleanup previous instance
if CoreGui:FindFirstChild("GenocideHub") then
    CoreGui:FindFirstChild("GenocideHub"):Destroy()
end

-- Mobile detection
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- GUI Configuration
local GUI_COLOR = Color3.fromRGB(25, 25, 25)
local ACCENT_COLOR = Color3.fromRGB(255, 0, 0)
local TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local SUCCESS_COLOR = Color3.fromRGB(50, 255, 50)
local WARNING_COLOR = Color3.fromRGB(255, 200, 0)

-- Main GUI Container
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GenocideHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- Icon Image (Minimized State)
local function CreateIcon()
    local Icon = Instance.new("TextButton")
    Icon.Name = "GenocideIcon"
    Icon.Size = UDim2.new(0, 60, 0, 60)
    Icon.Position = isMobile and UDim2.new(0.85, 0, 0.85, 0) or UDim2.new(0.85, 0, 0.05, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = ""
    Icon.ZIndex = 10
    
    -- Create icon image
    local Img = Instance.new("ImageLabel")
    Img.Name = "IconImage"
    Img.Size = UDim2.new(1, 0, 1, 0)
    Img.Image = "rbxassetid://6031068421"  -- Roblox combat icon
    Img.ImageColor3 = ACCENT_COLOR
    Img.Parent = Icon
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Icon
    
    -- Dragging for icon
    local dragging, dragStart, startPos
    Icon.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Icon.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            Icon.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    -- Click to toggle
    Icon.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
        Icon.Visible = not MainFrame.Visible
    end)
    
    return Icon
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = isMobile and UDim2.new(0, 320, 0, 450) or UDim2.new(0, 320, 0, 450)
MainFrame.Position = isMobile and UDim2.new(0.5, -160, 0.5, -225) or UDim2.new(0.5, -160, 0.5, -225)
MainFrame.BackgroundColor3 = GUI_COLOR
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = ACCENT_COLOR
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

-- Title Text
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "🔥 GENOCIDE HUB 🔥"
Title.TextColor3 = TEXT_COLOR
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.Parent = TitleBar

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -30, 0.5, -15)
MinimizeButton.BackgroundTransparency = 0
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = TEXT_COLOR
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeButton

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -65, 0.5, -15)
CloseButton.BackgroundTransparency = 0
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = TEXT_COLOR
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Scroll Frame
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 1, -85)
ScrollFrame.Position = UDim2.new(0, 10, 0, 75)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 8
ScrollFrame.ScrollBarImageColor3 = ACCENT_COLOR
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollFrame

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end)

-- Function to create toggle buttons
local function CreateToggle(name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 50)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = ScrollFrame

    local FrameCorner = Instance.new("UICorner")
    FrameCorner.CornerRadius = UDim.new(0, 10)
    FrameCorner.Parent = ToggleFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.65, 0, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = TEXT_COLOR
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 16
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0.28, 0, 0, 35)
    ToggleButton.Position = UDim2.new(0.68, 0, 0.5, -17.5)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ToggleButton.Text = "OFF"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 80, 80)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.TextSize = 14
    ToggleButton.Parent = ToggleFrame

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = ToggleButton

    local enabled = false
    
    local function Toggle(state)
        enabled = state
        ToggleButton.Text = enabled and "ON" or "OFF"
        ToggleButton.TextColor3 = enabled and SUCCESS_COLOR or Color3.fromRGB(255, 80, 80)
        ToggleButton.BackgroundColor3 = enabled and Color3.fromRGB(40, 80, 40) or Color3.fromRGB(60, 60, 60)
        callback(enabled)
    end

    ToggleButton.MouseButton1Click:Connect(function()
        Toggle(not enabled)
        
        -- Visual feedback
        local originalSize = ToggleButton.Size
        ToggleButton.Size = UDim2.new(0.26, 0, 0, 32)
        task.wait(0.1)
        ToggleButton.Size = originalSize
    end)
    
    return Toggle
end

-- Gun Mod Script (AMMO BUG FIX)
local gunModEnabled = false
local originalGunSettings = {}
local gunStates = {} -- For state preservation

local function ToggleGunMod(enabled)
    gunModEnabled = enabled
    
    local success, err = pcall(function()
        local gunSettingsFolder = ReplicatedStorage:FindFirstChild("TREKModules")
        if gunSettingsFolder then
            gunSettingsFolder = gunSettingsFolder:FindFirstChild("GunSettings")
        end
        
        if not gunSettingsFolder then
            warn("⚠️ Gun settings folder not found!")
            return
        end

        if enabled then
            -- CRITICAL FIX: Set ammo per shot to 0
            local newSettings = {
                MaxDamage = 999,
                MinDamage = 999,
                AmmoCount = math.huge,
                AmmoPerShot = 0, -- Prevents ammo consumption
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
                Suppression = 0,
                MaxShots = math.huge -- Unlimited shots
            }

            for _, gunModule in ipairs(gunSettingsFolder:GetChildren()) do
                if gunModule:IsA("ModuleScript") then
                    pcall(function()
                        local settings = require(gunModule)
                        
                        -- Store original state
                        if not gunStates[gunModule.Name] then
                            gunStates[gunModule.Name] = {
                                AmmoCount = settings.AmmoCount,
                                AmmoPerShot = settings.AmmoPerShot,
                                MaxShots = settings.MaxShots
                            }
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
            -- Restore original state
            for _, gunModule in ipairs(gunSettingsFolder:GetChildren()) do
                if gunModule:IsA("ModuleScript") then
                    pcall(function()
                        local settings = require(gunModule)
                        if gunStates[gunModule.Name] then
                            settings.AmmoCount = gunStates[gunModule.Name].AmmoCount
                            settings.AmmoPerShot = gunStates[gunModule.Name].AmmoPerShot
                            settings.MaxShots = gunStates[gunModule.Name].MaxShots
                        end
                    end)
                end
            end
            
            print("🔫 Gun Mod deactivated")
        end
    end)
    
    if not success then
        warn("❌ Gun Mod Error: " .. tostring(err))
    end
end

-- Fly Mode (Optimized for mobile)
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
            
            -- Mobile controls
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
        
        print("✈️ Fly Mode Activated!")
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

-- Aimbot (Optimized)
local aimbotEnabled = false
local aimbotConnection
local aimbotFOV = 500

local function GetClosestEnemy()
    local closest = nil
    local closestDist = math.huge
    local cam = Workspace.CurrentCamera
    local camPos = cam.CFrame.Position
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local head = char:FindFirstChild("Head")
            
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

-- ESP (Optimized)
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
        
        if player.Team and player.Team == LocalPlayer.Team then
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.OutlineColor = Color3.fromRGB(0, 200, 0)
        else
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
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
        for _, player in ipairs(Players:GetPlayers()) do
            CreateESPForPlayer(player)
        end
        
        Players.PlayerAdded:Connect(function(player)
            CreateESPForPlayer(player)
        end)
        
        print("👁️ ESP Activated!")
    else
        for _, highlight in pairs(espHighlights) do
            if highlight then
                highlight:Destroy()
            end
        end
        espHighlights = {}
        print("👁️ ESP Deactivated")
    end
end

-- Event Handlers
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    Icon.Visible = true
end)

-- Create Toggles
CreateToggle("🔫 Gun Mod", ToggleGunMod)
CreateToggle("✈️ Fly Mode", ToggleFly)
CreateToggle("🛡️ Godmode", ToggleGodmode)
CreateToggle("🏃 Speed Hack", ToggleSpeedHack)
CreateToggle("🎯 Aimbot", ToggleAimbot)
CreateToggle("👁️ ESP", ToggleESP)

-- Create Icon
local Icon = CreateIcon()

-- Auto-reconnect features on respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.5)
    
    if gunModEnabled then
        ToggleGunMod(false)
        wait(0.1)
        ToggleGunMod(true)
    end
    
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

-- Notification
local function Notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title;
            Text = text;
            Duration = duration or 3;
        })
    end)
end

Notify("Genocide Hub Loaded!", "Features: Gun Mod, Fly, ESP, and more!", 3)
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🔥 GENOCIDE HUB LOADED 🔥")
print("By VleisBeun")
print("Features: Mobile-Optimized, Ammo Bug Fixed")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
