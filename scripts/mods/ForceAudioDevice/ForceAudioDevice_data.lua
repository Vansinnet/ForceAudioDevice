local mod = get_mod("ForceAudioDevice")

local device_options = {
    {
        text = mod:localize("device_no_override"),
        value = "",
    },
    {
        text = mod:localize("device_system_default"),
        value = 0,
    },
}

device_options.localize = false

local wwise = rawget(_G, "Wwise")
local get_device_list = wwise and wwise.get_device_list
local devices = type(get_device_list) == "function" and get_device_list() or nil

if type(devices) == "table" then
    local seen_names = {}

    for _, device in ipairs(devices) do
        local device_name = device.device_name

        if type(device_name) == "string" and device_name ~= "" and not seen_names[device_name] then
            seen_names[device_name] = true
            device_options[#device_options + 1] = {
                text = device_name,
                value = device_name,
            }
        end
    end
end

return {
    name = mod:localize("mod_name"),
    description = mod:localize("mod_description"),
    is_togglable = true,
    options = {
        widgets = {
            {
                setting_id = "device_name",
                type = "dropdown",
                default_value = "",
                options = device_options,
                title = "device_name",
                tooltip = "device_name_tooltip",
            },
            {
                setting_id = "apply_audio_device",
                type = "button",
                function_name = "apply_audio_device",
                button_text = "apply_audio_device_button",
                title = "apply_audio_device",
                tooltip = "apply_audio_device_tooltip",
            },
            {
                setting_id = "show_startup_message",
                type = "checkbox",
                default_value = true,
                title = "show_startup_message",
                tooltip = "show_startup_message_tooltip",
            },
            {
                setting_id = "sync_game_setting",
                type = "checkbox",
                default_value = true,
                title = "sync_game_setting",
                tooltip = "sync_game_setting_tooltip",
            },
        },
    },
}
