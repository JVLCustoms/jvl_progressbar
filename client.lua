

local progressActive = false -- varible to see if there is a progressbar active
local cancelRequested = false -- set by the cancelProgressbar export
local cancelKey = 322 -- ESC key

-- Controls blocked by each `disable` option.
local blockedControls = {
    move = { 21, 22, 30, 31, 32, 33, 34, 35, 36, 44 },             -- Sprint, jump, walk, duck, cover
    car = { 59, 60, 63, 64, 71, 72, 75, 76 },                      -- Steer, accelerate, brake, exit, handbrake
    combat = { 24, 25, 37, 45, 47, 58, 140, 141, 142, 143, 257, 263, 264 }, -- Attack, aim, weapon wheel, reload, melee
    mouse = { 1, 2, 106 },                                         -- Look around
}

--- Blocks the controls of every enabled option for this frame.
---@param disable table { move?, car?, combat?, mouse? }
local function blockControls(disable)
    for option, controls in pairs(blockedControls) do
        if disable[option] then
            for _, control in ipairs(controls) do DisableControlAction(0, control, true) end
        end
    end
    if disable.combat then DisablePlayerFiring(PlayerId(), true) end
end

-- Función principal de la barra de progreso
---@param disable? table { move?, car?, combat?, mouse? } What the player cannot do while the bar runs (defaults to Config.Default.disable).
function startProgressbar(duration, text, animDict, animName, onFinish, onCancel, disable)
    disable = disable or Config.Default.disable or {}
    if progressActive then   -- if there is a progressbar active
        if Config.Debug then -- if debug is enabled
            print("^3[JVL Progressbar] There's an active bar^7")
        end
        return 
    end

    local time = duration or Config.Default.duration -- duration of the progressbar
    local label = text or Config.Default.text -- text of the progressbar
    progressActive = true -- set the progressbar as active
    cancelRequested = false
    local canceled = false -- if the progressbar was canceled

    if Config.Debug then -- if debug is enabled
        print("^2[JVL Progressbar] Iniciando: " .. label .. " (" .. time .. "ms)^7") -- print the progressbar info
    end

    -- Load animation if specified
    if animDict and animName then -- if animation is specified
        RequestAnimDict(animDict) 
        local timeout = GetGameTimer() + 3000 -- timeout for animation to load
        while not HasAnimDictLoaded(animDict) and GetGameTimer() < timeout do  -- wait for animation to load
            Wait(10)  
        end
        
        if HasAnimDictLoaded(animDict) then -- if animation loaded successfully
            TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, 8.0, -1, 1, 0, false, false, false) -- play animation
        end
    end

    -- Send data to the NUI_status
    SendNUIMessage({ -- send data to the NUI
        type = "progressbar",   -- type of message
        action = "start",       -- action to perform
        time = time,            -- time of the progressbar
        text = label,           -- text of the progressbar
        style = Config.Style    -- style of the progressbar
    })

    -- Cancel progressbar if ESC key is pressed 
    CreateThread(function() 
        local startTime = GetGameTimer() -- get start time
        
        while progressActive do -- while progressbar is active
            -- Verificar cancelación (ESC or cancelProgressbar export)
            if IsControlJustReleased(0, cancelKey) or cancelRequested then -- if ESC key is pressed
                canceled = true      -- set canceled to true
                if Config.Debug then -- if debug is enabled
                    print("^1[JVL Progressbar] Cancel for user^7") -- print message
                end
                break -- break the loop
            end
            
            -- Verificar si terminó el tiempo
            if GetGameTimer() - startTime >= time then -- if time is over
                if Config.Debug then -- if debug is enabled
                    print("^2[JVL Progressbar] Completado^7") 
                end
                break -- break the loop
            end

            blockControls(disable)
            Wait(0)
        end

        progressActive = false -- set progressActive to false
        
        -- Limpiar animación
        if animDict and animName then -- if animation is specified
            ClearPedTasks(PlayerPedId()) 
            RemoveAnimDict(animDict) 
        end

        -- Cerrar interfaz
        SendNUIMessage({ -- send data to the NUI
            type = "progressbar", -- type of message
            action = "stop" -- action to perform
        })
        
        Wait(100)

        -- Ejecutar callbacks
        if canceled and onCancel then -- if canceled and onCancel is specified
            onCancel() 
        elseif not canceled and onFinish then -- if not canceled and onFinish is specified
            onFinish() 
        end 
    end)
end

-- Event to iniciate the progressbar
RegisterNetEvent('jvl_progressbar:start', function(text, duration) -- event to iniciate the progressbar
    startProgressbar(duration, text) -- call the function
end)

-- Export function to start the progressbar
exports('startProgressbar', function(duration, text, animDict, animName, onFinish, onCancel, disable) -- export function to start the progressbar
    startProgressbar(duration, text, animDict, animName, onFinish, onCancel, disable) -- call the function
end)

-- Cancels the running progressbar from another script (its onCancel callback runs).
exports('cancelProgressbar', function()
    if progressActive then cancelRequested = true end
end)

-- True while a progressbar is running.
exports('isProgressActive', function() return progressActive end)

-- Display only (no controls, no animation, no timer): used by ox_lib's lib.progressBar,
-- which keeps its own logic and only asks us to draw the bar.
exports('ShowBar', function(text, duration)
    SendNUIMessage({ type = 'progressbar', action = 'start', time = duration or Config.Default.duration, text = text or Config.Default.text, style = Config.Style })
end)

exports('HideBar', function(cancelled)
    SendNUIMessage({ type = 'progressbar', action = cancelled and 'cancel' or 'stop' })
end)

-- Command to test the progressbar
RegisterCommand('testprogress', function(source, args) 
    local duration = tonumber(args[1]) or 3000 -- default duration is 3000ms
    local text = table.concat(args, " ", 2) or "Test progressbar" -- default text is "Prueba de barra"
    
    startProgressbar(duration, text, nil, nil, function() 
        print("^2Prueba completada!^7") --  print when the progressbar is finished
    end, function() 
        print("^1Prueba cancelada!^7") -- print when the progressbar is canceled
    end)
end, false)

