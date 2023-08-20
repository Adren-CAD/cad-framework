API_URL = GetConvar('cad_internal_API')

local resourceName = GetCurrentResourceName()

if resourceName ~= 'adrenCAD' then
    TriggerEvent('adrenCAD:log', 'It is highly reccomended too rename the resource to "adrenCAD"', true)
    TriggerEvent('adrenCAD:log', 'Leaving the resource name as "' .. resourceName .. '" will cause issues!', true)
end