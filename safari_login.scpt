tell application "Safari"
    activate
    
    set adminLogged to false
    set doctorLogged to false
    
    -- Check if already logged in
    repeat with w in every window
        repeat with t in every tab of w
            if URL of t contains "5173" then
                set pageText to do JavaScript "document.body.innerText" in t
                if pageText contains "Admin Dashboard" then
                    set adminLogged to true
                else if pageText contains "Doctor Dashboard" then
                    set doctorLogged to true
                end if
            end if
        end repeat
    end repeat
    
    -- Login Logic
    repeat with w in every window
        repeat with t in every tab of w
            if URL of t contains "5173" then
                
                set hasLoginInputs to do JavaScript "!!(document.querySelector('input[type=\"email\"]') && document.querySelector('input[type=\"password\"]'))" in t
                
                if hasLoginInputs is true then
                    if adminLogged is false then
                         do JavaScript "
                            const email = document.querySelector('input[type=\"email\"]');
                            const pass = document.querySelector('input[type=\"password\"]');
                            const btn = document.querySelector('button[type=\"submit\"]');
                            
                            if (email && pass && btn) {
                                email.value = '';
                                pass.value = '';
                                
                                email.value = 'admin@medicare.com';
                                email.dispatchEvent(new Event('input', { bubbles: true }));
                                pass.value = 'admin123';
                                pass.dispatchEvent(new Event('input', { bubbles: true }));
                                
                                setTimeout(() => btn.click(), 500);
                            }
                         " in t
                         set adminLogged to true
                         delay 2 -- Allow navigation to start
                    else if doctorLogged is false then
                         do JavaScript "
                            const email = document.querySelector('input[type=\"email\"]');
                            const pass = document.querySelector('input[type=\"password\"]');
                            const btn = document.querySelector('button[type=\"submit\"]');
                            
                            if (email && pass && btn) {
                                email.value = '';
                                pass.value = '';
                                
                                email.value = 'rajesh.sharma@medicare.com';
                                email.dispatchEvent(new Event('input', { bubbles: true }));
                                pass.value = 'pass123';
                                pass.dispatchEvent(new Event('input', { bubbles: true }));
                                
                                setTimeout(() => btn.click(), 500);
                            }
                         " in t
                         set doctorLogged to true
                         delay 2
                    end if
                end if
            end if
        end repeat
    end repeat
    
    -- Return status
    return "Admin: " & adminLogged & ", Doctor: " & doctorLogged
end tell
