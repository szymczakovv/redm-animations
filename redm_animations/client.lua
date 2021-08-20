MenuData = {}
local playing = false

TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)

local Animations = {
	{
		items = {
			{label = "1", value = 1, dict = "amb_work@world_human_box_pickup@1@male_a@stand_exit_withprop", anim = "exit_front"}
		}
	}
}


CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 0xF3830D8E) then
            Animations()
        end
    end
    while playing == true do 
        for _, i in ipairs(Animations) do
            for _,a in ipairs(i.items) do
                RequestAnimDict(a.dict)
            end
        end
    end
end)

function Animations()
    MenuData.CloseAll()
    local elements = {}

    for _, i in ipairs(Animations) do
        for _,a in ipairs(i.items) do
            table.insert(elements, {
                label = a.label,
                value = 1,
                dict = a.dict,
                anim = a.anim,
            })
        end
    end

    table.insert(elements, {
        label = '- PRZERWIJ -', 
        value = 0
        dict = nil,
        anim = nil
    })
    
    MenuData.Open(
        'default', GetCurrentResourceName(), 'animations',
        {
            title    = 'Menu Animacji',
            align    = 'right',
            elements = elements,
        },
        function(data, menu)
            if data.current.value == 0 then 
                ClearPedTasksImmediately(PlayerPedId())
                playing = false
            else
                playing = true
                TaskPlayAnim(PlayerPedId(), data.current.dict, data.current.anim, 1.0, 8.0, -1, 1, 0, false, false, false)
            end
        end,
                
    function(data, menu)
        menu.close()
    end)  
end
