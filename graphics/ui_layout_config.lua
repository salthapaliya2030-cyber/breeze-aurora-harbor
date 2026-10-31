-- graphics/ui_layout_config.lua
-- Relative percentage-based UI layout anchors to prevent stretching across resolutions.

local UILayout = {}

UILayout.screen = {
    width = 1920,
    height = 1080,
    aspect = 16 / 9,
}

UILayout.scale = {
    menuButtonWidth = 0.18,
    menuButtonHeight = 0.08,
    modalWidth = 0.62,
    modalHeight = 0.54,
    hudBarHeight = 0.075,
}

UILayout.anchor = {
    topLeft = UDim2.new(0.02, 0, 0.02, 0),
    topCenter = UDim2.new(0.5, 0, 0.05, 0),
    bottomCenter = UDim2.new(0.5, 0, 0.9, 0),
    bottomRight = UDim2.new(0.9, 0, 0.9, 0),
    center = UDim2.new(0.5, 0, 0.5, 0),
}

function UILayout.validate(frame)
    if not frame or not frame.Parent then
        return false
    end

    local anchor = frame.AnchorPoint or Vector2.new(0.5, 0.5)
    if anchor.X < 0 or anchor.X > 1 or anchor.Y < 0 or anchor.Y > 1 then
        return false
    end

    return true
end

function UILayout.aspectConstraint(instance)
    if not instance or not instance:IsA("GuiObject") then
        return
    end

    instance.AnchorPoint = Vector2.new(0.5, 0.5)
    instance.Size = UDim2.new(UILayout.scale.modalWidth, 0, UILayout.scale.modalHeight, 0)
end

return UILayout
