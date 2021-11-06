
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local v2 = RaycastParams.new();
v2.IgnoreWater = false;
local l__LocalPlayer__1 = game:GetService("Players").LocalPlayer;
local u2 = tick();
local u3 = nil;
local l__RunService__4 = game:GetService("RunService");
local u5 = tick();
local l__Splash__6 = l__ReplicatedStorage__1:WaitForChild("Relays"):WaitForChild("Replication"):WaitForChild("Splash");
local u7 = tick();
local l__SoundService__8 = game:GetService("SoundService");
local u9 = require(l__ReplicatedStorage__1:WaitForChild("FunctionLibrary"));
local u10 = Random.new();
u9.BindToCharacter(function()
	while true do
		wait();
		if tick() - u2 > 10 then
			break;
		end;	
	end;
	local l__Character__11 = l__LocalPlayer__1.Character;
	local u12 = 0;
	u3 = l__RunService__4.RenderStepped:Connect(function(p1)
		local v3 = l__Character__11 and l__Character__11:FindFirstChild("Humanoid");
		p1 = math.clamp(p1, 0.016, 0.033);
		if v3 then
			if v3:GetState() == Enum.HumanoidStateType.Freefall then
				if not l__Character__11.PrimaryPart:FindFirstChild("InteractionWeld") then
					local v4 = workspace:Raycast(l__Character__11.PrimaryPart.Position, Vector3.new(0, -15, 0), v2);
					if v4 and v4.Position and (l__Character__11.PrimaryPart.Position - v4.Position).Magnitude > 8 then
						u12 = u12 + p1;
					end;
				end;
			else
				u12 = 0;
			end;
			if v3:GetState() == Enum.HumanoidStateType.Freefall and u12 > 0.85 or v3:GetState() == Enum.HumanoidStateType.Physics then
				v2.FilterDescendantsInstances = { l__LocalPlayer__1.Character };
				v2.FilterType = Enum.RaycastFilterType.Blacklist;
				local v5 = workspace:Raycast(l__Character__11.PrimaryPart.Position, Vector3.new(0, -15, 0), v2);
				if v5 and v5.Position and (l__Character__11.PrimaryPart.Position - v5.Position).Magnitude < 5 then
					if v5.Material == Enum.Material.Water then
						if tick() - u5 > 5 then
							u5 = tick();
							l__Splash__6:FireServer(v5.Position);
						end;
					elseif v3:GetState() == Enum.HumanoidStateType.Physics and tick() - u7 > 0.6 then
						u7 = tick();
						if l__Character__11.PrimaryPart.Velocity.Magnitude > 60 then
							local l__CarHitPlayer__6 = l__ReplicatedStorage__1:WaitForChild("Sounds"):WaitForChild("CarHitPlayer");
							local v7 = l__CarHitPlayer__6:GetChildren()[math.random(1, #l__CarHitPlayer__6:GetChildren())];
							if v7 then
								l__SoundService__8:PlayLocalSound(v7);
							end;
						end;
					end;
				end;
			end;
      --// code in this section creates glitch where character ragdolls on jump \\--
			if u12 >= 1.1 then
				if v3:GetState() == Enum.HumanoidStateType.Freefall then
					u9.Ragdoll(l__Character__11, v3, true, 1.75, true);
				end;
				l__Character__11.PrimaryPart.RotVelocity = l__Character__11.PrimaryPart.RotVelocity + Vector3.new(u10:NextInteger(-2, 2), u10:NextInteger(-2, 2), u10:NextInteger(-2, 2));
			end;
      --// End section \\--
		end;
	end);
end, function()
	if u3 then
		u3:Disconnect();
		u3 = nil;
	end;
end);
