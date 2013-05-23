--[[ =================================================================
    Description:
        Provides a safe haven for all you debug messages

    Contact:
        For questions, bug reports visit the website or send an email
        to the following address: wowaddon@xs4all.nl

    Dependencies:
        None

    Credits:
        A big 'Thank You' to all the people at Blizzard Entertainment
        for making World of Warcraft.

    Revision:
        $Id: DebugMessages.lua 772 2013-02-05 15:32:54Z fmeus_lgs $
    ================================================================= --]]

-- Globals
    DM_LINES = 25;
    DM_MSG = {};

-- Create AddOn frame
    local DebugMessages = CreateFrame( "Frame", "DebugMessages", UIParent );

-- Initialize settings
    if ( not DM_Config ) then DM_Config = {}; end;
    if ( not DM_Config.scrollstate ) then DM_Config.scrollstate = true; end;

-- Add message to the debug messages stack (External API)
    function DebugMessages:AddMessage( addon, message )
        tinsert( DM_MSG, { time(), addon, message } );
        
        -- Force scroll to last message or perform a regular refresh
        if ( DM_Config.scrollstate ) then
            FauxScrollFrame_SetOffset( DebugMessages_ScrollFrame, DebugMessages_ScrollFrame:GetVerticalScrollRange() );
        else
            DebugMessages_Scroll();
        end;
    end;

-- Mark Odd/Even lines
    local function DebugMessages_MarkLines()
        -- Redraw items
        for line = 1, DM_LINES, 1 do
            if ( line % 2 == 0 ) then
                _G["DebugMessage"..line.."BG"]:Hide();
            end;
            _G["DebugMessage"..line]:Hide();
        end;
    end;

-- Scroll through the debug messages
    function DebugMessages_Scroll()
        local length = #DM_MSG;
        local line, index, button, time, addon, message;
        local offset = FauxScrollFrame_GetOffset( DebugMessages_ScrollFrame );
        local argName, argData;

        -- Draw Odd/Even markings
        DebugMessages_MarkLines();

        -- Update scrollbars
        FauxScrollFrame_Update( DebugMessages_ScrollFrame, length+1, DM_LINES, 12 );

        -- Redraw items
        for line = 1, DM_LINES, 1 do
            index = offset + line;
            button = _G["DebugMessage"..line];
            if index <= length then
                time, addon, message = unpack( DM_MSG[index] );
                _G["DebugMessage"..line.."InfoTime"]:SetText( date( "%H:%M:%S", time ) );
                _G["DebugMessage"..line.."InfoAddOn"]:SetText( addon );
                _G["DebugMessage"..line.."InfoMessage"]:SetText( message );
                button:Show();
                button:Enable();
            else
                button:Hide();
            end;
        end;
    end;

-- Show/Hide the DebugMessages frame containing all the messages
    function DebugMessages_Purge()
        -- Wipe all messages
        wipe( DM_MSG );

        -- Redraw
        DebugMessages_Scroll();
    end;

-- Show/Hide the DebugMessages frame containing all the messages
    function DebugMessages_Toggle()
        if ( DebugMessagesFrame:IsVisible() ) then
            DebugMessagesFrame:Hide();
        else
            DebugMessagesFrame:Show();
        end;
    end;

-- Toggle 'Scroll to Last' state
    function DebugMessages_ScrollState()
        DM_Config.scrollstate = ScrollState:GetChecked();
    end;