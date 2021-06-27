------------------------------------------------------------------------
-- BIDDING	
------------------------------------------------------------------------
-- Contains methods related to bidding and the bidding gui.
------------------------------------------------------------------------

local WebDKP_BidList = {};					-- Will hold the bids placed during run time
local WebDKP_bidCountdown = 0;				-- How many seconds until bid ends on its own
local WebDKP_startingBid = 0 ;				-- the default starting bid if something cannot be found in the loot table (NOT the current starting bid which is read from the gui)

WebDKP_bidInProgress = false;				-- Bid in progress?.
WebDKP_RollInProgress = false;				-- Roll in progress?
WebDKP_bidItem = "";						-- Item name being bid on
WebDKP_bidItemLink = "";                    -- This is the item link for the chat window.
WebDKP_lastBidItem = "";					-- The last item that was bidded on and actually awarded. Flagged so that auto fill will not to show a popup when it is given out
WebDKP_Rolls = {};							-- Store the rolls
WebDKP_Roll_Total = 1;

-- Data structure for sorting the table 
WebDKP_BidSort = {
	["curr"] = 2,							-- the column to sort
	["way"] = 1								-- Desc
};

--------------------------[  Added By SnGa  ]---------------------------
local bidall_flag = false; 					-- Bandera de !bidall
local sale_flag = false;
local WebDKP_Item_Preview = nil; 			-- Item de la subasta anterior
local WebDKP_Ultimo_Bid = { };  			-- Ultimo postor aceptado (utilizado en caso de reapertura de subasta)

WebDKP_Name_Preview = nil; 					-- Postor de la oferta aceptada
WebDKP_Bid_Preview = 0; 					-- Oferta correcta anterior
WebDKP_Value_Min = 0;   					-- Siguiente valor minimo para apostar

-- ================================
-- Toggles displaying the bidding panel
-- ================================
function WebDKP_Bid_ToggleUI() -- Modified by SnGa
	if ( WebDKP_BidFrame:IsShown() ) then
		WebDKP_BidFrame:Hide();
	else
		WebDKP_BidFrame:Show();
		
		WebDKP_BidFrameBid:Show();
		WebDKP_BidFrameDKP:Show();
		WebDKP_BidFramePost:Show();
		WebDKP_BidFrameStartingBid:Show();
		WebDKP_BidFrameTop3Button:Show();
		WebDKP_BidFrameTitle:Show();
		WebDKP_BidFrameScrollFrame:Show();

		local time = WebDKP_BidFrameTime:GetText();

		if(time == nil or time == "") then
			WebDKP_BidFrameTime:SetText("0");
		end
	end
end

-- ================================
-- Shows the Bid UI
-- ================================
function WebDKP_Bid_ShowUI()
	WebDKP_BidFrame:Show();
	local time = WebDKP_BidFrameTime:GetText();
	
	if(time == nil or time == "") then
		WebDKP_BidFrameTime:SetText("0");
	end
end

-- ================================
-- Called when mouse goes over a dkp line entry. 
-- If that player is not selected causes that row
-- to become 'highlighted'
-- ================================
function WebDKP_Bid_HandleMouseOver(self) -- Modified by SnGa
	local this = self;
	local playerBid =0;
	local playerName = getglobal(this:GetName().."Name"):GetText();

	playerBid = getglobal(this:GetName().."Bid"):GetText() + 0 ;		
	
	if playerBid == nil then
		playerBid = 0;
	end
	local selected = WebDKP_Bid_IsSelected(playerName, playerBid);
	
	if( not selected ) then
		getglobal(this:GetName() .. "Background"):SetVertexColor(0.2, 0.2, 0.7, 0.5);
	end
end

-- ================================
-- Called when a mouse leaves a dkp line entry. 
-- If that player is not selected, causes that row
-- to return to normal (none highlighted)
-- ================================
function WebDKP_Bid_HandleMouseLeave(self) -- Modified by SnGa
local this = self;
	local playerBid = 0;
	local playerName = getglobal(this:GetName().."Name"):GetText();
	
	playerBid = getglobal(this:GetName().."Bid"):GetText() + 0 ;		
	
	if playerBid == nil then
		playerBid = 0;
	end
	local selected = WebDKP_Bid_IsSelected(playerName, playerBid);
	if( not selected ) then
		getglobal(this:GetName() .. "Background"):SetVertexColor(0, 0, 0, 0);
	end
end

-- ================================
-- Called when the user clicks on a player entry. Causes 
-- that entry to either become selected or normal
-- and updates the dkp table with the change
-- ================================
function WebDKP_Bid_SelectPlayerToggle(self) -- Modified by SnGa
local this = self;
		
	local playerName = getglobal(this:GetName().."Name"):GetText();
	
	local playerBid2 = 0;
	
	playerBid2 = getglobal(this:GetName().."Bid"):GetText() + 0;		
	
	if playerBid2 == nil then
		playerBid2 = 0;
	end
	
	-- we need to search through the table and figure out which one was selected
	-- an entry is considered a unique name / bid pair
	-- once we find an entry we can toggle its selection state
	for key, v in pairs(WebDKP_BidList) do
		if ( type(v) == "table" ) then
			if( v["Name"] ~= nil and v["Bid"] ~= nil ) then
				if ( v["Name"] == playerName and WebDKP_ROUND(v["Bid"],2) == playerBid2 ) then
					if (v["Selected"] == true) then
						v["Selected"] = false;
						getglobal(this:GetName() .. "Background"):SetVertexColor(0.2, 0.2, 0.7, 0.5);
					else
						-- deselect all the others on the table
						WebDKP_Bid_DeselectAll();
						
						v["Selected"] = true;
						getglobal(this:GetName() .. "Background"):SetVertexColor(0.1, 0.1, 0.9, 0.8);
					end
				end
			end
		end
	end
	
	WebDKP_Bid_UpdateTable();	

end

-- ================================
-- Returns true if the given player name / bid value is selected
-- in the bid list table. false otherwise. 
-- ================================
function WebDKP_Bid_IsSelected(playerName, playerBid) -- Modified by SnGa
	playerBid = playerBid + 0 ; 
	playerbidcompare = 0;
	
	for key, v in pairs(WebDKP_BidList) do
		if ( type(v) == "table" ) then
			if( v["Name"] ~= nil and v["DKP"] ~= nil ) then
				playerbidcompare = v["Bid"];
				playerbidcompare = tonumber(playerbidcompare);
				playerbidcompare = WebDKP_ROUND(playerbidcompare, 2 );
				if ( v["Name"] == playerName and playerbidcompare == playerBid ) then 
					return v["Selected"];
				end
			end
		end
	end

	return false;

end

-- ================================
-- Deselects all entries in the table
-- ================================
function WebDKP_Bid_DeselectAll() -- Modified by SnGa
	for key, v in pairs(WebDKP_BidList) do
		if ( type(v) == "table" ) then
			if( v["Name"] ~= nil and v["DKP"] ~= nil ) then
				v["Selected"] = false;
			end
		end
	end	
end

-- ================================
-- Called when a player clicks on a column header on the table
-- Changes the sorting options / asc&desc. 
-- Causes the table display to be refreshed afterwards
-- to player instantly sees changes
-- ================================
function WebDKP_Bid_SortBy(id) -- Modified by SnGa
	if ( WebDKP_BidSort["curr"] == id ) then
		WebDKP_BidSort["way"] = abs(WebDKP_BidSort["way"]-1);
	else
		WebDKP_BidSort["curr"] = id;
		if( id == 1) then
			WebDKP_BidSort["way"] = 0;
		elseif ( id == 2 ) then
			WebDKP_BidSort["way"] = 1; --columns with numbers need to be sorted different first in order to get DESC right
		elseif ( id == 3 ) then
			WebDKP_BidSort["way"] = 1; --columns with numbers need to be sorted different first in order to get DESC right
		else
			WebDKP_BidSort["way"] = 1; --columns with numbers need to be sorted different first in order to get DESC right
		end	
	end

	-- update table so we can see sorting changes
	WebDKP_Bid_UpdateTable();		

end

-- ================================
-- Rerenders the sorted table to the screen. This is called 
-- on a few instances - when the scroll frame throws an 
-- event or when bids are placed or when a bid ends. 
-- General structure:
-- First runs through the table to display and puts the data
-- into a temp array to work with
-- Then uses sorting options to sort the temp array
-- Calculates the offset of the table to determine
-- what information needs to be displayed and in what lines 
-- of the table it should be displayed
-- ================================
function WebDKP_Bid_UpdateTable() -- Modified by SnGa
	-- Copy data to the temporary array
	local entries = { };
	for key_name, v in pairs(WebDKP_BidList) do
		if ( type(v) == "table" ) then
			if( v["Name"] ~= nil and v["Bid"] ~= nil and v["DKP"] ~=nil and v["Post"] ~=nil) then
				tinsert(entries,{v["Name"],v["Bid"],v["DKP"],v["Post"],v["Date"],v["Roll"],v["Spec"],v["GuildRank"]}); -- copies over name, bid, dkp, dkp-bid,date,roll,spec, and guild rank
			end
		end
	end
	
	-- SORT
	table.sort(
		entries,
		function(a1, a2)
			if ( a1 and a2 ) then
				if ( a1 == nil ) then
					return 1>0;
				elseif (a2 == nil) then
					return 1<0;
				end
				if ( WebDKP_BidSort["way"] == 1 ) then
					if ( a1[WebDKP_BidSort["curr"]] == a2[WebDKP_BidSort["curr"]] ) then
						return a1[1] > a2[1];
					else
						return a1[WebDKP_BidSort["curr"]] > a2[WebDKP_BidSort["curr"]];
					end
				else
					if ( a1[WebDKP_BidSort["curr"]] == a2[WebDKP_BidSort["curr"]] ) then
						return a1[1] < a2[1];
					else
						return a1[WebDKP_BidSort["curr"]] < a2[WebDKP_BidSort["curr"]];
					end
				end
			end
		end
	);
	
	local numEntries = getn(entries);
	local offset = FauxScrollFrame_GetOffset(WebDKP_BidFrameScrollFrame);
	FauxScrollFrame_Update(WebDKP_BidFrameScrollFrame, numEntries, 15, 13);
	
	-- Run through the table lines and put the appropriate information into each line
	for i=1, 13, 1 do
		local line = getglobal("WebDKP_BidFrameLine" .. i);
		local nameText = getglobal("WebDKP_BidFrameLine" .. i .. "Name");
		local bidText = getglobal("WebDKP_BidFrameLine" .. i .. "Bid");
		local dkpText = getglobal("WebDKP_BidFrameLine" .. i .. "DKP");
		local postBidText = getglobal("WebDKP_BidFrameLine" .. i .. "Post");
		local rollText = getglobal("WebDKP_BidFrameLine" .. i .. "Roll");
		local SpecText = getglobal("WebDKP_BidFrameLine" .. i .. "Spec");
		local GuildRankText = getglobal("WebDKP_BidFrameLine" .. i .. "GuildRank");
		local index = i + FauxScrollFrame_GetOffset(WebDKP_BidFrameScrollFrame); 


		if ( index <= numEntries) then
			local playerName = entries[index][1];
			local date = entries[index][5];
			
			if WebDKP_DkpTable[playerName] == nil then
				WebDKP_DkpTable[playerName] = {};
			end
			local playerClass = ColorPostor(playerName, entries[index][2])
			playerClass = string.upper(playerClass);
			playerClass = string.gsub(playerClass, " ", "");

			-- Set line
			line:Show();
			nameText:SetText(playerName);
			
			if RAID_CLASS_COLORS[playerClass] ~= nil then
				nameText:SetTextColor(RAID_CLASS_COLORS[playerClass]["r"],RAID_CLASS_COLORS[playerClass]["g"],RAID_CLASS_COLORS[playerClass]["b"]);
			end
			
			bidText:SetText(WebDKP_ROUND(entries[index][2], 2 ));
			dkpText:SetText(WebDKP_ROUND(entries[index][3], 2 ));
			postBidText:SetText(WebDKP_ROUND(entries[index][4], 2 ));
			
			if entries[index][2] == 0 then
				rollText:SetText(ColorClass(entries[index][6]));
			else
				rollText:SetText(entries[index][6]);
			end
			
			SpecText:SetText(entries[index][7]);
			GuildRankText:SetText(entries[index][8]);

			-- kill the background of this line if it is not selected
			if( WebDKP_BidList[playerName..date] and (not WebDKP_BidList[playerName..date]["Selected"]) ) then
				getglobal("WebDKP_BidFrameLine" .. i .. "Background"):SetVertexColor(0, 0, 0, 0);
			else
				getglobal("WebDKP_BidFrameLine" .. i .. "Background"):SetVertexColor(0.1, 0.1, 0.9, 0.8);
			end
		else
			-- if the line isn't in use, hide it so we dont' have mouse overs
			line:Hide();
		end
	end
end

-- ================================
-- Handles chat messages directed towards bidding. This includes
-- placing a bid and remotly starting / stopping a bid.
-- ================================
function WebDKP_Bid_Event(trigger, name) -- Modified by SnGa
	if(WebDKP_IsBidChat(name,trigger)) then

		if (WebDKP_Options_SnGa["BidsPerBand"] == 1) then 					-- Ofertas por Banda
			if (string.find(string.lower(trigger), "!bid")==1) then	
				WebDKP_Bid_Receiveded(name,trigger);
			
			elseif (string.find(string.lower(trigger), "!casino")==1) then	
				WebDKP_AddBidder_Casino(name,trigger);

			elseif (string.find(string.lower(trigger), WebDKP_Language_lua["WisperDKP"]["Cancel"][GLanguage])==1) then	
				WebDKP_DelBidder_Casino(name,trigger);
			end
		end

	end
end

-- ================================
-- Gets the current starting bid from the gui
-- ================================
function WebDKP_GetStartingBid()
	local start = WebDKP_BidFrameStartingBid:GetText();
	if ( start == nil or start == "") then
		start = 0;
	end
	return start+0; -- add + 0 to convert it to an int
end

-- ================================
-- Returns true if the passed whisper is a chat message directed
-- towards web dkp bidding
-- ================================
function WebDKP_IsBidChat(name, trigger)
	local Cancel_cmd = WebDKP_Language_lua["WisperDKP"]["Cancel"][GLanguage];
	if ( string.find(string.lower(trigger), "!bid" )	== 1 or
		 string.find(string.lower(trigger), "!casino")	== 1 or 
		 string.find(string.lower(trigger), Cancel_cmd) == 1
		) then
        return true
    end
    return false
end

-- ================================
-- Triggers Bidding to Start
-- ================================
function WebDKP_Bid_StartBid(item, time) -- Modified by SnGa
	if item ~= "" and item ~= nil then
	
		WebDKP_BidFrameBidButton:SetText(Bidding_EndEvent);
	
		for key_name, v in pairs(WebDKP_BidList) do
			if ( type(v) == "table" ) then
				if (tonumber(v["Bid"]) == WebDKP_Bid_Preview) and (v["Name"] == WebDKP_Name_Preview) then
					WebDKP_Ultimo_Bid = {};
					WebDKP_Ultimo_Bid[v] = v;
				end
			end
		end
		WebDKP_BidList = {};
		if not sale_flag then
			WebDKP_BidList = WebDKP_Ultimo_Bid;
		end

		if (time == "" or time == nil or time=="0" or time==" ") then
			time = 0 ; 
		end
	
		local quality, itemName, itemLink, itemLevel = WebDKP_GetItemInfo(item);
		WebDKP_bidItem = itemName;
		WebDKP_bidItemLink = itemLink;
		WebDKP_BidFrameItem:SetText(itemName);
		WebDKP_BidFrameTime:SetText(time);
		WebDKP_Bid_ItemNameChanged();

		if (WebDKP_Item_Preview ~= item) then
			WebDKP_Item_Preview = item;
			WebDKP_Limpiar_Ofertas();
		end

		-- if the options ask for it, also make an announcement in a raid warning
		if WebDKP_Options_SnGa["SilentBidding"] == 0 then 				--Subastas Silenciosas
			local channel = " /Wisp!";
			toSay = nil;

			if WebDKP_Options_SnGa["BidsPerBand"] == 1 then 			--Ofertas por Banda
				channel   = " /Raid";
			end

			if (WebDKP_Bid_Preview == 0) then
				toSay =	string.gsub(Bidding_OpenEvent .. channel, "$item", item); 
			else
				toSay =	string.gsub(Bidding_ReopenEvent .. channel, "$item", item); 
			end
			if WebDKP_Options_SnGa["BidAnnounceRaid"] == 1 then  		--Anunciar por Alertas de Banda
				WebDKP_SendAnnouncement(toSay,"RAID_WARNING");
			else
				WebDKP_SendAnnouncement(toSay,"RAID");
			end
		end 
		WebDKP_bidInProgress = true;
		WebDKP_BidFrameItem:SetText(itemLink);
		
		if (WebDKP_Bid_Preview == 0) then
		WebDKP_AnnounceBidStart(itemLink, time, WebDKP_GetStartingBid());
		end

		WebDKP_Bid_UpdateTable();

		WebDKP_Bid_ShowUI();
	
		if(time ~= 0 ) then 
			WebDKP_bidCountdown = time;
			WebDKP_Bid_UpdateFrame:Show();
		else
			WebDKP_Bid_UpdateFrame:Hide();
		end
	else
		WebDKP_Print(Bidding_ItemSelect);
	end
end

-- ================================
-- Stops the current bidding
-- ================================
function WebDKP_Bid_StopBid(flag) -- Modified by SnGa
	local totalbids = 0;
	WebDKP_Bid_UpdateFrame:Hide();										-- stop any countdowns
	
	WebDKP_BidFrameBidButton:SetText(Bidding_StartEvent);
	local bidder, bid = WebDKP_Bid_GetHighestBid();						-- find highest bidder (not used any more)
	for key_name, v in pairs(WebDKP_BidList) do
		if ( type(v) == "table" ) then
			totalbids = totalbids + 1;
		end
	end
	
	if not flag then
		WebDKP_AnnounceBidEnd(WebDKP_bidItem, bidder, bid, 
							  totalbids, WebDKP_Bid_Preview);				-- make the announcement
	end

	WebDKP_bidInProgress = false;								
	WebDKP_Bid_ShowUI();												-- show the bid gui
	
end

-- ================================
-- Handles a bid placed by a player. 
-- ================================
function WebDKP_Bid_HandleBid(playerName, bidAmount, spec) -- Modified by SnGa
	local flag = false;
	local postDkp = 0;
	if WebDKP_DkpTable[playerName] == nil then
		WebDKP_DkpTable[playerName] = {};
	end
	local playerGP = WebDKP_DkpTable[playerName]["gp_"..tableid];
	-- if a bid is not in progress ignore it
	if(WebDKP_bidInProgress) then 
		--load up some information about the player
		local dkp = WebDKP_GetDKP(playerName);							-- how much dkp do they have now
		postDkp = dkp - bidAmount;										-- what they will have if they spend this

		local date  = date("%Y-%m-%d %H:%M:%S");						-- record when this bid was placed
		local guildrank = WebDKP_GetGuildRank(playerName);				-- Gets the guild rank
		-- check to see if we should reject this bid if it makes the user go into negative balance
		if ( postDkp < 0 and WebDKP_Options_SnGa["BidAllowNegativeBids"] == 0 ) then
			WebDKP_SendWhisper(playerName,string.gsub(WebDKP_Language_lua["Bidding"]["Insufficient"][GLanguage], "$dkp", dkp));
		else
			--Set the success flag to return
			flag = true;
			if sale_flag and WebDKP_BidList ~= nil then
				local temp = false;
				for k, p in pairs(WebDKP_BidList) do
					if p["Name"] == playerName then
						if p["Bid"] == 0 then
							p["Bid"] = bidAmount;
							p["Post"] = p["Post"] - bidAmount;
						end
						temp = true;
						break
					end
				end
				if temp == false then
					WebDKP_BidList[playerName..date] = 	{						-- place their bid in the bid table (combine it with the date so 1 player can have multiple bids / unique indices in the table)
					["Name"] = playerName,
					["Bid"] = bidAmount,
					["DKP"] = dkp,
					["Post"] = postDkp,
					["Date"] = date,
					["Roll"] = 0,
					["Spec"] = spec,
					["GuildRank"] = guildrank;			}
				end

			else
				WebDKP_BidList[playerName..date] = 	{						-- place their bid in the bid table (combine it with the date so 1 player can have multiple bids / unique indices in the table)
				["Name"] = playerName,
				["Bid"] = bidAmount,
				["DKP"] = dkp,
				["Post"] = postDkp,
				["Date"] = date,
				["Roll"] = 0,
				["Spec"] = spec,
				["GuildRank"] = guildrank;			}

				if(WebDKP_BidList[playerName..date]["Selected"]==nil) then
					WebDKP_BidList[playerName..date]["Selected"] = false;
				end
			end	
			
			WebDKP_Bid_UpdateTable();
		
		end

		return flag;
	
	else
		WebDKP_SendWhisper(playerName, Bidding_NoEvent);
	end
end

-- ================================
-- Returns the highest bidder and what they bid. 
-- ================================
function WebDKP_Bid_GetHighestBid()
	local highestBidder = nil;
	local highestBid = nil; 

	for key_name, v in pairs(WebDKP_BidList) do
		if ( type(v) == "table" ) then
			if( v["Bid"] ~= nil ) then
				if highestBid == nil then
					highestBidder = v["Name"];
					highestBid = v["Bid"];
				elseif (v["Bid"] > highestBid ) then
					highestBidder = v["Name"];
					highestBid = v["Bid"];

				end
			end
		end
	end
	return highestBidder, highestBid;
end

-- ================================
-- Returns the top 3 bidders and what they bid. 
-- ================================
function WebDKP_Bid_GetTopThree()
	local highestBidder = nil;
	local highestBidder2 = nil;
	local highestBidder3 = nil;
	local highestBid = 0; 
	local highestBid2 = 0;
	local highestBid3 = 0;

	for key_name, v in pairs(WebDKP_BidList) do
		if ( type(v) == "table" ) then
			if( v["Bid"] ~= nil ) then
				if (v["Bid"] > highestBid ) then
					highestBidder = v["Name"];
					highestBid = v["Bid"];
				elseif (v["Bid"] > highestBid2 and v["Bid"] ~= highestBid) then
					highestBidder2 = v["Name"];
					highestBid2 = v["Bid"];
				elseif (v["Bid"] > highestBid3 and v["Bid"] ~= highestBid and v["Bid"] ~= highestBid2 ) then
					highestBidder3 = v["Name"];
					highestBid3 = v["Bid"];
				
				end
			end
		end
	end
	return highestBidder, highestBidder2, highestBidder3, highestBid, highestBid2, highestBid3;
end

-- ===============================================================================
-- Returns the highest roller and what they rolled. 
-- ===============================================================================
function WebDKP_Bid_GetHighestRoll()
	local highestRoller = WebDKP_Language_lua["Others"]["NoOne"][GLanguage];
	local highestRoll = 0; 

	for key_name, v in pairs(WebDKP_BidList) do
		if ( type(v) == "table" ) then
			if( v["Roll"] ~= nil and v["Roll"] ~= "NA") then
				if (v["Roll"] > highestRoll) then
					highestRoller = v["Name"];
					highestRoll = v["Roll"];

				end
			end
		end
	end
	return highestRoller, highestRoll;
end

-- ================================
-- Method invoked when the user clicks the award button the on 
-- bid frame. Finds the first person who is selected
-- and awards them the item. 
-- ================================
function WebDKP_Bid_AwardSelected() -- Modified by SnGa
	-- find out who is selected
	local player, bid, spec = WebDKP_Bid_GetSelected();
	local _, item,link = WebDKP_GetItemInfo(WebDKP_bidItem);
	local startingBid = WebDKP_BidFrameStartingBid:GetText();
	if startingBid ~= nil then
		startingBid = tonumber(startingBid);
	end
	-- Check to see if the persons bid is less than the startingBid or minimum. If it is then Negative Bids must be enabled so change their bid to the startingBid value for the confirmation box.
	if startingBid ~= nil and bid < startingBid then
		bid = startingBid;
	end
	
	-- if someone is selected, award them the item via the award class
	if ( player == nil ) then 
		WebDKP_Print(WebDKP_Language_lua["Bidding"]["NoPJ"][GLanguage]);
		PlaySound_Fixed("igQuestFailed");
	else
		--since we are awarding, stop the bid
		if WebDKP_bidInProgress then
			WebDKP_Bid_StopBid();
		end
	
		if WebDKP_Options_SnGa["ItemLevelEquation"] == 1 or WebDKP_Options_SnGa["SlotLocMult"] == 1 then
			bid = WebDKP_BidFrameStartingBid:GetText();
			bid = tonumber(bid);
		end
		-- check the options to see if we need to display a confirmation box
		if ( WebDKP_Options_SnGa["BidConfirmPopup"] == 1 or bid == nil) then
			local temp = WebDKP_Language_lua["Bidding"]["AssignPJ"][GLanguage];
			temp = string.gsub(temp, "$link", link)
			temp = string.gsub(temp, "$player", player)
			temp = string.gsub(temp, "$bid", bid)
			WebDKP_Bid_ShowConfirmFrame(temp,bid);

		else

			WebDKP_Bid_AwardPerson(bid);

		end
	end
end

-- ================================
-- Auto Assign the Loot Item. 
-- Auto Give the Item. 
-- Added by Zevious (Bronzebeard)
-- ================================
function Auto_Assign_Item_Player(player)
	local _, item,link = WebDKP_GetItemInfo(WebDKP_bidItem);
	local numberInRaid = 0;

	if Is_WoWLK then
		numberInRaid = GetNumRaidMembers();
	else -- Is Classic				
		numberInRaid = GetNumGroupMembers(); -- Fix Classic
	end

	for ci = 1, numberInRaid do
		candidate = GetMasterLootCandidate(ci);
		-- name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(ci);
		if (candidate == player ) then
			for li = 1, GetNumLootItems() do
			 	local lootIcon, lootName, lootQuantity, rarity, locked = GetLootSlotInfo(li);
				if(lootName == item) then
					GiveMasterLoot(li, ci);
					ci = numberInRaid + 1;
				end
			end
		end
	end
end

-- ================================
-- Event handler for the start / stop bid button. 
-- This button toggles between states when clicked. 
-- ================================
function WebDKP_Bid_ButtonHandler()
	-- clear the rolling in case rolling and bidding are monitored at the same time
	if WebDKP_RollInProgress then
		WebDKP_Roll_Stop(true);
	end									
	for i = 1, WebDKP_Roll_Total, 1 do
		WebDKP_Rolls[i] = nil; 
	end
	WebDKP_Roll_Total = 1;

	if WebDKP_bidInProgress then
		WebDKP_Bid_StopBid();	
	else

		local item = WebDKP_BidFrameItem:GetText();
		local time = WebDKP_BidFrameTime:GetText();
		WebDKP_Bid_StartBid(item, time);

	end
end

-- ================================
-- Event handler for the start / stop roll button. 
-- This button toggles between states when clicked. 
-- ================================
function WebDKP_Roll_Initiate()
	if WebDKP_bidInProgress then
		WebDKP_Bid_StopBid(true);
	end

	if(WebDKP_RollInProgress) then
		WebDKP_Roll_Stop();		
	else
		local item = WebDKP_BidFrameItem:GetText();
		local time = WebDKP_BidFrameTime:GetText();
		WebDKP_Roll_Start(item, time);
	end
end

-- ================================
-- Method invoked when the user clicks the award button the on 
-- bid frame. Finds the first person who is selected
-- and awards them the item. 
-- ================================
function WebDKP_Bid_GetSelected()
	for key_name, v in pairs(WebDKP_BidList) do
		if ( type(v) == "table" ) then
			if(  v["Selected"] == true) then
				return v["Name"], v["Bid"],v["Spec"];
			end
		end
	end
	return nil, 0;
end

-- ================================
-- Event handler for the bidding update frame. The update frame is visible (and calling this method)
-- when a timer value was specified. The addon countdowns until 0 - and when it reaches 0 it stops
-- the current bid
-- ================================
function WebDKP_Bid_OnUpdate(self,elapsed)	-- Modified by SnGa
local this = self;
	this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed; 	

	if (this.TimeSinceLastUpdate > 1.0) then
		-- Check to see if a roll is in progress and if so get the highest roller
		if WebDKP_RollInProgress then
			highest_roller, high_roll = WebDKP_Bid_GetHighestRoll();
		end
		this.TimeSinceLastUpdate = 0;
		-- decrement the count down
		WebDKP_bidCountdown = WebDKP_bidCountdown - 1;
		
		highest_bidder, high_bid = WebDKP_Bid_GetHighestBid();
		if highest_bidder == nil then
			highest_bidder = WebDKP_Language_lua["Others"]["NoOne"][GLanguage]; 
			high_bid = 0;
		end
		local _,_,link = WebDKP_GetItemInfo(WebDKP_bidItem);
		
		local rollmessage = "";

		if WebDKP_bidInProgress and WebDKP_Options_SnGa["SilentBidding"] == 0 then 									-- Subastas Silenciosas			
			if (WebDKP_Bid_Preview == 0) then
				rollmessage = WebDKP_Language_lua["Bidding"]["AuctionSec"][GLanguage];
			else
				rollmessage = Bidding_EventTime;
			end

			if WebDKP_Options_SnGa["AnonymousBids"] == 1 then 														-- Ofertas anonimas
				highest_bidder = WebDKP_Language_lua["Others"]["SomeOne"][GLanguage];
			end

			rollmessage = string.gsub(rollmessage, "$name", highest_bidder);
			rollmessage = string.gsub(rollmessage, "$dkp", high_bid);
			rollmessage = string.gsub(rollmessage, "$item", link);


			local announceText = WebDKP_Options_SnGa["EditDuringAnnounce"];
			if WebDKP_Options_SnGa["Announcements"] == 1 and announceText ~= "" and announceText ~= nil then 		-- Anuncios Personalizados
				rollmessage = announceText
			end

			if ( WebDKP_bidCountdown == 50 ) then						-- 45 seconds left 
				rollmessage =	string.gsub(rollmessage, "$time", "50");
				WebDKP_SendAnnouncementDefault(rollmessage);

			elseif ( WebDKP_bidCountdown == 40 ) then					-- 15 seconds left
				rollmessage =	string.gsub(rollmessage, "$time", "40");
				WebDKP_SendAnnouncementDefault(rollmessage);

			elseif ( WebDKP_bidCountdown == 30 ) then					-- 5 seconds left 
				rollmessage =	string.gsub(rollmessage, "$time", "30");
				WebDKP_SendAnnouncementDefault(rollmessage);

			elseif ( WebDKP_bidCountdown == 20 ) then					-- 15 seconds left
				rollmessage =	string.gsub(rollmessage, "$time", "20");
				WebDKP_SendAnnouncementDefault(rollmessage);

			elseif ( WebDKP_bidCountdown == 10 ) then					-- 5 seconds left 
				rollmessage =	string.gsub(rollmessage, "$time", "10");
				WebDKP_SendAnnouncementDefault(rollmessage);
				
			elseif ( WebDKP_bidCountdown <= 0 ) then					-- countdown reached 0

				-- stop the bidding!
				WebDKP_Bid_StopBid();
			end
		elseif WebDKP_bidInProgress and WebDKP_Options_SnGa["SilentBidding"] == 1 then 								-- Subastas Silenciosas
			if ( WebDKP_bidCountdown <= 0 ) then						-- countdown reached 0
				-- stop the bidding!
				WebDKP_Bid_StopBid();
			end

		else
			rollmessage = WebDKP_Language_lua["Bidding"]["RollTime"][GLanguage];
			rollmessage = string.gsub(rollmessage, "$name", highest_roller);
			rollmessage = string.gsub(rollmessage, "$roll", high_roll);
			rollmessage = string.gsub(rollmessage, "$item", link);

			local announceRollText = WebDKP_Options_SnGa["EditRollAnnounce"];
			if WebDKP_Options_SnGa["Announcements"] == 1 and announceRollText ~= "" and announceRollText ~= nil then -- Anuncios Personalizados
				rollmessage = announceRollText
			end

			if ( WebDKP_bidCountdown == 50 ) then						-- 45 seconds left 
				rollmessage =	string.gsub(rollmessage, "$time", "50");
				WebDKP_SendAnnouncementDefault(rollmessage);

			elseif ( WebDKP_bidCountdown == 40 ) then					-- 15 seconds left
				rollmessage =	string.gsub(rollmessage, "$time", "40");
				WebDKP_SendAnnouncementDefault(rollmessage);

			elseif ( WebDKP_bidCountdown == 30 ) then					-- 45 seconds left
				rollmessage = string.gsub(rollmessage, "$time", "30");
				WebDKP_SendAnnouncementDefault(rollmessage);
			
			elseif ( WebDKP_bidCountdown == 20 ) then					-- 15 seconds left
				rollmessage = string.gsub(rollmessage, "$time", "20");
				WebDKP_SendAnnouncementDefault(rollmessage);

			elseif ( WebDKP_bidCountdown == 10 ) then					-- 5 seconds left
				rollmessage = string.gsub(rollmessage, "$time", "10");
				WebDKP_SendAnnouncementDefault(rollmessage);
				
			elseif ( WebDKP_bidCountdown <= 0 ) then					-- countdown reached 0

				WebDKP_Roll_Stop();
				
			end
		end
	end
end

-- ================================
-- Invoked when a user uses shift/alt/ctrl+click to display item details.
-- As long as a bid is not in progress and the bid gui is displayed, 
-- fill the item information into the form
-- ================================
function WebDKP_Bid_ItemChatClick(link, text, button) --Modified by SnGa
	if ( IsControlKeyDown() or IsAltKeyDown() or IsShiftKeyDown() ) then 
		if ( WebDKP_BidFrame:IsShown() and WebDKP_bidInProgress == false ) then

			local _,itemName,itemLink = WebDKP_GetItemInfo(link); 		
			local itemRarity, itemName2, itemLink, itemLevel, itemEquipLoc = WebDKP_GetItemInfo(itemName);

			WebDKP_BidFrameItem:SetText(itemLink);
            WebDKP_bidItemLink = itemLink;
			-- fill in the starting bid if we can find it
			local partialBid, inLoot = WebDKP_GetLootTableCost(itemName);
			WebDKP_ItemFound(partialBid, inLoot);

			startingBid = Calculate_StartingBid(partialBid, inLoot, itemLevel, itemEquipLoc)

			if startingBid ~= nil then
				WebDKP_BidFrameStartingBid:SetText(startingBid);
			end 
		end
	end
end

-- ================================
-- Called when the user enters a new item name in the item name textbox. 
-- Checks to see if it can autoload a new starting bid
-- Checks to see if the Item Level Multi and Slot level Multi are enabled
-- ================================
function WebDKP_Bid_ItemNameChanged() --Modified by SnGa
	local itemName = WebDKP_BidFrameItem:GetText();
	local multiplier1 = WebDKP_Options_SnGa["ItemLevelMult"];
	local itemRarity, itemName2, itemLink, itemLevel, itemEquipLoc = WebDKP_GetItemInfo(itemName);
	local changedflag = 0;
	
	local partialBid, inLoot = WebDKP_GetLootTableCost(itemName);
	WebDKP_ItemFound(partialBid, inLoot);
	startingBid = Calculate_StartingBid(partialBid, inLoot, itemLevel, itemEquipLoc)

	if ( startingBid ~= nil ) then
		startingBid = WebDKP_ROUND(startingBid,1);
		WebDKP_BidFrameStartingBid:SetText(startingBid);
	end
end

-- ================================
-- Confirm Frame
-- ================================
function WebDKP_Bid_ShowConfirmFrame(title, cost)
	PlaySound_Fixed("igMainMenuOpen");
	WebDKP_BidConfirmFrame:Show();
	
	WebDKP_BidConfirmFrameTitle:SetText(title);
	if(cost ~= nil) then
		WebDKP_BidConfirmFrameCost:SetText(cost);
	else
		WebDKP_BidConfirmFrameCost:SetText(0);
	end

	WebDKP_BidConfirmFrameMult:SetText(1);

end

-- ================================
-- Awards the currently selected player the currently 
-- ================================
function WebDKP_Bid_AwardPerson(cost) -- Modified by SnGa
	local player,_,_ = WebDKP_Bid_GetSelected();
	local percentcost = string.find(cost, "%%");
	local percentflag = 0;
	local tableid = WebDKP_GetTableid();
	local points = 0;

	if percentcost ~= nil then
		-- This means they are entering a percent so calculate the proper cost
		-- Substitute the % with "" so we are left with just the number as a string
		cost = string.gsub(cost, "%%", "")
		cost = tonumber(cost);
		percentflag = 1;

	end

	if WebDKP_Options_SnGa["AutoGive"] == 1 then
		Auto_Assign_Item_Player(player);
	end
	
	points = cost * -1;

	if percentflag == 1 then
		--local actualname = player[0]["name"];
		cost = (cost / 100) * WebDKP_DkpTable[player]["dkp_"..tableid] * -1;
		points = WebDKP_ROUND(cost,2);
	end

	--put this into a points table for the add dkp method
	local playerTable = {};
	playerTable[0] = {}
	playerTable[0]["name"] = player;
	playerTable[0]["class"] = WebDKP_GetPlayerClass(player);
	--award the item
	
	--local _,itemName,itemLink = WebDKP_GetItemInfo(WebDKP_bidItem);
	WebDKP_AddDKP(points, WebDKP_bidItemLink, "true", playerTable)
	WebDKP_AnnounceAwardItem(points, WebDKP_bidItemLink, player);

	WebDKP_UpdateTableToShow();
	
	-- Update the table so we can see the new dkp status
	WebDKP_UpdateTable();       --update the gui
	
	PlaySound_Fixed("LOOTWINDOWCOINSOUND");

	WebDKP_Item_Preview = nil;
	WebDKP_Limpiar_Ofertas();
	
	-- Hides the Bid UI
	WebDKP_BidFrame:Hide();
	
	-- record this item as having been given in a bid
	WebDKP_lastBidItem = WebDKP_bidItem;
end

-- ================================
-- Process rolling
-- Added by Zevious (Bronzebeard)
-- ================================
function WebDKP_ProcessRoll(player, roll, min_roll, max_roll) -- Modified by SnGa
	roll = tonumber(roll);
	min_roll = tonumber(min_roll);
	max_roll = tonumber(max_roll);
	local RolledFlag = 0;
	local date  = date("%Y-%m-%d %H:%M:%S");
	local dkp = WebDKP_GetDKP(player);
	local guildrank = WebDKP_GetGuildRank(player);
	local StatusEvent = false;

	if WebDKP_Options_SnGa["Casino"] == 1 then
		if (min_roll == 1 and max_roll == 100)	then
			WebDKP_CaptureRoll_Casino(player, roll);
		end
	end

	if WebDKP_RollInProgress then
		StatusEvent = WebDKP_RollInProgress
	elseif WebDKP_bidInProgress and WebDKP_Options_SnGa["BidandRoll"] == 1 then
		StatusEvent = WebDKP_bidInProgress
	end

	if StatusEvent then

		-- Check Boundaries (1-100)
		if (min_roll == 1 and max_roll == 100)	then

			for i = 1, WebDKP_Roll_Total, 1 do
				if (WebDKP_Rolls[i] == player) then 
					RolledFlag = 1;
				end
			end


			if RolledFlag == 0 then
				local player_rolled = nil
				WebDKP_Roll_Total = WebDKP_Roll_Total + 1;
				WebDKP_Rolls[WebDKP_Roll_Total] = player

				for m, v in pairs(WebDKP_BidList) do
					if v["Name"] == player then
						v["Roll"] = roll
						player_rolled = player
						break
					end
				end
				
				if not (player_rolled == player) then
					WebDKP_BidList[player..date] = {		-- Add to main Table
						["Name"] = player,
						["Bid"] = 0,
						["DKP"] = dkp,
						["Post"] = dkp,
						["Date"] = date,
						["Roll"] = roll,
						["Spec"] = ColorClass(player, true),
						["GuildRank"] = guildrank;
					}
				end

				player_rolled = nil
				WebDKP_Bid_UpdateTable();		

			end
		end
	end
end

-- ================================
-- Triggers Rolling to Start
-- Added by Zevious (Bronzebeard)
-- ================================
function WebDKP_Roll_Start(item, time) -- Modified by SnGa
	
	if item ~= "" and item ~= nil then

		WebDKP_BidFrameRollButton:SetText(WebDKP_Language_lua["Bidding"]["EndRoll"][GLanguage]);

		WebDKP_BidList = {};
		if (time == "" or time == nil or time=="0" or time==" ") then
			time = 0 ; 
		end
	
		local quality, itemName, itemLink = WebDKP_GetItemInfo(item);
		WebDKP_bidItem = itemName;
		WebDKP_bidItemLink = itemLink;
		WebDKP_BidFrameItem:SetText(itemName);
		WebDKP_BidFrameTime:SetText(time);
		WebDKP_Bid_ItemNameChanged();
	
	
		-- if the options ask for it, also make an announcement in a raid warning
		if ( WebDKP_Options_SnGa["BidAnnounceRaid"] == 1 ) then
			toSay =	string.gsub(WebDKP_Language_lua["Bidding"]["AlertRoll"][GLanguage], "$item", item);
			WebDKP_SendAnnouncement(toSay,"RAID_WARNING");
		end	

		WebDKP_AnnounceRollStart(itemLink, time);
	
		WebDKP_RollInProgress = true;
		WebDKP_BidFrameItem:SetText(itemLink);
		
		WebDKP_Bid_UpdateTable();		
		WebDKP_Bid_ShowUI();
	
		if(time ~= 0 ) then 
			WebDKP_bidCountdown = time;
			WebDKP_Bid_UpdateFrame:Show();
		else
			WebDKP_Bid_UpdateFrame:Hide();
		end
	else
		WebDKP_Print(WebDKP_Language_lua["WebDKP_Error"]["NoItemRoll"][GLanguage]);
	end
end

-- ================================
-- Stops the current rolling
-- Added by Zevious (Bronzebeard)
-- ================================
function WebDKP_Roll_Stop(flag)
	local totalrolls = 0;
	WebDKP_Bid_UpdateFrame:Hide();										-- stop any countdowns
	for key_name, v in pairs(WebDKP_BidList) do
		if ( type(v) == "table" ) then
			totalrolls = totalrolls + 1;
		end
	end
	WebDKP_BidFrameRollButton:SetText(WebDKP_Language_lua["Bidding"]["StartRoll"][GLanguage]);
	if not flag then					
		WebDKP_AnnounceRollEnd(WebDKP_bidItem, bidder, bid, totalrolls);	-- make the announcement
	end 
	WebDKP_RollInProgress = false;								
	WebDKP_Bid_ShowUI();												-- show the bid gui
	for i = 1, WebDKP_Roll_Total, 1 do
		WebDKP_Rolls[i] = nil; 
	end
	WebDKP_Roll_Total = 1;
end
 
------------------------[  SnGa's  Functions  ]-------------------------
function WebDKP_Bid_Control( cmd, name )
--- Verifica que el !bid entrante compla con los requisitos para ser aceptado
	local bid_flag = false;
	cmd = WebDKP_Redondeo(tonumber(cmd)); 

	if (WebDKP_Bid_Preview == 0) then 
		bid_flag = true;
	else
		if sale_flag then
			bid_flag = true;
			for k, p in pairs(WebDKP_BidList) do
				if p["Name"] == name then
					bid_flag = false;
				end
			end

		elseif (WebDKP_Name_Preview ~= name) then 
			if ( bidall_flag ) then 
				if ( cmd >= WebDKP_Bid_Preview ) then 
					bid_flag = true;
				end
			else
				WebDKP_Value_Min = WebDKP_Bid_Min(WebDKP_Bid_Preview);

				if (cmd >= WebDKP_Value_Min) then
					bid_flag = true;
				end
			end
		end
	end 

	bidall_flag = false;	
	return bid_flag;

end

function WebDKP_Bid_Receiveded( name,trigger )
--- Realiza todo el analisis previo antes de aceptar una oferta correctamente
	local cmd, subcmd = WebDKP_GetCmd(trigger);
	cmd, subcmd = WebDKP_GetCommaCmd(subcmd);
	cmd = tonumber(cmd) or 0;

	if (string.find(string.lower(trigger), "!bidall") == 1) then
		bidall_flag = true;
		cmd = tonumber(WebDKP_GetDKP(name));
	end

	if WebDKP_Options_SnGa["ItemLevelEquation"] == 1 or WebDKP_Options_SnGa["SlotLocMult"] == 1 or WebDKP_SlotLocFound == 1 then 	-- Venta de Items
		sale_flag = true;
		if WebDKP_Options_SnGa["FixedPrice"] == 0 then 																				-- Precio Fijo
			sale_flag = false;
		end
	else
		sale_flag = false;
	end
	
	if cmd == (0 or WebDKP_Bid_Preview) then
		if WebDKP_Bid_Preview >= tonumber(WebDKP_Options_SnGa["AutoBidValue"]) and WebDKP_Options_SnGa["AutomaticBid"] == 1 then 	-- Bid Automatico
			cmd = WebDKP_Bid_Min(WebDKP_Bid_Preview);
		elseif sale_flag then
			cmd = WebDKP_GetStartingBid();
		else
			WebDKP_SendWhisper(name,WebDKP_Language_lua["Bidding"]["NoNumber"][GLanguage]);
		end
	end
	
	if cmd ~= 0 then 
		if(WebDKP_bidInProgress == false) then 
			WebDKP_SendWhisper(name, Bidding_NoEvent);

		elseif ( (cmd) < WebDKP_GetStartingBid() ) then
			local menssage = WebDKP_Language_lua["Bidding"]["MinimumBid"][GLanguage];
			if (WebDKP_Bid_Preview > 0) then
				WebDKP_SendWhisper(name, string.gsub(menssage, "$amount", WebDKP_Bid_Min(WebDKP_Bid_Preview))); 
			else
				WebDKP_SendWhisper(name,string.gsub(menssage, "$amount", WebDKP_GetStartingBid())); 
			end 

		else 
			if sale_flag then
				cmd = WebDKP_GetStartingBid();
			end
			if (WebDKP_Bid_Control(cmd, name) == false) then
				if sale_flag then
					WebDKP_SendWhisper(name, string.gsub(WebDKP_Language_lua["Bidding"]["BidReceived"][GLanguage],"$item", item_inprocess));
				elseif (WebDKP_Name_Preview == name) then 																
					WebDKP_SendWhisper(name, string.gsub(WebDKP_Language_lua["Bidding"]["NotNecessary"][GLanguage], "$dkp", WebDKP_Bid_Preview));
				else 
					WebDKP_SendWhisper(name, string.gsub(WebDKP_Language_lua["Bidding"]["GreatOrEqual"][GLanguage], "$dkp", WebDKP_Value_Min));
				end 
			else
				local bid_flag = WebDKP_Bid_HandleBid(name,cmd, ColorClass(name, true));
				if bid_flag then -- Oferta aceptada!
					local toSay = string.gsub(WebDKP_Language_lua["Bidding"]["BidAcepted"][GLanguage], "$cmd", cmd);
					if WebDKP_Options_SnGa["SilentBidding"] == 0 then 																-- Subastas Silenciosas
						if WebDKP_Options_SnGa["AnonymousBids"] ~= 1 then 															-- Ofertas Anonimas
							toSay =	string.gsub(toSay, "!", (string.gsub(WebDKP_Language_lua["Others"]["Of"][GLanguage], "$name", name)));
						end
						WebDKP_SendAnnouncement(toSay,"RAID");
					else
						WebDKP_SendWhisper(name,toSay);
					end

					WebDKP_Bid_Preview = cmd;

					if (WebDKP_Name_Preview ~= name) and (WebDKP_Name_Preview ~= nil) then
						if WebDKP_Options_SnGa["BidExceededAlert"] == 1 and sale_flag == false then									-- Notificar Oferta Superada
							local notify = string.gsub(WebDKP_Language_lua["Bidding"]["Notify"][GLanguage], "$dkp", WebDKP_Bid_Min(WebDKP_Bid_Preview));
							if WebDKP_Options_SnGa["AnonymousBids"] == 1 then 														-- Ofertas Anonimas
								WebDKP_SendWhisper(WebDKP_Name_Preview,WebDKP_Language_lua["Bidding"]["Anonymus"][GLanguage]..notify);
							else 
								WebDKP_SendWhisper(WebDKP_Name_Preview,string.gsub(WebDKP_Language_lua["Bidding"]["Attention"][GLanguage]..notify, "$name", name));
							end
						end
					end

					WebDKP_Name_Preview = name;

					if (string.find(string.lower(trigger), "!bidall") == 1) and sale_flag == false then
						if WebDKP_Options_SnGa["SilentBidding"] == 0 then 															-- Subastas Silenciosas
							toSay =	string.gsub(WebDKP_Language_lua["Bidding"]["BidAll"][GLanguage], "$item", WebDKP_bidItemLink);
							if WebDKP_Options_SnGa["AnonymousBids"] == 1 then 														-- Ofertas Anonimas
								toSay =	string.gsub(toSay, "$name", WebDKP_Language_lua["Others"]["SomeOne"][GLanguage]);
							else
								toSay =	string.gsub(toSay, "$name", name);
							end
							if WebDKP_Options_SnGa["BidAnnounceRaid"] == 1 then 													-- Anunciar por Alerta de Banda
								WebDKP_SendAnnouncement(toSay,"RAID_WARNING");
							else
								WebDKP_SendAnnouncement(toSay,"RAID");
							end
						end 
					end
				end
			end
		end
	end
end

function WebDKP_Limpiar_Ofertas()
---	Limpia todas las variables para Iniciar/Limnpiar una Subasta
	WebDKP_Name_Preview = nil; 				-- Postor anterior
	WebDKP_Bid_Preview = 0; 				-- Oferta anteior
	WebDKP_Ultimo_Bid = {}; 				-- Ultimo !bid valido
	WebDKP_BidList = {}; 					-- Lista de ofertas
	WebDKP_Rolls = {}						-- Lista de rolls
	WebDKP_Bid_UpdateTable();
end
