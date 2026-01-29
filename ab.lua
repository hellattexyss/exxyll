-- Combat GUI v11 - Fixed AutoBlock with Complete Logic
-- Snippet 1/3: Configuration and Setup
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
        Size = UDim2.fromOffset(580, 100),
        Transparent = false,
        Theme = "Crimson",
        Resizable = true,
        SideBarWidth = 135,
        HideSearchBar = true,
        ScrollBarEnabled = true,
        MinimizeEnabled = true,
        CloseEnabled = true,
    })
    -- Snippet 2/3: AutoBlock Core Functions
-- AutoBlock Core Functions
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
        -- Snippet 3/3: UI and Final Setup
    -- Create Tabs with better styling
    local MainTab = Window:Tab({
        Title = "Main Features",
        Icon = "zap",
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
    
    -- Main Tab Elements
    MainTab:Section({
        Title = "Auto Block System",
        Desc = "Automatic defense against enemy attacks"
    })
    
    local autoBlockToggle = MainTab:Toggle({
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
    
    local counterNotifierToggle = MainTab:Toggle({
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
    
    local m1AfterBlockToggle = MainTab:Toggle({
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
    
    -- Settings Tab Elements
    SettingsTab:Section({
        Title = "Auto Block Settings",
        Desc = "Configure detection ranges"
    })
    
    local closeRangeSlider = SettingsTab:Slider({
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
    
    local longRangeSlider = SettingsTab:Slider({
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
    
    SettingsTab:Section({
        Title = "Configuration Management",
        Desc = "Save and load your settings"
    })
    
    local saveButton = SettingsTab:Button({
        Title = "💾 Save Configuration",
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
        Title = "🔄 Load Defaults",
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
            
            -- Restart auto block with new settings
            if AutoBlock.Enabled then
                AutoBlock:Stop()
                AutoBlock:Start()
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
        Title = "⚡ Test Auto Block",
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
        Desc = "• Advanced Auto Block system\n• Counter move detection\n• M1 After Block feature\n• Configurable detection ranges\n• Settings persistence\n• Clean, modern UI"
    })
    
    AboutTab:Paragraph({
        Title = "Instructions",
        Desc = "1. Enable Auto Block in Main Features tab\n2. Adjust ranges in Configuration tab\n3. Save your preferred settings\n4. The system will automatically block enemy attacks"
    })
    
    AboutTab:Button({
        Title = "📺 YouTube Channel",
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
        Title = "💬 Discord Server",
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
    
    -- Initialize based on saved state
    task.spawn(function()
        task.wait(1) -- Wait for game to load
        if ConfigManager:Get("AutoBlockEnabled") then
            AutoBlock:Start()
            WindUI:Notify({
                Title = "Auto Block",
                Content = "Auto Block system initialized from saved settings",
                Duration = 3,
                Icon = "check"
            })
        end
    end)
    
    -- Add custom UI elements to window
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
                        -- Add version label
                        local versionLabel = Instance.new("TextLabel")
                        versionLabel.Name = "VersionLabel"
                        versionLabel.Text = "v1.0"
                        versionLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                        versionLabel.Font = Enum.Font.GothamBold
                        versionLabel.TextSize = 12
                        versionLabel.BackgroundTransparency = 1
                        versionLabel.Size = UDim2.new(0, 40, 0, 20)
                        versionLabel.Position = UDim2.new(0, 95, 0, 10)
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
        Text = "Waspire's Auto Block system loaded successfully!",
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
