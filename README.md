local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Davizinhofprest/Jaoohub/refs/heads/main/Jaoohub/Orion.lua')))()
local Window = OrionLib:MakeWindow({
    Name = "MATRIX HUB V2 : By Team Cartola Center🎩",
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "MatrixHubConfigs",
    IntroEnabled = true,
    IntroText = "Team CARTOLA CENTER🎩",
    IntroIcon = "rbxassetid://86898373680592",
    Icon = "rbxassetid://86898373680592",
    CloseCallback = function() 
        print("MATRIX HUB V2 fechado")
    end
})

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScreenGui"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Toggle = Instance.new("ImageButton")
Toggle.Name = "Toggle"
Toggle.Parent = ScreenGui
Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle.BackgroundTransparency = 0.5
Toggle.Position = UDim2.new(0, 0, 0.454706937, 0)
Toggle.Size = UDim2.new(0, 50, 0, 50)
Toggle.Image = "rbxassetid://10709752035"
Toggle.Draggable = true

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0.1, 0)
Corner.Parent = Toggle

local isOn = false
local selectedPlayerName = nil

local function onButtonClicked()
    if gethui():FindFirstChild("Orion") then
        gethui().Orion.Enabled = not gethui().Orion.Enabled
    end
end

local function offButtonClicked()
    if gethui():FindFirstChild("Orion") then
        gethui().Orion.Enabled = not gethui().Orion.Enabled
    end
end

Toggle.MouseButton1Click:Connect(function()
    isOn = not isOn
    if isOn then
        Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        onButtonClicked()
    else
        Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        offButtonClicked()
    end
end)


local Tab = Window:MakeTab({
	Name = "BEM VINDO",
	Icon = "rbxassetid://10709751939",
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
	Name = "Pegar Sniper (Necessário)",
	Callback = function()
local args = {
    [1] = "PickingTools",
    [2] = "Sniper"
}

game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))

  	end    
})

-- TextBox para inserir o ID
Tab:AddTextbox({
    Name = "Digite o ID do Áudio",
    Default = "",
    TextDisappear = true,
    Callback = function(value)
        Value = value
    end
})

-- Botão para executar a função uma vez
Tab:AddButton({
    Name = "Tocar Áudio",
    Callback = function()
        if Value then
            local args = {
                [1] = game:GetService("Players").LocalPlayer.Character.Sniper.Handle,
                [2] = Value,
                [3] = 1
            }
            game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))
            
            local soundId = "rbxassetid://" .. Value
            local sound = Instance.new("Sound")
            sound.SoundId = soundId
            sound.Parent = game.Workspace
            sound.Volume = 0.3
            
            sound:Play()
            wait(3)
            sound:Stop()
        else
            OrionLib:MakeNotification({
                Name = "Erro",
                Content = "Insira um ID válido antes de executar.",
                Image = "rbxassetid://132225387260946",
                Time = 5
            })
        end
    end
})

-- Toggle para ativar/desativar o loop
Tab:AddToggle({
    Name = "Loop Audio",
    Default = false,
    Callback = function(value)
        looping = value
        
        while looping do
            if Value then
                local args = {
                    [1] = game:GetService("Players").LocalPlayer.Character.Sniper.Handle,
                    [2] = Value,
                    [3] = 1
                }
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))
                
                local soundId = "rbxassetid://" .. Value
                local sound = Instance.new("Sound")
                sound.SoundId = soundId
                sound.Parent = game.Workspace
                sound.Volume = 0.1
                
                sound:Play()
                wait(3)
                sound:Stop()
            else
                OrionLib:MakeNotification({
                    Name = "Erro",
                    Content = "Insira um ID antes de ativar o loop som.",
                    Image = "rbxassetid://132225387260946",
                    Time = 5
                })
                break
            end
            wait(1) -- Intervalo entre execuções
        end
    end
})

Tab:AddParagraph("Atenção","Você deve segurar a <font color='rgb(0, 255, 0)'>Sniper</font> para que o áudio seja executado corretamente de forma FE, suporta o som por 3 segundos")

local Section = Tab:AddSection({
    Name = "Áudio All"
})

Tab:AddButton({
	Name = "Pegar Sniper (Necessário)",
	Callback = function()
local args = {
    [1] = "PickingTools",
    [2] = "Sniper"
}

game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))

  	end    
})

-- Variáveis
local Value = ""  -- ID do som será inserido pelo usuário
local Speed = 1   -- Velocidade padrão (pode ser ajustada)
local isPlaying = false  -- Estado do toggle
local interval = 0.1  -- Tempo padrão entre execuções

-- Função para tocar o som localmente
local function playSoundLocally(Value, Speed)
    local soundId = "rbxassetid://" .. Value
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Parent = game.Workspace
    sound.Volume = 0.3
    sound.PlaybackSpeed = Speed  -- Velocidade do som

    sound:Play()

    -- O som será destruído após 3 segundos, mas isso não impede a execução contínua
    game:GetService("Debris"):AddItem(sound, 3)
end

-- Função para enviar o evento ao servidor
local function playSoundServer(Value, Speed)
    local args = {
        [1] = workspace,
        [2] = Value,
        [3] = Speed
    }
    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gu1nSound1s"):FireServer(unpack(args))
end

-- TextBox para inserir o ID do som
Tab:AddTextbox({
    Name = "ID do Áudio",
    Default = "",
    TextDisappear = true,
    Callback = function(value)
        Value = value  -- Atualizando o ID do som
    end
})

-- TextBox para inserir a velocidade do som
Tab:AddTextbox({
    Name = "Velocidade do Áudio",
    Default = "1",
    TextDisappear = true,
    Callback = function(value)
        Speed = tonumber(value) or 1  -- Garantindo que a velocidade seja um número, se não for, usa 1
    end
})

-- Botão para tocar o som uma vez
Tab:AddButton({
    Name = "Tocar Áudio",
    Callback = function()
        if Value == "" then
            print("Você não colocou nemhum ID de Áudio")
        else
            playSoundLocally(Value, Speed)  -- Toca o som localmente
            playSoundServer(Value, Speed)  -- Envia o evento ao servidor
        end
    end
})

-- Toggle para tocar o som repetidamente
Tab:AddToggle({
    Name = "Loop Áudio All",
    Default = false,
    Callback = function(state)
        isPlaying = state  -- Atualizando o estado do toggle
        if isPlaying then
            -- Loop para tocar o som enquanto o toggle estiver ativado
            coroutine.wrap(function()
                while isPlaying do
                    if Value ~= "" then
                        playSoundLocally(Value, Speed)  -- Toca o som localmente
                        playSoundServer(Value, Speed)  -- Envia o evento ao servidor
                    else
                        print("Você não colocou nemhum ID de Áudio")
                        break
                    end
                    wait(interval)  -- Usa o intervalo definido pelo usuário
                end
            end)()
        end
    end
})

-- TextBox para ajustar o intervalo do toggle
Tab:AddTextbox({
    Name = "Intervalo para o Loop Áudio All",
    Default = "0.5",
    TextDisappear = true,
    Callback = function(value)
        interval = tonumber(value) or 0.5  -- Atualiza o intervalo, valor padrão é 0.1
        if interval <= 0 then
            interval = 0.5  -- Garante que o intervalo não seja zero ou negativo
            print("Intervalo do Loop Áudio All Definido")
        end
    end
})


 
--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]


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


