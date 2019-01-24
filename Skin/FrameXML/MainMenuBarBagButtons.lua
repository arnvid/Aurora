local _, private = ...

--[[ Lua Globals ]]
-- luacheck: globals

--[[ Core ]]
local Aurora = private.Aurora
local Base = Aurora.Base
local Skin = Aurora.Skin

--do --[[ FrameXML\MainMenuBarBagButtons.lua ]]
--end

do --[[ FrameXML\MainMenuBarBagButtons.xml ]]
    function Skin.BagSlotButtonTemplate(CheckButton)
        Skin.ItemButtonTemplate(CheckButton)
        if private.isPatch then
            Base.CropIcon(CheckButton.SlotHighlightTexture)
        else
            Base.CropIcon(CheckButton:GetCheckedTexture())
        end
    end
end

function private.FrameXML.MainMenuBarBagButtons()
    if private.disabled.mainmenubar then return end

    Skin.ItemButtonTemplate(_G.MainMenuBarBackpackButton)
    if private.isPatch then
        Base.CropIcon(_G.MainMenuBarBackpackButton.SlotHighlightTexture)
    else
        Base.CropIcon(_G.MainMenuBarBackpackButton:GetCheckedTexture())
    end

    Skin.BagSlotButtonTemplate(_G.CharacterBag0Slot)
    Skin.BagSlotButtonTemplate(_G.CharacterBag1Slot)
    Skin.BagSlotButtonTemplate(_G.CharacterBag2Slot)
    Skin.BagSlotButtonTemplate(_G.CharacterBag3Slot)
    _G.CharacterBag0Slot:SetPoint("RIGHT", _G.MainMenuBarBackpackButton, "LEFT", -4, -5)
    _G.CharacterBag1Slot:SetPoint("RIGHT", _G.CharacterBag0Slot, "LEFT", -4, 0)
    _G.CharacterBag2Slot:SetPoint("RIGHT", _G.CharacterBag1Slot, "LEFT", -4, 0)
    _G.CharacterBag3Slot:SetPoint("RIGHT", _G.CharacterBag2Slot, "LEFT", -4, 0)

    Skin.GlowBoxFrame(_G.AzeriteInBagsHelpBox)
end
