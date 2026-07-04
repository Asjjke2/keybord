-- ========================================================
-- واجهة خالد الأسطورة V6: فحص كامل للماب + سرعة خارقة + God Mode حقيقي
-- ========================================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local ButtonsScroll = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

local ToggleButton = Instance.new("Frame")
local ToggleImage = Instance.new("ImageButton")
local UICorner_Frame = Instance.new("UICorner")
local UICorner_Image = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "KhaledCrunchyFinalHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 260)
MainFrame.Active = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, -40, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "سكربت خالد الاسطورة V6"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 15
Title.Font = Enum.Font.SourceSansBold

CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 40, 0, 45)
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.SourceSansBold

ButtonsScroll.Parent = MainFrame
ButtonsScroll.Position = UDim2.new(0.05, 0, 0.22, 0)
ButtonsScroll.Size = UDim2.new(0.9, 0, 0, 190)
ButtonsScroll.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ButtonsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ButtonsScroll.ScrollBarThickness = 6

UIListLayout.Parent = ButtonsScroll
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

ToggleButton.Name = "KhaledCustomDragButton"
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 48, 0, 48)
ToggleButton.Position = UDim2.new(0.02, 0, 0.4, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.Visible = false
ToggleButton.Active = true

UICorner_Frame.CornerRadius = UDim.new(0, 6)
UICorner_Frame.Parent = ToggleButton

ToggleImage.Parent = ToggleButton
ToggleImage.Size = UDim2.new(0, 40, 0, 40)
ToggleImage.Position = UDim2.new(0.5, -20, 0.5, -20)
ToggleImage.BackgroundTransparency = 1
ToggleImage.Image = "rbxassetid://117228230346733"

UICorner_Image.CornerRadius = UDim.new(0, 4)
UICorner_Image.Parent = ToggleImage

local function makeDraggable(frame, customHandle)
    local UserInputService = game:GetService("UserInputService")
    local dragging, dragInput, dragStart, startPos
    local handle = customHandle or frame
    
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

makeDraggable(MainFrame)
makeDraggable(ToggleButton, ToggleImage)

ToggleImage.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ToggleButton.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ToggleButton.Visible = true
end)

-- ========================================================
-- المحرك الخارق: God Mode + حركة أرضية سريعة + فحص كلي
-- ========================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local activeWinLoop = nil
local foundButtons = {}
local buttonToggles = {}

-- نظام God Mode المطور لمنع الموت تماماً من ليزرات الماب
task.spawn(function()
    while true do
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                -- جعل اللاعب غير قابل للمس من أجزاء الموت
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanTouch = true
                    end
                end
                
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.MaxHealth = 999999
                    hum.Health = 999999
                    if hum.Health == 0 then
                        hum.Health = 999999
                    end
                end
            end
        end)
        task.wait(0.05)
    end
end)

-- دالة الحركة الأرضية الخارقة بسرعة 300 (تضمن ملامسة الأرض واحتساب النقاط)
local function fastWalkOnGround(part)
    if part and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local targetPos = part.Position
        
        -- الحفاظ على ملامسة الأرض تماماً (نفس مستوى ارتفاع اللاعب الحالي)
        local startY = hrp.Position.Y
        
        -- حلقة تحريك سريعة وثابتة نحو الهدف
        while (hrp.Position - targetPos).Magnitude > 5 and activeWinLoop == part do
            local currentPos = hrp.Position
            local direction = (targetPos - currentPos).Unit
            
            -- سرعة التحرك الخارقة (300)
            local speed = 300
            local nextPos = currentPos + (direction * (speed * 0.03))
            
            -- الإبقاء على اللاعب فوق الأرض مباشرة ليحسب له النقاط والخطوات
            hrp.Velocity = direction * speed
            hrp.CFrame = CFrame.new(nextPos.X, startY, nextPos.Z)
            
            task.wait(0.03)
        end
        
        -- عند الوصول، تفعيل اللمس المباشر للحصول على الـ Wins
        if firetouchinterest and activeWinLoop == part then
            firetouchinterest(hrp, part, 0)
            task.wait(0.02)
            firetouchinterest(hrp, part, 1)
        end
    end
end

-- دالة الفحص الكلي الشامل للماب بالكامل (يبحث بعمق بدون شروط مسافة)
local function scanAllPlatforms()
    -- البحث في كل مكان داخل الـ Workspace
    local allObjects = Workspace:GetDescendants()
    
    for _, v in pairs(allObjects) do
        if v:IsA("TouchTransmitter") and v.Parent then
            local btnPart = v.Parent
            local detectedText = ""
            local isWinPlatform = false
            local hasStep = false
            
            local container = btnPart.Parent
            if container then
                for _, child in pairs(container:GetDescendants()) do
                    if child:IsA("TextLabel") then
                        local txt = child.Text
                        local lowerTxt = txt:lower()
                        if string.find(lowerTxt, "step") then hasStep = true end
                        if string.find(lowerTxt, "win") or (string.find(txt, "+") and not string.find(lowerTxt, "step")) then
                            detectedText = txt
                            isWinPlatform = true
                        end
                    end
                end
                
                -- فحص بالاسم إذا لم تتوفر لوحة نصية محملة
                if not isWinPlatform and not hasStep then
                    local cName = container.Name:lower()
                    local pName = btnPart.Name:lower()
                    if string.find(cName, "win") or string.find(cName, "platform") or string.find(pName, "win") or string.find(pName, "+") then
                        detectedText = container.Name
                        isWinPlatform = true
                    end
                end
            end
            
            -- فلترة وإدراج المنصة فوراً
            if isWinPlatform and not hasStep and not foundButtons[btnPart] then
                local lowerPartName = btnPart.Name:lower()
                if not string.find(lowerPartName, "kill") and not string.find(lowerPartName, "lava") then
                    
                    foundButtons[btnPart] = true
                    buttonToggles[btnPart] = false
                    
                    local finalButtonText = (detectedText ~= "") and ("انطلاق سريع: " .. detectedText) or ("منصة فوز: " .. btnPart.Name)
                    
                    local NewBtn = Instance.new("TextButton")
                    NewBtn.Parent = ButtonsScroll
                    NewBtn.Size = UDim2.new(1, -10, 0, 38)
                    NewBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    NewBtn.Text = finalButtonText
                    NewBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    NewBtn.TextSize = 11
                    NewBtn.Font = Enum.Font.SourceSansBold
                    
                    ButtonsScroll.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
                    
                    NewBtn.MouseButton1Click:Connect(function()
                        if not buttonToggles[btnPart] then
                            activeWinLoop = nil
                            for part, _ in pairs(buttonToggles) do
                                buttonToggles[part] = false
                            end
                            for _, child in pairs(ButtonsScroll:GetChildren()) do
                                if child:IsA("TextButton") then
                                    child.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                                end
                            end
                            
                            task.wait(0.02)
                            
                            local currentLoop = btnPart
                            activeWinLoop = currentLoop
                            buttonToggles[currentLoop] = true
                            NewBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
                            
                            task.spawn(function()
                                while activeWinLoop == currentLoop do
                                    fastWalkOnGround(currentLoop)
                                    task.wait(0.2)
                                end
                                NewBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                                buttonToggles[currentLoop] = false
                            end)
                        else
                            activeWinLoop = nil
                            buttonToggles[btnPart] = false
                            NewBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                        end
                    end)
                end
            end
        end
    end
end

-- تشغيل فحص الماب الشامل والمستمر كل ثانية
task.spawn(function()
    while true do
        scanAllPlatforms()
        task.wait(1)
    end
end)
