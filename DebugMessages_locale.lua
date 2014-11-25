-- Version information (not localized)
    DM_NAME = GetAddOnMetadata( "DebugMessages", "Title" );
    DM_VERSION = GetAddOnMetadata( "DebugMessages", "Version" );
    DM_FULLNAME = DM_NAME.." - "..DM_VERSION;

-- Standard English messages
    DM_ADDON = "AddOn";
    DM_TIME = "Time";
    DM_MESSAGE = "Message";
    DM_CLOSE = "Close";
    DM_PURGE = "Purge";

-- Binding strings
    BINDING_HEADER_DM = "DebugMessages Bindings";
    BINDING_NAME_TOGGLE = "Show/Hide DebugMessages";

-- Messages for other languages
    if (GetLocale()=="deDE") then     -- German
    elseif (GetLocale()=="ruRU") then -- Russian
    elseif (GetLocale()=="koKR") then -- Korean
    elseif (GetLocale()=="frFR") then -- French
    elseif (GetLocale()=="esES") then -- Spanish (European)
    elseif (GetLocale()=="esMX") then -- Spanish (Latin American)
    elseif (GetLocale()=="zhCN") then -- Chinese(simplified; mainland China)
    elseif (GetLocale()=="zhTW") then -- Chinese(traditional; Taiwan)
    end;