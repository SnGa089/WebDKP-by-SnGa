------------------------------------------------------------------------
-- Options
------------------------------------------------------------------------
-- This file contains event handlers for the Options window. These will
-- update the options datastructure specified in WebDKP.lua
------------------------------------------------------------------------

-- ================================
-- Toggles displaying the bidding panel
-- ================================
function WebDKP_Options_ToggleUI()
	if ( WebDKP_OptionsFrame:IsShown() ) then
		WebDKP_OptionsFrame:Hide();
	else
		WebDKP_Options_Autofill_DropDown_OnLoad();
		WebDKP_Options_Autofill_DropDown_Init();

		WebDKP_Options_Language_OnLoad();
		WebDKP_Options_Language_Init();
		WebDKP_OptionsFrame:Show();
	end
end

-- ================================
-- Shows the Bid UI
-- ================================
function WebDKP_Options_ShowUI()
	WebDKP_Options_Autofill_DropDown_OnLoad();
	WebDKP_Options_Autofill_DropDown_Init();
	
	WebDKP_Options_Language_OnLoad();
	WebDKP_Options_Language_Init();
	WebDKP_OptionsFrame:Show();
end

-- ================================
-- Hides the Bid UI
-- ================================
function WebDKP_Options_HideUI()
	WebDKP_OptionsFrame:Hide();
end

-- ================================
-- Initializes the options, setting default values as needed
-- ================================
function WebDKP_Options_Init() -- Modified by SnGa
	-------------------------[  Auto Clean Logs  ]--------------------------
	WebDKP_Sindra_SnGa   = AutoCleanLogData_FS(WebDKP_Sindra_SnGa);
	WebDKP_Fatality_SnGa = AutoCleanLogData_FS(WebDKP_Fatality_SnGa);
	------------------------------------------------------------------------
	--initalize the default options for the checkboxes on the options gui
	WebDKP_Options_InitOption("GeneralOptions", "Language", "SPANISH");												-- Added by SnGa
	WebDKP_Options_InitOption("GeneralOptions", "Enabled", 1);														-- Added by Cather (Bronzebeard)
	WebDKP_Options_InitOption("GeneralOptions", "AutoAwardEnabled", 1);		
	WebDKP_Options_InitOption("GeneralOptions", "AutofillEnabled", 0);												-- Added by SnGa						
	WebDKP_Options_InitOption("GeneralOptions", "Sindra", 1);														-- Added by SnGa
	WebDKP_Options_InitOption("GeneralOptions", "SindraBand", 1);													-- Added by SnGa
	WebDKP_Options_InitOption("GeneralOptions", "Fatality", 1);														-- Added by SnGa
	WebDKP_Options_InitOption("GeneralOptions", "FatalityBand", 1);													-- Added by SnGa
	WebDKP_Options_InitOption("GeneralOptions", "AwardBossDKP", 0);													-- Added by Zevious (Bronzebeard)
	WebDKP_Options_InitOption("GeneralOptions", "AwardBossDKP10", 0);												-- Added by Zevious (Bronzebeard)
	WebDKP_Options_InitOption("GeneralOptions", "AwardBossDKP25", 0);												-- Added by Zevious (Bronzebeard)
	WebDKP_Options_InitOption("GeneralOptions", "AutoCleanLogData", 1);												-- Added by SnGa
	WebDKP_Options_InitOption("GeneralOptions", "AltClick", 1);														-- Added by Zevious (Bronzebeard)
	WebDKP_Options_InitOption("GeneralOptions", "IgnWhispers", 0);													-- Added by Zevious (Bronzebeard)
	WebDKP_Options_InitOption("GeneralOptions", "dkpCap", 0);														-- Added by Zevious (Bronzebeard)
	WebDKP_Options_InitOption("BiddingOptions", "BidAnnounceRaid", 1);  											-- Added by SnGa
	WebDKP_Options_InitOption("BiddingOptions", "BidConfirmPopup", 1);												-- Added by SnGa
	WebDKP_Options_InitOption("BiddingOptions", "BidAllowNegativeBids", 0);											-- Added by SnGa
	WebDKP_Options_InitOption("BiddingOptions", "BidExceededAlert", 1);												-- Added by SnGa
	WebDKP_Options_InitOption("BiddingOptions", "BidsPerBand", 0);													-- Added by SnGa
	WebDKP_Options_InitOption("BiddingOptions", "AutoGive", 0);														-- Added by Zevious
	WebDKP_Options_InitOption("BiddingOptions", "AnonymousBids", 0);												-- Added by SnGa
	WebDKP_Options_InitOption("BiddingOptions", "SilentBidding", 0);												-- Added by Zevious 
	WebDKP_Options_InitOption("BiddingOptions", "BidandRoll", 0);													-- Added by Zevious
	WebDKP_Options_InitOption("BiddingOptions", "BidPercentage", 1);												-- Added by SnGa
	WebDKP_Options_InitOption("BiddingOptions", "FixedDiscountFS", 1);												-- Added by SnGa		
	WebDKP_Options_InitOption("BiddingOptions", "AutomaticBid", 1);													-- Added by SnGa
	WebDKP_Options_InitOption("AwardDKP", "Casino", 0);																-- Added by SnGa
	WebDKP_Options_InitOption("AwardDKP", "AllInOne", 1);															-- Added by SnGa
	WebDKP_Options_InitOption("AwardItem", "ItemLevelEquation", 0);													-- Added by Zevious
	WebDKP_Options_InitOption("AwardItem", "SlotLocMult", 0);														-- Added by Zevious
	WebDKP_Options_InitOption("AnnouncementsOptions", "Announcements", 1);											-- Added by Zevious
	WebDKP_Options_InitOption("AnnouncementsOptions", "BossDialogue", 0);											-- Added by SnGa

	WebDKP_FiltersFrameLimitGuild:SetChecked(WebDKP_GetOptionValue("LimitGuild",0));
	WebDKP_FiltersFrameLimitGuildOnline:SetChecked(WebDKP_GetOptionValue("LimitGuildOnline",0));
	WebDKP_FiltersFrameLimitAlts:SetChecked(WebDKP_GetOptionValue("LimitAlts",0));
	WebDKP_FiltersFrameLimitAlts2:SetChecked(WebDKP_GetOptionValue("LimitAlts2",0));
	WebDKP_FiltersFrameStandby1:SetChecked(WebDKP_GetOptionValue("Standby1",0));
	WebDKP_FiltersFrameStandby2:SetChecked(WebDKP_GetOptionValue("Standby2",0));

	WebDKP_AwardDKP_FrameAmountLimit:SetText(WebDKP_GetOptionValue("CasinoLimit","500"));							-- Added by SnGa
	WebDKP_AwardDKP_FrameRollWin:SetText(WebDKP_GetOptionValue("CasinoWinWith","79"));								-- Added by SnGa
	WebDKP_AwardDKP_FrameMultiplyFor:SetText(WebDKP_GetOptionValue("CasinoMultiplyFor","1"));						-- Added by SnGa

	WebDKP_AwardItem_FrameItemLevelMult:SetText(WebDKP_GetOptionValue("ItemLevelMult",".01"));						-- Added by Zevious

	WebDKP_GeneralOptions_FrameBossDKP:SetText(WebDKP_GetOptionValue("BossDKPValue",0));
	WebDKP_GeneralOptions_FramedkpCapLimit:SetText(WebDKP_GetOptionValue("dkpCapLimit",0));
	WebDKP_GeneralOptions_FrameToggleAutoCleanDaysLimit:SetText(WebDKP_GetOptionValue("AutoCleanDaysLimit", 5));

	WebDKP_BiddingOptions_FrameDiscountValue:SetText(WebDKP_GetOptionValue("DiscountValue","250"));					-- Added by SnGa
	WebDKP_BiddingOptions_FramePercentageValue:SetText(WebDKP_GetOptionValue("PercentageValue","5"));				-- Added by SnGa
	WebDKP_BiddingOptions_FrameAutoBidValue:SetText(WebDKP_GetOptionValue("AutoBidValue","2500"));					-- Added by SnGa

	WebDKP_AnnouncementsOptions_FrameEditStartAnnounce:SetText(WebDKP_GetOptionValue("EditStartAnnounce",""));		-- Added by Zevious
	WebDKP_AnnouncementsOptions_FrameEditDuringAnnounce:SetText(WebDKP_GetOptionValue("EditDuringAnnounce",""));	-- Added by Zevious
	WebDKP_AnnouncementsOptions_FrameEditEndAnnounce:SetText(WebDKP_GetOptionValue("EditEndAnnounce",""));			-- Added by Zevious
	WebDKP_AnnouncementsOptions_FrameEditSRollAnnounce:SetText(WebDKP_GetOptionValue("EditSRollAnnounce",""));		-- Added by Zevious
	WebDKP_AnnouncementsOptions_FrameEditRollAnnounce:SetText(WebDKP_GetOptionValue("EditRollAnnounce",""));		-- Added by Zevious
	WebDKP_AnnouncementsOptions_FrameEditERollAnnounce:SetText(WebDKP_GetOptionValue("EditERollAnnounce",""));		-- Added by Zevious

	WebDKP_SynchFramePassword:SetText(WebDKP_GetOptionValue("SynchPassword",""));									-- Added by Zevious
	WebDKP_SynchFrameEnableSynch:SetChecked(WebDKP_GetOptionValue("EnableSynch",1));								-- Added by Zevious
	WebDKP_SynchFrameSynchFrom:SetText(WebDKP_GetOptionValue("SynchFrom",""));										-- Added by Zevious

	WebDKP_BidFrameStartingBid:SetText(WebDKP_GetOptionValue("StartBid",0));										-- Added by Zevious
	WebDKP_BidFrameTime:SetText(WebDKP_GetOptionValue("Time",0));													-- Added by Zevious
	WebDKP_BidFrameToggleFixedPrice:SetChecked(WebDKP_GetOptionValue("FixedPrice",1));								-- Added by SnGa

	WebDKP_CharRaidInfoFrameInGroup:SetChecked(WebDKP_GetOptionValue("InGroup",1));									-- Added by Zevious

	WebDKP_TimedAwardFrameLoopTimer:SetChecked(WebDKP_GetOptionValue("TimedAwardRepeat",1));
	WebDKP_TimedAwardFrameDkp:SetText(WebDKP_GetOptionValue("TimedAwardDkp",0));
	WebDKP_TimedAwardFrameTime:SetText(WebDKP_GetOptionValue("TimedAwardTotalTime",5));

	WebDKP_GetOptionValue("TimedAwardTimer",0);
	local bidInProgress = WebDKP_GetOptionValue("TimedAwardInProgress",false);
	if( bidInProgress == true ) then
		WebDKP_TimedAward_UpdateFrame:Show();	-- if a timer is in progres make sure the update frame appears so the timer can still count down
		WebDKP_TimedAwardFrameStartStopButton:SetText(WebDKP_Language_lua["Others"]["Stop"][GLanguage]);
	end
	WebDKP_GetOptionValue("TimedAwardMiniTimer",0);
	if ( WebDKP_Options_SnGa["TimedAwardMiniTimer"] == 1 ) then
		WebDKP_TimedAward_MiniFrame:Show();
	end

	WebDKP_InitVisibilityElements();
end

-- ================================
-- Initializes a single option on the GUI by setting its checkbox to on/off based
-- on what is set in the options datastructure.
-- Parameters are:
-- frame - the frame that the checkbox is on. "GeneralOptions" "BiddingOptions" "AutoAwardOptions"
-- optionName - the name of the option in the WebDKP_Options_SnGa / WebDKP_WebOptions data structure
-- defaultValue - if no option is present, what option it should default to
-- ================================
function WebDKP_Options_InitOption(frame, optionName, defaultValue)
	-- load the state from either the options  or weboptions data structure
	local state = WebDKP_GetOptionValue(optionName, defaultValue);
	
	-- find what checkbox to initailize
    -- DLL Faster access to get globals with _G as a table instead of the function call.

	local checkbox = _G["WebDKP_"..frame.."_FrameToggle"..optionName];
	
	-- if the checkbox exists, initalize it
	if(checkbox ~= nil ) then
		checkbox:SetChecked(state);
	end
end

-- ================================
-- Gui handler for switching tabs and showing new content
-- ================================
function WebDKP_Options_Tab_OnClick(self)
local this = self;
	if ( this:GetID() == 1 ) then
		_G["WebDKP_GeneralOptions_Frame"]:Show();
		_G["WebDKP_BiddingOptions_Frame"]:Hide();
		_G["WebDKP_AnnouncementsOptions_Frame"]:Hide();
		_G["WebDKP_PlayersFail_Frame"]:Hide();
	elseif ( this:GetID() == 2 ) then
		_G["WebDKP_GeneralOptions_Frame"]:Hide();
		_G["WebDKP_BiddingOptions_Frame"]:Show();
		_G["WebDKP_AnnouncementsOptions_Frame"]:Hide();
		_G["WebDKP_PlayersFail_Frame"]:Hide();
	elseif (this:GetID() == 3 ) then
		_G["WebDKP_GeneralOptions_Frame"]:Hide();
		_G["WebDKP_BiddingOptions_Frame"]:Hide();
		_G["WebDKP_AnnouncementsOptions_Frame"]:Show();
		_G["WebDKP_PlayersFail_Frame"]:Hide();
	elseif (this:GetID() == 4 ) then
		_G["WebDKP_GeneralOptions_Frame"]:Hide();
		_G["WebDKP_BiddingOptions_Frame"]:Hide();
		_G["WebDKP_AnnouncementsOptions_Frame"]:Hide();
		_G["WebDKP_PlayersFail_Frame"]:Show();
	elseif (this:GetID() == 5 ) then
		_G["WebDKP_GeneralOptions_Frame"]:Hide();
		_G["WebDKP_BiddingOptions_Frame"]:Hide();
		_G["WebDKP_AnnouncementsOptions_Frame"]:Hide();
		_G["WebDKP_PlayersFail_Frame"]:Hide();
	end 
	PlaySound_Fixed("igCharacterInfoTab");
end

-- ================================
-- Invoked when the gui loads up the drop down list of the autofill threshold
-- ================================
function WebDKP_Options_Autofill_DropDown_OnLoad()
	UIDropDownMenu_Initialize(WebDKP_GeneralOptions_FrameAutofillDropDown, WebDKP_Options_Autofill_DropDown_Init);
end

-- ================================
-- Invoked when the drop down list for the autofill option  is loaded
-- ================================
function WebDKP_Options_Autofill_DropDown_Init()
	local info;
	local selected = "";
	WebDKP_AddAutofillChoice("Gray Items",-1);
	WebDKP_AddAutofillChoice("White Items",0);
	WebDKP_AddAutofillChoice("Green Items",1);
	WebDKP_AddAutofillChoice("Blue Items",2);
	WebDKP_AddAutofillChoice("Purple Items",3);
	WebDKP_AddAutofillChoice("Orange Items",4);
	
	UIDropDownMenu_SetWidth(WebDKP_GeneralOptions_FrameAutofillDropDown, 130);
end

-- ================================
-- Helper method that adds a choice to the Autofill dropdown
-- ================================
function WebDKP_AddAutofillChoice(text, value)
	info = { };
	info.text = text;
	info.value = value; 
	info.func = WebDKP_Options_Autofill_DropDown_OnClick;
	if ( value == WebDKP_Options_SnGa["AutofillThreshold"] ) then
		info.checked = ( 1 == 1 );
		UIDropDownMenu_SetSelectedName(WebDKP_GeneralOptions_FrameAutofillDropDown, info.text );
	end
	UIDropDownMenu_AddButton(info);
end

-- ================================
-- Called when the user switches between different autofill threshholds
-- ================================
function WebDKP_Options_Autofill_DropDown_OnClick(self)
local this = self;
	WebDKP_Options_SnGa["AutofillThreshold"] = this.value; 
	WebDKP_Options_Autofill_DropDown_Init();
end

-- ================================
-- Toggles the passed option between on and off.
-- The majority of all options use this method for toggling.
-- ================================
function WebDKP_Options_ToggleOption(option)
	-- Toggle the option based on whether it is in the normal options or the WebOptions
	-- data structure
	if( WebDKP_WebOptions[option] ~= nil ) then
		WebDKP_WebOptions[option] = abs(WebDKP_WebOptions[option]-1);
	elseif (WebDKP_Options_SnGa[option] ~= nil ) then
		WebDKP_Options_SnGa[option] = abs(WebDKP_Options_SnGa[option]-1);
	end
end
