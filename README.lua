-- SADHUB | Mega Troll Panel (Key: askTroll)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

local old = player.PlayerGui:FindFirstChild("SADHUB_TrollHub")
if old then old:Destroy() end

-- ===== СИСТЕМА КЛЮЧА =====
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "SADHUB_TrollKey"
keyGui.ResetOnSpawn = false
keyGui.IgnoreGuiInset = true
keyGui.DisplayOrder = 100
keyGui.Parent = player.PlayerGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 300, 0, 160)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
keyFrame.Parent = keyGui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 10)

local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(200, 50, 200)
keyStroke.Thickness = 1.5
keyStroke.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 40)
keyTitle.BackgroundColor3 = Color3.fromRGB(25, 20, 30)
keyTitle.Text = "🔐 SADHUB KEY"
keyTitle.TextColor3 = Color3.fromRGB(240, 240, 250)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 15
keyTitle.Parent = keyFrame
Instance.new("UICorner", keyTitle).CornerRadius = UDim.new(0, 10)

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(1, -40, 0, 36)
keyInput.Position = UDim2.new(0, 20, 0, 55)
keyInput.BackgroundColor3 = Color3.fromRGB(35, 30, 40)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.Font = Enum.Font.Gotham
keyInput.TextSize = 14
keyInput.PlaceholderText = "Введите ключ (askTroll)"
keyInput.Text = ""
keyInput.Parent = keyFrame
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 6)

local keyBtn = Instance.new("TextButton")
keyBtn.Size = UDim2.new(1, -40, 0, 36)
keyBtn.Position = UDim2.new(0, 20, 0, 105)
keyBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 200)
keyBtn.Text = "ПРОВЕРИТЬ"
keyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBtn.Font = Enum.Font.GothamBold
keyBtn.TextSize = 14
keyBtn.Parent = keyFrame
Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 6)

local keyStatus = Instance.new("TextLabel")
keyStatus.Size = UDim2.new(1, -40, 0, 20)
keyStatus.Position = UDim2.new(0, 20, 1, -25)
keyStatus.BackgroundTransparency = 1
keyStatus.Text = ""
keyStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
keyStatus.Font = Enum.Font.Gotham
keyStatus.TextSize = 12
keyStatus.Parent = keyFrame

keyBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == "askTroll" then
        keyStatus.Text = "✅ Успешно!"
        keyStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(0.5)
        keyGui:Destroy()
        loadTrollHub()
    else
        keyStatus.Text = "❌ Неверный ключ!"
    end
end)

-- ===== ОСНОВНОЙ ХАБ =====
function loadTrollHub()
    local gui = Instance.new("ScreenGui")
    gui.Name = "SADHUB_TrollHub"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 99
    gui.Parent = player.PlayerGui

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 520, 0, 400)
    main.Position = UDim2.new(0.5, -260, 0.5, -200)
    main.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    main.Active = true
    main.Parent = gui
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(180, 50, 255)
    stroke.Thickness = 1.5
    stroke.Parent = main

    -- Перетаскивание
    local dragging, dragInput, dragStart, startPos
    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Заголовок
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    titleBar.Parent = main
    Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -50, 1, 0)
    title.Position = UDim2.new(0, 15, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "😈 SADHUB | MEGA TROLL HUB"
    title.TextColor3 = Color3.fromRGB(240, 240, 250)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = titleBar

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = titleBar
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    -- Боковая панель
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 130, 1, -40)
    sidebar.Position = UDim2.new(0, 0, 0, 40)
    sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
    sidebar.Parent = main

    local contentArea = Instance.new("Frame")
    contentArea.Size = UDim2.new(1, -130, 1, -40)
    contentArea.Position = UDim2.new(0, 130, 0, 40)
    contentArea.BackgroundTransparency = 1
    contentArea.Parent = main

    -- Хелперы
    local function createTab(text, yPos)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 35)
        btn.Position = UDim2.new(0, 0, 0, yPos)
        btn.BackgroundTransparency = 1
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(150, 150, 160)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13
        btn.Parent = sidebar
        
        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, -10, 1, -10)
        page.Position = UDim2.new(0, 5, 0, 5)
        page.BackgroundTransparency = 1
        page.ScrollBarThickness = 3
        page.Visible = false
        page.Parent = contentArea
        
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 6)
        layout.Parent = page

        btn.MouseButton1Click:Connect(function()
            for _, child in ipairs(sidebar:GetChildren()) do
                if child:IsA("TextButton") then child.TextColor3 = Color3.fromRGB(150, 150, 160) end
            end
            for _, child in ipairs(contentArea:GetChildren()) do
                if child:IsA("ScrollingFrame") then child.Visible = false end
            end
            btn.TextColor3 = Color3.fromRGB(200, 50, 255)
            page.Visible = true
        end)
        return page
    end

    local function createButton(parent, name, callback, color)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 32)
        btn.BackgroundColor3 = color or Color3.fromRGB(35, 30, 45)
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.Parent = parent
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        
        btn.MouseEnter:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color and color:Lerp(Color3.new(1,1,1), 0.2) or Color3.fromRGB(50, 40, 60)}):Play() end)
        btn.MouseLeave:Connect(function() TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color or Color3.fromRGB(35, 30, 45)}):Play() end)
        btn.MouseButton1Click:Connect(callback)
    end

    -- ВКЛАДКИ
    local PlayersTab = createTab("👥 Игроки", 5)
    local TrollTab = createTab("💀 Троллинг", 45)
    local ChaosTab = createTab("🌪️ Хаос", 85)
    local SettingsTab = createTab("⚙ Разное", 125)
    
    sidebar:GetChildren()[1].TextColor3 = Color3.fromRGB(200, 50, 255)
    PlayersTab.Visible = true

    -- ВКЛАДКА: ИГРОКИ
    local playerList = Instance.new("Frame")
    playerList.Size = UDim2.new(1, 0, 0, 200)
    playerList.BackgroundTransparency = 1
    playerList.Parent = PlayersTab
    
    local plrLayout = Instance.new("UIListLayout")
    plrLayout.Padding = UDim.new(0, 6)
    plrLayout.Parent = playerList

    local function updateList()
        for _, v in ipairs(playerList:GetChildren()) do
            if v:IsA("TextButton") then v:Destroy() end
        end
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player then
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 32)
                btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
                btn.Text = "  " .. plr.Name
                btn.TextColor3 = Color3.fromRGB(200, 200, 220)
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 12
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.Parent = playerList
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
                
                btn.MouseButton1Click:Connect(function()
                    _G.TargetPlayer = plr
                    for _, b in ipairs(playerList:GetChildren()) do
                        if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(25, 25, 35) end
                    end
                    btn.BackgroundColor3 = Color3.fromRGB(150, 50, 200)
                end)
            end
        end
    end
    updateList()
    Players.PlayerAdded:Connect(updateList)
    Players.PlayerRemoving:Connect(function() task.wait(1) updateList() end)

    -- Хелпер получения цели
    local function getTarget()
        if _G.TargetPlayer and _G.TargetPlayer.Character and _G.TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            return _G.TargetPlayer
        end
        return nil
    end

    -- ================= ВКЛАДКА: ТРОЛЛИНГ (10 функций) =================
    createButton(TrollTab, "🚀 ТП к игроку", function()
        local target = getTarget()
        if target and player.Character then
            player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
        end
    end, Color3.fromRGB(50, 150, 250))

    createButton(TrollTab, "🌪️ Кинуть в космос", function()
        local target = getTarget()
        if target and target.Character then
            local flingPart = Instance.new("Part")
            flingPart.Size = Vector3.new(2, 2, 2)
            flingPart.Transparency = 1
            flingPart.CanCollide = false
            flingPart.Parent = workspace
            flingPart.CFrame = target.Character.HumanoidRootPart.CFrame
            
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = target.Character.HumanoidRootPart
            weld.Part1 = flingPart
            weld.Parent = flingPart
            
            flingPart.Velocity = Vector3.new(math.random(-5000, 5000), 5000, math.random(-5000, 5000))
            flingPart.RotVelocity = Vector3.new(math.random(-5000, 5000), math.random(-5000, 5000), math.random(-5000, 5000))
            task.delay(3, function() if flingPart then flingPart:Destroy() end end)
        end
    end, Color3.fromRGB(200, 50, 200))

    createButton(TrollTab, "🧊 Заморозить (Anchor)", function()
        local target = getTarget()
        if target and target.Character then
            for _, part in ipairs(target.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.Anchored = true end
            end
        end
    end, Color3.fromRGB(100, 200, 255))

    createButton(TrollTab, "🔥 Поджечь (Fire)", function()
        local target = getTarget()
        if target and target.Character then
            local fire = Instance.new("Fire")
            fire.Size = 10
            fire.Heat = 50
            fire.Parent = target.Character.HumanoidRootPart
        end
    end, Color3.fromRGB(255, 100, 50))

    createButton(TrollTab, "💥 Взорвать", function()
        local target = getTarget()
        if target and target.Character then
            local exp = Instance.new("Explosion")
            exp.BlastRadius = 15
            exp.BlastPressure = 500000
            exp.Position = target.Character.HumanoidRootPart.Position
            exp.Parent = workspace
        end
    end, Color3.fromRGB(200, 50, 50))

    createButton(TrollTab, "🦠 Заразить (Plague)", function()
        local target = getTarget()
        if target and target.Character then
            local smoke = Instance.new("Smoke")
            smoke.Color = Color3.fromRGB(0, 255, 0)
            smoke.Size = 5
            smoke.Parent = target.Character.HumanoidRootPart
        end
    end, Color3.fromRGB(50, 200, 50))

    createButton(TrollTab, "🎈 Надуть (Grow)", function()
        local target = getTarget()
        if target and target.Character then
            for _, part in ipairs(target.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Size = part.Size * 2
                end
            end
        end
    end, Color3.fromRGB(255, 150, 50))

    createButton(TrollTab, "🪡 Уменьшить (Shrink)", function()
        local target = getTarget()
        if target and target.Character then
            for _, part in ipairs(target.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Size = part.Size / 2
                end
            end
        end
    end, Color3.fromRGB(50, 255, 150))

    createButton(TrollTab, "💀 Убить (Kill)", function()
        local target = getTarget()
        if target and target.Character and target.Character:FindFirstChild("Humanoid") then
            target.Character.Humanoid.Health = 0
        end
    end, Color3.fromRGB(200, 20, 20))

    createButton(TrollTab, "🧲 Прилипнуть", function()
        local target = getTarget()
        if target and player.Character then
            player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = target.Character.HumanoidRootPart
            weld.Part1 = player.Character.HumanoidRootPart
            weld.Parent = player.Character.HumanoidRootPart
            task.delay(5, function() if weld then weld:Destroy() end end)
        end
    end, Color3.fromRGB(150, 150, 50))

    -- ================= ВКЛАДКА: ХАОС (10 функций) =================
    createButton(ChaosTab, "🌍 Нулевая гравитация", function()
        workspace.Gravity = 0
    end, Color3.fromRGB(100, 100, 255))

    createButton(ChaosTab, "🌍 Космическая гравитация", function()
        workspace.Gravity = 300
    end, Color3.fromRGB(255, 100, 100))

    createButton(ChaosTab, "☀️ Включить день (Day)", function()
        Lighting.ClockTime = 12
    end, Color3.fromRGB(255, 255, 100))

    createButton(ChaosTab, "🌙 Включить ночь (Night)", function()
        Lighting.ClockTime = 0
    end, Color3.fromRGB(50, 50, 100))

    createButton(ChaosTab, "💡 Слепящий свет (Fullbright)", function()
        Lighting.Brightness = 5
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    end, Color3.fromRGB(255, 255, 255))

    createButton(ChaosTab, "🟥 Красный туман", function()
        Lighting.FogColor = Color3.fromRGB(255, 0, 0)
        Lighting.FogEnd = 50
    end, Color3.fromRGB(200, 0, 0))

    createButton(ChaosTab, "🟩 Зеленый туман", function()
        Lighting.FogColor = Color3.fromRGB(0, 255, 0)
        Lighting.FogEnd = 50
    end, Color3.fromRGB(0, 200, 0))

    createButton(ChaosTab, "🎵 Включить громкую музыку", function()
        local music = Instance.new("Sound")
        music.SoundId = "rbxassetid://1837879082" -- Стандартный громкий звук
        music.Volume = 10
        music.Looped = true
        music.Parent = workspace
        music:Play()
    end, Color3.fromRGB(200, 50, 200))

    createButton(ChaosTab, "☄️ Метеоритный дождь", function()
        for i = 1, 10 do
            task.spawn(function()
                local part = Instance.new("Part")
                part.Size = Vector3.new(5, 5, 5)
                part.Position = player.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 100, math.random(-50, 50))
                part.Color = Color3.fromRGB(255, 100, 0)
                part.Parent = workspace
                part.Velocity = Vector3.new(0, -500, 0)
                task.delay(5, function() part:Destroy() end)
            end)
            task.wait(0.2)
        end
    end, Color3.fromRGB(255, 50, 0))

    createButton(ChaosTab, "👻 Спектральный режим", function()
        if player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.Transparency = 0.5 end
            end
        end
    end, Color3.fromRGB(150, 150, 255))

    -- ================= ВКЛАДКА: РАЗНОЕ =================
    createButton(SettingsTab, "🔄 Респавн", function()
        if player.Character then player.Character:BreakJoints() end
    end, Color3.fromRGB(100, 100, 100))

    createButton(SettingsTab, "🧹 Убрать эффекты", function()
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sound") then v:Destroy() end
        end
    end, Color3.fromRGB(100, 150, 200))
end
