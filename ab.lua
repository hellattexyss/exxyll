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
        CounterNotifierEnabled = false,
        CounterRange = 20, -- Hardcoded for counter detection
        M1AfterBlockEnabled = false,
        CamlockEnabled = false,
        CamlockKeybind = "Q",
        MobileCamlockButton = false,
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
    
    -- Create WindUI Window with Custom Title
    local Window = WindUI:CreateWindow({
        Title = "Combat UI - Waspire",
        Icon = "shield",
        Author = "The Strongest Battlegrounds",
        Folder = "CombatGUI",
        Size = UDim2.fromOffset(620, 140), -- Increased size
        Transparent = false,
        Theme = "Crimson",
        Resizable = true,
        SideBarWidth = 135,
        HideSearchBar = true,
        ScrollBarEnabled = true,
        MinimizeEnabled = true,
        CloseEnabled = true,
    })
    -- Add Version Tag (ADD THIS RIGHT HERE)
    Window:Tag({
        Title = "v1.0",
        Color = Color3.fromHex("#DC143C"),  -- Crimson red color
        Radius = 13
    })
    -- Add Premium Tag with Star Icon (ADD THIS)
    Window:Tag({
        Title = "Premium",
        Icon = "star",
        Color = Color3.fromHex("#000000"),  -- Black color
        BorderColor = Color3.fromHex("#DC143C"),  -- Crimson border
        Radius = 10
     })
    
-- Snippet 2/4: AutoBlock Core Functions
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

-- Counter Detection Functions from original script
function AutoBlock:AddCounterHighlight(character, color)
    if not self.CounterHighlights[character] then
        local highlight = Instance.new("Highlight")
        highlight.FillColor = color
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = character
        self.CounterHighlights[character] = highlight
    end
end

function AutoBlock:RemoveCounterHighlight(character)
    local highlight = self.CounterHighlights[character]
    if highlight then
        highlight:Destroy()
        self.CounterHighlights[character] = nil
    end
end

function AutoBlock:GetCounterAnimation(humanoid)
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

function AutoBlock:CheckCounterMoves()
    if not ConfigManager:Get("CounterNotifierEnabled") then return end
    
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
                if counterAnimation then
                    local currentTime = tick()
                    if not self.CounterNotifierCooldowns[player] or 5 < currentTime - self.CounterNotifierCooldowns[player] then
                        self.CounterNotifierCooldowns[player] = currentTime
                        local highlightColor = counterAnimation == ConfigManager:Get("WhiteCounterAnimation") and 
                            Color3.fromRGB(240, 240, 240) or Color3.fromRGB(0, 0, 254)
                        
                        self:AddCounterHighlight(otherCharacter, highlightColor)
                        
                        game:GetService("StarterGui"):SetCore("SendNotification", {
                            Title = "Counter Detected!",
                            Text = player.Name .. " used a counter move",
                            Duration = 1.2,
                        })
                        
                        task.delay(17.5, function()
                            self:RemoveCounterHighlight(otherCharacter)
                            game:GetService("StarterGui"):SetCore("SendNotification", {
                                Title = "Counter Ended",
                                Text = player.Name .. "'s counter move cooldown has ended",
                                Duration = 2,
                            })
                        end)
                    end
                end
            end
        end
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
    
    -- Counter notifier heartbeat
    if ConfigManager:Get("CounterNotifierEnabled") then
        local counterConn = RunService.Heartbeat:Connect(function()
            self:CheckCounterMoves()
        end)
        table.insert(self.Connections, counterConn)
    end
end

function AutoBlock:Stop()
    if not self.Enabled then return end
    
    self.Enabled = false
    
    -- Release block key if holding
    if self.Blocking then
        self:ReleaseBlockKey()
        self.Blocking = false
    end
    
    -- Clear all highlights
    for character, highlight in pairs(self.CounterHighlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    self.CounterHighlights = {}
    
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
-- Snippet 3/4: Camlock System with Fixes
-- Camlock System
local Camlock = {
    Enabled = false,
    Target = nil,
    TargetHighlight = nil,
    Connections = {},
    MobileButton = nil,
    TargetDisplay = nil,
    ButtonState = "OFF",  -- Track button state
    Locked = false,  -- Prevent accidental toggles
    LastToggleTime = 0,
    Cooldown = 0.5,  -- Cooldown between toggles
    InputConnections = {},  -- Separate storage for input connections
    IsDead = false  -- Track if local player is dead
}

-- Camlock Functions
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
                    local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
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
        -- Remove any existing highlights first
        if self.TargetHighlight then
            self.TargetHighlight:Destroy()
        end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "CamlockHighlight"
        highlight.FillColor = Color3.fromRGB(255, 50, 50) -- Red color
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.3
        highlight.OutlineTransparency = 0
        highlight.Parent = self.Target.Character
        self.TargetHighlight = highlight
        
        -- Listen for character removal
        local charConn
        charConn = self.Target.Character.AncestryChanged:Connect(function()
            if not self.Target.Character or not self.Target.Character.Parent then
                charConn:Disconnect()
                self:Stop()
            end
        end)
        
        table.insert(self.Connections, charConn)
    end
end

function Camlock:RemoveTargetHighlight()
    if self.TargetHighlight then
        self.TargetHighlight:Destroy()
        self.TargetHighlight = nil
    end
end

function Camlock:UpdateMobileButtonText()
    if self.MobileButton and self.MobileButton:FindFirstChild("CamlockButton") then
        local button = self.MobileButton.CamlockButton
        button.Text = "CAMLOCK " .. self.ButtonState
        -- Update button color based on state
        if self.ButtonState == "ON" then
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            button.BorderColor3 = Color3.fromRGB(255, 50, 50)
        else
            button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            button.BorderColor3 = Color3.fromRGB(255, 50, 50)
        end
    end
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
    
    -- Check if target is within reasonable distance
    local localChar = LocalPlayer.Character
    if not localChar or not localChar:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local distance = (localChar.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
    if distance > 500 then  -- Max lock distance
        return false
    end
    
    return true
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

function Camlock:Start(target)
    if self.Enabled then return end
    
    self.Enabled = true
    self.Locked = true  -- Prevent accidental toggles
    self.Target = target or self:FindClosestTarget()
    
    if not self.Target then
        self.Enabled = false
        self.Locked = false
        return
    end
    
    -- Reset death state
    self.IsDead = false
    
    -- Add red highlight to target
    self:AddTargetHighlight()
    
    -- Create target display
    if not self.TargetDisplay then
        self.TargetDisplay = Instance.new("ScreenGui")
        self.TargetDisplay.Name = "CamlockTargetDisplay"
        self.TargetDisplay.ResetOnSpawn = false
        self.TargetDisplay.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
        local frame = Instance.new("Frame")
        frame.Name = "TargetFrame"
        frame.BackgroundTransparency = 1
        frame.Size = UDim2.new(0, 300, 0, 80)
        frame.Position = UDim2.new(0.5, -150, 0, 10)
        frame.Parent = self.TargetDisplay
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "TargetName"
        nameLabel.Text = ""
        nameLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 18
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
        infoLabel.TextSize = 14
        infoLabel.BackgroundTransparency = 1
        infoLabel.Size = UDim2.new(1, 0, 0.5, 0)
        infoLabel.Position = UDim2.new(0, 0, 0.5, 0)
        infoLabel.TextStrokeTransparency = 0.5
        infoLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        infoLabel.Parent = frame
        
        self.TargetDisplay.Parent = game:GetService("CoreGui")
    end
    
    -- Main camlock loop with death check
    local conn = RunService.Heartbeat:Connect(function()
        if not self.Enabled then return end
        
        -- Check if local player died
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
            -- Smooth camera movement
            local targetCFrame = CFrame.new(camera.CFrame.Position, humanoidRootPart.Position)
            camera.CFrame = camera.CFrame:Lerp(targetCFrame, 0.5)
            
            -- Update target display
            if self.TargetDisplay and self.TargetDisplay:FindFirstChild("TargetFrame") then
                local frame = self.TargetDisplay.TargetFrame
                local humanoid = character:FindFirstChild("Humanoid")
                local health = humanoid and math.floor(humanoid.Health) or 0
                local maxHealth = humanoid and math.floor(humanoid.MaxHealth) or 100
                
                local localChar = LocalPlayer.Character
                local localRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")
                local distance = localRoot and math.floor((localRoot.Position - humanoidRootPart.Position).Magnitude) or 0
                
                frame.TargetName.Text = self.Target.Name
                frame.TargetInfo.Text = string.format("Health: %d/%d | Distance: %d studs", 
                    health, maxHealth, distance)
            end
        else
            self:Stop()
        end
    end)
    
    table.insert(self.Connections, conn)
    
    -- Add target cleanup connection
    local cleanupConn = self.Target.CharacterAdded:Connect(function()
        if self.Enabled then
            task.wait(1) -- Wait for character to load
            self:AddTargetHighlight()
        end
    end)
    
    local removalConn = self.Target.CharacterRemoving:Connect(function()
        if self.Enabled then
            self:Stop()
        end
    end)
    
    table.insert(self.Connections, cleanupConn)
    table.insert(self.Connections, removalConn)
    
    self.Locked = false
end

function Camlock:Stop()
    if not self.Enabled then return end
    
    self.Enabled = false
    self.Locked = true
    
    -- Remove target highlight
    self:RemoveTargetHighlight()
    
    -- Clear target display
    self:ClearTargetDisplay()
    
    -- Disconnect all connections
    for _, conn in ipairs(self.Connections) do
        if conn then
            pcall(function() conn:Disconnect() end)
        end
    end
    self.Connections = {}
    
    -- Disconnect input connections
    for _, conn in ipairs(self.InputConnections) do
        if conn then
            pcall(function() conn:Disconnect() end)
        end
    end
    self.InputConnections = {}
    
    self.Target = nil
    self.Locked = false
end

function Camlock:Toggle()
    local currentTime = tick()
    
    -- Prevent rapid toggling
    if currentTime - self.LastToggleTime < self.Cooldown then
        return self.Enabled
    end
    
    -- Prevent toggling when locked
    if self.Locked then
        return self.Enabled
    end
    
    self.LastToggleTime = currentTime
    
    if self.Enabled then
        -- Turn OFF
        self:Stop()
        self.ButtonState = "OFF"
        ConfigManager:Set("CamlockEnabled", false)
        return false
    else
        -- Turn ON
        local target = self:FindClosestTarget()
        if target then
            self:Start(target)
            self.ButtonState = "ON"
            ConfigManager:Set("CamlockEnabled", true)
            return true
        else
            WindUI:Notify({
                Title = "Camlock",
                Content = "No target found in camera FOV",
                Duration = 2,
                Icon = "alert-triangle"
            })
            return false
        end
    end
end

function Camlock:ClearTargetDisplay()
    if self.TargetDisplay and self.TargetDisplay:FindFirstChild("TargetFrame") then
        self.TargetDisplay.TargetFrame.TargetName.Text = ""
        self.TargetDisplay.TargetFrame.TargetInfo.Text = ""
    end
end

function Camlock:CreateMobileButton()
    if self.MobileButton then
        self.MobileButton:Destroy()
        self.MobileButton = nil
    end
    
    -- Clear any previous input connections
    for _, conn in ipairs(self.InputConnections) do
        if conn then
            pcall(function() conn:Disconnect() end)
        end
    end
    self.InputConnections = {}
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MobileCamlockButton"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.IgnoreGuiInset = true
    
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
    
    -- Add curved borders
    local uICorner = Instance.new("UICorner")
    uICorner.CornerRadius = UDim.new(0, 8) -- Curved corners
    uICorner.Parent = button
    
    button.Size = UDim2.new(0, 120, 0, 40)
    button.Position = UDim2.new(1, -130, 0.5, -20)
    button.Parent = screenGui
    
    -- Make draggable with improved handling
    local dragging = false
    local dragStart, startPos
    
    -- Mouse drag functionality
    button.MouseButton1Down:Connect(function()
        dragging = true
        dragStart = game:GetService("UserInputService"):GetMouseLocation()
        startPos = button.Position
    end)
    
    -- Touch drag functionality
    button.TouchLongPress:Connect(function(touchPos)
        dragging = true
        dragStart = touchPos
        startPos = button.Position
    end)
    
    -- Mouse up/touch ended
    local function endDrag()
        dragging = false
    end
    
    button.MouseButton1Up:Connect(endDrag)
    button.MouseLeave:Connect(endDrag)
    
    -- Touch ended
    local touchEndedConn = game:GetService("UserInputService").TouchEnded:Connect(function()
        dragging = false
    end)
    table.insert(self.InputConnections, touchEndedConn)
    
    -- Update position while dragging
    local dragConnection
    dragConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if dragging then
            local inputService = game:GetService("UserInputService")
            local currentPos
            
            if inputService.MouseEnabled and inputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                currentPos = inputService:GetMouseLocation()
            elseif inputService.TouchEnabled then
                local touch = inputService:GetTouchInputs()[1]
                if touch then
                    currentPos = Vector2.new(touch.Position.X, touch.Position.Y)
                end
            end
            
            if currentPos then
                local delta = currentPos - dragStart
                button.Position = UDim2.new(
                    startPos.X.Scale, 
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale, 
                    startPos.Y.Offset + delta.Y
                )
            end
        end
    end)
    
    table.insert(self.InputConnections, dragConnection)
    
    -- Button functionality with debounce and proper filtering
    local lastClickTime = 0
    local clickCooldown = 0.5
    
    local function handleCamlockToggle()
        local currentTime = tick()
        if currentTime - lastClickTime > clickCooldown then
            lastClickTime = currentTime
            
            -- Toggle camlock
            local wasEnabled = self.Enabled
            local newState = self:Toggle()
            
            if newState ~= wasEnabled then
                -- Update mobile button text
                self:UpdateMobileButtonText()
                
                -- Update UI toggle if it exists
                if camlockToggle then
                    camlockToggle:SetValue(newState)
                end
                
                WindUI:Notify({
                    Title = "Camlock",
                    Content = newState and "Camlock activated" or "Camlock deactivated",
                    Duration = 1.5,
                    Icon = "crosshair"
                })
            end
        end
    end
    
    -- Connect click events directly to button only
    button.MouseButton1Click:Connect(function()
        if not dragging then
            handleCamlockToggle()
        end
    end)
    
    button.TouchTap:Connect(function()
        if not dragging then
            handleCamlockToggle()
        end
    end)
    
    screenGui.Parent = game:GetService("CoreGui")
    self.MobileButton = screenGui
    self:UpdateMobileButtonText()
end
-- Snippet 4/4: UI Setup and Final Initialization
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
    
    local SettingsTab = Window:Tab({
        Title = "Configuration",
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
    
    local counterNotifierToggle = CombatTab:Toggle({
        Title = "Counter Notifier",
        Desc = "Highlights enemies when they use counter moves.",
        Value = ConfigManager:Get("CounterNotifierEnabled"),
        Callback = function(state)
            ConfigManager:Set("CounterNotifierEnabled", state)
            if state then
                WindUI:Notify({
                    Title = "Counter Notifier",
                    Content = "Counter detection activated",
                    Duration = 2,
                    Icon = "eye"
                })
            else
                WindUI:Notify({
                    Title = "Counter Notifier",
                    Content = "Counter detection deactivated",
                    Duration = 2,
                    Icon = "eye-off"
                })
            end
            
            if state and AutoBlock.Enabled then
                -- Restart to include counter detection
                AutoBlock:Stop()
                AutoBlock:Start()
            elseif not state and AutoBlock.Enabled then
                -- Just remove counter highlights but keep auto block
                for character, highlight in pairs(AutoBlock.CounterHighlights) do
                    if highlight then
                        highlight:Destroy()
                    end
                end
                AutoBlock.CounterHighlights = {}
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
            WindUI:Notify({
                Title = "Settings Updated",
                Content = "Close range set to " .. value .. " studs",
                Duration = 2,
                Icon = "settings"
            })
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
            WindUI:Notify({
                Title = "Settings Updated",
                Content = "Long range set to " .. value .. " studs",
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
            -- Only start if toggle is ON
            local target = Camlock:FindClosestTarget()
            if target then
                Camlock.ButtonState = "ON"
                Camlock:Start(target)
                Camlock:UpdateMobileButtonText()
                WindUI:Notify({
                    Title = "Camlock",
                    Content = "Camlock activated on " .. target.Name,
                    Duration = 2,
                    Icon = "crosshair"
                })
            else
                -- No target found, revert toggle
                ConfigManager:Set("CamlockEnabled", false)
                camlockToggle:SetValue(false)
                WindUI:Notify({
                    Title = "Camlock",
                    Content = "No target found in camera FOV",
                    Duration = 2,
                    Icon = "alert-triangle"
                })
            end
        else
            -- Turn OFF
            Camlock:Stop()
            Camlock.ButtonState = "OFF"
            Camlock:UpdateMobileButtonText()
            WindUI:Notify({
                Title = "Camlock",
                Content = "Camlock deactivated",
                Duration = 2,
                Icon = "crosshair"
            })
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
    
    -- Settings Tab Elements (without emojis)
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
            counterNotifierToggle:SetValue(defaultConfig.CounterNotifierEnabled)
            m1AfterBlockToggle:SetValue(defaultConfig.M1AfterBlockEnabled)
            closeRangeSlider:SetValue(defaultConfig.AutoBlockCloseRange)
            longRangeSlider:SetValue(defaultConfig.AutoBlockLongRange)
            camlockToggle:SetValue(defaultConfig.CamlockEnabled)
            mobileCamlockToggle:SetValue(defaultConfig.MobileCamlockButton)
            keybindButton:SetTitle("Change Keybind (Currently: " .. defaultConfig.CamlockKeybind .. ")")
            
            -- Restart systems with new settings
            if AutoBlock.Enabled then
                AutoBlock:Stop()
                AutoBlock:Start()
            end
            
            if Camlock.Enabled then
                Camlock:Stop()
                if defaultConfig.CamlockEnabled then
                    local target = Camlock:FindClosestTarget()
                    if target then
                        Camlock.Target = target
                        Camlock:Start()
                    end
                end
            end
            
            if Camlock.MobileButton and not defaultConfig.MobileCamlockButton then
                Camlock:RemoveMobileButton()
            elseif not Camlock.MobileButton and defaultConfig.MobileCamlockButton then
                Camlock:CreateMobileButton()
            end
            
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
        Desc = "• Advanced Auto Block system\n• Camlock with mobile button\n• Counter move detection\n• M1 After Block feature\n• Configurable detection ranges\n• Settings persistence\n• Clean, modern UI"
    })
    
    AboutTab:Paragraph({
        Title = "Instructions",
        Desc = "1. Enable Auto Block in Combat tab\n2. Adjust ranges in Combat tab\n3. Configure Camlock in Camlock tab\n4. Save your preferred settings"
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
    
-- Fixed keybind handler for camlock with better control
local keybindConnection
local lastKeybindTime = 0
local keybindCooldown = 0.5

-- Function to setup keybind
local function setupKeybind()
    -- Disconnect previous connection if exists
    if keybindConnection then
        keybindConnection:Disconnect()
        keybindConnection = nil
    end
    
    -- Create new connection
    keybindConnection = game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
        -- Only process if not processed by GUI and key matches
        if not processed and input.KeyCode.Name == ConfigManager:Get("CamlockKeybind") then
            local currentTime = tick()
            if currentTime - lastKeybindTime > keybindCooldown then
                lastKeybindTime = currentTime
                
                -- Toggle camlock
                local wasEnabled = Camlock.Enabled
                local newState = Camlock:Toggle()
                
                if newState ~= wasEnabled then
                    -- Update mobile button text
                    Camlock:UpdateMobileButtonText()
                    
                    -- Update UI toggle
                    if camlockToggle then
                        camlockToggle:SetValue(newState)
                    end
                    
                    WindUI:Notify({
                        Title = "Camlock",
                        Content = newState and "Camlock activated" or "Camlock deactivated",
                        Duration = 1.5,
                        Icon = "crosshair"
                    })
                end
            end
        end
    end)
end

-- Initialize keybind
setupKeybind()

-- Re-setup keybind when it's changed
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.Escape then
        -- Escape key can be used to force stop camlock if needed
        if Camlock.Enabled then
            Camlock:Stop()
            Camlock.ButtonState = "OFF"
            Camlock:UpdateMobileButtonText()
            ConfigManager:Set("CamlockEnabled", false)
            if camlockToggle then
                camlockToggle:SetValue(false)
            end
        end
    end
end)
    
    -- Initialize based on saved state
    task.spawn(function()
        task.wait(1) -- Wait for game to load
        
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
            local target = Camlock:FindClosestTarget()
            if target then
                Camlock.Target = target
                Camlock:Start()
                Camlock.ButtonState = "ON"
                Camlock:UpdateMobileButtonText()
            else
                ConfigManager:Set("CamlockEnabled", false)
            end
        end
        
        -- Initialize mobile camlock button
        if ConfigManager:Get("MobileCamlockButton") then
            Camlock:CreateMobileButton()
        end
    end)
    
    -- Add custom UI elements to window (v1.0 label and social icons)
    local function addCustomUIElements()
        task.wait(0.5) -- Wait for window to fully load
        local coreGui = game:GetService("CoreGui")
        
        -- Find the WindUI window
        for _, gui in pairs(coreGui:GetChildren()) do
            if gui.Name == "WindUI" then
                local combatGUI = gui:FindFirstChild("CombatGUI")
                if combatGUI then
                    local titleBar = combatGUI:FindFirstChild("TitleBar")
                    if titleBar then
                        -- Add version label (crimson color)
                        local versionLabel = Instance.new("TextLabel")
                        versionLabel.Name = "VersionLabel"
                        versionLabel.Text = "v1.0"
                        versionLabel.TextColor3 = Color3.fromRGB(220, 50, 50) -- Crimson color
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
                        youtubeButton.Image = "rbxassetid://108320733835485" -- YouTube icon
                        youtubeButton.BackgroundTransparency = 1
                        youtubeButton.Size = UDim2.new(0, 25, 0, 25)
                        youtubeButton.Position = UDim2.new(0, 0, 0, 2)
                        youtubeButton.Parent = socialContainer
                        
                        -- Discord icon
                        local discordButton = Instance.new("ImageButton")
                        discordButton.Name = "DiscordIcon"
                        discordButton.Image = "rbxassetid://119731774091515" -- Discord icon
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
