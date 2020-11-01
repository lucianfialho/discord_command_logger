function CommandChecker()
    local self = {}

    self.commandStartCharacter = '/'
    self.rawCommand = {}

    self.isCommand = function(text)
        return text:sub(1, #self.commandStartCharacter) == self.commandStartCharacter
    end
    
    self.splitCommand = function(command)
        for token in string.gmatch(command, "[^%s]+") do
            table.insert(self.rawCommand, token)
        end

        return self.rawCommand
    end

    return self
end