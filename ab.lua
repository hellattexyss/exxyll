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
        ButtonState = "OFF"  -- Track button state
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
            local highlight = Instance.new("Highlight")
            highlight.Name = "CamlockHighlight"
            highlight.FillColor = Color3.fromRGB(255, 50, 50) -- Red color
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.3
            highlight.OutlineTransparency = 0
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
    
    function Camlock:UpdateMobileButtonText()
        if self.MobileButton and self.MobileButton:FindFirstChild("CamlockButton") then
            local button = self.MobileButton.CamlockButton
            button.Text = "CAMLOCK " .. self.ButtonState
        end
    end
    
    function Camlock:Start(target)
        if self.Enabled then return end
        
        self.Enabled = true
        self.Target = target or self:FindClosestTarget()
        
        if not self.Target then
            self.Enabled = false
            return
        end
        
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
        
        -- Main camlock loop
        local conn = RunService.Heartbeat:Connect(function()
            if not self.Enabled then return end
            
            if self.Target and self.Target.Character then
                local character = self.Target.Character
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                
                if humanoidRootPart then
                    local camera = workspace.CurrentCamera
                    camera.CFrame = CFrame.new(camera.CFrame.Position, humanoidRootPart.Position)
                    
                    -- Update target display
                    if self.TargetDisplay and self.TargetDisplay:FindFirstChild("TargetFrame") then
                        local frame = self.TargetDisplay.TargetFrame
                        local humanoid = character:FindFirstChild("Humanoid")
                        local health = humanoid and math.floor(humanoid.Health) or 0
                        local maxHealth = humanoid and math.floor(humanoid.MaxHealth) or 100
                        
                        frame.TargetName.Text = self.Target.Name
                        frame.TargetInfo.Text = string.format("Health: %d/%d | Distance: %d studs", 
                            health, maxHealth, 
                            math.floor((LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and 
                            (LocalPlayer.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude) or 0))
                    end
                else
                    self:Stop()
                end
            end
        end)
        
        table.insert(self.Connections, conn)
    end
    
    function Camlock:Stop()
        if not self.Enabled then return end
        
        self.Enabled = false
        
        -- Remove target highlight
        self:RemoveTargetHighlight()
        
        -- Clear target display
        self:ClearTargetDisplay()
        
        -- Disconnect all connections
        for _, conn in ipairs(self.Connections) do
            conn:Disconnect()
        end
        self.Connections = {}
        
        self.Target = nil
    end
    
    function Camlock:Toggle()
        if self.Enabled then
            self:Stop()
            self.ButtonState = "OFF"
            self:UpdateMobileButtonText()
            return false
        else
            local target = self:FindClosestTarget()
            if target then
                self:Start(target)
                self.ButtonState = "ON"
                self:UpdateMobileButtonText()
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
        
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "MobileCamlockButton"
        screenGui.ResetOnSpawn = false
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
        local button = Instance.new("TextButton")
        button.Name = "CamlockButton"
        button.Text = "CAMLOCK " .. self.ButtonState
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.GothamBold
        button.TextSize = 14
        button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        button.BorderColor3 = Color3.fromRGB(255, 50, 50)
        button.BorderSizePixel = 2
        
        -- Add curved borders
        local uICorner = Instance.new("UICorner")
        uICorner.CornerRadius = UDim.new(0, 8) -- Curved corners
        uICorner.Parent = button
        
        button.Size = UDim2.new(0, 120, 0, 40)
        button.Position = UDim2.new(1, -130, 0.5, -20)
        button.Parent = screenGui
        
        -- Make draggable
        local dragging = false
        local dragInput, dragStart, startPos
        
        button.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = button.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        
        button.InputChanged:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
                dragInput = input
            end
        end)
        
        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        
        -- Button functionality
        button.MouseButton1Click:Connect(function()
            self:Toggle()
        end)
        
        button.TouchTap:Connect(function()
            self:Toggle()
        end)
        
        screenGui.Parent = game:GetService("CoreGui")
        self.MobileButton = screenGui
    end
    
    function Camlock:RemoveMobileButton()
        if self.MobileButton then
            self.MobileButton:Destroy()
            self.MobileButton = nil
        end
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
        Icon = "sliders",
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
        Title = "Camlock",
        Desc = "Enable camera lock to nearest enemy",
        Value = ConfigManager:Get("CamlockEnabled"),
        Callback = function(state)
            ConfigManager:Set("CamlockEnabled", state)
            if state then
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
                Camlock:Stop()
                Camlock.ButtonState = "OFF"
                Camlock:UpdateMobileButtonText()
                WindUI:Notify({
                    Title = "Camlock",
                    Content = "Camlock deactivated",
