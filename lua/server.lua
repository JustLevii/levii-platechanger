---@diagnostic disable: trailing-space


if Config.Core == 'qb' then
    
-- Core
local QBCore = exports['qb-core']:GetCoreObject()


-- Callback
lib.callback.register('levii-platechanger:server:CheckOwnerVehicle', function(_, oldPlate)
    local Player = QBCore.Functions.GetPlayer(source)
    local result = MySQL.single.await('SELECT plate FROM player_vehicles WHERE plate = ? AND citizenid = ?', {oldPlate,Player.PlayerData.citizenid})
    if not result then return end  
    return true 
end)


-- Event
RegisterNetEvent('levii-platechanger:server:updatePlate', function(netID, oldPlate, newPlate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local checkPlate = MySQL.query.await('SELECT * FROM player_vehicles WHERE plate = ?', {newPlate})
    if not checkPlate[1] then 
        MySQL.query('SELECT plate, mods FROM player_vehicles WHERE plate = ?', {oldPlate},function(result)
            if result[1] then
                local veh = NetworkGetEntityFromNetworkId(netID)
                local mods = json.decode(result[1].mods)
                mods["plate"] = newPlate
                MySQL.update('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(mods),oldPlate})
                MySQL.update('UPDATE player_vehicles SET plate = ? WHERE plate = ?', {newPlate,oldPlate})
                SetVehicleNumberPlateText(veh,newPlate)
                TriggerClientEvent('levii-platechanger:client:libNotify', src , Config.Lang['notify'].newlicenseplate ..newPlate, 'success')
                Player.Functions.RemoveItem('licenseplate', 1)
            end
        end)
    else
        TriggerClientEvent('levii-platechanger:client:libNotify', src , Config.Lang['notify'].sameplate, 'error')
    end
end)


-- Item
QBCore.Functions.CreateUseableItem('licenseplate', function(source)
    TriggerClientEvent('levii-platechanger:client:Menu',source)
end)

elseif Config.Core == 'esx' then 

-- Core
local ESX = exports["es_extended"]:getSharedObject()


-- Callback
lib.callback.register('levii-platechanger:server:CheckOwnerVehicle', function(_, oldPlate)
    local xPlayer = ESX.GetPlayerFromId(source)
    local result = MySQL.single.await('SELECT plate FROM owned_vehicles WHERE plate = ? AND owner = ?', {oldPlate, xPlayer.identifier})
    if not result then return end  
    return true 
end)


-- Event
RegisterNetEvent('levii-platechanger:server:updatePlate', function(netID, oldPlate, newPlate)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local checkPlate = MySQL.query.await('SELECT * FROM owned_vehicles WHERE plate = ?', {newPlate})
    if not checkPlate[1] then 
        MySQL.query('SELECT plate, vehicle FROM owned_vehicles WHERE plate = ?', {oldPlate},function(result)
            if result[1] then
                local veh = NetworkGetEntityFromNetworkId(netID)
                local vehicle = json.decode(result[1].vehicle)
                vehicle["plate"] = newPlate
                MySQL.update('UPDATE owned_vehicles SET vehicle = ? WHERE plate = ?', {json.encode(vehicle),oldPlate})
                MySQL.update('UPDATE owned_vehicles SET plate = ? WHERE plate = ?', {newPlate,oldPlate})
                SetVehicleNumberPlateText(veh,newPlate)
                TriggerClientEvent('levii-platechanger:client:libNotify', src , Config.Lang['notify'].newlicenseplate ..newPlate, 'success')
                xPlayer.removeInventoryItem('licenseplate', 1)
            end
        end)
    else
        TriggerClientEvent('levii-platechanger:client:libNotify', src , Config.Lang['notify'].sameplate, 'error')
    end
end)

-- Item
ESX.RegisterUsableItem('licenseplate', function(source)
    TriggerClientEvent('levii-platechanger:client:Menu',source)
end)

end
