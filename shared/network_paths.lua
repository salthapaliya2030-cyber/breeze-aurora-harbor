-- shared/network_paths.lua
-- Shared remote event and remote function definitions for client/server transport.

local SharedNetwork = {}

SharedNetwork.Events = {
    InputSignal = "InputSignal",
    MatchSetup = "MatchSetup",
    ScoreUpdate = "ScoreUpdate",
    StyleRoll = "StyleRoll",
    AbilityUse = "AbilityUse",
}

SharedNetwork.Functions = {
    GetProfile = "GetProfile",
    SaveProfile = "SaveProfile",
    ValidateMatchState = "ValidateMatchState",
}

function SharedNetwork.buildRemoteFolder(parent)
    local folder = parent:FindFirstChild("RemoteServices")
    if not folder then
        folder = Instance.new("Folder")
        folder.Name = "RemoteServices"
        folder.Parent = parent
    end

    local remotes = {}
    for eventName, eventKey in pairs(SharedNetwork.Events) do
        local event = folder:FindFirstChild(eventKey)
        if not event then
            event = Instance.new("RemoteEvent")
            event.Name = eventKey
            event.Parent = folder
        end
        remotes[eventName] = event
    end

    for functionName, functionKey in pairs(SharedNetwork.Functions) do
        local fn = folder:FindFirstChild(functionKey)
        if not fn then
            fn = Instance.new("RemoteFunction")
            fn.Name = functionKey
            fn.Parent = folder
        end
        remotes[functionName] = fn
    end

    return remotes
end

return SharedNetwork
