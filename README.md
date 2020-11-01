# discord_command_logger

## Creating Discord Webhook

How create Discord Webook [here](https://support.discord.com/hc/pt-br/articles/228383668-Usando-Webhooks)

## Download & Installation

### Download Using Git

```
cd resources
git clone https://github.com/lucianfialhobp/discord_command_logger.git discord_command_logger
```


### Installation
- Add this to your `server.cfg`:

```
ensure discord_command_logger
```

- Set discord settings in fxmanifest.lua 

```
discordWebHookUrl 'YOUR_WEBHOOK_YOU_SET_HERE'
discordWebHookImage 'YOUR_WEBHOOK_IMAGE_YOU_SET_HERE'
```

- Trigger `commandLoggerDiscord:commandWasExecuted` in resources/chat/cl_chat.lua:112 like this

```lua
RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false)

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
      -- Trigger Event 'commandLoggerDiscord:commandWasExecuted' below like this
      TriggerServerEvent('commandLoggerDiscord:commandWasExecuted', id, data)
    else
      TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
    end
  end

  cb('ok')
end)
```
