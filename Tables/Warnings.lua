local WarningsModule = require(game:GetService("ServerScriptService"):FindFirstChild("Cmdr").Tables.WarningsModule)

function WarningsModule.addWarning(player, reason)
    local playerWarnings = WarningsModule.getWarnings(player)
    
    -- Increment the warning count
    playerWarnings.count = playerWarnings.count + 1
    
    -- Add the new reason to the list of reasons
    table.insert(playerWarnings.reasons, reason)

    -- Store the updated data back to the DataStore
    WarningsModule.setWarnings(player, playerWarnings)
end
