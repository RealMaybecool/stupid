local anti = loadstring(game:HttpGet("https://raw.githubusercontent.com/RealMaybecool/stupid/refs/heads/main/secret.lua"))()

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
   Name = "⚔️ BobaX Blade Ball Hub",
   LoadingTitle = "BobaX Loader",
   LoadingSubtitle = "by Boba Devs",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BobaX_BladeBall",
      FileName = "Config"
   },
   Discord = {
      Enabled = false,
      Invite = "discord.gg/nytherune",
      RememberJoins = true
   },
   KeySystem = false
})

local Tab = Window:CreateTab("Main", 4483362458)
local Section = Tab:CreateSection("Core Features")

Tab:CreateToggle({
   Name = "Auto Parry",
   CurrentValue = false,
   Flag = "AutoParry",
   Callback = function(v)
      getgenv().AutoParry = v
      task.spawn(function()
         while getgenv().AutoParry do
            for _,ball in pairs(workspace:GetChildren()) do
               if ball.Name == "Ball" and ball:IsA("BasePart") then
                  local dist = (ball.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                  if dist < 30 then
                     game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                     task.wait(0.05)
                     game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
                  end
               end
            end
            task.wait(0.05)
         end
      end)
   end
})

Tab:CreateToggle({
   Name = "Auto Dash",
   CurrentValue = false,
   Flag = "AutoDash",
   Callback = function(v)
      getgenv().AutoDash = v
      task.spawn(function()
         while getgenv().AutoDash do
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
               for _,ball in pairs(workspace:GetChildren()) do
                  if ball.Name == "Ball" and ball:IsA("BasePart") then
                     if (ball.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "Q", false, game)
                        task.wait(0.05)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "Q", false, game)
                     end
                  end
               end
            end
            task.wait(0.1)
         end
      end)
   end
})

local espEnabled = false
local trajectoryEnabled = false
local ballsESP = {}

Tab:CreateToggle({
   Name = "Ball ESP",
   CurrentValue = false,
   Flag = "BallESP",
   Callback = function(v)
      espEnabled = v
      if not v then
         for _,esp in pairs(ballsESP) do
            if esp and esp.Parent then esp:Destroy() end
         end
         ballsESP = {}
      end
   end
})

Tab:CreateToggle({
   Name = "Trajectory Prediction",
   CurrentValue = false,
   Flag = "Trajectory",
   Callback = function(v)
      trajectoryEnabled = v
   end
})

game:GetService("RunService").RenderStepped:Connect(function()
   if espEnabled then
      for _,ball in pairs(workspace:GetChildren()) do
         if ball.Name == "Ball" and ball:IsA("BasePart") then
            if not ballsESP[ball] then
               local Billboard = Instance.new("BillboardGui")
               Billboard.Size = UDim2.new(0,100,0,40)
               Billboard.AlwaysOnTop = true
               Billboard.Adornee = ball
               local Label = Instance.new("TextLabel")
               Label.Size = UDim2.new(1,0,1,0)
               Label.BackgroundTransparency = 1
               Label.Text = "⚪ BALL"
               Label.TextColor3 = Color3.fromRGB(0,255,0)
               Label.TextScaled = true
               Label.Parent = Billboard
               Billboard.Parent = ball
               ballsESP[ball] = Billboard
            end
         end
      end
   end
   if trajectoryEnabled then
      for _,ball in pairs(workspace:GetChildren()) do
         if ball.Name == "Ball" and ball:IsA("BasePart") then
            if ball:FindFirstChild("BodyVelocity") then
               local direction = ball.Velocity.Unit * 10
               local ray = Instance.new("Part")
               ray.Anchored = true
               ray.CanCollide = false
               ray.Size = Vector3.new(0.2,0.2,5)
               ray.CFrame = CFrame.new(ball.Position, ball.Position + direction) * CFrame.new(0,0,-2.5)
               ray.BrickColor = BrickColor.new("Bright red")
               ray.Material = Enum.Material.Neon
               ray.Transparency = 0.25
               ray.Parent = workspace
               game:GetService("Debris"):AddItem(ray,0.05)
            end
         end
      end
   end
end)

Tab:CreateButton({
   Name = "Silent Anti-Ban Reload",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/RealMaybecool/stupid/refs/heads/main/secret.lua"))()
   end
})
