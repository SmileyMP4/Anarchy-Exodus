if anarchy_loaded then
    toast.add_error("Anarchy is already loaded.", "Already Load")
    return
end

anarchy_loaded = true

local anarchy_version = "1.0.0"

local update_date = "08/11/2023"

local Player_Parents = {}
local Player_Feature = {}
local Local_Parents = {}
local Local_Feature = {}

script.set_name("Anarchy v"..anarchy_version)
--script.set_desc("idk")

local function print(text)
    return log.add_info(tostring(text))
end

local function player_list(include_me)
    local pid = -1
    if not include_me then
        include_me = native.player.player_id()
    end
    return function()
        repeat
            pid = pid + 1
        until pid == 32 or (include_me ~= pid and player.is_connected(pid))
        if pid ~= 32 then
            return pid
        end
    end
end

local function player_count()
    count = 0
    for pid in player_list(true) do
        count = count + 1
    end
    return count
end

local function get_value(option)
    return tonumber(string.format("%.2f", option:get_value()))
end

local toggle_locked = {}
local function add_toggle(submenu, label, hints, callback)
    return submenu:add_toggle(label, hints, function()
        if not toggle_locked[label] then
            toggle_locked[label] = true
            callback()
            toggle_locked[label] = false
        end
    end)
end

local toggle_slider_int_locked = {}
local function add_toggle_slider_int(submenu, label, initial_value, minimum, maximum, step, hints, callback)
    return submenu:add_slider_int(label, initial_value, minimum, maximum, step, true, hints, function()
        if not toggle_slider_int_locked[label] then
            toggle_slider_int_locked[label] = true
            callback()
            toggle_slider_int_locked[label] = false
        end
    end)
end

local toggle_slider_float_locked = {}
local function add_toggle_slider_float(submenu, label, initial_value, minimum, maximum, step, hints, callback)
    return submenu:add_slider_float(label, initial_value, minimum, maximum, step, true, hints, function()
        if not toggle_slider_float_locked[label] then
            toggle_slider_float_locked[label] = true
            callback()
            toggle_slider_float_locked[label] = false
        end
    end)
end

--[[
thread.create(function()
    while true do

        thread.yield()
    end
end)
]]

Player_Parents["player root"] = menu.player_root()

Local_Parents["script root"] = menu.script_root()

--[[
Local_Feature["toggle"] = add_toggle(Local_Parents["script root"], "toggle", {}, function()
    if Local_Feature["toggle"]:get_toggle() then

    end
    while Local_Feature["toggle"]:get_toggle() do

        thread.yield()
    end
    if not Local_Feature["toggle"]:get_toggle() then

    end
end)

Local_Feature["toggle_slider_int"] = add_toggle_slider_int(Local_Parents["script root"], "toggle_slider_int", 0, -10, 10, 1, {}, function()
    if Local_Feature["toggle_slider_int"]:get_toggle() then

    end
    while Local_Feature["toggle_slider_int"]:get_toggle() do

        thread.yield()
    end
    if not Local_Feature["toggle_slider_int"]:get_toggle() then

    end
end)

Local_Feature["toggle_slider_float"] = add_toggle_slider_float(Local_Parents["script root"], "toggle_slider_float", 0.0, 0.0, 1.0, 0.10, {}, function()
    if Local_Feature["toggle_slider_float"]:get_toggle() then

    end
    while Local_Feature["toggle_slider_float"]:get_toggle() do

        thread.yield()
    end
    if not Local_Feature["toggle_slider_float"]:get_toggle() then

    end
end)
]]

Local_Feature["Collision Radius"] = add_toggle_slider_float(Local_Parents["script root"], "Collision Radius", 1.00, 0.10, 5.00, 0.10, {"Change your player's collision radius."}, function()
    while Local_Feature["Collision Radius"]:get_toggle() do
        native.ped.set_ped_capsule(native.player.player_ped_id(), get_value(Local_Feature["Collision Radius"]))
        thread.yield()
    end
end)

Local_Feature["Screenshot Mode"] = Local_Parents["script root"]:add_toggle("Screenshot Mode", {"Makes the Hud Invisible."}, function(toggle)
    native.hud.display_hud(toggle ~= true)
end)

script.on_shutdown(function()
    toast.add_success("Anarchy v"..anarchy_version, "Anarchy has been deleted.")
end)

toast.add_success("Anarchy v"..anarchy_version, "Version: "..anarchy_version.."\nUpdated on: "..update_date.."\nDev: [3arc] Smiley\nAccess: Standard\n\nAnarchy is correctly loaded.")

script.keep_alive()