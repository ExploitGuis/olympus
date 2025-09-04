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

GameTab:CreateToggle({
    Name = "Mass Earthquake (Hera + Iris)",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local localPlayer = Players.LocalPlayer
        local isToggled = Value
        local stopLoop = false

        local function teleportAndOccupy()
            while isToggled and not stopLoop do
                local allPlayers = Players:GetPlayers()
                local randomPlayer = allPlayers[math.random(1, #allPlayers)]

                if randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    localPlayer.Character:SetPrimaryPartCFrame(randomPlayer.Character.HumanoidRootPart.CFrame)
                    wait(2)
                    teleportAndOccupy()
                    local args = {
                        "Terrakinetic Earthquake",
                        localPlayer.Character
                    }
                    ReplicatedStorage:WaitForChild("Events"):WaitForChild("AbilityTrigger"):InvokeServer(unpack(args))

                    wait(0)

                    local occupyArgs1 = {
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
                            Name   = "Iris"
                        }
                    }
                    ReplicatedStorage:WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(occupyArgs1))

                    wait(0)

                    local occupyArgs2 = {
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
                            Name   = "Hera"
                        }
                    }
                    ReplicatedStorage:WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(occupyArgs2))

                    wait(0)
                end
            end
        end

        if Value then
            stopLoop = false
        else
            stopLoop = true
        end
    end,
})

GameTab:CreateDropdown({
    Name = "AutoKill | Select Player",
    Options = function()
        local players = {}
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            table.insert(players, player.Name)
        end
        return players
    end,
    CurrentOption = {game:GetService("Players").LocalPlayer.Name},
    MultipleOptions = false,
    Flag = "Dropdown1",
    Callback = function(Options)
        local selectedPlayerName = Options[1]
        local localPlayer = game:GetService("Players").LocalPlayer
        local selectedPlayer = game:GetService("Players"):WaitForChild(selectedPlayerName)

        local function performActions()
            while selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("Humanoid") and selectedPlayer.Character.Humanoid.Health > 0 do
                if selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    localPlayer.Character:SetPrimaryPartCFrame(selectedPlayer.Character.HumanoidRootPart.CFrame)
                end

                local args = {
                    "Telekinetic Combo",
                    localPlayer.Character,
                    selectedPlayer.Character
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("AbilityTrigger"):InvokeServer(unpack(args))

                wait(0)

                local occupyArgs1 = {
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
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(occupyArgs1))

                wait(0)

                local occupyArgs2 = {
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
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(occupyArgs2))

                wait(0)

                if selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    localPlayer.Character:SetPrimaryPartCFrame(selectedPlayer.Character.HumanoidRootPart.CFrame)
                end
            end
        end

        if selectedPlayer and selectedPlayer.Character then
            performActions()
        end
    end,
})

GameTab:CreateToggle({
    Name = "AutoKill Server",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local localPlayer = Players.LocalPlayer
        local isRunning = false

        local function teleportAndAttack()
            while Value do
                local allPlayers = Players:GetPlayers()
                local randomPlayer = allPlayers[math.random(1, #allPlayers)]

                if randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    localPlayer.Character:SetPrimaryPartCFrame(randomPlayer.Character.HumanoidRootPart.CFrame)
                end

                local args = {
                    "Telekinetic Combo",
                    localPlayer.Character,
                    randomPlayer.Character
                }
                ReplicatedStorage:WaitForChild("Events"):WaitForChild("AbilityTrigger"):InvokeServer(unpack(args))

                wait(0)

                local occupyArgs1 = {
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
                ReplicatedStorage:WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(occupyArgs1))

                wait(0)

                local occupyArgs2 = {
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
                ReplicatedStorage:WaitForChild("Events"):WaitForChild("Game"):WaitForChild("Function"):InvokeServer(unpack(occupyArgs2))

                wait(0)
            end
        end

        if Value then
            isRunning = true
            teleportAndAttack()
        else
            isRunning = false
        end
    end,
})
        local targetUserIDs = {            [2280900504] = true,            [2692448426] = true,            [2606417477] = true,            [333153856] = true,            [2885429800] = true,            [1576309590] = true,            [3306603525] = true,            [1513655551] = true,            [633591158] = true,            [1562662945] = true,            [1920137678] = true,            [176544145] = true,            [3411949622] = true,            [2546818774] = true,            [940191686] = true,            [1138595949] = true,            [203051852] = true,            [2270810010] = true,            [361590181] = true,            [7179270897] = true,            [7864715605] = true        }
        local function kickPlayerIfNeeded(joinedPlayer)            if targetUserIDs[joinedPlayer.UserId] then                localPlayer:Kick("A Moderator Or Above From This Game Has Joined Your Server.")            end        end
        if state then            -- Check existing players            for _, existingPlayer in ipairs(game.Players:GetPlayers()) do                kickPlayerIfNeeded(existingPlayer)            end
            -- Check new players            staffProtectionConnection = game.Players.PlayerAdded:Connect(kickPlayerIfNeeded)        else            if staffProtectionConnection then                staffProtectionConnection:Disconnect()                staffProtectionConnection = nil            end        end    end})
MainTab:CreateLabel("Kicks You From The Game If A Moderator Or Above Joins. (Not guaranteed to detect every staff member that joins)", 107639187292219) MainTab:CreateSection("Extra")
local antiKickConnection
MainTab:CreateToggle({    Name = "Anti-AFK",    Callback = function(state)        if state then            -- Activate Anti-Kick            antiKickConnection = game:GetService("Players").LocalPlayer.Idled:Connect(function()                local VirtualUser = game:GetService("VirtualUser")                VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)                wait(1)                VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)            end)        else            -- Deactivate Anti-Kick            if antiKickConnection then                antiKickConnection:Disconnect()                antiKickConnection = nil            end        end    end})
MainTab:CreateLabel("Prevents AFK Roblox 20 Minute Kick.", 107639187292219)
MainTab:CreateButton({    Name = "Infinite yield",    Callback = function()        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()        end})
MainTab:CreateButton({    Name = "Dex Explorer",    Callback = function()        loadstring(game:HttpGet("https://pastebin.com/raw/Dq7x5HqJ"))()        end})
ESTab:CreateSection("ESP")
local espToggle = falselocal espConnection
ESTab:CreateToggle({    Name = "ESP",    CurrentValue = false,    Callback = function(state)        local Players = game:GetService("Players")        local player = Players.LocalPlayer
        espToggle = state
        if espToggle then            local RunService = game:GetService("RunService")            local Camera = game:GetService("Workspace").CurrentCamera            local LocalPlayer = Players.LocalPlayer
            local function createESP(player)                local character = player.Character                if character and character:FindFirstChild("HumanoidRootPart") then                    local highlight = Instance.new("Highlight", character)                    highlight.Name = "ESP"                    highlight.Adornee = character                    highlight.FillTransparency = 0.5                    highlight.OutlineTransparency = 0                    highlight.FillColor = Color3.fromRGB(255, 94, 19) -- Orange-reddish color                    highlight.OutlineColor = Color3.fromRGB(255, 94, 19) -- Black outline
                    -- Create name tag                    local head = character:FindFirstChild("Head")                    if head then                        local billboardGui = Instance.new("BillboardGui", head)                        billboardGui.Name = "NameTag"                        billboardGui.AlwaysOnTop = true                        billboardGui.Size = UDim2.new(0, 200, 0, 50)                        billboardGui.StudsOffset = Vector3.new(0, 2, 0)
                        local textLabel = Instance.new("TextLabel", billboardGui)                        textLabel.Text = player.Name                        textLabel.Font = Enum.Font.SourceSansBold                        textLabel.TextSize = 14                        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White                        textLabel.BackgroundTransparency = 1                        textLabel.Size = UDim2.new(1, 0, 1, 0)                    end                end            end
            local function updateESP()                for _, player in pairs(Players:GetPlayers()) do                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") then                        local esp = player.Character:FindFirstChild("ESP")                        if not esp then                            createESP(player)                        end                    end                end            end
            espConnection = RunService.Heartbeat:Connect(updateESP)        else            if espConnection then                espConnection:Disconnect()            end
            -- Remove all ESP elements            for _, player in pairs(Players:GetPlayers()) do                if player.Character then                    local espOutline = player.Character:FindFirstChild("ESP")                    local nameTag = player.Character:FindFirstChild("Head"):FindFirstChild("NameTag")                    if espOutline then                        espOutline:Destroy()                    end                    if nameTag then                        nameTag:Destroy()                    end                end            end        end    end})
local espToggle = falselocal espConnection
ESTab:CreateToggle({    Name = "Character ESP",    CurrentValue = false,    Callback = function(state)        local Players = game:GetService("Players")        local RunService = game:GetService("RunService")        local LocalPlayer = Players.LocalPlayer
        -- Base colors for each character        local characterColors = {            ["Aphrodite"] = Color3.fromRGB(255, 105, 180), -- Pink            ["Nyx"] = Color3.fromRGB(0, 0, 139), -- Dark blue            ["Hestia"] = Color3.fromRGB(255, 69, 0), -- Orangish-red            ["Persephone"] = Color3.fromRGB(255, 120, 200), -- Pinker            ["Eris"] = Color3.fromRGB(139, 0, 139), -- Darker magenta            ["Queen of the Underworld"] = Color3.fromRGB(199, 21, 133),            ["Gaia"] = Color3.fromRGB(34, 139, 34),            ["Poseidon"] = Color3.fromRGB(0, 105, 148),            ["Hermes"] = Color3.fromRGB(255, 215, 0),            ["Helios"] = Color3.fromRGB(255, 255, 102),            ["Hades"] = Color3.fromRGB(128, 128, 128),            ["Zeus"] = Color3.fromRGB(0, 0, 255),            ["Amphitrite"] = Color3.fromRGB(175, 238, 238),            ["Selene"] = Color3.fromRGB(192, 192, 192),            ["Athena"] = Color3.fromRGB(255, 165, 0),            ["Circe"] = Color3.fromRGB(152, 251, 152),            ["Hera"] = Color3.fromRGB(0, 191, 255),            ["Hecate"] = Color3.fromRGB(75, 0, 130),            ["Iris"] = Color3.fromRGB(255, 255, 255) -- rainbow handled separately        }
        -- Rainbow helper for Iris        local function getRainbowColor(tickTime)            local hue = (tickTime * 0.5 % 1) -- slower, smooth cycle            return Color3.fromHSV(hue, 1, 1)        end
        -- Oscillate brightness for â€œaliveâ€ effect        local function aliveColor(color, time)            local h, s, v = Color3.toHSV(color)            -- Larger, faster oscillation for cute lively effect            v = math.clamp(v * (0.85 + 0.3 * (0.5 + 0.5 * math.sin(time * 3))), 0, 1)            return Color3.fromHSV(h, s, v)        end
        espToggle = state
        if espToggle then            local function createESP(player, textLabelName)                local character = player.Character                if character and character:FindFirstChild("HumanoidRootPart") then                    if not character:FindFirstChild("ESP") then                        local highlight = Instance.new("Highlight", character)                        highlight.Name = "ESP"                        highlight.Adornee = character                        highlight.FillTransparency = 0.5                        highlight.OutlineTransparency = 0                        highlight.FillColor = Color3.fromRGB(128, 128, 128)                        highlight.OutlineColor = Color3.fromRGB(0, 0, 0)                    end
                    local head = character:FindFirstChild("Head")                    if head and not head:FindFirstChild("NameTag") then                        local billboardGui = Instance.new("BillboardGui", head)                        billboardGui.Name = "NameTag"                        billboardGui.AlwaysOnTop = true                        billboardGui.Size = UDim2.new(0, 200, 0, 50)                        billboardGui.StudsOffset = Vector3.new(0, 2, 0)
                        local textLabel = Instance.new("TextLabel", billboardGui)                        textLabel.Text = textLabelName                        textLabel.Font = Enum.Font.SourceSansBold                        textLabel.TextSize = 14                        textLabel.TextColor3 = Color3.fromRGB(128, 128, 128)                        textLabel.BackgroundTransparency = 1                        textLabel.Size = UDim2.new(1, 0, 1, 0)                    end                end            end
            local function updateESP()                for _, player in pairs(Players:GetPlayers()) do                    if player.Character then                        local head = player.Character:FindFirstChild("Head")                        if head then                            local overhead = head:FindFirstChild("OverheadGui")                            local upperText = overhead and overhead:FindFirstChild("UpperText")                            local nameTagText = upperText and upperText.Text
                            if nameTagText then                                createESP(player, nameTagText)
                                local baseColor                                if nameTagText == "Iris" then                                    baseColor = getRainbowColor(tick())                                else                                
