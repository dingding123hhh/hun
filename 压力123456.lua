game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "『禁漫中心』"; Text ="压力"; Duration = 10; })

local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

local Window = OrionLib:MakeWindow({Name = "『禁漫中心』", HidePremium = false, SaveConfig = true,IntroText = "『禁漫中心』", ConfigFolder = "禁漫中心"})

game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "启动成功"; Text ="1.0"; Duration = 10; })


local Tab = Window:MakeTab({
	Name = "主要功能",
	Icon = "rbxassetid://18942670945",
	PremiumOnly = false
})
Tab:AddSlider({

	Name = "速度",

	Min = 16,

	Max = 200,

	Default = 16,

	Color = Color3.fromRGB(255,255,255),

	Increment = 1,

	ValueName = "数值",

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value

	end    

})

Tab:AddSlider({

	Name = "跳跃高度",

	Min = 50,

	Max = 200,

	Default = 50,

	Color = Color3.fromRGB(255,255,255),

	Increment = 1,

	ValueName = "数值",

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value

	end    

})

Tab:AddTextbox({

	Name = "跳跃高度设置",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value

	end

})

Tab:AddTextbox({

	Name = "移动速度设置",

	Default = "",

	TextDisappear = true,

	Callback = function(Value)

		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value

	end

})

Tab:AddButton({
	Name = "满亮光",
	Callback = function()
		local lighting = game.Lighting
		lighting.Brightness = 2
		lighting.ClockTime = 14
		lighting.FogEnd = 100000
		lighting.GlobalShadows = false
		lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	end    
})
Tab:AddButton({
	Name = "给出永久NormalKey(先选择一个NormalKey)",
	Callback = function()
		game.Players.LocalPlayer.PlayerFolder.Inventory.NormalKeyCard:Destroy()
		local d = Instance.new("NumberValue")
		d.Name = "NormalKeyCard"
		d.Parent = game.Players.LocalPlayer.PlayerFolder.Inventory
	end    
})
Tab:AddButton({
	Name = "给永久的InnerKeyCard(先选一个InnerKeyCard)",
	Callback = function()
		game.Players.LocalPlayer.PlayerFolder.Inventory.InnerKeyCard:Destroy()
		local d = Instance.new("NumberValue")
		d.Name = "InnerKeyCard"
		d.Parent = game.Players.LocalPlayer.PlayerFolder.Inventory
	end    
})
Tab:AddToggle({
	Name = "无近端时长",
	Default = true,
	Flag = "asdas",
	Save = true
})
Tab:AddToggle({
	Name = "通知怪物",
	Default = true,
	Flag = "NotifyMonster",
	Save = true
})
Tab:AddToggle({
	Name = "避免任何怪物(测试)",
	Default = true,
	Flag = "avoids",
	Save = true
})
Tab:AddToggle({
	Name = "无眼部感染",
	Default = true,
	Flag = "noeyefestation",
	Save = true
})
Tab:AddToggle({
	Name = "无探照灯",
	Default = true,
	Flag = "Searchlights",
	Save = true
})
Tab:AddToggle({
	Name = "无蒸汽",
	Default = true,
	Flag = "steaming",
	Save = true
})
Tab:AddToggle({
	Name = "钥匙显示",
	Default = true,
	Flag = "keys",
	Save = true,
	Callback = function(Value)
		for _, cham in pairs(key) do
			cham.Enabled = Value
		end
	end    
})
Tab:AddToggle({
	Name = "怪物显示",
	Default = true,
	Flag = "monsters",
	Save = true,
	Callback = function(Value)
		for _, cham in pairs(monster) do
			cham.Enabled = Value
		end
	end    
})
Tab:AddToggle({
	Name = "戏弄室显示",
	Default = true,
	Flag = "TricksterRoomdanger",
	Save = true,
	Callback = function(Value)
		for _, cham in pairs(trickster) do
			cham.Enabled = Value
		end
	end    
})
Tab:AddToggle({
	Name = "怪物储物柜显示",
	Default = true,
	Flag = "monsterlocker",
	Save = true,
	Callback = function(Value)
		for _, cham in pairs(locker) do
			cham.Enabled = Value
		end
	end    
})
local function applykey(inst)
	local text = Instance.new("BillboardGui")
	text.Name = "key"
	text.Adornee = inst
	text.Size = UDim2.new(0, 200, 0, 50)
	text.StudsOffset = Vector3.new(0, 2, 0)
	text.AlwaysOnTop = true
	text.Parent = game.CoreGui
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.Text = inst.Name
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 1
	label.TextStrokeTransparency = 0
	label.TextScaled = true
	label.Parent = text
	table.insert(key, text)
end
local function applymos(inst)
	local text = Instance.new("BillboardGui")
	text.Name = "mons"
	text.Adornee = inst
	text.Size = UDim2.new(0, 200, 0, 50)
	text.StudsOffset = Vector3.new(0, 2, 0)
	text.AlwaysOnTop = true
	text.Parent = game.CoreGui
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.Text = inst.Name
	label.TextColor3 = Color3.new(1, 0, 0)
	label.BackgroundTransparency = 1
	label.TextStrokeTransparency = 0
	label.TextScaled = true
	label.Parent = text
	table.insert(monster, text)
end
local function applylocker(inst)
	local text = Instance.new("BillboardGui")
	text.Name = "locker"
	text.Adornee = inst
	text.Size = UDim2.new(0, 200, 0, 50)
	text.StudsOffset = Vector3.new(0, 2, 0)
	text.AlwaysOnTop = true
	text.Parent = game.CoreGui
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.Text = "Monster Locker"
	label.TextColor3 = Color3.new(0.5, 0, 0.5) 
	label.BackgroundTransparency = 1
	label.TextStrokeTransparency = 0
	label.TextScaled = true
	label.Parent = text
	table.insert(locker, text)
end
local function applytrickster(inst)
	local text = Instance.new("BillboardGui")
	text.Name = "locker"
	text.Adornee = inst
	text.Size = UDim2.new(0, 200, 0, 50)
	text.StudsOffset = Vector3.new(0, 2, 0)
	text.AlwaysOnTop = true
	text.Parent = game.CoreGui
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.Text = "Do not enter"
	label.TextColor3 = Color3.new(1, 1, 1) 
	label.BackgroundTransparency = 1
	label.TextStrokeTransparency = 0
	label.TextScaled = true
	label.Parent = text
	table.insert(trickster, text)
end
local keycor = coroutine.create(function()
	workspace.Rooms.DescendantAdded:Connect(function(inst)
		if inst:IsA("Model") and inst:GetAttribute("InteractionType") == "KeyCard" then
			applykey(inst)
		end
		if inst:IsA("Model") and inst:GetAttribute("InteractionType") == "InnerKeyCard" then
			applykey(inst)
		end
	end)
end)
coroutine.resume(keycor)
for _, v in ipairs(workspace.Rooms:GetDescendants()) do
	if v:IsA("Model") and v:GetAttribute("InteractionType") == "KeyCard" then
		applykey(v)
	end
	if v:IsA("Model") and v:GetAttribute("InteractionType") == "InnerKeyCard" then
		applykey(v)
	end
end
workspace.ChildAdded:Connect(function(inst)
	local sikibid = {}
	for _, descendant in ipairs(game.ReplicatedStorage.DeathFolder:GetDescendants()) do
		table.insert(sikibid, descendant.Name)
	end
	if table.find(sikibid, inst.Name) then
		if OrionLib.Flags.NotifyMonster.Value then
			OrionLib:MakeNotification({
				Name = "A monster has spawned go hide in the closet",
				Content = "WARNING!!!!!!!!!!!!",
				Image = "rbxassetid://18942670945",
				Time = 10
			})
		end
		if OrionLib.Flags.monsters.Value then
			applymos(inst)
		end
		if OrionLib.Flags.avoids.Value then
			local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
			local tp = game:GetService("RunService").Heartbeat:Connect(function()
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(p.Position)
			end)
			inst.Destroying:Wait()
			tp:Disconnect()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(oldpos)
		end
	end
end)

workspace.DescendantAdded:Connect(function(inst)
	if inst.Name == "Eyefestation" and OrionLib.Flags.noeyefestation.Value then
		task.wait(0.1)
		inst:Destroy()
	end
	if inst.Name == "SearchlightsEncounter" and OrionLib.Flags.Searchlights.Value then
		wait(10)
		inst:Destroy()
	end
	if inst:IsA("ProximityPrompt") and OrionLib.Flags.asdas.Value then
		task.wait(0.1)
		inst.HoldDuration = 0
	end
	if inst.Name == "Steams" and OrionLib.Flags.steaming.Value then
		task.wait(0.1)
		inst:Destroy()
	end
	if inst.Name == "MonsterLocker" and OrionLib.Flags.monsterlocker.Value then
		task.wait(0.1)
		applylocker(inst)
	end
	if inst.Name == "TricksterRoom" and OrionLib.Flags.TricksterRoomdanger.Value then
		task.wait(0.1)
		applytrickster(inst)
	end
end)
for _, v in ipairs(workspace:GetDescendants()) do
	if v.Name == "MonsterLocker" and OrionLib.Flags.monsterlocker.Value then
		applylocker(v)
	end
end
game:GetService("RunService").Heartbeat:Connect(function()
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = sp
end)