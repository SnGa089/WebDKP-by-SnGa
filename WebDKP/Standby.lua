------------------------------------------------------------------------
-- WebDKP Standby Processing
-- Handles functions related to standby players
------------------------------------------------------------------------
-- Work in progres . . . Zevious
------------------------------------------------------------------------
		
-- ===========================================================================================
-- Toggle someone as standby
-- ===========================================================================================
function WebDKP_Standby_GUIToggle(state,playername) -- Modified by SnGa
	local tableid = WebDKP_GetTableid();

	-- If the playername was not passed then check the edit box
	if ( playername == nil or playername == "" ) then
		playername = WebDKP_Standby_FrameAddStandby:GetText();
	end
	
	if playername == nil or playername == "" then
		WebDKP_Print(WebDKP_Language_lua["Standby"]["SelectPlayer"][GLanguage]);
	
	-- If the name is good then do this
	else
		if state == "add" then
		-- We want to flag this player as being in standby

			-- Check to see if this player is already in the table
			if WebDKP_DkpTable[playername] == nil then
				-- Add this player to the table
				WebDKP_DkpTable[playername] = {
				["dkp_"..tableid] = 0,
				["class"] = Fixes_Class[UnitClass(playername)] or UnitClass(playername) or "Priest",
				["standby"] = 1,
				["cantrim"] = false,
					
				}
			WebDKP_SendWhisper(playername, WebDKP_Language_lua["Standby"]["AddPlayer"][GLanguage]);
			else
				-- Change their standby state appropiately
				WebDKP_DkpTable[playername]["standby"] = 1;
				WebDKP_SendWhisper(playername, WebDKP_Language_lua["Standby"]["AddPlayer"][GLanguage]); 
			end

		
		end
		if state == "remove" then
			-- We want to remove this player from being listed as standby
			if WebDKP_DkpTable[playername] == nil then
				-- This person doesn't exist
				WebDKP_Print(WebDKP_Language_lua["Standby"]["NoExistPlayer"][GLanguage]); 
			else
				-- Change their standby state appropiately
				WebDKP_DkpTable[playername]["standby"] = 0;
				WebDKP_SendWhisper(playername, WebDKP_Language_lua["Standby"]["DelPlayer"][GLanguage]); 
			end
		
		end
		WebDKP_UpdateTableToShow();
		WebDKP_UpdateTable();
	end
end

-- ===========================================================================================
-- Set everyone's standby status to 0
-- ===========================================================================================
function WebDKP_Standby_Reset()

	for k, v in pairs(WebDKP_DkpTable) do
		if ( type(v) == "table" ) then
			v["standby"] = 0;
		end
		flag = true
	end
	WebDKP_Print(WebDKP_Language_lua["Standby"]["ResetList"][GLanguage]);
	WebDKP_UpdateTableToShow();
	WebDKP_UpdateTable();

end
