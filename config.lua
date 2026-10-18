Config = {}

-- Debug (optional)
Config.Debug = false -- Enable/Disable debug mode

-- Progressbar layout. Since v3.0.0 colors, font, shadows and borders come from the
-- JVL Steel Blue standard (jvl-steel-blue.css), so every JVL UI looks the same.
Config.Style = {
    width = '400px',      -- Width of the progress bar
    position = 'bottom',  -- 'center', 'top', 'bottom'
}

-- Default config (optional)
Config.Default = {          -- default config
    text = "Processing...", -- default text, you can change it
    duration = 5000,        -- default duration
    -- What the player cannot do while the bar runs when the caller does not say it.
    -- Callers can pass their own table as the 7th argument of startProgressbar.
    disable = { move = false, car = false, combat = false, mouse = false },
}

