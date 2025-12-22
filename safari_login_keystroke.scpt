tell application "Safari"
    activate
    delay 1
    
    -- Ensure we have two tabs ready
    set medicareTabs to {}
    repeat with w in every window
        repeat with t in every tab of w
            if URL of t contains "5173" then
                set end of medicareTabs to t
            end if
        end repeat
    end repeat
    
    -- If not enough tabs, make them
    if (count of medicareTabs) < 2 then
        tell window 1
            make new tab with properties {URL:"http://localhost:5173/login"}
            set end of medicareTabs to current tab
        end tell
    end if
    
    -- Login Admin in Tab 1
    set t1 to item 1 of medicareTabs
    set current tab of window 1 to t1
    set URL of t1 to "http://localhost:5173/login"
    delay 2
    
    tell application "System Events"
        tell process "Safari"
            -- Focus web area roughly (usually focused by default on load, but let's tab to be sure? No, inputs usually autofocus or we click)
            -- Simplest: Tab until we hit email? Or just assume focus?
            -- Let's try sending Tab then inputs.
            -- Actually, most login forms auto-focus email, or we can use Tab.
            -- Let's press Tab once to focus Email if not already, or navigate to it.
            -- Better: reload page to reset focus state
            
            keystroke "admin@medicare.com"
            keystroke tab
            keystroke "admin123"
            keystroke return
        end tell
    end tell
    
    delay 2
    
    -- Login Doctor in Tab 2
    set t2 to item 2 of medicareTabs
    set current tab of window 1 to t2
    set URL of t2 to "http://localhost:5173/login"
    delay 2
    
    tell application "System Events"
        tell process "Safari"
            keystroke "rajesh.sharma@medicare.com"
            keystroke tab
            keystroke "pass123"
            keystroke return
        end tell
    end tell
    
end tell
