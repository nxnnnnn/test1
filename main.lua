-- LocalScript สำหรับรันบน Delta Executor
-- Script Name: momo v1.1 (With Speed & Jump Toggle)

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- ป้องกันสร้าง GUI ซ้ำ
if CoreGui:FindFirstChild("MomoV1_1GUI") then
    CoreGui.MomoV1_1GUI:Destroy()
end

-- 1. สร้าง ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MomoV1_1GUI"
ScreenGui.ResetOnSpawn = false

if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui
end

-- 2. ปุ่มวงกลมเปิด/ปิด GUI (Toggle Button)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ToggleButton.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "momo"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16
ToggleButton.Active = true
ToggleButton.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(0, 170, 255)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleButton

-- 3. หน้าต่างหลัก (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -200)
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(45, 45, 55)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

-- Top Bar (หัวข้อ momo v1.1)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TopBar.Size = UDim2.new(1, 0, 0, 35)

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 10)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "momo v1.1"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TopBar
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 1, 0)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 85, 85)
CloseButton.TextSize = 16

-- ScrollFrame สำหรับเลื่อนดูเมนูทั้งหมด
local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Parent = MainFrame
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.Position = UDim2.new(0, 10, 0, 40)
ScrollContainer.Size = UDim2.new(1, -20, 1, -45)
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 750)
ScrollContainer.ScrollBarThickness = 4
ScrollContainer.BorderSizePixel = 0

---------------------------------------------------------
-- ระบบ 1: ความเร็ว (WalkSpeed Toggle)
---------------------------------------------------------
local SpeedInput = Instance.new("TextBox")
SpeedInput.Parent = ScrollContainer
SpeedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SpeedInput.Position = UDim2.new(0, 0, 0, 5)
SpeedInput.Size = UDim2.new(0.48, 0, 0, 32)
SpeedInput.Font = Enum.Font.SourceSans
SpeedInput.PlaceholderText = "ใส่ความเร็ว..."
SpeedInput.Text = "100"
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.TextSize = 14

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 6)
SpeedCorner.Parent = SpeedInput

local SpeedToggleBtn = Instance.new("TextButton")
SpeedToggleBtn.Parent = ScrollContainer
SpeedToggleBtn.BackgroundColor3 = Color3.fromRGB(170, 50, 50)
SpeedToggleBtn.Position = UDim2.new(0.52, 0, 0, 5)
SpeedToggleBtn.Size = UDim2.new(0.48, 0, 0, 32)
SpeedToggleBtn.Font = Enum.Font.SourceSansBold
SpeedToggleBtn.Text = "ความเร็ว: ปิด"
SpeedToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedToggleBtn.TextSize = 14

local SpeedToggleCorner = Instance.new("UICorner")
SpeedToggleCorner.CornerRadius = UDim.new(0, 6)
SpeedToggleCorner.Parent = SpeedToggleBtn

---------------------------------------------------------
-- ระบบ 2: กระโดดสูง (JumpPower Toggle)
---------------------------------------------------------
local JumpInput = Instance.new("TextBox")
JumpInput.Parent = ScrollContainer
JumpInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
JumpInput.Position = UDim2.new(0, 0, 0, 45)
JumpInput.Size = UDim2.new(0.48, 0, 0, 32)
JumpInput.Font = Enum.Font.SourceSans
JumpInput.PlaceholderText = "ใส่แรงกระโดด..."
JumpInput.Text = "100"
JumpInput.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpInput.TextSize = 14

local JumpCorner = Instance.new("UICorner")
JumpCorner.CornerRadius = UDim.new(0, 6)
JumpCorner.Parent = JumpInput

local JumpToggleBtn = Instance.new("TextButton")
JumpToggleBtn.Parent = ScrollContainer
JumpToggleBtn.BackgroundColor3 = Color3.fromRGB(170, 50, 50)
JumpToggleBtn.Position = UDim2.new(0.52, 0, 0, 45)
JumpToggleBtn.Size = UDim2.new(0.48, 0, 0, 32)
JumpToggleBtn.Font = Enum.Font.SourceSansBold
JumpToggleBtn.Text = "กระโดด: ปิด"
JumpToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpToggleBtn.TextSize = 14

local JumpToggleCorner = Instance.new("UICorner")
JumpToggleCorner.CornerRadius = UDim.new(0, 6)
JumpToggleCorner.Parent = JumpToggleBtn

---------------------------------------------------------
-- ระบบ 3: บิน (Fly)
---------------------------------------------------------
local FlyButton = Instance.new("TextButton")
FlyButton.Parent = ScrollContainer
FlyButton.BackgroundColor3 = Color3.fromRGB(170, 50, 50)
FlyButton.Position = UDim2.new(0, 0, 0, 85)
FlyButton.Size = UDim2.new(1, 0, 0, 32)
FlyButton.Font = Enum.Font.SourceSansBold
FlyButton.Text = "โหมดบิน (Fly): ปิดอยู่"
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.TextSize = 14

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0, 6)
FlyCorner.Parent = FlyButton

---------------------------------------------------------
-- ระบบ 4: ESP ผู้เล่น
---------------------------------------------------------
local Line0 = Instance.new("Frame")
Line0.Parent = ScrollContainer
Line0.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
Line0.Position = UDim2.new(0, 0, 0, 125)
Line0.Size = UDim2.new(1, 0, 0, 2)

local ESPHeader = Instance.new("TextLabel")
ESPHeader.Parent = ScrollContainer
ESPHeader.BackgroundTransparency = 1
ESPHeader.Position = UDim2.new(0, 0, 0, 132)
ESPHeader.Size = UDim2.new(1, 0, 0, 20)
ESPHeader.Font = Enum.Font.SourceSansBold
ESPHeader.Text = "👁 ระบบมองผู้เล่น (ESP)"
ESPHeader.TextColor3 = Color3.fromRGB(0, 200, 255)
ESPHeader.TextSize = 15

local ESPBoxBtn = Instance.new("TextButton")
ESPBoxBtn.Parent = ScrollContainer
ESPBoxBtn.BackgroundColor3 = Color3.fromRGB(170, 50, 50)
ESPBoxBtn.Position = UDim2.new(0, 0, 0, 157)
ESPBoxBtn.Size = UDim2.new(0.48, 0, 0, 32)
ESPBoxBtn.Font = Enum.Font.SourceSansBold
ESPBoxBtn.Text = "ESP Box: ปิด"
ESPBoxBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBoxBtn.TextSize = 14

local ESPBoxCorner = Instance.new("UICorner")
ESPBoxCorner.CornerRadius = UDim.new(0, 6)
ESPBoxCorner.Parent = ESPBoxBtn

local ESPNameBtn = Instance.new("TextButton")
ESPNameBtn.Parent = ScrollContainer
ESPNameBtn.BackgroundColor3 = Color3.fromRGB(170, 50, 50)
ESPNameBtn.Position = UDim2.new(0.52, 0, 0, 157)
ESPNameBtn.Size = UDim2.new(0.48, 0, 0, 32)
ESPNameBtn.Font = Enum.Font.SourceSansBold
ESPNameBtn.Text = "ESP Name: ปิด"
ESPNameBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPNameBtn.TextSize = 14

local ESPNameCorner = Instance.new("UICorner")
ESPNameCorner.CornerRadius = UDim.new(0, 6)
ESPNameCorner.Parent = ESPNameBtn

---------------------------------------------------------
-- ระบบ 5: วาร์ปหาผู้เล่น / Tween หาผู้เล่น
---------------------------------------------------------
local Line1 = Instance.new("Frame")
Line1.Parent = ScrollContainer
Line1.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
Line1.Position = UDim2.new(0, 0, 0, 200)
Line1.Size = UDim2.new(1, 0, 0, 2)

local PlayerHeader = Instance.new("TextLabel")
PlayerHeader.Parent = ScrollContainer
PlayerHeader.BackgroundTransparency = 1
PlayerHeader.Position = UDim2.new(0, 0, 0, 207)
PlayerHeader.Size = UDim2.new(1, 0, 0, 20)
PlayerHeader.Font = Enum.Font.SourceSansBold
PlayerHeader.Text = "👤 ระบบวาร์ป & Tween หาผู้เล่น"
PlayerHeader.TextColor3 = Color3.fromRGB(0, 200, 255)
PlayerHeader.TextSize = 15

local PlayerNameInput = Instance.new("TextBox")
PlayerNameInput.Parent = ScrollContainer
PlayerNameInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
PlayerNameInput.Position = UDim2.new(0, 0, 0, 232)
PlayerNameInput.Size = UDim2.new(1, 0, 0, 30)
PlayerNameInput.Font = Enum.Font.SourceSans
PlayerNameInput.PlaceholderText = "พิมพ์ชื่อผู้เล่น (พิมพ์แค่บางส่วนได้)..."
PlayerNameInput.Text = ""
PlayerNameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerNameInput.TextSize = 14

local PlayerNameCorner = Instance.new("UICorner")
PlayerNameCorner.CornerRadius = UDim.new(0, 6)
PlayerNameCorner.Parent = PlayerNameInput

local TPPlayerBtn = Instance.new("TextButton")
TPPlayerBtn.Parent = ScrollContainer
TPPlayerBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
TPPlayerBtn.Position = UDim2.new(0, 0, 0, 270)
TPPlayerBtn.Size = UDim2.new(0.48, 0, 0, 32)
TPPlayerBtn.Font = Enum.Font.SourceSansBold
TPPlayerBtn.Text = "⚡ วาร์ปไปหา"
TPPlayerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TPPlayerBtn.TextSize = 14

local TPPlayerCorner = Instance.new("UICorner")
TPPlayerCorner.CornerRadius = UDim.new(0, 6)
TPPlayerCorner.Parent = TPPlayerBtn

local TweenPlayerBtn = Instance.new("TextButton")
TweenPlayerBtn.Parent = ScrollContainer
TweenPlayerBtn.BackgroundColor3 = Color3.fromRGB(150, 80, 200)
TweenPlayerBtn.Position = UDim2.new(0.52, 0, 0, 270)
TweenPlayerBtn.Size = UDim2.new(0.48, 0, 0, 32)
TweenPlayerBtn.Font = Enum.Font.SourceSansBold
TweenPlayerBtn.Text = "🚀 Tween บินไปหา"
TweenPlayerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TweenPlayerBtn.TextSize = 14

local TweenPlayerCorner = Instance.new("UICorner")
TweenPlayerCorner.CornerRadius = UDim.new(0, 6)
TweenPlayerCorner.Parent = TweenPlayerBtn

local CancelTweenBtn = Instance.new("TextButton")
CancelTweenBtn.Parent = ScrollContainer
CancelTweenBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
CancelTweenBtn.Position = UDim2.new(0, 0, 0, 308)
CancelTweenBtn.Size = UDim2.new(1, 0, 0, 28)
CancelTweenBtn.Font = Enum.Font.SourceSansBold
CancelTweenBtn.Text = "❌ ยกเลิกการ Tween บิน"
CancelTweenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CancelTweenBtn.TextSize = 13

local CancelTweenCorner = Instance.new("UICorner")
CancelTweenCorner.CornerRadius = UDim.new(0, 6)
CancelTweenCorner.Parent = CancelTweenBtn

---------------------------------------------------------
-- ระบบ 6: Safe / Teleport จุดวาร์ป
---------------------------------------------------------
local Line2 = Instance.new("Frame")
Line2.Parent = ScrollContainer
Line2.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
Line2.Position = UDim2.new(0, 0, 0, 345)
Line2.Size = UDim2.new(1, 0, 0, 2)

local TPHeader = Instance.new("TextLabel")
TPHeader.Parent = ScrollContainer
TPHeader.BackgroundTransparency = 1
TPHeader.Position = UDim2.new(0, 0, 0, 352)
TPHeader.Size = UDim2.new(1, 0, 0, 20)
TPHeader.Font = Enum.Font.SourceSansBold
TPHeader.Text = "📍 ระบบเซฟ & วาร์ปจุด"
TPHeader.TextColor3 = Color3.fromRGB(0, 200, 255)
TPHeader.TextSize = 15

local WaypointNameInput = Instance.new("TextBox")
WaypointNameInput.Parent = ScrollContainer
WaypointNameInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
WaypointNameInput.Position = UDim2.new(0, 0, 0, 377)
WaypointNameInput.Size = UDim2.new(0.65, 0, 0, 30)
WaypointNameInput.Font = Enum.Font.SourceSans
WaypointNameInput.PlaceholderText = "พิมพ์ชื่อจุดวาร์ป..."
WaypointNameInput.Text = ""
WaypointNameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
WaypointNameInput.TextSize = 14

local WaypointNameCorner = Instance.new("UICorner")
WaypointNameCorner.CornerRadius = UDim.new(0, 6)
WaypointNameCorner.Parent = WaypointNameInput

local SaveButton = Instance.new("TextButton")
SaveButton.Parent = ScrollContainer
SaveButton.BackgroundColor3 = Color3.fromRGB(0, 150, 100)
SaveButton.Position = UDim2.new(0.68, 0, 0, 377)
SaveButton.Size = UDim2.new(0.32, 0, 0, 30)
SaveButton.Font = Enum.Font.SourceSansBold
SaveButton.Text = "+ เซฟจุดนี้"
SaveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveButton.TextSize = 14

local SaveCorner = Instance.new("UICorner")
SaveCorner.CornerRadius = UDim.new(0, 6)
SaveCorner.Parent = SaveButton

local WaypointScroll = Instance.new("ScrollingFrame")
WaypointScroll.Parent = ScrollContainer
WaypointScroll.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
WaypointScroll.Position = UDim2.new(0, 0, 0, 415)
WaypointScroll.Size = UDim2.new(1, 0, 0, 250)
WaypointScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
WaypointScroll.ScrollBarThickness = 4

local WaypointCorner = Instance.new("UICorner")
WaypointCorner.CornerRadius = UDim.new(0, 6)
WaypointCorner.Parent = WaypointScroll

local WaypointListLayout = Instance.new("UIListLayout")
WaypointListLayout.Parent = WaypointScroll
WaypointListLayout.SortOrder = Enum.SortOrder.LayoutOrder
WaypointListLayout.Padding = UDim.new(0, 5)

local WaypointPadding = Instance.new("UIPadding")
WaypointPadding.Parent = WaypointScroll
WaypointPadding.PaddingTop = UDim.new(0, 5)
WaypointPadding.PaddingLeft = UDim.new(0, 5)
WaypointPadding.PaddingRight = UDim.new(0, 5)

---------------------------------------------------------
-- LOGIC & FUNCTIONS
---------------------------------------------------------

-- สถานะการเปิด/ปิด ความเร็ว และ กระโดด
local isSpeedEnabled = false
local isJumpEnabled = false

SpeedToggleBtn.MouseButton1Click:Connect(function()
    isSpeedEnabled = not isSpeedEnabled
    if isSpeedEnabled then
        SpeedToggleBtn.Text = "ความเร็ว: เปิดอยู่"
        SpeedToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 170, 50)
    else
        SpeedToggleBtn.Text = "ความเร็ว: ปิด"
        SpeedToggleBtn.BackgroundColor3 = Color3.fromRGB(170, 50, 50)
        -- คืนค่าความเร็วปกติ
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
        end
    end
end)

JumpToggleBtn.MouseButton1Click:Connect(function()
    isJumpEnabled = not isJumpEnabled
    if isJumpEnabled then
        JumpToggleBtn.Text = "กระโดด: เปิดอยู่"
        JumpToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 170, 50)
    else
        JumpToggleBtn.Text = "กระโดด: ปิด"
        JumpToggleBtn.BackgroundColor3 = Color3.fromRGB(170, 50, 50)
        -- คืนค่าแรงกระโดดปกติ
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            humanoid.JumpPower = 50
        end
    end
end)

-- 1. WalkSpeed & JumpPower Loop
RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        
        -- ทำงานเฉพาะเมื่อปุ่มถูกเปิด
        if isSpeedEnabled then
            local numSpeed = tonumber(SpeedInput.Text)
            if numSpeed then humanoid.WalkSpeed = numSpeed end
        end
        
        if isJumpEnabled then
            local numJump = tonumber(JumpInput.Text)
            if numJump then
                humanoid.UseJumpPower = true
                humanoid.JumpPower = numJump
            end
        end
    end
end)

-- 2. Fly Logic
local flying = false
local flySpeed = 50
local bodyVelocity, bodyGyro

local function startFlying()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.cframe = root.CFrame
    bodyGyro.Parent = root

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.velocity = Vector3.new(0, 0.1, 0)
    bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Parent = root

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then humanoid.PlatformStand = true end

    task.spawn(function()
        while flying do
            RunService.RenderStepped:Wait()
            local camera = workspace.CurrentCamera
            if bodyGyro and bodyVelocity and root then
                bodyGyro.cframe = camera.CFrame
                local moveDir = humanoid and humanoid.MoveDirection or Vector3.new()
                if moveDir.Magnitude > 0 then
                    bodyVelocity.velocity = camera.CFrame.LookVector * (moveDir.Magnitude * flySpeed)
                else
                    bodyVelocity.velocity = Vector3.new(0, 0, 0)
                end
            end
        end
    end)
end

local function stopFlying()
    if bodyGyro then bodyGyro:Destroy() end
    if bodyVelocity then bodyVelocity:Destroy() end
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").PlatformStand = false
    end
end

FlyButton.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        FlyButton.Text = "โหมดบิน (Fly): เปิดอยู่"
        FlyButton.BackgroundColor3 = Color3.fromRGB(50, 170, 50)
        startFlying()
    else
        FlyButton.Text = "โหมดบิน (Fly): ปิดอยู่"
        FlyButton.BackgroundColor3 = Color3.fromRGB(170, 50, 50)
        stopFlying()
    end
end)

---------------------------------------------------------
-- ESP Logic System
---------------------------------------------------------
local espBoxEnabled = false
local espNameEnabled = false

local function createESP(plr)
    if plr == LocalPlayer then return end

    local function applyESP(char)
        if not char then return end
        local root = char:WaitForChild("HumanoidRootPart", 5)
        local head = char:WaitForChild("Head", 5)
        if not root or not head then return end

        if char:FindFirstChild("MomoESPBox") then char.MomoESPBox:Destroy() end
        if head:FindFirstChild("MomoESPName") then head.MomoESPName:Destroy() end

        -- 1. ESP Box
        local box = Instance.new("Highlight")
        box.Name = "MomoESPBox"
        box.Adornee = char
        box.FillColor = Color3.fromRGB(255, 0, 100)
        box.FillTransparency = 0.5
        box.OutlineColor = Color3.fromRGB(255, 255, 255)
        box.OutlineTransparency = 0
        box.Enabled = espBoxEnabled
        box.Parent = char

        -- 2. ESP Name & Distance
        local bg = Instance.new("BillboardGui")
        bg.Name = "MomoESPName"
        bg.Adornee = head
        bg.Size = UDim2.new(0, 200, 0, 50)
        bg.StudsOffset = Vector3.new(0, 2.5, 0)
        bg.AlwaysOnTop = true
        bg.Enabled = espNameEnabled

        local txt = Instance.new("TextLabel")
        txt.Parent = bg
        txt.Size = UDim2.new(1, 0, 1, 0)
        txt.BackgroundTransparency = 1
        txt.Font = Enum.Font.SourceSansBold
        txt.TextColor3 = Color3.fromRGB(0, 255, 200)
        txt.TextSize = 14
        txt.TextStrokeTransparency = 0

        bg.Parent = head

        task.spawn(function()
            while bg and bg.Parent and char and char:FindFirstChild("HumanoidRootPart") do
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local myRoot = LocalPlayer.Character.HumanoidRootPart
                    local dist = math.floor((myRoot.Position - char.HumanoidRootPart.Position).Magnitude)
                    txt.Text = plr.DisplayName .. " (@" .. plr.Name .. ")\n[" .. tostring(dist) .. "m]"
                else
                    txt.Text = plr.Name
                end
                task.wait(0.2)
            end
        end)
    end

    if plr.Character then
        applyESP(plr.Character)
    end
    plr.CharacterAdded:Connect(applyESP)
end

for _, plr in pairs(Players:GetPlayers()) do
    createESP(plr)
end
Players.PlayerAdded:Connect(createESP)

ESPBoxBtn.MouseButton1Click:Connect(function()
    espBoxEnabled = not espBoxEnabled
    ESPBoxBtn.Text = espBoxEnabled and "ESP Box: เปิดอยู่" or "ESP Box: ปิด"
    ESPBoxBtn.BackgroundColor3 = espBoxEnabled and Color3.fromRGB(50, 170, 50) or Color3.fromRGB(170, 50, 50)

    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("MomoESPBox") then
            plr.Character.MomoESPBox.Enabled = espBoxEnabled
        end
    end
end)

ESPNameBtn.MouseButton1Click:Connect(function()
    espNameEnabled = not espNameEnabled
    ESPNameBtn.Text = espNameEnabled and "ESP Name: เปิดอยู่" or "ESP Name: ปิด"
    ESPNameBtn.BackgroundColor3 = espNameEnabled and Color3.fromRGB(50, 170, 50) or Color3.fromRGB(170, 50, 50)

    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("Head") then
            local bg = plr.Character.Head:FindFirstChild("MomoESPName")
            if bg then
                bg.Enabled = espNameEnabled
            end
        end
    end
end)

-- 3. Player Search Helper Function
local function getPlayerByPartialName(name)
    name = string.lower(name)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if string.find(string.lower(plr.Name), name) or string.find(string.lower(plr.DisplayName), name) then
                return plr
            end
        end
    end
    return nil
end

-- 4. Teleport & Tween To Player Logic
local currentTween = nil

TPPlayerBtn.MouseButton1Click:Connect(function()
    local text = PlayerNameInput.Text
    if text == "" then return end
    
    local targetPlr = getPlayerByPartialName(text)
    if targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = targetPlr.Character.HumanoidRootPart.CFrame + Vector3.new(3, 1, 0)
        end
    end
end)

TweenPlayerBtn.MouseButton1Click:Connect(function()
    local text = PlayerNameInput.Text
    if text == "" then return end
    
    local targetPlr = getPlayerByPartialName(text)
    if targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            local myRoot = myChar.HumanoidRootPart
            local targetRoot = targetPlr.Character.HumanoidRootPart
            
            local distance = (targetRoot.Position - myRoot.Position).Magnitude
            local tweenTime = distance / 100 
            if tweenTime < 0.5 then tweenTime = 0.5 end

            if currentTween then currentTween:Cancel() end
            
            local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
            currentTween = TweenService:Create(myRoot, tweenInfo, {CFrame = targetRoot.CFrame + Vector3.new(0, 2, 0)})
            currentTween:Play()
        end
    end
end)

CancelTweenBtn.MouseButton1Click:Connect(function()
    if currentTween then
        currentTween:Cancel()
        currentTween = nil
    end
end)

-- 5. Waypoint System Logic
local waypoints = {}

local function updateWaypointCanvas()
    local count = #WaypointScroll:GetChildren() - 2
    WaypointScroll.CanvasSize = UDim2.new(0, 0, 0, count * 38)
end

local function addWaypointUI(name, cframe)
    local ItemFrame = Instance.new("Frame")
    ItemFrame.Name = name
    ItemFrame.Parent = WaypointScroll
    ItemFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    ItemFrame.Size = UDim2.new(1, -10, 0, 32)

    local ItemCorner = Instance.new("UICorner")
    ItemCorner.CornerRadius = UDim.new(0, 5)
    ItemCorner.Parent = ItemFrame

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Parent = ItemFrame
    NameLabel.BackgroundTransparency = 1
    NameLabel.Position = UDim2.new(0, 8, 0, 0)
    NameLabel.Size = UDim2.new(0.5, -10, 1, 0)
    NameLabel.Font = Enum.Font.SourceSansBold
    NameLabel.Text = name
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.TextSize = 14
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.TextTruncate = Enum.TextTruncate.AtEnd

    local TPBtn = Instance.new("TextButton")
    TPBtn.Parent = ItemFrame
    TPBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    TPBtn.Position = UDim2.new(0.52, 0, 0.15, 0)
    TPBtn.Size = UDim2.new(0.28, 0, 0.7, 0)
    TPBtn.Font = Enum.Font.SourceSansBold
    TPBtn.Text = "วาร์ปไป"
    TPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TPBtn.TextSize = 12

    local TPBtnCorner = Instance.new("UICorner")
    TPBtnCorner.CornerRadius = UDim.new(0, 4)
    TPBtnCorner.Parent = TPBtn

    local DelBtn = Instance.new("TextButton")
    DelBtn.Parent = ItemFrame
    DelBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    DelBtn.Position = UDim2.new(0.82, 0, 0.15, 0)
    DelBtn.Size = UDim2.new(0.16, 0, 0.7, 0)
    DelBtn.Font = Enum.Font.SourceSansBold
    DelBtn.Text = "ลบ"
    DelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DelBtn.TextSize = 12

    local DelBtnCorner = Instance.new("UICorner")
    DelBtnCorner.CornerRadius = UDim.new(0, 4)
    DelBtnCorner.Parent = DelBtn

    TPBtn.MouseButton1Click:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = cframe + Vector3.new(0, 3, 0)
        end
    end)

    DelBtn.MouseButton1Click:Connect(function()
        waypoints[name] = nil
        ItemFrame:Destroy()
        updateWaypointCanvas()
    end)

    updateWaypointCanvas()
end

SaveButton.MouseButton1Click:Connect(function()
    local name = WaypointNameInput.Text
    if name == "" or name:match("^%s*$") then
        name = "จุดวาร์ป " .. tostring(#WaypointScroll:GetChildren() - 1)
    end

    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local currentCFrame = char.HumanoidRootPart.CFrame
        if waypoints[name] then
            local oldFrame = WaypointScroll:FindFirstChild(name)
            if oldFrame then 
                oldFrame:Destroy() 
            end
        end

        waypoints[name] = currentCFrame
        addWaypointUI(name, currentCFrame)
        WaypointNameInput.Text = ""
    end
end)

-- 6. Toggle Window (เปิด/ปิด GUI)
local isOpen = true
local function toggleWindow()
    isOpen = not isOpen
    if isOpen then
        MainFrame.Visible = true
        MainFrame:TweenSize(UDim2.new(0, 320, 0, 420), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.2, true)
    else
        MainFrame:TweenSize(UDim2.new(0, 320, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.2, true, function()
            if not isOpen then
                MainFrame.Visible = false
            end
        end)
    end
end

ToggleButton.MouseButton1Click:Connect(toggleWindow)
CloseButton.MouseButton1Click:Connect(toggleWindow)
