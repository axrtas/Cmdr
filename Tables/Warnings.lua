local WarningsModule = require(game:GetService("ServerScriptService"):FindFirstChild("Cmdr").Tables.WarningsModule)

function WarningsModule.addWarning(player, reason)
    local playerWarnings = WarningsModule.getWarnings(player)
    
    playerWarnings.count = playerWarnings.count + 1
    
    table.insert(playerWarnings.reasons, reason)

    WarningsModule.setWarnings(player, playerWarnings)
end
