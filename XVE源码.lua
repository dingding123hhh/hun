local XVE = {}

local CORE_GUI = game:FindFirstChild('CoreGui') or game:GetService('Players').LocalPlayer.PlayerGui
local TWEEN_SERVICE = game:GetService('TweenService')
local USERINPUT_SERVICE = game:GetService('UserInputService')
local TEXT_SERVICE = game:GetService('TextService')

local function ConnectButtonEffect(UIFrame:Frame&TextButton&ImageLabel,UIStroke:UIStroke,int)
	if not UIStroke then
		return
	end

	int = int or 0.2
	local OldColor = UIStroke.Color
	local R,G,B = OldColor.R,OldColor.G,OldColor.B
	local MainColor = Color3.fromHSV(R,G,B + int)

	UIFrame.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseMovement then
			TWEEN_SERVICE:Create(UIStroke,TweenInfo.new(0.2),{Color = MainColor}):Play()
		end
	end)

	UIFrame.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseMovement then
			TWEEN_SERVICE:Create(UIStroke,TweenInfo.new(0.2),{Color = OldColor}):Play()
		end
	end)
end

local function OffsetToScale(Offset)
	local ViewPortSize = workspace.Camera.ViewportSize
	return {Offset[1] / ViewPortSize.X, Offset[2] / ViewPortSize.Y}
end

function XVE:Window(WindowName)
	WindowName = WindowName or "XVE"
	local XVEWindow = {}
	local Tabs = {}
	local Dbg_can_move = true
	local UI_VALUE = true

	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local DropShadow = Instance.new("ImageLabel")
	local Frame_2 = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local Tab_collect = Instance.new("Frame")
	local UIStroke = Instance.new("UIStroke")
	local UICorner = Instance.new("UICorner")
	local ScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local Tab_Frame_collect = Instance.new("Frame")
	local UIStroke_2 = Instance.new("UIStroke")
	local UICorner_2 = Instance.new("UICorner")
	local HeaderTitle = Instance.new("TextLabel")
	
	XVEWindow.Version = 5
	XVEWindow.StartTime = workspace:GetServerTimeNow()
	
	UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		ScrollingFrame.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y)
	end)

	local function SaveTran()
		for i,v : Frame? |ImageLabel? |TextLabel? |TextButton? |TextBox? |UIStroke? in ipairs(Frame:GetDescendants()) do
			if v:isA('Frame') then
				if not v:GetAttribute('MainTran') then
					v:SetAttribute("MainTran",v.BackgroundTransparency)
				end
			end

			if v:isA('ImageLabel') then
				if not v:GetAttribute('MainTran') then
					v:SetAttribute("MainTran",v.ImageTransparency)
				end
			end

			if v:isA('TextLabel') or v:isA('TextButton') or v:isA('TextBox') then
				if not v:GetAttribute('MainTran') then
					v:SetAttribute("MainTran",v.TextTransparency)
				end
			end

			if v:isA('UIStroke') then
				if not v:GetAttribute('MainTran') then
					v:SetAttribute("MainTran",v.Transparency)
				end
			end
		end
	end

	local function ToggleUI(val,time_)
		SaveTran()
		time_ = time_ or 0.4

		if val then
			Frame.Visible = true

			TWEEN_SERVICE:Create(Frame,TweenInfo.new(time_ - 0.1),{BackgroundTransparency = 0}):Play()
			for i,v :GuiObject in ipairs(Frame:GetDescendants()) do
				pcall(function()
					if v:GetAttribute('MainTran') then

						if v:isA('Frame') then
							if v:GetAttribute('MainTran') then
								TWEEN_SERVICE:Create(v,TweenInfo.new(time_),{BackgroundTransparency = v:GetAttribute('MainTran')}):Play()
							end
						end

						if v:isA('ImageLabel') then
							if v:GetAttribute('MainTran') then
								TWEEN_SERVICE:Create(v,TweenInfo.new(time_),{ImageTransparency = v:GetAttribute('MainTran')}):Play()
							end
						end

						if v:isA('TextLabel') or v:isA('TextButton') or v:isA('TextBox') then
							if v:GetAttribute('MainTran') then
								TWEEN_SERVICE:Create(v,TweenInfo.new(time_),{TextTransparency = v:GetAttribute('MainTran')}):Play()
							end
						end

						if v:isA('UIStroke') then
							if v:GetAttribute('MainTran') then
								TWEEN_SERVICE:Create(v,TweenInfo.new(time_),{Transparency = v:GetAttribute('MainTran')}):Play()
							end
						end
					else
						if v:isA('ScrollingFrame') then
							TWEEN_SERVICE:Create(v,TweenInfo.new(time_),{ScrollBarThickness = 1}):Play()
						end
					end
				end)
			end
		else
			TWEEN_SERVICE:Create(Frame,TweenInfo.new(time_ + 0.4),{BackgroundTransparency = 1}):Play()
			for i,v :GuiObject in ipairs(Frame:GetDescendants()) do
				pcall(function()
					if v:GetAttribute('MainTran') then
						pcall(function()
							TWEEN_SERVICE:Create(v,TweenInfo.new(time_),{BackgroundTransparency = 1}):Play()
						end)

						pcall(function()
							TWEEN_SERVICE:Create(v,TweenInfo.new(time_),{ImageTransparency = 1}):Play()
						end)

						pcall(function()
							TWEEN_SERVICE:Create(v,TweenInfo.new(time_),{TextTransparency = 1}):Play()
						end)

						pcall(function()
							TWEEN_SERVICE:Create(v,TweenInfo.new(time_),{Transparency = 1}):Play()
						end)
					else
						if v:isA('ScrollingFrame') then
							TWEEN_SERVICE:Create(v,TweenInfo.new(time_),{ScrollBarThickness = 0}):Play()
						end
					end
				end)
			end


			coroutine.wrap(function()
				task.wait(time_ + 0.4)

				if Frame.BackgroundTransparency == 1 then
					Frame.Visible = false
				end
			end)()
		end
	end

	ScreenGui.Parent = CORE_GUI
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ResetOnSpawn = false

	Frame.Parent = ScreenGui
	Frame.Active = true
	Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.282842755, 0, 0.259509921, 0)
	Frame.Size = UDim2.new(0.224999994, 200, 0.224999994, 150)

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = Frame
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1.000
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1, 47, 1, 47)
	DropShadow.ZIndex = -2
	DropShadow.Image = "rbxassetid://6014261993"
	DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow.ImageTransparency = 0.500
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	Frame_2.Parent = Frame
	Frame_2.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
	Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_2.BorderSizePixel = 0
	Frame_2.Size = UDim2.new(1, 0, 0.00999999978, 0)

	UIGradient.Rotation = 90
	UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
	UIGradient.Parent = Frame_2

	Tab_collect.Name = "Tab_collect"
	Tab_collect.Parent = Frame
	Tab_collect.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	Tab_collect.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tab_collect.BorderSizePixel = 0
	Tab_collect.Position = UDim2.new(0.02073621, 0, 0.119445719, 0)
	Tab_collect.Size = UDim2.new(0.2648004, 0, 0.855990291, 0)

	UIStroke.Color = Color3.fromRGB(29, 29, 29)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Parent = Tab_collect

	UICorner.CornerRadius = UDim.new(0, 2)
	UICorner.Parent = Tab_collect

	ScrollingFrame.Parent = Tab_collect
	ScrollingFrame.Active = true
	ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame.BackgroundTransparency = 1.000
	ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	ScrollingFrame.Size = UDim2.new(0.980000019, 0, 0.980000019, 0)
	ScrollingFrame.ScrollBarThickness = 1
	ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 4)

	UIListLayout.Parent = ScrollingFrame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 2)

	Tab_Frame_collect.Name = "Tab_Frame_collect"
	Tab_Frame_collect.Parent = Frame
	Tab_Frame_collect.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	Tab_Frame_collect.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tab_Frame_collect.BorderSizePixel = 0
	Tab_Frame_collect.Position = UDim2.new(0.313633978, 0, 0.119445719, 0)
	Tab_Frame_collect.Size = UDim2.new(0.663971007, 0, 0.855990291, 0)

	UIStroke_2.Color = Color3.fromRGB(29, 29, 29)
	UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_2.Parent = Tab_Frame_collect

	UICorner_2.CornerRadius = UDim.new(0, 2)
	UICorner_2.Parent = Tab_Frame_collect

	HeaderTitle.Name = "HeaderTitle"
	HeaderTitle.Parent = Frame
	HeaderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HeaderTitle.BackgroundTransparency = 1.000
	HeaderTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HeaderTitle.BorderSizePixel = 0
	HeaderTitle.Position = UDim2.new(0.02073621, 0, 0.0373268053, 0)
	HeaderTitle.Size = UDim2.new(0.956868708, 0, 0.0552078411, 0)
	HeaderTitle.Font = Enum.Font.RobotoMono
	HeaderTitle.Text = WindowName or "CAT SUS | UI Lib"
	HeaderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	HeaderTitle.TextScaled = true
	HeaderTitle.TextSize = 14.000
	HeaderTitle.TextWrapped = true
	HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left

	function XVEWindow:Tab(TabName)
		local tabButton = Instance.new("TextButton")
		local XVETab = {}

		local tabButton = Instance.new("TextButton")
		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
		tabButton.Name = "tabButton"
		tabButton.Parent = Tab_collect:FindFirstChildWhichIsA('ScrollingFrame')
		tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		tabButton.BackgroundTransparency = 1.000
		tabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		tabButton.BorderSizePixel = 0
		tabButton.ClipsDescendants = true
		tabButton.Size = UDim2.new(1, 0, 0.5, 0)
		tabButton.Font = Enum.Font.RobotoMono
		tabButton.Text = TabName or "Example Tab"
		tabButton.TextColor3 = Color3.fromRGB(255, 0, 3)
		tabButton.TextSize = 15.000
		tabButton.TextWrapped = true

		UIAspectRatioConstraint.Parent = tabButton
		UIAspectRatioConstraint.AspectRatio = 7.000
		UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

		local TabMain = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")

		TabMain.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 4)

		UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			TabMain.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y)
		end)

		TabMain.Name = "TabMain"
		TabMain.Parent = Tab_Frame_collect
		TabMain.Active = true
		TabMain.AnchorPoint = Vector2.new(0.5, 0.5)
		TabMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabMain.BackgroundTransparency = 1.000
		TabMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabMain.BorderSizePixel = 0
		TabMain.Position = UDim2.new(0.5, 0, 0.5, 0)
		TabMain.Size = UDim2.new(0.980000019, 0, 0.980000019, 0)
		TabMain.ScrollBarThickness = 1

		UIListLayout.Parent = TabMain
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 4)

		local event = Instance.new('BindableEvent')

		event.Event:Connect(function(val)
			if val then
				TWEEN_SERVICE:Create(tabButton,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(255, 0, 4)}):Play()
				TabMain.Visible = true
			else
				TWEEN_SERVICE:Create(tabButton,TweenInfo.new(0.25),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
				TabMain.Visible = false
			end
		end)

		if #Tabs==0 then
			event:Fire(true)
		else
			event:Fire(false)
		end

		table.insert(Tabs,event)

		local mainTextType = {
			['right'] = Enum.TextXAlignment.Right,
			['left'] = Enum.TextXAlignment.Left,
			['center'] = Enum.TextXAlignment.Center
		}

		tabButton.MouseButton1Click:Connect(function()
			for i,v in ipairs(Tabs) do
				if v==event then
					v:Fire(true)
				else
					v:Fire(false)
				end
			end
		end)

		function XVETab:Layout()
			local Layout = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UIGradient = Instance.new("UIGradient")

			Layout.Name = "Layout"
			Layout.Parent = TabMain
			Layout.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
			Layout.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Layout.BorderSizePixel = 0
			Layout.Size = UDim2.new(1, 0, 0.5, 0)

			UIAspectRatioConstraint.Parent = Layout
			UIAspectRatioConstraint.AspectRatio = 100.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.10, 0.45), NumberSequenceKeypoint.new(0.90, 0.47), NumberSequenceKeypoint.new(1.00, 1.00)}
			UIGradient.Parent = Layout
		end

		function XVETab:NewButton(ButtonName,callback,position)
			local textpos = mainTextType[tostring(position):lower()] or mainTextType.center
			callback = callback or function() end
			local Functions = {}

			local Button = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UIStroke = Instance.new("UIStroke")
			local UIGradient = Instance.new("UIGradient")
			local InputButton = Instance.new("TextButton")

			Button.Name = "Button"
			Button.Parent = TabMain
			Button.BackgroundColor3 = Color3.fromRGB(167, 0, 3)
			Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Button.BorderSizePixel = 0
			Button.Size = UDim2.new(0.970000029, 0, 0.5, 0)

			UIAspectRatioConstraint.Parent = Button
			UIAspectRatioConstraint.AspectRatio = 13.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UIStroke.Color = Color3.fromRGB(20, 20, 20)
			UIStroke.Parent = Button

			UIGradient.Rotation = 90
			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.83), NumberSequenceKeypoint.new(1.00, 0.96)}
			UIGradient.Parent = Button

			InputButton.Name = "InputButton"
			InputButton.Parent = Button
			InputButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			InputButton.BackgroundTransparency = 1.000
			InputButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InputButton.BorderSizePixel = 0
			InputButton.ClipsDescendants = true
			InputButton.Size = UDim2.new(1, 0, 1, 0)
			InputButton.Font = Enum.Font.RobotoMono
			InputButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			InputButton.TextScaled = true
			InputButton.TextSize = 14.000
			InputButton.TextWrapped = true
			InputButton.Text = ButtonName or "Button"
			InputButton.TextXAlignment = textpos

			ConnectButtonEffect(InputButton,UIStroke)

			InputButton.MouseButton1Click:Connect(callback)

			function Functions:Text(new)
				InputButton.Text = new
			end

			function Functions:Fire(...)
				callback(...)
			end

			return Functions
		end

		function XVETab:NewLabel(LabelName,position)
			local Functions = {}
			local textpos = mainTextType[tostring(position):lower()] or mainTextType.left
			local Label = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UIGradient = Instance.new("UIGradient")
			local Title = Instance.new("TextLabel")

			Label.Name = "Label"
			Label.Parent = TabMain
			Label.BackgroundColor3 = Color3.fromRGB(167, 0, 3)
			Label.BackgroundTransparency = 1.000
			Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Label.BorderSizePixel = 0
			Label.Size = UDim2.new(0.970000029, 0, 0.5, 0)

			UIAspectRatioConstraint.Parent = Label
			UIAspectRatioConstraint.AspectRatio = 13.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UIGradient.Rotation = 90
			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.83), NumberSequenceKeypoint.new(1.00, 0.96)}
			UIGradient.Parent = Label

			Title.Name = "Title"
			Title.Parent = Label
			Title.AnchorPoint = Vector2.new(0, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 0, 0.5, 0)
			Title.Size = UDim2.new(1, 0, 0.75, 0)
			Title.Font = Enum.Font.RobotoMono
			Title.Text = tostring(LabelName) or "Example Label"
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextScaled = true
			Title.TextSize = 14.000
			Title.TextWrapped = true
			Title.TextXAlignment = textpos or Enum.TextXAlignment.Left

			function Functions:Text(a)
				Title.Text = tostring(a)
			end

			return Functions
		end

		function XVETab:NewToggle(ToggleName,Default,callback)
			callback = callback or function() end
			local Functions = {}

			local Toggle = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UIGradient = Instance.new("UIGradient")
			local InputButton = Instance.new("TextButton")
			local ToggleIcon = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local ToggleEnable = Instance.new("Frame")
			local UIGradient_2 = Instance.new("UIGradient")
			local UICorner_2 = Instance.new("UICorner")
			local Title = Instance.new("TextLabel")


			Toggle.Name = "Toggle"
			Toggle.Parent = TabMain
			Toggle.BackgroundColor3 = Color3.fromRGB(167, 0, 3)
			Toggle.BackgroundTransparency = 1.000
			Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.BorderSizePixel = 0
			Toggle.Size = UDim2.new(0.970000029, 0, 0.5, 0)

			UIAspectRatioConstraint.Parent = Toggle
			UIAspectRatioConstraint.AspectRatio = 13.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UIGradient.Rotation = 90
			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.83), NumberSequenceKeypoint.new(1.00, 0.96)}
			UIGradient.Parent = Toggle

			InputButton.Name = "InputButton"
			InputButton.Parent = Toggle
			InputButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			InputButton.BackgroundTransparency = 1.000
			InputButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InputButton.BorderSizePixel = 0
			InputButton.ClipsDescendants = true
			InputButton.Size = UDim2.new(1, 0, 1, 0)
			InputButton.Font = Enum.Font.RobotoMono
			InputButton.Text = ""
			InputButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			InputButton.TextScaled = true
			InputButton.TextSize = 14.000
			InputButton.TextTransparency = 1.000
			InputButton.TextWrapped = true

			ToggleIcon.Name = "ToggleIcon"
			ToggleIcon.Parent = Toggle
			ToggleIcon.AnchorPoint = Vector2.new(0, 0.5)
			ToggleIcon.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
			ToggleIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleIcon.BorderSizePixel = 0
			ToggleIcon.Position = UDim2.new(0.00999999978, 0, 0.5, 0)
			ToggleIcon.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
			ToggleIcon.SizeConstraint = Enum.SizeConstraint.RelativeYY

			UICorner.CornerRadius = UDim.new(0, 2)
			UICorner.Parent = ToggleIcon

			UIStroke.Color = Color3.fromRGB(20, 20, 20)
			UIStroke.Parent = ToggleIcon

			ToggleEnable.Name = "ToggleEnable"
			ToggleEnable.Parent = ToggleIcon
			ToggleEnable.AnchorPoint = Vector2.new(0.5, 0.5)
			ToggleEnable.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
			ToggleEnable.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleEnable.BorderSizePixel = 0
			ToggleEnable.Position = UDim2.new(0.5, 0, 0.5, 0)
			ToggleEnable.Size = UDim2.new(0.850000024, 0, 0.850000024, 0)
			ToggleEnable.Visible = false

			UIGradient_2.Rotation = 90
			UIGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.35), NumberSequenceKeypoint.new(1.00, 0.69)}
			UIGradient_2.Parent = ToggleEnable

			UICorner_2.CornerRadius = UDim.new(0, 2)
			UICorner_2.Parent = ToggleEnable

			Title.Name = "Title"
			Title.Parent = Toggle
			Title.AnchorPoint = Vector2.new(0, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.107000165, 0, 0.499999881, 0)
			Title.Size = UDim2.new(0.892999887, 0, 0.75, 0)
			Title.Font = Enum.Font.RobotoMono
			Title.Text = ToggleName or "Toggle"
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextScaled = true
			Title.TextSize = 15.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			ConnectButtonEffect(Toggle,UIStroke)

			local function dex (val)
				if val then
					ToggleEnable.Visible = true
					TWEEN_SERVICE:Create(ToggleEnable,TweenInfo.new(0.1),{Size = UDim2.new(0.850000024, 0, 0.850000024, 0),BackgroundTransparency=0}):Play()
					ToggleEnable:SetAttribute("MainTran",0)
				else
					TWEEN_SERVICE:Create(ToggleEnable,TweenInfo.new(0.1),{Size = UDim2.new(0,0,0,0),BackgroundTransparency=1}):Play()
					ToggleEnable:SetAttribute("MainTran",1)
				end
			end

			dex(Default)

			InputButton.MouseButton1Click:Connect(function()
				Default = not Default
				dex(Default)
				callback(Default)
			end)

			function Functions:Text(a)
				Title.Text = tostring(a)
			end

			function Functions:Set(de)
				Default = de
				dex(Default)
				callback(de)
			end

			return Functions
		end

		function XVETab:NewSlider(SliderName,confix,callback)
			confix = confix or {}
			confix.Min = confix.Min or 1
			confix.Max = confix.Max or 100
			confix.Default = confix.Default or confix.Min
			callback = callback or function() end
			local Functions = {}

			local Slider = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UIGradient = Instance.new("UIGradient")
			local Title = Instance.new("TextLabel")
			local SliderFrame = Instance.new("Frame")
			local UIGradient_2 = Instance.new("UIGradient")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local SliderMove = Instance.new("Frame")
			local UIGradient_3 = Instance.new("UIGradient")
			local UICorner_2 = Instance.new("UICorner")
			local ValueFrame = Instance.new("TextLabel")

			Slider.Name = "Slider"
			Slider.Parent = TabMain
			Slider.BackgroundColor3 = Color3.fromRGB(167, 0, 3)
			Slider.BackgroundTransparency = 1.000
			Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Slider.BorderSizePixel = 0
			Slider.Size = UDim2.new(0.970000029, 0, 0.5, 0)

			UIAspectRatioConstraint.Parent = Slider
			UIAspectRatioConstraint.AspectRatio = 8.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UIGradient.Rotation = 90
			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.83), NumberSequenceKeypoint.new(1.00, 0.96)}
			UIGradient.Parent = Slider

			Title.Name = "Title"
			Title.Parent = Slider
			Title.AnchorPoint = Vector2.new(0, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 0, 0.200000063, 0)
			Title.Size = UDim2.new(0.822453856, 0, 0.449999988, 0)
			Title.Font = Enum.Font.RobotoMono
			Title.Text = SliderName or "Example Slider"
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextScaled = true
			Title.TextSize = 14.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			SliderFrame.Name = "SliderFrame"
			SliderFrame.Parent = Slider
			SliderFrame.Active = true
			SliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			SliderFrame.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
			SliderFrame.BackgroundTransparency = 0.400
			SliderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderFrame.BorderSizePixel = 0
			SliderFrame.Position = UDim2.new(0.49999997, 0, 0.644296825, 0)
			SliderFrame.Size = UDim2.new(0.99999994, 0, 0.338594288, 0)

			UIGradient_2.Rotation = 90
			UIGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.83), NumberSequenceKeypoint.new(1.00, 0.96)}
			UIGradient_2.Parent = SliderFrame

			UICorner.CornerRadius = UDim.new(0, 1)
			UICorner.Parent = SliderFrame

			UIStroke.Color = Color3.fromRGB(29, 29, 29)
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Parent = SliderFrame

			SliderMove.Name = "SliderMove"
			SliderMove.Parent = SliderFrame
			SliderMove.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
			SliderMove.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderMove.BorderSizePixel = 0
			SliderMove.Size = UDim2.new(0.100000001, 0, 1, 0)

			UIGradient_3.Rotation = 90
			UIGradient_3.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.34), NumberSequenceKeypoint.new(1.00, 0.86)}
			UIGradient_3.Parent = SliderMove

			UICorner_2.CornerRadius = UDim.new(0, 1)
			UICorner_2.Parent = SliderMove

			ValueFrame.Name = "ValueFrame"
			ValueFrame.Parent = Slider
			ValueFrame.AnchorPoint = Vector2.new(1, 0.5)
			ValueFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ValueFrame.BackgroundTransparency = 1.000
			ValueFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ValueFrame.BorderSizePixel = 0
			ValueFrame.Position = UDim2.new(0.998, 0,0.2, 0)
			ValueFrame.Size = UDim2.new(0.177546084, 0, 0.449999988, 0)
			ValueFrame.Font = Enum.Font.RobotoMono
			ValueFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
			ValueFrame.TextScaled = true
			ValueFrame.TextSize = 14.000
			ValueFrame.TextTransparency = 0.250
			ValueFrame.TextWrapped = true
			ValueFrame.TextXAlignment = Enum.TextXAlignment.Right
			ValueFrame.Text = tostring(confix.Default)..tostring("/")..tostring(confix.Max)

			local function UpdateText()
				local size = TEXT_SERVICE:GetTextSize(ValueFrame.Text,ValueFrame.TextSize,ValueFrame.Font,Vector2.new(math.huge,math.huge))
				--ValueFrame.Size = UDim2.new((size.X) / 200,0,0.45,0)
				TWEEN_SERVICE:Create(ValueFrame,TweenInfo.new(0.2),{Size = UDim2.new((size.X) / 200,0,0.45,0)}):Play()
			end

			ConnectButtonEffect(Slider,UIStroke)
			UpdateText()

			local danger = false

			SliderFrame.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					danger = true
					Dbg_can_move = false
				end
			end)

			SliderFrame.InputEnded:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					danger = false
					Dbg_can_move = true
				end
			end)

			local function Set(call,input,va)
				if call == "Input" then
					if danger and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						local SizeScale = math.clamp(((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X), 0, 1)
						local Valuea = math.floor(((confix.Max - confix.Min) * SizeScale) + confix.Min)
						local Size = UDim2.fromScale(SizeScale, 1)
						ValueFrame.Text = tostring(Valuea)..tostring("/")..tostring(confix.Max)
						TWEEN_SERVICE:Create(SliderMove,TweenInfo.new(0.02),{Size = Size}):Play()
						callback(Valuea)
					end
				else
					if not va then
						local min = confix.Default
						local max = confix.Max

						ValueFrame.Text = tostring(min)..tostring("/")..tostring(max)
						local size = UDim2.new((min/confix.Max),0,1,0)
						TWEEN_SERVICE:Create(SliderMove,TweenInfo.new(0.02),{Size = size}):Play()
						callback(confix.Default)
					else
						ValueFrame.Text = tostring(va)..tostring("/")..tostring(confix.Max)
						local size = UDim2.new((va/confix.Max),0,1,0)
						TWEEN_SERVICE:Create(SliderMove,TweenInfo.new(0.02),{Size = size}):Play()

					end

				end

				UpdateText()
			end

			USERINPUT_SERVICE.InputChanged:Connect(function(a)
				Set("Input",a)
			end)

			Set()

			function Functions:Value(a)
				Set(nil,nil,a)
			end

			function Functions:Text(a)
				Title.Text = tostring(a)
			end

			return Functions
		end

		function XVETab:NewKeybind(KeybindName,Default,callback)
			Default = Default or nil
			callback = callback or function() end

			local function Gettext(e:Enum.KeyCode)
				if not e then
					return "None"
				end
				return tostring(e.Name)
			end

			local Functions = {}

			local Keybind = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UIGradient = Instance.new("UIGradient")
			local Title = Instance.new("TextLabel")
			local BindKey = Instance.new("TextLabel")
			local UIStroke = Instance.new("UIStroke")
			local Frame = Instance.new("Frame")
			local UIGradient_2 = Instance.new("UIGradient")
			local UICorner = Instance.new("UICorner")
			local UICorner_2 = Instance.new("UICorner")
			local InputButton = Instance.new("TextButton")

			Keybind.Name = "Keybind"
			Keybind.Parent = TabMain
			Keybind.BackgroundColor3 = Color3.fromRGB(167, 0, 3)
			Keybind.BackgroundTransparency = 1.000
			Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Keybind.BorderSizePixel = 0
			Keybind.Size = UDim2.new(0.970000029, 0, 0.5, 0)

			UIAspectRatioConstraint.Parent = Keybind
			UIAspectRatioConstraint.AspectRatio = 13.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UIGradient.Rotation = 90
			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.83), NumberSequenceKeypoint.new(1.00, 0.96)}
			UIGradient.Parent = Keybind

			Title.Name = "Title"
			Title.Parent = Keybind
			Title.AnchorPoint = Vector2.new(0, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 0, 0.499999881, 0)
			Title.Size = UDim2.new(0.68938756, 0, 0.75, 0)
			Title.Font = Enum.Font.RobotoMono
			Title.Text = KeybindName or "Example Keybind"
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextScaled = true
			Title.TextSize = 14.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			BindKey.Name = "BindKey"
			BindKey.Parent = Keybind
			BindKey.AnchorPoint = Vector2.new(1, 0.5)
			BindKey.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
			BindKey.BackgroundTransparency = 1.000
			BindKey.BorderColor3 = Color3.fromRGB(0, 0, 0)
			BindKey.BorderSizePixel = 0
			BindKey.Position = UDim2.new(1, 0, 0.499999881, 0)
			BindKey.Size = UDim2.new(0.123995535, 0, 0.75, 0)
			BindKey.Font = Enum.Font.RobotoMono
			BindKey.Text = Gettext(Default)
			BindKey.TextColor3 = Color3.fromRGB(255, 255, 255)
			BindKey.TextScaled = true
			BindKey.TextSize = 14.000
			BindKey.TextWrapped = true

			UIStroke.Color = Color3.fromRGB(29, 29, 29)
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Parent = BindKey

			Frame.Parent = BindKey
			Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Size = UDim2.new(1, 0, 1, 0)

			UIGradient_2.Rotation = 90
			UIGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.83), NumberSequenceKeypoint.new(1.00, 0.96)}
			UIGradient_2.Parent = Frame

			UICorner.CornerRadius = UDim.new(0, 1)
			UICorner.Parent = Frame

			UICorner_2.CornerRadius = UDim.new(0, 1)
			UICorner_2.Parent = BindKey

			InputButton.Name = "InputButton"
			InputButton.Parent = Keybind
			InputButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			InputButton.BackgroundTransparency = 1.000
			InputButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InputButton.BorderSizePixel = 0
			InputButton.ClipsDescendants = true
			InputButton.Size = UDim2.new(1, 0, 1, 0)
			InputButton.Font = Enum.Font.RobotoMono
			InputButton.Text = ""
			InputButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			InputButton.TextScaled = true
			InputButton.TextSize = 14.000
			InputButton.TextTransparency = 1.000
			InputButton.TextWrapped = true

			local function UpdateText()
				local textsize = TEXT_SERVICE:GetTextSize(BindKey.Text,BindKey.TextSize,BindKey.Font,Vector2.new(math.huge,math.huge))
				--
				TWEEN_SERVICE:Create(BindKey,TweenInfo.new(0.2),{Size = UDim2.new(0,textsize.X + 9,0.75,0)}):Play()
			end

			ConnectButtonEffect(Keybind,UIStroke)
			UpdateText()

			local Binding = false
			InputButton.MouseButton1Click:Connect(function()
				if Binding then
					return
				end
				Binding =  true

				local targetloadded = nil

				local hook = USERINPUT_SERVICE.InputBegan:Connect(function(is)
					if is.KeyCode ~= Enum.KeyCode.Unknown then
						targetloadded = is.KeyCode
					end
				end)

				BindKey.Text = "..."
				repeat task.wait() UpdateText() until targetloadded or not Binding
				Binding =false
				if hook then
					hook:Disconnect()
				end
				if targetloadded then
					BindKey.Text = Gettext(targetloadded)
					Default = targetloadded
					UpdateText() 
					callback(targetloadded)
				end
				return
			end)

			function Functions:Value(a)
				BindKey.Text = Gettext(a)
				Default = a
				UpdateText() 
				callback(a)
			end

			function Functions:Text(v)
				Title.Text = tostring(v)
			end

			return Functions
		end

		function XVETab:NewTextBox(TextBoxName,InputText,callback)
			InputText = InputText or ""
			callback = callback or function() end
			local Functions = {}

			local TextBox = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UIGradient = Instance.new("UIGradient")
			local Title = Instance.new("TextLabel")
			local TextBox_2 = Instance.new("TextBox")
			local Frame = Instance.new("Frame")
			local UIGradient_2 = Instance.new("UIGradient")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")

			TextBox.Name = "TextBox"
			TextBox.Parent = TabMain
			TextBox.BackgroundColor3 = Color3.fromRGB(167, 0, 3)
			TextBox.BackgroundTransparency = 1.000
			TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextBox.BorderSizePixel = 0
			TextBox.Size = UDim2.new(0.970000029, 0, 0.5, 0)

			UIAspectRatioConstraint.Parent = TextBox
			UIAspectRatioConstraint.AspectRatio = 8.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UIGradient.Rotation = 90
			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.83), NumberSequenceKeypoint.new(1.00, 0.96)}
			UIGradient.Parent = TextBox

			Title.Name = "Title"
			Title.Parent = TextBox
			Title.AnchorPoint = Vector2.new(0, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 0, 0.200000003, 0)
			Title.Size = UDim2.new(1, 0, 0.449999988, 0)
			Title.Font = Enum.Font.RobotoMono
			Title.Text = TextBoxName or "Example TextBox"
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextScaled = true
			Title.TextSize = 14.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			TextBox_2.Parent = TextBox
			TextBox_2.AnchorPoint = Vector2.new(0.5, 0.5)
			TextBox_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextBox_2.BackgroundTransparency = 1.000
			TextBox_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextBox_2.BorderSizePixel = 0
			TextBox_2.Position = UDim2.new(0.5, 0, 0.725000024, 0)
			TextBox_2.Size = UDim2.new(1, 0, 0.5, 0)
			TextBox_2.ClearTextOnFocus = false
			TextBox_2.Font = Enum.Font.RobotoMono
			TextBox_2.Text = ""
			TextBox_2.TextColor3 = Color3.fromRGB(152, 152, 152)
			TextBox_2.TextSize = 14.000
			TextBox_2.TextWrapped = true
			TextBox_2.TextXAlignment = Enum.TextXAlignment.Left
			TextBox_2.PlaceholderText = InputText

			Frame.Parent = TextBox_2
			Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
			Frame.BackgroundTransparency = 0.400
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Size = UDim2.new(1, 0, 1, 0)

			UIGradient_2.Rotation = 90
			UIGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.83), NumberSequenceKeypoint.new(1.00, 0.96)}
			UIGradient_2.Parent = Frame

			UICorner.CornerRadius = UDim.new(0, 1)
			UICorner.Parent = Frame

			UIStroke.Color = Color3.fromRGB(29, 29, 29)
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Parent = Frame

			ConnectButtonEffect(TextBox_2,UIStroke)

			TextBox_2.FocusLost:Connect(function()
				callback(TextBox_2.Text)
			end)

			function Functions:Value(s)
				TextBox_2.Text = tostring(s)
				callback(TextBox_2.Text)
			end

			function Functions:Get()
				return TextBox_2.Text
			end

			function Functions:Text(a)
				Title.Text = tostring(a)
			end

			return Functions
		end

		function XVETab:NewDropdown(DropdownName,InfoData,Default,callback)
			InfoData = InfoData or {}
			callback = callback or function() end
			Default = Default or {InfoData[1]}
			local Functions = {}

			local Dropdown = Instance.new("Frame")
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			local UIGradient = Instance.new("UIGradient")
			local TopBar = Instance.new("Frame")
			local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
			local Title = Instance.new("TextLabel")
			local UIStroke = Instance.new("UIStroke")
			local Title_2 = Instance.new("TextLabel")
			local UIStroke_2 = Instance.new("UIStroke")
			local Dropdown_Scroll = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")

			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				Dropdown_Scroll.CanvasSize = UDim2.new(0,0,0,UIListLayout.AbsoluteContentSize.Y)
			end)

			Dropdown_Scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 4)

			Dropdown.Name = "Dropdown"
			Dropdown.Parent = TabMain
			Dropdown.BackgroundColor3 = Color3.fromRGB(167, 0, 3)
			Dropdown.BackgroundTransparency = 0.700
			Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.BorderSizePixel = 0
			Dropdown.Size = UDim2.new(0.970000029, 0, 0.5, 0)

			UIAspectRatioConstraint.Parent = Dropdown
			UIAspectRatioConstraint.AspectRatio = 13.000
			UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

			UIGradient.Rotation = 90
			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.83), NumberSequenceKeypoint.new(1.00, 0.96)}
			UIGradient.Parent = Dropdown

			TopBar.Name = "TopBar"
			TopBar.Parent = Dropdown
			TopBar.AnchorPoint = Vector2.new(0.5, 0)
			TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TopBar.BackgroundTransparency = 1.000
			TopBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TopBar.BorderSizePixel = 0
			TopBar.Position = UDim2.new(0.5, 0, 0.00999999978, 0)
			TopBar.Size = UDim2.new(0.980000019, 0, 0.5, 0)

			UIAspectRatioConstraint_2.Parent = TopBar
			UIAspectRatioConstraint_2.AspectRatio = 13.000
			UIAspectRatioConstraint_2.AspectType = Enum.AspectType.ScaleWithParentSize

			Title.Name = "Title"
			Title.Parent = TopBar
			Title.AnchorPoint = Vector2.new(0, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0, 0, 0.500000298, 0)
			Title.Size = UDim2.new(0.8836779, 0, 0.75, 0)
			Title.Font = Enum.Font.RobotoMono
			Title.Text = DropdownName or "Example Dropdown"
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextScaled = true
			Title.TextSize = 14.000
			Title.TextWrapped = true
			Title.TextXAlignment = Enum.TextXAlignment.Left

			UIStroke.Color = Color3.fromRGB(29, 29, 29)
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Parent = TopBar

			Title_2.Name = "Title"
			Title_2.Parent = TopBar
			Title_2.AnchorPoint = Vector2.new(0, 0.5)
			Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title_2.BackgroundTransparency = 1.000
			Title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title_2.BorderSizePixel = 0
			Title_2.Position = UDim2.new(0.911000013, 0, 0.5, 0)
			Title_2.Rotation = -90.000
			Title_2.Size = UDim2.new(0.899999976, 0, 0.899999976, 0)
			Title_2.SizeConstraint = Enum.SizeConstraint.RelativeYY
			Title_2.Font = Enum.Font.Unknown
			Title_2.Text = ">"
			Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title_2.TextScaled = true
			Title_2.TextSize = 14.000
			Title_2.TextWrapped = true

			UIStroke_2.Color = Color3.fromRGB(29, 29, 29)
			UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke_2.Parent = Dropdown

			Dropdown_Scroll.Name = "Dropdown_Scroll"
			Dropdown_Scroll.Parent = Dropdown
			Dropdown_Scroll.Active = true
			Dropdown_Scroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Dropdown_Scroll.BackgroundTransparency = 1.000
			Dropdown_Scroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown_Scroll.BorderSizePixel = 0
			Dropdown_Scroll.Position = UDim2.new(0.00812093727, 0, 0.231449082, 0)
			Dropdown_Scroll.Size = UDim2.new(0.980000079, 0, 0.729458511, 0)
			Dropdown_Scroll.Visible = false
			Dropdown_Scroll.ScrollBarThickness = 1

			UIListLayout.Parent = Dropdown_Scroll
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 2)

			local choose = InfoData[1]

			local function redtran(val)
				for i,v : TextButton in ipairs(Dropdown_Scroll:GetChildren()) do
					if v:isA('TextButton') then
						if val then
							v:SetAttribute("MainTran",0)
							TWEEN_SERVICE:Create(v,TweenInfo.new(0.5),{TextTransparency = 0}):Play()
						else
							v:SetAttribute("MainTran",1)
							TWEEN_SERVICE:Create(v,TweenInfo.new(0.5),{TextTransparency = 1}):Play()
						end
					end
				end
			end

			local function VALUE_CHANGE(val)
				if val then
					redtran(true)
					Dropdown_Scroll.Visible = true
					TWEEN_SERVICE:Create(Title_2,TweenInfo.new(0.2),{Rotation = 90}):Play()
					TWEEN_SERVICE:Create(UIAspectRatioConstraint,TweenInfo.new(0.2),{AspectRatio = 2.25}):Play()
				else
					redtran(false)
					Dropdown_Scroll.Visible = false
					TWEEN_SERVICE:Create(Title_2,TweenInfo.new(0.2),{Rotation = -90}):Play()
					TWEEN_SERVICE:Create(UIAspectRatioConstraint,TweenInfo.new(0.2),{AspectRatio = 13}):Play()
				end
			end

			local function GetButton()
				local Button = Instance.new("TextButton")
				local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

				Button.Name = "Button"
				Button.Parent = Dropdown_Scroll
				Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Button.BackgroundTransparency = 1.000
				Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button.BorderSizePixel = 0
				Button.ClipsDescendants = true
				Button.Size = UDim2.new(1, 0, 1, 0)
				Button.Font = Enum.Font.RobotoMono
				Button.TextColor3 = Color3.fromRGB(255, 255, 255)
				Button.TextScaled = true
				Button.TextSize = 14.000
				Button.TextWrapped = true

				UIAspectRatioConstraint.Parent = Button
				UIAspectRatioConstraint.AspectRatio = 13.000
				UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize

				return Button
			end

			local function OnRF()
				for i,v in ipairs(Dropdown_Scroll:GetChildren()) do
					if v:isA('TextButton') then
						v:Destroy()
					end
				end

				for i,v in ipairs(InfoData) do
					local button = GetButton()
					button.Text = tostring(v)

					button.MouseButton1Click:Connect(function()
						for i,a in ipairs(Dropdown_Scroll:GetChildren()) do
							if a:isA('TextButton') then
								if a==button then
									TWEEN_SERVICE:Create(a,TweenInfo.new(0.2),{TextColor3 = Color3.fromRGB(255, 0, 4)}):Play()
								else
									TWEEN_SERVICE:Create(a,TweenInfo.new(0.2),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
								end
							end
						end

						choose = v

						callback(v)
					end)

					if i==1 or Default == v then
						for i,a in ipairs(Dropdown_Scroll:GetChildren()) do
							if a:isA('TextButton') then
								if a==button then
									TWEEN_SERVICE:Create(a,TweenInfo.new(0.2),{TextColor3 = Color3.fromRGB(255, 0, 4)}):Play()
								else
									TWEEN_SERVICE:Create(a,TweenInfo.new(0.2),{TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
								end
							end
						end

						choose = v

						callback(v)
					end
				end
			end

			local db_toggle = false
			local on = false

			VALUE_CHANGE(false)

			ConnectButtonEffect(Dropdown,UIStroke)

			TopBar.InputBegan:Connect(function(a)
				if a.UserInputType == Enum.UserInputType.MouseButton1 or a.UserInputType == Enum.UserInputType.Touch then
					on = true
				end
			end)

			TopBar.InputEnded:Connect(function(a)
				if a.UserInputType == Enum.UserInputType.MouseButton1 or a.UserInputType == Enum.UserInputType.Touch then
					if on then
						on = false
						db_toggle = not db_toggle
						VALUE_CHANGE(db_toggle)
					end
				end
			end)

			OnRF()

			function Functions:Refresh(newinfo)
				newinfo = newinfo or InfoData
				InfoData = newinfo
				OnRF()
			end

			function Functions:Get()
				return choose
			end

			function Functions:Text(a)
				Title.Text = tostring(a)
			end

			return Functions
		end

		return XVETab
	end

	function XVEWindow:Destroy()
		ScreenGui:Destroy()
	end

	function XVEWindow:Watermark()
		local Watermark = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")

		Watermark.Name = "Watermark"
		Watermark.Parent = ScreenGui
		Watermark.AnchorPoint = Vector2.new(0.5, 0)
		Watermark.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
		Watermark.BackgroundTransparency = 1.000
		Watermark.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Watermark.BorderSizePixel = 0
		Watermark.Position = UDim2.new(0.499000013, 0, 0.944999993, 0)
		Watermark.Size = UDim2.new(0.980000019, 0, 0.0500000007, 0)

		UIListLayout.Parent = Watermark
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Padding = UDim.new(0, 2)

		local Functions = {}

		function Functions:NewWatermark(Text)
			if not Text then
				return
			end

			local WatermarFucntions = {}

			local WatermarkText = Instance.new("TextLabel")
			local Frame = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")

			WatermarkText.Name = "Watermark"
			WatermarkText.Parent = Watermark
			WatermarkText.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
			WatermarkText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			WatermarkText.BorderSizePixel = 0
			WatermarkText.Position = UDim2.new(0, 0, -2.073205e-06, 0)
			WatermarkText.Size = UDim2.new(0.0899034441, 0, 1.00000012, 0)
			WatermarkText.Font = Enum.Font.RobotoMono
			WatermarkText.TextColor3 = Color3.fromRGB(255, 255, 255)
			WatermarkText.TextScaled = true
			WatermarkText.TextSize = 14.000
			WatermarkText.TextWrapped = true
			WatermarkText.TextXAlignment = Enum.TextXAlignment.Center

			Frame.Parent = WatermarkText
			Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
			Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Frame.BorderSizePixel = 0
			Frame.Size = UDim2.new(1, 0, 0.100000001, 0)
			Frame.ZIndex = 2

			UIGradient.Rotation = 90
			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
			UIGradient.Parent = Frame

			local lockedtext = Instance.new('UITextSizeConstraint')
			lockedtext.MaxTextSize = 15
			lockedtext.MinTextSize = 15

			lockedtext.Parent = WatermarkText

			local function sttr()
				WatermarkText.Size = UDim2.new(0,0,0,0)
				WatermarkText.TextTransparency = 1
				Frame.BackgroundTransparency = 1

				TWEEN_SERVICE:Create(WatermarkText,TweenInfo.new(1),{TextTransparency = 0}):Play()
				TWEEN_SERVICE:Create(Frame,TweenInfo.new(0.6),{BackgroundTransparency = 0}):Play()
			end

			local function Update()
				local size = TEXT_SERVICE:GetTextSize(WatermarkText.Text,WatermarkText.TextSize,WatermarkText.Font,Vector2.new(math.huge,math.huge))

				TWEEN_SERVICE:Create(WatermarkText,TweenInfo.new(0.1),{Size = UDim2.new(0,size.X + 9,.98,0)}):Play()
			end

			sttr()

			WatermarkText.Text = tostring(Text)

			Update()

			function WatermarFucntions:Text(a)
				WatermarkText.Text = tostring(a)
				Update()
			end

			function WatermarFucntions:Delete()
				WatermarkText:Destroy()
			end

			return WatermarFucntions
		end

		return Functions
	end

	function XVEWindow:AddToggleButton(text)
		text = text or "开/关"
		local maind = Frame
		local Frame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local Frame_2 = Instance.new("Frame")
		local UIGradient = Instance.new("UIGradient")
		local InputButton = Instance.new("TextButton")

		Frame.Parent = ScreenGui
		Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0.6966362, 0, 0.0407608785, 0)
		Frame.Size = UDim2.new(0.140000001, 0, 0.140000001, 0)
		Frame.SizeConstraint = Enum.SizeConstraint.RelativeYY
		Frame.AnchorPoint = Vector2.new(0.5,0.2)

		UICorner.CornerRadius = UDim.new(0, 3)
		UICorner.Parent = Frame

		UIStroke.Color = Color3.fromRGB(29, 29, 29)
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.Parent = Frame

		Frame_2.Parent = Frame
		Frame_2.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
		Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame_2.BorderSizePixel = 0
		Frame_2.Size = UDim2.new(1, 0, 0.0549999997, 0)

		UIGradient.Rotation = 90
		UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
		UIGradient.Parent = Frame_2

		InputButton.Name = "InputButton"
		InputButton.Parent = Frame
		InputButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		InputButton.BackgroundTransparency = 1.000
		InputButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InputButton.BorderSizePixel = 0
		InputButton.ClipsDescendants = true
		InputButton.Size = UDim2.new(0.75, 0, 0.75, 0)
		InputButton.Font = Enum.Font.RobotoMono
		InputButton.Text = text or "开/关"
		InputButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		InputButton.TextScaled = true
		InputButton.TextSize = 14.000
		InputButton.TextWrapped = true
		InputButton.AnchorPoint = Vector2.new(0.5,0.5)
		InputButton.Position = UDim2.new(0.5,0,0.5,0)

		local function srr()
			Frame.Size = UDim2.new(0,0,0)
			Frame_2.BackgroundTransparency = 1
			UIStroke.Transparency = 1
			InputButton.TextTransparency = 1

			TWEEN_SERVICE:Create(Frame,TweenInfo.new(0.5,Enum.EasingStyle.Quint),{Size = UDim2.new(0.140000001, 0, 0.140000001, 0)}):Play()
			task.wait(0.5)
			TWEEN_SERVICE:Create(Frame_2,TweenInfo.new(1,Enum.EasingStyle.Quad),{BackgroundTransparency = 0}):Play()
			TWEEN_SERVICE:Create(UIStroke,TweenInfo.new(1,Enum.EasingStyle.Quad),{Transparency = 0.2}):Play()
			TWEEN_SERVICE:Create(InputButton,TweenInfo.new(1,Enum.EasingStyle.Quad),{TextTransparency = 0}):Play()

		end

		local dragToggle = nil
		local dragStart = nil
		local startPos = nil

		local function updateInput(input)
			local delta = input.Position - dragStart
			local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			game:GetService('TweenService'):Create(Frame, TweenInfo.new(0.025,Enum.EasingStyle.Linear), {Position = position}):Play()
		end

		InputButton.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
				dragToggle = true
				dragStart = input.Position
				startPos = Frame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)

		USERINPUT_SERVICE.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				if dragToggle and Dbg_can_move then
					updateInput(input)
				end
			end
		end)

		InputButton.MouseButton1Click:Connect(function()
			UI_VALUE = not UI_VALUE
			UIStroke.Transparency = 1
			UIStroke.Color = Color3.fromRGB(255, 0, 4)

			TWEEN_SERVICE:Create(UIStroke,TweenInfo.new(0.4,Enum.EasingStyle.Quad),{Transparency = 0.2,Color = Color3.fromRGB(0, 0, 0)}):Play()
			ToggleUI(UI_VALUE)
		end)

		srr()
	end

	function XVEWindow:SetKeybindToggle(key)
		USERINPUT_SERVICE.InputBegan:Connect(function(a)
			if a.KeyCode == key then
				UI_VALUE = not UI_VALUE
				ToggleUI(UI_VALUE)
			end
		end)
	end

	local dragToggle = nil
	local dragStart = nil
	local startPos = nil

	local function updateInput(input)
		local delta = input.Position - dragStart
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		game:GetService('TweenService'):Create(Frame, TweenInfo.new(0.025,Enum.EasingStyle.Linear), {Position = position}):Play()
	end

	Frame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			dragToggle = true
			dragStart = input.Position
			startPos = Frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)

	USERINPUT_SERVICE.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle and Dbg_can_move then
				updateInput(input)
			end
		end
	end)

	coroutine.wrap(function()
		Frame.Size = UDim2.new(0,0,0,0)
		ToggleUI(false,0)

		task.wait(0.1)

		Frame:FindFirstChild('Frame').BackgroundTransparency = 1
		Tab_Frame_collect.Visible = false
		Tab_collect.Visible = false
		task.wait(0.3)
		Frame.Size = UDim2.new(0,0,0,5)
		Frame.Visible = true
		TWEEN_SERVICE:Create(Frame,TweenInfo.new(0.5),{BackgroundTransparency = 0}):Play()

		TWEEN_SERVICE:Create(Frame,TweenInfo.new(0.45,Enum.EasingStyle.Quad),{Size = UDim2.new(0.224999994, 200, 0, 5)}):Play()

		task.wait(0.55)

		TWEEN_SERVICE:Create(Frame,TweenInfo.new(0.45,Enum.EasingStyle.Quad),{Size = UDim2.new(0.224999994, 200, 0.224999994, 150)}):Play()

		task.wait(0.9)
		Tab_Frame_collect.Visible = true
		Tab_collect.Visible = true
		ToggleUI(true,0.5)
	end)()

	return XVEWindow
end

function XVE:Notification()
	local NotificationFunction = {}
	local Notify = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	Notify.Name = "Notify"
	Notify.Parent = CORE_GUI
	Notify.ResetOnSpawn = false

	Frame.Parent = Notify
	Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame.BackgroundTransparency = 1.000
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.793189347, 0, 0.484035343, 0)
	Frame.Size = UDim2.new(0.200000003, 0, 0.5, 0)

	UIListLayout.Parent = Frame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	UIListLayout.Padding = UDim.new(0, 2)

	function NotificationFunction:Notify(TitleName,tim)
		tim = tim or 5

		local Notify = Instance.new("Frame")
		local Main = Instance.new("Frame")
		local Countdown = Instance.new("Frame")
		local UIGradient = Instance.new("UIGradient")
		local DropShadow = Instance.new("ImageLabel")
		local Title = Instance.new("TextLabel")

		Notify.Name = "Notify"
		Notify.Parent = Frame
		Notify.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Notify.BackgroundTransparency = 1.000
		Notify.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Notify.BorderSizePixel = 0
		Notify.Position = UDim2.new(0, 0, 0.904212236, 0)
		Notify.Size = UDim2.new(1, 0, 0.075, 0)

		Main.Name = "Main"
		Main.Parent = Notify
		Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
		Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Main.BorderSizePixel = 0
		Main.Size = UDim2.new(1, 0, 1, 0)

		Countdown.Name = "Countdown"
		Countdown.Parent = Main
		Countdown.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
		Countdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Countdown.BorderSizePixel = 0
		Countdown.Size = UDim2.new(1, 0, 0.100000001, 0)

		UIGradient.Rotation = 90
		UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
		UIGradient.Parent = Countdown

		DropShadow.Name = "DropShadow"
		DropShadow.Parent = Main
		DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
		DropShadow.BackgroundTransparency = 1.000
		DropShadow.BorderSizePixel = 0
		DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
		DropShadow.Size = UDim2.new(1, 27, 1, 27)
		DropShadow.ZIndex = -2
		DropShadow.Image = "rbxassetid://6014261993"
		DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
		DropShadow.ImageTransparency = 0.500
		DropShadow.ScaleType = Enum.ScaleType.Slice
		DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

		Title.Name = "Title"
		Title.Parent = Main
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Title.BorderSizePixel = 0
		Title.Position = UDim2.new(0.0311461799, 0, 0.100000232, 0)
		Title.Size = UDim2.new(0.937707722, 0, 0.899999797, 0)
		Title.Font = Enum.Font.RobotoMono
		Title.Text = tostring(TitleName) or "Noify"
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		--Title.TextScaled = true
		Title.TextSize = 15.000
		Title.TextWrapped = true
		Title.RichText = true
		Title.TextTransparency = 1
		--Title.TextXAlignment = Enum.TextXAlignment.Right
		
		local locked = Instance.new('UITextSizeConstraint')
		
		locked.MaxTextSize = 11
		locked.MinTextSize = 10
		locked.Parent = Title
		
		local function SetTounknow(time_)
			if time_ then
				TWEEN_SERVICE:Create(Notify,TweenInfo.new(time_),{Size = UDim2.new(0,0,0.096,0)}):Play()
				TWEEN_SERVICE:Create(Main,TweenInfo.new(time_ * 1.5),{Position = UDim2.new(3,0,0,0)}):Play()
				return
			else
				Notify.Size = UDim2.new(0,0,0,0)
				Main.Position = UDim2.new(3,0,0,0)
			end
		end

		local function offall()
			TWEEN_SERVICE:Create(DropShadow,TweenInfo.new(0.2),{ImageTransparency = 1}):Play()
			TWEEN_SERVICE:Create(Title,TweenInfo.new(0.2,Enum.EasingStyle.Quint),{TextTransparency = 1}):Play()
			TWEEN_SERVICE:Create(Countdown,TweenInfo.new(0.2),{BackgroundTransparency = 1}):Play()
			TWEEN_SERVICE:Create(Notify,TweenInfo.new(0.2),{Size = UDim2.new(0,0,0,0)}):Play()
		end

		local function upsize()
			local textSize = TEXT_SERVICE:GetTextSize(Title.Text,Title.TextSize,Title.Font,Vector2.new(math.huge,math.huge))
			local dex = OffsetToScale({textSize.X,textSize.Y})
			TWEEN_SERVICE:Create(Notify,TweenInfo.new(0.2),{Size = UDim2.new(0,textSize.X + 4,0.075,0)}):Play()
			TWEEN_SERVICE:Create(Title,TweenInfo.new(0.3,Enum.EasingStyle.Quint),{TextTransparency = 0}):Play()
		end

		coroutine.wrap(function()
			SetTounknow()
			Countdown.Size = UDim2.new(0,0,0.1,0)
			task.wait()
			TWEEN_SERVICE:Create(Main,TweenInfo.new(0.3),{Position = UDim2.new(0,0,0,0)}):Play()
			upsize()

			local tw = TWEEN_SERVICE:Create(Countdown,TweenInfo.new(tim,Enum.EasingStyle.Linear),{Size =  UDim2.new(1,0,0.1,0)})
			upsize()
			tw:Play()
			tw.Completed:Wait()
			task.wait(0.2)
			SetTounknow(0.5)
			offall()
			task.wait(0.64)
			Notify:Destroy()
		end)()
	end

	return NotificationFunction
end

return XVE
