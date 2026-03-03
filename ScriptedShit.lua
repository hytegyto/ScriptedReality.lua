-- to be scripted by htegito --


































































































































































































































































































































































































































-- if ur a skid, fuck you. 
-- htegito





--[[
    @prometheus-config {
        "Virtualize": true,
        "EncryptStrings": true,
        "Compress": true,
        "AntiTamper": true
    }
]]

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- GLOBALS & DATA SAVING
-- ==========================================
_G.ROBUX_AMMOUNT = 14383822
_G.FAKE_NAME = "filteredasync"
_G.FAKE_ROLE = "TOP 22"
_G.ROLE_COLORBG = Color3.fromRGB(235, 235, 0)
_G.RAINBOW_ENABLED = false

local FILE_NAME = "MBH_Final_Data.json"

local Colors = {
    ["red"] = Color3.fromRGB(255, 50, 50),
    ["green"] = Color3.fromRGB(50, 255, 50),
    ["blue"] = Color3.fromRGB(0, 120, 255),
    ["pink"] = Color3.fromRGB(255, 100, 255),
    ["orange"] = Color3.fromRGB(255, 120, 0),
    ["gold"] = Color3.fromRGB(235, 235, 0),
    ["white"] = Color3.fromRGB(255, 255, 255),
    ["cyan"] = Color3.fromRGB(0, 255, 255)
}

local function SaveSettings()
    local data = {
        Robux = _G.ROBUX_AMMOUNT,
        Name = _G.FAKE_NAME,
        Role = _G.FAKE_ROLE,
        Color = {R = _G.ROLE_COLORBG.R, G = _G.ROLE_COLORBG.G, B = _G.ROLE_COLORBG.B},
        Rainbow = _G.RAINBOW_ENABLED
    }
    if writefile then writefile(FILE_NAME, HttpService:JSONEncode(data)) end
end

local function LoadSettings()
    if readfile and isfile and isfile(FILE_NAME) then
        pcall(function()
            local d = HttpService:JSONDecode(readfile(FILE_NAME))
            _G.ROBUX_AMMOUNT = d.Robux
            _G.FAKE_NAME = d.Name
            _G.FAKE_ROLE = d.Role
            _G.ROLE_COLORBG = Color3.new(d.Color.R, d.Color.G, d.Color.B)
            _G.RAINBOW_ENABLED = d.Rainbow
        end)
    end
end

-- ==========================================
-- REFRESH LOGIC
-- ==========================================
function _G.UpdateFakeDonation()
    local char = LocalPlayer.Character or workspace:FindFirstChild(LocalPlayer.Name)
    if char and char:FindFirstChild("Head") and char.Head:FindFirstChild("HeadTag") then
        local tag = char.Head.HeadTag
        if tag:FindFirstChild("Display") then tag.Display.Text = _G.FAKE_NAME end
        if tag:FindFirstChild("Role") then 
            tag.Role.Text = _G.FAKE_ROLE
            if not _G.RAINBOW_ENABLED then tag.Role.BackgroundColor3 = _G.ROLE_COLORBG end
        end
    end
    local p = LocalPlayer.PlayerGui:FindFirstChild("CustomBuyPrompt")
    if p and p:FindFirstChild("BalanceText", true) then
        p:FindFirstChild("BalanceText", true).Text = tostring(_G.ROBUX_AMMOUNT)
    end
end

-- Dragging Function
local function makeDraggable(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

-- ==========================================
-- UI CONSTRUCTION (PROFESSIONAL DARK)
-- ==========================================
LoadSettings() -- Load data before UI builds
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MBH_Ultimate_Pro"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 360, 0, 550)
Main.Position = UDim2.new(0.5, -180, 0.5, -275)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
makeDraggable(Main)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Header.Parent = Main
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Text = "MBH PREMIUM"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 40, 0, 40)
Close.Position = UDim2.new(1, -45, 0, 10)
Close.Text = "X"; Close.TextColor3 = Color3.new(1,0,0); Close.BackgroundTransparency = 1; Close.TextSize = 20; Close.Parent = Header
Close.MouseButton1Click:Connect(function() Main.Visible = false end)

-- Scrolling Container
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -40, 1, -80)
Container.Position = UDim2.new(0, 20, 0, 75)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 0
Container.Parent = Main
Instance.new("UIListLayout", Container).Padding = UDim.new(0, 12)

-- Helper: Big Professional Input
local function createInput(label, default)
    local lbl = Instance.new("TextLabel")
    lbl.Text = label:upper(); lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 12; lbl.TextColor3 = Color3.fromRGB(100, 100, 110); lbl.Size = UDim2.new(1,0,0,15); lbl.BackgroundTransparency = 1; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = Container
    
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, 0, 0, 45)
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    box.Text = tostring(default); box.TextColor3 = Color3.new(1, 1, 1); box.Font = Enum.Font.GothamMedium; box.TextSize = 18; box.Parent = Container
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
    return box
end

local robuxIn = createInput("Robux Balance", _G.ROBUX_AMMOUNT)
local nameIn = createInput("Fake Name", _G.FAKE_NAME)
local roleIn = createInput("Role Label", _G.FAKE_ROLE)
local colorIn = createInput("Color (Keyword or RGB)", "gold")

-- Preset Button Helper
local function addPreset(name, color, role, user)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 40); b.BackgroundColor3 = Color3.fromRGB(40, 40, 50); b.Text = "PRESET: "..name; b.TextColor3 = Color3.new(1,1,1); b.Font = Enum.Font.GothamBold; b.Parent = Container
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        _G.RAINBOW_ENABLED = false; _G.ROLE_COLORBG = color; _G.FAKE_ROLE = role; _G.FAKE_NAME = user; _G.UpdateFakeDonation(); SaveSettings()
        b.Text = "✓ LOADED"
        task.wait(0.5)
        b.Text = "PRESET: "..name
    end)
end

addPreset("HAZ3MN", Colors.orange, "Developer", "haz3mn")

-- Rainbow Toggle
local RainBtn = Instance.new("TextButton")
RainBtn.Size = UDim2.new(1, 0, 0, 45); RainBtn.BackgroundColor3 = Color3.fromRGB(75, 0, 130); RainBtn.Text = "RAINBOW ROLE: OFF"; RainBtn.TextColor3 = Color3.new(1,1,1); RainBtn.Font = Enum.Font.GothamBold; RainBtn.Parent = Container
Instance.new("UICorner", RainBtn)
RainBtn.MouseButton1Click:Connect(function()
    _G.RAINBOW_ENABLED = not _G.RAINBOW_ENABLED
    RainBtn.Text = _G.RAINBOW_ENABLED and "RAINBOW ROLE: ON" or "RAINBOW ROLE: OFF"
end)

-- Main Apply & Save
local Apply = Instance.new("TextButton")
Apply.Size = UDim2.new(1, 0, 0, 55); Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255); Apply.Text = "APPLY & SAVE SETTINGS"; Apply.TextColor3 = Color3.new(1, 1, 1); Apply.Font = Enum.Font.GothamBold; Apply.TextSize = 20; Apply.Parent = Container
Instance.new("UICorner", Apply)

-- Moveable Toggle
local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(0, 65, 0, 65); Toggle.Position = UDim2.new(0, 50, 0, 50); Toggle.BackgroundColor3 = Color3.fromRGB(0, 120, 255); Toggle.Text = "MBH"; Toggle.Font = Enum.Font.GothamBold; Toggle.TextColor3 = Color3.new(1,1,1); Toggle.Parent = ScreenGui
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1,0)
makeDraggable(Toggle)

-- ==========================================
-- SCRIPT LOGIC
-- ==========================================
Toggle.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

UIS.InputBegan:Connect(function(i, gpe)
    if not gpe and i.KeyCode == Enum.KeyCode.F5 then ScreenGui.Enabled = not ScreenGui.Enabled end
end)

Apply.MouseButton1Click:Connect(function()
    _G.ROBUX_AMMOUNT = tonumber(robuxIn.Text) or _G.ROBUX_AMMOUNT
    _G.FAKE_NAME = nameIn.Text
    _G.FAKE_ROLE = roleIn.Text
    local c = colorIn.Text:lower():gsub("%s+", "")
    if Colors[c] then _G.ROLE_COLORBG = Colors[c] else
        local r,g,b = c:match("(%d+),(%d+),(%d+)")
        if r then _G.ROLE_COLORBG = Color3.fromRGB(r,g,b) end
    end
    _G.UpdateFakeDonation()
    SaveSettings()
    Apply.Text = "✓ SAVED TO MEMORY"
    task.wait(1)
    Apply.Text = "APPLY & SAVE SETTINGS"
end)

RunService.RenderStepped:Connect(function()
    if _G.RAINBOW_ENABLED then
        local char = LocalPlayer.Character
        local role = char and char:FindFirstChild("Head") and char.Head:FindFirstChild("HeadTag") and char.Head.HeadTag:FindFirstChild("Role")
        if role then role.BackgroundColor3 = Color3.fromHSV(tick()%5/5, 1, 1) end
    end
end)

_G.UpdateFakeDonation()






local Players = game: GetService("Players")

local function enumValue(enumType,  value)
    for _,  item in ipairs(enumType: GetEnumItems()) do
        if item.Value == value then return item end
    end
    return enumType: GetEnumItems()[1]
end

local function trySet(obj,  prop,  value)
    pcall(function() obj[prop] = value end)
end

local function CreateCustomBuyPrompt(parent)
    parent = parent or Players.LocalPlayer: WaitForChild("PlayerGui")
    local existing = parent: FindFirstChild("CustomBuyPrompt")
    if existing then existing: Destroy() end

    -- =========================
    -- TUNING (easy edits)
    -- =========================
	local ROBUX_AMMOUNT = 14383822
    local ROBUX_ICON = "rbxassetid: //135557279290308"
    local OVERLAY_TARGET_TRANSPARENCY = 0.21
	local FAKE_NAME = "filteredasync"
    -- Reduced scale factor (was 1.33)
    local SCALE = 1 -- No scaling (original size)

    -- Panel sizing adjustments
    local PANEL_WIDTH = 367  -- Reduced from 441
    local PANEL_HEIGHT = 177 -- Reduced from 238

    -- Text size adjustments
    local TITLE_TEXT_SIZE = 22  -- Reduced from 27
    local NAME_TEXT_SIZE = 16   -- Reduced from 19
    local PRICE_TEXT_SIZE = 16  -- Reduced from 19
    local BUTTON_TEXT_SIZE = 15 -- Reduced from 18

    -- Corner radius adjustments
    local CORNER_RADIUS = 14    -- Reduced from 15
    local BUTTON_CORNER_RADIUS = 8 -- Reduced from 8

    local CustomBuyPrompt = Instance.new("ScreenGui")
    CustomBuyPrompt.Name = "CustomBuyPrompt"
    trySet(CustomBuyPrompt,  "ClipToDeviceSafeArea",  true)
    trySet(CustomBuyPrompt,  "DisplayOrder",  0)
    trySet(CustomBuyPrompt,  "SafeAreaCompatibility",  enumValue(Enum.SafeAreaCompatibility,  1))
    trySet(CustomBuyPrompt,  "ScreenInsets",  enumValue(Enum.ScreenInsets,  1))
    trySet(CustomBuyPrompt,  "Enabled",  true)
    trySet(CustomBuyPrompt,  "ResetOnSpawn",  true)
    trySet(CustomBuyPrompt,  "ZIndexBehavior",  enumValue(Enum.ZIndexBehavior,  1))
    trySet(CustomBuyPrompt,  "AutoLocalize",  true)
    trySet(CustomBuyPrompt,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(CustomBuyPrompt,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(CustomBuyPrompt,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(CustomBuyPrompt,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(CustomBuyPrompt,  "SelectionGroup",  false)
    trySet(CustomBuyPrompt,  "DefinesCapabilities",  false)

    local Overlay = Instance.new("Frame")
    Overlay.Name = "Overlay"
    trySet(Overlay,  "Style",  enumValue(Enum.ButtonStyle,  0))
    trySet(Overlay,  "Active",  false)
    trySet(Overlay,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(Overlay,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(Overlay,  "BackgroundColor3",  Color3.new(0,  0,  0))
    trySet(Overlay,  "BackgroundTransparency",  0.5)
    trySet(Overlay,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(Overlay,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(Overlay,  "BorderSizePixel",  0)
    trySet(Overlay,  "ClipsDescendants",  false)
    trySet(Overlay,  "Draggable",  false)
    trySet(Overlay,  "Interactable",  true)
    trySet(Overlay,  "LayoutOrder",  0)
    trySet(Overlay,  "Position",  UDim2.new(-0.0071344059,  0,  0.0,  0))
    trySet(Overlay,  "Rotation",  0)
    trySet(Overlay,  "Selectable",  false)
    trySet(Overlay,  "SelectionOrder",  0)
    trySet(Overlay,  "Size",  UDim2.new(1.00713444,  0,  1,  0))
    trySet(Overlay,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(Overlay,  "Visible",  false)
    trySet(Overlay,  "ZIndex",  1)
    trySet(Overlay,  "AutoLocalize",  true)
    trySet(Overlay,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Overlay,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Overlay,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Overlay,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Overlay,  "SelectionGroup",  false)
    trySet(Overlay,  "DefinesCapabilities",  false)

    local Panel = Instance.new("Frame")
    Panel.Name = "Panel"
    trySet(Panel,  "Style",  enumValue(Enum.ButtonStyle,  0))
    trySet(Panel,  "Active",  true)
    trySet(Panel,  "AnchorPoint",  Vector2.new(0.5,  0.5))
    trySet(Panel,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(Panel,  "BackgroundColor3",  Color3.new(0.0980392173,  0.101960786,  0.121568628))
    trySet(Panel,  "BackgroundTransparency",  0)
    trySet(Panel,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(Panel,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(Panel,  "BorderSizePixel",  0)
    trySet(Panel,  "ClipsDescendants",  false)
    trySet(Panel,  "Draggable",  false)
    trySet(Panel,  "Interactable",  true)
    trySet(Panel,  "LayoutOrder",  0)
    trySet(Panel,  "Position",  UDim2.new(0.355243758,  0,  0.499986827,  0))
    trySet(Panel,  "Rotation",  0)
    trySet(Panel,  "Selectable",  false)
    trySet(Panel,  "SelectionOrder",  0)
    trySet(Panel,  "Size",  UDim2.new(0.0,  PANEL_WIDTH,  0.0,  PANEL_HEIGHT)) -- Modified
    trySet(Panel,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(Panel,  "Visible",  false)
    trySet(Panel,  "ZIndex",  1)
    trySet(Panel,  "AutoLocalize",  true)
    trySet(Panel,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Panel,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Panel,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Panel,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Panel,  "SelectionGroup",  false)
    trySet(Panel,  "DefinesCapabilities",  false)

    local UICorner = Instance.new("UICorner")
    UICorner.Name = "UICorner"
    trySet(UICorner,  "CornerRadius",  UDim.new(0.0,  CORNER_RADIUS)) -- Modified
    trySet(UICorner,  "DefinesCapabilities",  false)

    local BuyItem = Instance.new("TextLabel")
    BuyItem.Name = "BuyItem"
    trySet(BuyItem,  "FontFace",  Font.new("",  enumValue(Enum.FontWeight,  700),  Enum.FontStyle.Normal))
    trySet(BuyItem,  "LineHeight",  1)
    trySet(BuyItem,  "LocalizationMatchIdentifier",  "")
    trySet(BuyItem,  "LocalizationMatchedSourceText",  "")
    trySet(BuyItem,  "MaxVisibleGraphemes",  -1)
    trySet(BuyItem,  "OpenTypeFeatures",  "")
    trySet(BuyItem,  "RichText",  false)
    trySet(BuyItem,  "Text",  "Buy Item")
    trySet(BuyItem,  "TextColor3",  Color3.new(0.898039281,  0.898039281,  0.898039281))
    trySet(BuyItem,  "TextDirection",  enumValue(Enum.TextDirection,  0))
    trySet(BuyItem,  "TextScaled",  false)
    trySet(BuyItem,  "TextSize",  TITLE_TEXT_SIZE) -- Modified
    trySet(BuyItem,  "TextStrokeColor3",  Color3.new(124,  126,  128))
    trySet(BuyItem,  "TextStrokeTransparency",  1)
    trySet(BuyItem,  "TextTransparency",  0)
    trySet(BuyItem,  "TextTruncate",  enumValue(Enum.TextTruncate,  0))
    trySet(BuyItem,  "TextWrapped",  false)
    trySet(BuyItem,  "TextXAlignment",  enumValue(Enum.TextXAlignment,  2))
    trySet(BuyItem,  "TextYAlignment",  enumValue(Enum.TextYAlignment,  1))
    trySet(BuyItem,  "Active",  false)
    trySet(BuyItem,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(BuyItem,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(BuyItem,  "BackgroundColor3",  Color3.new(0.572549045,  0.580392182,  0.600000024))
    trySet(BuyItem,  "BackgroundTransparency",  1)
    trySet(BuyItem,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(BuyItem,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(BuyItem,  "BorderSizePixel",  0)
    trySet(BuyItem,  "ClipsDescendants",  false)
    trySet(BuyItem,  "Draggable",  false)
    trySet(BuyItem,  "Interactable",  true)
    trySet(BuyItem,  "LayoutOrder",  0)
    trySet(BuyItem,  "Position",  UDim2.new(-0.035774354,  0,  -0.233769909,  0))
    trySet(BuyItem,  "Rotation",  0)
    trySet(BuyItem,  "Selectable",  false)
    trySet(BuyItem,  "SelectionOrder",  0)
    trySet(BuyItem,  "Size",  UDim2.new(0.0,  140,  0.0,  125))
    trySet(BuyItem,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(BuyItem,  "Visible",  true)
    trySet(BuyItem,  "ZIndex",  1)
    trySet(BuyItem,  "AutoLocalize",  true)
    trySet(BuyItem,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyItem,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyItem,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyItem,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyItem,  "SelectionGroup",  false)
    trySet(BuyItem,  "DefinesCapabilities",  false)

    local ItemImage = Instance.new("ImageLabel")
    ItemImage.Name = "ItemImage"
    trySet(ItemImage,  "Image",  "")
    trySet(ItemImage,  "ImageColor3",  Color3.new(1,  1,  1))
    trySet(ItemImage,  "ImageRectOffset",  Vector2.new(0,  0))
    trySet(ItemImage,  "ImageRectSize",  Vector2.new(0,  0))
    trySet(ItemImage,  "ImageTransparency",  0)
    trySet(ItemImage,  "ResampleMode",  enumValue(Enum.ResamplerMode,  0))
    trySet(ItemImage,  "ScaleType",  enumValue(Enum.ScaleType,  0))
    trySet(ItemImage,  "SliceScale",  1)
    trySet(ItemImage,  "TileSize",  UDim2.new(1.0,  0,  1.0,  0))
    trySet(ItemImage,  "Active",  false)
    trySet(ItemImage,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(ItemImage,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(ItemImage,  "BackgroundColor3",  Color3.new(1,  1,  1))
    trySet(ItemImage,  "BackgroundTransparency",  1)
    trySet(ItemImage,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(ItemImage,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(ItemImage,  "BorderSizePixel",  0)
    trySet(ItemImage,  "ClipsDescendants",  false)
    trySet(ItemImage,  "Draggable",  false)
    trySet(ItemImage,  "Interactable",  true)
    trySet(ItemImage,  "LayoutOrder",  0)
    trySet(ItemImage,  "Position",  UDim2.new(0.0534521155,  0,  0.24433616,  0))
    trySet(ItemImage,  "Rotation",  0)
    trySet(ItemImage,  "Selectable",  false)
    trySet(ItemImage,  "SelectionOrder",  0)
    trySet(ItemImage,  "Size",  UDim2.new(0.0,  58,  0.0,  57))
    trySet(ItemImage,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(ItemImage,  "Visible",  true)
    trySet(ItemImage,  "ZIndex",  1)
    trySet(ItemImage,  "AutoLocalize",  true)
    trySet(ItemImage,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(ItemImage,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(ItemImage,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(ItemImage,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(ItemImage,  "SelectionGroup",  false)
    trySet(ItemImage,  "DefinesCapabilities",  false)

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Name = "UIStroke"
    trySet(UIStroke,  "ApplyStrokeMode",  enumValue(Enum.ApplyStrokeMode,  0))
    trySet(UIStroke,  "BorderOffset",  UDim.new(0.0,  0))
    trySet(UIStroke,  "BorderStrokePosition",  enumValue(Enum.BorderStrokePosition,  0))
    trySet(UIStroke,  "Color",  Color3.new(1,  1,  1))
    trySet(UIStroke,  "Enabled",  true)
    trySet(UIStroke,  "LineJoinMode",  enumValue(Enum.LineJoinMode,  0))
    trySet(UIStroke,  "StrokeSizingMode",  enumValue(Enum.StrokeSizingMode,  0))
    trySet(UIStroke,  "Thickness",  1)
    trySet(UIStroke,  "Transparency",  0.849999998)
    trySet(UIStroke,  "ZIndex",  1)
    trySet(UIStroke,  "DefinesCapabilities",  false)

    local ItemNameText = Instance.new("TextLabel")
    ItemNameText.Name = "ItemNameText"
    trySet(ItemNameText,  "FontFace",  Font.new("",  enumValue(Enum.FontWeight,  600),  Enum.FontStyle.Normal))
    trySet(ItemNameText,  "LineHeight",  1)
    trySet(ItemNameText,  "LocalizationMatchIdentifier",  "")
    trySet(ItemNameText,  "LocalizationMatchedSourceText",  "")
    trySet(ItemNameText,  "MaxVisibleGraphemes",  -1)
    trySet(ItemNameText,  "OpenTypeFeatures",  "")
    trySet(ItemNameText,  "RichText",  false)
    trySet(ItemNameText,  "Text",  "hi")
    trySet(ItemNameText,  "TextColor3",  Color3.new(1,  1,  1))
    trySet(ItemNameText,  "TextDirection",  enumValue(Enum.TextDirection,  0))
    trySet(ItemNameText,  "TextScaled",  false)
    trySet(ItemNameText,  "TextSize",  NAME_TEXT_SIZE) -- Modified
    trySet(ItemNameText,  "TextStrokeColor3",  Color3.new(0,  0,  0))
    trySet(ItemNameText,  "TextStrokeTransparency",  1)
    trySet(ItemNameText,  "TextTransparency",  0)
    trySet(ItemNameText,  "TextTruncate",  enumValue(Enum.TextTruncate,  1))
    trySet(ItemNameText,  "TextWrapped",  false)
    trySet(ItemNameText,  "TextXAlignment",  enumValue(Enum.TextXAlignment,  0))
    trySet(ItemNameText,  "TextYAlignment",  enumValue(Enum.TextYAlignment,  1))
    trySet(ItemNameText,  "Active",  false)
    trySet(ItemNameText,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(ItemNameText,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(ItemNameText,  "BackgroundColor3",  Color3.new(1,  1,  1))
    trySet(ItemNameText,  "BackgroundTransparency",  1)
    trySet(ItemNameText,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(ItemNameText,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(ItemNameText,  "BorderSizePixel",  0)
    trySet(ItemNameText,  "ClipsDescendants",  false)
    trySet(ItemNameText,  "Draggable",  false)
    trySet(ItemNameText,  "Interactable",  true)
    trySet(ItemNameText,  "LayoutOrder",  0)
    trySet(ItemNameText,  "Position",  UDim2.new(0.243337899,  0,  0.24500006,  0))
    trySet(ItemNameText,  "Rotation",  0)
    trySet(ItemNameText,  "Selectable",  false)
    trySet(ItemNameText,  "SelectionOrder",  0)
    trySet(ItemNameText,  "Size",  UDim2.new(0.0,  220,  0.0,  32)) -- Modified
    trySet(ItemNameText,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(ItemNameText,  "Visible",  true)
    trySet(ItemNameText,  "ZIndex",  1)
    trySet(ItemNameText,  "AutoLocalize",  true)
    trySet(ItemNameText,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(ItemNameText,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(ItemNameText,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(ItemNameText,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(ItemNameText,  "SelectionGroup",  false)
    trySet(ItemNameText,  "DefinesCapabilities",  false)

    local PriceIcon = Instance.new("ImageLabel")
    PriceIcon.Name = "PriceIcon"
    trySet(PriceIcon,  "Image",  "")
    trySet(PriceIcon,  "ImageColor3",  Color3.new(1,  1,  1))
    trySet(PriceIcon,  "ImageRectOffset",  Vector2.new(0,  0))
    trySet(PriceIcon,  "ImageRectSize",  Vector2.new(0,  0))
    trySet(PriceIcon,  "ImageTransparency",  0)
    trySet(PriceIcon,  "ResampleMode",  enumValue(Enum.ResamplerMode,  0))
    trySet(PriceIcon,  "ScaleType",  enumValue(Enum.ScaleType,  0))
    trySet(PriceIcon,  "SliceScale",  1)
    trySet(PriceIcon,  "TileSize",  UDim2.new(1.0,  0,  1.0,  0))
    trySet(PriceIcon,  "Active",  false)
    trySet(PriceIcon,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(PriceIcon,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(PriceIcon,  "BackgroundColor3",  Color3.new(1,  1,  1))
    trySet(PriceIcon,  "BackgroundTransparency",  0.980000019)
    trySet(PriceIcon,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(PriceIcon,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(PriceIcon,  "BorderSizePixel",  0)
    trySet(PriceIcon,  "ClipsDescendants",  false)
    trySet(PriceIcon,  "Draggable",  false)
    trySet(PriceIcon,  "Interactable",  true)
    trySet(PriceIcon,  "LayoutOrder",  0)
    trySet(PriceIcon,  "Position",  UDim2.new(0.246401548,  0,  0.440000034,  0))
    trySet(PriceIcon,  "Rotation",  0)
    trySet(PriceIcon,  "Selectable",  false)
    trySet(PriceIcon,  "SelectionOrder",  0)
    trySet(PriceIcon,  "Size",  UDim2.new(0.0,  12,  0.0,  12))
    trySet(PriceIcon,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(PriceIcon,  "Visible",  true)
    trySet(PriceIcon,  "ZIndex",  25)
    trySet(PriceIcon,  "AutoLocalize",  true)
    trySet(PriceIcon,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(PriceIcon,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(PriceIcon,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(PriceIcon,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(PriceIcon,  "SelectionGroup",  false)
    trySet(PriceIcon,  "DefinesCapabilities",  false)

    local PriceText = Instance.new("TextLabel")
    PriceText.Name = "PriceText"
    trySet(PriceText,  "FontFace",  Font.new("",  enumValue(Enum.FontWeight,  600),  Enum.FontStyle.Normal))
    trySet(PriceText,  "LineHeight",  1)
    trySet(PriceText,  "LocalizationMatchIdentifier",  "")
    trySet(PriceText,  "LocalizationMatchedSourceText",  "")
    trySet(PriceText,  "MaxVisibleGraphemes",  -1)
    trySet(PriceText,  "OpenTypeFeatures",  "")
    trySet(PriceText,  "RichText",  false)
    trySet(PriceText,  "Text",  "1")
    trySet(PriceText,  "TextColor3",  Color3.new(1,  1,  1))
    trySet(PriceText,  "TextDirection",  enumValue(Enum.TextDirection,  0))
    trySet(PriceText,  "TextScaled",  false)
    trySet(PriceText,  "TextSize",  PRICE_TEXT_SIZE) -- Modified
    trySet(PriceText,  "TextStrokeColor3",  Color3.new(0,  0,  0))
    trySet(PriceText,  "TextStrokeTransparency",  1)
    trySet(PriceText,  "TextTransparency",  0)
    trySet(PriceText,  "TextTruncate",  enumValue(Enum.TextTruncate,  0))
    trySet(PriceText,  "TextWrapped",  false)
    trySet(PriceText,  "TextXAlignment",  enumValue(Enum.TextXAlignment,  0))
    trySet(PriceText,  "TextYAlignment",  enumValue(Enum.TextYAlignment,  1))
    trySet(PriceText,  "Active",  false)
    trySet(PriceText,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(PriceText,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  1))
    trySet(PriceText,  "BackgroundColor3",  Color3.new(1,  1,  1))
    trySet(PriceText,  "BackgroundTransparency",  1)
    trySet(PriceText,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(PriceText,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(PriceText,  "BorderSizePixel",  0)
    trySet(PriceText,  "ClipsDescendants",  false)
    trySet(PriceText,  "Draggable",  false)
    trySet(PriceText,  "Interactable",  true)
    trySet(PriceText,  "LayoutOrder",  0)
    trySet(PriceText,  "Position",  UDim2.new(0.289872983,  0,  0.399000062,  0))
    trySet(PriceText,  "Rotation",  0)
    trySet(PriceText,  "Selectable",  false)
    trySet(PriceText,  "SelectionOrder",  0)
    trySet(PriceText,  "Size",  UDim2.new(0.0,  220,  0.0,  26))
    trySet(PriceText,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(PriceText,  "Visible",  true)
    trySet(PriceText,  "ZIndex",  1)
    trySet(PriceText,  "AutoLocalize",  true)
    trySet(PriceText,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(PriceText,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(PriceText,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(PriceText,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(PriceText,  "SelectionGroup",  false)
    trySet(PriceText,  "DefinesCapabilities",  false)

    local BuyWrap = Instance.new("Frame")
    BuyWrap.Name = "BuyWrap"
    trySet(BuyWrap,  "Style",  enumValue(Enum.ButtonStyle,  0))
    trySet(BuyWrap,  "Active",  false)
    trySet(BuyWrap,  "AnchorPoint",  Vector2.new(0.5,  1))
    trySet(BuyWrap,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(BuyWrap,  "BackgroundColor3",  Color3.new(0.172549024,  0.270588249,  0.807843149))
    trySet(BuyWrap,  "BackgroundTransparency",  0)
    trySet(BuyWrap,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(BuyWrap,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(BuyWrap,  "BorderSizePixel",  0)
    trySet(BuyWrap,  "ClipsDescendants",  false)
    trySet(BuyWrap,  "Draggable",  false)
    trySet(BuyWrap,  "Interactable",  true)
    trySet(BuyWrap,  "LayoutOrder",  0)
    trySet(BuyWrap,  "Position",  UDim2.new(0.5,  0,  1.03769912,  -22))
    trySet(BuyWrap,  "Rotation",  0)
    trySet(BuyWrap,  "Selectable",  false)
    trySet(BuyWrap,  "SelectionOrder",  0)
    trySet(BuyWrap,  "Size",  UDim2.new(1.0,  -40,  -0.0309734512,  40))
    trySet(BuyWrap,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(BuyWrap,  "Visible",  true)
    trySet(BuyWrap,  "ZIndex",  1)
    trySet(BuyWrap,  "AutoLocalize",  true)
    trySet(BuyWrap,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyWrap,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyWrap,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyWrap,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyWrap,  "SelectionGroup",  false)
    trySet(BuyWrap,  "DefinesCapabilities",  false)

    local UICorner2 = Instance.new("UICorner")
    UICorner2.Name = "UICorner"
    trySet(UICorner2,  "CornerRadius",  UDim.new(0.0,  BUTTON_CORNER_RADIUS)) -- Modified
    trySet(UICorner2,  "DefinesCapabilities",  false)

    local Fill = Instance.new("Frame")
    Fill.Name = "Fill"
    trySet(Fill,  "Style",  enumValue(Enum.ButtonStyle,  0))
    trySet(Fill,  "Active",  false)
    trySet(Fill,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(Fill,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(Fill,  "BackgroundColor3",  Color3.new(0.203921571,  0.360784322,  1))
    trySet(Fill,  "BackgroundTransparency",  0)
    trySet(Fill,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(Fill,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(Fill,  "BorderSizePixel",  0)
    trySet(Fill,  "ClipsDescendants",  false)
    trySet(Fill,  "Draggable",  false)
    trySet(Fill,  "Interactable",  true)
    trySet(Fill,  "LayoutOrder",  0)
    trySet(Fill,  "Position",  UDim2.new(-0.00977995154,  0,  0.0,  0))
    trySet(Fill,  "Rotation",  0)
    trySet(Fill,  "Selectable",  false)
    trySet(Fill,  "SelectionOrder",  0)
    trySet(Fill,  "Size",  UDim2.new(0.0,  411,  0.0,  38))
    trySet(Fill,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(Fill,  "Visible",  true)
    trySet(Fill,  "ZIndex",  1)
    trySet(Fill,  "AutoLocalize",  true)
    trySet(Fill,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Fill,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Fill,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Fill,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Fill,  "SelectionGroup",  false)
    trySet(Fill,  "DefinesCapabilities",  false)

    local UICorner3 = Instance.new("UICorner")
    UICorner3.Name = "UICorner"
    trySet(UICorner3,  "CornerRadius",  UDim.new(0.0,  BUTTON_CORNER_RADIUS)) -- Modified
    trySet(UICorner3,  "DefinesCapabilities",  false)

    local BuyButton = Instance.new("TextButton")
    BuyButton.Name = "BuyButton"
    trySet(BuyButton,  "FontFace",  Font.new("",  enumValue(Enum.FontWeight,  700),  Enum.FontStyle.Normal))
    trySet(BuyButton,  "LineHeight",  1)
    trySet(BuyButton,  "LocalizationMatchIdentifier",  "")
    trySet(BuyButton,  "LocalizationMatchedSourceText",  "")
    trySet(BuyButton,  "MaxVisibleGraphemes",  -1)
    trySet(BuyButton,  "OpenTypeFeatures",  "")
    trySet(BuyButton,  "RichText",  false)
    trySet(BuyButton,  "Text",  "Buy")
    trySet(BuyButton,  "TextColor3",  Color3.new(1,  1,  1))
    trySet(BuyButton,  "TextDirection",  enumValue(Enum.TextDirection,  0))
    trySet(BuyButton,  "TextScaled",  false)
    trySet(BuyButton,  "TextSize",  BUTTON_TEXT_SIZE) -- Modified
    trySet(BuyButton,  "TextStrokeColor3",  Color3.new(0,  0,  0))
    trySet(BuyButton,  "TextStrokeTransparency",  1)
    trySet(BuyButton,  "TextTransparency",  0)
    trySet(BuyButton,  "TextTruncate",  enumValue(Enum.TextTruncate,  0))
    trySet(BuyButton,  "TextWrapped",  false)
    trySet(BuyButton,  "TextXAlignment",  enumValue(Enum.TextXAlignment,  2))
    trySet(BuyButton,  "TextYAlignment",  enumValue(Enum.TextYAlignment,  1))
    trySet(BuyButton,  "AutoButtonColor",  false)
    trySet(BuyButton,  "Modal",  false)
    trySet(BuyButton,  "Selected",  false)
    trySet(BuyButton,  "Style",  enumValue(Enum.ButtonStyle,  0))
    trySet(BuyButton,  "Active",  true)
    trySet(BuyButton,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(BuyButton,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(BuyButton,  "BackgroundColor3",  Color3.new(1,  1,  1))
    trySet(BuyButton,  "BackgroundTransparency",  1)
    trySet(BuyButton,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(BuyButton,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(BuyButton,  "BorderSizePixel",  0)
    trySet(BuyButton,  "ClipsDescendants",  false)
    trySet(BuyButton,  "Draggable",  false)
    trySet(BuyButton,  "Interactable",  true)
    trySet(BuyButton,  "LayoutOrder",  0)
    trySet(BuyButton,  "Position",  UDim2.new(0.203999978,  0,  -0.222564043,  0))
    trySet(BuyButton,  "Rotation",  0)
    trySet(BuyButton,  "Selectable",  true)
    trySet(BuyButton,  "SelectionOrder",  0)
    trySet(BuyButton,  "Size",  UDim2.new(0.0,  200,  0.0,  50))
    trySet(BuyButton,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(BuyButton,  "Visible",  true)
    trySet(BuyButton,  "ZIndex",  1)
    trySet(BuyButton,  "AutoLocalize",  true)
    trySet(BuyButton,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyButton,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyButton,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyButton,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyButton,  "SelectionGroup",  false)
    trySet(BuyButton,  "DefinesCapabilities",  false)

    local Close = Instance.new("TextButton")
    Close.Name = "Close"
    trySet(Close,  "FontFace",  Font.new("",  enumValue(Enum.FontWeight,  650),  Enum.FontStyle.Normal))
    trySet(Close,  "LineHeight",  1)
    trySet(Close,  "LocalizationMatchIdentifier",  "")
    trySet(Close,  "LocalizationMatchedSourceText",  "")
    trySet(Close,  "MaxVisibleGraphemes",  -1)
    trySet(Close,  "OpenTypeFeatures",  "")
    trySet(Close,  "RichText",  false)
    trySet(Close,  "Text",  "X")
    trySet(Close,  "TextColor3",  Color3.new(0.854902029,  0.858823597,  0.874509871))
    trySet(Close,  "TextDirection",  enumValue(Enum.TextDirection,  0))
    trySet(Close,  "TextScaled",  false)
    trySet(Close,  "TextSize",  56)
    trySet(Close,  "TextStrokeColor3",  Color3.new(0,  0,  0))
    trySet(Close,  "TextStrokeTransparency",  1)
    trySet(Close,  "TextTransparency",  0)
    trySet(Close,  "TextTruncate",  enumValue(Enum.TextTruncate,  0))
    trySet(Close,  "TextWrapped",  false)
    trySet(Close,  "TextXAlignment",  enumValue(Enum.TextXAlignment,  2))
    trySet(Close,  "TextYAlignment",  enumValue(Enum.TextYAlignment,  1))
    trySet(Close,  "AutoButtonColor",  false)
    trySet(Close,  "Modal",  false)
    trySet(Close,  "Selected",  false)
    trySet(Close,  "Style",  enumValue(Enum.ButtonStyle,  0))
    trySet(Close,  "Active",  true)
    trySet(Close,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(Close,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(Close,  "BackgroundColor3",  Color3.new(0.176470593,  0.176470593,  0.203921571))
    trySet(Close,  "BackgroundTransparency",  1)
    trySet(Close,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(Close,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(Close,  "BorderSizePixel",  0)
    trySet(Close,  "ClipsDescendants",  false)
    trySet(Close,  "Draggable",  false)
    trySet(Close,  "Interactable",  true)
    trySet(Close,  "LayoutOrder",  0)
    trySet(Close,  "Position",  UDim2.new(0.909000018,  0,  0.075000003,  0))
    trySet(Close,  "Rotation",  0)
    trySet(Close,  "Selectable",  true)
    trySet(Close,  "SelectionOrder",  0)
    trySet(Close,  "Size",  UDim2.new(0.0,  18,  0.0,  18))
    trySet(Close,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(Close,  "Visible",  true)
    trySet(Close,  "ZIndex",  1)
    trySet(Close,  "AutoLocalize",  true)
    trySet(Close,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Close,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Close,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Close,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Close,  "SelectionGroup",  false)
    trySet(Close,  "DefinesCapabilities",  false)

    local UICorner4 = Instance.new("UICorner")
    UICorner4.Name = "UICorner"
    trySet(UICorner4,  "CornerRadius",  UDim.new(0.0,  9))
    trySet(UICorner4,  "DefinesCapabilities",  false)

    local BalanceRow = Instance.new("Frame")
    BalanceRow.Name = "BalanceRow"
    trySet(BalanceRow,  "Style",  enumValue(Enum.ButtonStyle,  0))
    trySet(BalanceRow,  "Active",  false)
    trySet(BalanceRow,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(BalanceRow,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(BalanceRow,  "BackgroundColor3",  Color3.new(1,  1,  1))
    trySet(BalanceRow,  "BackgroundTransparency",  1)
    trySet(BalanceRow,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(BalanceRow,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(BalanceRow,  "BorderSizePixel",  0)
    trySet(BalanceRow,  "ClipsDescendants",  false)
    trySet(BalanceRow,  "Draggable",  false)
    trySet(BalanceRow,  "Interactable",  true)
    trySet(BalanceRow,  "LayoutOrder",  0)
    trySet(BalanceRow,  "Position",  UDim2.new(0.729827702,  0,  0.687999921,  0))
    trySet(BalanceRow,  "Rotation",  0)
    trySet(BalanceRow,  "Selectable",  false)
    trySet(BalanceRow,  "SelectionOrder",  0)
    trySet(BalanceRow,  "Size",  UDim2.new(0.0,  49,  0.0,  -200))
    trySet(BalanceRow,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(BalanceRow,  "Visible",  true)
    trySet(BalanceRow,  "ZIndex",  1)
    trySet(BalanceRow,  "AutoLocalize",  true)
    trySet(BalanceRow,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BalanceRow,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BalanceRow,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BalanceRow,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BalanceRow,  "SelectionGroup",  false)
    trySet(BalanceRow,  "DefinesCapabilities",  false)

    local BalanceIcon = Instance.new("ImageLabel")
    BalanceIcon.Name = "BalanceIcon"
    trySet(BalanceIcon,  "Image",  "")
    trySet(BalanceIcon,  "ImageColor3",  Color3.new(1,  1,  1))
    trySet(BalanceIcon,  "ImageRectOffset",  Vector2.new(0,  0))
    trySet(BalanceIcon,  "ImageRectSize",  Vector2.new(0,  0))
    trySet(BalanceIcon,  "ImageTransparency",  0)
    trySet(BalanceIcon,  "ResampleMode",  enumValue(Enum.ResamplerMode,  0))
    trySet(BalanceIcon,  "ScaleType",  enumValue(Enum.ScaleType,  0))
    trySet(BalanceIcon,  "SliceScale",  1)
    trySet(BalanceIcon,  "TileSize",  UDim2.new(1.0,  0,  1.0,  0))
    trySet(BalanceIcon,  "Active",  false)
    trySet(BalanceIcon,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(BalanceIcon,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(BalanceIcon,  "BackgroundColor3",  Color3.new(1,  1,  1))
    trySet(BalanceIcon,  "BackgroundTransparency",  1)
    trySet(BalanceIcon,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(BalanceIcon,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(BalanceIcon,  "BorderSizePixel",  0)
    trySet(BalanceIcon,  "ClipsDescendants",  false)
    trySet(BalanceIcon,  "Draggable",  false)
    trySet(BalanceIcon,  "Interactable",  true)
    trySet(BalanceIcon,  "LayoutOrder",  0)
    trySet(BalanceIcon,  "Position",  UDim2.new(0.907238328,  0,  0.123893805,  0))
    trySet(BalanceIcon,  "Rotation",  0)
    trySet(BalanceIcon,  "Selectable",  false)
    trySet(BalanceIcon,  "SelectionOrder",  0)
    trySet(BalanceIcon,  "Size",  UDim2.new(0.0,  12,  0.0,  12))
    trySet(BalanceIcon,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(BalanceIcon,  "Visible",  true)
    trySet(BalanceIcon,  "ZIndex",  1)
    trySet(BalanceIcon,  "AutoLocalize",  true)
    trySet(BalanceIcon,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BalanceIcon,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BalanceIcon,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BalanceIcon,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BalanceIcon,  "SelectionGroup",  false)
    trySet(BalanceIcon,  "DefinesCapabilities",  false)

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Name = "UIListLayout"
    trySet(UIListLayout,  "HorizontalFlex",  enumValue(Enum.UIFlexAlignment,  0))
    trySet(UIListLayout,  "ItemLineAlignment",  enumValue(Enum.ItemLineAlignment,  0))
    trySet(UIListLayout,  "Padding",  UDim.new(0.0,  -18))
    trySet(UIListLayout,  "VerticalFlex",  enumValue(Enum.UIFlexAlignment,  0))
    trySet(UIListLayout,  "Wraps",  false)
    trySet(UIListLayout,  "FillDirection",  enumValue(Enum.FillDirection,  0))
    trySet(UIListLayout,  "HorizontalAlignment",  enumValue(Enum.HorizontalAlignment,  1))
    trySet(UIListLayout,  "SortOrder",  enumValue(Enum.SortOrder,  2))
    trySet(UIListLayout,  "VerticalAlignment",  enumValue(Enum.VerticalAlignment,  0))
    trySet(UIListLayout,  "DefinesCapabilities",  false)

    local BalanceText = Instance.new("TextLabel")
    BalanceText.Name = "BalanceText"
    trySet(BalanceText,  "FontFace",  Font.new("",  enumValue(Enum.FontWeight,  600),  Enum.FontStyle.Normal))
    trySet(BalanceText,  "LineHeight",  1)
    trySet(BalanceText,  "LocalizationMatchIdentifier",  "")
    trySet(BalanceText,  "LocalizationMatchedSourceText",  "")
    trySet(BalanceText,  "MaxVisibleGraphemes",  -1)
    trySet(BalanceText,  "OpenTypeFeatures",  "")
    trySet(BalanceText,  "RichText",  false)
    trySet(BalanceText,  "Text",  ROBUX_AMMOUNT)
    trySet(BalanceText,  "TextColor3",  Color3.new(0.905882418,  0.909803987,  0.921568692))
    trySet(BalanceText,  "TextDirection",  enumValue(Enum.TextDirection,  0))
    trySet(BalanceText,  "TextScaled",  false)
    trySet(BalanceText,  "TextSize",  15.6)
    trySet(BalanceText,  "TextStrokeColor3",  Color3.new(0,  0,  0))
    trySet(BalanceText,  "TextStrokeTransparency",  1)
    trySet(BalanceText,  "TextTransparency",  0)
    trySet(BalanceText,  "TextTruncate",  enumValue(Enum.TextTruncate,  0))
    trySet(BalanceText,  "TextWrapped",  false)
    trySet(BalanceText,  "TextXAlignment",  enumValue(Enum.TextXAlignment,  2))
    trySet(BalanceText,  "TextYAlignment",  enumValue(Enum.TextYAlignment,  1))
    trySet(BalanceText,  "Active",  false)
    trySet(BalanceText,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(BalanceText,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(BalanceText,  "BackgroundColor3",  Color3.new(1,  1,  1))
    trySet(BalanceText,  "BackgroundTransparency",  1)
    trySet(BalanceText,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(BalanceText,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(BalanceText,  "BorderSizePixel",  0)
    trySet(BalanceText,  "ClipsDescendants",  false)
    trySet(BalanceText,  "Draggable",  false)
    trySet(BalanceText,  "Interactable",  true)
    trySet(BalanceText,  "LayoutOrder",  0)
    trySet(BalanceText,  "Position",  UDim2.new(-0.0163934417,  0,  0.3342857122,  0))
    trySet(BalanceText,  "Rotation",  0)
    trySet(BalanceText,  "Selectable",  false)
    trySet(BalanceText,  "SelectionOrder",  0)
    trySet(BalanceText,  "Size",  UDim2.new(0.0,  70,  0.0,  39))
    trySet(BalanceText,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(BalanceText,  "Visible",  true)
    trySet(BalanceText,  "ZIndex",  1)
    trySet(BalanceText,  "AutoLocalize",  true)
    trySet(BalanceText,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BalanceText,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BalanceText,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BalanceText,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BalanceText,  "SelectionGroup",  false)
    trySet(BalanceText,  "DefinesCapabilities",  false)

    local SuccessPanel = Instance.new("Frame")
    SuccessPanel.Name = "SuccessPanel"
    trySet(SuccessPanel,  "Style",  enumValue(Enum.ButtonStyle,  0))
    trySet(SuccessPanel,  "Active",  true)
    trySet(SuccessPanel,  "AnchorPoint",  Vector2.new(0.5,  0.5))
    trySet(SuccessPanel,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(SuccessPanel,  "BackgroundColor3",  Color3.new(0.0980392173,  0.101960786,  0.121568628))
    trySet(SuccessPanel,  "BackgroundTransparency",  0)
    trySet(SuccessPanel,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(SuccessPanel,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(SuccessPanel,  "BorderSizePixel",  0)
    trySet(SuccessPanel,  "ClipsDescendants",  false)
    trySet(SuccessPanel,  "Draggable",  false)
    trySet(SuccessPanel,  "Interactable",  true)
    trySet(SuccessPanel,  "LayoutOrder",  0)
    trySet(SuccessPanel,  "Position",  UDim2.new(0.495243758,  0,  0.499986827,  0))
    trySet(SuccessPanel,  "Rotation",  0)
    trySet(SuccessPanel,  "Selectable",  false)
    trySet(SuccessPanel,  "SelectionOrder",  0)
    trySet(SuccessPanel,  "Size",  UDim2.new(0.0,  PANEL_WIDTH,  0.0,  PANEL_HEIGHT)) -- Modified
    trySet(SuccessPanel,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(SuccessPanel,  "Visible",  false)
    trySet(SuccessPanel,  "ZIndex",  1)
    trySet(SuccessPanel,  "AutoLocalize",  true)
    trySet(SuccessPanel,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(SuccessPanel,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(SuccessPanel,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(SuccessPanel,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(SuccessPanel,  "SelectionGroup",  false)
    trySet(SuccessPanel,  "DefinesCapabilities",  false)

    local UICorner5 = Instance.new("UICorner")
    UICorner5.Name = "UICorner"
    trySet(UICorner5,  "CornerRadius",  UDim.new(0.0,  CORNER_RADIUS)) -- Modified
    trySet(UICorner5,  "DefinesCapabilities",  false)

    local PurchaseCompleted = Instance.new("TextLabel")
    PurchaseCompleted.Name = "PurchaseCompleted"
    trySet(PurchaseCompleted,  "FontFace",  Font.new("",  enumValue(Enum.FontWeight,  700),  Enum.FontStyle.Normal))
    trySet(PurchaseCompleted,  "LineHeight",  1)
    trySet(PurchaseCompleted,  "LocalizationMatchIdentifier",  "")
    trySet(PurchaseCompleted,  "LocalizationMatchedSourceText",  "")
    trySet(PurchaseCompleted,  "MaxVisibleGraphemes",  -1)
    trySet(PurchaseCompleted,  "OpenTypeFeatures",  "")
    trySet(PurchaseCompleted,  "RichText",  false)
    trySet(PurchaseCompleted,  "Text",  "Purchase completed")
    trySet(PurchaseCompleted,  "TextColor3",  Color3.new(0.898039281,  0.898039281,  0.898039281))
    trySet(PurchaseCompleted,  "TextDirection",  enumValue(Enum.TextDirection,  0))
    trySet(PurchaseCompleted,  "TextScaled",  false)
    trySet(PurchaseCompleted,  "TextSize",  TITLE_TEXT_SIZE) -- Modified
    trySet(PurchaseCompleted,  "TextStrokeColor3",  Color3.new(0,  0,  0))
    trySet(PurchaseCompleted,  "TextStrokeTransparency",  1)
    trySet(PurchaseCompleted,  "TextTransparency",  0)
    trySet(PurchaseCompleted,  "TextTruncate",  enumValue(Enum.TextTruncate,  0))
    trySet(PurchaseCompleted,  "TextWrapped",  false)
    trySet(PurchaseCompleted,  "TextXAlignment",  enumValue(Enum.TextXAlignment,  2))
    trySet(PurchaseCompleted,  "TextYAlignment",  enumValue(Enum.TextYAlignment,  1))
    trySet(PurchaseCompleted,  "Active",  false)
    trySet(PurchaseCompleted,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(PurchaseCompleted,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(PurchaseCompleted,  "BackgroundColor3",  Color3.new(0.572549045,  0.580392182,  0.600000024))
    trySet(PurchaseCompleted,  "BackgroundTransparency",  1)
    trySet(PurchaseCompleted,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(PurchaseCompleted,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(PurchaseCompleted,  "BorderSizePixel",  0)
    trySet(PurchaseCompleted,  "ClipsDescendants",  false)
    trySet(PurchaseCompleted,  "Draggable",  false)
    trySet(PurchaseCompleted,  "Interactable",  true)
    trySet(PurchaseCompleted,  "LayoutOrder",  0)
    trySet(PurchaseCompleted,  "Position",  UDim2.new(-0.350872275,  0,  -0.231769969,  0))
    trySet(PurchaseCompleted,  "Rotation",  0)
    trySet(PurchaseCompleted,  "Selectable",  false)
    trySet(PurchaseCompleted,  "SelectionOrder",  0)
    trySet(PurchaseCompleted,  "Size",  UDim2.new(0.0,  454,  0.0,  125))
    trySet(PurchaseCompleted,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(PurchaseCompleted,  "Visible",  true)
    trySet(PurchaseCompleted,  "ZIndex",  1)
    trySet(PurchaseCompleted,  "AutoLocalize",  true)
    trySet(PurchaseCompleted,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(PurchaseCompleted,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(PurchaseCompleted,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(PurchaseCompleted,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(PurchaseCompleted,  "SelectionGroup",  false)
    trySet(PurchaseCompleted,  "DefinesCapabilities",  false)

    local UIStroke2 = Instance.new("UIStroke")
    UIStroke2.Name = "UIStroke"
    trySet(UIStroke2,  "ApplyStrokeMode",  enumValue(Enum.ApplyStrokeMode,  0))
    trySet(UIStroke2,  "BorderOffset",  UDim.new(0.0,  0))
    trySet(UIStroke2,  "BorderStrokePosition",  enumValue(Enum.BorderStrokePosition,  0))
    trySet(UIStroke2,  "Color",  Color3.new(1,  1,  1))
    trySet(UIStroke2,  "Enabled",  true)
    trySet(UIStroke2,  "LineJoinMode",  enumValue(Enum.LineJoinMode,  0))
    trySet(UIStroke2,  "StrokeSizingMode",  enumValue(Enum.StrokeSizingMode,  0))
    trySet(UIStroke2,  "Thickness",  1.5)
    trySet(UIStroke2,  "Transparency",  0.939999998)
    trySet(UIStroke2,  "ZIndex",  1)
    trySet(UIStroke2,  "DefinesCapabilities",  false)

    local OK = Instance.new("Frame")
    OK.Name = "OK"
    trySet(OK,  "Style",  enumValue(Enum.ButtonStyle,  0))
    trySet(OK,  "Active",  false)
    trySet(OK,  "AnchorPoint",  Vector2.new(0.5,  1))
    trySet(OK,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(OK,  "BackgroundColor3",  Color3.new(0.203921571,  0.360784322,  1))
    trySet(OK,  "BackgroundTransparency",  0)
    trySet(OK,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(OK,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(OK,  "BorderSizePixel",  0)
    trySet(OK,  "ClipsDescendants",  false)
    trySet(OK,  "Draggable",  false)
    trySet(OK,  "Interactable",  true)
    trySet(OK,  "LayoutOrder",  0)
    trySet(OK,  "Position",  UDim2.new(0.5,  0,  1.01769912,  -16))
    trySet(OK,  "Rotation",  0)
    trySet(OK,  "Selectable",  false)
    trySet(OK,  "SelectionOrder",  0)
    trySet(OK,  "Size",  UDim2.new(1.0,  -40,  -0.0309734512,  41))
    trySet(OK,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(OK,  "Visible",  true)
    trySet(OK,  "ZIndex",  1)
    trySet(OK,  "AutoLocalize",  false)
    trySet(OK,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(OK,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(OK,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(OK,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(OK,  "SelectionGroup",  false)
    trySet(OK,  "DefinesCapabilities",  false)

    local UICorner6 = Instance.new("UICorner")
    UICorner6.Name = "UICorner"
    trySet(UICorner6,  "CornerRadius",  UDim.new(0.0,  BUTTON_CORNER_RADIUS)) -- Modified
    trySet(UICorner6,  "DefinesCapabilities",  false)

    local BuyButton2 = Instance.new("TextButton")
    BuyButton2.Name = "BuyButton"
    trySet(BuyButton2,  "FontFace",  Font.new("",  enumValue(Enum.FontWeight,  700),  Enum.FontStyle.Normal))
    trySet(BuyButton2,  "LineHeight",  1)
    trySet(BuyButton2,  "LocalizationMatchIdentifier",  "")
    trySet(BuyButton2,  "LocalizationMatchedSourceText",  "")
    trySet(BuyButton2,  "MaxVisibleGraphemes",  -1)
    trySet(BuyButton2,  "OpenTypeFeatures",  "")
    trySet(BuyButton2,  "RichText",  false)
    trySet(BuyButton2,  "Text",  "OK")
    trySet(BuyButton2,  "TextColor3",  Color3.new(1,  1,  1))
    trySet(BuyButton2,  "TextDirection",  enumValue(Enum.TextDirection,  0))
    trySet(BuyButton2,  "TextScaled",  false)
    trySet(BuyButton2,  "TextSize",  16) -- Modified
    trySet(BuyButton2,  "TextStrokeColor3",  Color3.new(0,  0,  0))
    trySet(BuyButton2,  "TextStrokeTransparency",  1)
    trySet(BuyButton2,  "TextTransparency",  0)
    trySet(BuyButton2,  "TextTruncate",  enumValue(Enum.TextTruncate,  0))
    trySet(BuyButton2,  "TextWrapped",  false)
    trySet(BuyButton2,  "TextXAlignment",  enumValue(Enum.TextXAlignment,  2))
    trySet(BuyButton2,  "TextYAlignment",  enumValue(Enum.TextYAlignment,  1))
    trySet(BuyButton2,  "AutoButtonColor",  false)
    trySet(BuyButton2,  "Modal",  false)
    trySet(BuyButton2,  "Selected",  false)
    trySet(BuyButton2,  "Style",  enumValue(Enum.ButtonStyle,  0))
    trySet(BuyButton2,  "Active",  true)
    trySet(BuyButton2,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(BuyButton2,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(BuyButton2,  "BackgroundColor3",  Color3.new(1,  1,  1))
    trySet(BuyButton2,  "BackgroundTransparency",  1)
    trySet(BuyButton2,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(BuyButton2,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(BuyButton2,  "BorderSizePixel",  0)
    trySet(BuyButton2,  "ClipsDescendants",  false)
    trySet(BuyButton2,  "Draggable",  false)
    trySet(BuyButton2,  "Interactable",  true)
    trySet(BuyButton2,  "LayoutOrder",  0)
    trySet(BuyButton2,  "Position",  UDim2.new(0.193999978,  0,  -0.258564043,  1))
    trySet(BuyButton2,  "Rotation",  0)
    trySet(BuyButton2,  "Selectable",  true)
    trySet(BuyButton2,  "SelectionOrder",  0)
    trySet(BuyButton2,  "Size",  UDim2.new(0.0,  200,  0.0,  50))
    trySet(BuyButton2,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(BuyButton2,  "Visible",  true)
    trySet(BuyButton2,  "ZIndex",  1)
    trySet(BuyButton2,  "AutoLocalize",  false)
    trySet(BuyButton2,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyButton2,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyButton2,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyButton2,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(BuyButton2,  "SelectionGroup",  false)
    trySet(BuyButton2,  "DefinesCapabilities",  false)

    local Close2 = Instance.new("TextButton")
    Close2.Name = "Close"
    trySet(Close2,  "FontFace",  Font.new("",  enumValue(Enum.FontWeight,  700),  Enum.FontStyle.Normal))
    trySet(Close2,  "LineHeight",  1)
    trySet(Close2,  "LocalizationMatchIdentifier",  "")
    trySet(Close2,  "LocalizationMatchedSourceText",  "")
    trySet(Close2,  "MaxVisibleGraphemes",  -1)
    trySet(Close2,  "OpenTypeFeatures",  "")
    trySet(Close2,  "RichText",  false)
    trySet(Close2,  "Text",  "X")
    trySet(Close2,  "TextColor3",  Color3.new(0.854902029,  0.858823597,  0.874509871))
    trySet(Close2,  "TextDirection",  enumValue(Enum.TextDirection,  0))
    trySet(Close2,  "TextScaled",  false)
    trySet(Close2,  "TextSize",  18)
    trySet(Close2,  "TextStrokeColor3",  Color3.new(0,  0,  0))
    trySet(Close2,  "TextStrokeTransparency",  1)
    trySet(Close2,  "TextTransparency",  0)
    trySet(Close2,  "TextTruncate",  enumValue(Enum.TextTruncate,  0))
    trySet(Close2,  "TextWrapped",  false)
    trySet(Close2,  "TextXAlignment",  enumValue(Enum.TextXAlignment,  2))
    trySet(Close2,  "TextYAlignment",  enumValue(Enum.TextYAlignment,  1))
    trySet(Close2,  "AutoButtonColor",  false)
    trySet(Close2,  "Modal",  false)
    trySet(Close2,  "Selected",  false)
    trySet(Close2,  "Style",  enumValue(Enum.ButtonStyle,  0))
    trySet(Close2,  "Active",  true)
    trySet(Close2,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(Close2,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(Close2,  "BackgroundColor3",  Color3.new(0.176470593,  0.176470593,  0.203921571))
    trySet(Close2,  "BackgroundTransparency",  1)
    trySet(Close2,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(Close2,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(Close2,  "BorderSizePixel",  0)
    trySet(Close2,  "ClipsDescendants",  false)
    trySet(Close2,  "Draggable",  false)
    trySet(Close2,  "Interactable",  true)
    trySet(Close2,  "LayoutOrder",  0)
    trySet(Close2,  "Position",  UDim2.new(0.869000018,  0,  0.042000003,  0))
    trySet(Close2,  "Rotation",  0)
    trySet(Close2,  "Selectable",  true)
    trySet(Close2,  "SelectionOrder",  0)
    trySet(Close2,  "Size",  UDim2.new(0.0,  41,  0.0,  41))
    trySet(Close2,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(Close2,  "Visible",  true)
    trySet(Close2,  "ZIndex",  1)
    trySet(Close2,  "AutoLocalize",  true)
    trySet(Close2,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Close2,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Close2,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Close2,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(Close2,  "SelectionGroup",  false)
    trySet(Close2,  "DefinesCapabilities",  false)

    local UICorner7 = Instance.new("UICorner")
    UICorner7.Name = "UICorner"
    trySet(UICorner7,  "CornerRadius",  UDim.new(0.0,  9))
    trySet(UICorner7,  "DefinesCapabilities",  false)

    local CheckIcon = Instance.new("ImageLabel")
    CheckIcon.Name = "CheckIcon"
    trySet(CheckIcon,  "Image",  "rbxassetid://124946982440214")
    trySet(CheckIcon,  "ImageColor3",  Color3.new(1,  1,  1))
    trySet(CheckIcon,  "ImageRectOffset",  Vector2.new(0,  0))
    trySet(CheckIcon,  "ImageRectSize",  Vector2.new(0,  0))
    trySet(CheckIcon,  "ImageTransparency",  0)
    trySet(CheckIcon,  "ResampleMode",  enumValue(Enum.ResamplerMode,  0))
    trySet(CheckIcon,  "ScaleType",  enumValue(Enum.ScaleType,  0))
    trySet(CheckIcon,  "SliceScale",  1)
    trySet(CheckIcon,  "TileSize",  UDim2.new(1.0,  0,  1.0,  0))
    trySet(CheckIcon,  "Active",  false)
    trySet(CheckIcon,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(CheckIcon,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(CheckIcon,  "BackgroundColor3",  Color3.new(1,  1,  1))
    trySet(CheckIcon,  "BackgroundTransparency",  1)
    trySet(CheckIcon,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(CheckIcon,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(CheckIcon,  "BorderSizePixel",  0)
    trySet(CheckIcon,  "ClipsDescendants",  false)
    trySet(CheckIcon,  "Draggable",  false)
    trySet(CheckIcon,  "Interactable",  true)
    trySet(CheckIcon,  "LayoutOrder",  0)
    trySet(CheckIcon,  "Position",  UDim2.new(0.333800012,  0,  0.195999996,  0))
    trySet(CheckIcon,  "Rotation",  0)
    trySet(CheckIcon,  "Selectable",  false)
    trySet(CheckIcon,  "SelectionOrder",  0)
    trySet(CheckIcon,  "Size",  UDim2.new(0.0,  118,  0.0,  78))
    trySet(CheckIcon,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(CheckIcon,  "Visible",  true)
    trySet(CheckIcon,  "ZIndex",  1)
    trySet(CheckIcon,  "AutoLocalize",  true)
    trySet(CheckIcon,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(CheckIcon,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(CheckIcon,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(CheckIcon,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(CheckIcon,  "SelectionGroup",  false)
    trySet(CheckIcon,  "DefinesCapabilities",  false)

    local SuccessText = Instance.new("TextLabel")
    SuccessText.Name = "SuccessText"
    trySet(SuccessText,  "FontFace",  Font.new("",  enumValue(Enum.FontWeight,  400),  Enum.FontStyle.Normal))
    trySet(SuccessText,  "LineHeight",  0)
    trySet(SuccessText,  "LocalizationMatchIdentifier",  "")
    trySet(SuccessText,  "LocalizationMatchedSourceText",  "")
    trySet(SuccessText,  "MaxVisibleGraphemes",  -1)
    trySet(SuccessText,  "OpenTypeFeatures",  "")
    trySet(SuccessText,  "RichText",  false)
    trySet(SuccessText,  "Text",  "You have succesfully bought Colo2009.")
    trySet(SuccessText,  "TextColor3",  Color3.new(0.82745105,  0.839215755,  0.866666734))
    trySet(SuccessText,  "TextDirection",  enumValue(Enum.TextDirection,  0))
    trySet(SuccessText,  "TextScaled",  false)
    trySet(SuccessText,  "TextSize",  16)
    trySet(SuccessText,  "TextStrokeColor3",  Color3.new(0.572549045,  0.580392182,  0.600000024))
    trySet(SuccessText,  "TextStrokeTransparency",  1)
    trySet(SuccessText,  "TextTransparency",  0)
    trySet(SuccessText,  "TextWrapped",  false)
    trySet(SuccessText,  "TextXAlignment",  enumValue(Enum.TextXAlignment,  2))
    trySet(SuccessText,  "Active",  false)
    trySet(SuccessText,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(SuccessText,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(SuccessText,  "BackgroundColor3",  Color3.new(1,  1,  1))
    trySet(SuccessText,  "BackgroundTransparency",  1)
    trySet(SuccessText,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(SuccessText,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(SuccessText,  "BorderSizePixel",  0)
    trySet(SuccessText,  "ClipsDescendants",  false)
    trySet(SuccessText,  "Draggable",  false)
    trySet(SuccessText,  "Interactable",  true)
    trySet(SuccessText,  "LayoutOrder",  0)
    trySet(SuccessText,  "Position",  UDim2.new(0.97770000011,  1,  0.5,  1))
    trySet(SuccessText,  "Rotation",  0)
    trySet(SuccessText,  "Selectable",  false)
    trySet(SuccessText,  "SelectionOrder",  0)
    trySet(SuccessText,  "Size",  UDim2.new(0.0,  200,  0.0,  100))
    trySet(SuccessText,  "Visible",  true)
    trySet(SuccessText,  "ZIndex",  1)
    trySet(SuccessText,  "AutoLocalize",  true)
    trySet(SuccessText,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(SuccessText,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(SuccessText,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(SuccessText,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(SuccessText,  "SelectionGroup",  false)
    trySet(SuccessText,  "DefinesCapabilities",  false)

    local ImageButton = Instance.new("ImageButton")
    ImageButton.Name = "ImageButton"
    trySet(ImageButton,  "HoverImage",  "")
    trySet(ImageButton,  "Image",  "")
    trySet(ImageButton,  "ImageColor3",  Color3.new(1,  1,  1))
    trySet(ImageButton,  "ImageRectOffset",  Vector2.new(0,  0))
    trySet(ImageButton,  "ImageRectSize",  Vector2.new(0,  0))
    trySet(ImageButton,  "ImageTransparency",  0)
    trySet(ImageButton,  "PressedImage",  "")
    trySet(ImageButton,  "ResampleMode",  enumValue(Enum.ResamplerMode,  0))
    trySet(ImageButton,  "ScaleType",  enumValue(Enum.ScaleType,  0))
    trySet(ImageButton,  "SliceScale",  1)
    trySet(ImageButton,  "TileSize",  UDim2.new(1.0,  0,  1.0,  0))
    trySet(ImageButton,  "AutoButtonColor",  true)
    trySet(ImageButton,  "Modal",  false)
    trySet(ImageButton,  "Selected",  false)
    trySet(ImageButton,  "Style",  enumValue(Enum.ButtonStyle,  0))
    trySet(ImageButton,  "Active",  true)
    trySet(ImageButton,  "AnchorPoint",  Vector2.new(0,  0))
    trySet(ImageButton,  "AutomaticSize",  enumValue(Enum.AutomaticSize,  0))
    trySet(ImageButton,  "BackgroundColor3",  Color3.new(1,  1,  1))
    trySet(ImageButton,  "BackgroundTransparency",  0)
    trySet(ImageButton,  "BorderColor3",  Color3.new(0,  0,  0))
    trySet(ImageButton,  "BorderMode",  enumValue(Enum.BorderMode,  0))
    trySet(ImageButton,  "BorderSizePixel",  0)
    trySet(ImageButton,  "ClipsDescendants",  false)
    trySet(ImageButton,  "Draggable",  false)
    trySet(ImageButton,  "Interactable",  true)
    trySet(ImageButton,  "LayoutOrder",  0)
    trySet(ImageButton,  "Position",  UDim2.new(0.04812347699,  0,  0.13787678,  0))
    trySet(ImageButton,  "Rotation",  0)
    trySet(ImageButton,  "Selectable",  true)
    trySet(ImageButton,  "SelectionOrder",  0)
    trySet(ImageButton,  "Size",  UDim2.new(0.0,  20,  0.0,  20))
    trySet(ImageButton,  "SizeConstraint",  enumValue(Enum.SizeConstraint,  0))
    trySet(ImageButton,  "Visible",  true)
    trySet(ImageButton,  "ZIndex",  1)
    trySet(ImageButton,  "AutoLocalize",  true)
    trySet(ImageButton,  "SelectionBehaviorDown",  enumValue(Enum.SelectionBehavior,  0))
    trySet(ImageButton,  "SelectionBehaviorLeft",  enumValue(Enum.SelectionBehavior,  0))
    trySet(ImageButton,  "SelectionBehaviorRight",  enumValue(Enum.SelectionBehavior,  0))
    trySet(ImageButton,  "SelectionBehaviorUp",  enumValue(Enum.SelectionBehavior,  0))
    trySet(ImageButton,  "SelectionGroup",  false)
    trySet(ImageButton,  "DefinesCapabilities",  false)

    -- Parenting (matches hierarchy)
    CustomBuyPrompt.Parent = parent
    Overlay.Parent = CustomBuyPrompt
    Panel.Parent = Overlay
    UICorner.Parent = Panel
    BuyItem.Parent = Panel
    ItemImage.Parent = Panel
    UIStroke.Parent = Panel
    ItemNameText.Parent = Panel
    PriceIcon.Parent = Panel
    PriceText.Parent = Panel
    BuyWrap.Parent = Panel
    UICorner2.Parent = BuyWrap
    Fill.Parent = BuyWrap
    UICorner3.Parent = Fill
    BuyButton.Parent = BuyWrap
    Close.Parent = Panel
    UICorner4.Parent = Close
    BalanceRow.Parent = Panel
    BalanceIcon.Parent = BalanceRow
    UIListLayout.Parent = BalanceRow
    BalanceText.Parent = BalanceRow
    SuccessPanel.Parent = Overlay
    UICorner5.Parent = SuccessPanel
    PurchaseCompleted.Parent = SuccessPanel
    UIStroke2.Parent = SuccessPanel
    OK.Parent = SuccessPanel
    UICorner6.Parent = OK
    BuyButton2.Parent = OK
    Close2.Parent = SuccessPanel
    UICorner7.Parent = Close2
    CheckIcon.Parent = SuccessPanel
    SuccessText.Parent = SuccessPanel
    ImageButton.Parent = CustomBuyPrompt

    return CustomBuyPrompt
end

-- Controller code continues unchanged...


					-- =========================
					-- =========================
					-- =========================
					-- =========================
					-- =========================
					-- Controller (inlined)
				local promptLocks = {}

					-- =========================
					local function sanitizeSingleLine(s)
						s = tostring(s or "")
						-- remove control chars like \n \r \t etc
						s = s:gsub("[%c]", " ")
						-- collapse spaces + trim
						s = s:gsub("%s+", " "):match("^%s*(.-)%s*$")
						return s
					end

					-- =========================================================



					-- Defines _G.ShowGiftPopupDupe(username) if not already defined
					-- =========================================================
					local function EnsureGiftPopupDupe()
						local SoundService = game:GetService("SoundService")
						local Debris = game:GetService("Debris")
							local function forceSentGiftText(root)
						local TARGET = "sent gift!"

						-- try common names first (fast + deterministic if you rename it later)
						local nameHints = { "SentGift", "SentGiftText", "GiftText", "Message", "Msg", "Title", "Header", "Text" }
						for _, hint in ipairs(nameHints) do
							local obj = root:FindFirstChild(hint, true)
							if obj and obj:IsA("TextLabel") then
								obj.Text = TARGET
								obj.Visible = true
								obj.TextTransparency = 0
								obj.BackgroundTransparency = 1
								return
							end
						end

						-- fallback: pick the largest TextLabel (usually the main message line)
						local best, bestArea = nil, 0
						for _, d in ipairs(root:GetDescendants()) do
							if d:IsA("TextLabel") then
								local area = d.AbsoluteSize.X * d.AbsoluteSize.Y
								if area > bestArea then
									bestArea = area
									best = d
								end
							end
						end

						if best then
							best.Text = TARGET
							best.Visible = true
							best.TextTransparency = 0
							best.BackgroundTransparency = 1
						end
					end
						if _G.ShowGiftPopupDupe then return end

						local Players = game:GetService("Players")
						local StarterGui = game:GetService("StarterGui")
						local TweenService = game:GetService("TweenService")

						local player = Players.LocalPlayer
						local playerGui = player:WaitForChild("PlayerGui")

						-- ====== TIMING ======
						local POP_TIME = 0.20
						local TOTAL_LIFETIME = 5.5 -- from show -> destroyed (includes pop in + pop out)
						local USER_CHAR_DELAY = 0.018

						-- ====== FLY IN ======
						local FLY_Y_OFFSET_PX = 28 -- starts slightly lower, flies up into place

						-- ====== TEMPLATE PATHS ======
						local function findGiftTemplate()
							local pgTemplates = playerGui:FindFirstChild("UITemplates")
							if pgTemplates then
								local t = pgTemplates:FindFirstChild("giftPopup")
								if t then return t end
							end

							local sgTemplates = StarterGui:FindFirstChild("UITemplates")
							if sgTemplates then
								local t = sgTemplates:FindFirstChild("giftPopup")
								if t then return t end
							end

							return nil
						end

						local function stripScripts(root)
							for _, d in ipairs(root:GetDescendants()) do
								if d:IsA("LocalScript") or d:IsA("Script") then
									d:Destroy()
								end
							end
						end

						local function safeClone(inst)
							local old = inst.Archivable
							pcall(function() inst.Archivable = true end)
							local ok, c = pcall(function() return inst:Clone() end)
							pcall(function() inst.Archivable = old end)
							if ok then return c end
							return nil
						end

						local function getTargetParent(cloneObj)
							-- If the template is a ScreenGui, it MUST go under PlayerGui.
							if cloneObj:IsA("ScreenGui") then
								return playerGui
							end

							-- Otherwise prefer MainGUI.Popups if it exists
							local main = playerGui:FindFirstChild("MainGUI")
							local popups = main and main:FindFirstChild("Popups")
							return popups or playerGui
						end

						local function firstGuiObject(root)
							if root:IsA("GuiObject") then return root end
							for _, d in ipairs(root:GetDescendants()) do
								if d:IsA("GuiObject") then
									return d
								end
							end
							return nil
						end

						-- Pick the label where the username appears.
						-- Priority:
						-- 1) Any TextLabel containing "{USER}"
						-- 2) Any TextLabel containing an "@name"
						-- 3) Common name matches
						-- 4) First TextLabel found
						local function findUserLabel(root)
						for _, d in ipairs(root:GetDescendants()) do
							if d:IsA("TextLabel") then
								if tostring(d.Text):find("{USER}", 1, true) then
									return d, "placeholder"
								end
							end
						end

						for _, d in ipairs(root:GetDescendants()) do
							if d:IsA("TextLabel") then
								if tostring(d.Text):match("@[%w_]+") then
									return d, "atpattern"
								end
							end
						end

						return nil, nil -- no safe target; don't type anywhere
					end

						-- Types only the username portion, keeping any prefix/suffix constant.
						local function typeUsernameOnly(tokenRef, label, rawText, username, mode)
							username = tostring(username or "")
							if username ~= "" and not username:match("^@") then
								username = "@" .. username
							end

							local originalRich = label.RichText
							label.RichText = false -- prevent partial richtext tags from breaking while typing

							local prefix, suffix = "", ""
							if mode == "placeholder" and rawText:find("{USER}", 1, true) then
								local a, b = rawText:find("{USER}", 1, true)
								prefix = rawText:sub(1, a - 1)
								suffix = rawText:sub(b + 1)
							elseif mode == "atpattern" then
								local a, b = rawText:find("@[%w_]+")
								if a and b then
									prefix = rawText:sub(1, a - 1)
									suffix = rawText:sub(b + 1)
								else
									prefix, suffix = "", ""
								end
							else
								prefix, suffix = "", ""
							end

							label.Text = prefix .. suffix

							for i = 1, #username do
								if tokenRef.killed then return end
								label.Text = prefix .. username:sub(1, i) .. suffix
								task.wait(USER_CHAR_DELAY)
							end

							label.RichText = originalRich
						end

						-- ====== Animation controller ======
						local animToken = 0
						local currentClone = nil
						local showTween1, showTween2, hideTween1, hideTween2

						local function cancelTweens()
							for _, t in ipairs({ showTween1, showTween2, hideTween1, hideTween2 }) do
								if t then pcall(function() t:Cancel() end) end
							end
							showTween1, showTween2, hideTween1, hideTween2 = nil, nil, nil, nil
						end

						local function destroyCurrent()
							if currentClone then
								pcall(function() currentClone:Destroy() end)
								currentClone = nil
							end
						end

					function _G.ShowGiftPopupDupe(username)
						animToken += 1
						local myToken = animToken
						local tokenRef = { killed = false }

						cancelTweens()
						destroyCurrent()

						local template = findGiftTemplate()
						if not template then
							warn("[GiftPopupDupe] Couldn't find UITemplates.giftPopup in PlayerGui or StarterGui.")
							return
						end

						local clone = safeClone(template)
						if not clone then
							warn("[GiftPopupDupe] Clone failed (Archivable/protected).")
							return
						end

						clone.Name = "giftPopup_PERSIST"
						stripScripts(clone)
						clone.Parent = getTargetParent(clone)
						currentClone = clone

						-- ALWAYS force "sent gift!" text
						forceSentGiftText(clone)

						-- Decide what GUI object we animate (ScreenGui -> animate its first GuiObject inside)
						local animRoot = clone
						if clone:IsA("ScreenGui") then
							clone.ResetOnSpawn = false
							clone.IgnoreGuiInset = true
							clone.DisplayOrder = 999999
							clone.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
							clone.Enabled = true

							animRoot = firstGuiObject(clone)
						end

						if not animRoot or not animRoot:IsA("GuiObject") then
							warn("[GiftPopupDupe] No GuiObject found inside giftPopup to animate.")
							return
						end

						animRoot.Visible = true
						-- play sound once when popup appears
	do
		local s = Instance.new("Sound")
		s.SoundId = "rbxassetid://14674229054"
		s.Volume = 1
		s.Looped = false
		s.Parent = SoundService
		SoundService:PlayLocalSound(s)
		Debris:AddItem(s, 3)
	end


						-- Ensure UIScale exists for pop
						local scale = animRoot:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
						scale.Name = "UIScale"
						scale.Scale = 0.01
						scale.Parent = animRoot

						-- Fly-in position
						local finalPos = animRoot.Position
						animRoot.Position = finalPos + UDim2.new(0, 0, 0, FLY_Y_OFFSET_PX)

						-- Pop + fly in
						showTween1 = TweenService:Create(scale, TweenInfo.new(POP_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = 1 })
						showTween2 = TweenService:Create(animRoot, TweenInfo.new(POP_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = finalPos })
						showTween1:Play()
						showTween2:Play()

						-- Username typing (ONLY if a username was provided AND a safe label exists)
						local uname = tostring(username or "")
						if uname ~= "" then
							local label, mode = findUserLabel(clone)
							if label then
								local raw = tostring(label.Text or "")
								task.spawn(function()
									typeUsernameOnly(tokenRef, label, raw, uname, mode)
								end)
							end
						end

						-- Hide timing so total lifetime ~= 5.5s including pop out
						local hideDelay = math.max(0, TOTAL_LIFETIME - POP_TIME)
						task.delay(hideDelay, function()
							if myToken ~= animToken then return end
							tokenRef.killed = true

							cancelTweens()

							hideTween1 = TweenService:Create(scale, TweenInfo.new(POP_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Scale = 0.01 })
							hideTween2 = TweenService:Create(animRoot, TweenInfo.new(POP_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
								Position = finalPos + UDim2.new(0, 0, 0, FLY_Y_OFFSET_PX)
							})

							hideTween1:Play()
							hideTween2:Play()

							hideTween1.Completed:Once(function()
								if myToken ~= animToken then return end
								destroyCurrent()
							end)
						end)
					end

					end

					local function formatWithCommas(n: number): string
						local s = tostring(math.floor(n))
						local k
						repeat
							s, k = s:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
						until k == 0
						return s
					end

					local function addToRaisedTextKeepDecor(text: string, add: number): string
						local firstDigit = text:find("%d")
						if not firstDigit then return text end

						local lastDigit = firstDigit
						for i = firstDigit, #text do
							local ch = text:sub(i, i)
							if ch:match("%d") then
								lastDigit = i
							elseif i > firstDigit and not ch:match("[%d,%.%s]") then
								break
							end
						end

						local prefix = text:sub(1, firstDigit - 1)
						local numberChunk = text:sub(firstDigit, lastDigit)
						local suffix = text:sub(lastDigit + 1)

						local digitsOnly = numberChunk:gsub("%D", "")
						local current = tonumber(digitsOnly) or 0
						local newValue = current + (add or 0)

						return prefix .. formatWithCommas(newValue) .. suffix
					end

					local function tryGetOfflineRaisedLabel(playerGui: PlayerGui)
						local boothUI = playerGui:FindFirstChild("BoothUI")
						local details = boothUI and boothUI:FindFirstChild("Details")
						local raised = details and details:FindFirstChild("Raised")
						if raised and raised:IsA("TextLabel") then
							return raised
						end
						return nil
					end


					-- =========================================================
					-- Controller (CustomBuyPrompt)

					-- Hover effect (lighter on hover)
					-- =========================================================
					local function AttachCustomBuyPromptController(gui)
						EnsureGiftPopupDupe()

						-- Original placement: StarterGui > CustomBuyPrompt > LocalScript
						local TweenService = game:GetService("TweenService")
						local ContentProvider = game:GetService("ContentProvider")
						local Players = game:GetService("Players")

						local player = Players.LocalPlayer
						local playerGui = player:WaitForChild("PlayerGui")
						if not gui or not gui:IsA("ScreenGui") then
							warn("AttachCustomBuyPromptController expected a ScreenGui (CustomBuyPrompt).")
							return
						end

						-- =========================
						-- TUNING (easy edits)
						-- =========================
						-- In the AttachCustomBuyPromptController function, find this section and modify:

                        -- =========================
                        -- TUNING (easy edits)
                        -- =========================
                        local ROBUX_ICON = "rbxassetid://135557279290308"
                        local OVERLAY_TARGET_TRANSPARENCY = 0.21

                        -- Reduced scale factor (was 1.33)
                        local SCALE = 1.0 -- No scaling (original size)

                        -- Panel sizing adjustments
                        local PANEL_WIDTH = 350  -- Reduced from 441
                        local PANEL_HEIGHT = 190 -- Reduced from 238

                        -- Text size adjustments
                        local TITLE_TEXT_SIZE = 22  -- Reduced from 27
                        local NAME_TEXT_SIZE = 16   -- Reduced from 19
                        local PRICE_TEXT_SIZE = 16  -- Reduced from 19
                        local BUTTON_TEXT_SIZE = 15 -- Reduced from 18

                        -- Corner radius adjustments
                        local CORNER_RADIUS = 10    -- Reduced from 15
                        local BUTTON_CORNER_RADIUS = 6 -- Reduced from 8
                        
                        -- Fast fly-in (Panel / SuccessPanel)
                        local FLY_IN_TIME = 0.08
                        local FLY_IN_OFFSET_PX = 20 -- Reduced from 26
                        local FLY_EASING_STYLE = Enum.EasingStyle.Quad
                        local FLY_EASING_DIR = Enum.EasingDirection.Out
                        
                        -- If true, script will NOT change Panel / Close / ItemNameText positioning.
                        local USE_STUDIO_LAYOUT = true
                        
                        -- Buy button fill
                        local FILL_START_DELAY = 0.5
                        local FILL_SECONDS = 1.8
                        local BUY_PROCESS_SECONDS = 0.9
                        
                        local BALANCE_ICON_PADDING = 4 -- Reduced from 6
                        
                        -- Success text placeholder handling
                        local SUCCESS_PLACEHOLDER = "{ITEM}"

                        -- In the CreateCustomBuyPrompt function, modify these sections:
                        
                        -- Panel size
                        trySet(Panel, "Size", UDim2.new(0, PANEL_WIDTH, 0, PANEL_HEIGHT))
                        
                        -- Corner radius
                        trySet(UICorner, "CornerRadius", UDim.new(0, CORNER_RADIUS))
                        
                        -- BuyItem text size
                        trySet(BuyItem, "TextSize", TITLE_TEXT_SIZE)
                        
                        -- ItemNameText
                        trySet(ItemNameText, "TextSize", NAME_TEXT_SIZE)
                        trySet(ItemNameText, "Size", UDim2.new(0, 220, 0, 32)) -- Reduced size
                        
                        -- PriceText
                        trySet(PriceText, "TextSize", PRICE_TEXT_SIZE)
                        
                        -- BuyButton text size
                        trySet(BuyButton, "TextSize", BUTTON_TEXT_SIZE)
                        
                        -- Button corner radius
                        trySet(UICorner2, "CornerRadius", UDim.new(0, BUTTON_CORNER_RADIUS))
                        trySet(UICorner3, "CornerRadius", UDim.new(0, BUTTON_CORNER_RADIUS))

                        -- SuccessPanel (same adjustments)
                        trySet(SuccessPanel, "Size", UDim2.new(0, PANEL_WIDTH, 0, PANEL_HEIGHT))
                        trySet(UICorner5, "CornerRadius", UDim.new(0, CORNER_RADIUS))
                        trySet(PurchaseCompleted, "TextSize", TITLE_TEXT_SIZE)
                        trySet(BuyButton2, "TextSize", BUTTON_TEXT_SIZE)
                        trySet(UICorner6, "CornerRadius", UDim.new(0, BUTTON_CORNER_RADIUS))
                        
                        -- Also modify the controller's applyScale function:
                        local SCALE = 1.0 -- Changed from 1.33
                        
                        local function applyScale(frame)
                            if not (frame and frame:IsA("GuiObject")) then return end
                            local s = frame:FindFirstChild("UIScale") or Instance.new("UIScale")
                            s.Name = "UIScale"
                            s.Scale = SCALE
                            s.Parent = frame
                        end
                        
                        applyScale(panel)
                        applyScale(successPanel)

						-- =========================
						-- ScreenGui draw settings (keep on top in live game)
						-- =========================
						gui.ResetOnSpawn = false
						gui.IgnoreGuiInset = true
						gui.DisplayOrder = 999999
						gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

						-- =========================
						-- Helpers
						local function getOfflineOwnerUsername(playerGui)
	local boothUI = playerGui:FindFirstChild("BoothUI")
	local details = boothUI and boothUI:FindFirstChild("Details")
	local owner = details and details:FindFirstChild("Owner")
	if owner and owner:IsA("TextLabel") then
		-- Owner.Text is usually like "<user>'s stand"
		local txt = tostring(owner.Text or "")
		local u = txt:match("^(.-)%s*'s%s+stand")
		return u or txt
	end
	return ""
end

						local function flyIn(guiObj)
						if not (guiObj and guiObj:IsA("GuiObject")) then return end

						-- cancel any old tween
						if panelTween then pcall(function() panelTween:Cancel() end) end

						local finalPos = guiObj.Position
						guiObj.Position = finalPos + UDim2.new(0, 0, 0, FLY_IN_OFFSET_PX) -- start lower
						guiObj.Visible = true

						panelTween = TweenService:Create(
							guiObj,
							TweenInfo.new(FLY_IN_TIME, FLY_EASING_STYLE, FLY_EASING_DIR),
							{ Position = finalPos }
						)
						panelTween:Play()
					end

						-- =========================
						local function findDescendantAnyCase(parent, name)
							if not parent then return nil end
							local target = string.lower(name)
							for _, d in ipairs(parent:GetDescendants()) do
								if string.lower(d.Name) == target then
									return d
								end
							end
							return nil
						end

						local function must(parent, name)
							if not parent then return nil end
							local obj = parent:FindFirstChild(name, true) or findDescendantAnyCase(parent, name)
							if not obj then
								warn(("Missing UI object '%s' under %s"):format(name, parent:GetFullName()))
							end
							return obj
						end

						local function forceIcon(img)
							if not img then return end
							if img:IsA("ImageLabel") or img:IsA("ImageButton") then
								img.Visible = true
								img.ImageTransparency = 0
								img.BackgroundTransparency = 1
								img.Image = ROBUX_ICON
							end
						end

						-- parse numbers that may include commas (e.g. "1,174,264")
						local function parseNumberText(s)
							s = tostring(s or "")
							s = s:gsub(",", ""):gsub("%s", "")
							return tonumber(s)
						end

						-- format numbers with commas for display
						local function formatWithCommas(n)
							n = math.floor(tonumber(n) or 0)
							local sign = ""
							if n < 0 then
								sign = "-"
								n = -n
							end
							local s = tostring(n)
							while true do
								local new = s:gsub("^(%d+)(%d%d%d)", "%1,%2")
								if new == s then break end
								s = new
							end
							return sign .. s
						end

						-- =========================
						-- Donation toast (ONLINE OK)
						-- =========================
						local function buildDonationToast(playerGui)
							local ROBUX_ICON_ID = ROBUX_ICON
							local BG_GREEN = Color3.fromRGB(0, 255, 38)
							local FG_DARK = Color3.fromRGB(19, 90, 30)
							local BOTTOM_OFFSET_PX = 70
							local ICON_SIZE_PX = 28

							local POP_TIME = 0.20
							local DISPLAY_TIME = 4.0
							local USER_CHAR_DELAY = 0.018

							local old = playerGui:FindFirstChild("DonationPopupDupe")
							if old then old:Destroy() end

							local toastGui = Instance.new("ScreenGui")
							toastGui.Name = "DonationPopupDupe"
							toastGui.IgnoreGuiInset = true
							toastGui.ResetOnSpawn = false
							toastGui.DisplayOrder = 999998
							toastGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
							toastGui.Parent = playerGui

							local pill = Instance.new("Frame")
							pill.Name = "donationPopup_PERSIST"
							pill.BackgroundColor3 = BG_GREEN
							pill.BorderSizePixel = 0
							pill.AutomaticSize = Enum.AutomaticSize.XY
							pill.AnchorPoint = Vector2.new(0.5, 1)
							pill.Position = UDim2.new(0.5, 0, 1, -BOTTOM_OFFSET_PX)
							pill.Active = true
							pill.Visible = false
							pill.Parent = toastGui

							local corner = Instance.new("UICorner")
							corner.CornerRadius = UDim.new(0, 30)
							corner.Parent = pill

							local stroke = Instance.new("UIStroke")
							stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
							stroke.Color = Color3.fromRGB(0, 0, 0)
							stroke.LineJoinMode = Enum.LineJoinMode.Round
							stroke.Thickness = 3
							stroke.Transparency = 0.97
							stroke.Parent = pill

							local pad = Instance.new("UIPadding")
							pad.PaddingLeft = UDim.new(0, 16)
							pad.PaddingRight = UDim.new(0, 20)
							pad.PaddingTop = UDim.new(0, 12)
							pad.PaddingBottom = UDim.new(0, 12)
							pad.Parent = pill

							local layout = Instance.new("UIListLayout")
							layout.FillDirection = Enum.FillDirection.Horizontal
							layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
							layout.VerticalAlignment = Enum.VerticalAlignment.Center
							layout.SortOrder = Enum.SortOrder.LayoutOrder
							layout.Padding = UDim.new(0, 10)
							layout.Parent = pill

							local scale = Instance.new("UIScale")
							scale.Name = "UIScale"
							scale.Scale = 0.01
							scale.Parent = pill

							local function makeIcon(name, sizePx, order)
								local img = Instance.new("ImageLabel")
								img.Name = name
								img.BackgroundTransparency = 1
								img.Image = ROBUX_ICON_ID
								img.ImageColor3 = FG_DARK
								img.ScaleType = Enum.ScaleType.Fit
								img.Size = UDim2.fromOffset(sizePx, sizePx)
								img.LayoutOrder = order
								img.Parent = pill

								local ar = Instance.new("UIAspectRatioConstraint")
								ar.AspectRatio = 1
								ar.Parent = img
								return img
							end

							local function makeText(name, text, order)
								local t = Instance.new("TextLabel")
								t.Name = name
								t.BackgroundTransparency = 1
								t.AutomaticSize = Enum.AutomaticSize.XY
								t.Text = text
								t.RichText = true
								t.TextColor3 = FG_DARK
								t.TextSize = 22
								t.TextWrapped = false
								t.TextXAlignment = Enum.TextXAlignment.Center
								t.TextYAlignment = Enum.TextYAlignment.Center
								t.LayoutOrder = order
								pcall(function()
									t.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
								end)
								t.Parent = pill
								return t
							end

							makeIcon("Icon", ICON_SIZE_PX, 0)
							makeText("MsgLeft", "you donated", 1)
							makeIcon("MidIcon", ICON_SIZE_PX, 2)

							local rightWrap = Instance.new("Frame")
							rightWrap.Name = "RightWrap"
							rightWrap.BackgroundTransparency = 1
							rightWrap.AutomaticSize = Enum.AutomaticSize.XY
							rightWrap.LayoutOrder = 3
							rightWrap.Parent = pill

							local rightLayout = Instance.new("UIListLayout")
							rightLayout.FillDirection = Enum.FillDirection.Horizontal
							rightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
							rightLayout.VerticalAlignment = Enum.VerticalAlignment.Center
							rightLayout.SortOrder = Enum.SortOrder.LayoutOrder
							rightLayout.Padding = UDim.new(0, 0)
							rightLayout.Parent = rightWrap

							local rightPrefix = Instance.new("TextLabel")
							rightPrefix.Name = "RightPrefix"
							rightPrefix.BackgroundTransparency = 1
							rightPrefix.AutomaticSize = Enum.AutomaticSize.XY
							rightPrefix.RichText = true
							rightPrefix.TextColor3 = FG_DARK
							rightPrefix.TextSize = 22
							rightPrefix.TextWrapped = false
							rightPrefix.TextXAlignment = Enum.TextXAlignment.Center
							rightPrefix.TextYAlignment = Enum.TextYAlignment.Center
							rightPrefix.LayoutOrder = 0
							pcall(function()
								rightPrefix.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
							end)
							rightPrefix.Parent = rightWrap

							local rightUser = Instance.new("TextLabel")
							rightUser.Name = "RightUser"
							rightUser.BackgroundTransparency = 1
							rightUser.AutomaticSize = Enum.AutomaticSize.XY
							rightUser.RichText = true
							rightUser.TextColor3 = FG_DARK
							rightUser.TextSize = 22
							rightUser.TextWrapped = false
							rightUser.TextXAlignment = Enum.TextXAlignment.Center
							rightUser.TextYAlignment = Enum.TextYAlignment.Center
							rightUser.LayoutOrder = 1
							pcall(function()
								rightUser.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
							end)
							rightUser.Parent = rightWrap

							local animToken = 0
							local showTween, hideTween

							local function cancelTweens()
								if showTween then pcall(function() showTween:Cancel() end) end
								if hideTween then pcall(function() hideTween:Cancel() end) end
								showTween, hideTween = nil, nil
							end

							local function typeUsername(token, username)
								username = tostring(username or "@unknown")
								rightUser.Text = ""
								for i = 1, #username do
									if token ~= animToken then return end
									rightUser.Text = string.sub(username, 1, i)
									task.wait(USER_CHAR_DELAY)
								end
							end

							local function hidePopup(token)
								if token ~= animToken then return end
								cancelTweens()
								hideTween = TweenService:Create(scale, TweenInfo.new(POP_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Scale = 0.01 })
								hideTween:Play()
								hideTween.Completed:Once(function()
									if token ~= animToken then return end
									pill.Visible = false
								end)
							end

							local function showPopup(amountText, username)
								animToken += 1
								local token = animToken
								cancelTweens()

								pill.Visible = true
								scale.Scale = 0.01

								rightPrefix.Text = ("%s to "):format(tostring(amountText or "0"))

								task.spawn(function()
									typeUsername(token, username)
								end)

								showTween = TweenService:Create(scale, TweenInfo.new(POP_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = 1 })
								showTween:Play()

								task.delay(DISPLAY_TIME, function()
									hidePopup(token)
								end)
							end

							return showPopup
						end

						local showDonationToast = buildDonationToast(player:WaitForChild("PlayerGui"))

						-- =========================
						-- UI references (match your Explorer)
						-- =========================
						local overlay = must(gui, "Overlay")
						local panel = overlay and must(overlay, "Panel")
						local successPanel = overlay and must(overlay, "SuccessPanel")
						local function syncSuccessToPanel()
	if panel and successPanel then
		successPanel.AnchorPoint = panel.AnchorPoint
		successPanel.Position = panel.Position
	end
end

						local SCALE = 1.33 -- 10% bigger

					local function applyScale(frame)
						if not (frame and frame:IsA("GuiObject")) then return end
						local s = frame:FindFirstChild("UIScale") or Instance.new("UIScale")
						s.Name = "UIScale"
						s.Scale = SCALE
						s.Parent = frame
					end

					applyScale(panel)
					applyScale(successPanel)

						-- FORCE perfect centering (1:1 screen center)
					local CENTER_Y_OFFSET_PX = 29 -- try 6, 8, 10, 12 etc.
						
					local function centerFrame(f)
						if f and f:IsA("GuiObject") then
							f.AnchorPoint = Vector2.new(0.5, 0.5)
							f.Position = UDim2.new(0.5, 0, 0.5, CENTER_Y_OFFSET_PX)
						end
					end

					-- make overlay true full-screen (removes the tiny -0.007 offset)
					if overlay then
						overlay.AnchorPoint = Vector2.new(0, 0)
						overlay.Position = UDim2.fromScale(0, 0)
						overlay.Size = UDim2.fromScale(1, 1)
					end

					centerFrame(panel)


						if not overlay or not panel or not successPanel then
							warn("Missing Overlay/Panel/SuccessPanel in CustomBuyPrompt.")
							return
						end

						-- Main prompt refs
						local closeBtn = must(panel, "Close")
						local itemImage = must(panel, "ItemImage")
						local itemNameText = must(panel, "ItemNameText")
						-- Make the item name line wider so it truncates later (like the real prompt)
		if itemNameText and itemNameText:IsA("TextLabel") then
			itemNameText.TextTruncate = Enum.TextTruncate.AtEnd
			itemNameText.TextXAlignment = Enum.TextXAlignment.Left
			itemNameText.TextWrapped = false

			-- widen the label (this is what fixes the "cuts off too early")
			itemNameText.Size = UDim2.new(0, 300, 0, 40)  -- try 300-330

			-- optional: nudge it a little left if you want even more room
			-- itemNameText.Position = itemNameText.Position + UDim2.new(0, -10, 0, 0)
		end

						local priceText = must(panel, "PriceText")
						
						local priceIcon = must(panel, "PriceIcon")
						local balanceText = must(panel, "BalanceText")
						local balanceIcon = must(panel, "BalanceIcon")
						local balanceText = must(panel, "BalanceText")
local balanceIcon = must(panel, "BalanceIcon")


						if balanceText and balanceText:IsA("TextLabel") then
	balanceText.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
end


						local buyWrap = must(panel, "BuyWrap")
						local fill = buyWrap and must(buyWrap, "Fill")
						local buyButton = buyWrap and must(buyWrap, "BuyButton")
						-- Hover effect on the whole BuyWrap (so hovering anywhere on the blue bar works)
				do
					if buyWrap and buyWrap:IsA("Frame") then
						local TweenService = game:GetService("TweenService")

						-- make sure BuyWrap can receive mouse hover signals
						buyWrap.Active = true

						local hoverTween, outTween
						local baseColor: Color3? = nil

						local tIn  = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						local tOut = TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

						local function cancel()
							if hoverTween then pcall(function() hoverTween:Cancel() end) end
							if outTween then pcall(function() outTween:Cancel() end) end
							hoverTween, outTween = nil, nil
						end

						buyWrap.MouseEnter:Connect(function()
							-- only hover-lighten when the buy button is actually usable
							if not (buyButton and buyButton.Active) then return end

							baseColor = buyWrap.BackgroundColor3
							local lighter = baseColor:Lerp(Color3.new(1, 1, 1), 0.12)

							cancel()
							hoverTween = TweenService:Create(buyWrap, tIn, { BackgroundColor3 = lighter })
							hoverTween:Play()
						end)

						buyWrap.MouseLeave:Connect(function()
							if not baseColor then return end
							cancel()
							outTween = TweenService:Create(buyWrap, tOut, { BackgroundColor3 = baseColor })
							outTween:Play()
						end)
					end
				end


						-- Success prompt refs
						local successCloseBtn = must(successPanel, "Close")
						local successText = must(successPanel, "SuccessText")
						-- Fix "Purchase completed" message going out of bounds
		if successText and successText:IsA("TextLabel") then
			successText.Position = successText.Position + UDim2.new(0, 0, 0, -10) -- try -4 to -12



			-- Option A (recommended): wrap like the real Roblox prompt
			successText.TextWrapped = false
			successText.TextTruncate = Enum.TextTruncate.AtEnd

			-- Make the label span almost the full width of the panel
			successText.AnchorPoint = Vector2.new(0.5, 0)
			successText.Position = UDim2.new(0.5, 0, 0.55, -10)
			successText.Size = UDim2.new(1, -80, 0, 52) -- wider box, stays inside panel

			-- Optional: make sure it doesn't visually spill (extra safety)
			successPanel.ClipsDescendants = true
		end

						local okWrap = must(successPanel, "OK")
						local okButton = okWrap and must(okWrap, "BuyButton")
						-- Hover shading on Success OK bar (hover anywhere on the blue bar)
		do
			if okWrap and okWrap:IsA("Frame") then
				local TweenService = game:GetService("TweenService")

				okWrap.Active = true -- must be true for MouseEnter/Leave to fire

				local hoverTween, outTween
				local baseColor: Color3? = nil

				local tIn  = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				local tOut = TweenInfo.new(0.10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

				local function cancel()
					if hoverTween then pcall(function() hoverTween:Cancel() end) end
					if outTween then pcall(function() outTween:Cancel() end) end
					hoverTween, outTween = nil, nil
				end

				okWrap.MouseEnter:Connect(function()
					-- only hover-lighten when OK is usable
					if not (okButton and okButton.Active) then return end

					baseColor = okWrap.BackgroundColor3
					local lighter = baseColor:Lerp(Color3.new(1, 1, 1), 0.12)

					cancel()
					hoverTween = TweenService:Create(okWrap, tIn, { BackgroundColor3 = lighter })
					hoverTween:Play()
				end)

				okWrap.MouseLeave:Connect(function()
					if not baseColor then return end
					cancel()
					outTween = TweenService:Create(okWrap, tOut, { BackgroundColor3 = baseColor })
					outTween:Play()
				end)
			end
		end

						local testOpenBtn = gui:FindFirstChild("ImageButton")

						-- =========================
						-- ZIndex / overlay defaults
						-- =========================
						overlay.Visible = false
						overlay.Active = true
						overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
						overlay.BackgroundTransparency = 1
						overlay.ZIndex = 1

						panel.Visible = false
						panel.ZIndex = 10

						successPanel.Visible = false
						successPanel.ZIndex = 10

						for _, d in ipairs(panel:GetDescendants()) do
							if d:IsA("GuiObject") then
								d.ZIndex = 20
							end
						end
						for _, d in ipairs(successPanel:GetDescendants()) do
							if d:IsA("GuiObject") then
								d.ZIndex = 20
							end
						end
						if priceIcon then priceIcon.ZIndex = 25 end
						if balanceIcon then balanceIcon.ZIndex = 25 end

						-- =========================
						-- Close button style (×, not bold)
						-- =========================
						local function styleClose(btn)
							if not (btn and btn:IsA("TextButton")) then return end
							btn.Text = "×"
							btn.TextSize = 44
							btn.TextScaled = false
							btn.TextStrokeTransparency = 1
							btn.AutoButtonColor = false
							btn.BackgroundTransparency = 1
							btn.TextColor3 = Color3.fromRGB(235, 235, 235)

							pcall(function()
								btn.FontFace = Font.new(
									"rbxasset://fonts/families/GothamBold.json",
									Enum.FontWeight.Light,
									Enum.FontStyle.Normal
								)
							end)

							for _, ch in ipairs(btn:GetChildren()) do
								if ch:IsA("UIStroke") then
									ch.Enabled = false
								end
							end

							local corner = btn:FindFirstChildOfClass("UICorner") or Instance.new("UICorner")
							corner.CornerRadius = UDim.new(0, 10)
							corner.Parent = btn

							btn.MouseEnter:Connect(function()
								TweenService:Create(btn, TweenInfo.new(0.08), { BackgroundTransparency = 0.2 }):Play()
							end)
							btn.MouseLeave:Connect(function()
								TweenService:Create(btn, TweenInfo.new(0.08), { BackgroundTransparency = 1 }):Play()
							end)
						end

						styleClose(closeBtn)
						styleClose(successCloseBtn)

						-- =========================
						-- Item name behavior
						-- =========================
						local function fixItemNameBehavior()
							if not (itemNameText and itemNameText:IsA("TextLabel")) then return end
							itemNameText.TextXAlignment = Enum.TextXAlignment.Left
							itemNameText.TextWrapped = false
							pcall(function()
								itemNameText.TextTruncate = Enum.TextTruncate.AtEnd
							end)
						end
						fixItemNameBehavior()

						if itemNameText and itemNameText:IsA("TextLabel") then
							itemNameText:GetPropertyChangedSignal("Text"):Connect(function()
								fixItemNameBehavior()
							end)
						end

						-- =========================
						-- BalanceRow behavior (keeps icon + text attached)
						-- =========================
						local function fixBalanceRowBehavior()


							if not (balanceText and balanceIcon) then return end
							if not balanceText:IsA("TextLabel") then return end

							local row = balanceText.Parent
							if not row or not row:IsA("GuiObject") then return end

							local layout = row:FindFirstChildOfClass("UIListLayout")
							if layout then
								layout.FillDirection = Enum.FillDirection.Horizontal
								layout.SortOrder = Enum.SortOrder.LayoutOrder
								layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
								layout.VerticalAlignment = Enum.VerticalAlignment.Center
								layout.Padding = UDim.new(0, BALANCE_ICON_PADDING)
								-- move BalanceText up a bit (works even with UIListLayout)
								local pad = balanceText:FindFirstChildOfClass("UIPadding") or Instance.new("UIPadding")

								pad.Parent = balanceText

							end

							balanceIcon.LayoutOrder = 1
							balanceText.LayoutOrder = 2

							pcall(function()
								balanceText.AutomaticSize = Enum.AutomaticSize.X
							end)

							local y = balanceText.Size
							balanceText.Size = UDim2.new(0, 0, y.Y.Scale, y.Y.Offset)

							balanceText.TextWrapped = false
							balanceText.TextXAlignment = Enum.TextXAlignment.Right
							balanceText.TextScaled = false
						end

						fixBalanceRowBehavior()
						if balanceText and balanceText:IsA("TextLabel") then
							balanceText:GetPropertyChangedSignal("Text"):Connect(fixBalanceRowBehavior)
						end

						-- =========================
						-- Icons
						-- =========================
						forceIcon(balanceIcon)
						forceIcon(priceIcon)

						-- =========================
						-- Prompt state
						-- =========================
						local currentPrice = 0
						local currentBalance = 57
						local currentItemName = ""
						local currentOwnerUsername = ""
						local currentIsOffline = false

						local lastPurchaseAmount = nil
						local lastPurchaseOwner = ""
						local lastPurchaseIsOffline = false

						local isOpen = false
						local isBuying = false
						local showingSuccess = false
						local buyActionId = 0

						local overlayTween, panelTween, fillTween
						local fillRequestId = 0 -- guards delayed fill-starts

						local successTemplate = (successText and successText:IsA("TextLabel") and successText.Text) or "You have succesfully bought {ITEM}."

						local function makeSuccessText(itemName)
							itemName = sanitizeSingleLine(itemName)
							if successTemplate:find(SUCCESS_PLACEHOLDER, 1, true) then
								return (successTemplate:gsub(SUCCESS_PLACEHOLDER, itemName))
							end

							local prefix, _, suffix = successTemplate:match("^(.-bought%s+)(.-)([%.%!%?]?)%s*$")
							if prefix then
								suffix = (suffix ~= "" and suffix) or "."
								return prefix .. itemName .. suffix
							end

							return ("You have succesfully bought %s."):format(itemName)
						end

						local function cancelTweens()
							if overlayTween then pcall(function() overlayTween:Cancel() end) end
							if panelTween then pcall(function() panelTween:Cancel() end) end
							if fillTween then pcall(function() fillTween:Cancel() end) end
							overlayTween, panelTween, fillTween = nil, nil, nil
						end

						local function prepFill()
							if not fill or not fill:IsA("Frame") then return end
							fill.AnchorPoint = Vector2.new(0, 0)
							fill.Position = UDim2.new(0, 0, 0, 0)
							fill.ClipsDescendants = true
						end
						prepFill()

				local RunService = game:GetService("RunService")

				local fillConn: RBXScriptConnection? = nil
				local fillRequestId = 0

				local function stopFill()
					if fillConn then
						fillConn:Disconnect()
						fillConn = nil
					end
				end

				local function setFillAlpha(alpha: number)
					alpha = math.clamp(alpha, 0, 1)
					-- keep Y full, only X grows
					fill.Size = UDim2.new(alpha, 0, 1, 0)
				end

				local function setBuyLoading()
					if not buyWrap or not fill or not buyButton then return end

					fillRequestId += 1
					local thisId = fillRequestId

					stopFill()

					-- IMPORTANT: clip at the PARENT, not the fill itself
					buyWrap.ClipsDescendants = true

					buyButton.Active = false
					buyButton.AutoButtonColor = false

					-- normal background while loading
					buyWrap.BackgroundColor3 = Color3.fromRGB(30, 54, 120)

					-- hard reset (no chance to show full width)
					fill.Visible = false
					fill.Position = UDim2.new(0, 0, 0, 0)
					fill.AnchorPoint = Vector2.new(0, 0)
					setFillAlpha(0)

					task.delay(FILL_START_DELAY, function()
						-- only start if still valid
						if thisId ~= fillRequestId then return end
						if not isOpen or isBuying or showingSuccess then return end

						fill.Visible = true
						setFillAlpha(0)

						local startT = os.clock()
						local dur = FILL_SECONDS

						fillConn = RunService.RenderStepped:Connect(function()
							if thisId ~= fillRequestId then
								stopFill()
								return
							end
							if not isOpen or isBuying or showingSuccess then
								stopFill()
								return
							end

							local t = (os.clock() - startT) / dur
							if t >= 1 then
								setFillAlpha(1)
								stopFill()

								-- finish -> enable buy
								fill.Visible = false
								buyWrap.BackgroundColor3 = Color3.fromRGB(52, 92, 255)
								buyButton.Active = true
								return
							end

							setFillAlpha(t)
						end)
					end)
				end

				local function setBuyProcessingShade()
					if not buyWrap or not buyButton or not fill then return end
					fillRequestId += 1
					stopFill()

					fill.Visible = false
					setFillAlpha(0)

					buyWrap.BackgroundColor3 = Color3.fromRGB(30, 54, 120)
					buyButton.Active = false
					buyButton.AutoButtonColor = false
				end


						local function setBuyProcessingShade()
							if not buyWrap or not buyButton or not fill then return end
							fillRequestId += 1
							if fillTween then pcall(function() fillTween:Cancel() end) end

							fill.Visible = false
							buyWrap.BackgroundColor3 = Color3.fromRGB(30, 54, 120)
							buyButton.Active = false
							buyButton.AutoButtonColor = false
						end

						local function openOverlayFade()
							overlay.Visible = true
							overlay.BackgroundTransparency = 1
							cancelTweens()
							overlayTween = TweenService:Create(overlay, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
								BackgroundTransparency = OVERLAY_TARGET_TRANSPARENCY
							})
							overlayTween:Play()
						end

						local function openPrompt(data)
							showingSuccess = false
							isOpen = true
							isBuying = false
							data = (typeof(data) == "table") and data or {}

							currentOwnerUsername = tostring(data.ownerUsername or "")
							currentIsOffline = data.isOffline == true

							if data.name ~= nil and itemNameText then
								currentItemName = sanitizeSingleLine(data.name)
											itemNameText.Text = currentItemName
							end
							if data.price ~= nil and priceText then
								local p = parseNumberText(data.price)
								if p ~= nil then
									currentPrice = p
									priceText.Text = formatWithCommas(p)
								else
									priceText.Text = tostring(data.price)
								end
							end

							if data.balance ~= nil and balanceText then
								local b = parseNumberText(data.balance)
								if b ~= nil then
									currentBalance = b
									balanceText.Text = formatWithCommas(currentBalance)
								else
									balanceText.Text = tostring(data.balance)
								end
							end

							if data.image ~= nil and itemImage and (itemImage:IsA("ImageLabel") or itemImage:IsA("ImageButton")) then
								itemImage.Image = tostring(data.image)
								itemImage.Visible = true
								itemImage.ImageTransparency = 0
							end

							currentPrice = parseNumberText(priceText and priceText.Text) or 0
							currentBalance = parseNumberText(balanceText and balanceText.Text) or currentBalance

							if balanceText then
								balanceText.Text = formatWithCommas(currentBalance)
							end

							forceIcon(balanceIcon)
							forceIcon(priceIcon)

							fixItemNameBehavior()
							fixBalanceRowBehavior()

							successPanel.Visible = false
							openOverlayFade()

							if not USE_STUDIO_LAYOUT then
								panel.AnchorPoint = Vector2.new(0.5, 0.5)
								panel.Position = UDim2.fromScale(0.5, 0.56)
							end

							flyIn(panel)

							if not USE_STUDIO_LAYOUT then
								panelTween = TweenService:Create(panel, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									Position = UDim2.fromScale(0.5, 0.5)
								})
								panelTween:Play()
							end

							setBuyLoading()
						end

						local function closeAllInstant()
							isOpen = false
							isBuying = false
							showingSuccess = false
							buyActionId += 1

							cancelTweens()

							overlay.BackgroundTransparency = 1
							panel.Visible = false
							successPanel.Visible = false
							overlay.Visible = false
						end

						local function openSuccess(itemName)
							isOpen = false
							isBuying = false
							showingSuccess = true

							panel.Visible = false
							openOverlayFade()

							if successText and successText:IsA("TextLabel") then
								successText.Text = makeSuccessText(itemName)
							end
							syncSuccessToPanel()
							flyIn(successPanel)
						end

						-- close buttons
						if closeBtn and closeBtn:IsA("TextButton") then
							closeBtn.Activated:Connect(closeAllInstant)
						end
						if successCloseBtn and successCloseBtn:IsA("TextButton") then
							successCloseBtn.Activated:Connect(closeAllInstant)
						end

						-- OK button: close + OFFLINE->GiftPopupDupe, ONLINE->DonationToast
					-- OK button: close + OFFLINE->GiftPopupDupe, ONLINE->DonationToast
					if okButton and okButton:IsA("TextButton") then
						okButton.Activated:Connect(function()
							closeAllInstant()

							local amt = lastPurchaseAmount
							local owner = tostring(lastPurchaseOwner or "")
							local wasOffline = lastPurchaseIsOffline == true

							-- NEW: after OK, wait 1s then increase "Raised" by amt (OFFLINE only for now)
							task.delay(1, function()
								if wasOffline and amt and amt > 0 then
									local raisedLabel = tryGetOfflineRaisedLabel(playerGui)
									if raisedLabel then
										raisedLabel.Text = addToRaisedTextKeepDecor(raisedLabel.Text, amt)
									end
								end
							end)

							-- existing behavior
task.delay(0.8, function()
	if not (amt and amt > 0) then return end

	-- OFFLINE: show the "sent gift!" popup (this includes the sound inside your EnsureGiftPopupDupe)
	if wasOffline and _G.ShowGiftPopupDupe then
		_G.ShowGiftPopupDupe()
	end

	-- Decide username for the green toast
	if wasOffline and (owner == nil or owner == "") then
		owner = getOfflineOwnerUsername(playerGui) -- from the helper you added
	end

	local amountText = formatWithCommas(amt)
	local userText = tostring(owner or "")

	if userText == "" then
		userText = "@offline"
	elseif not userText:match("^@") then
		userText = "@" .. userText
	end

	-- Show the same green popup for offline too
	showDonationToast(amountText, userText)
end)


						end)
					end


						if buyButton and buyButton:IsA("TextButton") then
							buyButton.Activated:Connect(function()
								if not isOpen or isBuying or showingSuccess then return end
								isBuying = true
								setBuyProcessingShade()

								buyActionId += 1
								local thisId = buyActionId
								local boughtName = currentItemName

								task.delay(BUY_PROCESS_SECONDS, function()
									if thisId ~= buyActionId then return end

									local canAfford = (currentPrice > 0 and currentBalance >= currentPrice)

									if canAfford then
										currentBalance -= currentPrice
										if balanceText then
											balanceText.Text = formatWithCommas(currentBalance)
										end
										fixBalanceRowBehavior()
									end

									if canAfford then
										-- save info for OK button
										lastPurchaseAmount = currentPrice
										lastPurchaseOwner = tostring(currentOwnerUsername or "")
										lastPurchaseIsOffline = currentIsOffline

										openSuccess(boughtName)
									else
										closeAllInstant()
									end

									isBuying = false
								end)
							end)
						end

						-- Optional: click ImageButton to test open/close
						if testOpenBtn and testOpenBtn:IsA("GuiButton") then
							testOpenBtn.Activated:Connect(function()
								if overlay.Visible then
									closeAllInstant()
								else
									openPrompt({
										name = currentItemName ~= "" and currentItemName or "Test Item",
										price = currentPrice ~= 0 and currentPrice or 500,
										balance = parseNumberText(balanceText and balanceText.Text) or currentBalance,
										ownerUsername = "",
										isOffline = false,
									})
								end
							end)
						end

						-- =========================
						-- BindableEvent API
						-- =========================
						local openEvent = gui:FindFirstChild("OpenPrompt") or Instance.new("BindableEvent")
						openEvent.Name = "OpenPrompt"
						openEvent.Parent = gui

						local closeEvent = gui:FindFirstChild("ClosePrompt") or Instance.new("BindableEvent")
						closeEvent.Name = "ClosePrompt"
						closeEvent.Parent = gui

						local successOpenEvent = gui:FindFirstChild("OpenSuccess") or Instance.new("BindableEvent")
						successOpenEvent.Name = "OpenSuccess"
						successOpenEvent.Parent = gui

						local successCloseEvent = gui:FindFirstChild("CloseSuccess") or Instance.new("BindableEvent")
						successCloseEvent.Name = "CloseSuccess"
						successCloseEvent.Parent = gui

						-- UPDATED: accepts ownerUsername as 5th param, isOffline as 6th
						openEvent.Event:Connect(function(name, price, image, balance, ownerUsername, isOffline)
							openPrompt({
								name = name,
								price = price,
								image = image,
								balance = balance,
								ownerUsername = ownerUsername,
								isOffline = isOffline == true,
							})
						end)

						closeEvent.Event:Connect(closeAllInstant)

						successOpenEvent.Event:Connect(function(itemName)
							openSuccess(itemName)
						end)

						successCloseEvent.Event:Connect(closeAllInstant)

						closeAllInstant()

						-- =========================
						-- DEBUG PRELOAD
						-- =========================
						local function debugPreload(img)
							if not img or not (img:IsA("ImageLabel") or img:IsA("ImageButton")) then
								return
							end
							ContentProvider:PreloadAsync({ img })
						end

						task.defer(function()
							debugPreload(balanceIcon)
							debugPreload(priceIcon)
						end)
					end

					-- =========================================================
					-- BoothDetector + CustomBuyPrompt (FINAL.rbxmx UI + controller + success)
					-- LocalScript / run client-side
					-- =========================================================

					local Players = game:GetService("Players")

					if _G.BoothBuyPromptDetector then
						_G.BoothBuyPromptDetector:Destroy()
					end

					local detector = {}
					_G.BoothBuyPromptDetector = detector

					local GuiService = game:GetService("GuiService")
					local UIS = game:GetService("UserInputService")

					local player = Players.LocalPlayer
					local playerGui = player:WaitForChild("PlayerGui")

					-- =========================================================
					-- Build prompt UI + attach controller
					-- =========================================================
					local gui = CreateCustomBuyPrompt(playerGui)
					AttachCustomBuyPromptController(gui)

					local openEvent = gui:WaitForChild("OpenPrompt")
					local closeEvent = gui:WaitForChild("ClosePrompt")

					-- ignore clicks inside our custom UI so it doesn't retrigger detection
					local function isInCustomPrompt(inst)
						while inst do
							if inst == gui then return true end
							inst = inst.Parent
						end
						return false
					end

					-- =========================================================
					-- Data helpers (thumbnail + balance)
					-- =========================================================
					local function thumbFrom(item)
						local assetImage = item:GetAttribute("AssetImage")
						if assetImage and assetImage ~= "" then
							return tostring(assetImage)
						end

						local assetId = item:GetAttribute("AssetId")
						local assetType = tostring(item:GetAttribute("AssetType") or item:GetAttribute("InfoType") or ""):lower()

						if assetId then
							if assetType == "gamepass" then
								return ("rbxthumb://type=GamePass&id=%s&w=150&h=150"):format(tostring(assetId))
							else
								return ("rbxthumb://type=Asset&id=%s&w=150&h=150"):format(tostring(assetId))
							end
						end

						return ""
					end

					local function getBalanceMaybe()
						local attrCandidates = { "Robux", "R$", "Rbx", "Balance", "Currency", "Coins", "Money", "Cash" }
						for _, a in ipairs(attrCandidates) do
							local v = player:GetAttribute(a)
							if type(v) == "number" then
								return v
							end
						end

						local ls = player:FindFirstChild("leaderstats")
						if ls then
							local statCandidates = { "Robux", "R$", "Rbx", "Balance", "Currency", "Coins", "Money", "Cash" }
							for _, n in ipairs(statCandidates) do
								local obj = ls:FindFirstChild(n)
								if obj and (obj:IsA("IntValue") or obj:IsA("NumberValue")) then
									return obj.Value
								end
							end
						end

						return nil
					end

					-- =========================================================
					-- Booth owner username helper (ONLINE ONLY)
					-- =========================================================
					local function parseBoothOwnerText(txt)
						txt = tostring(txt or "")
						txt = txt:gsub("<[^>]->", "")
						txt = txt:gsub("^%s+", ""):gsub("%s+$", "")
						txt = txt:gsub("^[^%w_]+", "")
						txt = txt:gsub("^%s+", ""):gsub("%s+$", "")

						local u = txt:match("^(.-)%s*'s%s+stand")
						if u and u ~= "" then
							return u
						end

						return txt
					end

					local function ownerFromItem(item)
						local attrCandidates = { "Owner", "OwnerName", "BoothOwner", "Creator", "CreatorName" }
						for _, a in ipairs(attrCandidates) do
							local v = item:GetAttribute(a)
							if type(v) == "string" and v ~= "" then
								return v
							end
						end

						local inst = item
						while inst do
							if inst.Name:match("^BoothUI%d+$") then
								local details = inst:FindFirstChild("Details", true)
								local ownerLabel = details and details:FindFirstChild("Owner", true)
								if ownerLabel and ownerLabel:IsA("TextLabel") then
									return parseBoothOwnerText(ownerLabel.Text)
								end
								break
							end
							inst = inst.Parent
						end

						return nil
					end

					-- =========================================================
					-- =========================================================
					-- Prompt stripping (DESTROY) + optional placeholder
					-- =========================================================
					local KEEP_PROMPT_PLACEHOLDER = false -- set false if you truly want it gone
					local DUMMY_ATTR = "__CustomPromptDummy"

					local function stripScriptsUnder(root)
						for _, d in ipairs(root:GetDescendants()) do
							if d:IsA("LocalScript") or d:IsA("Script") then
								pcall(function() d:Destroy() end)
							end
						end
					end

					local function makePromptPlaceholder(item)
						if not KEEP_PROMPT_PLACEHOLDER then return end
						if item:FindFirstChild("Prompt") then return end

						local dummy = Instance.new("Frame")
						dummy.Name = "Prompt"
						dummy:SetAttribute(DUMMY_ATTR, true)
						dummy.BackgroundTransparency = 1
						dummy.Visible = false
						dummy.Active = false
						dummy.Size = UDim2.new(0, 0, 0, 0)
						dummy.Parent = item
					end

					local function destroyPromptObject(obj)
						if not obj then return end
						if obj:GetAttribute(DUMMY_ATTR) then return end -- don't delete our own placeholder
						pcall(function()
							stripScriptsUnder(obj)
						end)
						pcall(function()
							obj:Destroy()
						end)
					end

					local function stripPromptFromItem(item)
						if not item or not item.Name:match("^Item%d+$") then return end

						-- destroy direct Prompt
						destroyPromptObject(item:FindFirstChild("Prompt"))

						-- destroy any nested Prompts
						for _, d in ipairs(item:GetDescendants()) do
							if d.Name == "Prompt" then
								destroyPromptObject(d)
							end
						end

						-- re-add dummy Prompt if you want to stop other scripts erroring on Item.Prompt
						makePromptPlaceholder(item)
					end


					-- =========================================================
					-- Show prompt for an item
					-- =========================================================
					local showingToken = 0
					local function showPromptForItem(item, isOffline)
						showingToken += 1
						local myToken = showingToken

						task.delay(0.5, function()
							if myToken ~= showingToken then return end

							local name = item:GetAttribute("AssetName") or item.Name
							local price = item:GetAttribute("AssetPrice") or item:GetAttribute("Price") or 0
							local image = thumbFrom(item)
							local balance = getBalanceMaybe()

							local ownerUsername = ""
							if not isOffline then
								ownerUsername = ownerFromItem(item) or ""
							end

							openEvent:Fire(name, price, image, balance, ownerUsername, isOffline == true)
						end)
					end

					-- =========================================================
					-- DETECTOR (online + offline roots)
					-- =========================================================
					local attached = {}
					local btnConns = {}
					local rootConns = {}

					local function disconnectBtn(inst)
						local c = btnConns[inst]
						if c then
							c:Disconnect()
							btnConns[inst] = nil
						end
					end

					function detector:Destroy()
						for inst, _ in pairs(btnConns) do
							disconnectBtn(inst)
						end
						for _, c in ipairs(rootConns) do
							pcall(function() c:Disconnect() end)
						end

						for obj, conn in pairs(promptLocks) do
							pcall(function() conn:Disconnect() end)
							promptLocks[obj] = nil
						end

						pcall(function() closeEvent:Fire() end)
						pcall(function() gui:Destroy() end)

						table.clear(attached)
						table.clear(btnConns)
						table.clear(rootConns)
					end

					local function findItem(inst, stopAt)
						while inst and inst ~= stopAt do
							if inst.Name:match("^Item%d+$") then
								return inst
							end
							inst = inst.Parent
						end
						return nil
					end

					local function hookIfClickable(root, inst, isOffline)
						if not inst:IsA("GuiButton") then return end
						if btnConns[inst] then return end
						if not findItem(inst, root) then return end

						btnConns[inst] = inst.Activated:Connect(function()
							if isInCustomPrompt(inst) then return end
							local item = findItem(inst, root)
							if item then
								showPromptForItem(item, isOffline == true)
							end
						end)
					end

					local function attachRoot(root, isOffline)
						if not root or attached[root] then return end
						attached[root] = true

						for _, d in ipairs(root:GetDescendants()) do
							if d.Name:match("^Item%d+$") then
								stripPromptFromItem(d)
							end
							hookIfClickable(root, d, isOffline == true)
						end

						table.insert(rootConns, root.DescendantAdded:Connect(function(inst)
							if inst.Name:match("^Item%d+$") then
								stripPromptFromItem(inst)
									elseif inst.Name == "Prompt" then
						-- ignore our own placeholder, otherwise we'd loop
										if inst:GetAttribute(DUMMY_ATTR) then return end

										local item = findItem(inst, root)
										if item then
							stripPromptFromItem(item)
										end
									end


							hookIfClickable(root, inst, isOffline == true)
						end))

						table.insert(rootConns, root.DescendantRemoving:Connect(function(inst)
							disconnectBtn(inst)
						end))
					end

					local function tryAttachOnline()
						local c = playerGui:FindFirstChild("MapUIContainer")
						if not c then return end
						local m = c:FindFirstChild("MapUI")
						if not m then return end
						local boothRoot = m:FindFirstChild("BoothUI")
						if boothRoot then
							attachRoot(boothRoot, false) -- online
						end
					end

					local function tryAttachOffline()
						local boothRoot = playerGui:FindFirstChild("BoothUI")
						if boothRoot then
							attachRoot(boothRoot, true) -- offline
						end
					end

					tryAttachOnline()
					tryAttachOffline()

					table.insert(rootConns, playerGui.DescendantAdded:Connect(function(inst)
						if inst.Name == "MapUIContainer" or inst.Name == "MapUI" or inst.Name == "BoothUI" then
							task.defer(function()
								tryAttachOnline()
								tryAttachOffline()
							end)
						end
					end))

					-- Fallback click detection for cases where the clickable isn't a GuiButton
					table.insert(rootConns, UIS.InputBegan:Connect(function(input, gameProcessed)
						if gameProcessed then return end
						if input.UserInputType ~= Enum.UserInputType.MouseButton1
							and input.UserInputType ~= Enum.UserInputType.Touch then
							return
						end

						local pos = UIS:GetMouseLocation()
						local guiList = GuiService:GetGuiObjectsAtPosition(pos.X, pos.Y)

						for _, obj in ipairs(guiList) do
							if isInCustomPrompt(obj) then
								return
							end

							local onlineRoot = playerGui:FindFirstChild("MapUIContainer")
								and playerGui.MapUIContainer:FindFirstChild("MapUI")
								and playerGui.MapUIContainer.MapUI:FindFirstChild("BoothUI")

							if onlineRoot then
								local item = findItem(obj, onlineRoot)
								if item then
									showPromptForItem(item, false)
									return
								end
							end

							local offlineRoot = playerGui:FindFirstChild("BoothUI")
							if offlineRoot then
								local item = findItem(obj, offlineRoot)
								if item then
									showPromptForItem(item, true)
									return
								end
							end
						end
					end))

					print("[BoothDetector+CustomBuyPrompt] Running (FINAL.rbxmx UI). Default prompts locked; custom UI + success + ONLINE donation toast + OFFLINE gift popup enabled.")

                               -- FAKE USER BY HTEGITO --
							   -- FAKE USER BY HTEGITO --
							   -- FAKE USER BY HTEGITO --

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local FAKE_NAME = "filteredasync"

local function changeName()
    local character = workspace:FindFirstChild(LocalPlayer.Name)
    if not character then return end
    
    local head = character:FindFirstChild("Head")
    if not head then return end
    
    local headtag = head:FindFirstChild("HeadTag")
    if not headtag then return end
    
    local display = headtag:FindFirstChild("Display")
    if display and display:IsA("TextLabel") then
        display.Text = FAKE_NAME
    end
end

-- run 
changeName()

-- Keep forcing it (in case game refreshes it)

                                        -- FAKE ROLE BY HTEGITO --
										-- FAKE ROLE BY HTEGITO --
										-- FAKE ROLE BY HTEGITO --

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local FAKE_ROLE = "TOP 22"  -- change this to whatever you want
local ROLE_COLORBG = Color3.fromRGB(235, 235, 0) -- nice blue
local ROLE_COLOR = Color3.fromRGB(255, 255, 255)   -- white

local function changeRole()
    local character = workspace:FindFirstChild(LocalPlayer.Name)
    if not character then return end
    
    local head = character:FindFirstChild("Head")
    if not head then return end
    
    local headtag = head:FindFirstChild("HeadTag")
    if not headtag then return end
    
    local roleLabel = headtag:FindFirstChild("Role")
    if roleLabel and roleLabel:IsA("TextLabel") then
        roleLabel.Text = FAKE_ROLE
        roleLabel.BackgroundColor3 = ROLE_COLORBG
		roleLabel.TextColor3 = ROLE_COLOR
    end
end

-- Run 
changeRole()






 
