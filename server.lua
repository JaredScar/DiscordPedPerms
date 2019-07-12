-----------------------
--- DiscordPedPerms ---
-----------------------
roleList = {
1, -- Trusted Civ (1)
1, -- Donator (2)
1, -- Personal (3)
}

RegisterNetEvent('Print:PrintDebug')
AddEventHandler('Print:PrintDebug', function(msg)
	print(msg)
	TriggerClientEvent('chatMessage', -1, "^7[^1Badger's Scripts^7] ^1DEBUG ^7" .. msg)
end)

RegisterNetEvent("DiscordPedPerms:CheckPerms")
AddEventHandler("DiscordPedPerms:CheckPerms", function()
	local src = source
	for k, v in ipairs(GetPlayerIdentifiers(src)) do
		if string.sub(v, 1, string.len("discord:")) == "discord:" then
			identifierDiscord = v
		end
	end
	local hasPerms = {} -- Has perms for indexes:
	if identifierDiscord then
		local roleIDs = exports.discord_perms:GetRoles(src)
		-- Loop through roleList and set their role up:
		if not (roleIDs == false) then
			for i = 1, #roleList do
				for j = 1, #roleIDs do
					local roleID = roleIDs[j]
					if (tostring(roleList[i]) == tostring(roleID)) then
						table.insert(hasPerms, i)
					end
				end
			end
		else
			print(GetPlayerName(src) .. " has not gotten their permissions cause roleIDs == false")
		end
	end
	TriggerClientEvent('DiscordPedPerms:CheckPerms:Return', src, hasPerms)
end)