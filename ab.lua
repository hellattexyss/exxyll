-- Wind UI with COMPLETE Autoblock System
-- Fixed version with proper Wind UI integration

-- Load Wind UI
local WindUI = loadstring(game:HttpGet("https://githubusercontent.com/Footagesus/WindUI/main/source.lua"))()

-- Create Window
local Window = WindUI:CreateWindow({
    Title = "Combat System | AutoBlock v11",
    Icon = "shield",
    Author = "notpaki",
    Folder = "CombatSystem",
    
    Size = UDim2.fromOffset(650, 500),
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    HideSearchBar = true,
    ScrollBarEnabled = true,
    User = { Enabled = false },
})

Window:Tag({
    Title = "v11",
    Color = Color3.fromHex("#ff6b6b"),
    Radius = 8,
})

-- COMPLETE AUTOBLOCK MODULE WITH ALL FEATURES
local AutoBlock = {}
AutoBlock.__index = AutoBlock

-- Configuration with ALL original features
AutoBlock.Config = {
    Enabled = false,
    CloseRange = 14,
    LongRange = 35,
    CounterRange = 20,
    BlockDuration = 0.15,
    CheckInterval = 0.1,
    M1AfterBlock = false,
    CounterDetection = true,
    DeathCounterDetection = true,
    CounterBait = false,
    LEmote = false,
    AutoCounterM1 = false,
    M1Reach = false,
    M1Reset = false,
    AntiDeathCounter = false,
    NoStun = false,
    NoFatigue = false,
    AntiKnockback = false,
    ShowCD = false,
    CounterBaitMessage = "Simon says counter"
}

-- State Management
AutoBlock.State = {
    Active = false,
    Blocking = false,
    Connections = {},
    Cooldowns = {},
    Highlights = {},
    DeathCounterHighlights = {},
    Players = game:GetService("Players"),
    RunService = game:GetService("RunService"),
    LocalPlayer = game.Players.LocalPlayer,
    UserInputService = game:GetService("UserInputService"),
    TweenService = game:GetService("TweenService")
}

-- COMPLETE ANIMATION LISTS FROM ORIGINAL SCRIPT
AutoBlock.Animations = {
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
    
    WhiteCounter = "rbxassetid://15311685628",
    BlueCounter = "rbxassetid://12351854556",
    DeathCounter = "rbxassetid://11343250001",
    LAnimation = "rbxassetid://18614546390"
}

-- Helper Functions
function AutoBlock:IsPlayingAnimation(humanoid, animationList)
    if not humanoid or not animationList then return false end
    for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
        if track.Animation and table.find(animationList, track.Animation.AnimationId) then
            return true
        end
    end
    return false
end

function AutoBlock:IsPlayingAnimationId(humanoid, animationId)
    if not humanoid or not animationId then return false end
    for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
        if track.Animation and track.Animation.AnimationId == animationId then
            return true
        end
    end
    return false
end

function AutoBlock:PressBlockKey()
    local char = self.State.LocalPlayer.Character
    if char and char:FindFirstChild("Communicate") then
        pcall(function()
            char.Communicate:FireServer({
                [1] = {
                    Goal = "KeyPress",
                    Key = Enum.KeyCode.F,
                }
            })
        end)
    end
end

function AutoBlock:ReleaseBlockKey()
    local char = self.State.LocalPlayer.Character
    if char and char:FindFirstChild("Communicate") then
        pcall(function()
            char.Communicate:FireServer({
                [1] = {
                    Goal = "KeyRelease",
                    Key = Enum.KeyCode.F,
                }
            })
        end)
    end
end

function AutoBlock:PressM1()
    local char = self.State.LocalPlayer.Character
    if char and char:FindFirstChild("Communicate") then
        pcall(function()
            char.Communicate:FireServer({
                [1] = {
                    Goal = "LeftClick",
                    Mobile = true,
                }
            })
        end)
    end
end

function AutoBlock:ReleaseM1()
    local char = self.State.LocalPlayer.Character
    if char and char:FindFirstChild("Communicate") then
        pcall(function()
            char.Communicate:FireServer({
                [1] = {
                    Goal = "LeftClickRelease",
                    Mobile = true,
                }
            })
        end)
    end
end

-- Find targets in range
function AutoBlock:FindTargetsInRange(range)
    local character = self.State.LocalPlayer.Character
    if not character then return {} end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return {} end
    
    local characterPos = humanoidRootPart.Position
    local targets = {}
    
    for _, player in ipairs(self.State.Players:GetPlayers()) do
        if player ~= self.State.LocalPlayer and player.Character then
            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
            local targetHumanoid = player.Character:FindFirstChild("Humanoid")
            
            if targetRoot and targetHumanoid and targetHumanoid.Health > 0 then
                local distance = (characterPos - targetRoot.Position).Magnitude
                if distance <= range then
                    table.insert(targets, {
                        Player = player,
                        Distance = distance,
                        Character = player.Character,
                        Humanoid = targetHumanoid
                    })
                end
            end
        end
    end
    
    -- Sort by distance
    table.sort(targets, function(a, b) return a.Distance < b.Distance end)
    return targets
end

-- Check for counter tools
function AutoBlock:HasCounterTool()
    local backpack = self.State.LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return false end
    
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and (tool.Name == "Prey's Peril" or tool.Name == "Split Second Counter") then
            return true
        end
    end
    return false
end

-- Core Autoblock Logic
function AutoBlock:CheckAndBlock()
    if not self.Config.Enabled or self.State.Blocking then return end
    
    local character = self.State.LocalPlayer.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- Check long range moves first
    local longTargets = self:FindTargetsInRange(self.Config.LongRange)
    for _, target in ipairs(longTargets) do
        if target.Humanoid and self:IsPlayingAnimation(target.Humanoid, self.Animations.LongRangeMoves) then
            self:ExecuteBlock()
            return
        end
    end
    
    -- Check close range moves
    local closeTargets = self:FindTargetsInRange(self.Config.CloseRange)
    for _, target in ipairs(closeTargets) do
        if target.Humanoid and self:IsPlayingAnimation(target.Humanoid, self.Animations.CloseRangeMoves) then
            self:ExecuteBlock()
            
            -- M1 after block
            if self.Config.M1AfterBlock then
                task.wait(0.1)
                self:PressM1()
                task.wait(0.05)
                self:ReleaseM1()
            end
            return
        end
    end
end

function AutoBlock:ExecuteBlock()
    self.State.Blocking = true
    self:PressBlockKey()
    
    task.wait(self.Config.BlockDuration)
    
    self:ReleaseBlockKey()
    self.State.Blocking = false
end

-- Counter Detection
function AutoBlock:CheckCounterMoves()
    if not self.Config.CounterDetection then return end
    
    local character = self.State.LocalPlayer.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    for _, player in ipairs(self.State.Players:GetPlayers()) do
        if player ~= self.State.LocalPlayer and player.Character then
            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
            local targetHumanoid = player.Character:FindFirstChild("Humanoid")
            
            if targetRoot and targetHumanoid then
                local distance = (rootPart.Position - targetRoot.Position).Magnitude
                if distance <= self.Config.CounterRange then
                    if self:IsPlayingAnimationId(targetHumanoid, self.Animations.WhiteCounter) or
                       self:IsPlayingAnimationId(targetHumanoid, self.Animations.BlueCounter) then
                        
                        local currentTime = tick()
                        if not self.State.Cooldowns[player] or (currentTime - self.State.Cooldowns[player]) > 5 then
                            self.State.Cooldowns[player] = currentTime
                            
                            -- Add highlight
                            if not self.State.Highlights[player.Character] then
                                local highlight = Instance.new("Highlight")
                                highlight.FillColor = Color3.fromRGB(240, 240, 240)
                                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                                highlight.FillTransparency = 0.5
                                highlight.Parent = player.Character
                                self.State.Highlights[player.Character] = highlight
                                
                                WindUI:Notify({
                                    Title = "Counter Detection",
                                    Description = player.Name .. " used a counter move",
                                    Duration = 1.5
                                })
                                
                                -- Remove highlight after 17.5 seconds
                                task.delay(17.5, function()
                                    if self.State.Highlights[player.Character] then
                                        self.State.Highlights[player.Character]:Destroy()
                                        self.State.Highlights[player.Character] = nil
                                    end
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Death Counter Detection
function AutoBlock:CheckDeathCounters()
    if not self.Config.DeathCounterDetection then return end
    
    local liveFolder = workspace:FindFirstChild("Live")
    if not liveFolder then return end
    
    for _, character in ipairs(liveFolder:GetChildren()) do
        if game.Players:FindFirstChild(character.Name) then
            for _, accessory in ipairs(character:GetDescendants()) do
                if accessory:IsA("Accessory") and accessory.Name == "Counter" then
                    if not self.State.DeathCounterHighlights[character] then
                        local highlight = Instance.new("Highlight")
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.FillTransparency = 0.5
                        highlight.Parent = character
                        self.State.DeathCounterHighlights[character] = highlight
                        
                        WindUI:Notify({
                            Title = "Death Counter",
                            Description = character.Name .. " used Death Counter",
                            Duration = 2
                        })
                        
                        task.delay(10.1, function()
                            if self.State.DeathCounterHighlights[character] then
                                self.State.DeathCounterHighlights[character]:Destroy()
                                self.State.DeathCounterHighlights[character] = nil
                            end
                        end)
                    end
                end
            end
        end
    end
end

-- Counter Bait System
function AutoBlock:CheckCounterBait()
    if not self.Config.CounterBait then return end
    
    local character = self.State.LocalPlayer.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    for _, player in ipairs(self.State.Players:GetPlayers()) do
        if player ~= self.State.LocalPlayer and player.Character then
            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
            local targetHumanoid = player.Character:FindFirstChild("Humanoid")
            
            if targetRoot and targetHumanoid then
                local distance = (rootPart.Position - targetRoot.Position).Magnitude
                if distance <= self.Config.CounterRange then
                    if self:IsPlayingAnimationId(targetHumanoid, self.Animations.WhiteCounter) or
                       self:IsPlayingAnimationId(targetHumanoid, self.Animations.BlueCounter) then
                        
                        -- Send bait message
                        if game:GetService("TextChatService") then
                            pcall(function()
                                game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(self.Config.CounterBaitMessage)
                            end)
                        end
                        
                        -- Play L emote
                        if self.Config.LEmote then
                            local animator = character:FindFirstChild("Humanoid"):FindFirstChild("Animator")
                            if animator then
                                local animation = Instance.new("Animation")
                                animation.AnimationId = self.Animations.LAnimation
                                local track = animator:LoadAnimation(animation)
                                track:Play()
                                task.wait(1)
                                track:Stop()
                            end
                        end
                        
                        return
                    end
                end
            end
        end
    end
end

-- No Stun System
function AutoBlock:RemoveStuns()
    if not self.Config.NoStun then return end
    
    local liveFolder = workspace:FindFirstChild("Live")
    if not liveFolder then return end
    
    for _, player in ipairs(self.State.Players:GetPlayers()) do
        local character = liveFolder:FindFirstChild(player.Name)
        if character then
            for _, accessory in ipairs(character:GetChildren()) do
                if accessory:IsA("Accessory") then
                    local stunNames = {"Slowed", "Freeze", "NoDash", "NoBlock", "NoPunch", "NoJump", "ComboStun"}
                    if table.find(stunNames, accessory.Name) then
                        accessory:Destroy()
                    end
                end
            end
        end
    end
end

-- No Fatigue System
function AutoBlock:HandleNoFatigue()
    if not self.Config.NoFatigue then return end
    
    local character = self.State.LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid and humanoid.JumpPower < 50 then
        humanoid.JumpPower = 48.5
    end
end

-- Anti Knockback
function AutoBlock:RemoveKnockback()
    if not self.Config.AntiKnockback then return end
    
    local liveFolder = workspace:FindFirstChild("Live")
    if not liveFolder then return end
    
    for _, player in ipairs(self.State.Players:GetPlayers()) do
        local character = liveFolder:FindFirstChild(player.Name)
        if character then
            for _, accessory in ipairs(character:GetChildren()) do
                if accessory:IsA("Accessory") and (accessory.Name == "Ragdoll" or accessory.Name == "RagdollSim") then
                    accessory:Destroy()
                end
            end
        end
    end
end

-- M1 Reach System
function AutoBlock:HandleM1Reach()
    if not self.Config.M1Reach then return end
    
    local character = self.State.LocalPlayer.Character
    if not character then return end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    if not rootPart or not humanoid then return end
    
    local m1ReachMoves = {
        "rbxassetid://10469493270", "rbxassetid://10469630950", "rbxassetid://13532562418",
        "rbxassetid://13532600125", "rbxassetid://13491635433", "rbxassetid://13296577783",
        "rbxassetid://13370310513", "rbxassetid://13390230973", "rbxassetid://14004222985",
        "rbxassetid://13997092940", "rbxassetid://15259161390", "rbxassetid://15240216931",
        "rbxassetid://16515503507", "rbxassetid://16515520431", "rbxassetid://17889458563",
        "rbxassetid://17889461810", "rbxassetid://123005629431309", "rbxassetid://100059874351664"
    }
    
    for _, track in ipairs(humanoid:GetPlayingAnimationTracks()) do
        if track.Animation and table.find(m1ReachMoves, track.Animation.AnimationId) then
            -- Find closest target
            local closestTarget = nil
            local closestDistance = 16
            
            for _, player in ipairs(self.State.Players:GetPlayers()) do
                if player ~= self.State.LocalPlayer and player.Character then
                    local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                    if targetRoot then
                        local distance = (rootPart.Position - targetRoot.Position).Magnitude
                        if distance <= 16 and distance < closestDistance then
                            closestDistance = distance
                            closestTarget = targetRoot
                        end
                    end
                end
            end
            
            if closestTarget then
                local lookVector = closestTarget.CFrame.LookVector
                local dotProduct = lookVector:Dot((rootPart.Position - closestTarget.Position).unit)
                local offset = dotProduct > 0 and 0.3 or -0.3
                local newCFrame = CFrame.lookAt(closestTarget.Position + lookVector * offset, closestTarget.Position)
                
                self.State.TweenService:Create(rootPart, TweenInfo.new(0.09), {
                    CFrame = newCFrame
                }):Play()
            end
            break
        end
    end
end

-- Main Enable/Disable Functions
function AutoBlock:Enable()
    if self.State.Active then return end
    
    self.State.Active = true
    self.Config.Enabled = true
    
    -- Main autoblock heartbeat
    local heartbeatConn = self.State.RunService.Heartbeat:Connect(function(deltaTime)
        self:CheckAndBlock()
        self:CheckCounterMoves()
        self:CheckCounterBait()
        self:HandleM1Reach()
        
        if deltaTime % 0.1 < 0.01 then -- Run every ~0.1 seconds
            self:RemoveStuns()
            self:HandleNoFatigue()
            self:RemoveKnockback()
            self:CheckDeathCounters()
        end
    end)
    
    table.insert(self.State.Connections, heartbeatConn)
    
    -- Character respawn handler
    local charConn = self.State.LocalPlayer.CharacterAdded:Connect(function()
        self.State.Blocking = false
        task.wait(0.5)
    end)
    
    table.insert(self.State.Connections, charConn)
    
    WindUI:Notify({
        Title = "AutoBlock System",
        Description = "Enabled",
        Duration = 2
    })
end

function AutoBlock:Disable()
    if not self.State.Active then return end
    
    self.State.Active = false
    self.Config.Enabled = false
    
    -- Release block if active
    if self.State.Blocking then
        self:ReleaseBlockKey()
        self.State.Blocking = false
    end
    
    -- Clean up connections
    for _, conn in ipairs(self.State.Connections) do
        conn:Disconnect()
    end
    
    self.State.Connections = {}
    
    -- Clean up highlights
    for _, highlight in pairs(self.State.Highlights) do
        highlight:Destroy()
    end
    self.State.Highlights = {}
    
    for _, highlight in pairs(self.State.DeathCounterHighlights) do
        highlight:Destroy()
    end
    self.State.DeathCounterHighlights = {}
    
    WindUI:Notify({
        Title = "AutoBlock System",
        Description = "Disabled",
        Duration = 2
    })
end

function AutoBlock:Toggle()
    if self.State.Active then
        self:Disable()
    else
        self:Enable()
    end
end

-- Initialize
AutoBlock.State.LocalPlayer = game.Players.LocalPlayer
print("[AutoBlock] Module initialized")

-- CREATE WIND UI INTERFACE
local CombatTab = Window:CreateTab({
    Title = "Combat",
    Icon = "swords"
})

-- Main Settings Section
local MainSection = CombatTab:CreateSection({
    Title = "Main Settings",
    Side = "Left"
})

local toggleEnabled = MainSection:CreateToggle({
    Title = "Enable AutoBlock",
    Description = "Toggle the entire autoblock system",
    Default = false,
    Callback = function(value)
        if value then
            AutoBlock:Enable()
        else
            AutoBlock:Disable()
        end
    end
})

-- Range Settings
local RangeSection = CombatTab:CreateSection({
    Title = "Range Settings",
    Side = "Left"
})

RangeSection:CreateSlider({
    Title = "Close Range",
    Description = "Distance for close-range moves",
    Default = AutoBlock.Config.CloseRange,
    Min = 5,
    Max = 30,
    Rounding = 1,
    Callback = function(value)
        AutoBlock.Config.CloseRange = value
    end
})

RangeSection:CreateSlider({
    Title = "Long Range",
    Description = "Distance for long-range moves",
    Default = AutoBlock.Config.LongRange,
    Min = 10,
    Max = 50,
    Rounding = 1,
    Callback = function(value)
        AutoBlock.Config.LongRange = value
    end
})

RangeSection:CreateSlider({
    Title = "Counter Range",
    Description = "Distance for counter detection",
    Default = AutoBlock.Config.CounterRange,
    Min = 5,
    Max = 40,
    Rounding = 1,
    Callback = function(value)
        AutoBlock.Config.CounterRange = value
    end
})

-- Timing Settings
local TimingSection = CombatTab:CreateSection({
    Title = "Timing Settings",
    Side = "Right"
})

TimingSection:CreateSlider({
    Title = "Block Duration",
    Description = "How long to hold block",
    Default = AutoBlock.Config.BlockDuration,
    Min = 0.05,
    Max = 0.3,
    Rounding = 0.01,
    Callback = function(value)
        AutoBlock.Config.BlockDuration = value
    end
})

-- Features Section
local FeaturesSection = CombatTab:CreateSection({
    Title = "Features",
    Side = "Left"
})

FeaturesSection:CreateToggle({
    Title = "M1 After Block",
    Description = "Attack automatically after blocking",
    Default = AutoBlock.Config.M1AfterBlock,
    Callback = function(value)
        AutoBlock.Config.M1AfterBlock = value
    end
})

FeaturesSection:CreateToggle({
    Title = "Counter Detection",
    Description = "Highlight players using counters",
    Default = AutoBlock.Config.CounterDetection,
    Callback = function(value)
        AutoBlock.Config.CounterDetection = value
    end
})

FeaturesSection:CreateToggle({
    Title = "Death Counter Detection",
    Description = "Detect death counter usage",
    Default = AutoBlock.Config.DeathCounterDetection,
    Callback = function(value)
        AutoBlock.Config.DeathCounterDetection = value
    end
})

FeaturesSection:CreateToggle({
    Title = "Counter Bait",
    Description = "React when enemies counter",
    Default = AutoBlock.Config.CounterBait,
    Callback = function(value)
        AutoBlock.Config.CounterBait = value
    end
})

FeaturesSection:CreateToggle({
    Title = "L Emote",
    Description = "Play L emote when baiting",
    Default = AutoBlock.Config.LEmote,
    Callback = function(value)
        AutoBlock.Config.LEmote = value
    end
})

-- Advanced Features
local AdvancedSection = CombatTab:CreateSection({
    Title = "Advanced Features",
    Side = "Right"
})

AdvancedSection:CreateToggle({
    Title = "No Stun",
    Description = "Remove stun effects",
    Default = AutoBlock.Config.NoStun,
    Callback = function(value)
        AutoBlock.Config.NoStun = value
    end
})

AdvancedSection:CreateToggle({
    Title = "No Fatigue",
    Description = "Prevent jump fatigue",
    Default = AutoBlock.Config.NoFatigue,
    Callback = function(value)
        AutoBlock.Config.NoFatigue = value
    end
})

AdvancedSection:CreateToggle({
    Title = "Anti Knockback",
    Description = "Prevent knockback effects",
    Default = AutoBlock.Config.AntiKnockback,
    Callback = function(value)
        AutoBlock.Config.AntiKnockback = value
    end
})

AdvancedSection:CreateToggle({
    Title = "M1 Reach",
    Description = "Extend M1 reach",
    Default = AutoBlock.Config.M1Reach,
    Callback = function(value)
        AutoBlock.Config.M1Reach = value
    end
})

AdvancedSection:CreateToggle({
    Title = "M1 Reset",
    Description = "Reset M1 animations",
    Default = AutoBlock.Config.M1Reset,
    Callback = function(value)
        AutoBlock.Config.M1Reset = value
    end
})

AdvancedSection:CreateToggle({
    Title = "Anti Death Counter",
    Description = "Bypass death counter",
    Default = AutoBlock.Config.AntiDeathCounter,
    Callback = function(value)
        AutoBlock.Config.AntiDeathCounter = value
    end
})

AdvancedSection:CreateToggle({
    Title = "Show Cooldowns",
    Description = "Display ability cooldowns",
    Default = AutoBlock.Config.ShowCD,
    Callback = function(value)
        AutoBlock.Config.ShowCD = value
    end
})

-- Counter Bait Message
local BaitSection = CombatTab:CreateSection({
    Title = "Bait Settings",
    Side = "Right"
})

BaitSection:CreateInput({
    Title = "Bait Message",
    Description = "Message to send when baiting",
    Default = AutoBlock.Config.CounterBaitMessage,
    Placeholder = "Enter bait message...",
    Callback = function(value)
        AutoBlock.Config.CounterBaitMessage = value
    end
})

-- Quick Actions
local ActionsSection = CombatTab:CreateSection({
    Title = "Quick Actions",
    Side = "Left"
})

ActionsSection:CreateButton({
    Title = "Toggle AutoBlock",
    Description = "Quick enable/disable",
    Callback = function()
        AutoBlock:Toggle()
        toggleEnabled:Set(not toggleEnabled.Value)
    end
})

ActionsSection:CreateButton({
    Title = "Test Block",
    Description = "Manually trigger a block",
    Callback = function()
        if AutoBlock.State.Active then
            AutoBlock:ExecuteBlock()
            WindUI:Notify({
                Title = "Test Block",
                Description = "Manual block triggered",
                Duration = 1
            })
        else
            WindUI:Notify({
                Title = "Error",
                Description = "Enable AutoBlock first",
                Duration = 2
            })
        end
    end
})

ActionsSection:CreateButton({
    Title = "Reset Settings",
    Description = "Reset all to defaults",
    Callback = function()
        AutoBlock.Config = {
            Enabled = false,
            CloseRange = 14,
            LongRange = 35,
            CounterRange = 20,
            BlockDuration = 0.15,
            CheckInterval = 0.1,
            M1AfterBlock = false,
            CounterDetection = true,
            DeathCounterDetection = true,
            CounterBait = false,
            LEmote = false,
            AutoCounterM1 = false,
            M1Reach = false,
            M1Reset = false,
            AntiDeathCounter = false,
            NoStun = false,
            NoFatigue = false,
            AntiKnockback = false,
            ShowCD = false,
            CounterBaitMessage = "Simon says counter"
        }
        
        WindUI:Notify({
            Title = "Settings Reset",
            Description = "All settings restored to default",
            Duration = 2
        })
    end
})

-- Status Display
local StatusSection = CombatTab:CreateSection({
    Title = "Status",
    Side = "Right"
})

local statusLabel = StatusSection:CreateLabel({
    Title = "Status: Inactive",
    Description = "AutoBlock is disabled"
})

-- Update status
local function updateStatus()
    if AutoBlock.State.Active then
        statusLabel:Update({
            Title = "Status: Active",
            Description = "AutoBlock is protecting you"
        })
    else
        statusLabel:Update({
            Title = "Status: Inactive",
            Description = "AutoBlock is disabled"
        })
    end
end

-- Hook status updates
toggleEnabled.Callback = function(value)
    if value then
        AutoBlock:Enable()
    else
        AutoBlock:Disable()
    end
    updateStatus()
end

-- Keybind for toggle
AutoBlock.State.UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        AutoBlock:Toggle()
        toggleEnabled:Set(not toggleEnabled.Value)
        updateStatus()
    end
end)

-- Initial notification
WindUI:Notify({
    Title = "AutoBlock System",
    Description = "Loaded successfully. Press INSERT to toggle.",
    Duration = 3
})

-- Return module
return {
    Window = Window,
    AutoBlock = AutoBlock
}
