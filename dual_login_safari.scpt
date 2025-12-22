tell application "Safari"
    activate
    
    -- Window 1: Doctor (localhost)
    make new document with properties {URL:"http://localhost:5173/login"}
    set doctorWindow to front window
    delay 1 -- Wait for load
    
    -- Login Doctor
    do JavaScript "
        setTimeout(() => {
            const email = document.querySelector('input[type=\"email\"]');
            const pass = document.querySelector('input[type=\"password\"]');
            const btn = document.querySelector('button[type=\"submit\"]');
            
            if (email && pass && btn) {
                // React requires setting value property descriptor or dispatching input event
                let nativeInputValueSetter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;
                
                nativeInputValueSetter.call(email, 'rajesh.sharma@medicare.com');
                email.dispatchEvent(new Event('input', { bubbles: true }));
                
                nativeInputValueSetter.call(pass, 'pass123');
                pass.dispatchEvent(new Event('input', { bubbles: true }));
                
                setTimeout(() => btn.click(), 500);
            }
        }, 1000);
    " in current tab of doctorWindow
    
    
    -- Window 2: Patient (127.0.0.1)
    make new document with properties {URL:"http://127.0.0.1:5173/login"}
    set patientWindow to front window
    set bounds of patientWindow to {50, 50, 800, 800} -- Adjust positioning if needed
    delay 1
    
    -- Login Patient
    do JavaScript "
        setTimeout(() => {
            const email = document.querySelector('input[type=\"email\"]');
            const pass = document.querySelector('input[type=\"password\"]');
            const btn = document.querySelector('button[type=\"submit\"]');
            
            if (email && pass && btn) {
                 let nativeInputValueSetter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;

                nativeInputValueSetter.call(email, 'patient@medicare.com');
                email.dispatchEvent(new Event('input', { bubbles: true }));
                
                nativeInputValueSetter.call(pass, 'pass123');
                pass.dispatchEvent(new Event('input', { bubbles: true }));
                
                setTimeout(() => btn.click(), 500);
            }
        }, 1000);
    " in current tab of patientWindow
    
end tell
