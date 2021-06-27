------------------------------------------------------------------------
-- HELP	
------------------------------------------------------------------------
-- Contains methods related to displaying help and the help frame to the
-- user. 
------------------------------------------------------------------------

-- The actual help content
local HLanguage = WebDKP_Options_SnGa["Language"];
local WebDKP_Help = 	{
		[1] = { ["Name"] = WebDKP_Language_lua["Help"]["Welcome"][HLanguage],		["Text"] = nil, },
		[2] = { ["Name"] = WebDKP_Language_lua["Help"]["GeneralUse"][HLanguage], 	["Text"] = nil, },
		[3] = { ["Name"] = WebDKP_Language_lua["Help"]["GeneralOptions"][HLanguage],["Text"] = nil, },
		[4] = { ["Name"] = WebDKP_Language_lua["Help"]["Events&Bids"][HLanguage], 	["Text"] = nil, },
		[5] = { ["Name"] = WebDKP_Language_lua["Help"]["Bidding&Wisper"][HLanguage],["Text"] = nil,	},
		[6] = { ["Name"] = WebDKP_Language_lua["Help"]["AddedRecords"][HLanguage],	["Text"] = nil,	},
		[7] = { ["Name"] = WebDKP_Language_lua["Help"]["SlashCommands"][HLanguage],	["Text"] = nil,	},
		[8] = { ["Name"] = WebDKP_Language_lua["Help"]["IgnoredItems"][HLanguage],	["Text"] = nil,	},
						}

-- ================================
-- Initializes the help menu to show the 
-- currently selected topic
-- ================================
function WebDKP_Help_Init()
	WebDKP_Help_DropDown_Init();
	WebDKP_Help_Frame_Text:SetText(WebDKP_Help[WebDKP_HelpFrame.helpChoice]["Text"]);
end

-- ================================
-- Toggles the help frame on and off.
-- ================================
function WebDKP_Help_ToggleGUI()
	if ( WebDKP_HelpFrame:IsShown() ) then
		WebDKP_HelpFrame:Hide();
	else
		WebDKP_Help_Init();
		WebDKP_HelpFrame:Show();
	end
end

-- ================================
-- Invoked when the gui is down. Loads up the contents
-- of the help topic drop down. 
-- ================================
function WebDKP_Help_DropDown_OnLoad()
	UIDropDownMenu_Initialize(WebDKP_Help_DropDown, WebDKP_Help_DropDown_Init);
end

-- ================================
-- Invoked when the help menu drop down list is invoked. 
-- Runs through the help topics data structure and adds
-- a list of items. 
-- ================================
function WebDKP_Help_DropDown_Init()
	if( WebDKP_HelpFrame.helpChoice == nil ) then
		WebDKP_HelpFrame.helpChoice = 1;
	end

	--WebDKP_Print(WebDKP_Help[WebDKP_HelpFrame.helpChoice]["Name"]);
	local numHelpTopics = WebDKP_GetTableSize(WebDKP_Help);
	for i=1, numHelpTopics do
		if ( type(WebDKP_Help[i]) == "table" ) then
			local checked = (WebDKP_Help[i]["Name"] == WebDKP_Help[WebDKP_HelpFrame.helpChoice]["Name"]);
			WebDKP_Add_HelpDropDownItem(self,WebDKP_Help[i]["Name"],i, checked);	
		end
	end
	UIDropDownMenu_SetSelectedName(WebDKP_Help_DropDown, WebDKP_Help[WebDKP_HelpFrame.helpChoice]["Name"] );
	UIDropDownMenu_SetWidth(WebDKP_Help_DropDown, 150, 10);
end

-- ================================
-- Helper method that adds individual entries into the help menu drop down
-- ================================
function WebDKP_Add_HelpDropDownItem(self,text, value, checked)
local this = self;
	local info = { };
	info.text = text;
	info.value = value; 
	info.owner = this;
	info.checked = checked;
	info.func = WebDKP_Help_DropDown_OnClick;
	UIDropDownMenu_AddButton(info);
end

-- ================================
-- Called when the user switches between
-- a different dkp table.
-- ================================
function WebDKP_Help_DropDown_OnClick(self)
local this = self;
	WebDKP_HelpFrame.helpChoice = this.value;
	WebDKP_Help_DropDown_Init();
	WebDKP_Help_Frame_Text:SetText(WebDKP_Help[WebDKP_HelpFrame.helpChoice]["Text"]);
end

------------------------[  SnGa's  Functions  ]-------------------------
function WebDKP_Load_Help() 
	WebDKP_Help[1]["Text"] = WebDKP_Language_lua["Help"]["Text_1"][GLanguage]
	WebDKP_Help[2]["Text"] = WebDKP_Language_lua["Help"]["Text_2"][GLanguage]
	WebDKP_Help[3]["Text"] = WebDKP_Language_lua["Help"]["Text_3"][GLanguage]
	WebDKP_Help[4]["Text"] = WebDKP_Language_lua["Help"]["Text_4"][GLanguage]
	WebDKP_Help[5]["Text"] = WebDKP_Language_lua["Help"]["Text_5"][GLanguage]
	WebDKP_Help[6]["Text"] = WebDKP_Language_lua["Help"]["Text_6"][GLanguage]
	WebDKP_Help[7]["Text"] = WebDKP_Language_lua["Help"]["Text_7"][GLanguage]
	WebDKP_Help[8]["Text"] = WebDKP_Language_lua["Help"]["Text_8"][GLanguage]

	WebDKP_Help_Frame_Text:SetText(WebDKP_Help[WebDKP_HelpFrame.helpChoice]["Text"]);
end
