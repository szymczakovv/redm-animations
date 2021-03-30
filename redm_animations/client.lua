MenuData = {}
local playerPed = PlayerPedId()
local playing = false

TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)

CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 0xF3830D8E) then
            Main_Menu()
        end
    end
    while playing do 
        RequestAnimDict("amb_work@world_human_box_pickup@1@male_a@stand_exit_withprop")
        RequestAnimDict("script_story@wnt4@ig@ig_cme_dutch_letsride")
    end
end)

function Main_Menu()
    MenuData.CloseAll()
    local elements = {
        {label = '- PRZERWIJ -', value = '0'},
        {label = 'Animacje', value = 'anims', desc = 'Naciśnij [ENTER] aby otworzyć menu z Animacjami'},
        {label = 'Emotki', value = 'emotes', desc = 'Naciśnij [ENTER] aby otworzyć menu z Emotkami'},
    }

    MenuData.Open(
        'default', GetCurrentResourceName(), 'exile_animations',
        {
            title    = 'Menu Animacji',
            align    = 'right',
            elements = elements,
        },
        function(data, menu)
            if data.current.value == '0' then 
                ClearPedTasksImmediately(playerPed)
            end
            if data.current.value == 'anims' then
                Animations()
            elseif data.current.value == 'emotes' then
                Emotes()
            end
        end,
                
    function(data, menu)
        menu.close()
    end)  
end

function Animations()
    MenuData.CloseAll()
    local elements = {
        {label = '- PRZERWIJ -', value = '0'},
        {label = 'Test 1', value = '1', dict = 'amb_work@world_human_box_pickup@1@male_a@stand_exit_withprop', anim = 'exit_front'},
        {label = 'Test 2', value = '2', dict = 'script_story@wnt4@ig@ig_cme_dutch_letsride', anim = 'dutch_action'},
    }

    MenuData.Open(
        'default', GetCurrentResourceName(), 'exile_animations',
        {
            title    = 'Menu Animacji',
            align    = 'right',
            elements = elements,
        },
        function(data, menu)
            if data.current.value == '0' then 
                ClearPedTasksImmediately(playerPed)
            end
            if data.current.value == '1' then
                playing = true
                TaskPlayAnim(PlayerPedId(), data.current.dict, data.current.anim, 1.0, 8.0, -1, 1, 0, false, false, false)
            end
            if data.current.value == '2' then
                playing = true
                TaskPlayAnim(PlayerPedId(), data.current.dict, data.current.anim, 1.0, 8.0, -1, 1, 0, false, false, false)
            end
        end,
                
    function(data, menu)
        Main_Menu()
    end)  
end


function Emotes()
    MenuData.CloseAll()
    local elements = {
        {label = '- PRZERWIJ -', value = '0},
        {label = 'Tak Jest!', value = '1'},
    }
    MenuData.Open(
        'default', GetCurrentResourceName(), 'exile_animations',
        {
            title    = 'Menu Animacji',
            align    = 'right',
            elements = elements,
        },
        function(data, menu)
            if data.current.value == '0' then 
                ClearPedTasksImmediately(playerPed)
            end
            if data.current.value == '1' then
                Citizen.InvokeNative(0xB31A277C1AC7B7FF, playerPed, 0, 0, tonumber(-402959), 1, 1, 0, 0)
            end
        end,
                
    function(data, menu)
        Main_Menu()
    end)  
end
