-- Snippet 1/5: Configuration and Setup
if game.PlaceId == 10449761463 or game.PlaceId == 130818724007978 or game.PlaceId == 131048399685555 then
    local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    
    local ConfigManager = {}
    local configFile = "WaspireCombatUI.json"
    
    local defaultConfig = {
        AutoBlockEnabled = false,
        AutoBlockCloseRange = 14,
        AutoBlockLongRange = 35,
        M1AfterBlockRange = 10,  -- ADD THIS LINE
        CounterESPEnabled = false,
        CounterRange = 20,
        M1AfterBlockEnabled = false,
        CamlockEnabled = false,
        CamlockKeybind = "Q",
        MobileCamlockButton = false,
        DeathCounterESPEnabled = false,
        PingESPEnabled = false,
        BlockESPEnabled = false,
        HighPingWarningEnabled = false,
        AutoToxicEnabled = false,
        AutoToxicMessage = "ez",
        AutoToxicRepeat = 1,
        AutoToxicCooldown = 1,
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
    
    local currentConfig = {}
    
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
        for key, value in pairs(defaultConfig) do
            currentConfig[key] = value
        end
        return false
    end
    
    function ConfigManager:Save()
        local success = pcall(function()
            writefile(configFile, game:GetService("HttpService"):JSONEncode(currentConfig))
        end)
        return success
    end
    
    function ConfigManager:Get(key)
        return currentConfig[key] or defaultConfig[key]
    end
    
    function ConfigManager:Set(key, value)
        currentConfig[key] = value
        self:Save()
    end
    
    ConfigManager:Load()
    
    local Window = WindUI:CreateWindow({
        Title = "Combat UI - Waspire",
        Icon = "rbxassetid://122251684068515",
        Author = "The Strongest Battlegrounds",
        Folder = "CombatGUI",
        Size = UDim2.fromOffset(620, 140),
        Transparent = false,
        Theme = "Crimson",
        BorderColor = Color3.fromHex("#DC143C"),
        Resizable = true,
        SideBarWidth = 135,
        HideSearchBar = true,
        ScrollBarEnabled = true,
        MinimizeEnabled = true,
        CloseEnabled = true,
    })
    
    Window:Tag({
        Title = "v1.0",
        Color = Color3.fromHex("#DC143C"),
        Radius = 13
    })
    
    Window:Tag({
        Title = "Premium",
        Icon = "star",
        Color = Color3.fromHex("#000000"),
        BorderColor = Color3.fromHex("#DC143C"),
        Radius = 10
    })
    
    Window:EditOpenButton({
        Title = "Open Combat UI - v1.0",
        Icon = "sword",
        CornerRadius = UDim.new(0,16),
        StrokeThickness = 2,
        Color = ColorSequence.new(
            Color3.fromHex("DC143C"),
            Color3.fromHex("FFFFFF")
        ),
        OnlyMobile = false,
        Enabled = true,
        Draggable = true,
    })

-- Snippet 2/5: AutoBlock Core Functions
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

function AutoBlock:Start()
    if self.Enabled then return end
    
    self.Enabled = true
    self.Blocking = false
        
    local heartbeatConn = RunService.Heartbeat:Connect(function()
        if not self.Enabled then return end
        
        local closeRange = ConfigManager:Get("AutoBlockCloseRange")
        local longRange = ConfigManager:Get("AutoBlockLongRange")
        local closeMoves = ConfigManager:Get("CloseRangeMoves")
        local longMoves = ConfigManager:Get("LongRangeMoves")
        local m1Range = ConfigManager:Get("M1AfterBlockRange")  -- ADD THIS
                
        local character = LocalPlayer.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        
        local characterPos = character.HumanoidRootPart.Position
        
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
        
        if closestClosePlayer and closestClosePlayer.Character and closestClosePlayer.Character:FindFirstChild("Humanoid") then
            local closeHumanoid = closestClosePlayer.Character.Humanoid
            if self:IsPlayingAnimation(closeHumanoid, closeMoves) and not self.Blocking then
                self.Blocking = true
                self:PressBlockKey()
                task.wait(0.15)
                self.Blocking = false
                self:ReleaseBlockKey()
                
                if ConfigManager:Get("M1AfterBlockEnabled") and closestCloseDistance <= m1Range then
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
    
    if self.Blocking then
        self:ReleaseBlockKey()
        self.Blocking = false
    end
    
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
-- Snippet 3/5: Camlock System with Fixed Mobile Button
local Camlock = {
    Enabled = false,
    Target = nil,
    TargetHighlight = nil,
    Connections = {},
    MobileButton = nil,
    MobileButtonFrame = nil,
    TargetDisplay = nil,
    ButtonState = "OFF",
    IsDead = false,
    LastToggleTime = 0,
    ToggleCooldown = 0.5,
    KeybindConnection = nil,
    InputService = game:GetService("UserInputService"),
    LastClickTime = 0,
    ClickCooldown = 0.3,
     -- ... existing properties ...
    IsDragging = false,
    DragStart = nil,
    StartPosition = nil
    Smoothness = 0.05  -- ADD THIS LINE HERE
}

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

function Camlock:RemoveTargetHighlight()
    if self.TargetHighlight then
        self.TargetHighlight:Destroy()
        self.TargetHighlight = nil
    end
end

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

function Camlock:CreateMobileButton()
    if self.MobileButton then 
        self.MobileButton.Enabled = true
        return 
    end

    -- Create the GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MobileCamlockButton"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.IgnoreGuiInset = true
    screenGui.Enabled = true
    
    local button = Instance.new("TextButton")
    button.Name = "CamlockButton"
    button.Text = "CAMLOCK " .. self.ButtonState
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.BackgroundColor3 = self.ButtonState == "ON" and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(0, 0, 0)
    button.BorderColor3 = Color3.fromRGB(255, 50, 50)
    button.BorderSizePixel = 2
    button.AutoButtonColor = false
    button.Size = UDim2.new(0, 120, 0, 40)
    button.Position = UDim2.new(1, -130, 0.5, -20)
    button.Visible = true
    button.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- Simple click handler (toggle camlock when clicked)
    button.MouseButton1Click:Connect(function()
        self:Toggle()
        -- Also update the PC toggle in WindUI if it exists
        if camlockToggle and typeof(camlockToggle.SetValue) == "function" then
            camlockToggle:SetValue(self.Enabled)
        end
    end)
    
    -- SIMPLIFIED DRAGGING - Works for both mouse and touch
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function updateInput(input)
        local delta = input.Position - dragStart
        local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                  startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        button.Position = newPos
    end
    
    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = button.Position
            
            -- Capture input for smooth dragging
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    button.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    -- Smooth dragging during render step
    local dragConnection
    dragConnection = RunService.RenderStepped:Connect(function()
        if dragging and dragInput then
            updateInput(dragInput)
        end
    end)
    
    -- Store connection for cleanup
    if not self.MobileConnections then
        self.MobileConnections = {}
    end
    table.insert(self.MobileConnections, dragConnection)
    
    self.MobileButton = screenGui
    screenGui.Parent = game:GetService("CoreGui")
    
    -- Update text immediately
    self:UpdateMobileButtonText()
end
-- Also update RemoveMobileButton to clean up mobile connections:
function Camlock:RemoveMobileButton()
    if self.MobileButton then
        -- Clean up mobile-specific connections
        if self.MobileConnections then
            for name, conn in pairs(self.MobileConnections) do
                if conn and conn.Connected then
                    pcall(function() conn:Disconnect() end)
                end
            end
            self.MobileConnections = {}
        end
        
        if self.MobileButton.Parent then
            self.MobileButton:Destroy()
        end
        self.MobileButton = nil
        self.MobileButtonFrame = nil
    end
end

function Camlock:SetupKeybind()
    if self.KeybindConnection then
        self.KeybindConnection:Disconnect()
    end
    
    self.KeybindConnection = self.InputService.InputBegan:Connect(function(input, processed)
        if processed then
            return
        end
        
        if input.KeyCode.Name == ConfigManager:Get("CamlockKeybind") then
            local currentTime = tick()
            if currentTime - self.LastToggleTime < self.ToggleCooldown then
                return
            end
            
            self.LastToggleTime = currentTime
            self:Toggle()
        end
    end)
end

function Camlock:Toggle()
    local currentTime = tick()
    if currentTime - self.LastToggleTime < self.ToggleCooldown then
        return
    end
    
    self.LastToggleTime = currentTime
    
    if self.Enabled then
        self:Stop()
    else
        self:Start()
    end
    
    self:UpdateMobileButtonText()
    
    return self.Enabled
end

function Camlock:UpdateMobileButtonText()
    if self.MobileButton and self.MobileButton:FindFirstChild("CamlockButton") then
        local button = self.MobileButton.CamlockButton
        self.ButtonState = self.Enabled and "ON" or "OFF"
        button.Text = "CAMLOCK " .. self.ButtonState
        button.BackgroundColor3 = self.Enabled and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(0, 0, 0)
    end
end

local character = self.Target.Character
if character and character:FindFirstChild("HumanoidRootPart") then
    local camera = workspace.CurrentCamera
    local targetPosition = character.HumanoidRootPart.Position
    
    -- Use the smoothness variable
    local smoothness = self.Smoothness or 0.05
    
    -- Calculate smoothed camera position
    local currentCFrame = camera.CFrame
    local targetCFrame = CFrame.new(currentCFrame.Position, targetPosition)
    local smoothedCFrame = currentCFrame:Lerp(targetCFrame, smoothness)
    
    camera.CFrame = smoothedCFrame
end
    
    table.insert(self.Connections, renderStepConn)
    
    WindUI:Notify({
        Title = "Camlock",
        Content = "Camlock enabled on " .. self.Target.Name,
        Duration = 2,
        Icon = "crosshair"
    })
    
    self:UpdateMobileButtonText()
    return true
end
    
function Camlock:Stop()
    if not self.Enabled then return end
    
    self.Enabled = false
    self.Target = nil
    self:RemoveTargetHighlight()
    
    for _, conn in ipairs(self.Connections) do
        conn:Disconnect()
    end
    self.Connections = {}
    
    WindUI:Notify({
        Title = "Camlock",
        Content = "Camlock disabled",
        Duration = 2,
        Icon = "crosshair-off"
    })
    
    self:UpdateMobileButtonText()
end
-- Target Info Display System
local TargetInfo = {
    Enabled = false,
    InfoFrame = nil,
    Connection = nil
}

function TargetInfo:CreateInfoFrame()
    if self.InfoFrame then return end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CamlockTargetInfo"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local frame = Instance.new("Frame")
    frame.Name = "TargetInfoFrame"
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BackgroundTransparency = 0.2
    frame.Size = UDim2.new(0, 250, 0, 100)
    frame.Position = UDim2.new(0.5, -125, 0, 10)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 50, 50)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Text = "LOCKED TARGET"
    title.TextColor3 = Color3.fromRGB(255, 100, 100)
    title.TextSize = 16
    title.Font = Enum.Font.GothamBold
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, 0, 0, 25)
    title.Position = UDim2.new(0, 0, 0, 5)
    title.Parent = frame
    
    -- Player Name
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "PlayerName"
    nameLabel.Text = "Player: None"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(1, -10, 0, 20)
    nameLabel.Position = UDim2.new(0, 10, 0, 30)
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = frame
    
    -- Health
    local healthLabel = Instance.new("TextLabel")
    healthLabel.Name = "Health"
    healthLabel.Text = "Health: 100/100"
    healthLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    healthLabel.TextSize = 14
    healthLabel.Font = Enum.Font.Gotham
    healthLabel.BackgroundTransparency = 1
    healthLabel.Size = UDim2.new(1, -10, 0, 20)
    healthLabel.Position = UDim2.new(0, 10, 0, 50)
    healthLabel.TextXAlignment = Enum.TextXAlignment.Left
    healthLabel.Parent = frame
    
    -- Distance
    local distanceLabel = Instance.new("TextLabel")
    distanceLabel.Name = "Distance"
    distanceLabel.Text = "Distance: 0 studs"
    distanceLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
    distanceLabel.TextSize = 14
    distanceLabel.Font = Enum.Font.Gotham
    distanceLabel.BackgroundTransparency = 1
    distanceLabel.Size = UDim2.new(1, -10, 0, 20)
    distanceLabel.Position = UDim2.new(0, 10, 0, 70)
    distanceLabel.TextXAlignment = Enum.TextXAlignment.Left
    distanceLabel.Parent = frame
    
    screenGui.Parent = game:GetService("CoreGui")
    self.InfoFrame = screenGui
    
    -- Start hidden
    frame.Visible = false
end

function TargetInfo:UpdateInfo(target)
    if not self.Enabled or not self.InfoFrame then return end
    
    local frame = self.InfoFrame:FindFirstChild("TargetInfoFrame")
    if not frame then return end
    
    if not target or not target.Character then
        frame.Visible = false
        return
    end
    
    local character = target.Character
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local localRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then
        frame.Visible = false
        return
    end
    
    frame.Visible = true
    
    -- Update player name
    local nameLabel = frame:FindFirstChild("PlayerName")
    if nameLabel then
        nameLabel.Text = "Player: " .. target.Name
    end
    
    -- Update health
    local healthLabel = frame:FindFirstChild("Health")
    if healthLabel then
        local health = math.floor(humanoid.Health)
        local maxHealth = math.floor(humanoid.MaxHealth)
        healthLabel.Text = "Health: " .. health .. "/" .. maxHealth
        
        -- Color based on health percentage
        local healthPercent = health / maxHealth
        if healthPercent > 0.5 then
            healthLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        elseif healthPercent > 0.25 then
            healthLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
        else
            healthLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end
    
    -- Update distance
    local distanceLabel = frame:FindFirstChild("Distance")
    if distanceLabel and localRootPart then
        local distance = math.floor((rootPart.Position - localRootPart.Position).Magnitude)
        distanceLabel.Text = "Distance: " .. distance .. " studs"
    end
end

function TargetInfo:Start()
    if self.Enabled then return end
    
    self.Enabled = true
    self:CreateInfoFrame()
    
    -- Update target info in render loop
    self.Connection = RunService.RenderStepped:Connect(function()
        if Camlock.Enabled and Camlock.Target then
            self:UpdateInfo(Camlock.Target)
        elseif self.InfoFrame then
            local frame = self.InfoFrame:FindFirstChild("TargetInfoFrame")
            if frame then
                frame.Visible = false
            end
        end
    end)
end

function TargetInfo:Stop()
    if not self.Enabled then return end
    
    self.Enabled = false
    
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
    
    if self.InfoFrame then
        local frame = self.InfoFrame:FindFirstChild("TargetInfoFrame")
        if frame then
            frame.Visible = false
        end
    end
end
-- Snippet 4/5: UI Setup and Systems
-- Snippet 4/5: UI Setup and Systems
    local InfoTab = Window:Tab({
        Title = "Info",
        Icon = "book",
        Locked = false,
    })
    
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
    
    local UtilityTab = Window:Tab({
        Title = "Utility",
        Icon = "pickaxe",
        Locked = false,
    })
    
    local SettingsTab = Window:Tab({
        Title = "Settings",
        Icon = "settings",
        Locked = false,
    })

    -- Info Tab Content
    InfoTab:Section({
        Title = "Live Server Statistics",
        Desc = "Real-time game server information"
    })

    local serverStatsLabel = InfoTab:Paragraph({
        Title = "Server Status",
        Desc = "Loading server stats..."
    })

    InfoTab:Button({
        Title = "Copy Server Info",
        Desc = "Copy current server statistics to clipboard",
        Callback = function()
            local totalPlayers = #Players:GetPlayers()
            local serverSize = game.PlaceId == 10449761463 and 20 or 15
            local text = string.format("Server: %d/%d players online", totalPlayers, serverSize)
            setclipboard(text)
            WindUI:Notify({
                Title = "Server Info",
                Content = "Server information copied to clipboard!",
                Duration = 2,
                Icon = "clipboard"
            })
        end
    })
    InfoTab:Button({
    Title = "Refresh Stats",
    Desc = "Manually refresh server and Discord statistics",
    Callback = function()
        -- Update server stats
        local totalPlayers = #Players:GetPlayers()
        local serverSize = game.PlaceId == 10449761463 and 20 or 15
        local serverText = string.format("Players: %d/%d\nStatus: LIVE", totalPlayers, serverSize)
        
        if serverStatsLabel and typeof(serverStatsLabel.SetDescription) == "function" then
            serverStatsLabel:SetDescription(serverText)
        end
        
        -- Update Discord stats
        local discordData = getDiscordStats()
        local discordText = string.format("Members: %d+\nOnline: %d+", discordData.members, discordData.online)
        
        if discordStatsLabel and typeof(discordStatsLabel.SetDescription) == "function" then
            discordStatsLabel:SetDescription(discordText)
        end
        
        WindUI:Notify({
            Title = "Stats Refreshed",
            Content = "Server statistics updated",
            Duration = 2,
            Icon = "refresh-cw"
        })
    end
})
    InfoTab:Section({
        Title = "Discord Community",
        Desc = "Our Discord server statistics"
    })

    local discordStatsLabel = InfoTab:Paragraph({
        Title = "Discord Stats",
        Desc = "Members: 32100\nOnline: 4000"
    })

    InfoTab:Button({
        Title = "Copy Discord Link",
        Desc = "Copy Discord invite link to clipboard",
        Callback = function()
            setclipboard("https://discord.gg/H2bURQxq3T")
            WindUI:Notify({
                Title = "Discord",
                Content = "Discord link copied to clipboard!",
                Duration = 2,
                Icon = "message-circle"
            })
        end
    })

    InfoTab:Section({
        Title = "YouTube Channel",
        Desc = "Waspire's YouTube statistics"
    })

    local youtubeStatsLabel = InfoTab:Paragraph({
        Title = "YouTube Stats",
        Desc = "Subscribers: 25,600"
    })

    InfoTab:Button({
        Title = "Copy YouTube Link",
        Desc = "Copy YouTube channel link to clipboard",
        Callback = function()
            setclipboard("https://youtube.com/@waspire")
            WindUI:Notify({
                Title = "YouTube",
                Content = "YouTube link copied to clipboard!",
                Duration = 2,
                Icon = "youtube"
            })
        end
    })

    InfoTab:Section({
        Title = "Script Information",
        Desc = "Script details and features"
    })

    InfoTab:Paragraph({
        Title = "Script Details",
        Desc = "Version: v1.0\nCreator: Waspire\nGame: The Strongest Battlegrounds\nStatus: Premium"
    })

    InfoTab:Paragraph({
        Title = "Main Features",
        Desc = "Auto Block System\nCamlock with Mobile Support\nCounter ESP Detection\nDeath Counter ESP\nAuto Toxic Messages\nPing Display ESP\nBlock ESP Indicators\nHigh Ping Warning"
    })

    -- Replace the entire fetchDiscordStats function and update loop with this:

-- Simple function to get Discord stats (no HTTP calls)
-- Simple function to get Discord stats (no HTTP calls)
local function getDiscordStats()
    -- Return static values since HTTP may be blocked
    return {
        members = 32100,
        online = 4000
    }
end

-- Update statistics in real-time - SIMPLIFIED
task.spawn(function()
    while true do
        pcall(function()
            -- Update server stats
            local totalPlayers = #Players:GetPlayers()
            local serverSize = game.PlaceId == 10449761463 and 20 or 15
            local serverText = string.format("Players: %d/%d\nStatus: LIVE", totalPlayers, serverSize)
            
            if serverStatsLabel and typeof(serverStatsLabel.SetDescription) == "function" then
                serverStatsLabel:SetDescription(serverText)
            end
            
            -- Update Discord stats (cached values)
            local discordData = getDiscordStats()
            local discordText = string.format("Members: %d+\nOnline: %d+", discordData.members, discordData.online)
            
            if discordStatsLabel and typeof(discordStatsLabel.SetDescription) == "function" then
                discordStatsLabel:SetDescription(discordText)
            end
            
            -- Update YouTube stats
            if youtubeStatsLabel and typeof(youtubeStatsLabel.SetDescription) == "function" then
                youtubeStatsLabel:SetDescription("Subscribers: 25,600")
            end
        end)
        task.wait(5) -- Check every 5 seconds
    end
end)

-- Initialize immediately
task.spawn(function()
    task.wait(2) -- Wait for UI to load
    pcall(function()
        local totalPlayers = #Players:GetPlayers()
        local serverSize = game.PlaceId == 10449761463 and 20 or 15
        local serverText = string.format("Players: %d/%d\nStatus: LIVE", totalPlayers, serverSize)
        
        if serverStatsLabel and typeof(serverStatsLabel.SetDescription) == "function" then
            serverStatsLabel:SetDescription(serverText)
        end
        
        -- Initialize Discord stats
        local discordData = getDiscordStats()
        local discordText = string.format("Members: %d+\nOnline: %d+", discordData.members, discordData.online)
        
        if discordStatsLabel and typeof(discordStatsLabel.SetDescription) == "function" then
            discordStatsLabel:SetDescription(discordText)
        end
        
        -- Initialize YouTube stats
        if youtubeStatsLabel and typeof(youtubeStatsLabel.SetDescription) == "function" then
            youtubeStatsLabel:SetDescription("Subscribers: 25,600")
        end
    end)
end)
        
    -- Fixed Auto Toxic System
    local AutoToxic = {
        Enabled = false,
        Message = ConfigManager:Get("AutoToxicMessage"),
        RepeatCount = ConfigManager:Get("AutoToxicRepeat"),
        Cooldown = ConfigManager:Get("AutoToxicCooldown"),
        IsSending = false,
        LastKills = 0,
        Connection = nil
    }

    UtilityTab:Section({
        Title = "Auto Toxic System",
        Desc = "Automatically send messages when you get a kill"
    })

    local autoToxicToggle = UtilityTab:Toggle({
        Title = "Auto Toxic",
        Desc = "Enable automatic toxic messages on kill",
        Value = ConfigManager:Get("AutoToxicEnabled"),
        Callback = function(state)
            ConfigManager:Set("AutoToxicEnabled", state)
            if state then
                AutoToxic:Start()
            else
                AutoToxic:Stop()
            end
        end
    })

    local toxicMessageInput = UtilityTab:Input({
        Title = "Toxic Message",
        Desc = "Message to send when you get a kill",
        Value = AutoToxic.Message,
        InputIcon = "",
        Type = "Input",
        Placeholder = "Enter toxic message...",
        Callback = function(input)
            ConfigManager:Set("AutoToxicMessage", input)
            AutoToxic.Message = input
        end
    })

    local repeatSlider = UtilityTab:Slider({
        Title = "Repeat Count",
        Desc = "How many times to send the message",
        Value = {
            Min = 1,
            Max = 10,
            Default = ConfigManager:Get("AutoToxicRepeat"),
        },
        Callback = function(value)
            ConfigManager:Set("AutoToxicRepeat", tonumber(value))
            AutoToxic.RepeatCount = tonumber(value)
        end
    })

    local cooldownSlider = UtilityTab:Slider({
        Title = "Cooldown (seconds)",
        Desc = "Time between repeated messages",
        Value = {
            Min = 0.5,
            Max = 5,
            Default = ConfigManager:Get("AutoToxicCooldown"),
        },
        Callback = function(value)
            ConfigManager:Set("AutoToxicCooldown", tonumber(value))
            AutoToxic.Cooldown = tonumber(value)
        end
    })

    function AutoToxic:SendMessages()
    if not self.Enabled or self.IsSending then return end
    self.IsSending = true
    
    for i = 1, self.RepeatCount do
        local success, errorMsg = pcall(function()
            -- Try the new TextChatService first
            local textChatService = game:GetService("TextChatService")
            if textChatService and textChatService:IsA("TextChatService") then
                local channel = textChatService.TextChannels:FindFirstChild("RBXGeneral")
                if channel then
                    channel:SendAsync(self.Message)
                    return true
                end
            end
            
            -- Fallback to old chat system
            local replicatedStorage = game:GetService("ReplicatedStorage")
            local chatEvents = replicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
            if chatEvents then
                local sayMessage = chatEvents:FindFirstChild("SayMessageRequest")
                if sayMessage then
                    sayMessage:FireServer(self.Message, "All")
                    return true
                end
            end
            
            return false
        end)
        
        if not success then
            WindUI:Notify({
                Title = "Auto Toxic Error",
                Content = "Failed to send message: " .. tostring(errorMsg),
                Duration = 2,
                Icon = "alert-triangle"
            })
            break
        end
        
        if i < self.RepeatCount then
            task.wait(self.Cooldown)
        end
    end
    
    self.IsSending = false
end

    function AutoToxic:Start()
        if self.Enabled then return end
        
        self.Enabled = true
        self.LastKills = 0
        
        -- Try to get kills from leaderstats
        local function monitorKills()
            local leaderstats = LocalPlayer:WaitForChild("leaderstats", 3)
            if leaderstats then
                local kills = leaderstats:WaitForChild("Kills", 3)
                if kills then
                    self.LastKills = kills.Value
                    
                    if self.Connection then
                        self.Connection:Disconnect()
                    end
                    
                    self.Connection = kills.Changed:Connect(function(newValue)
                        if not self.Enabled then return end
                        
                        if newValue > self.LastKills then
                            self:SendMessages()
                        end
                        self.LastKills = newValue
                    end)
                    
                    WindUI:Notify({
                        Title = "Auto Toxic",
                        Content = "Auto Toxic enabled! Messages will send on kills.",
                        Duration = 3,
                        Icon = "message-square"
                    })
                    return true
                end
            end
            return false
        end
        
        if not monitorKills() then
            WindUI:Notify({
                Title = "Auto Toxic",
                Content = "Auto Toxic enabled. Waiting for game stats...",
                Duration = 3,
                Icon = "message-square"
            })
            
            -- Try again after a delay
            task.delay(5, function()
                if self.Enabled and not self.Connection then
                    monitorKills()
                end
            end)
        end
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
    local m1RangeSlider = CombatTab:Slider({
    Title = "M1 After Block Range",
    Desc = "Maximum distance to M1 after blocking (studs)",
    Value = {
        Min = 5,
        Max = 30,
        Default = ConfigManager:Get("M1AfterBlockRange"),
    },
    Callback = function(value)
        ConfigManager:Set("M1AfterBlockRange", tonumber(value))
        WindUI:Notify({
            Title = "Settings Updated",
            Content = "M1 After Block range set to " .. value .. " studs",
            Duration = 2,
            Icon = "settings"
        })
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
        
        -- Update mobile button if it exists
        if Camlock.MobileButton then
            Camlock:UpdateMobileButtonText()
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
                Content = "Mobile camlock button added to screen\nDrag to move, click to toggle camlock",
                Duration = 3,
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

local targetInfoToggle = CamlockTab:Toggle({
    Title = "Target Info Display",
    Desc = "Show information about the locked target",
    Value = false,
    Callback = function(state)
        if state then
            TargetInfo:Start()
            WindUI:Notify({
                Title = "Target Info",
                Content = "Target info display enabled",
                Duration = 2,
                Icon = "info"
            })
        else
            TargetInfo:Stop()
            WindUI:Notify({
                Title = "Target Info",
                Content = "Target info display disabled",
                Duration = 2,
                Icon = "info-off"
            })
        end
    end
})

-- Add smoothness slider for camlock
local smoothnessSlider = CamlockTab:Slider({
    Title = "Camlock Smoothness",
    Desc = "How smooth the camera movement is (lower = snappier)",
    Value = {
        Min = 0.01,
        Max = 1.0,
        Default = 0.05,
    },
    Callback = function(value)
        Camlock.Smoothness = tonumber(value)
        WindUI:Notify({
            Title = "Camlock Settings",
            Content = "Camlock smoothness set to " .. string.format("%.2f", value),
            Duration = 2,
            Icon = "settings"
        })
    end
})

-- Initialize smoothness
Camlock.Smoothness = 0.01
-- Snippet 5/5: ESP Systems and Final Initialization
    -- ESP Tab Elements
    ESPTab:Section({
        Title = "ESP Systems",
        Desc = "Visual indicators utility"
    })
    
    -- Counter ESP System
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
            highlight.FillColor = Color3.fromRGB(100, 150, 255)
            highlight.OutlineColor = Color3.fromRGB(200, 220, 255)
            highlight.FillTransparency = 0.3
            highlight.OutlineTransparency = 0
            highlight.Parent = character
            self.Highlights[character] = highlight
        end
    end
    
    function CounterESP:RemoveHighlight(character, fade)
        local highlight = self.Highlights[character]
        if highlight then
            if fade then
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
                        self:AddHighlight(otherCharacter)
                        self.Timers[otherCharacter] = tick()
                        
                        game:GetService("StarterGui"):SetCore("SendNotification", {
                            Title = "Counter Detected!",
                            Text = player.Name .. " used a counter move",
                            Duration = 1.2,
                        })
                        
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
        
        for character, highlight in pairs(self.Highlights) do
            if highlight then
                self:RemoveHighlight(character, true)
            end
        end
        
        for _, conn in ipairs(self.Connections) do
            if conn then
                pcall(function() conn:Disconnect() end)
            end
        end
        self.Connections = {}
        self.Highlights = {}
        self.Timers = {}
    end
    
    local counterESPToggle = ESPTab:Toggle({
        Title = "Counter ESP",
        Desc = "Highlights enemies when they use counter.",
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
        bb.MaxDistance = 300
        bb.StudsOffset = Vector3.new(0, 3, 0)
        
        local label = Instance.new("TextLabel")
        label.Name = "PingLabel"
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamBold
        label.TextSize = 14
        label.TextStrokeTransparency = 0.5
        label.TextStrokeColor3 = Color3.new(0, 0, 0)
        label.Text = "0ms"
        label.Parent = bb
        
        return bb
    end
    
    function PingESP:UpdatePingColor(label, ping)
        ping = ping or 0
        
        if ping < 50 then
            label.TextColor3 = Color3.fromRGB(50, 255, 50)
        elseif ping < 150 then
            label.TextColor3 = Color3.fromRGB(255, 255, 50)
        else
            label.TextColor3 = Color3.fromRGB(255, 50, 50)
        end
    end
    
    function PingESP:Start()
        if self.Enabled then return end
        
        self.Enabled = true
        
        self.GuiFolder = Instance.new("Folder")
        self.GuiFolder.Name = "PingESP"
        self.GuiFolder.Parent = game:GetService("CoreGui")
        
        for _, player in ipairs(Players:GetPlayers()) do
            self:SetupPlayer(player)
        end
        
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
                    
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid and humanoid.Health <= 0 then
                        label.TextColor3 = Color3.fromRGB(100, 100, 100)
                    end
                end
            else
                bb.Adornee = nil
            end
        end)
        
        local charAddedConn = player.CharacterAdded:Connect(function(character)
            task.wait(1)
            if self.Enabled and bb and bb.Parent then
                local rootPart = character:WaitForChild("HumanoidRootPart", 3)
                if rootPart then
                    bb.Adornee = rootPart
                end
            end
        end)
        
        table.insert(self.Connections, heartbeatConn)
        table.insert(self.Connections, charAddedConn)
    end
    
    function PingESP:Stop()
        if not self.Enabled then return end
        
        self.Enabled = false
        
        if self.GuiFolder then
            self.GuiFolder:Destroy()
            self.GuiFolder = nil
        end
        
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
        Desc = "Shows player ping above their heads.",
        Value = ConfigManager:Get("PingESPEnabled"),
        Callback = function(state)
            ConfigManager:Set("PingESPEnabled", state)
            if state then
                PingESP:Start()
            else
                PingESP:Stop()
            end
        end
    })

    -- Fixed High Ping Warning System
    -- REPLACE the entire HighPingWarning system with this:
local HighPingWarning = {
    Enabled = false,
    Threshold = 105,  -- Changed from 150 to 105
    WarningFrame = nil,
    Blinking = false,
    Connection = nil,
    LastPingCheck = 0,
    PingCheckInterval = 1  -- Check every second
}

function HighPingWarning:CreateWarningFrame()
    if self.WarningFrame then return end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HighPingWarning"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local frame = Instance.new("Frame")
    frame.Name = "WarningFrame"
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BackgroundTransparency = 0.3
    frame.Size = UDim2.new(0, 300, 0, 80)
    frame.Position = UDim2.new(0.5, -150, 0.8, 0)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 50, 50)
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local warningIcon = Instance.new("TextLabel")
    warningIcon.Name = "WarningIcon"
    warningIcon.Text = "⚠"
    warningIcon.TextSize = 24
    warningIcon.TextColor3 = Color3.fromRGB(255, 100, 100)
    warningIcon.BackgroundTransparency = 1
    warningIcon.Size = UDim2.new(0, 40, 0, 40)
    warningIcon.Position = UDim2.new(0, 10, 0.5, -20)
    warningIcon.Font = Enum.Font.GothamBold
    warningIcon.Parent = frame
    
    local warningText = Instance.new("TextLabel")
    warningText.Name = "WarningText"
    warningText.Text = "HIGH PING"
    warningText.TextSize = 18
    warningText.TextColor3 = Color3.fromRGB(255, 100, 100)
    warningText.BackgroundTransparency = 1
    warningText.Size = UDim2.new(1, -60, 0.5, 0)
    warningText.Position = UDim2.new(0, 50, 0, 10)
    warningText.Font = Enum.Font.GothamBold
    warningText.TextXAlignment = Enum.TextXAlignment.Left
    warningText.Parent = frame
    
    local subText = Instance.new("TextLabel")
    subText.Name = "SubText"
    subText.Text = "Ping is too high. Autoblock may not work."
    subText.TextSize = 14
    subText.TextColor3 = Color3.fromRGB(200, 200, 200)
    subText.BackgroundTransparency = 1
    subText.Size = UDim2.new(1, -60, 0.5, 0)
    subText.Position = UDim2.new(0, 50, 0.5, 0)
    subText.Font = Enum.Font.Gotham
    subText.TextXAlignment = Enum.TextXAlignment.Left
    subText.Parent = frame
    
    screenGui.Parent = game:GetService("CoreGui")
    self.WarningFrame = screenGui
    
    -- Start hidden
    frame.Visible = false
end

function HighPingWarning:CheckPing()
    if not self.Enabled then return end
    
    local currentTime = tick()
    if currentTime - self.LastPingCheck < self.PingCheckInterval then
        return
    end
    
    self.LastPingCheck = currentTime
    
    -- Get player ping
    local success, ping = pcall(function()
        return LocalPlayer:GetNetworkPing() * 1000  -- Convert to milliseconds
    end)
    
    if not success then
        ping = 0
    end
    
    local pingValue = math.floor(ping)
    
    if pingValue >= self.Threshold then
        if not self.Blinking then
            self.Blinking = true
            if self.WarningFrame and self.WarningFrame:FindFirstChild("WarningFrame") then
                local frame = self.WarningFrame.WarningFrame
                local warningText = frame:FindFirstChild("WarningText")
                if warningText then
                    warningText.Text = "HIGH PING (" .. pingValue .. "ms)"
                end
                frame.Visible = true
            end
        end
    else
        if self.Blinking then
            self.Blinking = false
            if self.WarningFrame and self.WarningFrame:FindFirstChild("WarningFrame") then
                self.WarningFrame.WarningFrame.Visible = false
            end
        end
    end
end

function HighPingWarning:Start()
    if self.Enabled then return end
    
    self.Enabled = true
    self:CreateWarningFrame()
    
    if self.Connection then
        self.Connection:Disconnect()
    end
    
    self.Connection = RunService.Heartbeat:Connect(function()
        self:CheckPing()
    end)
    
    WindUI:Notify({
        Title = "High Ping Warning",
        Content = "High ping warning enabled (105+ ms)",
        Duration = 2,
        Icon = "alert-triangle"
    })
end

function HighPingWarning:Stop()
    if not self.Enabled then return end
    
    self.Enabled = false
    self.Blinking = false
    
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
    
    if self.WarningFrame then
        self.WarningFrame:Destroy()
        self.WarningFrame = nil
    end
    
    WindUI:Notify({
        Title = "High Ping Warning",
        Content = "High ping warning disabled",
        Duration = 2,
        Icon = "alert-triangle-off"
    })
end

-- Update the toggle in ESPTab to set threshold to 105
local highPingToggle = ESPTab:Toggle({
    Title = "High Ping Warning",
    Desc = "Shows warning when ping is too high (105+ ms)",
    Value = ConfigManager:Get("HighPingWarningEnabled"),
    Callback = function(state)
        ConfigManager:Set("HighPingWarningEnabled", state)
        if state then
            HighPingWarning:Start()
        else
            HighPingWarning:Stop()
        end
    end
})

    -- Block ESP System
    local BlockESP = {
        Enabled = false,
        BlockAnimationId = "rbxassetid://10470389827",
        BlockImageId = "rbxassetid://13180179085",
        Indicators = {},
        Connections = {}
    }
    
    function BlockESP:CreateBlockIndicator(character)
    if self.Indicators[character] then return self.Indicators[character] end
    
    local head = character:FindFirstChild("Head")
    if not head then return nil end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "BlockIndicator"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 100, 0, 100)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = 200
    billboard.Parent = head
    
    local label = Instance.new("TextLabel")
    label.Name = "BlockIcon"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "🛡️"  -- Shield emoji
    label.TextColor3 = Color3.fromRGB(100, 150, 255)
    label.TextSize = 24
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard
    
    task.spawn(function()
        while billboard and billboard.Parent and self.Enabled do
            for i = 0, 1, 0.1 do
                if not billboard or not billboard.Parent or not self.Enabled then break end
                local alpha = 0.3 + (math.sin(i * math.pi) * 0.7)
                label.TextTransparency = alpha
                task.wait(0.05)
            end
        end
    end)
    
    self.Indicators[character] = billboard
    return billboard
endend
    
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
        
        local animationConn = humanoid.AnimationPlayed:Connect(function(track)
            if not self.Enabled then return end
            
            -- Check for block animation
            if track.Animation and track.Animation.AnimationId == self.BlockAnimationId then
                local billboard = self:CreateBlockIndicator(character)
                
                track.Stopped:Connect(function()
                    if billboard and billboard.Parent then
                        self:RemoveBlockIndicator(character)
                    end
                end)
                
                humanoid.Died:Connect(function()
                    self:RemoveBlockIndicator(character)
                end)
            end
        end)
        
        table.insert(self.Connections, animationConn)
        
        -- Check for already playing block animations
        for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
            if track.Animation and track.Animation.AnimationId == self.BlockAnimationId then
                self:CreateBlockIndicator(character)
            end
        end
    end)
    
    table.insert(self.Connections, charAddedConn)
    
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
            
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation and track.Animation.AnimationId == self.BlockAnimationId then
                    self:CreateBlockIndicator(player.Character)
                end
            end
        end
    end
end
            
            for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
                if track.Animation and track.Animation.AnimationId == self.BlockAnimationId then
                    self:CreateBlockIndicator(character)
                end
            end
        end)
        
        table.insert(self.Connections, charAddedConn)
        
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
        
        for _, player in ipairs(Players:GetPlayers()) do
            self:SetupPlayer(player)
        end
        
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
        
        for character, indicator in pairs(self.Indicators) do
            if indicator and indicator.Parent then
                indicator:Destroy()
            end
        end
        self.Indicators = {}
        
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
        Desc = "Shows indicator when enemies block.",
        Value = ConfigManager:Get("BlockESPEnabled"),
        Callback = function(state)
            ConfigManager:Set("BlockESPEnabled", state)
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
                                self:CreateBillboard(char, "💥")
                            else
                                self:RemoveBillboard(char)
                            end
                        else
                            if skillType == "strong" then
                                if lastState ~= "strong" then
                                    self:CreateBillboard(char, "💥")
                                end
                                self.State[plr] = "strong"
                            elseif skillType == "weak" and lastState == "strong" then
                                self:CreateBillboard(char, "💢")
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
        
        for target, _ in pairs(self.Billboards) do
            self:RemoveBillboard(target)
        end
        
        for _, conn in ipairs(self.Connections) do
            conn:Disconnect()
        end
        self.Connections = {}
        self.State = {}
        self.Billboards = {}
    end
    
    local deathCounterESPToggle = ESPTab:Toggle({
        Title = "Death Counter ESP",
        Desc = "Shows enemy skill indicators above their heads\n💢 = Death Counter\n💥 = Ultimate",
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
            
            autoBlockToggle:SetValue(defaultConfig.AutoBlockEnabled)
            m1AfterBlockToggle:SetValue(defaultConfig.M1AfterBlockEnabled)
            closeRangeSlider:SetValue(defaultConfig.AutoBlockCloseRange)
            longRangeSlider:SetValue(defaultConfig.AutoBlockLongRange)
            m1RangeSlider:SetValue(defaultConfig.M1AfterBlockRange)  -- ADD THIS LINE
            camlockToggle:SetValue(defaultConfig.CamlockEnabled)
            mobileCamlockToggle:SetValue(defaultConfig.MobileCamlockButton)
            counterESPToggle:SetValue(defaultConfig.CounterESPEnabled)
            deathCounterESPToggle:SetValue(defaultConfig.DeathCounterESPEnabled)
            pingESPToggle:SetValue(defaultConfig.PingESPEnabled)
            blockESPToggle:SetValue(defaultConfig.BlockESPEnabled)
            highPingToggle:SetValue(defaultConfig.HighPingWarningEnabled)
            autoToxicToggle:SetValue(defaultConfig.AutoToxicEnabled)
            toxicMessageInput:SetValue(defaultConfig.AutoToxicMessage)
            repeatSlider:SetValue(defaultConfig.AutoToxicRepeat)
            cooldownSlider:SetValue(defaultConfig.AutoToxicCooldown)
            keybindButton:SetTitle("Change Keybind (Currently: " .. defaultConfig.CamlockKeybind .. ")")
            
            if AutoBlock.Enabled then
                AutoBlock:Stop()
                if defaultConfig.AutoBlockEnabled then
                    AutoBlock:Start()
                end
            end
            
            if Camlock.Enabled then
                Camlock:Stop()
            end
         
            if Camlock.MobileButton and not defaultConfig.MobileCamlockButton then
                    Camlock:RemoveMobileButton()
                elseif not Camlock.MobileButton and defaultConfig.MobileCamlockButton then
                    -- Wait a bit then create
                    task.wait(0.1)
                    Camlock:CreateMobileButton()
                end
            if CounterESP.Enabled then
                CounterESP:Stop()
                if defaultConfig.CounterESPEnabled then
                    CounterESP:Start()
                end
            end
            
            if PingESP.Enabled then
                PingESP:Stop()
                if defaultConfig.PingESPEnabled then
                    PingESP:Start()
                end
            end
            
            if BlockESP.Enabled then
                BlockESP:Stop()
                if defaultConfig.BlockESPEnabled then
                    BlockESP:Start()
                end
            end
            
            if HighPingWarning.Enabled then
                HighPingWarning:Stop()
                if defaultConfig.HighPingWarningEnabled then
                    HighPingWarning:Start()
                end
            end
            
            if DeathCounterESP.Enabled then
                DeathCounterESP:Stop()
                if defaultConfig.DeathCounterESPEnabled then
                    DeathCounterESP:Start()
                end
            end
            
            if AutoToxic.Enabled then
                AutoToxic:Stop()
                if defaultConfig.AutoToxicEnabled then
                    AutoToxic:Start()
                end
            end
            
            if Camlock.MobileButton and not defaultConfig.MobileCamlockButton then
                Camlock:RemoveMobileButton()
            elseif not Camlock.MobileButton and defaultConfig.MobileCamlockButton then
                Camlock:CreateMobileButton()
            end
            
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
    -- Initialize all features based on saved state
task.spawn(function()
    task.wait(2) -- Wait for UI to fully load
    
    WindUI:Notify({
        Title = "Combat UI",
        Content = "Initializing features...",
        Duration = 2,
        Icon = "loader"
    })
    
    -- AutoBlock
    if ConfigManager:Get("AutoBlockEnabled") then
        AutoBlock:Start()
    end
    
    -- Camlock
    if ConfigManager:Get("CamlockEnabled") then
        local success = Camlock:Start()
        if not success then
            ConfigManager:Set("CamlockEnabled", false)
            if camlockToggle then
                camlockToggle:SetValue(false)
            end
        end
    end
    
    -- Mobile Camlock Button
    if ConfigManager:Get("MobileCamlockButton") then
        task.wait(0.5) -- Extra delay for mobile button
        Camlock:CreateMobileButton()
    end
    -- Target Info
    if targetInfoToggle then
        targetInfoToggle:SetValue(false)  -- Start disabled by default
    end
    -- Counter ESP
    if ConfigManager:Get("CounterESPEnabled") then
        CounterESP:Start()
    end
    
    -- Ping ESP
    if ConfigManager:Get("PingESPEnabled") then
        PingESP:Start()
    end
    
    -- Block ESP
    if ConfigManager:Get("BlockESPEnabled") then
        BlockESP:Start()
    end
    
    -- High Ping Warning
    if ConfigManager:Get("HighPingWarningEnabled") then
        HighPingWarning:Start()
    end
    
    -- Death Counter ESP
    if ConfigManager:Get("DeathCounterESPEnabled") then
        DeathCounterESP:Start()
    end
    
    -- Auto Toxic
    if ConfigManager:Get("AutoToxicEnabled") then
        AutoToxic:Start()
    end
    
    WindUI:Notify({
        Title = "Combat UI v1.0",
        Content = "All features initialized!",
        Duration = 3,
        Icon = "check"
    })
end)
    
    task.wait(1)
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
