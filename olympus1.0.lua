local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Kermisha's Gui",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Loading gui..",
   LoadingSubtitle = "by kermisha",
   ShowText = "Hide/Show", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Bloom", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Kermisha",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "TRasd", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Locked"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Tab = Window:CreateTab("Combat", "crown")

local Crw = Window:CreateTab("Characters", "crown")

local Button = Crw:CreateButton({
   Name = "Custom1",
   Callback = function()
   -- The function that takes place when the button is pressed
   end,
})

local Button = Crw:CreateButton({
   Name = "Custom2",
   Callback = function()
   -- The function that takes place when the button is pressed
   end,
})

local Button = Crw:CreateButton({
   Name = "Custom3",
   Callback = function()
   -- The function that takes place when the button is pressed
   end,
})

local Label = Tab:CreateLabel("Anodite", "rewind")

local Button = Tab:CreateButton({
   Name = "Mass Bubble",
   Callback = function()
   -- The function that takes place when the button is pressed
   end,
})

local Dropdown = Tab:CreateDropdown({
    Name = "Player List",
    Options = (function()
        local names = {}
        for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
            table.insert(names, plr.Name)
        end
        return names
    end)(),
    CurrentOption = {},
    MultipleOptions = false,
    Flag = "Dropdown1",
    Callback = function(Options)
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local selected = Options[1]
        local target = Players:FindFirstChild(selected)
        if target and target.Character and target.Character:FindFirstChild("Head") then
            task.spawn(function()
                while true do
                    local args = {
                        {
                            NAME = "Bubble",
                            FUNCTION = "ACTIVE"
                        },
                        CFrame.new(-50.657955169677734, 1.8605097532272339, 142.15611267089844, -0.2921024262905121, 0.43180471658706665, -0.8533586263656616, -0, 0.8922733068466187, 0.45149579644203186, 0.9563870429992676, 0.13188301026821136, -0.2606351971626282),
                        target.Character:WaitForChild("Head")
                    }
                    ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("ServerRemote"):FireServer(unpack(args))
                    task.wait(1)
                end
            end)
        end
    end,
})


