Config = {}

-- Debug (optional)
Config.Debug = false -- Enable/Disable debug mode

-- Progressbar configuration (optional)
Config.Style = { 
    -- Colors
    barColor = '#0a7df7',                  -- Progress bar color (grayish blue)
    bgColor = 'rgba(25, 33, 45, 0.5)',       -- Bottom bottom color (50%translucent gray)
    textColor = '#FFFFFF',                 -- Text color (white)
    
    -- Font and typography settings
    fontFamily = 'Poppins, sans-serif',      -- Font family
    fontSize = '14px',                       -- Font size
    fontWeight = '600',                      -- Font weight
    
    -- Layout and spacing
    width = '300px',                         -- width of the progressbar
    height = '40px',                         -- hight of the progressbar
    position = 'bottom',                     -- Positión: 'center', 'top', 'bottom'
    
    -- Border and shadow
    borderRadius = '12px',                      -- Border radius
    shadow = '0px 4px 15px rgba(0, 0, 0, 0.4)', -- Shadow
    
    -- Animation
    animationSpeed = 1000                        -- Animation speed in milliseconds
}

-- Default config (optional)
Config.Default = {          -- default config
    text = "Processing...", -- default text, you can change it
    duration = 5000         -- default duration
}

