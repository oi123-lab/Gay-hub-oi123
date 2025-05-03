local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/Library-ui/refs/heads/main/Redzhubui"))()
local Window = redzlib:MakeWindow({
  Title = "MATRIX HUB v0.1 : MEME SEA",
  SubTitle = "by MATRIX COMMUNITY",
  SaveFolder = "MatrixHubConfigs"
})

local Tabs = {
  Main = Window:AddTab({ Title = "Main", Icon = "house" }),
  Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

Tabs.Main:AddSection("Auto farm")

Tabs.Main:AddDropdown("Fighting style", {
  Title = "Fighting style",
  Values = {"Melee", "Weapons"},
  Multi = false,
  Default = "Melee",
  Callback = function(Value)
    
    getgenv().EquipStyle = Value
    
  end
})

Tabs.Main:AddSlider("Player height", {
  Title = "Player height",
  Description = "",
  Default = 7,
  Min = 5,
  Max = 15,
  Rounding = 10,
  Callback = function(Value)
    getgenv().HeightPlayer = Value
  end
})

local Autofarmtoggle = Tabs.Main:AddToggle("Auto farm", {
  Title = "Auto farm", 
  Default = false,
  Callback= function(Value)
    RaelHubMemeSea.GetLevelAndQuest(Value)
    RaelHubMemeSea.AutoFarm(Value)
    
  end
})

Tabs.Main:AddToggle("Auto click", {
  Title = "Auto click", 
  Default = false,
  Callback= function(Value)
    
    RaelHubMemeSea.AutoClicker(Value)
    
  end
})

local ListMonsterDropDown

Tabs.Main:AddSection("Auto farm monster selected")

Tabs.Main:AddDropdown("List monster", {
  Title = "List monster",
  Values = GetListMonsters,
  Multi = false,
  Default = "...",
  Callback = function(Value)
    
    ListMonsterDropDown = Value
    
  end
})

Tabs.Main:AddToggle("Auto farm monster selected", {
  Title = "Auto farm monster selected", 
  Default = false,
  Callback= function(Value)
    
    if Value then
      Autofarmtoggle:SetValue(false)
    end
    RaelHubMemeSea.AutoFarmMonsterSelected(ListMonsterDropDown, Value)
    
  end
})

local ListBossDropDown

Tabs.Main:AddSection("Auto farm boss")

Tabs.Main:AddDropdown("List Boss", {
  Title = "List Boss",
  Values = {"Giant Pumpkin", "Evil Noob", "Lord Sus"},
  Multi = false,
  Default = "...",
  Callback = function(Value)
    
    ListBossDropDown = Value
    
  end
})

Tabs.Main:AddToggle("Auto farm boss summoner", {
  Title = "Auto farm boss", 
  Default = false,
  Callback= function(Value)
    
    RaelHubMemeSea.AutoFarmBoss(ListBossDropDown, Value)
    
  end
})

Tabs.Main:AddSection("Pop cat click")

Tabs.Main:AddToggle("Auto click cat", {
  Title = "Auto click cat", 
  Default = false,
  Callback= function(Value)
    
    RaelHubMemeSea.AutoClickCat(Value)
    
  end
})

Tabs.Main:AddButton({
  Title = "Teleport to pop cat",
  Description = "",
  Callback = function()
    local FloppaIsland = workspace.Island:FindFirstChild("FloppaIsland")
    local PlayerCharacter = game.Players.LocalPlayer.Character
    if FloppaIsland then
      local Popcat_Clickable = FloppaIsland:FindFirstChild("Popcat_Clickable")
      if Popcat_Clickable then
        local Part = Popcat_Clickable:FindFirstChild("Part")
        
        if Part then
          local humanoidrootpart = PlayerCharacter:FindFirstChild("HumanoidRootPart")
          if humanoidrootpart then
            humanoidrootpart.CFrame = CFrame.new(Part.Position)
          end
        end
      end
    end
  end
})

Tabs.Main:AddButton({
  Title = "Show clicks cat",
  Description = "",
  Callback = function()
    Fluent:Notify({
      Title = "Pop cat clicks: " .. RaelHubMemeSea.ShowClickCat(),
      Content = "",
      SubContent = "",
      Duration = 3
    })
  end
})

InterfaceManager:SetLibrary(Fluent)
InterfaceManager:BuildInterfaceSection(Tabs.Settings)

Window:SelectTab(1)
