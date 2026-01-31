-- Combat GUI v11 - Fixed AutoBlock with Complete Logic
-- Snippet 1/4: Configuration and Setup
if game.PlaceId == 10449761463 or game.PlaceId == 130818724007978 or game.PlaceId == 131048399685555 then
    -- Load WindUI
    local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    
    -- Create configuration manager
    local ConfigManager = {}
    local configFile = "WaspireCombatUI.json"
    
    -- Default configuration
    local defaultConfig = {
        AutoBlockEnabled = false,
        AutoBlockCloseRange = 14,
        AutoBlockLongRange = 35,
        CounterESPEnabled = false,
        CounterRange = 20, -- Hardcoded for counter detection
        M1AfterBlockEnabled = false,
        CamlockEnabled = false,
        CamlockKeybind = "Q",
        MobileCamlockButton = false,
        DeathCounterESPEnabled = false,
        CloseRangeMoves = {
            "rbxassetid://16552234590", "rbxassetid://17889290569", "rbxassetid://17889461810", "rbxassetid://17889458563",
            "rbxassetid://17889471098", "rbxassetid://16515448089", "rbxassetid://16515520431", "rbxassetid://16515503507",
            "rbxassetid://15162694192", "rbxassetid://15240176873", "rbxassetid://15240216931", "rbxassetid://15259161390",
            "rbxassetid://14136436157", "rbxassetid://14001963401", "rbxassetid://13997092940", "rbxassetid://14004222985",
            "rbxassetid://13378708199", "rbxassetid://13378751717", "rbxassetid://13390230973", "rbxassetid://13295936866",
            "rbxassetid://13295919399", "rbxassetid://13296577783", "rbxassetid://13491635433", "rbxassetid://13294471966",
            "rbxassetid://13532604085", "rbxassetid://13532600125", "rbxassetid://13532562418", "rbxassetid://10469643643",
            "rbxassetid://10469630950", "rbxassetid://10469639222", "rbxassetid://10469493270", "rbxassetid://10479335397",
            "rbxassetid://17325537719", "rbxassetid://17325522388", "rbxassetid://17325510002", "rbxassetid://17325513870",
            "rbxassetid://13380255751", "rbxassetid://17857788598", "rbxassetid://17799224866", "rbxassetid://10470104242",
            "rbxassetid://10503381238", "rbxassetid://17889290569", "rbxassetid://17889471098", "rbxassetid://10479335397",
            "rbxassetid://18464351556", "rbxassetid://17889461810", "rbxassetid://17889458563", "rbxassetid://10466974800",
            "rbxassetid://10468665991", "rbxassetid://13380255751", "rbxassetid://12509505723", "rbxassetid://18179181663",
            "rbxassetid://17857880283", "rbxassetid://12534735382", "rbxassetid://12296882427", "rbxassetid://12272894215",
            "rbxassetid://15290930205", "rbxassetid://16431491215", "rbxassetid://16515850153", "rbxassetid://16139402582",
            "rbxassetid://13362587853", "rbxassetid://16139108718", "rbxassetid://14046756619", "rbxassetid://134775406437626",
            "rbxassetid://104895379416342", "rbxassetid://100059874351664", "rbxassetid://123005629431309",
            "rbxassetid://98542310119798", "rbxassetid://77509627104305", "rbxassetid://113166426814229",
            "rbxassetid://13376869471", "rbxassetid://15295895753", "rbxassetid://13370310513", "rbxassetid://125955606488863"
        },
        LongRangeMoves = {
            "rbxassetid://10479335397", "rbxassetid://10468665991", "rbxassetid://12684185971", "rbxassetid://12509505723",
            "rbxassetid://12684390285", "rbxassetid://17275150809", "rbxassetid://131820095363270", "rbxassetid://13362587853",
            "rbxassetid://14046756619", "rbxassetid://15295895753", "rbxassetid://15290930205", "rbxassetid://13380255751"
        },
        CounterMoves = {
            "rbxassetid://10469493270", "rbxassetid://10469630950", "rbxassetid://10469639222", "rbxassetid://10469643643",
            "rbxassetid://13532562418", "rbxassetid://13532600125", "rbxassetid://13532604085", "rbxassetid://13294471966",
            "rbxassetid://13491635433", "rbxassetid://13296577783", "rbxassetid://13295919399", "rbxassetid://13295936866",
            "rbxassetid://13370310513", "rbxassetid://13390230973", "rbxassetid://13378751717", "rbxassetid://13378708199",
            "rbxassetid://14004222985", "rbxassetid://13997092940", "rbxassetid://14001963401", "rbxassetid://14136436157",
            "rbxassetid://15259161390", "rbxassetid://15240216931", "rbxassetid://15240176873", "rbxassetid://15162694192",
            "rbxassetid://16515503507", "rbxassetid://16515520431", "rbxassetid://16515448089", "rbxassetid://16552234590",
            "rbxassetid://17889458563", "rbxassetid://17889461810", "rbxassetid://17889471098", "rbxassetid://17889290569",
            "rbxassetid://123005629431309", "rbxassetid://100059874351664", "rbxassetid://104895379416342", "rbxassetid://134775406437626"
        },
        WhiteCounterAnimation = "rbxassetid://15311685628",
        BlueCounterAnimation = "rbxassetid://12351854556"
    }
    
    -- Current configuration
    local currentConfig = {}
    
    -- Load configuration
    function ConfigManager:Load()
        if isfile(configFile) then
            local success, data = pcall(function()
                return game:GetService("HttpService"):JSONDecode(readfile(configFile))
            end)
            if success then
                for key, value in pairs(data) do
                    currentConfig[key] = value
                end
                return true
            end
        end
        -- Load defaults
        for key, value in pairs(defaultConfig) do
            currentConfig[key] = value
        end
        return false
    end
    
    -- Save configuration
    function ConfigManager:Save()
        local success = pcall(function()
            writefile(configFile, game:GetService("HttpService"):JSONEncode(currentConfig))
        end)
        return success
    end
    
    -- Get configuration value
    function ConfigManager:Get(key)
        return currentConfig[key] or defaultConfig[key]
    end
    
    -- Set configuration value
    function ConfigManager:Set(key, value)
        currentConfig[key] = value
        self:Save()
    end
    
    -- Initialize config
    ConfigManager:Load()
    
    -- Create WindUI Window with Custom Title and Crimson border
    local Window = WindUI:CreateWindow({
        Title = "Combat UI - Waspire",
        Icon = "rbxassetid://125242807265435",
        Author = "The Strongest Battlegrounds",
        Folder = "CombatGUI",
        Size = UDim2.fromOffset(620, 140), -- Increased size
        Transparent = false,
        Theme = "Crimson",
        BorderColor = Color3.fromHex("#DC143C"), -- Crimson border color
        Resizable = true,
        SideBarWidth = 135,
        HideSearchBar = true,
        ScrollBarEnabled = true,
        MinimizeEnabled = true,
        CloseEnabled = true,
    })
    
    -- Add Version Tag
    Window:Tag({
        Title = "v1.0",
        Color = Color3.fromHex("#DC143C"),  -- Crimson red color
        Radius = 13
    })
    
    -- Add Premium Tag with Star Icon
    Window:Tag({
        Title = "Premium",
        Icon = "star",
        Color = Color3.fromHex("#000000"),  -- Black color
        BorderColor = Color3.fromHex("#DC143C"),  -- Crimson border
        Radius = 10
    })
    -- Edit Open Button
    Window:EditOpenButton({
        Title = "Open Combat UI - v1.0",
        Icon = "sword",
        CornerRadius = UDim.new(0,16),
        StrokeThickness = 2,
        Color = ColorSequence.new( -- gradient
            Color3.fromHex("DC143C"),  -- Crimson
            Color3.fromHex("FFFFFF")   -- Dark Red
        ),
        OnlyMobile = false,
        Enabled = true,
        Draggable = true,
    })
-- Snippet 2/4: AutoBlock Core Functions (Counter ESP Removed)
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local AutoBlock = {
    Enabled = false,
    Blocking = false,
    Connections = {},
    CounterNotifierCooldowns = {},
    CounterHighlights = {}
}

-- Helper Functions from original script
function AutoBlock:IsPlayingAnimation(humanoid, animationList)
    if not humanoid then return false end
    for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
        if track.Animation and table.find(animationList, track.Animation.AnimationId) then
            return true
        end
    end
    return false
end

function AutoBlock:PressBlockKey()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Communicate") then
        character.Communicate:FireServer(unpack({
            [1] = {
                Goal = "KeyPress",
                Key = Enum.KeyCode.F,
            },
        }))
    end
end

function AutoBlock:ReleaseBlockKey()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Communicate") then
        character.Communicate:FireServer(unpack({
            [1] = {
                Goal = "KeyRelease",
                Key = Enum.KeyCode.F,
            },
        }))
    end
end

function AutoBlock:PressM1()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Communicate") then
        character.Communicate:FireServer(unpack({
            [1] = {
                Goal = "LeftClick",
                Mobile = true,
            },
        }))
    end
end

function AutoBlock:ReleaseM1()
    local character = LocalPlayer.Character
    if character and character:FindFirstChild("Communicate") then
        character.Communicate:FireServer(unpack({
            [1] = {
                Goal = "LeftClickRelease",
                Mobile = true,
            },
        }))
    end
end

-- Main Auto Block Logic
function AutoBlock:Start()
    if self.Enabled then return end
    
    self.Enabled = true
    self.Blocking = false
    
    -- Main Auto Block heartbeat
    local heartbeatConn = RunService.Heartbeat:Connect(function()
        if not self.Enabled then return end
        
        local closeRange = ConfigManager:Get("AutoBlockCloseRange")
        local longRange = ConfigManager:Get("AutoBlockLongRange")
        local closeMoves = ConfigManager:Get("CloseRangeMoves")
        local longMoves = ConfigManager:Get("LongRangeMoves")
        
        local character = LocalPlayer.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        
        local characterPos = character.HumanoidRootPart.Position
        
        -- Find closest players for both ranges
        local closestClosePlayer = nil
        local closestCloseDistance = closeRange
        local closestLongPlayer = nil
        local closestLongDistance = longRange
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local otherChar = player.Character
                if otherChar and otherChar:FindFirstChild("HumanoidRootPart") and otherChar:FindFirstChild("Humanoid") then
                    local distance = (characterPos - otherChar.HumanoidRootPart.Position).Magnitude
                    
                    if distance <= closeRange and distance < closestCloseDistance then
                        closestClosePlayer = player
                        closestCloseDistance = distance
                    end
                    
                    if distance <= longRange and distance < closestLongDistance then
                        closestLongPlayer = player
                        closestLongDistance = distance
                    end
                end
            end
        end
        
        -- Check for long range moves first (from original script logic)
        if closestLongPlayer and closestLongPlayer.Character and closestLongPlayer.Character:FindFirstChild("Humanoid") then
            local longHumanoid = closestLongPlayer.Character.Humanoid
            if self:IsPlayingAnimation(longHumanoid, longMoves) and not self.Blocking then
                self.Blocking = true
                self:PressBlockKey()
                task.wait(0.15)
                self.Blocking = false
                self:ReleaseBlockKey()
            end
        end
        
        -- Check for close range moves (with M1 after block option)
        if closestClosePlayer and closestClosePlayer.Character and closestClosePlayer.Character:FindFirstChild("Humanoid") then
            local closeHumanoid = closestClosePlayer.Character.Humanoid
            if self:IsPlayingAnimation(closeHumanoid, closeMoves) and not self.Blocking then
                self.Blocking = true
                self:PressBlockKey()
                task.wait(0.15)
                self.Blocking = false
                self:ReleaseBlockKey()
                
                -- M1 after block feature
                if ConfigManager:Get("M1AfterBlockEnabled") then
                    self:PressM1()
                    task.wait(0.1)
                    self:ReleaseM1()
                end
            end
        end
    end)
    
    table.insert(self.Connections, heartbeatConn)
end

function AutoBlock:Stop()
    if not self.Enabled then return end
    
    self.Enabled = false
    
    -- Release block key if holding
    if self.Blocking then
        self:ReleaseBlockKey()
        self.Blocking = false
    end
    
    -- Disconnect all connections
    for _, conn in ipairs(self.Connections) do
        conn:Disconnect()
    end
    self.Connections = {}
end

function AutoBlock:Toggle()
    if self.Enabled then
        self:Stop()
    else
        self:Start()
    end
    return self.Enabled
    end
-- Snippet 3/4: REWRITTEN Camlock System with FIXED Mobile Button
-- Camlock System - FIXED Mobile Button
local Camlock = {
    Enabled = false,
    Target = nil,
    TargetHighlight = nil,
    Connections = {},
    MobileButton = nil,
    MobileButtonFrame = nil,
    TargetDisplay = nil,
    ButtonState = "OFF",
    IsDragging = false,
    IsDead = false,
    LastToggleTime = 0,
    ToggleCooldown = 0.5,
    KeybindConnection = nil,
    InputService = game:GetService("UserInputService"),
    LastClickTime = 0,
    ClickCooldown = 0.3,
    DragStart = nil,
    DragStartPos = nil
}

-- Proper input detection
function Camlock:IsGUIBlockingInput()
    local guiService = game:GetService("GuiService")
    local selectedObject = guiService.SelectedObject
    return selectedObject ~= nil
end

-- Find closest target in camera FOV
function Camlock:FindClosestTarget()
    local camera = workspace.CurrentCamera
    local closest = nil
    local closestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local character = player.Character
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            local humanoid = character:FindFirstChild("Humanoid")
            
            if humanoidRootPart and humanoid and humanoid.Health > 0 then
                -- Check if target is in front of camera
                local screenPoint, onScreen = camera:WorldToViewportPoint(humanoidRootPart.Position)
                if onScreen then
                    local center = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
                    local targetPos = Vector2.new(screenPoint.X, screenPoint.Y)
                    local distance = (targetPos - center).Magnitude
                    
                    if distance < closestDistance then
                        closestDistance = distance
                        closest = player
                    end
                end
            end
        end
    end
    
    return closest
end

-- Add red highlight to target
function Camlock:AddTargetHighlight()
    if self.Target and self.Target.Character and not self.TargetHighlight then
        local highlight = Instance.new("Highlight")
        highlight.Name = "CamlockHighlight"
        highlight.FillColor = Color3.fromRGB(255, 50, 50)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.3
        highlight.OutlineTransparency = 0
        highlight.Adornee = self.Target.Character
        highlight.Parent = self.Target.Character
        self.TargetHighlight = highlight
    end
end

-- Remove target highlight
function Camlock:RemoveTargetHighlight()
    if self.TargetHighlight then
        self.TargetHighlight:Destroy()
        self.TargetHighlight = nil
    end
end

-- Check if local player is dead
function Camlock:CheckLocalPlayerDeath()
    local character = LocalPlayer.Character
    if not character then
        self.IsDead = true
        return true
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        self.IsDead = true
        return true
    end
    
    self.IsDead = false
    return false
end

-- Validate target
function Camlock:ValidateTarget()
    if not self.Target or not self.Target.Character then
        return false
    end
    
    local character = self.Target.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    
    if not humanoidRootPart or not humanoid or humanoid.Health <= 0 then
        return false
    end
    
    return true
end

-- Create target display (SMALLER and LOWER on screen)
function Camlock:CreateTargetDisplay()
    if self.TargetDisplay then return end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CamlockTargetDisplay"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.IgnoreGuiInset = true
    
    -- Smaller frame positioned lower on screen
    local frame = Instance.new("Frame")
    frame.Name = "TargetFrame"
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.5
    frame.Size = UDim2.new(0, 200, 0, 60)  -- Smaller size
    frame.Position = UDim2.new(0.5, -100, 0.1, 0)  -- Lower position (10% from top)
    frame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "TargetName"
    nameLabel.Text = ""
    nameLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14  -- Smaller text
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Parent = frame
    
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Name = "TargetInfo"
    infoLabel.Text = ""
    infoLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextSize = 12  -- Smaller text
    infoLabel.BackgroundTransparency = 1
    infoLabel.Size = UDim2.new(1, 0, 0.5, 0)
    infoLabel.Position = UDim2.new(0, 0, 0.5, 0)
    infoLabel.TextStrokeTransparency = 0.5
    infoLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    infoLabel.Parent = frame
    
    frame.Parent = screenGui
    screenGui.Parent = game:GetService("CoreGui")
    self.TargetDisplay = screenGui
end

-- Update target display
function Camlock:UpdateTargetDisplay()
    if not self.TargetDisplay or not self.Target or not self.Target.Character then return end
    
    local character = self.Target.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    
    if not humanoidRootPart or not humanoid then return end
    
    local health = math.floor(humanoid.Health)
    local maxHealth = math.floor(humanoid.MaxHealth)
    
    local localChar = LocalPlayer.Character
    local localRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")
    local distance = localRoot and math.floor((localRoot.Position - humanoidRootPart.Position).Magnitude) or 0
    
    local frame = self.TargetDisplay:FindFirstChild("TargetFrame")
    if frame then
        frame.TargetName.Text = self.Target.Name
        frame.TargetInfo.Text = string.format("HP: %d/%d | Dist: %d", health, maxHealth, distance)
    end
end

-- Clear target display
function Camlock:ClearTargetDisplay()
    if self.TargetDisplay then
        self.TargetDisplay:Destroy()
        self.TargetDisplay = nil
    end
end

-- Start camlock
function Camlock:Start()
    if self.Enabled then return end
    
    local target = self:FindClosestTarget()
    if not target then
        WindUI:Notify({
            Title = "Camlock",
            Content = "No target found in camera FOV",
            Duration = 2,
            Icon = "alert-triangle"
        })
        return false
    end
    
    self.Target = target
    self.Enabled = true
    self.ButtonState = "ON"
    
    -- Add highlight
    self:AddTargetHighlight()
    
    -- Create display
    self:CreateTargetDisplay()
    
    -- Main camlock loop
    local heartbeatConn = RunService.Heartbeat:Connect(function()
        if not self.Enabled then return end
        
        -- Check death
        if self:CheckLocalPlayerDeath() then
            self:Stop()
            return
        end
        
        -- Validate target
        if not self:ValidateTarget() then
            self:Stop()
            return
        end
        
        local character = self.Target.Character
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        
        if humanoidRootPart then
            local camera = workspace.CurrentCamera
            -- Smooth camera lock
            local targetCFrame = CFrame.new(camera.CFrame.Position, humanoidRootPart.Position)
            camera.CFrame = camera.CFrame:Lerp(targetCFrame, 0.5)
            
            -- Update display
            self:UpdateTargetDisplay()
        else
            self:Stop()
        end
    end)
    
    table.insert(self.Connections, heartbeatConn)
    
    -- Handle target respawn
    local charAddedConn = self.Target.CharacterAdded:Connect(function(newChar)
        task.wait(1) -- Wait for character to load
        if self.Enabled then
            self:AddTargetHighlight()
        end
    end)
    
    local charRemovingConn = self.Target.CharacterRemoving:Connect(function()
        if self.Enabled then
            self:Stop()
        end
    end)
    
    table.insert(self.Connections, charAddedConn)
    table.insert(self.Connections, charRemovingConn)
    
    -- Update mobile button if exists
    self:UpdateMobileButtonText()
    
    WindUI:Notify({
        Title = "Camlock",
        Content = "Camlock activated on " .. self.Target.Name,
        Duration = 2,
        Icon = "crosshair"
    })
    
    return true
end

-- Stop camlock
function Camlock:Stop()
    if not self.Enabled then return end
    
    self.Enabled = false
    self.ButtonState = "OFF"
    self.Target = nil
    
    -- Remove highlight
    self:RemoveTargetHighlight()
    
    -- Clear display
    self:ClearTargetDisplay()
    
    -- Disconnect connections
    for _, conn in ipairs(self.Connections) do
        if conn then
            pcall(function() conn:Disconnect() end)
        end
    end
    self.Connections = {}
    
    -- Update mobile button
    self:UpdateMobileButtonText()
    
    WindUI:Notify({
        Title = "Camlock",
        Content = "Camlock deactivated",
        Duration = 2,
        Icon = "crosshair"
    })
end

-- Toggle camlock with cooldown
function Camlock:Toggle()
    local currentTime = tick()
    if currentTime - self.LastToggleTime < self.ToggleCooldown then
        return self.Enabled
    end
    
    self.LastToggleTime = currentTime
    
    if self.Enabled then
        self:Stop()
        return false
    else
        return self:Start()
    end
end

-- FIXED: Create mobile button with proper touch handling
function Camlock:CreateMobileButton()
    if self.MobileButton then return end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MobileCamlockButton"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.IgnoreGuiInset = true
    
    -- Main container frame
    local container = Instance.new("Frame")
    container.Name = "CamlockContainer"
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(0, 120, 0, 40)
    container.Position = UDim2.new(1, -130, 0.5, -20)
    container.Parent = screenGui
    
    -- The actual button
    local button = Instance.new("TextButton")
    button.Name = "CamlockButton"
    button.Text = "CAMLOCK " .. self.ButtonState
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    button.BorderColor3 = Color3.fromRGB(255, 50, 50)
    button.BorderSizePixel = 2
    button.AutoButtonColor = false
    button.Size = UDim2.new(1, 0, 1, 0)
    button.Position = UDim2.new(0, 0, 0, 0)
    button.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- FIXED: SIMPLE DRAGGING - NO CONFLICTS
    local dragging = false
    local dragStart = Vector2.new(0, 0)
    local startPos = UDim2.new(0, 0, 0, 0)
    
    button.MouseButton1Down:Connect(function()
        dragging = true
        dragStart = self.InputService:GetMouseLocation()
        startPos = container.Position
    end)
    
    -- SIMPLE INPUT HANDLER - NO MULTIPLE CONNECTIONS
    local dragConnection
    dragConnection = self.InputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local currentPos = self.InputService:GetMouseLocation()
            local delta = currentPos - dragStart
            container.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X,
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    local upConnection
    upConnection = self.InputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Store connections for cleanup
    table.insert(self.Connections, dragConnection)
    table.insert(self.Connections, upConnection)
    
    -- FIXED: SIMPLE CLICK HANDLER
    button.MouseButton1Click:Connect(function()
        -- Check if we were dragging
        task.wait(0.1)
        if dragging then return end
        
        local currentTime = tick()
        if currentTime - self.LastClickTime < self.ClickCooldown then
            return
        end
        
        self.LastClickTime = currentTime
        
        -- Toggle camlock
        local wasEnabled = self.Enabled
        local newState = self:Toggle()
        
        if newState ~= wasEnabled then
            ConfigManager:Set("CamlockEnabled", newState)
            if camlockToggle then
                camlockToggle:SetValue(newState)
            end
        end
    end)
    
    -- Store the container
    self.MobileButton = screenGui
    self.MobileButtonFrame = container
    
    screenGui.Parent = game:GetService("CoreGui")
end

-- Update mobile button text
function Camlock:UpdateMobileButtonText()
    if self.MobileButtonFrame and self.MobileButtonFrame:FindFirstChild("CamlockButton") then
        local button = self.MobileButtonFrame.CamlockButton
        button.Text = "CAMLOCK " .. self.ButtonState
        
        if self.ButtonState == "ON" then
            button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            button.BorderColor3 = Color3.fromRGB(255, 50, 50)
        else
            button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            button.BorderColor3 = Color3.fromRGB(255, 50, 50)
        end
    end
end

-- Remove mobile button
function Camlock:RemoveMobileButton()
    if self.MobileButton then
        self.MobileButton:Destroy()
        self.MobileButton = nil
        self.MobileButtonFrame = nil
    end
end

-- Setup keybind
function Camlock:SetupKeybind()
    if self.KeybindConnection then
        self.KeybindConnection:Disconnect()
    end
    
    self.KeybindConnection = self.InputService.InputBegan:Connect(function(input, processed)
        -- Check if GUI is blocking input
        if processed or self:IsGUIBlockingInput() then
            return
        end
        
        if input.KeyCode.Name == ConfigManager:Get("CamlockKeybind") then
            local currentTime = tick()
            if currentTime - self.LastToggleTime < self.ToggleCooldown then
                return
            end
            
            self.LastToggleTime = currentTime
            
            local wasEnabled = self.Enabled
            local newState = self:Toggle()
            
            if newState ~= wasEnabled then
                ConfigManager:Set("CamlockEnabled", newState)
                if camlockToggle then
                    camlockToggle:SetValue(newState)
                end
            end
        end
    end)
end
-- Snippet 4/4: UI Setup and Final Initialization with ESP Tab
    -- Create Tabs with better styling
    local CombatTab = Window:Tab({
        Title = "Combat",
        Icon = "zap",
        Locked = false,
    })
    
    local CamlockTab = Window:Tab({
        Title = "Camlock",
        Icon = "crosshair",
        Locked = false,
    })
    
    local ESPTab = Window:Tab({
        Title = "ESP",
        Icon = "eye",
        Locked = false,
    })
    -- Utility Tab
     local UtilityTab = Window:Tab({
        Title = "Utility",
        Icon = "tool",
        Locked = false,
     })

    UtilityTab:Section({
        Title = "Auto Toxic",
        Desc = "Automatically send toxic messages on kill"
    })

-- Auto Toxic System
local AutoToxic = {
    Enabled = false,
    Message = "ez stop riding, you suck lalalala",
    RepeatCount = 1,
    Cooldown = 1,
    IsSending = false,
    LastKills = 0,
    Connection = nil
}

-- Auto Toxic Message Configuration - SIMPLE FIX
local toxicMessageLabel = UtilityTab:Paragraph({
    Title = "Toxic Message",
    Desc = "Current: " .. AutoToxic.Message
})

local changeMessageButton = UtilityTab:Button({
    Title = "Change Message",
    Desc = "Click to edit toxic message",
    Callback = function()
        -- Use a simple text input dialog
        local input = game:GetService("TextService"):GetStringAsync("Enter toxic message:", AutoToxic.Message)
        if input and input ~= "" then
            AutoToxic.Message = input
            toxicMessageLabel:SetDescription("Current: " .. input)
            WindUI:Notify({
                Title = "Auto Toxic",
                Content = "Message updated",
                Duration = 2,
                Icon = "message-square"
            })
        end
    end
})

-- Repeat count
local repeatSlider = UtilityTab:Slider({
    Title = "Repeat Count",
    Desc = "How many times to send the message",
    Value = {
        Min = 1,
        Max = 10,
        Default = AutoToxic.RepeatCount,
    },
    Callback = function(value)
        AutoToxic.RepeatCount = tonumber(value)
    end
})

-- Cooldown between repeats
local cooldownSlider = UtilityTab:Slider({
    Title = "Cooldown (seconds)",
    Desc = "Time between repeated messages",
    Value = {
        Min = 0.5,
        Max = 5,
        Default = AutoToxic.Cooldown,
    },
    Callback = function(value)
        AutoToxic.Cooldown = tonumber(value)
    end
})

function AutoToxic:SendMessages()
    if not self.Enabled or self.IsSending then return end
    self.IsSending = true
    
    for i = 1, self.RepeatCount do
        if game:GetService("TextChatService") then
            local channel = game:GetService("TextChatService").TextChannels.RBXGeneral
            if channel then
                pcall(function()
                    channel:SendAsync(self.Message)
                end)
            end
        end
        task.wait(self.Cooldown)
    end
    
    self.IsSending = false
end

function AutoToxic:Start()
    if self.Enabled then return end
    
    self.Enabled = true
    
    -- Get kills leaderstat
    local leaderstats = LocalPlayer:WaitForChild("leaderstats", 5)
    if not leaderstats then
        WindUI:Notify({
            Title = "Auto Toxic Error",
            Content = "Could not find leaderstats",
            Duration = 3,
            Icon = "alert-triangle"
        })
        return
    end
    
    local kills = leaderstats:WaitForChild("Kills", 5)
    if not kills then
        WindUI:Notify({
            Title = "Auto Toxic Error",
            Content = "Could not find Kills stat",
            Duration = 3,
            Icon = "alert-triangle"
        })
        return
    end
    
    self.LastKills = kills.Value
    
    -- Monitor kill changes
    self.Connection = kills.Changed:Connect(function(newValue)
        if not self.Enabled then return end
        
        if newValue > self.LastKills then
            self:SendMessages()
        end
        self.LastKills = newValue
    end)
    
    WindUI:Notify({
        Title = "Auto Toxic",
        Content = "Auto Toxic enabled\nMessage: " .. self.Message,
        Duration = 3,
        Icon = "message-square"
    })
end

function AutoToxic:Stop()
    if not self.Enabled then return end
    
    self.Enabled = false
    
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
    
    WindUI:Notify({
        Title = "Auto Toxic",
        Content = "Auto Toxic disabled",
        Duration = 2,
        Icon = "message-square-off"
    })
end

function AutoToxic:Toggle()
    if self.Enabled then
        self:Stop()
        return false
    else
        self:Start()
        return true
    end
end

-- Toggle button for Auto Toxic
local autoToxicToggle = UtilityTab:Toggle({
    Title = "Auto Toxic",
    Desc = "Send toxic messages automatically on kill",
    Value = false,
    Callback = function(state)
        if state then
            AutoToxic:Start()
        else
            AutoToxic:Stop()
        end
    end
})
    local SettingsTab = Window:Tab({
        Title = "Settings",
        Icon = "settings",
        Locked = false,
    })
    
    local AboutTab = Window:Tab({
        Title = "About",
        Icon = "info",
        Locked = false,
    })
    
    -- Combat Tab Elements
    CombatTab:Section({
        Title = "Auto Block System",
        Desc = "Automatic defense against enemy attacks"
    })
    
    local autoBlockToggle = CombatTab:Toggle({
        Title = "Auto Block",
        Desc = "Automatically blocks incoming attacks",
        Value = ConfigManager:Get("AutoBlockEnabled"),
        Callback = function(state)
            ConfigManager:Set("AutoBlockEnabled", state)
            if state then
                AutoBlock:Start()
                WindUI:Notify({
                    Title = "Auto Block",
                    Content = "Auto Block system activated",
                    Duration = 2,
                    Icon = "shield"
                })
            else
                AutoBlock:Stop()
                WindUI:Notify({
                    Title = "Auto Block",
                    Content = "Auto Block system deactivated",
                    Duration = 2,
                    Icon = "shield-off"
                })
            end
        end
    })
    
    local m1AfterBlockToggle = CombatTab:Toggle({
        Title = "M1 After Block",
        Desc = "Automatically attack after blocking a close range move",
        Value = ConfigManager:Get("M1AfterBlockEnabled"),
        Callback = function(state)
            ConfigManager:Set("M1AfterBlockEnabled", state)
            WindUI:Notify({
                Title = "M1 After Block",
                Content = state and "Enabled" or "Disabled",
                Duration = 2,
                Icon = "sword"
            })
        end
    })
    
    CombatTab:Section({
        Title = "Detection Ranges",
        Desc = "Configure auto block detection distances"
    })
    
    -- Store slider values locally to avoid notification spam
    local lastCloseRangeNotification = 0
    local lastLongRangeNotification = 0
    local notificationCooldown = 1
    
    local closeRangeSlider = CombatTab:Slider({
        Title = "Close Range Distance",
        Desc = "Distance for close range moves (studs)",
        Value = {
            Min = 5,
            Max = 50,
            Default = ConfigManager:Get("AutoBlockCloseRange"),
        },
        Callback = function(value)
            ConfigManager:Set("AutoBlockCloseRange", tonumber(value))
            -- Only show notification on final value (not during dragging)
            local currentTime = tick()
            if currentTime - lastCloseRangeNotification > notificationCooldown then
                lastCloseRangeNotification = currentTime
                WindUI:Notify({
                    Title = "Settings Updated",
                    Content = "Close range set to " .. value .. " studs",
                    Duration = 2,
                    Icon = "settings"
                })
            end
        end
    })
    
    local longRangeSlider = CombatTab:Slider({
        Title = "Long Range Distance",
        Desc = "Distance for long range moves (studs)",
        Value = {
            Min = 10,
            Max = 100,
            Default = ConfigManager:Get("AutoBlockLongRange"),
        },
        Callback = function(value)
            ConfigManager:Set("AutoBlockLongRange", tonumber(value))
            -- Only show notification on final value (not during dragging)
            local currentTime = tick()
            if currentTime - lastLongRangeNotification > notificationCooldown then
                lastLongRangeNotification = currentTime
                WindUI:Notify({
                    Title = "Settings Updated",
                    Content = "Long range set to " .. value .. " studs",
                    Duration = 2,
                    Icon = "settings"
                })
            end
        end
    })
    
    -- Camlock Tab Elements
    CamlockTab:Section({
        Title = "Camlock System",
        Desc = "Automatically lock camera to nearest enemy"
    })
    
    local camlockToggle = CamlockTab:Toggle({
        Title = "Camlock (PC)",
        Desc = "Enable camera lock to nearest enemy for PC users",
        Value = ConfigManager:Get("CamlockEnabled"),
        Callback = function(state)
            ConfigManager:Set("CamlockEnabled", state)
            
            if state then
                local success = Camlock:Start()
                if not success then
                    ConfigManager:Set("CamlockEnabled", false)
                    camlockToggle:SetValue(false)
                end
            else
                Camlock:Stop()
            end
        end
    })
    
    local keybindButton = CamlockTab:Button({
        Title = "Change Keybind (Currently: " .. ConfigManager:Get("CamlockKeybind") .. ")",
        Desc = "Click then press a key to set as camlock toggle",
        Callback = function()
            WindUI:Notify({
                Title = "Keybind Setup",
                Content = "Press any key to set as camlock toggle...",
                Duration = 5,
                Icon = "key"
            })
            
            local input = game:GetService("UserInputService").InputBegan:Wait()
            local key = input.KeyCode.Name
            
            ConfigManager:Set("CamlockKeybind", key)
            keybindButton:SetTitle("Change Keybind (Currently: " .. key .. ")")
            
            -- Re-setup keybind with new key
            Camlock:SetupKeybind()
            
            WindUI:Notify({
                Title = "Keybind Updated",
                Content = "Camlock keybind set to: " .. key,
                Duration = 3,
                Icon = "check"
            })
        end
    })
    
    local mobileCamlockToggle = CamlockTab:Toggle({
        Title = "Mobile Camlock Button",
        Desc = "Show mobile button for camlock control (Mobile users)",
        Value = ConfigManager:Get("MobileCamlockButton"),
        Callback = function(state)
            ConfigManager:Set("MobileCamlockButton", state)
            if state then
                Camlock:CreateMobileButton()
                WindUI:Notify({
                    Title = "Mobile Button",
                    Content = "Mobile camlock button added to screen",
                    Duration = 2,
                    Icon = "smartphone"
                })
            else
                Camlock:RemoveMobileButton()
                WindUI:Notify({
                    Title = "Mobile Button",
                    Content = "Mobile camlock button removed",
                    Duration = 2,
                    Icon = "smartphone-off"
                })
            end
        end
    })
    
    -- ESP Tab Elements (Counter ESP Moved Here)
    ESPTab:Section({
        Title = "ESP Systems",
        Desc = "Visual indicators utility"
    })
    
    -- Counter ESP System (FIXED - BLUE HIGHLIGHT, 4 SECONDS)
    local CounterESP = {
        Enabled = false,
        Highlights = {},
        Timers = {},
        Connections = {}
    }
    
    function CounterESP:GetCounterAnimation(humanoid)
        local whiteCounter = ConfigManager:Get("WhiteCounterAnimation")
        local blueCounter = ConfigManager:Get("BlueCounterAnimation")
        
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            if track.Animation then
                local animId = track.Animation.AnimationId
                if animId == whiteCounter or animId == blueCounter then
                    return animId
                end
            end
        end
        return nil
    end
    
    function CounterESP:AddHighlight(character)
        if not self.Highlights[character] then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(100, 150, 255) -- LIGHT BLUE color
            highlight.OutlineColor = Color3.fromRGB(200, 220, 255)
            highlight.FillTransparency = 0.3 -- Same transparency as camlock
            highlight.OutlineTransparency = 0
            highlight.Parent = character
            self.Highlights[character] = highlight
        end
    end
    
    function CounterESP:RemoveHighlight(character, fade)
        local highlight = self.Highlights[character]
        if highlight then
            if fade then
                -- Fade out effect
                for i = 0.3, 1, 0.1 do
                    if highlight then
                        highlight.FillTransparency = i
                        highlight.OutlineTransparency = i
                    end
                    task.wait(0.05)
                end
            end
            if highlight then
                highlight:Destroy()
            end
            self.Highlights[character] = nil
        end
        self.Timers[character] = nil
    end
    
    function CounterESP:CheckCounters()
        if not self.Enabled then return end
        
        local character = LocalPlayer.Character
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        local counterRange = ConfigManager:Get("CounterRange")
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local otherCharacter = player.Character
                local otherRootPart = otherCharacter:FindFirstChild("HumanoidRootPart")
                local otherHumanoid = otherCharacter:FindFirstChild("Humanoid")
                
                if otherRootPart and otherHumanoid and (rootPart.Position - otherRootPart.Position).Magnitude <= counterRange then
                    local counterAnimation = self:GetCounterAnimation(otherHumanoid)
                    if counterAnimation and not self.Timers[otherCharacter] then
                        -- Add highlight
                        self:AddHighlight(otherCharacter)
                        
                        -- Start timer for 4 seconds duration
                        self.Timers[otherCharacter] = tick()
                        
                        game:GetService("StarterGui"):SetCore("SendNotification", {
                            Title = "Counter Detected!",
                            Text = player.Name .. " used a counter move",
                            Duration = 1.2,
                        })
                        
                        -- Remove highlight after 4 seconds with fade
                        task.delay(4, function()
                            self:RemoveHighlight(otherCharacter, true)
                            game:GetService("StarterGui"):SetCore("SendNotification", {
                                Title = "Counter Ended",
                                Text = player.Name .. "'s counter move cooldown has ended",
                                Duration = 1.2,
                            })
                        end)
                    end
                end
            end
        end
    end
    
    function CounterESP:Start()
        if self.Enabled then return end
        
        self.Enabled = true
        
        local heartbeatConn = RunService.Heartbeat:Connect(function()
            self:CheckCounters()
        end)
        
        table.insert(self.Connections, heartbeatConn)
    end
    
    function CounterESP:Stop()
        if not self.Enabled then return end
        
        self.Enabled = false
        
        -- Remove all highlights with fade
        for character, highlight in pairs(self.Highlights) do
            if highlight then
                self:RemoveHighlight(character, true)
            end
        end
        
        -- Disconnect all connections
        for _, conn in ipairs(self.Connections) do
            if conn then
                pcall(function() conn:Disconnect() end)
            end
        end
        self.Connections = {}
        self.Highlights = {}
        self.Timers = {}
    end
    
    function CounterESP:Toggle()
        if self.Enabled then
            self:Stop()
        else
            self:Start()
        end
        return self.Enabled
    end
    
    local counterESPToggle = ESPTab:Toggle({
        Title = "Counter ESP",
        Desc = "Highlights enemies when they use counter moves.",
        Value = ConfigManager:Get("CounterESPEnabled"),
        Callback = function(state)
            ConfigManager:Set("CounterESPEnabled", state)
            if state then
                CounterESP:Start()
                WindUI:Notify({
                    Title = "Counter ESP",
                    Content = "Counter ESP activated (4s Blue Highlight)",
                    Duration = 2,
                    Icon = "eye"
                })
            else
                CounterESP:Stop()
                WindUI:Notify({
                    Title = "Counter ESP",
                    Content = "Counter ESP deactivated",
                    Duration = 2,
                    Icon = "eye-off"
                })
            end
        end
    })
    -- Ping Display ESP System
local PingESP = {
    Enabled = false,
    GuiFolder = nil,
    Connections = {}
}

function PingESP:CreateBillboard(player)
    if player == LocalPlayer then return nil end
    
    local bb = Instance.new("BillboardGui")
    bb.Name = "PingDisplay_" .. player.Name
    bb.Size = UDim2.new(0, 100, 0, 40)
    bb.AlwaysOnTop = true
    bb.MaxDistance = 300  -- Increased for better visibility
    bb.StudsOffset = Vector3.new(0, 3, 0)  -- Higher above head
    
    local label = Instance.new("TextLabel")
    label.Name = "PingLabel"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold  -- Better font
    label.TextSize = 14
    label.TextStrokeTransparency = 0.5
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.Text = "0ms"
    label.Parent = bb
    
    return bb
end

function PingESP:UpdatePingColor(label, ping)
    ping = ping or 0
    
    -- Dynamic color based on ping
    if ping < 50 then
        -- Green for low ping
        label.TextColor3 = Color3.fromRGB(50, 255, 50)
    elseif ping < 150 then
        -- Yellow for medium ping
        label.TextColor3 = Color3.fromRGB(255, 255, 50)
    else
        -- Red for high ping
        label.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end

function PingESP:Start()
    if self.Enabled then return end
    
    self.Enabled = true
    
    -- Create GUI folder
    self.GuiFolder = Instance.new("Folder")
    self.GuiFolder.Name = "PingESP"
    self.GuiFolder.Parent = game:GetService("CoreGui")
    
    -- Track existing players
    for _, player in ipairs(Players:GetPlayers()) do
        self:SetupPlayer(player)
    end
    
    -- Track new players
    local playerAddedConn = Players.PlayerAdded:Connect(function(player)
        self:SetupPlayer(player)
    end)
    
    table.insert(self.Connections, playerAddedConn)
    
    WindUI:Notify({
        Title = "Ping Display ESP",
        Content = "Ping Display ESP activated",
        Duration = 2,
        Icon = "wifi"
    })
end

function PingESP:SetupPlayer(player)
    if player == LocalPlayer then return end
    
    local bb = self:CreateBillboard(player)
    if not bb then return end
    
    bb.Parent = self.GuiFolder
    
    -- Update ping continuously
    local heartbeatConn = RunService.Heartbeat:Connect(function()
        if not self.Enabled or not bb or not bb.Parent then
            heartbeatConn:Disconnect()
            return
        end
        
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            bb.Adornee = character.HumanoidRootPart
            
            local ping = player:GetAttribute("Ping") or 0
            local pingValue = math.floor(ping)
            
            if bb:FindFirstChild("PingLabel") then
                local label = bb.PingLabel
                label.Text = tostring(pingValue) .. "ms"
                self:UpdatePingColor(label, pingValue)
                
                -- Handle dead players
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health <= 0 then
                    label.TextColor3 = Color3.fromRGB(100, 100, 100)  -- Gray for dead
                end
            end
        else
            bb.Adornee = nil
        end
    end)
    
    -- Handle character changes
    local charAddedConn = player.CharacterAdded:Connect(function(character)
        task.wait(1) -- Wait for character to load
        if self.Enabled and bb and bb.Parent then
            local rootPart = character:WaitForChild("HumanoidRootPart", 3)
            if rootPart then
                bb.Adornee = rootPart
            end
        end
    end)
    
    -- Store connections for cleanup
    table.insert(self.Connections, heartbeatConn)
    table.insert(self.Connections, charAddedConn)
end

function PingESP:Stop()
    if not self.Enabled then return end
    
    self.Enabled = false
    
    -- Remove GUI folder
    if self.GuiFolder then
        self.GuiFolder:Destroy()
        self.GuiFolder = nil
    end
    
    -- Disconnect all connections
    for _, conn in ipairs(self.Connections) do
        if conn then
            pcall(function() conn:Disconnect() end)
        end
    end
    self.Connections = {}
    
    WindUI:Notify({
        Title = "Ping Display ESP",
        Content = "Ping Display ESP deactivated",
        Duration = 2,
        Icon = "wifi-off"
    })
end

local pingESPToggle = ESPTab:Toggle({
    Title = "Ping Display ESP",
    Desc = "Shows player ping above their heads\nGreen(<50ms) Yellow(<150ms) Red(>150ms)",
    Value = false,
    Callback = function(state)
        if state then
            PingESP:Start()
        else
            PingESP:Stop()
        end
    end
})
-- High Ping Warning System
local HighPingWarning = {
    Enabled = true,
    Threshold = 150, -- ms
    WarningFrame = nil,
    Blinking = false
}

function HighPingWarning:CreateWarningFrame()
    if self.WarningFrame then return end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HighPingWarning"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local frame = Instance.new("Frame")
    frame.Name = "WarningFrame"
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.6
    frame.Size = UDim2.new(0, 300, 0, 80)
    frame.Position = UDim2.new(0.5, -150, 0.8, 0)  -- Middle bottom
    frame.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    -- Warning icon
    local warningIcon = Instance.new("TextLabel")
    warningIcon.Name = "WarningIcon"
    warningIcon.Text = "⚠️"
    warningIcon.TextSize = 24
    warningIcon.TextColor3 = Color3.fromRGB(255, 50, 50)
    warningIcon.BackgroundTransparency = 1
    warningIcon.Size = UDim2.new(0, 40, 0, 40)
    warningIcon.Position = UDim2.new(0, 10, 0.5, -20)
    warningIcon.Font = Enum.Font.GothamBold
    warningIcon.Parent = frame
    
    -- Main warning text
    local warningText = Instance.new("TextLabel")
    warningText.Name = "WarningText"
    warningText.Text = "PING TOO HIGH"
    warningText.TextSize = 18
    warningText.TextColor3 = Color3.fromRGB(255, 50, 50)
    warningText.BackgroundTransparency = 1
    warningText.Size = UDim2.new(1, -60, 0.5, 0)
    warningText.Position = UDim2.new(0, 50, 0, 10)
    warningText.Font = Enum.Font.GothamBold
    warningText.TextXAlignment = Enum.TextXAlignment.Left
    warningText.Parent = frame
    
    -- Subtext
    local subText = Instance.new("TextLabel")
    subText.Name = "SubText"
    subText.Text = "Autoblock may not work properly."
    subText.TextSize = 14
    subText.TextColor3 = Color3.fromRGB(180, 180, 180)
    subText.BackgroundTransparency = 1
    subText.Size = UDim2.new(1, -60, 0.5, 0)
    subText.Position = UDim2.new(0, 50, 0.5, 0)
    subText.Font = Enum.Font.Gotham
    subText.TextXAlignment = Enum.TextXAlignment.Left
    subText.Parent = frame
    
    screenGui.Parent = game:GetService("CoreGui")
    self.WarningFrame = screenGui
    
    -- Start hidden
    self.WarningFrame.Enabled = false
end

function HighPingWarning:StartBlinking()
    if self.Blinking then return end
    self.Blinking = true
    
    self.WarningFrame.Enabled = true
    
    task.spawn(function()
        while self.Blinking and self.WarningFrame and self.WarningFrame.Parent do
            -- Blink effect
            self.WarningFrame.WarningFrame.BackgroundTransparency = 0.3
            self.WarningFrame.WarningFrame.WarningText.TextColor3 = Color3.fromRGB(255, 100, 100)
            task.wait(0.5)
            
            if not self.Blinking then break end
            
            self.WarningFrame.WarningFrame.BackgroundTransparency = 0.6
            self.WarningFrame.WarningFrame.WarningText.TextColor3 = Color3.fromRGB(255, 50, 50)
            task.wait(0.5)
        end
    end)
end

function HighPingWarning:StopBlinking()
    self.Blinking = false
    if self.WarningFrame then
        self.WarningFrame.Enabled = false
    end
end

function HighPingWarning:CheckPing()
    if not self.Enabled then return end
    
    local ping = LocalPlayer:GetAttribute("Ping") or 0
    local pingValue = math.floor(ping)
    
    if pingValue >= self.Threshold then
        if not self.WarningFrame then
            self:CreateWarningFrame()
        end
        self:StartBlinking()
        
        -- Update ping value in warning
        if self.WarningFrame and self.WarningFrame.WarningFrame then
            self.WarningFrame.WarningFrame.WarningText.Text = "PING TOO HIGH (" .. pingValue .. "ms)"
        end
    else
        self:StopBlinking()
    end
end

function HighPingWarning:Start()
    self:CreateWarningFrame()
    
    -- Check ping every second
    task.spawn(function()
        while task.wait(1) do
            if self.Enabled then
                self:CheckPing()
            end
        end
    end)
end

function HighPingWarning:Stop()
    self:StopBlinking()
    if self.WarningFrame then
        self.WarningFrame:Destroy()
        self.WarningFrame = nil
    end
end

-- Add toggle to ESPTab (add this in ESPTab section)
local highPingToggle = ESPTab:Toggle({
    Title = "High Ping Warning",
    Desc = "Shows warning when ping is too high (150+ ms)",
    Value = false,
    Callback = function(state)
        if state then
            HighPingWarning:Start()
            WindUI:Notify({
                Title = "High Ping Warning",
                Content = "High ping warning enabled",
                Duration = 2,
                Icon = "alert-triangle"
            })
        else
            HighPingWarning:Stop()
            WindUI:Notify({
                Title = "High Ping Warning",
                Content = "High ping warning disabled",
                Duration = 2,
                Icon = "alert-triangle-off"
            })
        end
    end
})
-- Opponent Block ESP System - FIXED
local BlockESP = {
    Enabled = false,
    BlockAnimationId = "rbxassetid://10470389827",
    BlockImageId = "rbxassetid://13180179085",
    Indicators = {},
    Connections = {}
}

function BlockESP:CreateBlockIndicator(character)
    if self.Indicators[character] then return self.Indicators[character] end
    
    local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
    if not torso then return nil end
    
    -- Create billboard
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "BlockIndicator"
    billboard.Adornee = torso
    billboard.Size = UDim2.new(4, 0, 4, 0)  -- Larger size for visibility
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)  -- Higher above character
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 200
    billboard.Parent = character
    
    -- Image label
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = "BlockIcon"
    imageLabel.Size = UDim2.new(1, 0, 1, 0)
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = self.BlockImageId
    imageLabel.ImageTransparency = 0.4
    imageLabel.Parent = billboard
    
    -- Pulsing effect
    task.spawn(function()
        while billboard and billboard.Parent and self.Enabled do
            for i = 0, 1, 0.1 do
                if not billboard or not billboard.Parent or not self.Enabled then break end
                local pulse = 0.4 + (math.sin(i * math.pi) * 0.3)
                imageLabel.ImageTransparency = pulse
                task.wait(0.05)
            end
        end
    end)
    
    self.Indicators[character] = billboard
    return billboard
end

function BlockESP:RemoveBlockIndicator(character)
    if self.Indicators[character] then
        self.Indicators[character]:Destroy()
        self.Indicators[character] = nil
    end
end

function BlockESP:SetupPlayer(player)
    if player == LocalPlayer then return end
    
    local charAddedConn = player.CharacterAdded:Connect(function(character)
        task.wait(1)
        
        local humanoid = character:WaitForChild("Humanoid", 3)
        if not humanoid then return end
        
        -- Track animation playback
        local animationConn = humanoid.AnimationPlayed:Connect(function(track)
            if not self.Enabled then return end
            
            if track.Animation and track.Animation.AnimationId == self.BlockAnimationId then
                -- Create indicator
                local billboard = self:CreateBlockIndicator(character)
                
                -- Remove when animation stops
                track.Stopped:Connect(function()
                    if billboard and billboard.Parent then
                        self:RemoveBlockIndicator(character)
                    end
                end)
                
                -- Remove if character dies
                humanoid.Died:Connect(function()
                    self:RemoveBlockIndicator(character)
                end)
            end
        end)
        
        table.insert(self.Connections, animationConn)
        
        -- Check existing animations
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            if track.Animation and track.Animation.AnimationId == self.BlockAnimationId then
                self:CreateBlockIndicator(character)
            end
        end
    end)
    
    table.insert(self.Connections, charAddedConn)
    
    -- Setup existing character
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            local animationConn = humanoid.AnimationPlayed:Connect(function(track)
                if not self.Enabled then return end
                
                if track.Animation and track.Animation.AnimationId == self.BlockAnimationId then
                    local billboard = self:CreateBlockIndicator(player.Character)
                    
                    if billboard then
                        track.Stopped:Connect(function()
                            self:RemoveBlockIndicator(player.Character)
                        end)
                    end
                end
            end)
            
            table.insert(self.Connections, animationConn)
            
            -- Check existing animations
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation and track.Animation.AnimationId == self.BlockAnimationId then
                    self:CreateBlockIndicator(player.Character)
                end
            end
        end
    end
end

function BlockESP:Start()
    if self.Enabled then return end
    
    self.Enabled = true
    
    -- Setup all players
    for _, player in ipairs(Players:GetPlayers()) do
        self:SetupPlayer(player)
    end
    
    -- Setup for new players
    local playerAddedConn = Players.PlayerAdded:Connect(function(player)
        self:SetupPlayer(player)
    end)
    
    table.insert(self.Connections, playerAddedConn)
    
    WindUI:Notify({
        Title = "Opponent Block ESP",
        Content = "Block indicator ESP activated",
        Duration = 2,
        Icon = "shield"
    })
end

function BlockESP:Stop()
    if not self.Enabled then return end
    
    self.Enabled = false
    
    -- Remove all indicators
    for character, indicator in pairs(self.Indicators) do
        if indicator and indicator.Parent then
            indicator:Destroy()
        end
    end
    self.Indicators = {}
    
    -- Disconnect all connections
    for _, conn in ipairs(self.Connections) do
        if conn then
            pcall(function() conn:Disconnect() end)
        end
    end
    self.Connections = {}
    
    WindUI:Notify({
        Title = "Opponent Block ESP",
        Content = "Block indicator ESP deactivated",
        Duration = 2,
        Icon = "shield-off"
    })
  end
local blockESPToggle = ESPTab:Toggle({
    Title = "Opponent Block ESP",
    Desc = "Shows indicator when enemies use block animation",
    Value = false,
    Callback = function(state)
        if state then
            BlockESP:Start()
        else
            BlockESP:Stop()
        end
    end
})

    -- Death Counter ESP System
    local DeathCounterESP = {
        Enabled = false,
        State = {},
        Billboards = {},
        Connections = {}
    }
    
    local strongSkills = {
        ["Omni Directional Punch"] = true,
        ["Death Counter"] = true,
        ["Serious Punch"] = true,
        ["Table Flip"] = true
    }
    
    local weakSkills = {
        ["Consecutive Punches"] = true,
        ["Normal Punch"] = true,
        ["Shove"] = true,
        ["Uppercut"] = true
    }
    
    function DeathCounterESP:GetSkillType(backpack)
        for _, tool in ipairs(backpack:GetChildren()) do
            if strongSkills[tool.Name] then return "strong" end
            if weakSkills[tool.Name] then return "weak" end
        end
        return nil
    end
    
    function DeathCounterESP:CreateBillboard(target, text)
        if not (target and target:FindFirstChild("Head")) then return end
        
        local bb = target.Head:FindFirstChild("SkillTag") or Instance.new("BillboardGui")
        bb.Name = "SkillTag"
        bb.Size = UDim2.new(0, 100, 0, 40)
        bb.StudsOffset = Vector3.new(0, 2.5, 0)
        bb.Adornee = target.Head
        bb.AlwaysOnTop = true
        if not bb.Parent then bb.Parent = target.Head end

        local label = bb:FindFirstChild("TextLabel") or Instance.new("TextLabel", bb)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamBold
        label.TextScaled = true
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextStrokeTransparency = 0.5
        label.Text = text
        
        self.Billboards[target] = bb
    end
    
    function DeathCounterESP:RemoveBillboard(target)
        if target and target:FindFirstChild("Head") and target.Head:FindFirstChild("SkillTag") then
            target.Head.SkillTag:Destroy()
            self.Billboards[target] = nil
        end
    end
    
    function DeathCounterESP:Start()
        if self.Enabled then return end
        
        self.Enabled = true
        
        local heartbeatConn = RunService.Heartbeat:Connect(function()
            if not self.Enabled then return end
            
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    local char = plr.Character
                    local backpack = plr:FindFirstChildOfClass("Backpack")
                    
                    if char and backpack then
                        local skillType = self:GetSkillType(backpack)
                        local lastState = self.State[plr]

                        if not lastState then
                            self.State[plr] = skillType
                            if skillType == "strong" then
                                self:CreateBillboard(char, "💥") -- Ultimate indicator
                            else
                                self:RemoveBillboard(char)
                            end
                        else
                            if skillType == "strong" then
                                if lastState ~= "strong" then
                                    self:CreateBillboard(char, "💢")
                                end
                                self.State[plr] = "strong"
                            elseif skillType == "weak" and lastState == "strong" then
                                self:CreateBillboard(char, "⚠️") -- Death Counter indicator
                                self.State[plr] = "weak"
                                task.delay(math.random(8, 9), function()
                                    if self.State[plr] == "weak" then
                                        self:RemoveBillboard(char)
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        end)
        
        table.insert(self.Connections, heartbeatConn)
    end
    
    function DeathCounterESP:Stop()
        if not self.Enabled then return end
        
        self.Enabled = false
        
        -- Remove all billboards
        for target, _ in pairs(self.Billboards) do
            self:RemoveBillboard(target)
        end
        
        -- Disconnect all connections
        for _, conn in ipairs(self.Connections) do
            conn:Disconnect()
        end
        self.Connections = {}
        self.State = {}
        self.Billboards = {}
    end
    
    local deathCounterESPToggle = ESPTab:Toggle({
        Title = "Death Counter ESP",
        Desc = "⚠️ = Death Counter, 💥 = Ultimate\nShows enemy skill indicators above their heads",
        Value = ConfigManager:Get("DeathCounterESPEnabled"),
        Callback = function(state)
            ConfigManager:Set("DeathCounterESPEnabled", state)
            if state then
                DeathCounterESP:Start()
                WindUI:Notify({
                    Title = "Death Counter ESP",
                    Content = "Death Counter ESP activated",
                    Duration = 2,
                    Icon = "skull"
                })
            else
                DeathCounterESP:Stop()
                WindUI:Notify({
                    Title = "Death Counter ESP",
                    Content = "Death Counter ESP deactivated",
                    Duration = 2,
                    Icon = "skull-off"
                })
            end
        end
    })
    
    -- Settings Tab Elements
    SettingsTab:Section({
        Title = "Settings Management",
        Desc = "Save and load your settings"
    })
    
    local saveButton = SettingsTab:Button({
        Title = "Save Configuration",
        Desc = "Save current settings to file",
        Callback = function()
            ConfigManager:Save()
            WindUI:Notify({
                Title = "Success",
                Content = "Configuration saved successfully!",
                Duration = 3,
                Icon = "check"
            })
        end
    })
    
    local loadButton = SettingsTab:Button({
        Title = "Load Defaults",
        Desc = "Reset all settings to default values",
        Callback = function()
            for key, value in pairs(defaultConfig) do
                ConfigManager:Set(key, value)
            end
            
            -- Update UI elements
            autoBlockToggle:SetValue(defaultConfig.AutoBlockEnabled)
            m1AfterBlockToggle:SetValue(defaultConfig.M1AfterBlockEnabled)
            closeRangeSlider:SetValue(defaultConfig.AutoBlockCloseRange)
            longRangeSlider:SetValue(defaultConfig.AutoBlockLongRange)
            camlockToggle:SetValue(defaultConfig.CamlockEnabled)
            mobileCamlockToggle:SetValue(defaultConfig.MobileCamlockButton)
            counterESPToggle:SetValue(defaultConfig.CounterESPEnabled)
            deathCounterESPToggle:SetValue(defaultConfig.DeathCounterESPEnabled)
            keybindButton:SetTitle("Change Keybind (Currently: " .. defaultConfig.CamlockKeybind .. ")")
            
            -- Restart systems with new settings
            if AutoBlock.Enabled then
                AutoBlock:Stop()
                AutoBlock:Start()
            end
            
            if Camlock.Enabled then
                Camlock:Stop()
            end
            
            if CounterESP.Enabled then
                CounterESP:Stop()
            end
            
            if DeathCounterESP.Enabled then
                DeathCounterESP:Stop()
            end
            
            if Camlock.MobileButton and not defaultConfig.MobileCamlockButton then
                Camlock:RemoveMobileButton()
            elseif not Camlock.MobileButton and defaultConfig.MobileCamlockButton then
                Camlock:CreateMobileButton()
            end
            
            -- Re-setup keybind
            Camlock:SetupKeybind()
            
            WindUI:Notify({
                Title = "Success",
                Content = "Default settings loaded!",
                Duration = 3,
                Icon = "check"
            })
        end
    })
    
    local testButton = SettingsTab:Button({
        Title = "Test Auto Block",
        Desc = "Manually test the auto block system",
        Callback = function()
            if not AutoBlock.Enabled then
                WindUI:Notify({
                    Title = "Test Failed",
                    Content = "Please enable Auto Block first!",
                    Duration = 3,
                    Icon = "alert-triangle"
                })
                return
            end
            
            WindUI:Notify({
                Title = "Test Active",
                Content = "Auto Block is active. Try attacking with an enemy character.",
                Duration = 5,
                Icon = "shield"
            })
        end
    })
    
    -- About Tab Elements
    AboutTab:Section({
        Title = "About Combat UI",
        Desc = "Information about this script"
    })
    
    AboutTab:Paragraph({
        Title = "Version Information",
        Desc = "Combat UI v1.0\nCreated for The Strongest Battlegrounds\nAuthor: Waspire"
    })
    
    AboutTab:Paragraph({
        Title = "Features",
        Desc = "• Advanced Auto Block system\n• Camlock with mobile button\n• Counter ESP detection\n• Death Counter ESP\n• M1 After Block feature\n• Configurable detection ranges\n• Settings persistence\n• Clean, modern UI"
    })
    
    AboutTab:Paragraph({
        Title = "Instructions",
        Desc = "1. Enable Auto Block in Combat tab\n2. Configure ESP in ESP tab\n3. Set up Camlock in Camlock tab\n4. Save your preferred settings"
    })
    
    AboutTab:Button({
        Title = "YouTube Channel",
        Desc = "Visit Waspire's YouTube channel",
        Callback = function()
            setclipboard("https://youtube.com/@waspire")
            WindUI:Notify({
                Title = "YouTube",
                Content = "Link copied to clipboard!",
                Duration = 3,
                Icon = "youtube"
            })
        end
    })
    
    AboutTab:Button({
        Title = "Discord Server",
        Desc = "Join the community Discord",
        Callback = function()
            setclipboard("https://discord.gg/H2bURQxq3T")
            WindUI:Notify({
                Title = "Discord",
                Content = "Link copied to clipboard!",
                Duration = 3,
                Icon = "message-circle"
            })
        end
    })
    
    -- Initialize keybind
    Camlock:SetupKeybind()
    
    -- Escape key handler
    game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.Escape and Camlock.Enabled then
            Camlock:Stop()
            ConfigManager:Set("CamlockEnabled", false)
            if camlockToggle then
                camlockToggle:SetValue(false)
            end
        end
    end)
    
    -- Initialize based on saved state
    task.spawn(function()
        task.wait(1)
        
        -- Initialize auto block
        if ConfigManager:Get("AutoBlockEnabled") then
            AutoBlock:Start()
            WindUI:Notify({
                Title = "Auto Block",
                Content = "Auto Block system initialized from saved settings",
                Duration = 3,
                Icon = "check"
            })
        end
        
        -- Initialize camlock
        if ConfigManager:Get("CamlockEnabled") then
            local success = Camlock:Start()
            if not success then
                ConfigManager:Set("CamlockEnabled", false)
                if camlockToggle then
                    camlockToggle:SetValue(false)
                end
            end
        end
        
        -- Initialize mobile camlock button
        if ConfigManager:Get("MobileCamlockButton") then
            Camlock:CreateMobileButton()
        end
        
        -- Initialize Counter ESP
        if ConfigManager:Get("CounterESPEnabled") then
            CounterESP:Start()
        end
        -- Initialize Ping ESP if enabled
        if PingESP.Enabled then
            PingESP:Start()
        end
        -- Initialize High Ping Warning if enabled
        if HighPingWarning.Enabled then
            HighPingWarning:Start()
        end
        -- Initialize Block ESP if enabled
        if BlockESP.Enabled then
            BlockESP:Start()
        end
        -- Initialize Death Counter ESP
        if ConfigManager:Get("DeathCounterESPEnabled") then
            DeathCounterESP:Start()
        end
    end)
    
    -- Add custom UI elements to window (v1.0 label and social icons)
    local function addCustomUIElements()
        task.wait(0.5)
        local coreGui = game:GetService("CoreGui")
        
        for _, gui in pairs(coreGui:GetChildren()) do
            if gui.Name == "WindUI" then
                local combatGUI = gui:FindFirstChild("CombatGUI")
                if combatGUI then
                    local titleBar = combatGUI:FindFirstChild("TitleBar")
                    if titleBar then
                        -- Add version label
                        local versionLabel = Instance.new("TextLabel")
                        versionLabel.Name = "VersionLabel"
                        versionLabel.Text = "v1.0"
                        versionLabel.TextColor3 = Color3.fromRGB(220, 50, 50)
                        versionLabel.Font = Enum.Font.GothamBold
                        versionLabel.TextSize = 12
                        versionLabel.BackgroundTransparency = 1
                        versionLabel.Size = UDim2.new(0, 40, 0, 20)
                        versionLabel.Position = UDim2.new(0, 100, 0, 10)
                        versionLabel.Parent = titleBar
                        
                        -- Add social icons container
                        local socialContainer = Instance.new("Frame")
                        socialContainer.Name = "SocialIcons"
                        socialContainer.BackgroundTransparency = 1
                        socialContainer.Size = UDim2.new(0, 70, 0, 30)
                        socialContainer.Position = UDim2.new(1, -80, 0, 5)
                        socialContainer.Parent = titleBar
                        
                        -- YouTube icon
                        local youtubeButton = Instance.new("ImageButton")
                        youtubeButton.Name = "YouTubeIcon"
                        youtubeButton.Image = "rbxassetid://108320733835485"
                        youtubeButton.BackgroundTransparency = 1
                        youtubeButton.Size = UDim2.new(0, 25, 0, 25)
                        youtubeButton.Position = UDim2.new(0, 0, 0, 2)
                        youtubeButton.Parent = socialContainer
                        
                        -- Discord icon
                        local discordButton = Instance.new("ImageButton")
                        discordButton.Name = "DiscordIcon"
                        discordButton.Image = "rbxassetid://119731774091515"
                        discordButton.BackgroundTransparency = 1
                        discordButton.Size = UDim2.new(0, 25, 0, 25)
                        discordButton.Position = UDim2.new(0, 35, 0, 2)
                        discordButton.Parent = socialContainer
                        
                        -- YouTube click event
                        youtubeButton.MouseButton1Click:Connect(function()
                            setclipboard("https://youtube.com/@waspire")
                            WindUI:Notify({
                                Title = "YouTube",
                                Content = "Link copied to clipboard: https://youtube.com/@waspire",
                                Duration = 3,
                                Icon = "youtube"
                            })
                        end)
                        
                        -- Discord click event
                        discordButton.MouseButton1Click:Connect(function()
                            setclipboard("https://discord.gg/H2bURQxq3T")
                            WindUI:Notify({
                                Title = "Discord",
                                Content = "Link copied to clipboard: https://discord.gg/H2bURQxq3T",
                                Duration = 3,
                                Icon = "message-circle"
                            })
                        end)
                        
                        -- Add hover effects
                        youtubeButton.MouseEnter:Connect(function()
                            youtubeButton.ImageColor3 = Color3.fromRGB(255, 50, 50)
                        end)
                        
                        youtubeButton.MouseLeave:Connect(function()
                            youtubeButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        end)
                        
                        discordButton.MouseEnter:Connect(function()
                            discordButton.ImageColor3 = Color3.fromRGB(88, 101, 242)
                        end)
                        
                        discordButton.MouseLeave:Connect(function()
                            discordButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
                        end)
                        
                        break
                    end
                end
            end
        end
    end
    
    -- Call the function to add custom UI
    task.spawn(addCustomUIElements)
    
    -- Initial notification
    task.wait(0.9)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Combat UI v1.0",
        Text = "Waspire's Combat system loaded successfully!",
        Duration = 4,
    })
    
    Window:SelectTab(1)
    
else
    wait(0.1)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Combat UI - Error",
        Text = "This script only works in The Strongest Battlegrounds",
        Duration = 3,
    })
end
