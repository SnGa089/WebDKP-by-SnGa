-------------------------[  Init  Variables  ]--------------------------
-- Additional user options and information that must be saved across reloads. 
-- Note, that this data is only here for quick reference. Many of these values are initalized
-- to default values in the Options.lua file.

WebDKP_Options_SnGa = {
	["Language"] = "ENGLISH",		-- Language for WebDKP UI - SnGa
	["Fatality"] = 1,				-- Fatality_Complement - SnGa
	["FatalityBand"] = 1,			-- Anunciar Muertes por Banda - SnGa
	["Sindra"] = 1,					-- Sindra_Log - SnGa
	["SindraBand"] = 1, 			-- Imprimir Contragolpes Mayores a 5 Marcas - SnGa
	["AutoCleanLogData"] = 1,		-- Autoborrado de Registros - SnGa
	["AutoCleanDaysLimit"] = 5,		-- Tiempo antes de borrar automaticamente los registros, 0 no borra - SnGa
	["BossDialogue"] = 0,			-- Capturar dialogos de los bosses ( solo para programadores ) - SnGa
	["AutoGive"] = 0,				-- Auto Gives Items when awarded! Caution!
	["AwardBossDKP"] = 0,			-- Award DKP on Boss Kill. 0 = disabled. 1 = enabled
	["AwardBossDKP10"] = 0,			-- If Checked 10 Man Northrend Raid bosses auto award
	["AwardBossDKP25"] = 0,			-- If Checked 25 man Northrend Raid bosses auto award
	["BossDKPValue"] = 0,			-- Amount awarded for Boss Kills
	["AutofillEnabled"] = 0,		-- Auto fill data. 0 = disabled. 1 = enabled. 
	["AutofillThreshold"] = 3,		-- What level of items should be picked up by auto fill. -1 = Gray, 4 = Orange
	["AutoAwardEnabled"] = 1,		-- Whether dkp awards should be recorded automatically if all data can be auto filled (user is still prompted)
	["SelectedTableId"] = 1,		-- The last table that was being looked at
	["MiniMapButtonAngle"] = 1,		-- MiniMap Button Position 
	["BidAnnounceRaid"] = 1,		-- Announces when bids start / stop in raid warning
	["BidConfirmPopup"] = 1,		-- Displays a popup when a winning bid is determined so that the user can tweak how much to award
	["BidAllowNegativeBids"] = 0,	-- Whether or not to allow people to bid more dkp than they have
	["BidExceededAlert"] = 1,		-- Notifica al anterior postor que su oferta fue superada - SnGa
	["BidsPerBand"] = 0,			-- Ofertas por Banda - SnGa
	["TimedAwardRepeat"] = 1,		-- Whether timed awards should repeat after they have finished
	["TimedAwardInProgress"] =false,-- Whether a timed award is in progress (0 = no, 1 = yes)
	["TimedAwardTimer"] = 0,		-- The current timer for a timed award (seconds). If a timed award is in progress and this reaches 0 an award must be given
	["TimedAwardTotalTime"] = 5,	-- How many minutes the timer started at.
	["TimedAwardDkp"] = 0,			-- How much DKP should be awarded for a timed award
	["SynchPassword"] = "",			-- Required password to synchronize.
	["EnableSynch"] = 0,			-- Enable or Disable The Synchronization
	["SynchFrom"] = "",				-- Player to Synchronize From
	["Decay"] = 1,					-- Added for Decay
	["AnonymousBids"] = 0,			-- Ofertas Anonimas - SnGa
	["SilentBidding"] = 0,			-- Added to enable silent bidding so the countdown announcements dont say whos winning or the dkp value thats highest.
	["BidandRoll"] = 0,				-- Added to enable monitoring bids and rolls at the same time.
	["FixedDiscountFS"] = 1,		-- Descuento F/S - SnGa
	["BidPercentage"] = 1, 			-- Added to enable custom !need percentages
	["AutomaticBid"] = 1,			-- Bid Automatico - SnGa
	["TimedAwardMiniTimer"] = 0,	-- 1 = mini timer is shown, 0 = mini timer is hidden
 	["Enabled"] = 1,                -- 1 = On, 0 = Off added by cather (Bronzebeard)
	["Announcements"] = 0,         	-- 1 = On, 0 = Off added by Zevious (Bronzebeard)
	["EditStartAnnounce"] = "",		-- The custom start bid message - Zev
	["EditDuringAnnounce"] = "",	-- The custom during bid message - Zev
	["EditEndAnnounce"] = "",		-- The custom end bid message - Zev
	["EditSRollAnnounce"] = "",		-- The custom start roll message - Zev
	["EditRollAnnounce"] = "",		-- The custom roll message - Zev
	["EditERollAnnounce"] = "",		-- The custom end roll message - Zev
	["InGroup"] = 1,				-- Only displays raid attendance for chars in the group
	["LimitGuild"] = 0,				-- Display people only in your guild
	["LimitGuildOnline"] = 0,		-- Limit the list to only online guild members
	["LimitAlts"] = 0,				-- Exclude all alternate players
	["LimitAlts2"] = 0,				-- Exclude alt players not in the current group
	["Standby1"] = 0,				-- Includes alts in the listing
	["Standby2"] = 0,				-- Only shows standby players
	["StartBid"] = 0,				-- Value you want all auctions to start at
	["Time"] = 0,					-- How long you want a bid or roll to last
	["AltClick"] = 1,				-- Option to disable the Alt+Click to bring up the bidding window.
	["IgnWhispers"] = 0,			-- Option to ignore whispers from people outside of the raid/party added to prevent spamming.
	["DiscountValue"] = "100",		-- Valor del descuento F/S - SnGa
	["PercentageValue"] = "5",		-- Valor Porcentaje entre Bids - SnGa
	["AutoBidValue"] = "1000",		-- Valor Bid Automatico - SnGa
	["dkpCap"] = 0,					-- Enable or disable the DKP Cap
	["dkpCapLimit"] = 0,			-- Default value is blank
	["ItemLevelEquation"] = 0,		-- Enable or Disable the Item Level Multiplier
	["ItemLevelMult"] = "1",		-- Default Item Level Multiplier
	["SlotLocMult"] = 0,			-- Slot Location Mult Enabled
	["FixedPrice"] = 1,				-- For Sales - SnGa
	["GlobalRaid"] = "",			-- For Raid Attendance - SnGa
	["GlobalStartTime"] = "",		-- For Raid Attendance - SnGa
	["Casino"] = 0,					-- For Casino - SnGa
	["CasinoLimit"] = "500",		-- For Casino - SnGa
	["CasinoWinWith"] = "79",		-- For Casino - SnGa
	["CasinoMultiplyFor"] =	"1",	-- For Casino - SnGa
	["AllInOne"] = 1, 			-- For Casino - SnGa
}

WebDKP_Equipament_SnGa = {
	["HeadSlot"] 		= { ["By"] = "1", ["Value"] = "50", },
	["NeckSlot"] 		= { ["By"] = "1", ["Value"] = "50", },
	["ShouldersSlot"] 	= { ["By"] = "1", ["Value"] = "50", },
	["BackSlot"] 		= { ["By"] = "1", ["Value"] = "50", },
	["ChestSlot"] 		= { ["By"] = "1", ["Value"] = "50", },
	["WristsSlot"] 		= { ["By"] = "1", ["Value"] = "50", },
	["HandsSlot"] 		= { ["By"] = "1", ["Value"] = "50", },
	["WaistSlot"] 		= { ["By"] = "1", ["Value"] = "50", },
	["LegsSlot"] 		= { ["By"] = "1", ["Value"] = "50", },
	["FeetSlot"] 		= { ["By"] = "1", ["Value"] = "50", },
	["FingersSlot"] 	= { ["By"] = "1", ["Value"] = "50", },
	["TrinketsSlot"] 	= { ["By"] = "1", ["Value"] = "50", },
	["MainHandSlot"] 	= { ["By"] = "1", ["Value"] = "50", },
	["ShieldSlot"] 		= { ["By"] = "1", ["Value"] = "50", },
	["RangedSlot"] 		= { ["By"] = "1", ["Value"] = "50", },
	["RelicSlot"] 		= { ["By"] = "1", ["Value"] = "50", },
	["TwoHandSlot"] 	= { ["By"] = "1", ["Value"] = "50", },
	["OneHandSlot"] 	= { ["By"] = "1", ["Value"] = "50", },
	["HeldInOffhand"] 	= { ["By"] = "1", ["Value"] = "50", },
	["OffhandWeapon"] 	= { ["By"] = "1", ["Value"] = "50", },
}

------------------------[  Global Array Logs  ]-------------------------
WebDKP_Sindra_SnGa 			= {};				-- Array Sindra Logs
WebDKP_Fatality_SnGa 		= {};				-- Array Fatality Logs
WebDKP_Casino_SnGa			= {};				-- Array Casino Logs
WebDKP_Boss_SnGa 			= {};				-- Array Boss Dialogue
WebDKP_Synch_Users 			= {}; 				-- Added by Zevious
WebDKP_Ignored_Items 		= {}; 				-- Added by Zevious
WebDKP_RaidInfo 			= {};				-- Added by Zevious
WebDKP_CharRaidInfo 		= {}; 				-- Added by Zevious

------------------------[  Global  Variables  ]-------------------------
Is_WoWLK 				  	= false; 			-- For WoW Version Detect
GLanguage 					= nil; 				-- For Lua files

--------------------------[  GUI Functions  ]---------------------------
function WebDKP_LoadLanguageGUI( Language )
--- Setea todos los textos de todos los frames del WebDKP.
	local Frame = nil;

				---------------------------------------
						 GLanguage = Language;		
				---------------------------------------

--[[]] Frame = "WebDKP_AwardFrame";
	_G[Frame.."Yes"]:SetText(WebDKP_Language_xml["Others"]["Yes"][Language]);
	_G[Frame.."No"]:SetText(WebDKP_Language_xml["Others"]["No"][Language]);
	_G[Frame.."2Yes"]:SetText(WebDKP_Language_xml["Others"]["Yes"][Language]);
	_G[Frame.."2No"]:SetText(WebDKP_Language_xml["Others"]["No"][Language]);
	_G[Frame.."3Yes"]:SetText(WebDKP_Language_xml["Others"]["Yes"][Language]);
	_G[Frame.."3No"]:SetText(WebDKP_Language_xml["Others"]["No"][Language]);
	_G[Frame.."4Yes"]:SetText(WebDKP_Language_xml["Others"]["Yes"][Language]);
	_G[Frame.."4No"]:SetText(WebDKP_Language_xml["Others"]["No"][Language]);
	_G[Frame.."5Yes"]:SetText(WebDKP_Language_xml["Others"]["Yes"][Language]);
	_G[Frame.."5No"]:SetText(WebDKP_Language_xml["Others"]["No"][Language]);

--[[]] Frame = "WebDKP_BidFrame";
	_G[Frame.."StartingBidString"]:SetText(WebDKP_Language_xml["Bid_Frame"]["StartingBid"][Language]);
	_G[Frame.."ToggleFixedPriceString"]:SetText(WebDKP_Language_xml["Bid_Frame"]["FixedPrice"][Language]);
	_G[Frame.."TimeString1"]:SetText(WebDKP_Language_xml["Bid_Frame"]["Bid/Roll"][Language]);
	_G[Frame.."TimeString2"]:SetText(WebDKP_Language_xml["Bid_Frame"]["TimeDescrip"][Language]);
	_G[Frame.."Top3Button"]:SetText(WebDKP_Language_xml["Bid_Frame"]["Top3Button"][Language]);
	_G[Frame.."BidReset"]:SetText(WebDKP_Language_xml["Bid_Frame"]["ResetButton"][Language]);
	_G[Frame.."NameString"]:SetText(WebDKP_Language_xml["Others"]["Name"][Language]);
	_G[Frame.."NameTitle"]:SetText(WebDKP_Language_xml["Bid_Frame"]["Received"][Language]);
	_G[Frame.."BidString"]:SetText(WebDKP_Language_xml["Bid_Frame"]["Bid"][Language]);
	_G[Frame.."SpecString"]:SetText(WebDKP_Language_xml["Others"]["Class"][Language]);
	_G[Frame.."GuildRankString"]:SetText(WebDKP_Language_xml["Others"]["GuildRank"][Language]);
	_G[Frame.."AwardButton"]:SetText(WebDKP_Language_xml["Bid_Frame"]["AssingButton"][Language]);
	_G[Frame.."RollButton"]:SetText(WebDKP_Language_lua["Bidding"]["StartRoll"][Language]);
	if WebDKP_RollInProgress then
		_G[Frame.."RollButton"]:SetText(WebDKP_Language_lua["Bidding"]["EndRoll"][Language]);
	end
	
--[[]] Frame = "WebDKP_BidConfirmFrame";
	_G[Frame.."CostString"]:SetText(WebDKP_Language_xml["Bid_Frame"]["ConfirmBid"][Language]);
	_G[Frame.."MultString"]:SetText(WebDKP_Language_xml["Bid_Frame"]["ConfirmMult"][Language]);
	_G[Frame.."Yes"]:SetText(WebDKP_Language_xml["Others"]["Yes"][Language]);
	_G[Frame.."No"]:SetText(WebDKP_Language_xml["Others"]["No"][Language]);

 --[[]] Frame = "WebDKP_CharRaidInfoFrame";
	_G[Frame.."Title"]:SetText(WebDKP_Language_xml["CharRaidFrame"]["Title"][Language]);
	_G[Frame.."Header"]:SetText(WebDKP_Language_xml["CharRaidFrame"]["Header"][Language]);
	_G[Frame.."FilterDaysTitle"]:SetText(WebDKP_Language_xml["CharRaidFrame"]["FiltersDays"][Language]);
	_G[Frame.."CharRaidNameString"]:SetText(WebDKP_Language_xml["Others"]["Name"][Language]);
	_G[Frame.."CharRaidAttendedString"]:SetText(WebDKP_Language_xml["CharRaidFrame"]["Attended"][Language]);
	_G[Frame.."CharRaidPercentString"]:SetText(WebDKP_Language_xml["CharRaidFrame"]["Percent"][Language]);
	_G[Frame.."CharRaidTotRaidsString"]:SetText(WebDKP_Language_xml["CharRaidFrame"]["TotalRaids"][Language]);
	_G[Frame.."CharRaidLocationString"]:SetText(WebDKP_Language_xml["CharRaidFrame"]["Location"][Language]);
	_G[Frame.."CharRaidDateString"]:SetText(WebDKP_Language_xml["CharRaidFrame"]["DateTime"][Language]);
	_G[Frame.."RemChar"]:SetText(WebDKP_Language_xml["CharRaidFrame"]["RemoveChar"][Language]);
	_G[Frame.."InGroupString"]:SetText(WebDKP_Language_xml["Others"]["OnlyInGroup"][Language]);
	_G[Frame.."FilterDateString"]:SetText(WebDKP_Language_xml["CharRaidFrame"]["StartDate"][Language]);
	_G[Frame.."ApplyFilterDateString"]:SetText(WebDKP_Language_xml["CharRaidFrame"]["ApplyFilter"][Language]);

--[[]] Frame = "WebDKP_Frame";
	_G[Frame.."Title"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Title"][Language]);
	_G[Frame.."NameString"]:SetText(WebDKP_Language_xml["Others"]["Name"][Language]);
	_G[Frame.."ClassString"]:SetText(WebDKP_Language_xml["Others"]["Class"][Language]);
	_G[Frame.."GuildRankString"]:SetText(WebDKP_Language_xml["Others"]["GuildRank"][Language]);
	_G[Frame.."HelpButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Help"][Language]);
	_G[Frame.."SelectAllButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["SelectAll"][Language]);
	_G[Frame.."DeselectAllButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["DeselectAll"][Language]);
	_G[Frame.."SaveLogButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["SaveLog"][Language]);
	_G[Frame.."RefreshButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["RefreshGroup"][Language]);
	
--[[]] Frame = "WebDKP_FiltersFrame";
	_G[Frame.."Header"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Filters"][Language]);
	_G[Frame.."SearchString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Search"][Language]);
	_G[Frame.."LimitRaidString"]:SetText(WebDKP_Language_xml["Others"]["OnlyInGroup"][Language]);
	_G[Frame.."LimitGuildString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Guild"][Language]);
	_G[Frame.."LimitGuildOnlineString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["GuildOnline"][Language]);
	_G[Frame.."LimitAltsString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["LimitAlts"][Language]);
	_G[Frame.."LimitAlts2String"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["LimitAlts2"][Language]);
	_G[Frame.."Standby1String"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Standby1"][Language]);
	_G[Frame.."Standby2String"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Standby2"][Language]);
	---------------------------------[ Classes powered by WebDKP_Language_lua ]----------------------------------
	_G[Frame.."ClassDeath_KnightString"]:SetText(WebDKP_Language_lua["MoreFunctions"]["DEATHKNIGHT"][Language]);
	_G[Frame.."ClassDruidString"]:SetText(WebDKP_Language_lua["MoreFunctions"]["DRUID"][Language]);
	_G[Frame.."ClassHunterString"]:SetText(WebDKP_Language_lua["MoreFunctions"]["HUNTER"][Language]);
	_G[Frame.."ClassMageString"]:SetText(WebDKP_Language_lua["MoreFunctions"]["MAGE"][Language]);
	_G[Frame.."ClassRogueString"]:SetText(WebDKP_Language_lua["MoreFunctions"]["ROGUE"][Language]);
	_G[Frame.."ClassShamanString"]:SetText(WebDKP_Language_lua["MoreFunctions"]["SHAMAN"][Language]);
	_G[Frame.."ClassPaladinString"]:SetText(WebDKP_Language_lua["MoreFunctions"]["PALADIN"][Language]);
	_G[Frame.."ClassPriestString"]:SetText(WebDKP_Language_lua["MoreFunctions"]["PRIEST"][Language]);
	_G[Frame.."ClassWarriorString"]:SetText(WebDKP_Language_lua["MoreFunctions"]["WARRIOR"][Language]);
	_G[Frame.."ClassWarlockString"]:SetText(WebDKP_Language_lua["MoreFunctions"]["WARLOCK"][Language]);
	-------------------------------------------------------------------------------------------------------------
	_G[Frame.."ClassChainString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Chain"][Language]);
	_G[Frame.."ClassClothString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Cloth"][Language]);
	_G[Frame.."ClassLeatherString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Leather"][Language]);
	_G[Frame.."ClassPlateString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Plate"][Language]);
	_G[Frame.."CheckAllButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["CheckAll"][Language]);
	_G[Frame.."UncheckAllButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["UncheckAll"][Language]);

--[[]] Frame = "WebDKP_AwardDKP_Frame";
	_G[Frame.."Header"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["AwardDKP"][Language]..":");
	_G[Frame.."Info1"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["DKPInfo1"][Language]);
	_G[Frame.."Info2"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["DKPInfo2"][Language]);
	_G[Frame.."Info3"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["DKPInfo3"][Language]);
	_G[Frame.."ReasonString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Reason"][Language]..":");
	_G[Frame.."PointsString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Points"][Language]);
	_G[Frame.."DecayString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Decay"][Language]);
	_G[Frame.."AwardPointsButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["AwardDKP"][Language]);
	_G[Frame.."AwardDecayButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["AwardDecay"][Language]);
	_G[Frame.."ToggleCasinoString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["CasinoCheck"][Language]);
	_G[Frame.."ToggleAllInOneString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["AllInOne"][Language]);
	_G[Frame.."AmountLimitString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["RollLimit"][Language]);
	_G[Frame.."RollWinString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["RollWin"][Language]);
	_G[Frame.."MultiplyForString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["RollMultiply"][Language]);
	_G[Frame.."Unmodifiable"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Unmodifiable"][Language]);
	_G[Frame.."TimedAwardsButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["TimedAwards"][Language]);
	_G[Frame.."SettingsButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Settings"][Language]);

--[[]] Frame = "WebDKP_AwardItem_Frame";
	_G[Frame.."Header"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["AwardItem"][Language]);
	_G[Frame.."Info1"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemInfo1"][Language]);
	_G[Frame.."ItemNameString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemName"][Language]);
	_G[Frame.."ItemCostString1"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemCost1"][Language]);
	_G[Frame.."ItemCostString2"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemCost2"][Language]);
	_G[Frame.."AwardItem"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemButton"][Language]);
	_G[Frame.."BiddingButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Bidding"][Language]);
	_G[Frame.."MainHandButtonString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemWeapons"][Language]);
	_G[Frame.."HelmButtonString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemSets"][Language]);
	_G[Frame.."ToggleItemLevelEquationString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemLevel"][Language]);
	_G[Frame.."ItemLevelMultString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemValue"][Language]);
	_G[Frame.."ToggleSlotLocMultTitle"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemTitle"][Language]);
	_G[Frame.."ToggleSlotLocMultString2"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemSale"][Language]);
	_G[Frame.."ToggleSlotLocMultString1"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemType"][Language]);

--[[]] Frame = "WebDKP_ItemSlotFrame";
	_G[Frame.."Yes"]:SetText(WebDKP_Language_xml["Others"]["Yes"][Language]);
	_G[Frame.."No"]:SetText(WebDKP_Language_xml["Others"]["No"][Language]);
	_G[Frame.."CostString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["DefaultPrice"][Language]);
	if ( WebDKP_Options_SnGa["ItemLevelEquation"] == 1 ) then
		_G[Frame.."CostString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemValue"][Language]);
		WebDKP_AwardItem_FrameToggleSlotLocMultString1:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemMult"][Language]);
	end

--[[]] Frame = "WebDKP_Standby_Frame";
	local flag = "Start";
	_G[Frame.."Header"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["RaidStatus"][Language]);
	_G[Frame.."AddStandbyString1"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["StandBox"][Language]);
	_G[Frame.."AddStandbyString2"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["StandInfo1"][Language]);
	_G[Frame.."AddStandbyString3"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["StandInfo2"][Language]);
	_G[Frame.."AddToStandbyButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["AddToStand"][Language]);
	_G[Frame.."DelToStandbyButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["DelToStand"][Language]);
	_G[Frame.."ResetToStandbyButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ResetToStand"][Language]);
	_G[Frame.."AddToStandbyButtonString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["PlayerInfo"][Language]);
	_G[Frame.."ResetToStandbyButtonString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ResetInfo"][Language]);
	_G[Frame.."RaidDescription"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["RaidDescrip"][Language]);
	_G[Frame.."Date"]:SetText(WebDKP_Language_xml["Others"]["Date"][Language]..":");
	_G[Frame.."StartTime"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["StartTime"][Language]..":");
	_G[Frame.."FinishTime"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["FinishTime"][Language]..":");
	_G[Frame.."TotalTime"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["TotalTime"][Language]);
	_G[Frame.."TotalPlayers"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["TotalPlayers"][Language]);
	_G[Frame.."TableDKP"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["TableDKP"][Language]);
	_G[Frame.."CharRaidLog"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Attendance"][Language]);
	_G[Frame.."RaidLog"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["RaidLog"][Language]);
	_G[Frame.."RaidButton"]:SetText(WebDKP_Language_lua["RaidAttendance"]["RaidEnd"][Language]);
	if WebDKP_Options_SnGa["GlobalRaid"] == "" and WebDKP_Options_SnGa["GlobalStartTime"] == "" then
		_G[Frame.."RaidButton"]:SetText(WebDKP_Language_lua["RaidAttendance"]["RaidStart"][Language]);
		flag = "Init";
	else
		WebDKP_Print(WebDKP_Language_lua["WebDKP"]["RaidInProcess"][Language]);
	end

	Frame = "Help_Frame";
	WebDKP_Help_DropDownString:SetText(WebDKP_Language_xml["Help_Frame"]["Categories"][Language]);

--[[]] Frame = "WebDKP_LogFrame";
	_G[Frame.."Header"]:SetText(WebDKP_Language_xml["Records_Frame"]["AssignTo"][Language]..":");
	_G[Frame.."HeaderDirChar"]:SetText(WebDKP_Language_xml["Records_Frame"]["SelectAward"][Language]);
	_G[Frame.."AwardedtoString"]:SetText(WebDKP_Language_xml["Records_Frame"]["AssignTo"][Language]);
	_G[Frame.."AmountString"]:SetText(WebDKP_Language_xml["Others"]["Amount"][Language]);
	_G[Frame.."ReasonString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["Reason"][Language]);
	_G[Frame.."DateString"]:SetText(WebDKP_Language_xml["CharRaidFrame"]["DateTime"][Language]);
	_G[Frame.."SaveLog"]:SetText(WebDKP_Language_xml["Records_Frame"]["SaveLog"][Language]);
	_G[Frame.."DelLog"]:SetText(WebDKP_Language_xml["Records_Frame"]["UndoAward"][Language]);
	_G[Frame.."CharChangeString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["PlayerInfo"][Language]);
	_G[Frame.."AddChar"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["AddToStand"][Language]);
	_G[Frame.."DelChar"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["DelToStand"][Language]);

--[[]] Frame = "WebDKP_GeneralOptions_Frame"; 
	_G[Frame.."Title"]:SetText(WebDKP_Language_xml["Options_Frame"]["TitleGral"][Language]);
	_G[Frame.."Info1"]:SetText(WebDKP_Language_xml["Options_Frame"]["Info1Gral"][Language]);
	_G[Frame.."Info2"]:SetText(WebDKP_Language_xml["Options_Frame"]["Info2Gral"][Language]);
	_G[Frame.."Info3"]:SetText(WebDKP_Language_xml["Options_Frame"]["Info3Gral"][Language]);
	_G[Frame.."Info4"]:SetText(WebDKP_Language_xml["Options_Frame"]["Info4Gral"][Language].." WebDKP");
	_G[Frame.."Info5"]:SetText(WebDKP_Language_xml["Options_Frame"]["Info5Gral"][Language]);
	_G[Frame.."Info6"]:SetText(WebDKP_Language_xml["Options_Frame"]["Info6Gral"][Language]);
	_G[Frame.."Info7"]:SetText(WebDKP_Language_xml["Options_Frame"]["Info7Gral"][Language]);
	_G[Frame.."Info8"]:SetText(WebDKP_Language_xml["Options_Frame"]["Info8Gral"][Language]);
	_G[Frame.."Info9"]:SetText(WebDKP_Language_xml["Options_Frame"]["Info9Gral"][Language]);
	_G[Frame.."Info10"]:SetText(WebDKP_Language_xml["Options_Frame"]["Info10Gral"][Language]);
	_G[Frame.."ToggleAutofillEnabledString"]:SetText(WebDKP_Language_xml["Options_Frame"]["EnabledFill"][Language]);
	_G[Frame.."AutofillDropDownString"]:SetText(WebDKP_Language_xml["Options_Frame"]["LimitedFill"][Language]);
	_G[Frame.."LanguageDropDownDescrip"]:SetText(WebDKP_Language_xml["Options_Frame"]["LDescrip"][Language]);
	_G[Frame.."LanguageDropDownString"]:SetText(WebDKP_Language_xml["Options_Frame"]["LString"][Language]);
	_G[Frame.."ToggleFatalityString"]:SetText(WebDKP_Language_xml["Options_Frame"]["Fatality1"][Language]);
	_G[Frame.."ToggleFatalityBandString"]:SetText(WebDKP_Language_xml["Options_Frame"]["Fatality2"][Language]);
	_G[Frame.."ToggleAutoCleanLogDataString"]:SetText(WebDKP_Language_xml["Options_Frame"]["AutoClean1"][Language]);
	_G[Frame.."ToggleAutoCleanDaysLimitString1"]:SetText(WebDKP_Language_xml["Options_Frame"]["AutoClean2"][Language]);
	_G[Frame.."ToggleAutoCleanDaysLimitString2"]:SetText(WebDKP_Language_xml["Options_Frame"]["AutoClean3"][Language]);
	_G[Frame.."ToggleSindraString"]:SetText(WebDKP_Language_xml["Options_Frame"]["Sindra1"][Language]);
	_G[Frame.."ToggleSindraBandString"]:SetText(WebDKP_Language_xml["Options_Frame"]["Sindra2"][Language]);
	_G[Frame.."ToggleAwardBossDKPString"]:SetText(WebDKP_Language_xml["Options_Frame"]["Info4Gral"][Language]);
	_G[Frame.."ToggleAltClickString"]:SetText(WebDKP_Language_xml["Options_Frame"]["AltClick"][Language]);
	_G[Frame.."ToggleIgnWhispersString"]:SetText(WebDKP_Language_xml["Options_Frame"]["Ignore"][Language]);
	_G[Frame.."ToggledkpCapString"]:SetText(WebDKP_Language_xml["Options_Frame"]["DKPCap"][Language]);
	_G[Frame.."dkpCapLimitString"]:SetText(WebDKP_Language_xml["Options_Frame"]["CapLimit"][Language]);
	_G[Frame.."BossDKPString"]:SetText(WebDKP_Language_xml["Options_Frame"]["AmoutDKP"][Language]);
	_G[Frame.."ToggleAwardBossDKP10String"]:SetText(WebDKP_Language_xml["Options_Frame"]["EnableFor"][Language].." R10");
	_G[Frame.."ToggleAwardBossDKP25String"]:SetText(WebDKP_Language_xml["Options_Frame"]["EnableFor"][Language].." R25");
	_G[Frame.."ToggleEnabledString"]:SetText(WebDKP_Language_xml["Options_Frame"]["EnableWebDKP"][Language]);

--[[]] Frame = "WebDKP_BiddingOptions_Frame";
	_G[Frame.."Title"]:SetText(WebDKP_Language_xml["Options_Frame"]["OptionsTitle"][Language]);
	_G[Frame.."ToggleBidAnnounceRaidDescrip"]:SetText(WebDKP_Language_xml["Options_Frame"]["AnnounceBidD"][Language]);
	_G[Frame.."ToggleBidAnnounceRaidNote"]:SetText(WebDKP_Language_xml["Options_Frame"]["AnnounceBidN"][Language]);
	_G[Frame.."ToggleBidConfirmPopupDescrip"]:SetText(WebDKP_Language_xml["Options_Frame"]["ConfirmPopupD"][Language]);
	_G[Frame.."ToggleBidConfirmPopupNote"]:SetText(WebDKP_Language_xml["Options_Frame"]["ConfirmPopupN"][Language]);
	_G[Frame.."ToggleBidAllowNegativeBidsDescrip"]:SetText(WebDKP_Language_xml["Options_Frame"]["NegativeBidsD"][Language]);
	_G[Frame.."ToggleBidAllowNegativeBidsNote"]:SetText(WebDKP_Language_xml["Options_Frame"]["NegativeBidsN"][Language]);
	_G[Frame.."ToggleBidExceededAlertDescrip"]:SetText(WebDKP_Language_xml["Options_Frame"]["NotifyBidD"][Language]);
	_G[Frame.."ToggleBidExceededAlertNote"]:SetText(WebDKP_Language_xml["Options_Frame"]["NotifyBidN"][Language]);
	_G[Frame.."ToggleBidsPerBandDescrip"]:SetText(WebDKP_Language_xml["Options_Frame"]["BidsPerBandD"][Language]);
	_G[Frame.."ToggleBidsPerBandNote"]:SetText(WebDKP_Language_xml["Options_Frame"]["BidsPerBandN"][Language]);
	_G[Frame.."ToggleAutoGiveDescrip"]:SetText(WebDKP_Language_xml["Options_Frame"]["AutoGiveD"][Language]);
	_G[Frame.."ToggleAutoGiveNote"]:SetText(WebDKP_Language_xml["Options_Frame"]["AutoGiveN"][Language]);
	_G[Frame.."ToggleAnonymousBidsDescrip"]:SetText(WebDKP_Language_xml["Options_Frame"]["AnonymusBidsD"][Language]);
	_G[Frame.."ToggleAnonymousBidsNote"]:SetText(WebDKP_Language_xml["Options_Frame"]["AnonymusBidsN"][Language]);
	_G[Frame.."ToggleSilentBiddingDescrip"]:SetText(WebDKP_Language_xml["Options_Frame"]["SilentEventsD"][Language]);
	_G[Frame.."ToggleSilentBiddingNote"]:SetText(WebDKP_Language_xml["Options_Frame"]["SilentEventsN"][Language]);
	_G[Frame.."ToggleBidandRollDescrip"]:SetText(WebDKP_Language_xml["Options_Frame"]["BidsAndRollD"][Language]);
	_G[Frame.."ToggleBidandRollNote"]:SetText(WebDKP_Language_xml["Options_Frame"]["BidsAndRollN"][Language]);
	_G[Frame.."ToggleBidPercentageDescrip"]:SetText(WebDKP_Language_xml["Options_Frame"]["PercentageD"][Language]);
	_G[Frame.."ToggleBidPercentageNote"]:SetText(WebDKP_Language_xml["Options_Frame"]["PercentageN"][Language]);
	_G[Frame.."PercentageValueString"]:SetText(WebDKP_Language_xml["Options_Frame"]["ValuePercent"][Language]);
	_G[Frame.."ToggleFixedDiscountFSDescrip"]:SetText(WebDKP_Language_xml["Options_Frame"]["CostFixedFSD"][Language]);
	_G[Frame.."ToggleFixedDiscountFSNote"]:SetText(WebDKP_Language_xml["Options_Frame"]["CostFixedFSN"][Language]);
	_G[Frame.."DiscountValueString"]:SetText(WebDKP_Language_xml["Options_Frame"]["ValueCost"][Language]);
	_G[Frame.."ToggleAutomaticBidDescrip"]:SetText(WebDKP_Language_xml["Options_Frame"]["AutomaticBidD"][Language]);
	_G[Frame.."ToggleAutomaticBidNote"]:SetText(WebDKP_Language_xml["Options_Frame"]["AutomaticBidN"][Language]);
	_G[Frame.."AutoBidValueString"]:SetText(WebDKP_Language_xml["Options_Frame"]["ValueAutoBid"][Language]);

--[[]] Frame = "WebDKP_PlayersFail_Frame";
	_G[Frame.."Title"]:SetText(WebDKP_Language_xml["Options_Frame"]["PlayersFail"][Language]);
	_G[Frame.."String"]:SetText(WebDKP_Language_xml["Options_Frame"]["ComingSoon"][Language]);

--[[]] Frame = "WebDKP_AnnouncementsOptions_Frame";
	_G[Frame.."Info11"]:SetText(WebDKP_Language_xml["Options_Frame"]["Announce1"][Language]);
	_G[Frame.."Info12"]:SetText(WebDKP_Language_xml["Options_Frame"]["Announce2"][Language]);
	_G[Frame.."Info13"]:SetText(WebDKP_Language_xml["Options_Frame"]["Announce3"][Language]);
	_G[Frame.."Info14"]:SetText(WebDKP_Language_xml["Options_Frame"]["Announce4"][Language]);
	_G[Frame.."Info15"]:SetText(WebDKP_Language_xml["Options_Frame"]["Announce5"][Language]);
	_G[Frame.."Info16"]:SetText(WebDKP_Language_xml["Options_Frame"]["Announce6"][Language]);
	_G[Frame.."Info17"]:SetText(WebDKP_Language_xml["Options_Frame"]["Announce7"][Language]);
	_G[Frame.."Info18"]:SetText(WebDKP_Language_xml["Options_Frame"]["Announce8"][Language]);
	_G[Frame.."ToggleAnnouncementsString"]:SetText(WebDKP_Language_xml["Options_Frame"]["Customing"][Language]);

--[[]] Frame = "WebDKP_RaidInfoFrame";
	_G[Frame.."Attended"]:SetText(WebDKP_Language_xml["RaidInfoFrame"]["Attended"][Language]);
	_G[Frame.."DirTime"]:SetText(WebDKP_Language_xml["RaidInfoFrame"]["DirTime"][Language]);
	_G[Frame.."DirChar"]:SetText(WebDKP_Language_xml["RaidInfoFrame"]["DirChar"][Language]);
	_G[Frame.."DateString"]:SetText(WebDKP_Language_xml["Others"]["Date"][Language]);
	_G[Frame.."StartTimeString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["StartTime"][Language]);
	_G[Frame.."EndTimeButtonString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["FinishTime"][Language]);
	_G[Frame.."TotalTimeString"]:SetText(WebDKP_Language_xml["RaidInfoFrame"]["TotalTime"][Language]);
	_G[Frame.."EndTimeString"]:SetText(WebDKP_Language_xml["RaidInfoFrame"]["EndTimeAdjust"][Language]);
	_G[Frame.."AdjustTime"]:SetText(WebDKP_Language_xml["RaidInfoFrame"]["AdjustTime"][Language]);
	_G[Frame.."DeleteRaid"]:SetText(WebDKP_Language_xml["RaidInfoFrame"]["DeleteRaid"][Language]);
	_G[Frame.."CharChangeString"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["PlayerInfo"][Language]);
	_G[Frame.."AddChar"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["AddToStand"][Language]);
	_G[Frame.."DelChar"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["DelToStand"][Language]);

--[[]] Frame = "WebDKP_TimedAwardFrame";
	_G[Frame.."Text"]:SetText(WebDKP_Language_xml["TimedAward_Frame"]["HeaderText"][Language]);
	_G[Frame.."DkpString"]:SetText(WebDKP_Language_xml["TimedAward_Frame"]["Points"][Language]);
	_G[Frame.."TimeString1"]:SetText(WebDKP_Language_xml["TimedAward_Frame"]["TimeString1"][Language]);
	_G[Frame.."TimeString2"]:SetText(WebDKP_Language_xml["TimedAward_Frame"]["TimeString2"][Language]);
	_G[Frame.."LoopTimerString"]:SetText(WebDKP_Language_xml["TimedAward_Frame"]["RepeatAward"][Language]);
	_G[Frame.."ResetButton"]:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ResetToStand"][Language]);
	_G[Frame.."StartStopButton"]:SetText(WebDKP_Language_lua["Others"]["Start"][Language]);
	if ( WebDKP_Options_SnGa["TimedAwardInProgress"] == true ) then
		_G[Frame.."StartStopButton"]:SetText(WebDKP_Language_lua["Others"]["Stop"][Language]);
	end

--[[]] Frame = "WebDKP_FatalityFrame";
	_G[Frame.."FileDir"]:SetText(WebDKP_Language_xml["Records_Frame"]["FileDir"][Language]);
	_G[Frame.."AwardedtoString"]:SetText(WebDKP_Language_xml["Others"]["Name"][Language]);
	_G[Frame.."AmountString"]:SetText(WebDKP_Language_xml["Records_Frame"]["MurderedBy"][Language]);
	_G[Frame.."ReasonString"]:SetText(WebDKP_Language_xml["Records_Frame"]["ReasonFLog"][Language]);
	_G[Frame.."DateString"]:SetText(WebDKP_Language_xml["Others"]["Time"][Language]);
	_G[Frame.."DelChar"]:SetText(WebDKP_Language_xml["Records_Frame"]["DelLog"][Language]);
	_G[Frame.."UpdateChar"]:SetText(WebDKP_Language_xml["Records_Frame"]["UpdateLog"][Language]);
	_G[Frame.."SaveChar"]:SetText(WebDKP_Language_xml["Records_Frame"]["SaveLog"][Language]);

--[[]] Frame = "WebDKP_Fatality_ToDiscount";
	_G[Frame.."CostString"]:SetText(WebDKP_Language_xml["Records_Frame"]["Penalty"][Language]);
	_G[Frame.."MultString"]:SetText(WebDKP_Language_xml["Bid_Frame"]["ConfirmMult"][Language]);
	_G[Frame.."Yes"]:SetText(WebDKP_Language_xml["Others"]["Yes"][Language]);
	_G[Frame.."No"]:SetText(WebDKP_Language_xml["Others"]["No"][Language]);

--[[]] Frame = "WebDKP_Fatality_Deleteall";
	_G[Frame.."Title"]:SetText(WebDKP_Language_xml["Records_Frame"]["Question"][Language]);
	_G[Frame.."Yes"]:SetText(WebDKP_Language_xml["Others"]["Yes"][Language]);
	_G[Frame.."No"]:SetText(WebDKP_Language_xml["Others"]["No"][Language]);

--[[]] Frame = "WebDKP_SindraFrame";
	_G[Frame.."FileDir"]:SetText(WebDKP_Language_xml["Records_Frame"]["FileDir"][Language]);
	_G[Frame.."AwardedtoString"]:SetText(WebDKP_Language_xml["Others"]["Name"][Language]);
	_G[Frame.."AmountString"]:SetText(WebDKP_Language_xml["Others"]["Dramage"][Language]);
	_G[Frame.."ReasonString"]:SetText(WebDKP_Language_xml["Others"]["Details"][Language]);
	_G[Frame.."DateString"]:SetText(WebDKP_Language_xml["Others"]["Time"][Language]);
	_G[Frame.."DelChar"]:SetText(WebDKP_Language_xml["Records_Frame"]["DelLog"][Language]);
	_G[Frame.."UpdateChar"]:SetText(WebDKP_Language_xml["Records_Frame"]["UpdateLog"][Language]);
	_G[Frame.."SaveChar"]:SetText(WebDKP_Language_xml["Records_Frame"]["SaveLog"][Language]);

--[[]] Frame = "WebDKP_Sindra_ToDiscount";
	_G[Frame.."CostString"]:SetText(WebDKP_Language_xml["Records_Frame"]["Penalty"][Language]);
	_G[Frame.."MultString"]:SetText(WebDKP_Language_xml["Bid_Frame"]["ConfirmMult"][Language]);
	_G[Frame.."Yes"]:SetText(WebDKP_Language_xml["Others"]["Yes"][Language]);
	_G[Frame.."No"]:SetText(WebDKP_Language_xml["Others"]["No"][Language]);

--[[]] Frame = "WebDKP_Sindra_Deleteall";
	_G[Frame.."Title"]:SetText(WebDKP_Language_xml["Records_Frame"]["Question"][Language]);
	_G[Frame.."Yes"]:SetText(WebDKP_Language_xml["Others"]["Yes"][Language]);
	_G[Frame.."No"]:SetText(WebDKP_Language_xml["Others"]["No"][Language]);

	Frame = nil;

--- [ Calling Functions ] ---
	WebDKP_Refresh();
	WebDKP_Load_Help();
	Update_Headers_FS();
	WebDKP_RaidStatus(flag);
	WebDKP_AuctionToSale();
	WebDKP_Bid_UpdateTable();
end

-- :)