local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Star-dos-scripts/OrionLibYellow/refs/heads/main/README.md')))()

local Window = OrionLib:MakeWindow({Name = "MATRIX HUB V2 : BY TEAM CARTOLA CENTER🎩", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

--[[
Name = <MATRIX HUB FLING BOAT🛳> - The name of the UI.
HidePremium = <bool> - Whether or not the user details shows Premium status or not.
SaveConfig = <bool> - Toggles the config saving in the UI.
ConfigFolder = <string> - The name of the folder where the configs are saved.
IntroEnabled = <bool> - Whether or not to show the intro animation.
IntroText = <string> - Text to show in the intro animation.
IntroIcon = <string> - URL to the image you want to use in the intro animation.
Icon = <string> - URL to the image you want displayed on the window.
CloseCallback = <function> - Function to execute when the window is closed.
]]

local Tab = Window:MakeTab({
	Name = "BEM VINDO",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddParagraph("BEM VINDO MEU NOBRE🧐🎩","Paragraph Content")

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]

local Tab = Window:MakeTab({
Name = "boat fling🛳",

Icon = "rbxassetid://4483345998",

PremiumOnly = false

})

local Players = game:GetService("Players")

local playerNames = {}

for _, player in pairs(Players:GetPlayers()) do

table.insert(playerNames, player.Name)

end

local selectedPlayerName = nil

Tab:AddDropdown({

Name = "jogadores!",

Options = playerNames,

Callback = function(selected)

selectedPlayerName = selected

end

})

Tab:AddButton({

Name = " fling boat🛳",

Callback = function()

if selectedPlayerName then

local selectedPlayer = game.Players:FindFirstChild(selectedPlayerName)

if selectedPlayer then

local Player = game.Players.LocalPlayer

local Character = Player.Character

local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")

local Vehicles = game.Workspace:FindFirstChild("Vehicles")

local OldPos = RootPart and RootPart.CFrame

if RootPart and Vehicles then

local PCar = Vehicles:FindFirstChild(Player.Name.."Car")

if not PCar then

RootPart.CFrame = CFrame.new(-3, -4, 2105)

task.wait(0.5)

game:GetService("ReplicatedStorage").RE["1Ca1r"]:FireServer("PickingBoat", "MilitaryBoatFree")

task.wait(0.5)

PCar = Vehicles:FindFirstChild(Player.Name.."Car")

if PCar then

local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")

if Seat then

repeat

task.wait()

RootPart.CFrame = Seat.CFrame * CFrame.new(0, 2, 0)

until Humanoid and Humanoid.Sit

end

end

end

local TargetC = selectedPlayer.Character

local TargetH = TargetC and TargetC:FindFirstChildOfClass("Humanoid")

local TargetRP = TargetC and TargetC:FindFirstChild("HumanoidRootPart")

if PCar and TargetC and TargetH and TargetRP then

if not TargetH.Sit then

while not TargetH.Sit do

task.wait()

PCar:SetPrimaryPartCFrame(TargetRP.CFrame * CFrame.new(0, -2, 0))

end

task.wait(0.1)

local AngularVelocity = Instance.new("BodyAngularVelocity")

AngularVelocity.AngularVelocity = Vector3.new(70, 0, 0)

AngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

AngularVelocity.Parent = PCar.PrimaryPart

task.wait(1)

local launchDirection = Vector3.new(math.random(-1, 1), 1, math.random(-1, 1)).unit * 50

local BodyVelocity = Instance.new("BodyVelocity")

BodyVelocity.Velocity = launchDirection

BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

BodyVelocity.Parent = PCar.PrimaryPart

task.wait(0.5)

BodyVelocity:Destroy()

AngularVelocity:Destroy()

if Humanoid then Humanoid.Sit = false end

task.wait(0.1)

if RootPart then RootPart.CFrame = OldPos end

end

end

end

else

print("tu tento pega um jogador que kitou ou que ta bugado")

end

else

print("seleciona um jogador filho da puta animal")

end

end

})


local Tab = Window:MakeTab({
	Name = "Scripts universais",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]

Tab:AddButton({
	Name = "infinite yield",
	Callback = function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
      		print("button pressed")
  	end    
})

--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]


Tab:AddButton({
	Name = "Nameles Loopfling",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))()
      		print("button pressed")
  	end  
  
})Tab:AddButton({
	Name = "fly v3",
	Callback = function()
	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fly-v3-7412"))()
      		print("button pressed")
  	end 
  })

  local Tab = Window:MakeTab({
	Name = "pegar sofa",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]

Tab:AddButton({
	Name = "sofa",
	Callback = function()
	local args = {
    [1] = "PickingTools",
    [2] = "Couch"
}
 
game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
      		print("button pressed")
  	end    
})

local Tab = Window:MakeTab({
	Name = "Fling v16[OP]",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]


Tab:AddButton({
	Name = "FLING BY NOT LEGITTY👾",
	Callback = function()
 loadstring(game:HttpGet("https://raw.githubusercontent.com/CLEITI6966/HUB/refs/heads/main/fling.lua"))()
      		print("button pressed")
  	end    
})

--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]



local Tab = Window:MakeTab({
	Name = "SOUND ALL🚨",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]


Tab:AddButton({
	Name = "SOUND ALL🚨♨️",
	Callback = function()
 loadstring(game:HttpGet("https://raw.githubusercontent.com/ameicaa0/brookhaven/refs/heads/main/brookhaven%20script.txt"))()
      		print("button pressed")
  	end    
})

--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]
