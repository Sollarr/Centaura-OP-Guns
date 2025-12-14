--[[ 
    GENOCIDE GUI - Mobile-Optimized Fix for Centaura Fire Bug
    Features: Touch-Friendly, State Preservation, Optimized Loop
]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

-- // CONFIGURATION // --
local GUI_COLOR = Color3.fromRGB(30, 30, 30)
local ACCENT_COLOR = Color3.fromRGB(255, 0, 0)
local TEXT_COLOR = Color3.fromRGB(255, 255, 255)
local SUCCESS_COLOR = Color3.fromRGB(50, 200, 50)

-- Mobile detection
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- // CLEANUP EXISTING GUI // --
pcall(function()
    if CoreGui:FindFirstChild("GenocideGUI") then
        CoreGui.GenocideGUI:Destroy()
    end
end)

-- // LOGIC VARIABLES // --
local isEnabled = false
local isMinimized = false
local loopConnection = nil
local gunModules = {}
local originalValues = {}
local lastApplyTime = 0
local APPLY_INTERVAL = 0.5 -- Apply mods every 0.5 seconds (reduces mobile lag)

-- // CRITICAL FIX: PRESERVE GUN STATE // --
local gunStates = {} -- Stores original gun states to restore after shot

-- // MODS TABLE (MOBILE SAFE) // --
local mods = {
    -- Damage
    Damage = 999,
    MaxDamage = 999,
    MinDamage = 999,
    HeadshotMultiplier = 100,
    BodyShotMultiplier = 100,
    
    -- Accuracy & Recoil
    Spread = 0,
    spread = 0,
    Recoil = 0,
    recoil = 0,
    crouchSpread = 0,
    HipFireAccuracy = 0,
    ZoomAccuracy = 0,
    
    -- Fire Rate & Range
    Range = 99999,
    range = 99999,
    FireRate = 0.001,
    firerate = 0.001,
    BulletSpeed = 9999,
    
    -- Reload & Equipment
    prepTime = 0.01,
    equipTime = 0.01,
    ReloadSpeed = 0.01,
    ReloadAnimationSpeed = 0.01,
    
    -- Ammo (CRITICAL FIX)
    MaxShots = math.huge,
    AmmoCount = math.huge,      -- Infinite ammo
    AmmoPerShot = 0,            -- Keep at 0 (doesn't consume ammo)
    AmmoPerMagazine = math.huge,
    
    -- Additional
    Penetration = 999,
    ShellsPerShot = 1,
    Weight = -999,
    Suppression = 0,
    teamkill = false
}

-- // NOTIFICATION SYSTEM // --
local function Notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3
        })
    end)
end

-- // FIND GUN MODULES (MOBILE SAFE) // --
local function FindGunModules()
    gunModules = {}
    
    local searchPaths = {
        ReplicatedStorage:FindFirstChild("GunScripts"),
        ReplicatedStorage:FindFirstChild("TREKModules"),
        ReplicatedStorage:FindFirstChild("GunSettings"),
        ReplicatedStorage:FindFirstChild("WeaponModules"),
        ReplicatedStorage
    }
    
    for _, container in ipairs(searchPaths) do
        if container then
            for _, child in ipairs(container:GetDescendants()) do
                if child:IsA("ModuleScript") then
                    local name = child.Name:lower()
                    if name:find("gun") or name:find("weapon") or name:find("stats") then
                        table.insert(gunModules, child)
                    end
                end
            end
        end
    end
    
    return #gunModules > 0
end

-- // GUI CREATION (MOBILE OPTIMIZED) // --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GenocideGUI"
ScreenGui.ResetOnSpawn = false

pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then 
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui") 
end

-- Main Frame (POSITIONED FOR MOBILE THUMB REACH)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = isMobile and UDim2.new(0, 280, 0, 160) or UDim2.new(0, 220, 0, 120)
MainFrame.Position = isMobile and UDim2.new(0.5, -140, 0.7, -80) or UDim2.new(0.1, 0, 0.1, 0)
MainFrame.BackgroundColor3 = GUI_COLOR
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Shadow for depth
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0, -15, 0, -15)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.7
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
Shadow.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, isMobile and 45 or 30)
TitleBar.BackgroundColor3 = ACCENT_COLOR
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local BottomCover = Instance.new("Frame")
BottomCover.Name = "BottomCover"
BottomCover.Size = UDim2.new(1, 0, 0, 10)
BottomCover.Position = UDim2.new(0, 0, 1, -10)
BottomCover.BackgroundColor3 = ACCENT_COLOR
BottomCover.BorderSizePixel = 0
BottomCover.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "GENOCIDE"
TitleLabel.TextColor3 = TEXT_COLOR
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = isMobile and 20 or 16
TitleLabel.Parent = TitleBar

-- Minimize Button (LARGER FOR TOUCH)
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, isMobile and 45 or 30, 0, isMobile and 45 or 30)
MinimizeButton.Position = UDim2.new(1, isMobile and -45 or -30, 0, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = TEXT_COLOR
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = isMobile and 28 or 20
MinimizeButton.AutoButtonColor = false
MinimizeButton.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinimizeButton

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(0.9, 0, 0, isMobile and 25 or 20)
StatusLabel.Position = UDim2.new(0.05, 0, 0, isMobile and 50 or 35)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Ready"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = isMobile and 14 or 12
StatusLabel.Parent = MainFrame

-- Toggle Button (EXTRA LARGE FOR MOBILE)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = isMobile and UDim2.new(0.85, 0, 0, 50) or UDim2.new(0.8, 0, 0, 35)
ToggleButton.Position = isMobile and UDim2.new(0.075, 0, 0, 85) or UDim2.new(0.1, 0, 0, 60)
ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
ToggleButton.Text = "OFF"
ToggleButton.TextColor3 = TEXT_COLOR
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = isMobile and 24 or 18
ToggleButton.AutoButtonColor = false
ToggleButton.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleButton

-- // TOUCH DRAGGING (MOBILE SAFE) // --
local dragging = false
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- // MINIMIZE LOGIC // --
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    if isMinimized then
        StatusLabel.Visible = false
        ToggleButton.Visible = false
        TitleLabel.Text = "G"
        MinimizeButton.Text = "+"
        BottomCover.Visible = false
        
        local targetSize = isMobile and UDim2.new(0, 70, 0, 70) or UDim2.new(0, 50, 0, 50)
        TweenService:Create(MainFrame, tweenInfo, {Size = targetSize}):Play()
        TweenService:Create(TitleBar, tweenInfo, {Size = UDim2.new(1, 0, 1, 0)}):Play()
        
        TitleLabel.TextSize = isMobile and 32 or 24
    else
        local targetSize = isMobile and UDim2.new(0, 280, 0, 160) or UDim2.new(0, 220, 0, 120)
        TweenService:Create(MainFrame, tweenInfo, {Size = targetSize}):Play()
        TweenService:Create(TitleBar, tweenInfo, {Size = UDim2.new(1, 0, 0, isMobile and 45 or 30)}):Play()
        
        task.wait(0.2)
        StatusLabel.Visible = true
        ToggleButton.Visible = true
        TitleLabel.Text = "GENOCIDE"
        MinimizeButton.Text = "-"
        BottomCover.Visible = true
        TitleLabel.TextSize = isMobile and 20 or 16
    end
end)

-- // CRITICAL: PRESERVE GUN STATE BEFORE MODIFICATION // --
local function BackupGunState(gunStats)
    for gunName, gun in pairs(gunStats) do
        if not gunStates[gunName] then
            gunStates[gunName] = {
                AmmoCount = gun.AmmoCount,
                AmmoPerShot = gun.AmmoPerShot,
                MaxShots = gun.MaxShots
            }
        end
    end
end

-- // APPLY MODS (MOBILE SAFE WITH STATE PRESERVATION) // --
local function ApplyMods()
    local modified = 0
    
    for _, moduleScript in ipairs(gunModules) do
        local success, gunStats = pcall(require, moduleScript)
        if success and type(gunStats) == "table" then
            
            -- Backup original state FIRST TIME
            if not gunStates[moduleScript] then
                BackupGunState(gunStats)
                gunStates[moduleScript] = true
            end
            
            for gunName, gun in pairs(gunStats) do
                if type(gun) == "table" then
                    local changed = false
                    
                    for prop, value in pairs(mods) do
                        if gun[prop] ~= value then
                            gun[prop] = value
                            changed = true
                        end
                    end
                    
                    if changed then
                        modified = modified + 1
                    end
                end
            end
        end
    end
    
    return modified
end

-- // RESTORE ORIGINAL STATE AFTER SHOT (FIXES FIRE BUTTON BUG) // --
local function RestoreAfterShot()
    for _, moduleScript in ipairs(gunModules) do
        local success, gunStats = pcall(require, moduleScript)
        if success and type(gunStats) == "table" then
            for gunName, gun in pairs(gunStats) do
                if gunStates[gunName] then
                    -- Reset ONLY ammo-related values
                    gun.AmmoCount = gunStates[gunName].AmmoCount
                    gun.AmmoPerShot = gunStates[gunName].AmmoPerShot
                    gun.MaxShots = gunStates[gunName].MaxShots
                end
            end
        end
    end
end

-- // DETECT SHOT AND RESTORE STATE (MOBILE TOUCH DETECTION) // --
local function SetupShotDetection()
    -- Detect mobile fire button touch
    UserInputService.TouchTapInWorld:Connect(function(touch)
        -- Short delay to let game process shot
        task.delay(0.1, function()
            RestoreAfterShot()
        end)
    end)
end

-- // INITIALIZATION // --
local foundModules = FindGunModules()

if foundModules then
    StatusLabel.Text = "Found " .. #gunModules .. " module(s)"
    StatusLabel.TextColor3 = SUCCESS_COLOR
    Notify("GENOCIDE", "Found gun modules! Ready to activate.", 2)
else
    StatusLabel.Text = "Searching modules..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
end

-- // TOGGLE LOGIC (MOBILE SAFE) // --
ToggleButton.MouseButton1Click:Connect(function()
    isEnabled = not isEnabled
    
    if isEnabled then
        -- Double-check modules
        if #gunModules == 0 then
            FindGunModules()
            if #gunModules == 0 then
                Notify("ERROR", "No gun modules found!", 3)
                isEnabled = false
                return
            end
        end
        
        ToggleButton.Text = "ON"
        ToggleButton.BackgroundColor3 = SUCCESS_COLOR
        StatusLabel.Text = "ACTIVE"
        StatusLabel.TextColor3 = SUCCESS_COLOR
        
        -- Apply mods ONCE (not continuously)
        local count = ApplyMods()
        Notify("GENOCIDE", string.format("Activated! Modified %d values", count), 2)
        
        -- Setup shot detection
        SetupShotDetection()
        
    else
        ToggleButton.Text = "OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        StatusLabel.Text = "Disabled"
        StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        
        -- Restore original state COMPLETELY
        RestoreAfterShot()
        Notify("GENOCIDE", "Mods deactivated", 2)
    end
end)

-- // CLEANUP ON GUI DESTROY // --
ScreenGui.AncestryChanged:Connect(function()
    if not ScreenGui.Parent then
        RestoreAfterShot()
    end
end)

-- // INITIAL NOTIFICATION // --
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🔥 GENOCIDE MOBILE FIXED LOADED 🔥")
print("Modules found: " .. #gunModules)
print("Positioned for thumb reach on mobile")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

Notify("GENOCIDE", isMobile and "Mobile Optimized Loaded!" or "Desktop Loaded!", 2)
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🔥 GENOCIDE HUB LOADED 🔥")
print("By VleisBeun")
print("Toggle features in the GUI")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
