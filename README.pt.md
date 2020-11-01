# discord_command_logger

## Resumo
Esse script ao ser instalado irá criar um logger de todos os comando executados no seu sevidor e jogar todas essa informações para um canal seu do discord :)

![image](https://media.discordapp.net/attachments/772473741535346698/772542456663113728/unknown.png)

You can also read this README in [Portuguese](https://github.com/lucianfialhobp/discord_command_logger/blob/main/README.pt.md).


## Criando webhook no discord
Você pode ver como criar um webhook para o seu canal do discord [aqui](https://support.discord.com/hc/pt-br/articles/228383668-Usando-Webhooks)

## Download & Instalação

### Download Usando GIT

```
cd resources
git clone https://github.com/lucianfialhobp/discord_command_logger.git discord_command_logger
```


### Instalaçao
- Adicione no seu `server.cfg`:

```
ensure discord_command_logger
```

- Defina suas configurações do discord no config.lua

```
Config.discordWebHookUrl = 'YOUR_WEBHOOK_YOU_SET_HERE'
Config.discordWebHookImage = 'YOUR_WEBHOOK_IMAGE_YOU_SET_HERE'
```

- Dispare `commandLoggerDiscord:commandWasExecuted` no arquivo resources/chat/cl_chat.lua:112 como você pode ver abaixo:

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
