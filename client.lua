local weaponData = {}


for key, value in pairs(Weapons) do
	weaponData[GetHashKey(key)] = value
end 

if Config.AllowCriticalHits then 
	SetPedSuffersCriticalHits(GetPlayerPed(-1), false)
end 

CreateThread(function()
    while true do
        Wait(0)
        
        local playerPed = GetPlayerPed(-1)

		local weapon = GetSelectedPedWeapon(playerPed)

        local weaponsMultiplier = weaponData[weapon]

        if weaponsMultiplier ~= nil and weaponsMultiplier ~= 1.0 then
            SetWeaponDamageModifierThisFrame(weapon, weaponsMultiplier)
        else
            Wait(500)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
			DisableControlAction(1, 140, true)
       	   DisableControlAction(1, 141, true)
           DisableControlAction(1, 142, true)
        end
    end
end)


AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  --print("not  "..tostring(resourceName))
	  return
	end
	
	SetPedSuffersCriticalHits(GetPlayerPed(-1), true)
	
	print('The resource ' .. resourceName .. ' was stopped.')
end)