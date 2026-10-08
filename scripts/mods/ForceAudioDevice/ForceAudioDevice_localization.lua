---@class ForceAudioDeviceMod
local mod = get_mod("ForceAudioDevice")

return {
    mod_name = {
        en = "Force Audio Device",
    },
    mod_description = {
        en = "Selects a detected audio output by name whenever the mod loads.",
    },
    device_name = {
        en = "Audio device",
    },
    device_name_tooltip = {
        en = "Select an audio output detected when the mod loaded. Device names are resolved to current Wwise IDs whenever the selection is applied.",
    },
    device_no_override = {
        en = "Do not change audio device",
    },
    device_system_default = {
        en = "System default",
    },
    apply_audio_device = {
        en = "Apply audio device",
    },
    apply_audio_device_tooltip = {
        en = "Finds and selects the configured device now.",
    },
    apply_audio_device_button = {
        en = "Apply now",
    },
    show_startup_message = {
        en = "Show startup change notification",
    },
    show_startup_message_tooltip = {
        en = "Shows a chat message when the mod loads only if it changes Darktide's selected audio device.",
    },
    sync_game_setting = {
        en = "Sync Darktide audio setting",
    },
    sync_game_setting_tooltip = {
        en = "Updates Darktide's Audio Device setting to the same detected device. The setting is saved only when its current value differs.",
    },
    device_unchanged = {
        en = "Force Audio Device: audio device left unchanged.",
    },
    device_default_applied = {
        en = "Force Audio Device: selected the system default device.",
    },
    device_applied = {
        en = "Force Audio Device: selected '%s'.",
    },
    device_missing = {
        en = "Force Audio Device: '%s' was not found; using the system default device.",
    },
    startup_device_default_applied = {
        en = "Force Audio Device changed the audio device to the system default.",
    },
    startup_device_applied = {
        en = "Force Audio Device changed the audio device to '%s'.",
    },
    startup_device_missing = {
        en = "Force Audio Device could not find '%s' and changed the audio device to the system default.",
    },
}
