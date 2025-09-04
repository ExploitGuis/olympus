local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "|   [UPDATE OUT NOW] Olympus",
    Icon = 134461174841260,
    LoadingTitle = "[UPDATE OUT NOW] Olympus",
    LoadingSubtitle = "Loading Exploits.. <3",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "OLYMPUS HUB"
    }, 

Theme = {
    -- Font & Text
    TextFont = "Gotham", -- Clean and modern font
    TextColor = Color3.fromRGB(255, 255, 255), -- White text for readability
    PlaceholderColor = Color3.fromRGB(120, 120, 170), -- Softer placeholder text

    -- Main Backgrounds
    Background = Color3.fromRGB(20, 20, 20), -- Dark general background
    Topbar = Color3.fromRGB(30, 30, 30), -- Slightly lighter topbar
    Shadow = Color3.fromRGB(10, 10, 10), -- Subtle shadow

    -- Notifications
    NotificationBackground = Color3.fromRGB(25, 25, 25), -- Matches the topbar
    NotificationActionsBackground = Color3.fromRGB(35, 35, 35), -- Slightly brighter for contrast

    -- Tabs
    TabBackground = Color3.fromRGB(35, 35, 35), -- Default tab background
    TabStroke = Color3.fromRGB(50, 50, 50), -- Soft stroke for tabs
    TabBackgroundSelected = Color3.fromRGB(35, 35, 35), -- Muted blue for selected tabs
    TabTextColor = Color3.fromRGB(255, 255, 255), -- White text for tabs
    SelectedTabTextColor = Color3.fromRGB(170, 130, 11), -- Updated color (#aa820b)

    -- Elements
    ElementBackground = Color3.fromRGB(25, 25, 25), -- Neutral element background
    ElementBackgroundHover = Color3.fromRGB(30, 30, 30), -- Slightly brighter on hover
    SecondaryElementBackground = Color3.fromRGB(20, 20, 20), -- For secondary elements
    ElementStroke = Color3.fromRGB(50, 50, 50), -- Clean stroke
    SecondaryElementStroke = Color3.fromRGB(40, 40, 40), -- For secondary elements

    -- Sliders
    SliderBackground = Color3.fromRGB(170, 130, 11), -- Updated color (#aa820b)
    SliderProgress = Color3.fromRGB(170, 130, 11), -- Updated color (#aa820b)
    SliderStroke = Color3.fromRGB(50, 50, 50), -- Stroke for the slider

    -- Toggles
    ToggleBackground = Color3.fromRGB(25, 25, 25), -- Toggle base
    ToggleEnabled = Color3.fromRGB(170, 130, 11), -- Updated color (#aa820b)
    ToggleDisabled = Color3.fromRGB(50, 50, 50), -- Gray for disabled
    ToggleEnabledStroke = Color3.fromRGB(60, 60, 60), -- Clean stroke
    ToggleDisabledStroke = Color3.fromRGB(40, 40, 40), -- Stroke for disabled
    ToggleEnabledOuterStroke = Color3.fromRGB(170, 130, 11), -- Updated color (#aa820b)
    ToggleDisabledOuterStroke = Color3.fromRGB(30, 30, 30), -- Faint glow for disabled

    -- Inputs
    InputBackground = Color3.fromRGB(25, 25, 25), -- Neutral input background
    InputStroke = Color3.fromRGB(50, 50, 50), -- Stroke for input fields

    -- Labels & Paragraphs
    LabelBackground = Color3.fromRGB(40, 70, 100), -- Muted blue for labels (#284664)
    ParagraphBackground = Color3.fromRGB(40, 70, 100) -- Muted blue for paragraphs (#284664)
},

    Discord = {
        Enabled = true,
        Invite = "ZHpN6hAFnu", -- Replace with your actual Discord invite code
        RememberJoins = true
    },
    KeySystem = false -- No key system required
})

-- Create tabs
local MainTab = Window:CreateTab("Main", 13441691835)
local SurviTab = Window:CreateTab("Characters", 11537490966)
local ESTab = Window:CreateTab("ESP", 16369898431)
local ExtrTab = Window:CreateTab("TP", 6723742952)
local SigmaTab = Window:CreateTab("Game", 4728059072)
local GameTab = Window:CreateTab("Troll", 15782262663)
local EvntTab = Window:CreateTab("Info", 8798704474)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

Rayfield:Notify({
    Title = "Success✅!",
    Content = "Welcome '" .. LocalPlayer.DisplayName .. "'!",
    Duration = 20,
    Image = nil,
    Actions = {
        Close = {
            Name = "Close",
            Callback = function()
                print("Notification closed.")
            end
        }
    }
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

MainTab:CreateButton({
    Name = "Rejoin",
    Callback = function()
    local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
 
local Rejoin = coroutine.create(function()
    local Success, ErrorMessage = pcall(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
 
    if ErrorMessage and not Success then
        warn(ErrorMessage)
    end
end)
 
coroutine.resume(Rejoin)
    end
})

MainTab:CreateSection("Local")

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local camera = workspace.CurrentCamera

-- Variables
local infiniteJumpEnabled = false
local inputBeganConnection, inputEndedConnection

-- Infinite Jump Toggle
local infJump = MainTab:CreateToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(state)
        infiniteJumpEnabled = state
    end
})

-- Handle infinite jump logic
UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Super Sprint Toggle
MainTab:CreateToggle({
    Name = "Ctrl To Super Sprint",
    Default = false,
    Callback = function(state)
        local normalWalkSpeed = 16
        local sprintWalkSpeed = 160
        local defaultFOV = 70
        local sprintFOV = 100
        local tweenTime = 0.5

        local function tweenFOV(targetFOV)
            local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            local goal = {FieldOfView = targetFOV}
            local tween = TweenService:Create(camera, tweenInfo, goal)
            tween:Play()
        end

        local function cleanup()
            if inputBeganConnection then
                inputBeganConnection:Disconnect()
                inputBeganConnection = nil
            end
            if inputEndedConnection then
                inputEndedConnection:Disconnect()
                inputEndedConnection = nil
            end
            humanoid.WalkSpeed = normalWalkSpeed
            tweenFOV(defaultFOV)
        end

        if state then
            inputBeganConnection = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
                if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.LeftControl then
                    humanoid.WalkSpeed = sprintWalkSpeed
                    tweenFOV(sprintFOV)
                end
            end)

            inputEndedConnection = UserInputService.InputEnded:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.LeftControl then
                    humanoid.WalkSpeed = normalWalkSpeed
                    tweenFOV(defaultFOV)
                end
            end)
        else
            cleanup()
        end
    end
})


MainTab:CreateLabel("Notice: This Is Really Fast.", 107639187292219)

local function resetTabs(tab)
    for _, button in ipairs(tab:GetChildren()) do
        if button:IsA("GuiButton") then
            button:Destroy()
        end
    end
end

local walkSpeedSlider = MainTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 500},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        handleSpeedChange(Value)
    end
})

local jumpPowerSlider = MainTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 550},
    Increment = 1,
    Suffix = "JumpPower",
    CurrentValue = 50,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

MainTab:CreateButton({
    Name = "Reset Character",
    Callback = function()
        local args = { "Kill" }
        game:GetService("ReplicatedStorage")
            :WaitForChild("Events")
            :WaitForChild("Game")
            :FireServer(unpack(args))
    end,
})

MainTab:CreateSection("Protection")

local staffProtectionToggle = false
local staffProtectionConnection
local localPlayer = game.Players.LocalPlayer

-- Main toggle for staff protection
local protect = MainTab:CreateToggle({
    Name = "Leave If Moderator Or Above Joins",
    CurrentValue = false,
    Callback = function(state)
        staffProtectionToggle = state

        local targetUserIDs = {
            [2280900504] = true,
            [2692448426] = true,
            [2606417477] = true,
            [333153856] = true,
            [2885429800] = true,
            [1576309590] = true,
            [3306603525] = true,
            [1513655551] = true,
            [633591158] = true,
            [1562662945] = true,
            [1920137678] = true,
            [176544145] = true,
            [3411949622] = true,
            [2546818774] = true,
            [940191686] = true,
            [1138595949] = true,
            [203051852] = true,
            [2270810010] = true,
            [361590181] = true,
            [7179270897] = true,
            [7864715605] = true
        }

        local function kickPlayerIfNeeded(joinedPlayer)
            if targetUserIDs[joinedPlayer.UserId] then
                localPlayer:Kick("A Moderator Or Above From This Game Has Joined Your Server.")
            end
        end

        if state then
            -- Check existing players
            for _, existingPlayer in ipairs(game.Players:GetPlayers()) do
                kickPlayerIfNeeded(existingPlayer)
            end

            -- Check new players
            staffProtectionConnection = game.Players.PlayerAdded:Connect(kickPlayerIfNeeded)
        else
            if staffProtectionConnection then
                staffProtectionConnection:Disconnect()
                staffProtectionConnection = nil
            end
        end
    end
})

MainTab:CreateLabel("Kicks You From The Game If A Moderator Or Above Joins. (Not guaranteed to detect every staff member that joins)", 107639187292219)
 
MainTab:CreateSection("Extra")

local antiKickConnection

MainTab:CreateToggle({
    Name = "Anti-AFK",
    Callback = function(state)
        if state then
            -- Activate Anti-Kick
            antiKickConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                wait(1)
                VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        else
            -- Deactivate Anti-Kick
            if antiKickConnection then
                antiKickConnection:Disconnect()
                antiKickConnection = nil
            end
        end
    end
})

MainTab:CreateLabel("Prevents AFK Roblox 20 Minute Kick.", 107639187292219)

MainTab:CreateButton({
    Name = "Infinite yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        end
})

MainTab:CreateButton({
    Name = "Dex Explorer",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Dq7x5HqJ"))()
        end
})

ESTab:CreateSection("ESP")

local espToggle = false
local espConnection

ESTab:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Callback = function(state)
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer

        espToggle = state

        if espToggle then
            local RunService = game:GetService("RunService")
            local Camera = game:GetService("Workspace").CurrentCamera
            local LocalPlayer = Players.LocalPlayer

            local function createESP(player)
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local highlight = Instance.new("Highlight", character)
                    highlight.Name = "ESP"
                    highlight.Adornee = character
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.FillColor = Color3.fromRGB(255, 94, 19) -- Orange-reddish color
                    highlight.OutlineColor = Color3.fromRGB(255, 94, 19) -- Black outline

                    -- Create name tag
                    local head = character:FindFirstChild("Head")
                    if head then
                        local billboardGui = Instance.new("BillboardGui", head)
                        billboardGui.Name = "NameTag"
                        billboardGui.AlwaysOnTop = true
                        billboardGui.Size = UDim2.new(0, 200, 0, 50)
                        billboardGui.StudsOffset = Vector3.new(0, 2, 0)

                        local textLabel = Instance.new("TextLabel", billboardGui)
                        textLabel.Text = player.Name
                        textLabel.Font = Enum.Font.SourceSansBold
                        textLabel.TextSize = 14
                        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White
                        textLabel.BackgroundTransparency = 1
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                    end
                end
            end

            local function updateESP()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then
                        local esp = player.Character:FindFirstChild("ESP")
                        if not esp then
                            createESP(player)
                        end
                    end
                end
            end

            espConnection = RunService.Heartbeat:Connect(updateESP)
        else
            if espConnection then
                espConnection:Disconnect()
            end

            -- Remove all ESP elements
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    local espOutline = player.Character:FindFirstChild("ESP")
                    local nameTag = player.Character:FindFirstChild("Head"):FindFirstChild("NameTag")
                    if espOutline then
                        espOutline:Destroy()
                    end
                    if nameTag then
                        nameTag:Destroy()
                    end
                end
            end
        end
    end
})

local espToggle = false
local espConnection

ESTab:CreateToggle({
    Name = "Character ESP",
    CurrentValue = false,
    Callback = function(state)
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer

        -- Base colors for each character
        local characterColors = {
            ["Aphrodite"] = Color3.fromRGB(255, 105, 180), -- Pink
            ["Nyx"] = Color3.fromRGB(0, 0, 139),           -- Dark blue
            ["Hestia"] = Color3.fromRGB(255, 69, 0),      -- Orangish-red
            ["Persephone"] = Color3.fromRGB(255, 120, 200), -- Pinker
            ["Eris"] = Color3.fromRGB(139, 0, 139),       -- Darker magenta
            ["Queen of the Underworld"] = Color3.fromRGB(199, 21, 133),
            ["Gaia"] = Color3.fromRGB(34, 139, 34),
            ["Poseidon"] = Color3.fromRGB(0, 105, 148),
            ["Hermes"] = Color3.fromRGB(255, 215, 0),
            ["Helios"] = Color3.fromRGB(255, 255, 102),
            ["Hades"] = Color3.fromRGB(128, 128, 128),
            ["Zeus"] = Color3.fromRGB(0, 0, 255),
            ["Amphitrite"] = Color3.fromRGB(175, 238, 238),
            ["Selene"] = Color3.fromRGB(192, 192, 192),
            ["Athena"] = Color3.fromRGB(255, 165, 0),
            ["Circe"] = Color3.fromRGB(152, 251, 152),
            ["Hera"] = Color3.fromRGB(0, 191, 255),
            ["Hecate"] = Color3.fromRGB(75, 0, 130),
            ["Iris"] = Color3.fromRGB(255, 255, 255) -- rainbow handled separately
        }

        -- Rainbow helper for Iris
        local function getRainbowColor(tickTime)
            local hue = (tickTime * 0.5 % 1) -- slower, smooth cycle
            return Color3.fromHSV(hue, 1, 1)
        end

        -- Oscillate brightness for “alive” effect
        local function aliveColor(color, time)
            local h, s, v = Color3.toHSV(color)
            -- Larger, faster oscillation for cute lively effect
            v = math.clamp(v * (0.85 + 0.3 * (0.5 + 0.5 * math.sin(time * 3))), 0, 1)
            return Color3.fromHSV(h, s, v)
        end

        espToggle = state

        if espToggle then
            local function createESP(player, textLabelName)
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    if not character:FindFirstChild("ESP") then
                        local highlight = Instance.new("Highlight", character)
                        highlight.Name = "ESP"
                        highlight.Adornee = character
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                        highlight.FillColor = Color3.fromRGB(128, 128, 128)
                        highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
                    end

                    local head = character:FindFirstChild("Head")
                    if head and not head:FindFirstChild("NameTag") then
                        local billboardGui = Instance.new("BillboardGui", head)
                        billboardGui.Name = "NameTag"
                        billboardGui.AlwaysOnTop = true
                        billboardGui.Size = UDim2.new(0, 200, 0, 50)
                        billboardGui.StudsOffset = Vector3.new(0, 2, 0)

                        local textLabel = Instance.new("TextLabel", billboardGui)
                        textLabel.Text = textLabelName
                        textLabel.Font = Enum.Font.SourceSansBold
                        textLabel.TextSize = 14
                        textLabel.TextColor3 = Color3.fromRGB(128, 128, 128)
                        textLabel.BackgroundTransparency = 1
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                    end
                end
            end

            local function updateESP()
                for _, player in pairs(Players:GetPlayers()) do
                    if player.Character then
                        local head = player.Character:FindFirstChild("Head")
                        if head then
                            local overhead = head:FindFirstChild("OverheadGui")
                            local upperText = overhead and overhead:FindFirstChild("UpperText")
                            local nameTagText = upperText and upperText.Text

                            if nameTagText then
                                createESP(player, nameTagText)

                                local baseColor
                                if nameTagText == "Iris" then
                                    baseColor = getRainbowColor(tick())
                                else
                                    baseColor = characterColors[nameTagText] or Color3.fromRGB(128, 128, 128)
                                    baseColor = aliveColor(baseColor, tick())
                                end

                                local highlight = player.Character:FindFirstChild("ESP")
                                if highlight then
                                    highlight.FillColor = baseColor
                                end

                                local nameTag = head:FindFirstChild("NameTag")
                                if nameTag and nameTag:FindFirstChild("TextLabel") then
                                    nameTag.TextLabel.Text = nameTagText
                                    nameTag.TextLabel.TextColor3 = baseColor
                                end
                            end
                        end
                    end
                end
            end

            espConnection = RunService.Heartbeat:Connect(updateESP)
        else
            if espConnection then
                espConnection:Disconnect()
            end

            for _, player in pairs(Players:GetPlayers()) do
                if player.Character then
                    local espHighlight = player.Character:FindFirstChild("ESP")
                    local head = player.Character:FindFirstChild("Head")
                    local nameTag = head and head:FindFirstChild("NameTag")
                    if espHighlight then espHighlight:Destroy() end
                    if nameTag then nameTag:Destroy() end
                end
            end
        end
    end
})

local espToggle = false
local espConnection

ESTab:CreateToggle({
    Name = "Friend ESP",
    CurrentValue = false,
    Callback = function(state)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        espToggle = state

        if espToggle then
            local RunService = game:GetService("RunService")

            local function createESPForFriend(friend)
                local character = friend.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    -- Highlight
                    local highlight = Instance.new("Highlight", character)
                    highlight.Name = "ESP"
                    highlight.Adornee = character
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Green
                    highlight.OutlineColor = Color3.fromRGB(0, 0, 0) -- Black outline

                    -- Name Tag
                    local head = character:FindFirstChild("Head")
                    if head then
                        local billboardGui = Instance.new("BillboardGui", head)
                        billboardGui.Name = "NameTag"
                        billboardGui.AlwaysOnTop = true
                        billboardGui.Size = UDim2.new(0, 200, 0, 50)
                        billboardGui.StudsOffset = Vector3.new(0, 2, 0)

                        local textLabel = Instance.new("TextLabel", billboardGui)
                        textLabel.Text = friend.Name
                        textLabel.Font = Enum.Font.SourceSansBold
                        textLabel.TextSize = 14
                        textLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Green
                        textLabel.BackgroundTransparency = 1
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                    end
                end
            end

            local function updateESP()
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and LocalPlayer:IsFriendsWith(player.UserId) and player.Character and player.Character:FindFirstChild("Humanoid") then
                        local esp = player.Character:FindFirstChild("ESP")
                        local nameTag = player.Character:FindFirstChild("Head"):FindFirstChild("NameTag")
                        if not esp then
                            createESPForFriend(player)
                        end
                    end
                end
            end

            espConnection = RunService.Heartbeat:Connect(updateESP)
        else
            if espConnection then
                espConnection:Disconnect()
            end

            -- Remove all ESP elements from friends
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and LocalPlayer:IsFriendsWith(player.UserId) and player.Character then
                    local espOutline = player.Character:FindFirstChild("ESP")
                    local nameTag = player.Character:FindFirstChild("Head"):FindFirstChild("NameTag")
                    if espOutline then
                        espOutline:Destroy()
                    end
                    if nameTag then
                        nameTag:Destroy()
                    end
                end
            end
        end
    end
})

SurviTab:CreateSection("Characters")

SurviTab:CreateLabel("Notice: These buttons will only spawn you as the character you select it will not keep it in your inventory if you leave.", 18638286567)

SurviTab:CreateLabel("Note: You don't have to be in Main Menu or Character Selection for this to work.", 18638286567)

SurviTab:CreateButton({
    Name = "Spawn As Aphrodite",
    Callback = function()
        local args = {
            "Occupy",
            "Aphrodite",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Aphrodite"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Nyx",
    Callback = function()
        local args = {
            "Occupy",
            "Nyx",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Nyx"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Hestia",
    Callback = function()
        local args = {
            "Occupy",
            "Hestia",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Hestia"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Iris",
    Callback = function()
        local args = {
            "Occupy",
            "Iris",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Iris"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Persephone",
    Callback = function()
        local args = {
            "Occupy",
            "Persephone",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Persephone"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Eris",
    Callback = function()
        local args = {
            "Occupy",
            "Eris",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Eris"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Dark Persephone",
    Callback = function()
        local args = {
            "Occupy",
            "Queen of the Underworld",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Queen of the Underworld"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Gaia",
    Callback = function()
        local args = {
            "Occupy",
            "Gaia",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Gaia"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Poseidon",
    Callback = function()
        local args = {
            "Occupy",
            "Poseidon",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Poseidon"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Hermes",
    Callback = function()
        local args = {
            "Occupy",
            "Hermes",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Hermes"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Helios",
    Callback = function()
        local args = {
            "Occupy",
            "Helios",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Helios"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Hades",
    Callback = function()
        local args = {
            "Occupy",
            "Hades",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Hades"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})


SurviTab:CreateButton({
    Name = "Spawn As Zeus",
    Callback = function()
        local args = {
            "Occupy",
            "Zeus",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Zeus"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Amphitrite (Doesn't Work)",
    Callback = function()
        local args = {
            "Occupy",
            "Amphitrite",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Amphitrite"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Selene",
    Callback = function()
        local args = {
            "Occupy",
            "Selene",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Selene"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Athena",
    Callback = function()
        local args = {
            "Occupy",
            "Athena",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Athena"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Circe",
    Callback = function()
        local args = {
            "Occupy",
            "Circe",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Circe"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Hera",
    Callback = function()
        local args = {
            "Occupy",
            "Hera",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Hera"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Hecate",
    Callback = function()
        local args = {
            "Occupy",
            "Hecate",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Hecate"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateButton({
    Name = "Spawn As Fiona (Doesn't Work)",
    Callback = function()
        local args = {
            "Occupy",
            "Fiona",
            {
                Description = "Nyx, the goddess of the night, is a mysterious and awe-inspiring figure cloaked in the shadows of the cosmos. Her presence is both tranquil and unnerving, a living embodiment of the night’s duality: serene yet infinite, comforting yet full of secrets. Her flowing robes shimmer like the starry expanse, dark as the void yet laced with specks of silvery light, as though galaxies themselves are woven into the fabric.",
                SecondaryColor = Color3.new(0.4901960790157318, 0.5647059082984924, 0.7843137383460999),
                AccentColor    = Color3.new(0.18431372940540314, 0.24313725531101227, 0.42352941632270813),
                IconFrame      = "rbxassetid://109487525162601",
                PrimaryColor   = Color3.new(0.09803921729326248, 0.13333334028720856, 0.24705882370471954),
                Gamepass       = false,
                GamepassId     = 1062037243,
                Name           = "Fiona"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
    end
})

SurviTab:CreateSection("Steal Slot")

-- Aphrodite
local RunService = game:GetService("RunService")
local toggle = false
local connection

SurviTab:CreateToggle({
    Name = "Spam Aphrodite's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local found = false
                for _, character in ipairs(playersFolder:GetChildren()) do
                    local head = character:FindFirstChild("Head")
                    if head then
                        local overheadGui = head:FindFirstChild("OverheadGui")
                        if overheadGui then
                            local upperText = overheadGui:FindFirstChild("UpperText")
                            if upperText and upperText:IsA("TextLabel") and upperText.Text == "Aphrodite" then
                                found = true
                                repeat RunService.Heartbeat:Wait() until not toggle or not upperText:IsDescendantOf(game) or upperText.Text ~= "Aphrodite"
                                if toggle then
                                    local args = {"Occupy","Aphrodite",{Name="Aphrodite"}}
                                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                                end
                                break
                            end
                        end
                    end
                end
                if not found and toggle then
                    local args = {"Occupy","Aphrodite",{Name="Aphrodite"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Nyx
local RunService = game:GetService("RunService")
local toggle = false
local connection

SurviTab:CreateToggle({
    Name = "Spam Nyx's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local found = false
                for _, character in ipairs(playersFolder:GetChildren()) do
                    local head = character:FindFirstChild("Head")
                    if head then
                        local overheadGui = head:FindFirstChild("OverheadGui")
                        if overheadGui then
                            local upperText = overheadGui:FindFirstChild("UpperText")
                            if upperText and upperText:IsA("TextLabel") and upperText.Text == "Nyx" then
                                found = true
                                repeat RunService.Heartbeat:Wait() until not toggle or not upperText:IsDescendantOf(game) or upperText.Text ~= "Nyx"
                                if toggle then
                                    local args = {"Occupy","Nyx",{Name="Nyx"}}
                                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                                end
                                break
                            end
                        end
                    end
                end
                if not found and toggle then
                    local args = {"Occupy","Nyx",{Name="Nyx"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Hestia
local toggle = false
local connection
SurviTab:CreateToggle({
    Name = "Spam Hestia's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local count = 0
                for _, character in ipairs(playersFolder:GetChildren()) do
                    if character ~= localPlayer.Character then
                        local head = character:FindFirstChild("Head")
                        if head then
                            local overheadGui = head:FindFirstChild("OverheadGui")
                            if overheadGui then
                                local upperText = overheadGui:FindFirstChild("UpperText")
                                if upperText and upperText:IsA("TextLabel") and upperText.Text == "Hestia" then
                                    count = count + 1
                                end
                            end
                        end
                    end
                end
                if count >= 2 then
                    repeat
                        RunService.Heartbeat:Wait()
                        count = 0
                        for _, character in ipairs(playersFolder:GetChildren()) do
                            if character ~= localPlayer.Character then
                                local head = character:FindFirstChild("Head")
                                if head then
                                    local overheadGui = head:FindFirstChild("OverheadGui")
                                    if overheadGui then
                                        local upperText = overheadGui:FindFirstChild("UpperText")
                                        if upperText and upperText:IsA("TextLabel") and upperText.Text == "Hestia" then
                                            count = count + 1
                                        end
                                    end
                                end
                            end
                        end
                    until not toggle or count <= 1
                end
                if toggle then
                    local args = {"Occupy","Hestia",{Name="Hestia"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events")
                        :WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Iris
local toggle = false
local connection
SurviTab:CreateToggle({
    Name = "Spam Iris's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local count = 0
                for _, character in ipairs(playersFolder:GetChildren()) do
                    if character ~= localPlayer.Character then
                        local head = character:FindFirstChild("Head")
                        if head then
                            local overheadGui = head:FindFirstChild("OverheadGui")
                            if overheadGui then
                                local upperText = overheadGui:FindFirstChild("UpperText")
                                if upperText and upperText:IsA("TextLabel") and upperText.Text == "Iris" then
                                    count = count + 1
                                end
                            end
                        end
                    end
                end
                if count >= 2 then
                    repeat
                        RunService.Heartbeat:Wait()
                        count = 0
                        for _, character in ipairs(playersFolder:GetChildren()) do
                            if character ~= localPlayer.Character then
                                local head = character:FindFirstChild("Head")
                                if head then
                                    local overheadGui = head:FindFirstChild("OverheadGui")
                                    if overheadGui then
                                        local upperText = overheadGui:FindFirstChild("UpperText")
                                        if upperText and upperText:IsA("TextLabel") and upperText.Text == "Iris" then
                                            count = count + 1
                                        end
                                    end
                                end
                            end
                        end
                    until not toggle or count <= 1
                end
                if toggle then
                    local args = {"Occupy","Iris",{Name="Iris"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events")
                        :WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Persephone
local RunService = game:GetService("RunService")
local toggle = false
local connection

SurviTab:CreateToggle({
    Name = "Spam Persephone's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local found = false
                for _, character in ipairs(playersFolder:GetChildren()) do
                    local head = character:FindFirstChild("Head")
                    if head then
                        local overheadGui = head:FindFirstChild("OverheadGui")
                        if overheadGui then
                            local upperText = overheadGui:FindFirstChild("UpperText")
                            if upperText and upperText:IsA("TextLabel") and upperText.Text == "Persephone" then
                                found = true
                                repeat RunService.Heartbeat:Wait() until not toggle or not upperText:IsDescendantOf(game) or upperText.Text ~= "Persephone"
                                if toggle then
                                    local args = {"Occupy","Persephone",{Name="Persephone"}}
                                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                                end
                                break
                            end
                        end
                    end
                end
                if not found and toggle then
                    local args = {"Occupy","Persephone",{Name="Persephone"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Eris
local RunService = game:GetService("RunService")
local toggle = false
local connection

SurviTab:CreateToggle({
    Name = "Spam Eris's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local found = false
                for _, character in ipairs(playersFolder:GetChildren()) do
                    local head = character:FindFirstChild("Head")
                    if head then
                        local overheadGui = head:FindFirstChild("OverheadGui")
                        if overheadGui then
                            local upperText = overheadGui:FindFirstChild("UpperText")
                            if upperText and upperText:IsA("TextLabel") and upperText.Text == "Eris" then
                                found = true
                                repeat RunService.Heartbeat:Wait() until not toggle or not upperText:IsDescendantOf(game) or upperText.Text ~= "Eris"
                                if toggle then
                                    local args = {"Occupy","Eris",{Name="Eris"}}
                                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                                end
                                break
                            end
                        end
                    end
                end
                if not found and toggle then
                    local args = {"Occupy","Eris",{Name="Eris"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Queen of the Underworld
local RunService = game:GetService("RunService")
local toggle = false
local connection

SurviTab:CreateToggle({
    Name = "Spam Queen of the Underworld's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local found = false
                for _, character in ipairs(playersFolder:GetChildren()) do
                    local head = character:FindFirstChild("Head")
                    if head then
                        local overheadGui = head:FindFirstChild("OverheadGui")
                        if overheadGui then
                            local upperText = overheadGui:FindFirstChild("UpperText")
                            if upperText and upperText:IsA("TextLabel") and upperText.Text == "Queen of the Underworld" then
                                found = true
                                repeat RunService.Heartbeat:Wait() until not toggle or not upperText:IsDescendantOf(game) or upperText.Text ~= "Queen of the Underworld"
                                if toggle then
                                    local args = {"Occupy","Queen of the Underworld",{Name="Queen of the Underworld"}}
                                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                                end
                                break
                            end
                        end
                    end
                end
                if not found and toggle then
                    local args = {"Occupy","Queen of the Underworld",{Name="Queen of the Underworld"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Gaia
local RunService = game:GetService("RunService")
local toggle = false
local connection

SurviTab:CreateToggle({
    Name = "Spam Gaia's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local found = false
                for _, character in ipairs(playersFolder:GetChildren()) do
                    local head = character:FindFirstChild("Head")
                    if head then
                        local overheadGui = head:FindFirstChild("OverheadGui")
                        if overheadGui then
                            local upperText = overheadGui:FindFirstChild("UpperText")
                            if upperText and upperText:IsA("TextLabel") and upperText.Text == "Gaia" then
                                found = true
                                repeat RunService.Heartbeat:Wait() until not toggle or not upperText:IsDescendantOf(game) or upperText.Text ~= "Gaia"
                                if toggle then
                                    local args = {"Occupy","Gaia",{Name="Gaia"}}
                                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                                end
                                break
                            end
                        end
                    end
                end
                if not found and toggle then
                    local args = {"Occupy","Gaia",{Name="Gaia"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Poseidon
local toggle = false
local connection
SurviTab:CreateToggle({
    Name = "Spam Poseidon's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local count = 0
                for _, character in ipairs(playersFolder:GetChildren()) do
                    if character ~= localPlayer.Character then
                        local head = character:FindFirstChild("Head")
                        if head then
                            local overheadGui = head:FindFirstChild("OverheadGui")
                            if overheadGui then
                                local upperText = overheadGui:FindFirstChild("UpperText")
                                if upperText and upperText:IsA("TextLabel") and upperText.Text == "Poseidon" then
                                    count = count + 1
                                end
                            end
                        end
                    end
                end
                if count >= 2 then
                    repeat
                        RunService.Heartbeat:Wait()
                        count = 0
                        for _, character in ipairs(playersFolder:GetChildren()) do
                            if character ~= localPlayer.Character then
                                local head = character:FindFirstChild("Head")
                                if head then
                                    local overheadGui = head:FindFirstChild("OverheadGui")
                                    if overheadGui then
                                        local upperText = overheadGui:FindFirstChild("UpperText")
                                        if upperText and upperText:IsA("TextLabel") and upperText.Text == "Poseidon" then
                                            count = count + 1
                                        end
                                    end
                                end
                            end
                        end
                    until not toggle or count <= 1
                end
                if toggle then
                    local args = {"Occupy","Poseidon",{Name="Poseidon"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events")
                        :WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Hermes
local toggle = false
local connection
SurviTab:CreateToggle({
    Name = "Spam Hermes's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local count = 0
                for _, character in ipairs(playersFolder:GetChildren()) do
                    if character ~= localPlayer.Character then
                        local head = character:FindFirstChild("Head")
                        if head then
                            local overheadGui = head:FindFirstChild("OverheadGui")
                            if overheadGui then
                                local upperText = overheadGui:FindFirstChild("UpperText")
                                if upperText and upperText:IsA("TextLabel") and upperText.Text == "Hermes" then
                                    count = count + 1
                                end
                            end
                        end
                    end
                end
                if count >= 2 then
                    repeat
                        RunService.Heartbeat:Wait()
                        count = 0
                        for _, character in ipairs(playersFolder:GetChildren()) do
                            if character ~= localPlayer.Character then
                                local head = character:FindFirstChild("Head")
                                if head then
                                    local overheadGui = head:FindFirstChild("OverheadGui")
                                    if overheadGui then
                                        local upperText = overheadGui:FindFirstChild("UpperText")
                                        if upperText and upperText:IsA("TextLabel") and upperText.Text == "Hermes" then
                                            count = count + 1
                                        end
                                    end
                                end
                            end
                        end
                    until not toggle or count <= 1
                end
                if toggle then
                    local args = {"Occupy","Hermes",{Name="Hermes"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events")
                        :WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Helios
local toggle = false
local connection
SurviTab:CreateToggle({
    Name = "Spam Helios's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local count = 0
                for _, character in ipairs(playersFolder:GetChildren()) do
                    if character ~= localPlayer.Character then
                        local head = character:FindFirstChild("Head")
                        if head then
                            local overheadGui = head:FindFirstChild("OverheadGui")
                            if overheadGui then
                                local upperText = overheadGui:FindFirstChild("UpperText")
                                if upperText and upperText:IsA("TextLabel") and upperText.Text == "Helios" then
                                    count = count + 1
                                end
                            end
                        end
                    end
                end
                if count >= 2 then
                    repeat
                        RunService.Heartbeat:Wait()
                        count = 0
                        for _, character in ipairs(playersFolder:GetChildren()) do
                            if character ~= localPlayer.Character then
                                local head = character:FindFirstChild("Head")
                                if head then
                                    local overheadGui = head:FindFirstChild("OverheadGui")
                                    if overheadGui then
                                        local upperText = overheadGui:FindFirstChild("UpperText")
                                        if upperText and upperText:IsA("TextLabel") and upperText.Text == "Helios" then
                                            count = count + 1
                                        end
                                    end
                                end
                            end
                        end
                    until not toggle or count <= 1
                end
                if toggle then
                    local args = {"Occupy","Helios",{Name="Helios"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events")
                        :WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Hades
local toggle = false
local connection
SurviTab:CreateToggle({
    Name = "Spam Hades's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local count = 0
                for _, character in ipairs(playersFolder:GetChildren()) do
                    if character ~= localPlayer.Character then
                        local head = character:FindFirstChild("Head")
                        if head then
                            local overheadGui = head:FindFirstChild("OverheadGui")
                            if overheadGui then
                                local upperText = overheadGui:FindFirstChild("UpperText")
                                if upperText and upperText:IsA("TextLabel") and upperText.Text == "Hades" then
                                    count = count + 1
                                end
                            end
                        end
                    end
                end
                if count >= 2 then
                    repeat
                        RunService.Heartbeat:Wait()
                        count = 0
                        for _, character in ipairs(playersFolder:GetChildren()) do
                            if character ~= localPlayer.Character then
                                local head = character:FindFirstChild("Head")
                                if head then
                                    local overheadGui = head:FindFirstChild("OverheadGui")
                                    if overheadGui then
                                        local upperText = overheadGui:FindFirstChild("UpperText")
                                        if upperText and upperText:IsA("TextLabel") and upperText.Text == "Hades" then
                                            count = count + 1
                                        end
                                    end
                                end
                            end
                        end
                    until not toggle or count <= 1
                end
                if toggle then
                    local args = {"Occupy","Hades",{Name="Hades"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events")
                        :WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Zeus
local RunService = game:GetService("RunService")
local toggle = false
local connection

SurviTab:CreateToggle({
    Name = "Spam Zeus's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local found = false
                for _, character in ipairs(playersFolder:GetChildren()) do
                    local head = character:FindFirstChild("Head")
                    if head then
                        local overheadGui = head:FindFirstChild("OverheadGui")
                        if overheadGui then
                            local upperText = overheadGui:FindFirstChild("UpperText")
                            if upperText and upperText:IsA("TextLabel") and upperText.Text == "Zeus" then
                                found = true
                                repeat RunService.Heartbeat:Wait() until not toggle or not upperText:IsDescendantOf(game) or upperText.Text ~= "Zeus"
                                if toggle then
                                    local args = {"Occupy","Zeus",{Name="Zeus"}}
                                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                                end
                                break
                            end
                        end
                    end
                end
                if not found and toggle then
                    local args = {"Occupy","Zeus",{Name="Zeus"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Amphitrite
local toggle = false
local connection
SurviTab:CreateToggle({
    Name = "Spam Amphitrite's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local count = 0
                for _, character in ipairs(playersFolder:GetChildren()) do
                    if character ~= localPlayer.Character then
                        local head = character:FindFirstChild("Head")
                        if head then
                            local overheadGui = head:FindFirstChild("OverheadGui")
                            if overheadGui then
                                local upperText = overheadGui:FindFirstChild("UpperText")
                                if upperText and upperText:IsA("TextLabel") and upperText.Text == "Amphitrite" then
                                    count = count + 1
                                end
                            end
                        end
                    end
                end
                if count >= 2 then
                    repeat
                        RunService.Heartbeat:Wait()
                        count = 0
                        for _, character in ipairs(playersFolder:GetChildren()) do
                            if character ~= localPlayer.Character then
                                local head = character:FindFirstChild("Head")
                                if head then
                                    local overheadGui = head:FindFirstChild("OverheadGui")
                                    if overheadGui then
                                        local upperText = overheadGui:FindFirstChild("UpperText")
                                        if upperText and upperText:IsA("TextLabel") and upperText.Text == "Amphitrite" then
                                            count = count + 1
                                        end
                                    end
                                end
                            end
                        end
                    until not toggle or count <= 1
                end
                if toggle then
                    local args = {"Occupy","Amphitrite",{Name="Amphitrite"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events")
                        :WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Selene
local toggle = false
local connection
SurviTab:CreateToggle({
    Name = "Spam Selene's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local count = 0
                for _, character in ipairs(playersFolder:GetChildren()) do
                    if character ~= localPlayer.Character then
                        local head = character:FindFirstChild("Head")
                        if head then
                            local overheadGui = head:FindFirstChild("OverheadGui")
                            if overheadGui then
                                local upperText = overheadGui:FindFirstChild("UpperText")
                                if upperText and upperText:IsA("TextLabel") and upperText.Text == "Selene" then
                                    count = count + 1
                                end
                            end
                        end
                    end
                end
                if count >= 2 then
                    repeat
                        RunService.Heartbeat:Wait()
                        count = 0
                        for _, character in ipairs(playersFolder:GetChildren()) do
                            if character ~= localPlayer.Character then
                                local head = character:FindFirstChild("Head")
                                if head then
                                    local overheadGui = head:FindFirstChild("OverheadGui")
                                    if overheadGui then
                                        local upperText = overheadGui:FindFirstChild("UpperText")
                                        if upperText and upperText:IsA("TextLabel") and upperText.Text == "Selene" then
                                            count = count + 1
                                        end
                                    end
                                end
                            end
                        end
                    until not toggle or count <= 1
                end
                if toggle then
                    local args = {"Occupy","Selene",{Name="Selene"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events")
                        :WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Athena
local toggle = false
local connection
SurviTab:CreateToggle({
    Name = "Spam Athena's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local count = 0
                for _, character in ipairs(playersFolder:GetChildren()) do
                    if character ~= localPlayer.Character then
                        local head = character:FindFirstChild("Head")
                        if head then
                            local overheadGui = head:FindFirstChild("OverheadGui")
                            if overheadGui then
                                local upperText = overheadGui:FindFirstChild("UpperText")
                                if upperText and upperText:IsA("TextLabel") and upperText.Text == "Athena" then
                                    count = count + 1
                                end
                            end
                        end
                    end
                end
                if count >= 2 then
                    repeat
                        RunService.Heartbeat:Wait()
                        count = 0
                        for _, character in ipairs(playersFolder:GetChildren()) do
                            if character ~= localPlayer.Character then
                                local head = character:FindFirstChild("Head")
                                if head then
                                    local overheadGui = head:FindFirstChild("OverheadGui")
                                    if overheadGui then
                                        local upperText = overheadGui:FindFirstChild("UpperText")
                                        if upperText and upperText:IsA("TextLabel") and upperText.Text == "Athena" then
                                            count = count + 1
                                        end
                                    end
                                end
                            end
                        end
                    until not toggle or count <= 1
                end
                if toggle then
                    local args = {"Occupy","Athena",{Name="Athena"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events")
                        :WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Circe
local RunService = game:GetService("RunService")
local toggle = false
local connection

SurviTab:CreateToggle({
    Name = "Spam Circe's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local found = false
                for _, character in ipairs(playersFolder:GetChildren()) do
                    local head = character:FindFirstChild("Head")
                    if head then
                        local overheadGui = head:FindFirstChild("OverheadGui")
                        if overheadGui then
                            local upperText = overheadGui:FindFirstChild("UpperText")
                            if upperText and upperText:IsA("TextLabel") and upperText.Text == "Circe" then
                                found = true
                                repeat RunService.Heartbeat:Wait() until not toggle or not upperText:IsDescendantOf(game) or upperText.Text ~= "Circe"
                                if toggle then
                                    local args = {"Occupy","Circe",{Name="Circe"}}
                                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                                end
                                break
                            end
                        end
                    end
                end
                if not found and toggle then
                    local args = {"Occupy","Circe",{Name="Circe"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Hera
local RunService = game:GetService("RunService")
local toggle = false
local connection

SurviTab:CreateToggle({
    Name = "Spam Hera's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local found = false
                for _, character in ipairs(playersFolder:GetChildren()) do
                    local head = character:FindFirstChild("Head")
                    if head then
                        local overheadGui = head:FindFirstChild("OverheadGui")
                        if overheadGui then
                            local upperText = overheadGui:FindFirstChild("UpperText")
                            if upperText and upperText:IsA("TextLabel") and upperText.Text == "Hera" then
                                found = true
                                repeat RunService.Heartbeat:Wait() until not toggle or not upperText:IsDescendantOf(game) or upperText.Text ~= "Hera"
                                if toggle then
                                    local args = {"Occupy","Hera",{Name="Hera"}}
                                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                                end
                                break
                            end
                        end
                    end
                end
                if not found and toggle then
                    local args = {"Occupy","Hera",{Name="Hera"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

-- Hecate
local RunService = game:GetService("RunService")
local toggle = false
local connection

SurviTab:CreateToggle({
    Name = "Spam Hecate's Slot",
    CurrentValue = false,
    Callback = function(Value)
        toggle = Value
        if toggle then
            connection = RunService.Heartbeat:Connect(function()
                if not toggle then return end
                local playersFolder = workspace:FindFirstChild("Players")
                if not playersFolder then return end
                local found = false
                for _, character in ipairs(playersFolder:GetChildren()) do
                    local head = character:FindFirstChild("Head")
                    if head then
                        local overheadGui = head:FindFirstChild("OverheadGui")
                        if overheadGui then
                            local upperText = overheadGui:FindFirstChild("UpperText")
                            if upperText and upperText:IsA("TextLabel") and upperText.Text == "Hecate" then
                                found = true
                                repeat RunService.Heartbeat:Wait() until not toggle or not upperText:IsDescendantOf(game) or upperText.Text ~= "Hecate"
                                if toggle then
                                    local args = {"Occupy","Hecate",{Name="Hecate"}}
                                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                                end
                                break
                            end
                        end
                    end
                end
                if not found and toggle then
                    local args = {"Occupy","Hecate",{Name="Hecate"}}
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(args))
                end
            end)
        else
            if connection then connection:Disconnect() connection=nil end
        end
    end
})

ExtrTab:CreateSection("TP")

ExtrTab:CreateButton({
    Name = "Teleport To Top Of Temple",
    Callback = function()
local player = game.Players.LocalPlayer
local targetPosition = Vector3.new(212.89, 94.27, 35.37)

player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
})

ExtrTab:CreateButton({
    Name = "Teleport To Center Of Temple",
    Callback = function()
local player = game.Players.LocalPlayer
local targetPosition = Vector3.new(213.16, 33.40, -21.98)

player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
})

ExtrTab:CreateButton({
    Name = "Teleport To Center Of Village",
    Callback = function()
local player = game.Players.LocalPlayer
local targetPosition = Vector3.new(214.25, 11.75, -160.82)

player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
})

ExtrTab:CreateButton({
    Name = "Teleport To 1st Big Temple",
    Callback = function()
        local targetPosition = Vector3.new(-3.91, 12.56, -141.13)
        local player = game.Players.LocalPlayer

        if player.Character and player.Character.PrimaryPart then
            player.Character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
        end
    end
})

ExtrTab:CreateButton({
    Name = "Teleport To 2nd Big Temple",
    Callback = function()
local player = game.Players.LocalPlayer
local targetPosition = Vector3.new(419.11, 12.19, -138.42)

player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
})

ExtrTab:CreateButton({
    Name = "Teleport To Back Of Temple",
    Callback = function()
local player = game.Players.LocalPlayer
local targetPosition = Vector3.new(215.17, 12.35, 263.22)

player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
})

ExtrTab:CreateButton({
    Name = "Teleport To 1st Village",
    Callback = function()
local player = game.Players.LocalPlayer
local targetPosition = Vector3.new(-13.91, 12.38, 112.85)

player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
})

ExtrTab:CreateButton({
    Name = "Teleport To 2nd Village",
    Callback = function()
local player = game.Players.LocalPlayer
local targetPosition = Vector3.new(441.90, 12.92, 99.86)

player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
})

ExtrTab:CreateButton({
    Name = "Teleport Ontop Map Barrier",
    Callback = function()
local player = game.Players.LocalPlayer
local targetPosition = Vector3.new(205.61, 326.92, 11.72)

player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
})

ExtrTab:CreateButton({
    Name = "Teleport To Nyxs Dimension",
    Callback = function()
local player = game.Players.LocalPlayer
local targetPosition = Vector3.new(157.64, 298.91, -1774.44)

player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
})

ExtrTab:CreateButton({
    Name = "Teleport To Spawn Box",
    Callback = function()
local player = game.Players.LocalPlayer
local targetPosition = Vector3.new(215.56, -98.05, -114.35)

player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
})

ExtrTab:CreateButton({
    Name = "Teleport Inside Random House",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            -- List of positions
            local positions = {
                Vector3.new(-32.46, 11.87, 108.32),
                Vector3.new(45.04, 12.00, -2.18),
                Vector3.new(62.65, 11.84, 263.01),
                Vector3.new(377.97, 12.79, 111.37),
                Vector3.new(419.63, 12.63, -27.44),
                Vector3.new(500.40, 12.62, 66.65)
            }

            -- Pick a random position
            local randomPos = positions[math.random(1, #positions)]

            -- Teleport
            character.HumanoidRootPart.CFrame = CFrame.new(randomPos)
        else
            warn("Character or HumanoidRootPart not found!")
        end
    end
})

ExtrTab:CreateButton({
    Name = "Teleport Inside Main Temple",
    Callback = function()
local player = game.Players.LocalPlayer
local targetPosition = Vector3.new(213.22, 37.82, 58.97)

player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
})

ExtrTab:CreateButton({
    Name = "Teleport Under Map",
    Callback = function()
local player = game.Players.LocalPlayer
local targetPosition = Vector3.new(214.49, 1.65, -171.42)

player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
})

ExtrTab:CreateButton({
    Name = "Teleport Outside Map",
    Callback = function()
local player = game.Players.LocalPlayer
local targetPosition = Vector3.new(209.03, 1.65, -730.22)

player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
})

ExtrTab:CreateSection("Player Stuff")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local targetName = nil

-- === Find Target By Partial Username ===
local function findTargetPlayer()
    if not targetName or targetName == "" then return nil end
    local matches = {}

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and string.find(player.Name:lower(), targetName:lower()) then
            table.insert(matches, player)
        end
    end

    if #matches == 1 then
        return matches[1]
    elseif #matches > 1 then
        warn("Multiple players match that username. Be more specific.")
        return nil
    else
        return nil
    end
end

-- === Spectate Player ===
local function viewTargetPlayer()
    local targetPlayer = findTargetPlayer()
    if targetPlayer and targetPlayer.Character then
        local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            Camera.CameraType = Enum.CameraType.Custom
            Camera.CameraSubject = humanoid
        else
            warn("Target player's humanoid not found.")
        end
    else
        if targetName then
            warn("No matching player found for: " .. targetName)
        end
    end
end

ExtrTab:CreateLabel("Note: You can use partial usernames if you don't want to type the whole username.", 18638286567)

local Input = ExtrTab:CreateInput({
    Name = "Spectate Player",
    CurrentValue = "",
    PlaceholderText = "Enter Username",
    RemoveTextAfterFocusLost = false,
    Flag = "Input1",
    Callback = function(Text)
        targetName = Text
        viewTargetPlayer()
    end,
})


ExtrTab:CreateButton({
   Name = "Unspectate Player",
   Callback = function()
   local Camera = game:GetService("Workspace").CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function unviewTarget()
    Camera.CameraType = Enum.CameraType.Custom
    Camera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
end

unviewTarget()
   end,
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local targetName = nil

-- === Find Target By Partial Username ===
local function findTargetPlayer()
    if not targetName or targetName == "" then return nil end
    local matches = {}

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and string.find(player.Name:lower(), targetName:lower()) then
            table.insert(matches, player)
        end
    end

    if #matches == 1 then
        return matches[1]
    elseif #matches > 1 then
        warn("Multiple players match that username. Be more specific.")
        return nil
    else
        return nil
    end
end

-- === Teleport to Player ===
local function teleportToPlayer()
    local targetPlayer = findTargetPlayer()
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = targetPlayer.Character.HumanoidRootPart
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = hrp.CFrame + Vector3.new(0, 3, 0) -- small offset above target
        else
            warn("Your character's HumanoidRootPart not found.")
        end
    else
        if targetName then
            warn("No matching player found for: " .. targetName)
        end
    end
end

local Input = ExtrTab:CreateInput({
    Name = "Teleport to Player",
    CurrentValue = "",
    PlaceholderText = "Enter Username",
    RemoveTextAfterFocusLost = false,
    Flag = "Input1",
    Callback = function(Text)
        targetName = Text
        teleportToPlayer()
    end,
})

-- Teleport to Random Player Button
ExtrTab:CreateButton({
    Name = "Teleport To Random Player",
    Callback = function()
        local players = game:GetService("Players")
        local localPlayer = players.LocalPlayer

        local function teleportToPlayer(player)
            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                localPlayer.Character:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame)
            end
        end

        -- Find players without "OverHead" in their Head part
        local validPlayers = {}
        for _, player in pairs(players:GetPlayers()) do
            if player ~= localPlayer 
                and player.Character 
                and player.Character:FindFirstChild("Head") 
                and not player.Character.Head:FindFirstChild("OverHead") then
                table.insert(validPlayers, player)
            end
        end

        -- Teleport to a random valid player
        if #validPlayers > 0 then
            local randomPlayer = validPlayers[math.random(1, #validPlayers)]
            teleportToPlayer(randomPlayer)
        else
            print("No valid players found without OverHead.")
        end
    end
})

-- Section for Other
ExtrTab:CreateSection("Other")

-- Click To Teleport Toggle
local clickDetector = Instance.new("ClickDetector") -- Create a click detector
local indicatorActive = false
local teleportConnection

ExtrTab:CreateToggle({
    Name = "Click To Teleport",
    Callback = function(state)
        if state then
            -- Activate click detector
            clickDetector.Parent = workspace

            local player = game.Players.LocalPlayer
            local mouse = player:GetMouse()

            -- Disconnect any existing teleport connection
            if teleportConnection then
                teleportConnection:Disconnect()
            end

            -- Teleport to clicked position
            teleportConnection = mouse.Button1Down:Connect(function()
                player.Character:SetPrimaryPartCFrame(CFrame.new(mouse.Hit.p))
            end)

            indicatorActive = true
        else
            -- Deactivate click detector and disconnect teleport connection
            if clickDetector then
                clickDetector.Parent = nil
            end
            if teleportConnection then
                teleportConnection:Disconnect()
            end
            indicatorActive = false
        end
    end
})

SigmaTab:CreateSection("Game")

SigmaTab:CreateLabel("Nothing here yet..", 18638286567)

GameTab:CreateToggle({
   Name = "Telekinesis Glitch (Must Be Hecate)",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
       local Players = game:GetService("Players")
       local ReplicatedStorage = game:GetService("ReplicatedStorage")
       local localPlayer = Players.LocalPlayer
       local radius = 20
       local currentTarget = nil
       local outlineEffects = {}

       local function getNearbyPlayers(radius)
           local nearbyPlayers = {}
           local myChar = localPlayer.Character
           if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then
               return nearbyPlayers
           end
           local myPosition = myChar.HumanoidRootPart.Position

           for _, player in pairs(Players:GetPlayers()) do
               if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                   local distance = (player.Character.HumanoidRootPart.Position - myPosition).magnitude
                   if distance <= radius then
                       table.insert(nearbyPlayers, player)
                   end
               end
           end
           return nearbyPlayers
       end

       local function addOutlineEffect(player)
           local character = player.Character
           if character then
               local selectionBoxes = {}
               for _, part in pairs(character:GetChildren()) do
                   if part:IsA("MeshPart") or part:IsA("Part") then
                       local outline = Instance.new("SelectionBox")
                       outline.Adornee = part
                       outline.Color3 = Color3.fromRGB(255, 105, 180)
                       outline.Thickness = 0.1
                       outline.Parent = part
                       outline.Transparency = 0.5
                       table.insert(selectionBoxes, outline)
                   end
               end
               return selectionBoxes
           end
       end

       local function removeOutlineEffect(player)
           local character = player.Character
           if character then
               for _, part in pairs(character:GetChildren()) do
                   if part:IsA("MeshPart") or part:IsA("Part") then
                       for _, child in pairs(part:GetChildren()) do
                           if child:IsA("SelectionBox") then
                               child:Destroy()
                           end
                       end
                   end
               end
           end
       end

       if Value then
           while Value do
               wait(1)
               local nearbyPlayers = getNearbyPlayers(radius)

               for _, player in ipairs(nearbyPlayers) do
                   if not outlineEffects[player] then
                       local outline = addOutlineEffect(player)
                       outlineEffects[player] = outline
                   end
               end

               if currentTarget then
                   for i, player in ipairs(nearbyPlayers) do
                       if player == currentTarget then
                           table.remove(nearbyPlayers, i)
                           break
                       end
                   end
               end

               if #nearbyPlayers > 0 then
                   local targetPlayer = nearbyPlayers[math.random(1, #nearbyPlayers)]
                   currentTarget = targetPlayer
                   local args = {
                       "Telekinesis",
                       localPlayer.Character,
                       targetPlayer.Character
                   }
                   ReplicatedStorage:WaitForChild("Events"):WaitForChild("AbilityTrigger"):InvokeServer(unpack(args))
               end
           end
       else
           for player, _ in pairs(outlineEffects) do
               removeOutlineEffect(player)
           end
           outlineEffects = {}
           currentTarget = nil
       end
   end,
})


-- EventTab Sections
EvntTab:CreateSection("Info")
EvntTab:CreateParagraph({Title = "Olympus Script Developers🛠️", Content = "Kermisha & MotherOfGrass & Moon"})
EvntTab:CreateParagraph({Title = "Support Discord DMS💬", Content = "kermishaurfavx & grassmother & themoonandsunreuinite"})
EvntTab:CreateParagraph({Title = "Script Updates✨", Content = "Release!"})
EvntTab:CreateParagraph({Title = "Ban Risk⛔", Content = "MEDIUM"})
EvntTab:CreateParagraph({Title = "Exploit Patches🧪", Content = "0 - yay"})

EvntTab:CreateParagraph({Title = "Note From Hub Developers📝", Content = "If you don't wanna get banned from olympus don't use stuff that people can record and report, everything else is safe <3"})






