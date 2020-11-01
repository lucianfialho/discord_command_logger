function Webhook(webHookUrl, webHookImage)
    local self = {}

    self.webHookUrl = webHookUrl
    self.webHookImage = webHookImage or 'https://pbs.twimg.com/profile_images/1298948209876893698/pJHwyN9__400x400.jpg'

    if not self.webHookUrl then 
        error('discordWebHookUrl was expected but got nil')
        return
    end

    self.send = function(playerId, rawCommand)
        local messageObj = self.messageBuilder(playerId, rawCommand)
        PerformHttpRequest(self.webHookUrl, function(err, text, header) print(err, text) end,
        'POST',
        json.encode(messageObj), {['Content-Type'] = 'application/json'}) 
    end

    self.messageBuilder = function(playerId, rawCommand)
        local playerName = GetPlayerName(source)
    
        return {
            embeds = {
              {
                title = playerName..' was execute a command',
                description = '```'.. rawCommand ..'```',
                url = 'https://github.com/lucianfialhobp',
                color = 3666853,
                thumbnail = {
                  url = self.webHookImage
                },
                author = {
                  name = GetPlayerName(source),
                },
              },
            }
          }
    end

    return self

end
