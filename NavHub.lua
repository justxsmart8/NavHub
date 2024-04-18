-- Function to create and display the GUI
local function CreateGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 300, 0, 200)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Dark grey
    Frame.BorderSizePixel = 2
    Frame.BorderColor3 = Color3.new(0, 0, 0) -- Black border
    Frame.Parent = ScreenGui
    Frame.Active = true

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 30)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Dark grey
    TitleLabel.BorderSizePixel = 0
    TitleLabel.TextColor3 = Color3.new(1, 1, 1)
    TitleLabel.Text = "NavHub"
    TitleLabel.FontSize = Enum.FontSize.Size24
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Parent = Frame

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Position = UDim2.new(1, -25, 0, 5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- Grey
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.new(1, 1, 1)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = Frame

    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0.8, 0, 0, 30)
    TextBox.Position = UDim2.new(0.1, 0, 0.2, 0)
    TextBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70) -- Grey
    TextBox.BorderSizePixel = 0
    TextBox.Parent = Frame
    TextBox.FontSize = Enum.FontSize.Size18
    TextBox.Font = Enum.Font.GothamBold
    TextBox.PlaceholderText = "Enter Key..." -- Changed placeholder text
    TextBox.TextColor3 = Color3.new(1, 1, 1)

    local GetKeyButton = Instance.new("TextButton")
    GetKeyButton.Size = UDim2.new(0.4, 0, 0, 30)
    GetKeyButton.Position = UDim2.new(0.1, 0, 0.4, 0)
    GetKeyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Darker grey
    GetKeyButton.BorderSizePixel = 0
    GetKeyButton.Text = "Get Key"
    GetKeyButton.TextColor3 = Color3.new(1, 1, 1)
    GetKeyButton.Font = Enum.Font.GothamBold
    GetKeyButton.Parent = Frame

    local CheckKeyButton = Instance.new("TextButton")
    CheckKeyButton.Size = UDim2.new(0.4, 0, 0, 30)
    CheckKeyButton.Position = UDim2.new(0.5, 0, 0.4, 0)
    CheckKeyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Darker grey
    CheckKeyButton.BorderSizePixel = 0
    CheckKeyButton.Text = "Check Key"
    CheckKeyButton.TextColor3 = Color3.new(1, 1, 1)
    CheckKeyButton.Font = Enum.Font.GothamBold
    CheckKeyButton.Parent = Frame

    local MessageLabel = Instance.new("TextLabel")
    MessageLabel.Size = UDim2.new(0, 200, 0, 20)
    MessageLabel.Position = UDim2.new(0.5, -100, 0.7, 0)
    MessageLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Dark grey
    MessageLabel.BorderSizePixel = 0
    MessageLabel.TextColor3 = Color3.new(1, 1, 1)
    MessageLabel.Text = ""
    MessageLabel.FontSize = Enum.FontSize.Size14
    MessageLabel.Font = Enum.Font.GothamBold
    MessageLabel.Parent = Frame

    -- Event handler for the Close button
    CloseButton.MouseButton1Click:Connect(function()
        Frame:Destroy()
    end)

    -- Event handler for the Get Key button
    GetKeyButton.MouseButton1Click:Connect(function()
        setclipboard("https://work.ink/49a/lv4lcqde") -- Copy the key link to the clipboard
        MessageLabel.Text = "Link Copied to Clipboard"
        wait(2)
        MessageLabel.Text = ""
    end)

    -- Event handler for the Check Key button
    local function CheckKey()
        local enteredKey = TextBox.Text
        if enteredKey == "dog" then
            Frame:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/NavilanSanthanakrishnan/dahood/main/NavAutoFarm.lua"))()
        else
            MessageLabel.Text = "Invalid Key!"
            wait(2)
            MessageLabel.Text = ""
        end
    end

    CheckKeyButton.MouseButton1Click:Connect(CheckKey)

    -- Dragging functionality
    local dragging
    local dragInput
    local dragStart
    local startPos

    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Create and display the GUI
CreateGUI()
