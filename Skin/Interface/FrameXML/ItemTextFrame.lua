local _, private = ...
if private.shouldSkip() then return end

--[[ Lua Globals ]]
-- luacheck: globals select

--[[ Core ]]
local Aurora = private.Aurora
local Hook, Skin = Aurora.Hook, Aurora.Skin
local Color = Aurora.Color

do --[[ FrameXML\ItemTextFrame.lua ]]
    function Hook.ItemTextFrame_OnEvent(self, event, ...)
        if event == "ITEM_TEXT_BEGIN" then
            if _G.ItemTextGetMaterial() == "ParchmentLarge" then
                _G.ItemTextPageText:SetTextColor("P", Color.grayLight:GetRGB())
                _G.ItemTextPageText:SetTextColor("H1", Color.white:GetRGB())
                _G.ItemTextPageText:SetTextColor("H2", Color.white:GetRGB())
                _G.ItemTextPageText:SetTextColor("H3", Color.white:GetRGB())
            else
                -- Legacy behavior - ignore the title color
                _G.ItemTextPageText:SetTextColor("P", Color.grayLight:GetRGB())
                _G.ItemTextPageText:SetTextColor("H1", Color.grayLight:GetRGB())
                _G.ItemTextPageText:SetTextColor("H2", Color.grayLight:GetRGB())
                _G.ItemTextPageText:SetTextColor("H3", Color.grayLight:GetRGB())
            end
        elseif event == "ITEM_TEXT_READY" then
            local page = _G.ItemTextGetPage()
            local hasNext = _G.ItemTextHasNextPage()

            _G.ItemTextPageText:SetPoint("TOPLEFT", _G.ItemTextScrollFrame, 10, -10)
            _G.ItemTextScrollFrame:ClearAllPoints()
            if (page > 1) or hasNext then
                _G.ItemTextScrollFrame:SetPoint("TOPLEFT", _G.ItemTextFrame, 16, -(private.FRAME_TITLE_HEIGHT * 2 + 5))
                _G.ItemTextScrollFrame:SetPoint("BOTTOMRIGHT", _G.ItemTextFrame, -23, 4)
            else
                _G.ItemTextScrollFrame:SetPoint("TOPLEFT", _G.ItemTextFrame, 16, -(private.FRAME_TITLE_HEIGHT + 5))
                _G.ItemTextScrollFrame:SetPoint("BOTTOMRIGHT", _G.ItemTextFrame, -23, 4)
            end
        end
    end
end

--do --[[ FrameXML\ItemTextFrame.xml ]]
--end

function private.FrameXML.ItemTextFrame()
    local ItemTextFrame = _G.ItemTextFrame
    ItemTextFrame:HookScript("OnEvent", Hook.ItemTextFrame_OnEvent)

    Skin.ButtonFrameTemplate(ItemTextFrame)

    -- BlizzWTF: The portrait in the template is not being used.
    select(3, ItemTextFrame:GetRegions()):Hide()
    _G.ItemTextFramePageBg:SetAlpha(0)

    _G.ItemTextMaterialTopLeft:SetAlpha(0)
    _G.ItemTextMaterialTopRight:SetAlpha(0)
    _G.ItemTextMaterialBotLeft:SetAlpha(0)
    _G.ItemTextMaterialBotRight:SetAlpha(0)

    _G.ItemTextCurrentPage:SetPoint("TOP", 0, -(private.FRAME_TITLE_HEIGHT + 10))

    Skin.ScrollFrameTemplate(_G.ItemTextScrollFrame)
    _G.ItemTextPageText:SetPoint("TOPLEFT", _G.ItemTextScrollFrame, 10, -10)
    _G.ItemTextPageText:SetPoint("BOTTOMRIGHT", _G.ItemTextScrollFrame, -10, 10)

    Skin.FrameTypeStatusBar(_G.ItemTextStatusBar)
    _G.ItemTextStatusBar:SetHeight(17)
    _G.ItemTextStatusBar:GetRegions():Hide()

    for i, delta in _G.next, {"PrevPageButton", "NextPageButton"} do
        local button = _G["ItemText"..delta]
        button:ClearAllPoints()
        if i == 1 then
            Skin.NavButtonPrevious(button)
            button:SetPoint("TOPLEFT", 32, -private.FRAME_TITLE_HEIGHT)
            button:GetRegions():SetPoint("LEFT", button, "RIGHT", 3, 0)
        else
            Skin.NavButtonNext(button)
            button:SetPoint("TOPRIGHT", -32, -private.FRAME_TITLE_HEIGHT)
            button:GetRegions():SetPoint("RIGHT", button, "LEFT", -3, 0)
        end
    end
end
