
local GUI = require("GUI")
local system = require("System")
local eeprom = component.eeprom
local internet = require("Internet")

local workspace, window, menu = system.addWindow(GUI.filledWindow(1, 1, 60, 20, 0xE1E1E1))



local layout = window:addChild(GUI.layout(1, 1, window.width, window.height, 1, 1))

layout:addChild(GUI.button(2, 2, 30, 3, 0xFFFFFF, 0x555555, 0x2d2d2d, 0xFFFFFF, "DESTROY")).onTouch = function()
  GUI.alert("What are you running now is a EFI Destroyer! Are you sure to run this? If no, restart the computer.")
  GUI.alert("THIS IS THE LAST WARNING, ARE YOU SURE YOU WANT TO DESTROY UR EFI? IF NO, RESTART THE COMPUTER!")
  local data, reason = internet.request("https://raw.githubusercontent.com/marius123-oss/mineos-bios-destroy/refs/heads/main/bios.lua")
    local success, reason, reasonFromEeprom = pcall(eeprom.set, data)
    if success and not reasonFromEeprom then
      eeprom.setLabel("Corrupted")
      eeprom.setData(require("filesystem").getProxy().address)
      GUI.alert("EFI Destroyed")
    else
      GUI.alert("The destruction failed >:(")
    end
end

window.onResize = function(newWidth, newHeight)
  window.backgroundPanel.width, window.backgroundPanel.height = newWidth, newHeight
  layout.width, layout.height = newWidth, newHeight
end

workspace:draw()

