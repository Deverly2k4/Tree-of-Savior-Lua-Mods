--[[
in the future, this will just iterate all folders to load every addon. for now,
just load them one at a time. to disable one, just delete or comment out the
line.
--]]

dofile("../addons/utility.lua"); --do not remove this one as it's a dependency for others.

--do not touch below here

-- http://stackoverflow.com/questions/5303174/how-to-get-list-of-directories-in-lua
local addons = io.popen([[dir "../addons/" /b /ad]]):lines();
for addon in addons do 
	local addonloader = "../addons/" .. addon .. "/" .. addon .. ".lua";
	dofile(addonloader);
end

--http://stackoverflow.com/questions/4990990/lua-check-if-a-file-exists
function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

local addonLoaderFrame = ui.GetFrame("addonloader");
addonLoaderFrame:ShowWindow(0);
_G["ADDON_LOADER"] = {};
_G["ADDON_LOADER"]["LOADED"] = true;

function MAP_ON_INIT_HOOKED(addon, frame)
	_G["MAP_ON_INIT_OLD"](addon, frame);

	if _G["ADDON_LOADER"]["LOADED"] then
		local addonLoaderFrame = ui.GetFrame("addonloader");
		addonLoaderFrame:ShowWindow(0);
	end
end

SETUP_HOOK(MAP_ON_INIT_HOOKED, "MAP_ON_INIT");

ui.SysMsg("Excrulon's addons loaded! (v1.9)");
