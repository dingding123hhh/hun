local LBLG = Instance.new("ScreenGui", getParent)
local LBL = Instance.new("TextLabel", getParent)
local player = game.Players.LocalPlayer

LBLG.Name = "LBLG"
LBLG.Parent = game.CoreGui
LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LBLG.Enabled = true
LBL.Name = "LBL"
LBL.Parent = LBLG
LBL.BackgroundColor3 = Color3.new(1, 1, 1)
LBL.BackgroundTransparency = 1
LBL.BorderColor3 = Color3.new(0, 0, 0)
LBL.Position = UDim2.new(0.75,0,0.010,0)
LBL.Size = UDim2.new(0, 133, 0, 30)
LBL.Font = Enum.Font.GothamSemibold
LBL.Text = "TextLabel"
LBL.TextColor3 = Color3.new(1, 1, 1)
LBL.TextScaled = true
LBL.TextSize = 14
LBL.TextWrapped = true
LBL.Visible = true

local FpsLabel = LBL
local Heartbeat = game:GetService("RunService").Heartbeat
local LastIteration, Start
local FrameUpdateTable = { }

local function HeartbeatUpdate()
    LastIteration = tick()
    for Index = #FrameUpdateTable, 1, -1 do
        FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
    end
    FrameUpdateTable[1] = LastIteration
    local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
    CurrentFPS = CurrentFPS - CurrentFPS % 1
    FpsLabel.Text = ("时间:"..os.date("%H").."时"..os.date("%M").."分"..os.date("%S"))
end
Start = tick()
Heartbeat:Connect(HeartbeatUpdate)

local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/hun/main/library1.lua"))();        
local win = ui:new("禁漫中心")
--
local UITab1 = win:Tab("『信息』",'18930485323')

local about = UITab1:section("『信息』",true)



about:Label("禁漫中心㍿")
about:Label("作者QQ：198436746")
about:Label("QQ主群：1001390385")
about:Label("QQ2群： 950954309")
about:Label("QQ3群： 930667114")
about:Label("作者：丁丁")
about:Label("进群发最新禁漫天堂")
about:Label("脚本持续更新中")
about:Label("脚本疯狂优化中")
about:Label("           ")
about:Label("           ")
about:Label("你的注入器:"..identifyexecutor())
about:Label("你的用户名:"..game.Players.LocalPlayer.Character.Name)
about:Label("服务器id:"..game.GameId)



local about = UITab1:section("『公告』",true)

about:Label("原本我是不想更新的")
about:Label("但是昨天有人让我非要更新")
about:Label("那就小小更一波")
about:Label("       ")
about:Label("       ")
about:Label("大家不要用皮脚本 皮脚本会让手机爆炸<㉿")


local UITab2 = win:Tab("『通用』",'1000022856')

local about = UITab2:section("『通用』",true)

about:Button("玩家加入游戏提示",function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
end)
