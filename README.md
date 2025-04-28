local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Davizinhofprest/Jaoohub/refs/heads/main/Jaoohub/Orion.lua')))()
local Window = OrionLib:MakeWindow({
    Name = "MATRIX HUB V3.0 : By Matrix Community🎩",
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "MatrixHubConfigs",
    IntroEnabled = true,
    IntroText = "Team Matrix COMMUNITY",
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
Toggle.Image = "rbxassetid://122216401159246"
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

Icon = "rbxassetid://10734934585",

PremiumOnly = false

})



local Section = Tab:AddSection({
	Name = "Boat Fling"
})


local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local playerNames = {}
for _, player in pairs(Players:GetPlayers()) do
    table.insert(playerNames, player.Name)
end

local selectedPlayerName = nil

Tab:AddDropdown({
    Name = "Target",
    Options = playerNames,
    Callback = function(selected)
        selectedPlayerName = selected
    end
})

local function executeScript()
    local UserInputService = game:GetService("UserInputService")
    local Mouse = game.Players.LocalPlayer:GetMouse()
    local Folder = Instance.new("Folder", Workspace)
    local Part = Instance.new("Part", Folder)
    local Attachment1 = Instance.new("Attachment", Part)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1

    local NetworkAccess = coroutine.create(function()
        settings().Physics.AllowSleep = false
        while RunService.RenderStepped:Wait() do
            for _, player in next, Players:GetPlayers() do
                if player ~= Players.LocalPlayer then
                    player.MaximumSimulationRadius = 0
                    sethiddenproperty(player, "SimulationRadius", 0)
                end
            end
            Players.LocalPlayer.MaximumSimulationRadius = math.pow(math.huge, math.huge)
            setsimulationradius(math.huge)
        end
    end)
    coroutine.resume(NetworkAccess)

    local function ForceVehicle(v)
        if v:IsA("Model") and v:FindFirstChildOfClass("VehicleSeat") then
            Mouse.TargetFilter = v
            for _, x in next, v:GetDescendants() do
                if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                    x:Destroy()
                end
            end
            if v:FindFirstChild("Attachment") then
                v:FindFirstChild("Attachment"):Destroy()
            end
            if v:FindFirstChild("AlignPosition") then
                v:FindFirstChild("AlignPosition"):Destroy()
            end
            if v:FindFirstChild("Torque") then
                v:FindFirstChild("Torque"):Destroy()
            end
            for _, part in next, v:GetDescendants() do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                    local Torque = Instance.new("Torque", part)
                    Torque.Torque = Vector3.new(100000 * 12, 100000 * 12, 100000 * 12)
                    local AlignPosition = Instance.new("AlignPosition", part)
                    local Attachment2 = Instance.new("Attachment", part)
                    Torque.Attachment0 = Attachment2
                    AlignPosition.MaxForce = 999999
                    AlignPosition.MaxVelocity = math.huge
                    AlignPosition.Responsiveness = 200
                    AlignPosition.Attachment0 = Attachment2
                    AlignPosition.Attachment1 = Attachment1
                end
            end
        end
    end

    for _, v in next, Workspace:GetDescendants() do
        ForceVehicle(v)
    end

    Workspace.DescendantAdded:Connect(function(v)
        ForceVehicle(v)
    end)

    spawn(function()
        while true do
            local voidPosition = Vector3.new(101, -446, -180)
            Attachment1.WorldCFrame = CFrame.new(voidPosition)
            RunService.RenderStepped:Wait()
        end
    end)
end

local function monitorSeats()
    for _, seat in pairs(Workspace:GetDescendants()) do
        if seat:IsA("Seat") or seat:IsA("VehicleSeat") then
            seat:GetPropertyChangedSignal("Occupant"):Connect(function()
                if seat.Occupant then
                    local occupantPlayer = Players:GetPlayerFromCharacter(seat.Occupant.Parent)
                    if occupantPlayer and occupantPlayer.Name == selectedPlayerName then
                        executeScript()
                    end
                end
            end)
        end
    end

    Workspace.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("Seat") or descendant:IsA("VehicleSeat") then
            descendant:GetPropertyChangedSignal("Occupant"):Connect(function()
                if descendant.Occupant then
                    local occupantPlayer = Players:GetPlayerFromCharacter(descendant.Occupant.Parent)
                    if occupantPlayer and occupantPlayer.Name == selectedPlayerName then
                        executeScript()
                    end
                end
            end)
        end
    end)
end

monitorSeats()
Tab:AddButton({
    Name = "Boat Fling",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:WaitForChild("HumanoidRootPart")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")
        local OldPos = RootPart.CFrame

        if not Humanoid or not Vehicles then return end

        local function GetCar()
            return Vehicles:FindFirstChild(Player.Name.."Car")
        end

        local PCar = GetCar()

        if not PCar then
            RootPart.CFrame = CFrame.new(-2, 5, 2085)
            task.wait(0.5)
            local RemoteEvent = game:GetService("ReplicatedStorage"):FindFirstChild("RE")
            if RemoteEvent and RemoteEvent:FindFirstChild("1Ca1r") then
                RemoteEvent["1Ca1r"]:FireServer("PickingBoat", "MilitaryBoatFree")
            end
            task.wait(1)
            PCar = GetCar()
        end

        if PCar then
            local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
            if Seat and not Humanoid.Sit then
                repeat
                    RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    task.wait()
                until Humanoid.Sit or not PCar.Parent
            end
        end

        wait(0.2)

        local UserInputService = game:GetService("UserInputService")
        local RunService = game:GetService("RunService")
        local Mouse = Players.LocalPlayer:GetMouse()
        local Folder = Instance.new("Folder", game:GetService("Workspace"))
        local Part = Instance.new("Part", Folder)
        local Attachment1 = Instance.new("Attachment", Part)
        Part.Anchored = true
        Part.CanCollide = false
        Part.Transparency = 1

        local NetworkAccess = coroutine.create(function()
            settings().Physics.AllowSleep = false
            while RunService.RenderStepped:Wait() do
                for _, player in next, Players:GetPlayers() do
                    if player ~= Players.LocalPlayer then
                        player.MaximumSimulationRadius = 0
                        sethiddenproperty(player, "SimulationRadius", 2)
                    end
                end
                Players.LocalPlayer.MaximumSimulationRadius = math.pow(math.huge, math.huge)
                setsimulationradius(math.huge)
            end
        end)
        coroutine.resume(NetworkAccess)

        local function ForceVehicle(v)
            if v:IsA("Model") and v:FindFirstChildOfClass("VehicleSeat") then
                Mouse.TargetFilter = v
                for _, x in next, v:GetDescendants() do
                    if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                        x:Destroy()
                    end
                end
                if v:FindFirstChild("Attachment") then
                    v:FindFirstChild("Attachment"):Destroy()
                end
                if v:FindFirstChild("AlignPosition") then
                    v:FindFirstChild("AlignPosition"):Destroy()
                end
                if v:FindFirstChild("Torque") then
                    v:FindFirstChild("Torque"):Destroy()
                end
                for _, part in next, v:GetDescendants() do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                        local Torque = Instance.new("Torque", part)
                        Torque.Torque = Vector3.new(1000 * 102, 100000 * 102, 10000 * 12)
                        local AlignPosition = Instance.new("AlignPosition", part)
                        local Attachment2 = Instance.new("Attachment", part)
                        Torque.Attachment0 = Attachment2
                        AlignPosition.MaxForce = 99999
                        AlignPosition.MaxVelocity = math.huge
                        AlignPosition.Responsiveness = 200
                        AlignPosition.Attachment0 = Attachment2
                        AlignPosition.Attachment1 = Attachment1
                    end
                end
            end
        end

        for _, v in next, game:GetService("Workspace"):GetDescendants() do
            ForceVehicle(v)
        end

        game:GetService("Workspace").DescendantAdded:Connect(function(v)
            ForceVehicle(v)
        end)

        spawn(function()
            while true do
                if selectedPlayerName then
                    local player = Players:FindFirstChild(selectedPlayerName)
                    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local rootPart = player.Character.HumanoidRootPart
                        Attachment1.WorldCFrame = rootPart.CFrame
                    end
                end
                RunService.RenderStepped:Wait()
            end
        end)

        wait(4)

        local targetPosition = Vector3.new(101, -446, -180)
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)

        -- Código adicionado para efeito do kill()
        local function applyKillEffect(targetPlayer)
            if targetPlayer and targetPlayer.Character then
                local TargetRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                local TargetH = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
                local Angles = 45

                if TargetRP and TargetH then
                    kill(TargetRP, CFrame.new(0, 3, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05, CFrame.Angles(math.rad(Angles), 0, 0))
                    kill(TargetRP, CFrame.new(0, -1.5, 2) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05, CFrame.Angles(math.rad(Angles), 0, 0))
                    kill(TargetRP, CFrame.new(2, 1.5, 2.25)  + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(50), 0, 0))
                    kill(TargetRP, CFrame.new(-2.25, -1.5, 2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10, CFrame.Angles(math.rad(30), 0, 0))
                    kill(TargetRP, CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05, CFrame.Angles(math.rad(Angles), 0, 0))
                    kill(TargetRP, CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.05, CFrame.Angles(math.rad(Angles), 0, 0))
                end
            end
        end

        local function onPlayerSeated(player)
            if player and player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid and humanoid.SeatPart then
                    if humanoid.SeatPart.Parent:IsA("VehicleSeat") then
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
                        applyKillEffect(player)
                    end
                end
            end
        end

        game:GetService("Players").PlayerAdded:Connect(function(player)
            if player.Name == selectedPlayerName then
                player.CharacterAdded:Connect(function(character)
                    local humanoid = character:WaitForChild("Humanoid")
                    humanoid.Seated:Connect(function(_, seat)
                        if seat then
                            onPlayerSeated(player)
                        end
                    end)
                end)
            end
        end)
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
	Icon = "rbxassetid://10734934585",
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



local Tab = Window:MakeTab({
	Name = "Jogador",
	Icon = "rbxassetid://10734898355",
	PremiumOnly = false
})


local Section = Tab:AddSection({
	Name = "Anti functions"
})


Tab:AddToggle({
    Name = "Ant Sit",
    Default = false,
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local humanoid = player.Character and player.Character.Humanoid
        
        if humanoid then
            if Value then
                -- Quando o toggle está ativado (Value é true), o humanoide não pode sentar em assentos
                humanoid:SetStateEnabled("Seated", false)
            else
                -- Quando o toggle está desativado (Value é false), o humanoide pode sentar em assentos normalmente
                humanoid:SetStateEnabled("Seated", true)
            end
        else
            print("Erro: Personagem não encontrado.")
        end
    end    
})



local Tab = Window:MakeTab({
	Name = "HOUSE BAN KILL[OP]",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]

local Section = Tab:AddSection({
	Name = "Ban House Kill"
})


local selectedPlayer

local function ShowPlayerList()
    local playerNames = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(playerNames, player.Name)
    end
    
    Tab:AddDropdown({
        Name = "Target",
        Default = playerNames[1],
        Options = playerNames,
        Callback = function(Value)
            selectedPlayer = game.Players:FindFirstChild(Value)
            print("Jogador selecionado: " .. Value)
        end
    })
end

ShowPlayerList()


Tab:AddButton({
    Name = "House Ban",
    Callback = function()
        local Player = game.Players.LocalPlayer
    local Backpack = Player.Backpack
    local Character = Player.Character
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Character:FindFirstChild("HumanoidRootPart")
    local Houses = game.Workspace:FindFirstChild("001_Lots")
    local OldPos = RootPart.CFrame
    local Angles = 0
    local Vehicles = Workspace.Vehicles
    local Pos

   
    function Check()
        if Player and Character and Humanoid and RootPart and Vehicles then
            return true
        else
            return false
        end
    end

  
    if selectedPlayer and selectedPlayer.Character then
        if Check() then
            local House = Houses:FindFirstChild(Player.Name.."House")
            if not House then
                local EHouse
                for _,Lot in pairs(Houses:GetChildren()) do
                    if Lot.Name == "For Sale" then
                        for _,num in pairs(Lot:GetDescendants()) do
                            if num:IsA("NumberValue") and num.Name == "Number" and num.Value < 25 and num.Value > 10 then
                                EHouse = Lot
                                break
                            end
                        end
                    end
                end

                local BuyDetector = EHouse:FindFirstChild("BuyHouse")
                Pos = BuyDetector.Position
                if BuyDetector and BuyDetector:IsA("BasePart") then
                    RootPart.CFrame = BuyDetector.CFrame + Vector3.new(0,-6,0)
                    task.wait(.5)
                    local ClickDetector = BuyDetector:FindFirstChild("ClickDetector")
                    if ClickDetector then
                        fireclickdetector(ClickDetector)
                    end
                end
            end

            task.wait(0.5)
            local PreHouse = Houses:FindFirstChild(Player.Name .. "House")
            if PreHouse then
                task.wait(0.5)
                local Number
                for i,x in pairs(PreHouse:GetDescendants()) do
                    if x.Name == "Number" and x:IsA("NumberValue") then
                        Number = x
                    end
                end
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Gettin1gHous1e"):FireServer("PickingCustomHouse","049_House", Number.Value)
            end

            task.wait(0.5)
            local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
            if not PCar then
                if Check() then
                    RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar","SchoolBus")
                    task.wait(0.5)
                    local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
                    task.wait(0.5)
                    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                    if Seat then
                        repeat task.wait()
                            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                        until Humanoid.Sit
                    end
                end
            end

            task.wait(0.5)
            local PCar = Vehicles:FindFirstChild(Player.Name.."Car")
            if PCar then
                if not Humanoid.Sit then
                    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                    if Seat then
                        repeat task.wait()
                            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                        until Humanoid.Sit
                    end
                end

                local Target = selectedPlayer
                local TargetC = Target.Character
                local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
                local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
                if TargetC and TargetH and TargetRP then
                    if not TargetH.Sit then
                        while not TargetH.Sit do
                            task.wait()
                            local Fling = function(alvo,pos,angulo)
                                PCar:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)
                            end
                            Angles = Angles + 100
                            Fling(TargetRP,CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10,CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP,CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10,CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP,CFrame.new(2.25, 1.5, -2.25)  + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10,CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP,CFrame.new(-2.25, -1.5, 2.25) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10,CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP,CFrame.new(0, 1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10,CFrame.Angles(math.rad(Angles), 0, 0))
                            Fling(TargetRP,CFrame.new(0, -1.5, 0) + TargetH.MoveDirection * TargetRP.Velocity.Magnitude / 1.10,CFrame.Angles(math.rad(Angles), 0, 0))
                        end

                        task.wait(0.2)
                        local House = Houses:FindFirstChild(Player.Name.."House")
                        PCar:SetPrimaryPartCFrame(CFrame.new(House.HouseSpawnPosition.Position))
                        task.wait(0.2)
                        local pedro = Region3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(30,30,30),game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(30,30,30))

                        local a = workspace:FindPartsInRegion3(pedro,game.Players.LocalPlayer.Character.HumanoidRootPart,math.huge)

                        for i,v in pairs(a) do
                            if v.Name == "HumanoidRootPart" then
                                local b = game:GetService("Players"):FindFirstChild(v.Parent.Name)
                                local args = {
                                    [1] = "BanPlayerFromHouse",
                                    [2] = b,
                                    [3] = v.Parent
                                }

                                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))

                               
                                local args = {
                                    [1] = "DeleteAllVehicles"
                                }
                                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer(unpack(args))
                            end
                        end
                    end
                end
            end
        end
    end
    end
})


local Tab = Window:MakeTab({
	Name = "LAG SERVER[OP]",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]


local Section = Tab:AddSection({
	Name = "Lag Server"
})

-- Variáveis
local isLooping = false -- Controle do loop
local originalPosition = nil -- Para armazenar a posição original do jogador
local player = game.Players.LocalPlayer -- Referência ao jogador local
local selectedDevice = "Celular" -- Valor padrão do dispositivo

Tab:AddDropdown({
    Name = "Selecionar o Que Vai Usar Para Lagar o Servidor",
    Default = "Celular",
    Options = {"Laptop", "Celular", "Caça Fantasmas", "Celular e Laptop"},
    Callback = function(Value)
        selectedDevice = Value -- Atualiza o dispositivo selecionado com base na escolha do usuário
    end
})

-- Função para iniciar o loop
local function startLoop()
    if not isLooping then
        isLooping = true
        originalPosition = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position

        -- Define coordenadas baseadas no dispositivo selecionado
        local teleportPosition
        if selectedDevice == "Laptop" then
            teleportPosition = Vector3.new(-123.742, 20.074, 251.402)
        elseif selectedDevice == "Celular" then
            teleportPosition = Vector3.new(-123.742, 20.074, 251.402)
        elseif selectedDevice == "Caça Fantasmas" then
            teleportPosition = Vector3.new(-320.216, 7.4, -112.32)
        elseif selectedDevice == "Celular e Laptop" then
            teleportPosition = Vector3.new(-123.742, 20.074, 251.402)
        end

        -- Teleporta o jogador para a nova posição
        if teleportPosition then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(teleportPosition)
        end

        -- Define a velocidade para 0
        player.Character.Humanoid.WalkSpeed = 0

        -- Loop principal
        while isLooping do
            -- Verifica o dispositivo selecionado e executa o ClickDetector correspondente
            if selectedDevice == "Laptop" then
                fireclickdetector(workspace.WorkspaceCom["001_CommercialStores"].CommercialStorage1.Store.Tools.Laptop.ClickDetector)
            elseif selectedDevice == "Celular" then
                fireclickdetector(workspace.WorkspaceCom["001_CommercialStores"].CommercialStorage1.Store.Tools:GetChildren()[3].ClickDetector)
            elseif selectedDevice == "Caça Fantasmas" then
                fireclickdetector(workspace.WorkspaceCom["001_GiveTools"].GhostMeter.ClickDetector)
            elseif selectedDevice == "Celular e Laptop" then
                fireclickdetector(workspace.WorkspaceCom["001_CommercialStores"].CommercialStorage1.Store.Tools:GetChildren()[3].ClickDetector)
                wait(0.1)
                fireclickdetector(workspace.WorkspaceCom["001_CommercialStores"].CommercialStorage1.Store.Tools.Laptop.ClickDetector)
            end
            wait(0.01) -- Espera 0.01 segundo
        end
    end
end

-- Função para parar o loop e voltar à posição original
local function stopLoop()
    if isLooping then
        isLooping = false -- Para o loop
        wait(0.1) -- Espera um pouco antes de voltar

        -- Teleporta de volta para a posição original
        if originalPosition then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(originalPosition)
        end

        -- Restaura a velocidade para 16
        player.Character.Humanoid.WalkSpeed = 16
    end
end

-- Reinicializa as variáveis em caso de reset do personagem
player.CharacterAdded:Connect(function()
    isLooping = false -- Garante que o loop seja parado ao resetar
    originalPosition = nil -- Reseta a posição original
end)

-- Botão para iniciar o loop
Tab:AddButton({
    Name = "Lagar Servidor",
    Callback = function()
        startLoop()
    end
})

-- Botão para parar o loop
Tab:AddButton({
    Name = "Parar de Lagar",
    Callback = function()
        stopLoop()
    end
})

Tab:AddParagraph("Atenção", "Caso seu Celular não Seja Muito Bom não é Recomendado que use o Lagar Servidor")

local Tab = Window:MakeTab({
	Name = "CAR FLING",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]

local Section = Tab:AddSection({
	Name = "variable car forms kill"
})


local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local playerNames = {}
for _, player in pairs(Players:GetPlayers()) do
    table.insert(playerNames, player.Name)
end

local selectedPlayerName = nil

Tab:AddDropdown({
    Name = "Target Player",
    Options = playerNames,
    Callback = function(selected)
        selectedPlayerName = selected
    end
})

local function executeScript()
    local UserInputService = game:GetService("UserInputService")
    local Mouse = game.Players.LocalPlayer:GetMouse()
    local Folder = Instance.new("Folder", Workspace)
    local Part = Instance.new("Part", Folder)
    local Attachment1 = Instance.new("Attachment", Part)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1

    local NetworkAccess = coroutine.create(function()
        settings().Physics.AllowSleep = false
        while RunService.RenderStepped:Wait() do
            for _, player in next, Players:GetPlayers() do
                if player ~= Players.LocalPlayer then
                    player.MaximumSimulationRadius = 0
                    sethiddenproperty(player, "SimulationRadius", 0)
                end
            end
            Players.LocalPlayer.MaximumSimulationRadius = math.pow(math.huge, math.huge)
            setsimulationradius(math.huge)
        end
    end)
    coroutine.resume(NetworkAccess)

    local function ForceVehicle(v)
        if v:IsA("Model") and v:FindFirstChildOfClass("VehicleSeat") then
            Mouse.TargetFilter = v
            for _, x in next, v:GetDescendants() do
                if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                    x:Destroy()
                end
            end
            if v:FindFirstChild("Attachment") then
                v:FindFirstChild("Attachment"):Destroy()
            end
            if v:FindFirstChild("AlignPosition") then
                v:FindFirstChild("AlignPosition"):Destroy()
            end
            if v:FindFirstChild("Torque") then
                v:FindFirstChild("Torque"):Destroy()
            end
            for _, part in next, v:GetDescendants() do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                    local Torque = Instance.new("Torque", part)
                    Torque.Torque = Vector3.new(100000 * 12, 100000 * 12, 100000 * 12)
                    local AlignPosition = Instance.new("AlignPosition", part)
                    local Attachment2 = Instance.new("Attachment", part)
                    Torque.Attachment0 = Attachment2
                    AlignPosition.MaxForce = 999999
                    AlignPosition.MaxVelocity = math.huge
                    AlignPosition.Responsiveness = 200
                    AlignPosition.Attachment0 = Attachment2
                    AlignPosition.Attachment1 = Attachment1
                end
            end
        end
    end

    for _, v in next, Workspace:GetDescendants() do
        ForceVehicle(v)
    end

    Workspace.DescendantAdded:Connect(function(v)
        ForceVehicle(v)
    end)

    spawn(function()
        while true do
            local voidPosition = Vector3.new(223809667072, 223809667072, -223809667072)
            Attachment1.WorldCFrame = CFrame.new(voidPosition)
            RunService.RenderStepped:Wait()
        end
    end)
end

local function monitorSeats()
    for _, seat in pairs(Workspace:GetDescendants()) do
        if seat:IsA("Seat") or seat:IsA("VehicleSeat") then
            seat:GetPropertyChangedSignal("Occupant"):Connect(function()
                if seat.Occupant then
                    local occupantPlayer = Players:GetPlayerFromCharacter(seat.Occupant.Parent)
                    if occupantPlayer and occupantPlayer.Name == selectedPlayerName then
                        executeScript()
                    end
                end
            end)
        end
    end

    Workspace.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("Seat") or descendant:IsA("VehicleSeat") then
            descendant:GetPropertyChangedSignal("Occupant"):Connect(function()
                if descendant.Occupant then
                    local occupantPlayer = Players:GetPlayerFromCharacter(descendant.Occupant.Parent)
                    if occupantPlayer and occupantPlayer.Name == selectedPlayerName then
                        executeScript()
                    end
                end
            end)
        end
    end)
end

monitorSeats()
Tab:AddButton({
    Name = "Car Fling",
    Callback = function()
        local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Vehicles = game.Workspace:FindFirstChild("Vehicles")
local OldPos = RootPart.CFrame

if not Humanoid or not Vehicles then return end

local function GetCar()
    return Vehicles:FindFirstChild(Player.Name.."Car")
end

local PCar = GetCar()

if not PCar then
    RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
    task.wait(0.5)
    local RemoteEvent = game:GetService("ReplicatedStorage"):FindFirstChild("RE")
    if RemoteEvent and RemoteEvent:FindFirstChild("1Ca1r") then
        RemoteEvent["1Ca1r"]:FireServer("PickingCar", "SchoolBus")
    end
    task.wait(1)
    PCar = GetCar()
end

if PCar then
    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
    if Seat and not Humanoid.Sit then
        repeat
            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
            task.wait()
        until Humanoid.Sit or not PCar.Parent
    end
end
        wait(0.2)
        
        local UserInputService = game:GetService("UserInputService")
        local RunService = game:GetService("RunService")
        local Mouse = Players.LocalPlayer:GetMouse()
        local Folder = Instance.new("Folder", game:GetService("Workspace"))
        local Part = Instance.new("Part", Folder)
        local Attachment1 = Instance.new("Attachment", Part)
        Part.Anchored = true
        Part.CanCollide = false
        Part.Transparency = 1

        local NetworkAccess = coroutine.create(function()
            settings().Physics.AllowSleep = false
            while RunService.RenderStepped:Wait() do
                for _, player in next, Players:GetPlayers() do
                    if player ~= Players.LocalPlayer then
                        player.MaximumSimulationRadius = 0
                        sethiddenproperty(player, "SimulationRadius", 2)
                    end
                end
                Players.LocalPlayer.MaximumSimulationRadius = math.pow(math.huge, math.huge)
                setsimulationradius(math.huge)
            end
        end)
        coroutine.resume(NetworkAccess)

        local function ForceVehicle(v)
            if v:IsA("Model") and v:FindFirstChildOfClass("VehicleSeat") then
                Mouse.TargetFilter = v
                for _, x in next, v:GetDescendants() do
                    if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                        x:Destroy()
                    end
                end
                if v:FindFirstChild("Attachment") then
                    v:FindFirstChild("Attachment"):Destroy()
                end
                if v:FindFirstChild("AlignPosition") then
                    v:FindFirstChild("AlignPosition"):Destroy()
                end
                if v:FindFirstChild("Torque") then
                    v:FindFirstChild("Torque"):Destroy()
                end
                for _, part in next, v:GetDescendants() do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                        local Torque = Instance.new("Torque", part)
                        Torque.Torque = Vector3.new(1000 * 102, 100000 * 102, 10000 * 12)
                        local AlignPosition = Instance.new("AlignPosition", part)
                        local Attachment2 = Instance.new("Attachment", part)
                        Torque.Attachment0 = Attachment2
                        AlignPosition.MaxForce = 99999
                        AlignPosition.MaxVelocity = math.huge
                        AlignPosition.Responsiveness = 200
                        AlignPosition.Attachment0 = Attachment2
                        AlignPosition.Attachment1 = Attachment1
                    end
                end
            end
        end

        for _, v in next, game:GetService("Workspace"):GetDescendants() do
            ForceVehicle(v)
        end

        game:GetService("Workspace").DescendantAdded:Connect(function(v)
            ForceVehicle(v)
        end)

        spawn(function()
            while true do
                if selectedPlayerName then
                    local player = Players:FindFirstChild(selectedPlayerName)
                    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local rootPart = player.Character.HumanoidRootPart
                        Attachment1.WorldCFrame = rootPart.CFrame
                    end
                end
                RunService.RenderStepped:Wait()
            end
        end)

        wait(4)
        
        local targetPosition = Vector3.new(223809667072, 223809667072, -223809667072)
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)

        local function onPlayerSeated(player)
            if player and player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid and humanoid.SeatPart then
                    if humanoid.SeatPart.Parent:IsA("VehicleSeat") then
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
                    end
                end
            end
        end

        game:GetService("Players").PlayerAdded:Connect(function(player)
            if player.Name == selectedPlayerName then
                player.CharacterAdded:Connect(function(character)
                    local humanoid = character:WaitForChild("Humanoid")
                    humanoid.Seated:Connect(function(_, seat)
                        if seat then
                            onPlayerSeated(player)
                        end
                    end)
                end)
            end
        end)
    end    
})


local function executeScript()
    local UserInputService = game:GetService("UserInputService")
    local Mouse = game.Players.LocalPlayer:GetMouse()
    local Folder = Instance.new("Folder", Workspace)
    local Part = Instance.new("Part", Folder)
    local Attachment1 = Instance.new("Attachment", Part)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1

    local NetworkAccess = coroutine.create(function()
        settings().Physics.AllowSleep = false
        while RunService.RenderStepped:Wait() do
            for _, player in next, Players:GetPlayers() do
                if player ~= Players.LocalPlayer then
                    player.MaximumSimulationRadius = 0
                    sethiddenproperty(player, "SimulationRadius", 0)
                end
            end
            Players.LocalPlayer.MaximumSimulationRadius = math.pow(math.huge, math.huge)
            setsimulationradius(math.huge)
        end
    end)
    coroutine.resume(NetworkAccess)

    local function ForceVehicle(v)
        if v:IsA("Model") and v:FindFirstChildOfClass("VehicleSeat") then
            Mouse.TargetFilter = v
            for _, x in next, v:GetDescendants() do
                if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                    x:Destroy()
                end
            end
            if v:FindFirstChild("Attachment") then
                v:FindFirstChild("Attachment"):Destroy()
            end
            if v:FindFirstChild("AlignPosition") then
                v:FindFirstChild("AlignPosition"):Destroy()
            end
            if v:FindFirstChild("Torque") then
                v:FindFirstChild("Torque"):Destroy()
            end
            for _, part in next, v:GetDescendants() do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                    local Torque = Instance.new("Torque", part)
                    Torque.Torque = Vector3.new(100000 * 12, 100000 * 12, 100000 * 12)
                    local AlignPosition = Instance.new("AlignPosition", part)
                    local Attachment2 = Instance.new("Attachment", part)
                    Torque.Attachment0 = Attachment2
                    AlignPosition.MaxForce = 999999
                    AlignPosition.MaxVelocity = math.huge
                    AlignPosition.Responsiveness = 200
                    AlignPosition.Attachment0 = Attachment2
                    AlignPosition.Attachment1 = Attachment1
                end
            end
        end
    end

    for _, v in next, Workspace:GetDescendants() do
        ForceVehicle(v)
    end
    Workspace.DescendantAdded:Connect(function(v)
        ForceVehicle(v)
    end)
    spawn(function()
        while true do
            local voidPosition = Vector3.new(0, -470, 0)
            Attachment1.WorldCFrame = CFrame.new(voidPosition)
            RunService.RenderStepped:Wait()
        end
    end)
end
local function monitorSeats()
    for _, seat in pairs(Workspace:GetDescendants()) do
        if seat:IsA("Seat") or seat:IsA("VehicleSeat") then
            seat:GetPropertyChangedSignal("Occupant"):Connect(function()
                if seat.Occupant then
                    local occupantPlayer = Players:GetPlayerFromCharacter(seat.Occupant.Parent)
                    if occupantPlayer and occupantPlayer.Name == selectedPlayerName then
                        executeScript()
                    end
                end
            end)
        end
    end
    Workspace.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("Seat") or descendant:IsA("VehicleSeat") then           descendant:GetPropertyChangedSignal("Occupant"):Connect(function()
                if descendant.Occupant then
                    local occupantPlayer = Players:GetPlayerFromCharacter(descendant.Occupant.Parent)
                    if occupantPlayer and occupantPlayer.Name == selectedPlayerName then
                        executeScript()
                    end
                end
            end)
        end
    end)
end
monitorSeats()
Tab:AddButton({
    Name = "Car kill",
    Callback = function()
        local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Vehicles = game.Workspace:FindFirstChild("Vehicles")
local OldPos = RootPart.CFrame

if not Humanoid or not Vehicles then return end

local function GetCar()
    return Vehicles:FindFirstChild(Player.Name.."Car")
end

local PCar = GetCar()

if not PCar then
    RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
    task.wait(0.5)
    local RemoteEvent = game:GetService("ReplicatedStorage"):FindFirstChild("RE")
    if RemoteEvent and RemoteEvent:FindFirstChild("1Ca1r") then
        RemoteEvent["1Ca1r"]:FireServer("PickingCar", "SchoolBus")
    end
    task.wait(1)
    PCar = GetCar()
end
if PCar then
    local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
    if Seat and not Humanoid.Sit then
        repeat
            RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
            task.wait()
        until Humanoid.Sit or not PCar.Parent
    end
end
        wait(0.2)
        
        local UserInputService = game:GetService("UserInputService")
        local RunService = game:GetService("RunService")
        local Mouse = Players.LocalPlayer:GetMouse()
        local Folder = Instance.new("Folder", game:GetService("Workspace"))
        local Part = Instance.new("Part", Folder)
        local Attachment1 = Instance.new("Attachment", Part)
        Part.Anchored = true
        Part.CanCollide = false
        Part.Transparency = 1

        local NetworkAccess = coroutine.create(function()
            settings().Physics.AllowSleep = false
            while RunService.RenderStepped:Wait() do
                for _, player in next, Players:GetPlayers() do
                    if player ~= Players.LocalPlayer then
                        player.MaximumSimulationRadius = 0
                        sethiddenproperty(player, "SimulationRadius", 2)
                    end
                end
                Players.LocalPlayer.MaximumSimulationRadius = math.pow(math.huge, math.huge)
                setsimulationradius(math.huge)
            end
        end)
        coroutine.resume(NetworkAccess)
        local function ForceVehicle(v)
            if v:IsA("Model") and v:FindFirstChildOfClass("VehicleSeat") then
                Mouse.TargetFilter = v
                for _, x in next, v:GetDescendants() do
                    if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
                        x:Destroy()
                    end
                end
                if v:FindFirstChild("Attachment") then
                    v:FindFirstChild("Attachment"):Destroy()
                end
                if v:FindFirstChild("AlignPosition") then
                    v:FindFirstChild("AlignPosition"):Destroy()
                end
                if v:FindFirstChild("Torque") then
                    v:FindFirstChild("Torque"):Destroy()
                end
                for _, part in next, v:GetDescendants() do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                        local Torque = Instance.new("Torque", part)
                        Torque.Torque = Vector3.new(1000 * 102, 100000 * 102, 10000 * 12)
                        local AlignPosition = Instance.new("AlignPosition", part)
                        local Attachment2 = Instance.new("Attachment", part)
                        Torque.Attachment0 = Attachment2
                        AlignPosition.MaxForce = 99999
                        AlignPosition.MaxVelocity = math.huge
                        AlignPosition.Responsiveness = 200
                        AlignPosition.Attachment0 = Attachment2
                        AlignPosition.Attachment1 = Attachment1
                    end
                end
            end
        end

        for _, v in next, game:GetService("Workspace"):GetDescendants() do
            ForceVehicle(v)
        end    game:GetService("Workspace").DescendantAdded:Connect(function(v)
            ForceVehicle(v)
        end)
        spawn(function()
            while true do
                if selectedPlayerName then
                    local player = Players:FindFirstChild(selectedPlayerName)
                    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local rootPart = player.Character.HumanoidRootPart
                        Attachment1.WorldCFrame = rootPart.CFrame
                    end
                end
                RunService.RenderStepped:Wait()
            end
        end)

        wait(4)
        
        local targetPosition = Vector3.new(101, -446, -180)
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)

        local function onPlayerSeated(player)
            if player and player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid and humanoid.SeatPart then
                    if humanoid.SeatPart.Parent:IsA("VehicleSeat") then
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
                    end
                end
            end
        end

        game:GetService("Players").PlayerAdded:Connect(function(player)
            if player.Name == selectedPlayerName then
                player.CharacterAdded:Connect(function(character)
                    local humanoid = character:WaitForChild("Humanoid")
                    humanoid.Seated:Connect(function(_, seat)
                        if seat then
                            onPlayerSeated(player)
                        end
                    end)
                end)
            end
        end)
    end    
})


local Tab = Window:MakeTab({
	Name = "ALL",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]


local Section = Tab:AddSection({
	Name = "All Car variables"
})


Tab:AddButton({
	Name = "Car kill all[Beta]",
	Callback = function()
      		local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")
        local OldPos = RootPart.CFrame

        if not Humanoid or not RootPart then return end

        -- Lista de proteção
        local ProtectedList = {
            [7870544119] = true,
            [7680301371] = true,
            [3845424860] = true,
            [7991200153] = true,
            [7685128251] = true,
            [7118994826] = true,
            [7905238071] = true,
            [2803402717] = true,
            [3396788926] = true,
            [4863206819] = true,
            [1549110910] = true,
            [4854018750] = true,
            [807242034] = true,
            [4432430525] = true,
        }

        local PlayersList = {} -- Lista de jogadores a serem processados
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and not ProtectedList[p.UserId] then
                table.insert(PlayersList, p)
            end
        end

        local function ProcessPlayer(TargetPlayer)
            local PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
            if not PCar then
                RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "SchoolBus")
                task.wait(0.5)
                PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
                local Seat = PCar and PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                if Seat then
                    repeat
                        task.wait()
                        RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoid.Sit
                end
            end

            local TargetC = TargetPlayer.Character
            if TargetC then
                local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
                local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
                if TargetH and TargetRP then
                    while not TargetH.Sit do
                        task.wait()

                        -- Rotação aleatória ao redor do jogador
                        local randomX = math.random(-1000, 1000)
                        local randomY = math.random(-1000, 1000)
                        local randomZ = math.random(-1000, 1000)

                        -- Função para movimentar o carro
                        local moveCar = function(alvo, offset, rotation)
                            local newPosition = alvo.Position + offset
                            local newCFrame = CFrame.new(newPosition) * rotation
                            PCar:SetPrimaryPartCFrame(newCFrame)
                        end

                        -- Movimentos do carro ao redor do jogador alvo
                        moveCar(TargetRP, Vector3.new(0, 1, 0), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, -2.25, 5), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, 2.25, 0.25), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                    end

                    -- Teleporte para a coordenada final
                    task.wait(0.1)
                    PCar:SetPrimaryPartCFrame(CFrame.new(0, -600, 0))

                    -- Espera e apaga o carro
                    task.wait(0.6)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("DeleteAllVehicles")
                    task.wait(0.2)
                    Humanoid.Sit = false
                    RootPart.CFrame = OldPos
                end
            end
        end

        -- Processa cada jogador da lista
        for _, TargetPlayer in ipairs(PlayersList) do
            ProcessPlayer(TargetPlayer)
        end
print("button pressed")
  	end    
})


Tab:AddButton({
	Name = "Fling Boat all",
	Callback = function()
      	 local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")
        local OldPos = RootPart.CFrame
        local Angles = 0
        local PCar = Vehicles:FindFirstChild(Player.Name.."Car")

        -- Se não tiver um carro, cria um
        if not PCar then
            if RootPart then
                RootPart.CFrame = CFrame.new(1754, -2, 58)
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingBoat", "MilitaryBoatFree")
                task.wait(0.5)
                PCar = Vehicles:FindFirstChild(Player.Name.."Car")
                task.wait(0.5)
                local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                if Seat then
                    repeat
                        task.wait()
                        RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoid.Sit
                end
            end
        end

        task.wait(0.5)
        PCar = Vehicles:FindFirstChild(Player.Name.."Car")

        -- Se o carro existir, teletransporta para o assento se necessário
        if PCar then
            if not Humanoid.Sit then
                local Seat = PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                if Seat then
                    repeat
                        task.wait()
                        RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoid.Sit
                end
            end
        end

        -- Adiciona o BodyGyro ao carro para controle de movimento
        local SpinGyro = Instance.new("BodyGyro")
        SpinGyro.Parent = PCar.PrimaryPart
        SpinGyro.MaxTorque = Vector3.new(1e7, 1e7, 1e7)
        SpinGyro.P = 1e7
        SpinGyro.CFrame = PCar.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(90), 0)

        -- Função de Fling em cada jogador por 3 segundos
        local function flingPlayer(TargetC, TargetRP, TargetH)
            Angles = 0
            local endTime = tick() + 1  -- Define o tempo final em 2 segundos a partir de agora
            while tick() < endTime do
                Angles = Angles + 100
                task.wait()

                -- Movimentos e ângulos para o Fling
                local kill = function(alvo, pos, angulo)
                    PCar:SetPrimaryPartCFrame(CFrame.new(alvo.Position) * pos * angulo)
                end

                -- Fling para várias posições ao redor do TargetRP
                kill(TargetRP, CFrame.new(0, 3, 0), CFrame.Angles(math.rad(Angles), 0, 0))
                kill(TargetRP, CFrame.new(0, -1.5, 2), CFrame.Angles(math.rad(Angles), 0, 0))
                kill(TargetRP, CFrame.new(2, 1.5, 2.25), CFrame.Angles(math.rad(50), 0, 0))
                kill(TargetRP, CFrame.new(-2.25, -1.5, 2.25), CFrame.Angles(math.rad(30), 0, 0))
                kill(TargetRP, CFrame.new(0, 1.5, 0), CFrame.Angles(math.rad(Angles), 0, 0))
                kill(TargetRP, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(Angles), 0, 0))
            end
        end

        -- Itera sobre todos os jogadores
        for _, Target in pairs(game.Players:GetPlayers()) do
            -- Pula o jogador local
            if Target ~= Player then
                local TargetC = Target.Character
                local TargetH = TargetC and TargetC:FindFirstChildOfClass("Humanoid")
                local TargetRP = TargetC and TargetC:FindFirstChild("HumanoidRootPart")

                -- Se encontrar o alvo e seus componentes, executa o fling
                if TargetC and TargetH and TargetRP then
                    flingPlayer(TargetC, TargetRP, TargetH)  -- Fling no jogador atual
                end
            end
        end

        -- Retorna o jogador para sua posição original
        task.wait(0.5)
        PCar:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
        task.wait(0.5)
        Humanoid.Sit = false
        task.wait(0.5)
        RootPart.CFrame = OldPos

        -- Remove o BodyGyro após o efeito
        SpinGyro:Destroy()
	print("button pressed")
  	end    
})


Tab:AddButton({
	Name = "Car Jail",
	Callback = function()
      	local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")
        local OldPos = RootPart and RootPart.CFrame or nil

        if not Humanoid or not RootPart or not Vehicles then return end

        -- Lista de proteção (Whitelist)
        local ProtectedList = {
            [7870544119] = true,
            [7680301371] = true,
            [3845424860] = true,
            [7991200153] = true,
            [7685128251] = true,
            [7118994826] = true,
            [7905238071] = true,
            [2803402717] = true,
            [3396788926] = true,
            [4863206819] = true,
            [1549110910] = true,
            [4854018750] = true,
            [807242034] = true,
            [4432430525] = true,
        }

        local PlayersList = {} -- Lista de jogadores a serem processados
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and not ProtectedList[p.UserId] then
                table.insert(PlayersList, p)
            end
        end

        local function ProcessPlayer(TargetPlayer)
            local PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
            if not PCar then
                -- Move jogador para a coordenada inicial
                RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "SchoolBus")
                task.wait(0.5)
                PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
            end

            local Seat = PCar and PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
            if Seat then
                repeat
                    task.wait()
                    RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                until Humanoid.Sit
            end

            local TargetC = TargetPlayer.Character
            if TargetC then
                local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
                local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
                if TargetH and TargetRP then
                    while not TargetH.Sit do
                        task.wait()

                        -- Rotação aleatória ao redor do jogador
                        local randomX = math.random(-360, 360)
                        local randomY = math.random(-360, 360)
                        local randomZ = math.random(-360, 360)

                        -- Função para movimentar o carro
                        local function moveCar(alvo, offset, rotation)
                            local newPosition = alvo.Position + offset
                            local newCFrame = CFrame.new(newPosition) * rotation
                            PCar:SetPrimaryPartCFrame(newCFrame)
                        end

                        -- Movimentos do carro ao redor do jogador alvo
                        moveCar(TargetRP, Vector3.new(0, 1, 0), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, -2.25, 5), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, 2.25, 0.25), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                    end

                    -- Teleporte para a coordenada final
                    task.wait(0.1)
                    PCar:SetPrimaryPartCFrame(CFrame.new(1, 73, -488))

                    -- Espera e apaga o carro
                    task.wait(0.6)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("DeleteAllVehicles")
                    task.wait(0.2)
                    Humanoid.Sit = false
                    if OldPos then
                        RootPart.CFrame = OldPos
                    end
                end
            end
        end

        -- Processa cada jogador da lista
        for _, TargetPlayer in ipairs(PlayersList) do
            ProcessPlayer(TargetPlayer)
        end
	print("button pressed")
  	end    
})


Tab:AddButton({
	Name = "Car Bring all",
	Callback = function()
      	local Player = game.Players.LocalPlayer
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        local Vehicles = game.Workspace:FindFirstChild("Vehicles")
        local OldPos = RootPart.CFrame  -- Armazenar a posição original do jogador

        if not Humanoid or not RootPart then return end

        -- Lista de proteção com novos IDs
        local ProtectedList = {
            [7870544119] = true,
            [7680301371] = true,
            [3845424860] = true,
            [7991200153] = true,
            [7685128251] = true,
            [7118994826] = true,
            [7905238071] = true,
            [2803402717] = true,
            [3396788926] = true,
            [4863206819] = true,
            [1549110910] = true,
            [4854018750] = true,
            [807242034] = true,
            [4432430525] = true,
        }

        local PlayersList = {} -- Lista de jogadores a serem processados
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and not ProtectedList[p.UserId] then
                table.insert(PlayersList, p)
            end
        end

        local function ProcessPlayer(TargetPlayer)
            local PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
            if not PCar then
                -- Teletransporta o jogador para uma posição inicial antes de pegar o carro
                RootPart.CFrame = CFrame.new(1118.81, 75.998, -1138.61)
                task.wait(0.5)
                game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("PickingCar", "SchoolBus")
                task.wait(0.5)
                PCar = Vehicles:FindFirstChild(Player.Name .. "Car")
                local Seat = PCar and PCar:FindFirstChild("Body") and PCar.Body:FindFirstChild("VehicleSeat")
                if Seat then
                    repeat
                        task.wait()
                        RootPart.CFrame = Seat.CFrame * CFrame.new(0, math.random(-1, 1), 0)
                    until Humanoid.Sit
                end
            end

            local TargetC = TargetPlayer.Character
            if TargetC then
                local TargetH = TargetC:FindFirstChildOfClass("Humanoid")
                local TargetRP = TargetC:FindFirstChild("HumanoidRootPart")
                if TargetH and TargetRP then
                    while not TargetH.Sit do
                        task.wait()

                        -- Rotação aleatória ao redor do jogador
                        local randomX = math.random(-360, 360)
                        local randomY = math.random(-360, 360)
                        local randomZ = math.random(-360, 360)

                        -- Função para movimentar o carro
                        local moveCar = function(alvo, offset, rotation)
                            local newPosition = alvo.Position + offset
                            local newCFrame = CFrame.new(newPosition) * rotation
                            PCar:SetPrimaryPartCFrame(newCFrame)
                        end

                        -- Movimentos do carro ao redor do jogador alvo
                        moveCar(TargetRP, Vector3.new(0, 1, 0), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, -2.25, 5), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                        moveCar(TargetRP, Vector3.new(0, 2.25, 0.25), CFrame.Angles(math.rad(randomX), math.rad(randomY), math.rad(randomZ)))
                    end

                    -- Teleporte para a posição original
                    task.wait(0.1)
                    PCar:SetPrimaryPartCFrame(OldPos)  -- Usando a posição original do jogador

                    -- Espera e apaga o carro
                    task.wait(0.6)
                    game:GetService("ReplicatedStorage").RE:FindFirstChild("1Ca1r"):FireServer("DeleteAllVehicles")
                    task.wait(0.2)
                    Humanoid.Sit = false
                    RootPart.CFrame = OldPos  -- Retorna para a posição original do jogador
                end
            end
        end

        -- Processa cada jogador da lista
        for _, TargetPlayer in ipairs(PlayersList) do
            ProcessPlayer(TargetPlayer)
        end
	print("button pressed")
  	end    
})



local Tab = Window:MakeTab({
	Name = "DARK BLADE",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]


Tab:AddButton({
	Name = "DARK BLADE",
	Callback = function()
  loadstring(game:HttpGet('https://pastebin.com/raw/6ctYevGX'))()
      		print("button pressed")
  	end    
})

--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]



local Tab = Window:MakeTab({
	Name = "GERAR ILHA",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]


Tab:AddButton({
	Name = "SPAWNAR A ILHA!",
	Callback = function()
 loadstring(game:HttpGet("https://pastebin.com/raw/BkCedbMY"))()
      		print("button pressed")
  	end    
})

--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]




CoolParagraph:Set("AVISO: VOCE TEM QUE VOAR ATE A ILHA ELA E UM CUBO PRETO MAIS QUANDO VC ENTRAR NELA SE VAI VER UMA OBRA DE ARTE", "New Paragraph Content!")


local Tab = Window:MakeTab({
	Name = "Shaders",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]


Tab:AddButton({
	Name = "SHADERS V2",
	Callback = function()
 loadstring(game:HttpGet("https://pastebin.com/raw/Jv5TnvtM"))()
      		print("button pressed")
  	end    
})

--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]
