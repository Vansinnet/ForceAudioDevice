local mod = get_mod("ForceAudioDevice")

local DEVICE_NAME_SETTING = "device_name"
local SYNC_GAME_SETTING = "sync_game_setting"
local enabled = false
local warned_device_name

local function sync_game_setting(device_index)
    local application = rawget(_G, "Application")
    local get_user_setting = application and application.user_setting
    local set_user_setting = application and application.set_user_setting
    local save_user_settings = application and application.save_user_settings

    if type(get_user_setting) ~= "function"
        or type(set_user_setting) ~= "function"
        or type(save_user_settings) ~= "function" then
        mod:warning("ForceAudioDevice: Application user-setting API is unavailable.")
        return nil
    end

    local current_index = get_user_setting("sound_settings", "sound_device")

    if current_index == nil then
        current_index = 0
    end

    local changed = current_index ~= device_index

    if changed and mod:get(SYNC_GAME_SETTING) == true then
        set_user_setting("sound_settings", "sound_device", device_index)
        save_user_settings()
    end

    return changed
end

local function apply_audio_device(show_feedback, startup)
    local target_name = mod:get(DEVICE_NAME_SETTING)

    if target_name == "" then
        if show_feedback and not startup then
            mod:echo_localized("device_unchanged")
        end

        return
    end

    if target_name ~= 0 and type(target_name) ~= "string" then
        mod:warning("ForceAudioDevice: invalid audio-device setting type '%s'.", type(target_name))
        return
    end

    local wwise = rawget(_G, "Wwise")
    local get_device_list = wwise and wwise.get_device_list
    local set_active_device = wwise and wwise.set_active_device

    if type(get_device_list) ~= "function" or type(set_active_device) ~= "function" then
        mod:warning("ForceAudioDevice: Wwise output-device API is unavailable.")
        return
    end

    if target_name == 0 then
        set_active_device(0)
        local device_changed = sync_game_setting(0)
        warned_device_name = nil

        if show_feedback and (not startup or device_changed == true) then
            mod:echo_localized(startup and "startup_device_default_applied" or "device_default_applied")
        end

        return
    end

    local devices = get_device_list()

    if type(devices) == "table" then
        for device_index, device in ipairs(devices) do
            if device.device_name == target_name then
                set_active_device(device.device_id)
                local device_changed = sync_game_setting(device_index)
                warned_device_name = nil

                if show_feedback and (not startup or device_changed == true) then
                    mod:echo_localized(startup and "startup_device_applied" or "device_applied", target_name)
                end

                return
            end
        end
    end

    set_active_device(0)
    local device_changed = sync_game_setting(0)

    if show_feedback and (not startup or device_changed == true) then
        mod:echo_localized(startup and "startup_device_missing" or "device_missing", target_name)
        warned_device_name = target_name
    elseif warned_device_name ~= target_name then
        mod:warning("ForceAudioDevice: '%s' was not found; using the system default device.", target_name)
        warned_device_name = target_name
    end
end

mod.apply_audio_device = function()
    apply_audio_device(true)
end

mod.on_all_mods_loaded = function()
    if enabled then
        apply_audio_device(mod:get("show_startup_message") == true, true)
    end
end

mod.on_enabled = function(initial_call)
    enabled = true

    if not initial_call then
        apply_audio_device(true)
    end
end

mod.on_disabled = function()
    enabled = false
end

mod.on_setting_changed = function(setting_id)
    local sync_enabled = setting_id == SYNC_GAME_SETTING and mod:get(SYNC_GAME_SETTING) == true

    if enabled and (setting_id == DEVICE_NAME_SETTING or sync_enabled) then
        warned_device_name = nil
        apply_audio_device(true)
    end
end
