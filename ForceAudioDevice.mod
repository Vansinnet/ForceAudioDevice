return {
    version = "1.0.0",
    run = function()
        fassert(rawget(_G, "new_mod"), "`ForceAudioDevice` failed loading DMF.")

        new_mod("ForceAudioDevice", {
            mod_script = "ForceAudioDevice/scripts/mods/ForceAudioDevice/ForceAudioDevice",
            mod_data = "ForceAudioDevice/scripts/mods/ForceAudioDevice/ForceAudioDevice_data",
            mod_localization = "ForceAudioDevice/scripts/mods/ForceAudioDevice/ForceAudioDevice_localization",
        })
    end,
    packages = {},
}
