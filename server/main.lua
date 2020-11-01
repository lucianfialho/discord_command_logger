local thisResource = GetCurrentResourceName()

local DiscordWebHookSettings = {
    url = Config.discordWebHookUrl,
    image = Config.discordWebHookImage
}

RegisterServerEvent('commandLoggerDiscord:commandWasExecuted')
AddEventHandler('commandLoggerDiscord:commandWasExecuted', function(playerId, data)
    local commandChecker = CommandChecker()

    if commandChecker.isCommand(data.message) then
        local webhook = Webhook(DiscordWebHookSettings.url, DiscordWebHookSettings.image)
        webhook.send(playerId, data.message)
    end
end)