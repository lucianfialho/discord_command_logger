function Webhook(webHookUrl, webHookImage)
    local self = {}

    self.webHookUrl = webHookUrl
    self.webHookImage = webHookImage

    if not self.webHookUrl then 
        error('discordWebHookUrl was expected but got nil')
        return
    end

    self.send = function(playerId, rawCommand)
        local user = self.getPlayerServerInfo()
        local messageObj = self.messageBuilder(user, rawCommand)
        PerformHttpRequest(self.webHookUrl, function(err, text, header) print(err, text) end,
        'POST',
        json.encode(messageObj), {['Content-Type'] = 'application/json'}) 
    end

    self.messageBuilder = function(user, rawCommand)
        local description = self.createDescription(user)
    
        return {
            embeds = {
              {
                title = user.name ..' was execute a command',
                description = '```'.. rawCommand ..'```\n'.. description,
                url = 'https://github.com/lucianfialhobp',
                color = 3666853,
                thumbnail = {
                  url = self.webHookImage
                },
                author = {
                  name = user.name,
                },
              },
            }
          }
    end

    self.getPlayerServerInfo = function ()
      local user = {}
      user.name = GetPlayerName(source)
  
      for k,v in pairs(GetPlayerIdentifiers(source)) do              
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
          user.steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
          user.license = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
          user.ip = v
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
          user.discord = v
        end
      end
  
      return user
    end

    self.createDescription = function(user)
      return string.format("Steam: %s |\n License: %s |\n Ip: %s |\nt Discord: %s |", user.steamid, user.license, user.ip, user.discord)
    end

    return self

end
