------------------------------------------------------------------------
-- ANNOUNCMENETS	
------------------------------------------------------------------------
-- Contains methods related to the raid announcemenets in game whenever
-- DKP is awarded. 

--------------------------[  Added By SnGa  ]---------------------------
item_inprocess, item_old, auction_old  = nil, nil, nil;

-- ================================
-- Returns the location where notifications should be sent to. 
-- "Raid" or "Party". If player is in neither a raid or a party, returns
-- "None"
-- ================================
function WebDKP_GetTellLocation() -- Modified by SnGa
	local numberInRaid, numberInParty = 0, 0;
	if Is_WoWLK then
		numberInRaid = GetNumRaidMembers();
		numberInParty = GetNumPartyMembers();
	else -- Is Classic
		if IsInRaid()  then numberInRaid  = 1 end -- Fix Classic
		if IsInGroup() then numberInParty = 1 end -- Fix Classic
	end

	if( numberInRaid > 0 ) then
		return "RAID";
	elseif (numberInParty > 0 ) then
		return "PARTY";
	else
		return "NONE";
	end
end

-- ================================
-- Makes an announcement that a user has received an item. 
-- ================================
function WebDKP_AnnounceAwardItem(cost, item, player) -- Modified by SnGa
	local tellLocation = WebDKP_GetTellLocation();
	local _,_,link = WebDKP_GetItemInfo(item);			-- Convert the item to a link
	local Wisp = WebDKP_Language_lua["Announcments"]["Wisp"][GLanguage];			
	local toSay = "";
	cost = cost * -1;

	if WebDKP_Options_SnGa["AnonymousBids"] == 1 then 	-- Ofertas Anonimas
		toSay =	string.gsub(WebDKP_Language_lua["Announcments"]["ItemAward"][GLanguage], "$player", WebDKP_Language_lua["Others"]["Winner"][GLanguage]);
		toSay =	string.gsub(toSay, "$item", link);
		toSay =	string.gsub(toSay, "$cost", cost);

		Wisp =	string.gsub(Wisp, "$item", link);
		WebDKP_SendWhisper(player,Wisp);
	else
		toSay =	string.gsub(WebDKP_Language_lua["Announcments"]["ItemAward"][GLanguage], "$player", player);
		toSay =	string.gsub(toSay, "$item", link);
		toSay =	string.gsub(toSay, "$cost", cost);
	end

	if WebDKP_Options_SnGa["SilentBidding"] == 0 then 	-- Subastas Silenciosas
		WebDKP_SendAnnouncement(toSay,tellLocation);
	else
		if  WebDKP_Options_SnGa["AnonymousBids"] == 0 then
			Wisp =	string.gsub(Wisp, "$item", link);
			WebDKP_SendWhisper(player,Wisp);
		end
	end
end

-- ================================
-- Makes an announcement that the raid (or a set of users) has received dkp
-- ================================
function WebDKP_AnnounceAward(dkp, reason)
	local tellLocation = WebDKP_GetTellLocation();
	local allGroupSelected = WebDKP_AllGroupSelected();

	-- Everyone received the award
	if ( allGroupSelected == true ) then
	
		-- Announce the award
		local toSay =	string.gsub(WebDKP_Language_lua["Announcments"]["DkpAwardAll"][GLanguage], "$dkp", dkp);
		toSay =	string.gsub(toSay, "$reason", reason);
		WebDKP_SendAnnouncement(toSay,tellLocation);
	
	-- Only some people received the award
	else
		
		-- Announce the award
	
		local toSay =	string.gsub(WebDKP_Language_lua["Announcments"]["DkpAwardSome"][GLanguage], "$dkp", dkp); 
		toSay =	string.gsub(toSay, "$reason", reason);
		WebDKP_SendAnnouncement(toSay,tellLocation);
		
		-- now increment through the selected players and announce them
		for key_name, v in pairs(WebDKP_DkpTable) do
			if ( type(v) == "table" ) then
				if( v["Selected"] ) then
					WebDKP_SendWhisper(key_name, string.gsub(WebDKP_Language_lua["Announcments"]["Assigned"][GLanguage], "$dkp", dkp) );
				end
			end
		end
	end
end

-- ================================
-- Announces that bidding has started. 
-- Accepts item name and the time (in seconds) that bidding
-- will go for
-- ================================
function WebDKP_AnnounceBidStart(item, time, startingBid) -- Modified by SnGa
	local tellLocation = WebDKP_GetTellLocation();
	item_inprocess = item;
	startingBidvalue = startingBid;
	if(time == 0 or time == nil or time =="" or time=="0") then
		time = "";
	else
		time = string.gsub(WebDKP_Language_lua["Announcments"]["Time"][GLanguage], "$time", time);
	end
	
	local instructions; 
	local _,_,link = WebDKP_GetItemInfo(item);
	instructions = WebDKP_Language_lua["Announcments"]["Instructions"][GLanguage];
	
	local startingBidText = ""; 
	if ( startingBid > 0 ) then
		startingBidText = string.gsub(WebDKP_Language_lua["Announcments"]["StartBidText"][GLanguage], "$StartBid", startingBid);
	end
	
	local toSay = string.gsub(WebDKP_Language_lua["Announcments"]["BidStart"][GLanguage], "$item", item);
	toSay =	string.gsub(toSay, "$time", time);
	toSay =	string.gsub(toSay, "$startingBid", startingBidText);
	toSay =	string.gsub(toSay, "$instructions", instructions);

	local announceText = WebDKP_Options_SnGa["EditStartAnnounce"];
	if WebDKP_Options_SnGa["Announcements"] == 1 and announceText ~= "" and announceText ~= nil then -- Anuncios Personalizados
		
		if time == "" then
			time = WebDKP_Language_lua["Others"]["Undefined"][GLanguage];
		end
		if startingBidvalue == 0 then
			startingBidvalue = WebDKP_Language_lua["Announcments"]["StartBidValue"][GLanguage];
		end

		announceText = string.gsub(announceText, "$item", link);
		announceText = string.gsub(announceText, "$time", time);
		announceText = string.gsub(announceText, "$bid", startingBidvalue);
		toSay = announceText

	end

	if WebDKP_Options_SnGa["SilentBidding"] == 0 then
		WebDKP_SendAnnouncement(toSay,tellLocation);
	end
end	

-- ================================
-- Announces that Rolling has started. 
-- Accepts item name and the time (in seconds) that the rolling will go for
-- Added by Zevious (Bronzebeard)
-- ================================
function WebDKP_AnnounceRollStart(item, time) -- Modified by SnGa
	local tellLocation = WebDKP_GetTellLocation();
	local toSay = nil;
	if(time == 0 or time == nil or time =="" or time=="0") then
		time = "";
	else
		time = WebDKP_Language_lua["Announcments"]["Time"][GLanguage];
	end
	
	toSay = string.gsub(WebDKP_Language_lua["Announcments"]["RollStart"][GLanguage],"$item", item);
	if time ~= "" then
		toSay =	string.gsub(toSay.." "..WebDKP_Language_lua["Announcments"]["TimeRemaining"][GLanguage],"$time", time);
	end

	--convert the item to a link
	local _,_,link = WebDKP_GetItemInfo(item);
	local tellLocation = WebDKP_GetTellLocation();

	toSay = string.gsub(toSay, "$item", link);
	toSay =	string.gsub(toSay, "$time", time);

	local announceText = WebDKP_Options_SnGa["EditSRollAnnounce"];
	if WebDKP_Options_SnGa["Announcements"] == 1 and announceText ~= "" and announceText ~= nil then -- Anuncios Personalizados
		
		if time == 0 or time == nil or time == "0" then
			time = WebDKP_Language_lua["Others"]["Undefined"][GLanguage];
		end

		announceText = string.gsub(announceText, "$item", link);
		announceText = string.gsub(announceText, "$time", time);
		toSay = announceText
	
	end
	
	WebDKP_SendAnnouncement(toSay,tellLocation);

end

-- ================================
-- Announces that bidding has finished
-- Accepts itemname, name of highest bidder, bid dkp
-- ================================
function WebDKP_AnnounceBidEnd(item, name, dkp, totalbids, preview) -- Modified by SnGa
	local toSay = nil
	if(name == nil or name == "") then
		preview = 0
	end
	--convert the item to a link
	local _,_,link = WebDKP_GetItemInfo(item);
	local tellLocation = WebDKP_GetTellLocation();
	item_old = WebDKP_bidItemLink;
	
	local WebDKP_BidEndList = string.gsub(Announcments_EventEnd, "$item", WebDKP_bidItemLink);
	if (preview == 0) then
		toSay =	string.gsub(WebDKP_BidEndList, "$dkp", dkp);

		local 
		auction_old = string.gsub(WebDKP_Language_lua["Announcments"]["AuctionOld"][GLanguage], "$item", WebDKP_bidItemLink);
	else

		if WebDKP_Options_SnGa["AnonymousBids"] == 1 then
			toSay =	string.gsub(WebDKP_Language_lua["Announcments"]["Winner"][GLanguage] , "$name", WebDKP_Language_lua["Others"]["SomeOne"][GLanguage]);
		else
			toSay =	string.gsub(WebDKP_Language_lua["Announcments"]["Winner"][GLanguage] , "$name", name);
		end

		toSay =	string.gsub(toSay, "$dkp", dkp);
		-------------------------------[ Old Winner ]----------------------------------
		auction_old = string.gsub(toSay, "$win", WebDKP_bidItemLink.." "..WebDKP_Language_lua["Others"]["Previously"][GLanguage]);
		toSay = string.gsub(toSay, "$win", "");
		-------------------------------------------------------------------------------
		toSay =	WebDKP_BidEndList.."\n"..toSay;
	end

	if WebDKP_Options_SnGa["SilentBidding"] == 0 then -- Subastas Silenciosas	
		local announceText = WebDKP_Options_SnGa["EditEndAnnounce"];
		if  WebDKP_Options_SnGa["Announcements"] == 1 and announceText ~= "" and announceText ~= nil then -- Anuncios Personalizados 
			announceText = string.gsub(announceText, "$item", link);
			announceText = string.gsub(announceText, "$name", name);
			announceText = string.gsub(announceText, "$dkp", dkp);
			announceText = string.gsub(announceText, "$totbid", totalbids);
			toSay = announceText
		end

		if  WebDKP_Options_SnGa["BidAnnounceRaid"] == 1 then
			WebDKP_SendAnnouncement(toSay,"RAID_WARNING");
		else
			WebDKP_SendAnnouncement(toSay,"RAID");
		end
	end
end

-- ================================
-- Announces that rolling has finished
-- Accepts itemname, name of highest bidder, bid dkp
-- Added by Zevious (Bronzebeard)
-- ================================
function WebDKP_AnnounceRollEnd(item, name, dkp, totalrolls) -- Modified by SnGa
	highest_roller, high_roll = WebDKP_Bid_GetHighestRoll();
	local _,_,link = WebDKP_GetItemInfo(item);
	if(highest_roller == nil or highest_roller == "") then
		highest_roller = WebDKP_Language_lua["Others"]["NoOne"][GLanguage];
		high_roll = 0;
	end
	--convert the item to a link
	local _,_,link = WebDKP_GetItemInfo(item);
	local tellLocation = WebDKP_GetTellLocation();

	local toSay = WebDKP_Language_lua["Announcments"]["RollEnd"][GLanguage];
	toSay = string.gsub(toSay, "$item", link);
	toSay =	string.gsub(toSay, "$name", highest_roller);
	toSay =	string.gsub(toSay, "$roll", high_roll);

	local announceText = WebDKP_Options_SnGa["EditERollAnnounce"]; 
	if WebDKP_Options_SnGa["Announcements"] == 1 and announceText ~= "" and announceText ~= nil then -- Anuncios Personalizados 
		announceText = string.gsub(announceText, "$item", link);
		announceText = string.gsub(announceText, "$name", highest_roller);
		announceText = string.gsub(announceText, "$roll", high_roll);
		announceText = string.gsub(announceText, "$totrol", totalrolls);
		toSay = announceText
	end

	if WebDKP_Options_SnGa["BidAnnounceRaid"] == 1 then
		WebDKP_SendAnnouncement(toSay,"RAID_WARNING");
	else
		WebDKP_SendAnnouncement(toSay,"RAID");
	end
end

-- ================================
-- Announces that an automatted timed award has just been given
-- Minutes = # of minutes that the timer is on
-- Dkp = How much dkp was just given
-- ================================
function WebDKP_AnnounceTimedAward(minutes, dkp) 
	local tellLocation = WebDKP_GetTellLocation();
	local toSay =	string.gsub(WebDKP_Language_lua["Announcments"]["TimedAward"][GLanguage], "$minutes", minutes);
	toSay =	string.gsub(toSay, "$dkp", dkp);
	WebDKP_SendAnnouncement(toSay,tellLocation);
end

-- ================================
-- Announces that an automatted boss award has just been given
-- Dkp = How much dkp was just given
-- Added by Zevious(Bronzebeard)
-- ================================
function WebDKP_AnnounceBossAward(dkp)
	local tellLocation = WebDKP_GetTellLocation();
	local toSay =	string.gsub(WebDKP_Language_lua["Announcments"]["BossAwardNum"][GLanguage], "$dkp", dkp);
	WebDKP_SendAnnouncement(toSay,tellLocation);
end

-- ================================
-- Sends out an announcent to the screen. 
-- Possible locations are:
-- "RAID", "PARTY", "GUILD", or "NONE"
-- If "NONE" is selected it will output to the players console.
-- This method will also look for line breaks in 'toSay'. If a \n is seen 
-- in the text, the text will be divided into seperate messages at that point. 
-- Example: Hello \n there!
--			Zedd: Hello
--			Zedd: there!
-- ================================
function WebDKP_SendAnnouncement(toSay, location)
	if ( location == "NONE" ) then
		WebDKP_Print(toSay);
	else
		local newLineLoc = string.find(toSay,"\n");
		local tempToSay;
		local breaker = 0 ; 
		
		while (newLineLoc  ~= nil ) do 
			tempToSay = string.sub(toSay,0,newLineLoc-1);
			SendChatMessage(tempToSay,location);
			--trim to say of what we just said
			toSay = string.sub(toSay,newLineLoc+1,string.len(toSay));
			-- get the start of the next new line
			newLineLoc = string.find(toSay,"\n");
		end
		-- finish saying what is left
		SendChatMessage(toSay,location);
	end
end

-- ================================
-- Sends an announcement to the default location
-- ================================
function WebDKP_SendAnnouncementDefault(toSay)
	local tellLocation = WebDKP_GetTellLocation();
	WebDKP_SendAnnouncement(toSay, tellLocation);
end

-- ================================
-- Announces the top 3 bids
-- ================================
function WebDKP_AnnounceTop3() -- Modified by SnGa
	if WebDKP_Options_SnGa["SilentBidding"] == 0 then --Subastas Silenciosas
		local tellLocation = WebDKP_GetTellLocation();
		local highestBidder1, highestBidder2, highestBidder3, highestBid1, highestBid2, highestBid3 = WebDKP_Bid_GetTopThree();

		-- If there was only two people who bids, the third would need to be set to 0 so its not a nil value.
		if(highestBidder1 == nil or highestBidder1 == "") then
			highestBidder1 = "NA";
			highestBid1 = 0;
		end
		if(highestBidder2 == nil or highestBidder2 == "") then
			highestBidder2 = "NA";
			highestBid2 = 0;
		end
		if(highestBidder3 == nil or highestBidder3 == "") then
			highestBidder3 = "NA";
			highestBid3 = 0;
		end
		if WebDKP_Options_SnGa["AnonymousBids"] == 1 then --Ofertas Anonimas
			highestBidder1 = WebDKP_Language_lua["Others"]["SomeOne"][GLanguage];
			highestBidder2 = WebDKP_Language_lua["Others"]["SomeOne"][GLanguage];
			highestBidder3 = WebDKP_Language_lua["Others"]["SomeOne"][GLanguage];
		end

		local announceText = WebDKP_Language_lua["Announcments"]["Top3"][GLanguage]
		WebDKP_SendAnnouncement(announceText,tellLocation);
		if highestBid == 0 then
			WebDKP_SendAnnouncement(WebDKP_Language_lua["Announcments"]["NoneBids"][GLanguage], tellLocation);
		else
			WebDKP_SendAnnouncement("WebDKP: 1ro: "..highestBidder1.." >> "..highestBid1.." dkps" ,tellLocation);
			WebDKP_SendAnnouncement("WebDKP: 2do: "..highestBidder2.." >> "..highestBid2.." dkps" ,tellLocation);
			WebDKP_SendAnnouncement("WebDKP: 3ro: "..highestBidder3.." >> "..highestBid3.." dkps" ,tellLocation);
		end
	else
		WebDKP_Print(WebDKP_Language_lua["WebDKP_Error"]["Top3Silent"][GLanguage])
	end
end
