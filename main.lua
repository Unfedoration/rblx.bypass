-- Create Screen GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyButton = Instance.new("TextButton")
local WalkspeedSlider = Instance.new("TextBox")
local JumpPowerSlider = Instance.new("TextBox")
local GravitySlider = Instance.new("TextBox")
local SprintButton = Instance.new("TextButton")
local NoclipButton = Instance.new("TextButton")
local InvisibleButton = Instance.new("TextButton")
local SaveConfigButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

-- Parent the GUI to the player's PlayerGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "CustomUI"

-- UI setup with modern clean look
local function setProperties(object, size, pos, bgColor, text, textColor, rounded, fontSize)
    object.Size = size
    object.Position = pos
    object.BackgroundColor3 = bgColor
    object.Text = text
    object.TextColor3 = textColor
    object.Font = Enum.Font.GothamBold
    object.TextSize = fontSize or 16
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, rounded)
    corner.Parent = object
end

-- Setup the MainFrame (draggable window)
MainFrame.Parent = ScreenGui
setProperties(MainFrame, UDim2.new(0, 350, 0, 500), UDim2.new(0.5, -175, 0.5, -250), Color3.new(0.15, 0.15, 0.15), "", Color3.new(1, 1, 1), 10)
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Selectable = true

-- Title for the menu
Title.Parent = MainFrame
setProperties(Title, UDim2.new(0.8, 0, 0.1, 0), UDim2.new(0.1, 0, 0.02, 0), Color3.new(0.1, 0.1, 0.1), "Player Tools", Color3.new(1, 1, 1), 10, 22)

-- Fly Button
FlyButton.Parent = MainFrame
setProperties(FlyButton, UDim2.new(0.7, 0, 0.07, 0), UDim2.new(0.15, 0, 0.15, 0), Color3.new(0, 0.5, 1), "Toggle Fly", Color3.new(1, 1, 1), 10)

-- Walkspeed Slider Input
WalkspeedSlider.Parent = MainFrame
setProperties(WalkspeedSlider, UDim2.new(0.7, 0, 0.07, 0), UDim2.new(0.15, 0, 0.25, 0), Color3.new(0.3, 0.3, 0.3), "Walkspeed (default: 16)", Color3.new(1, 1, 1), 10)

-- JumpPower Slider Input
JumpPowerSlider.Parent = MainFrame
setProperties(JumpPowerSlider, UDim2.new(0.7, 0, 0.07, 0), UDim2.new(0.15, 0, 0.35, 0), Color3.new(0.3, 0.3, 0.3), "JumpPower (default: 50)", Color3.new(1, 1, 1), 10)

-- Gravity Slider Input
GravitySlider.Parent = MainFrame
setProperties(GravitySlider, UDim2.new(0.7, 0, 0.07, 0), UDim2.new(0.15, 0, 0.45, 0), Color3.new(0.3, 0.3, 0.3), "Gravity (default: 196.2)", Color3.new(1, 1, 1), 10)

-- Sprint Button
SprintButton.Parent = MainFrame
setProperties(SprintButton, UDim2.new(0.7, 0, 0.07, 0), UDim2.new(0.15, 0, 0.55, 0), Color3.new(0, 0.5, 0.5), "Toggle Sprint", Color3.new(1, 1, 1), 10)

-- Noclip Button
NoclipButton.Parent = MainFrame
setProperties(NoclipButton, UDim2.new(0.7, 0, 0.07, 0), UDim2.new(0.15, 0, 0.65, 0), Color3.new(0.5, 0.1, 0.1), "Toggle Noclip", Color3.new(1, 1, 1), 10)

-- Invisible Button
InvisibleButton.Parent = MainFrame
setProperties(InvisibleButton, UDim2.new(0.7, 0, 0.07, 0), UDim2.new(0.15, 0, 0.75, 0), Color3.new(0.2, 0.2, 0.2), "Toggle Invisible", Color3.new(1, 1, 1), 10)

-- Save Config Button
SaveConfigButton.Parent = MainFrame
setProperties(SaveConfigButton, UDim2.new(0.7, 0, 0.07, 0), UDim2.new(0.15, 0, 0.85, 0), Color3.new(0, 1, 0), "Save Config", Color3.new(1, 1, 1), 10)

-- Close Button (X button)
CloseButton.Parent = MainFrame
setProperties(CloseButton, UDim2.new(0.1, 0, 0.07, 0), UDim2.new(0.85, 0, 0.02, 0), Color3.new(1, 0, 0), "X", Color3.new(1, 1, 1), 10)

-- Close GUI Functionality
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Fly variables
local flying = false
local flySpeed = 50

-- Function to start flying
function startFlying()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoid = character:WaitForChild("Humanoid")
    local bodyVelocity = Instance.new("BodyVelocity", character.PrimaryPart)
    bodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)

    flying = true
    game:GetService("RunService").RenderStepped:Connect(function()
        if flying then
            bodyVelocity.Velocity = character.PrimaryPart.CFrame.LookVector * flySpeed
        else
            bodyVelocity:Destroy()
        end
    end)
end

-- Function to stop flying
function stopFlying()
    flying = false
end

-- Toggle Fly Button functionality
FlyButton.MouseButton1Click:Connect(function()
    if flying then
        stopFlying()
        FlyButton.Text = "Toggle Fly"
    else
        startFlying()
        FlyButton.Text = "Stop Flying"
    end
end)

-- Walkspeed functionality
WalkspeedSlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local inputSpeed = tonumber(WalkspeedSlider.Text)
        if inputSpeed then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = inputSpeed
        else
            warn("Invalid walkspeed value")
        end
    end
end)

-- JumpPower functionality
JumpPowerSlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local inputJumpPower = tonumber(JumpPowerSlider.Text)
        if inputJumpPower then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = inputJumpPower
        else
            warn("Invalid jumppower value")
        end
    end
end)

-- Gravity functionality
GravitySlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local inputGravity = tonumber(GravitySlider.Text)
        if inputGravity then
            game.Workspace.Gravity = inputGravity
        else
            warn("Invalid gravity value")
        end
    end
end)

-- Sprint Toggle
local sprinting = false
SprintButton.MouseButton1Click:Connect(function()
    sprinting = not sprinting
    if sprinting then
        SprintButton.Text = "Stop Sprinting"
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 60
    else
        SprintButton.Text = "Toggle Sprint"
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

-- Save Config Functionality (dummy example)
SaveConfigButton.MouseButton1Click:Connect(function()
    -- Save configuration to a file or datastore (Not implemented in this example)
    print("Configuration Saved!")
end)
