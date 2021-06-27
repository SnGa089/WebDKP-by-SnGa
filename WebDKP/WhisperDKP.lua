------------------------------------------------------------------------
-- WHISPER DKP
------------------------------------------------------------------------
-- This file contains methods related to WhisperDKP functionality. 
------------------------------------------------------------------------

-- A reference to the original chat frame event hook (the one that we will replace)
-- Used to disguise our whisper messages
local WebDKP_ChatFrame_OnEvent_Original = nil; 
-- ================================
-- Places a hook on incoming whispers to the chat message box. 
-- We can use this to disguise our whisper messages
-- ================================
function WebDKP_Register_WhisperHook()
	--hooksecurefunc("ChatFrame_OnEvent",WebDKP_ChatFrame_OnEvent_Hook);
  if ( ChatFrame_OnEvent ~= WebDKP_ChatFrame_OnEvent_Hook ) then
        -- hook the chatframe onevent to allow us to hide the queue requrests if we want
        WebDKP_ChatFrame_OnEvent_Original = ChatFrame_OnEvent;
        ChatFrame_OnEvent = WebDKP_ChatFrame_OnEvent_Hook;
    end
end

-- ================================
-- Event handler for regular chat whisper messages
-- Responds to the players whisper with a whisper telling
-- them their current dkp. 
-- ================================
function WebDKP_WhisperDKP_Event(arg1,arg2) -- Modified by SnGa
	local tableid = WebDKP_GetTableid();
	local name = arg2;
	local trigger = arg1;

	if ( WebDKP_IsWebDKPWhisper(name, trigger) ) then
		if(WebDKP_Options_SnGa["BidsPerBand"] == 0) then
			if (string.find(string.lower(trigger), "!bid")==1) then	
				WebDKP_Bid_Receiveded(name,trigger);
			
			elseif (string.find(string.lower(trigger), "!casino")==1) then	
				WebDKP_AddBidder_Casino(name,trigger);

			elseif (string.find(string.lower(trigger), WebDKP_Language_lua["WisperDKP"]["Cancel"][GLanguage])==1) then	
				WebDKP_DelBidder_Casino(name,trigger);
			end
		end
		
		if(string.find(string.lower(trigger), "!dkp")==1 ) then 		
			-- look up this player in our dkp table and see if we can find their information
			local main = WebDKP_GetMain(name, true);
			if ( WebDKP_DkpTable[main] == nil ) then
				-- not in our system, send them message
				WebDKP_SendWhisper(name, WebDKP_Language_lua["WisperDKP"]["NoDKP"][GLanguage]); 
			else
				-- they are in the table, get them their dkp
				local dkp = WebDKP_GetDKP(main, tableid);
				WebDKP_SendWhisper(name,string.gsub(WebDKP_Language_lua["WisperDKP"]["CurrentDKP"][GLanguage],"$dkp",dkp)); 
			end	

		elseif (string.find(string.lower(trigger), "!admin")==1) then		
			WebDKP_Admin(name,trigger);
			
		elseif (string.find(string.lower(trigger), WebDKP_Language_lua["WisperDKP"]["Current"][GLanguage])==1) then		
			if(WebDKP_bidInProgress == false) then 	
				WebDKP_SendWhisper(name, WisperDKP_NoCurrentEvent);
			else
				toSay = WebDKP_Language_lua["WisperDKP"]["ItemCurrent"][GLanguage];
				toSay = string.gsub(toSay, "$item", item_inprocess);
				toSay = string.gsub(toSay, "$current", WebDKP_Bid_Preview);

				if (WebDKP_Bid_Preview > 0) then
					if WebDKP_Options_SnGa["AnonymousBids"] == 0 then
						toSay = string.gsub(toSay, "!", WebDKP_Language_lua["Others"]["Of"][GLanguage])
						toSay = string.gsub(toSay,"$name", WebDKP_Name_Preview);
					end
					toSay = toSay.." "..WebDKP_Language_lua["WisperDKP"]["NextBid"][GLanguage];
					toSay = string.gsub(toSay,"$min", WebDKP_Bid_Min(WebDKP_Bid_Preview));
				end 
				WebDKP_SendWhisper(name,toSay);
			end

		elseif (string.find(string.lower(trigger), WebDKP_Language_lua["WisperDKP"]["Previous"][GLanguage])==1) then		
			if(item_old == nil) then 	
				WebDKP_SendWhisper(name, WisperDKP_NoPreviousEvent);
			else
				WebDKP_SendWhisper(name, auction_old)
			end

		elseif (string.find(string.lower(trigger), WebDKP_Language_lua["WisperDKP"]["Help"][GLanguage])==1) then
			WebDKP_SendWhisper(name, WebDKP_Language_lua["WisperDKP"]["HelpText1"][GLanguage]); 
			WebDKP_SendWhisper(name, WebDKP_Language_lua["WisperDKP"]["HelpText2"][GLanguage]);
			WebDKP_SendWhisper(name, WebDKP_Language_lua["WisperDKP"]["HelpText3"][GLanguage]);
			WebDKP_SendWhisper(name, WisperDKP_CurrentEvent); 
			WebDKP_SendWhisper(name, WisperDKP_PreviousEvent); 
			WebDKP_SendWhisper(name, WebDKP_Language_lua["WisperDKP"]["HelpText4"][GLanguage]);
			WebDKP_SendWhisper(name, WebDKP_Language_lua["WisperDKP"]["HelpText5"][GLanguage]); 

		elseif (string.find(string.lower(trigger), WebDKP_Language_lua["WisperDKP"]["Attendance"][GLanguage])==1) then		-- They want their attendance info
			if WebDKP_CharRaidInfo[name] ~= nil then
				local total_raids = WebDKP_CharRaidInfo[name]["total_raids"];
				local attended_raids =  WebDKP_CharRaidInfo[name]["raids_attended"];
				local percent =  WebDKP_CharRaidInfo[name]["percent"];

				temp = WebDKP_Language_lua["WisperDKP"]["AttenCurrent"][GLanguage];
				temp = string.gsub(temp, "$attended_raids", attended_raids);
				temp = string.gsub(temp, "$total_raids", total_raids);
				temp = string.gsub(temp, "$percent", percent)
				
				WebDKP_SendWhisper(name,temp);
			else
				WebDKP_SendWhisper(name, WebDKP_Language_lua["WisperDKP"]["NoAttendance"][GLanguage]);
			end

		elseif(trigger == "!standby add" ) then							
			WebDKP_Standby_GUIToggle("add",name)
		
		elseif(trigger == "!standby del" ) then						
			WebDKP_Standby_GUIToggle("remove",name)
		end
	end
end

-- ================================
-- Our special event hook that picks up on all whispers 
-- Before they are displayed on the screen or trigger the 
-- regular whisper. Here we can hide any whispers that our
-- ours. 
-- ================================
function WebDKP_ChatFrame_OnEvent_Hook(self, event, arg1, arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13)
    -- if ( arg1 and arg2 ) then
        -- whisper too me
        if ( event == "CHAT_MSG_WHISPER" ) then
            if ( WebDKP_IsWebDKPWhisper( arg2, arg1 ) ) then
                -- don't display whispercast whisper
                return
            end
        end
        -- whisper I am sending
        if ( event == "CHAT_MSG_WHISPER_INFORM" ) then
            if ( string.find(arg1,"^WebDKP: " ) or
			string.find(arg1, "!Sending")
		 ) then
                -- hide whispers that I am sending
                return
            end
        end
        if ( event == "CHAT_MSG_WHISPER_INFORM" ) then
            if ( string.find(arg1,"^WebDKP: " ) or
			string.find(arg1, "!SendingAuto")
		 ) then
                -- hide whispers that I am sending
                return
            end
        end
    -- end 
    WebDKP_ChatFrame_OnEvent_Original(self, event, arg1, arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,arg12,arg13)

end

-- ================================
-- Returns true if the passed whisper is a whisper directed
-- towards web dkp
-- ================================
function WebDKP_IsWebDKPWhisper(name, trigger) -- Modified by SnGa
	-- if it has webdkp in it, its an outgoing message. ignore it

	if ( string.find(string.lower(trigger), "WebDKP:" ) ) then
		return false;
	end
	if (string.find(string.lower(trigger), WebDKP_Language_lua["WisperDKP"]["Help"][GLanguage]) 	 	== 1 or
		string.find(string.lower(trigger), WebDKP_Language_lua["WisperDKP"]["Cancel"][GLanguage])		== 1 or	
		string.find(string.lower(trigger), WebDKP_Language_lua["WisperDKP"]["Current"][GLanguage])  	== 1 or
		string.find(string.lower(trigger), WebDKP_Language_lua["WisperDKP"]["Previous"][GLanguage]) 	== 1 or
		string.find(string.lower(trigger), WebDKP_Language_lua["WisperDKP"]["Attendance"][GLanguage]) 	== 1 or
		string.find(string.lower(trigger), "!bid")			== 1 or 
		string.find(string.lower(trigger), "!admin")		== 1 or 
		string.find(string.lower(trigger), "!dkp")			== 1 or 
		string.find(string.lower(trigger), "!casino")		== 1 or 
		string.find(string.lower(trigger), "!standby add")	== 1 or 
		string.find(string.lower(trigger), "!standby del")	== 1 or 
		string.find(trigger, "!Sending")					== 1 or 
		string.find(trigger, "!SendingAuto")				== 1  ) 
	then
	        return true
	end
    return false
end
