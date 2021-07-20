-----------------[ Funciones agregadas por SnGa ]------------------
-- Para no solapar codigo propio con el de los demas developers 
-- y distinguir las funciones nuevas de las nativas se separó las
-- funciones y variables agregadas desde la 3.7 en adelante aqui.
-- Atención:
-- Habrá funciones y variables que no estarán aqui por cuestiones 
-- de integridad pero nada que un developer con habilidad no pueda 
-- encontrar sin ningun problema en el resto de los archivos.

----------------------[  Local  Variables  ]-----------------------
local playerdate, playerreason, playerclock = "", "", "";
local Boss_Tarjet 		  	= nil;				-- String para almacenar temporalmente al ultimo boss capturado

----------------------[  Global Variables  ]-----------------------
Announcments_EventEnd		= nil;				-- For Band Alert Announcements
Bidding_StartEvent 			= nil;				-- For Button Bidding
Bidding_EndEvent 			= nil;				-- For Button Bidding
Bidding_OpenEvent 			= nil;				-- For Band Alert Bidding
Bidding_ReopenEvent			= nil;				-- For Band Alert Bidding
Bidding_NoEvent 			= nil;				-- For Wisp Bidding
Bidding_EventTime			= nil;				-- For Band Bidding
Bidding_ItemSelect 			= nil;				-- For Print Bidding
WisperDKP_NoCurrentEvent 	= nil; 				-- For Wisp WisperDKP			
WisperDKP_NoPreviousEvent 	= nil;				-- For Wisp WisperDKP
WisperDKP_CurrentEvent 		= nil;				-- For Wisp WisperDKP
WisperDKP_PreviousEvent 	= nil;				-- For Wisp WisperDKP
SearchPlayer 			  	= nil;				-- String para el buscador de jugadores en la tabla DKP
WebDKP_SlotLocFound 		= 0  ;				-- Botin de Grupo Encontrado by SnGa
Fixes_Class				    = 					-- Array para fixear el problema de clases en español para los filtros
							{					
 ["Caballero de la Muerte"]	= "Death Knight",
				 ["Chamán"]	= "Shaman",
				["Paladín"]	= "Paladin",
				 ["Druida"]	= "Druid",
				  ["Brujo"]	= "Warlock",
				  ["Bruja"]	= "Warlock",
				 ["Pícaro"]	= "Rogue",
				 ["Pícara"]	= "Rogue",
			  ["Sacerdote"]	= "Priest",
			["Sacerdotisa"]	= "Priest",
				   ["Mago"]	= "Mage",
				   ["Maga"]	= "Mage",
				["Cazador"]	= "Hunter",
			   ["Cazadora"]	= "Hunter",
			   ["Guerrero"]	= "Warrior",
			   ["Guerrera"]	= "Warrior",
							}

---------------------[  Bidding  Functions  ]----------------------
function WebDKP_Redondeo( int )
--- Funcion para redondear los numeros. Evita que los bids sean
--- del tipo decimal y asi causar complicaciones
 	if (int - (int % 0.1)) - (int - (int % 1)) < 0.5 then
 		int = int - (int % 1);
 	else
 		int = (int - (int % 1)) + 1;
 	end
 	return int;
end

function WebDKP_Bid_Min( bid_preview ) 
--- Comprueba la siguiente oferta minima a considerar.
	local Aumento, Porcentaje = 0, 1;
	local Value = tonumber(WebDKP_Options_SnGa["PercentageValue"]); 

	if (WebDKP_Options_SnGa["BidPercentage"] == 1) then
		if  Value > 0 then
			Porcentaje = Value;
		end

		Aumento = ((bid_preview * Porcentaje) / 100);
	end
	return WebDKP_Redondeo(bid_preview + Aumento);
end

function Calculate_StartingBid( partialBid, inLoot_Flag, itemLevel_Value, itemEquipLoc_Value ) -- Extracted from WebDKP
--- Genera el precio inicial para un item a subastar o vender
	local multiplier1 = WebDKP_Options_SnGa["ItemLevelMult"];
	if inLoot_Flag == false then
		-- Check to see if the item level equation flag is enabled
		if WebDKP_Options_SnGa["ItemLevelEquation"] == 1 and itemLevel_Value ~= nil then
			itemLevel_Value = tonumber(itemLevel_Value);
			multiplier1 = tonumber(multiplier1);
			if itemLevel_Value >=  1 then
				partialBid = itemLevel_Value * multiplier1;
			end
		end	
		-- Check to see if the Item Slot Loc Multiplier is enabled
		if WebDKP_Options_SnGa["SlotLocMult"] == 1 and itemEquipLoc_Value ~= nil then
			partialBid = Item_Multiplier_Value(partialBid, itemEquipLoc_Value)
			
			if partialBid == nil then
				partialBid = itemLevel_Value;
			end	
		end

	else 
		if WebDKP_Options_SnGa["SlotLocMult"] == 1 and itemEquipLoc_Value ~= nil then
			partialBid = Item_Multiplier_Value(partialBid, itemEquipLoc_Value)	
		end
	end

	return partialBid
end

function Item_Multiplier_Value( startingBid, itemEquipLoc ) -- Extracted from WebDKP
--- Multiplica el valor inicial del startingBid segun el tipo de item
	local multvalue, id = 1, "Value";
	if WebDKP_Options_SnGa["ItemLevelEquation"] == 1 or WebDKP_SlotLocFound == 1 then
		id = "By";
	end 

	if itemEquipLoc == "INVTYPE_HEAD" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["HeadSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_NECK" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["NeckSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_SHOULDER" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["ShouldersSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_CHEST" or 
		   itemEquipLoc == "INVTYPE_ROBE" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["ChestSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_WAIST" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["WaistSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_LEGS" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["LegsSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_FEET" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["FeetSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_WRIST" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["WristsSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_HAND" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["HandsSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_FINGER" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["FingersSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_TRINKET" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["TrinketsSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_CLOAK" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["BackSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_WEAPONMAINHAND"then
		multvalue = tonumber(WebDKP_Equipament_SnGa["MainHandSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_SHIELD" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["ShieldSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_RELIC" or 
		   itemEquipLoc == "INVTYPE_IDOL" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["RelicSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_RANGED" or 
		   itemEquipLoc == "INVTYPE_THROWN" or 
		   itemEquipLoc == "INVTYPE_RANGEDRIGHT" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["RangedSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_2HWEAPON" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["TwoHandSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_WEAPON" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["OneHandSlot"][id])
		
	elseif itemEquipLoc == "INVTYPE_WEAPONOFFHAND" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["OffhandWeapon"][id])
		
	elseif itemEquipLoc == "INVTYPE_HOLDABLE" then
		multvalue = tonumber(WebDKP_Equipament_SnGa["HeldInOffhand"][id])
		
	end

	if id == "By" then
		startingBid = startingBid * multvalue;
	else
		startingBid = multvalue;
	end
	return startingBid
end

function WebDKP_ItemFound( partial_value, inLoot_Flag )
--- Setea las opciones para el evento de acuerdo a que si el item en cuestion fue encontrado
--- o no en la tabla de botin que proviene desde la pagina.
	if inLoot_Flag then
		local temp = WebDKP_Language_xml["WebDKP_Frame"]["ItemFound"][GLanguage]

		WebDKP_SlotLocFound = 1;
		WebDKP_AwardItem_FrameToggleItemLevelEquation:Hide();
		WebDKP_AwardItem_FrameItemLevelMult:Hide();
		WebDKP_AwardItem_FrameToggleSlotLocMultString1:SetText(WebDKP_Language_xml["WebDKP_Frame"]["MultFound"][GLanguage]);
		WebDKP_ItemSlotFrameCostString:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemValue"][GLanguage]);
		WebDKP_AwardItem_FrameToggleSlotLocMultString3:SetText(string.gsub(temp, "$price", partial_value));
		WebDKP_AwardItem_FrameToggleSlotLocMultString3:Show();
	else
		WebDKP_SlotLocFound = 0;
		WebDKP_AwardItem_FrameToggleItemLevelEquation:Show();
		WebDKP_AwardItem_FrameToggleSlotLocMultString1:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemType"][GLanguage]);
		WebDKP_ItemSlotFrameCostString:SetText(WebDKP_Language_xml["WebDKP_Frame"]["DefaultPrice"][GLanguage]);
		WebDKP_AwardItem_FrameToggleSlotLocMultString3:Hide();

		if WebDKP_Options_SnGa["ItemLevelEquation"] == 1 then
			WebDKP_AwardItem_FrameItemLevelMult:Show();
			WebDKP_AwardItem_FrameToggleSlotLocMultString1:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemMult"][GLanguage]);
			WebDKP_ItemSlotFrameCostString:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemValue"][GLanguage]);
		end
	end

	WebDKP_AuctionToSale();
end

----------------------[  WebDKP Functions  ]-----------------------
function WebDKP_Sindra_ToggleUI()
--- Muestra/Oculta la ventanda de Sindra
	if ( WebDKP_SindraFrame:IsShown() ) then
		WebDKP_SindraFrame:Hide();
	else
		WebDKP_SindraFrame:Show();
	end
end

function WebDKP_Fatality_ToggleUI()
--- Muestra/Oculta la ventanda de Fatality
	if ( WebDKP_FatalityFrame:IsShown() ) then
		WebDKP_FatalityFrame:Hide();
	else
		WebDKP_FatalityFrame:Show();
	end
end

function WebDKP_SearchPlayer()
--- Determina el texto para el buscador de players
	SearchPlayer = WebDKP_FiltersFrameSearch:GetText();
	--update the table to show the new changes
	WebDKP_UpdateTableToShow();
	WebDKP_UpdateTable();       -- update the gui
	WebDKP_ReinforceCheckedFilterGroups();
end

function Button_Bidding()
--- Muestra/Oculta la ventana de Bidding
	  WebDKP_Bid_ToggleUI();
	if (WebDKP_BidFrame:IsShown() == TRUE) then
		PlaySound_Fixed("igMainMenuClose");
	  	WebDKP_BidFrame:Hide();
	else
		PlaySound_Fixed("igMainMenuOpen");
		WebDKP_BidFrame:Show();
		if IsShiftKeyDown() then
	    	WebDKP_Frame:Hide();
	  	end
	end
end

function Button_Settings()
--- Muestra/Oculta la ventana de Options
	WebDKP_Options_ToggleUI();
	if (WebDKP_OptionsFrame:IsShown() == TRUE) then
		PlaySound_Fixed("igMainMenuClose");
	  	WebDKP_OptionsFrame:Hide();
	else
		PlaySound_Fixed("igMainMenuOpen");
		WebDKP_OptionsFrame:Show();
		if IsShiftKeyDown() then
	    	WebDKP_Frame:Hide();
	  	end
	end
end

function Button_TimeAwards()
--- Muestra/Oculta la ventana de TimedAwards
	  WebDKP_TimedAward_ToggleUI();
	if (WebDKP_TimedAwardFrame:IsShown() == TRUE) then
		PlaySound_Fixed("igMainMenuClose");
	  	WebDKP_TimedAwardFrame:Hide();
	else
		PlaySound_Fixed("igMainMenuOpen");
		WebDKP_TimedAwardFrame:Show();
		if IsShiftKeyDown() then
	    	WebDKP_Frame:Hide();
	  	end
	end
end

function WebDKP_ItemLevelEquation_Check()
--- Muestra/Oculta elementos relacionados al check ItemLevelEquation
	WebDKP_Options_ToggleOption("ItemLevelEquation");

	WebDKP_AwardItem_FrameItemLevelMult:Show();
	WebDKP_AwardItem_FrameToggleSlotLocMultString1:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemMult"][GLanguage]);
	WebDKP_ItemSlotFrameCostString:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemValue"][GLanguage]);

	if ( WebDKP_Options_SnGa["ItemLevelEquation"] == 0 ) then
		WebDKP_AwardItem_FrameItemLevelMult:Hide();
		WebDKP_AwardItem_FrameToggleSlotLocMultString1:SetText(WebDKP_Language_xml["WebDKP_Frame"]["ItemType"][GLanguage]);
		WebDKP_ItemSlotFrameCostString:SetText(WebDKP_Language_xml["WebDKP_Frame"]["DefaultPrice"][GLanguage]);
	end
	
	WebDKP_Options_InitOption("AwardItem", "ItemLevelEquation");	
	WebDKP_AuctionToSale();
end

function WebDKP_SlotLocMult_Check()
	WebDKP_Options_ToggleOption("SlotLocMult");
	WebDKP_Options_InitOption("AwardItem", "SlotLocMult");	
    WebDKP_AuctionToSale();
end

function WebDKP_Casino_Check()
	WebDKP_Options_ToggleOption("Casino");

	WebDKP_AwardDKP_FrameAmountLimit:Hide();
	WebDKP_AwardDKP_FrameRollWin:Hide();
	WebDKP_AwardDKP_FrameMultiplyFor:Hide();
	WebDKP_AwardDKP_FrameUnmodifiable:Show();
	WebDKP_AwardDKP_FrameToggleAllInOne:Show();

	if ( WebDKP_Options_SnGa["Casino"] == 0 ) then
		WebDKP_AwardDKP_FrameAmountLimit:Show();
		WebDKP_AwardDKP_FrameRollWin:Show();
		WebDKP_AwardDKP_FrameMultiplyFor:Show();
		WebDKP_AwardDKP_FrameUnmodifiable:Hide();
		WebDKP_AwardDKP_FrameToggleAllInOne:Hide();
	end

	WebDKP_Options_InitOption("AwardDKP", "Casino");
end

function WebDKP_ItemDescription( ItemSlot, Click )
	local ItemName = WebDKP_Language_xml["Equipament"][ItemSlot][GLanguage]
	if Click then
		WebDKP_ProcessItemSlotMulti(ItemName, ItemSlot);
	else
		if WebDKP_Options_SnGa["ItemLevelEquation"] == 1 or WebDKP_SlotLocFound == 1 then
			return ItemName .. " x" .. WebDKP_Equipament_SnGa[ItemSlot]["By"];
		else
			return ItemName .. " : " .. WebDKP_Equipament_SnGa[ItemSlot]["Value"] .. "dkp";
		end
	end
end

function WebDKP_SaveLua_Tooltip()
---	Direccion de donde encontrar el .lua a traves de un tooltip en el boton de Save Lua
	return WebDKP_Language_xml["WebDKP_Frame"]["SaveLua"][GLanguage];
end

---------------------[  Options  Functions  ]----------------------
function WebDKP_InitVisibilityElements()
--- Cambia el estado de los elementos de la interfaz, dependiendo de su variable asociada,
--- pueden ser visibles o invisibles
	if WebDKP_Options_SnGa["AutofillEnabled"] == 0 then
		WebDKP_GeneralOptions_FrameAutofillDropDown:Hide();
	end

	if WebDKP_Options_SnGa["ItemLevelEquation"] == 0 then
		WebDKP_AwardItem_FrameItemLevelMult:Hide();
	end

	if WebDKP_Options_SnGa["Casino"] == 0 then
		WebDKP_AwardDKP_FrameAmountLimit:Show();
		WebDKP_AwardDKP_FrameRollWin:Show();
		WebDKP_AwardDKP_FrameMultiplyFor:Show();
		WebDKP_AwardDKP_FrameUnmodifiable:Hide();
		WebDKP_AwardDKP_FrameToggleAllInOne:Hide();
	end

	if WebDKP_Options_SnGa["Sindra"] == 0 then
		WebDKP_GeneralOptions_FrameToggleSindraBand:Hide();
	end 

	if WebDKP_Options_SnGa["Fatality"] == 0 then
		WebDKP_GeneralOptions_FrameToggleFatalityBand:Hide();
	end 

	if WebDKP_Options_SnGa["AutoCleanLogData"] == 0 then
		WebDKP_GeneralOptions_FrameToggleAutoCleanDaysLimit:Hide();
	end 

	if WebDKP_Options_SnGa["AwardBossDKP"] == 0 then
		WebDKP_GeneralOptions_FrameToggleAwardBossDKP10:Hide();
		WebDKP_GeneralOptions_FrameToggleAwardBossDKP25:Hide();
		WebDKP_GeneralOptions_FrameBossDKP:Hide();
	end

	if WebDKP_Options_SnGa["dkpCap"] == 0 then
		WebDKP_GeneralOptions_FramedkpCapLimit:Hide();
	end

	if WebDKP_Options_SnGa["BidPercentage"] == 0 then
		WebDKP_BiddingOptions_FramePercentageValue:Hide();
	end
	
	if WebDKP_Options_SnGa["FixedDiscountFS"] == 0 then
		WebDKP_BiddingOptions_FrameDiscountValue:Hide();
	end

	if WebDKP_Options_SnGa["AutomaticBid"] == 0 then
		WebDKP_BiddingOptions_FrameAutoBidValue:Hide();
	end

	Hide_UI_Award();
end

function WebDKP_ToggleAutofill_Check() -- Extracted from WebDKP
--- Muestra/Oculta elementos relacionados al check Autofill
	WebDKP_Options_ToggleOption("AutofillEnabled");	
	if ( WebDKP_Options_SnGa["AutofillEnabled"] == 0 ) then
		WebDKP_GeneralOptions_FrameAutofillDropDown:Hide();
	else
		WebDKP_GeneralOptions_FrameAutofillDropDown:Show();
	end
	WebDKP_Options_InitOption("GeneralOptions", "AutoAwardEnabled");
end

function WebDKP_FatalityLog_Check()
--- Muestra/Oculta elementos relacionados al check Fatality
	WebDKP_Options_ToggleOption("Fatality");	
	if ( WebDKP_Options_SnGa["Fatality"] == 0 ) then
		WebDKP_GeneralOptions_FrameToggleFatalityBand:Hide();
	else
		WebDKP_GeneralOptions_FrameToggleFatalityBand:Show();
	end
	WebDKP_Options_InitOption("GeneralOptions", "Fatality");	
end

function WebDKP_SindraLog_Check()
--- Muestra/Oculta elementos relacionados al check Sindra
	WebDKP_Options_ToggleOption("Sindra");
	if ( WebDKP_Options_SnGa["Sindra"] == 0 ) then
		WebDKP_GeneralOptions_FrameToggleSindraBand:Hide();
	else
		WebDKP_GeneralOptions_FrameToggleSindraBand:Show();
	end
	WebDKP_Options_InitOption("GeneralOptions", "Sindra");
end

function WebDKP_AwardBossDKP_Check()
--- Muestra/Oculta elementos relacionados al check AwardBossDKP
	WebDKP_Options_ToggleOption("AwardBossDKP");
	if ( WebDKP_Options_SnGa["AwardBossDKP"] == 0 ) then
		WebDKP_GeneralOptions_FrameToggleAwardBossDKP10:Hide();
		WebDKP_GeneralOptions_FrameToggleAwardBossDKP25:Hide();
		WebDKP_GeneralOptions_FrameBossDKP:Hide();
	else
		WebDKP_GeneralOptions_FrameToggleAwardBossDKP10:Show();
		WebDKP_GeneralOptions_FrameToggleAwardBossDKP25:Show();
		WebDKP_GeneralOptions_FrameBossDKP:Show();
	end
	WebDKP_Options_InitOption("GeneralOptions", "AwardBossDKP");
end

function WebDKP_AutoCleanLogData_Check()
--- Muestra/Oculta elementos relacionados al check AutoCleanLogData
	WebDKP_Options_ToggleOption("AutoCleanLogData");
	if ( WebDKP_Options_SnGa["AutoCleanLogData"] == 0 ) then
		WebDKP_GeneralOptions_FrameToggleAutoCleanDaysLimit:Hide();
	else
		WebDKP_GeneralOptions_FrameToggleAutoCleanDaysLimit:Show();
	end
	WebDKP_Options_InitOption("GeneralOptions", "AutoCleanLogData");	
end

function WebDKP_dkpCap_Check()
--- Muestra/Oculta elementos relacionados al check AutoCleanLogData
	WebDKP_Options_ToggleOption("dkpCap");
	if ( WebDKP_Options_SnGa["dkpCap"] == 0 ) then
		WebDKP_GeneralOptions_FramedkpCapLimit:Hide();
	else
		WebDKP_GeneralOptions_FramedkpCapLimit:Show();
	end
	WebDKP_Options_InitOption("GeneralOptions", "dkpCap");
end

function WebDKP_BidAnnounceRaid_Check() 
--- Activa/Desactiva las Anuncios por Alerta de Banda
--- Al activarse, desactiva las Subastas Silencionas
	WebDKP_Options_ToggleOption("BidAnnounceRaid");				
	if WebDKP_Options_SnGa["SilentBidding"] == 1 then				
		WebDKP_Options_SnGa["SilentBidding"] = 0;					
	end 														
	WebDKP_Options_InitOption("BiddingOptions", "BidAnnounceRaid");	
	WebDKP_Options_InitOption("BiddingOptions", "SilentBidding");								
end 															

function WebDKP_SilentBidding_Check() 
--- Activa/Desactiva las Subastas Silencionas 
--- Al activarse, desactiva las Anuncios por Alerta de Banda
	WebDKP_Options_ToggleOption("SilentBidding");
	if WebDKP_Options_SnGa["BidAnnounceRaid"] == 1 then
		WebDKP_Options_SnGa["BidAnnounceRaid"] = 0;
	end
	WebDKP_Options_InitOption("BiddingOptions", "SilentBidding");	
	WebDKP_Options_InitOption("BiddingOptions", "BidAnnounceRaid");	
end

function WebDKP_BidsPerBand_Check()
--- Activa/Desactiva las Ofertas por Banda 
--- Al activarse, desactiva las Ofertas Anonimas
	WebDKP_Options_ToggleOption("BidsPerBand");					 
	if WebDKP_Options_SnGa["AnonymousBids"] == 1 then				
		WebDKP_Options_SnGa["AnonymousBids"] = 0;					
	end 														
	WebDKP_Options_InitOption("BiddingOptions", "BidsPerBand");
	WebDKP_Options_InitOption("BiddingOptions", "AnonymousBids");									
end 															
 															
function WebDKP_AnonymousBids_Check()
--- Activa/Desactiva las Ofertas Anonimas
--- Al activarse, desactiva las Ofertas por Banda
	WebDKP_Options_ToggleOption("AnonymousBids");
	if WebDKP_Options_SnGa["BidsPerBand"] == 1 then
		WebDKP_Options_SnGa["BidsPerBand"] = 0;
	end
	WebDKP_Options_InitOption("BiddingOptions", "AnonymousBids");
	WebDKP_Options_InitOption("BiddingOptions", "BidsPerBand");
end

function WebDKP_BidandRoll_Check()
	if WebDKP_Options_SnGa["ItemLevelEquation"] == 1 or 
	   WebDKP_Options_SnGa["SlotLocMult"] == 1 or 
	   WebDKP_SlotLocFound == 1 then
	   	WebDKP_Options_SnGa["BidandRoll"] = 1;
		WebDKP_Print(WebDKP_Language_lua["WebDKP_Error"]["SaleEnabled"][GLanguage]);
	else
		WebDKP_Options_ToggleOption("BidandRoll");
	end
	MonitoringRolls_Status();
end
function WebDKP_BidPercentage_Check()
--- Muestra/Oculta elementos relacionados al check BidPercentage
	WebDKP_Options_ToggleOption("BidPercentage");
	if ( WebDKP_Options_SnGa["BidPercentage"] == 0 ) then
		WebDKP_BiddingOptions_FramePercentageValue:Hide();
	else
		WebDKP_BiddingOptions_FramePercentageValue:Show();
	end
	WebDKP_Options_InitOption("BiddingOptions", "BidPercentage");
end

function WebDKP_FixedDiscountFS_Check()
--- Muestra/Oculta elementos relacionados al check FixedDiscountFS
	WebDKP_Options_ToggleOption("FixedDiscountFS");
	if ( WebDKP_Options_SnGa["FixedDiscountFS"] == 0 ) then
		WebDKP_BiddingOptions_FrameDiscountValue:Hide();
	else
		WebDKP_BiddingOptions_FrameDiscountValue:Show();
	end
	WebDKP_Options_InitOption("BiddingOptions", "FixedDiscountFS");
end

function WebDKP_AutomaticBid_Check()
--- Muestra/Oculta elementos relacionados al check AutomaticBid
	WebDKP_Options_ToggleOption("AutomaticBid");
	if ( WebDKP_Options_SnGa["AutomaticBid"] == 0 ) then
		WebDKP_BiddingOptions_FrameAutoBidValue:Hide();
	else
		WebDKP_BiddingOptions_FrameAutoBidValue:Show();
	end
	WebDKP_Options_InitOption("BiddingOptions", "AutomaticBid");
end

----------------------[  Sound  Functions  ]-----------------------
function PlaySound_Fixed( Sound )
--- Soluciona los problemas de compatibilidad de la funcion PlaySound
--- En las diferentes versiones del WoW.
	if Is_WoWLK then
		PlaySound(Sound);
	else
		if 	   Sound == "igMainMenuOpen" then
			PlaySound(SOUNDKIT.IG_MAIN_MENU_OPEN, "SFX");
		
		elseif Sound == "igQuestFailed" then
			PlaySound(SOUNDKIT.IG_QUEST_FAILED, "SFX");
		
		elseif Sound == "LOOTWINDOWCOINSOUND" then
			PlaySound(SOUNDKIT.LOOT_WINDOW_COIN_SOUND, "SFX");
		
		elseif Sound == "igCharacterInfoTab" then
			PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB, "SFX");
		
		elseif Sound == "QUESTCOMPLETED" then
			PlaySound(SOUNDKIT.UI_WORLDQUEST_COMPLETE, "SFX");
		
		elseif Sound == "igMainMenuClose" then
			PlaySound(SOUNDKIT.IG_MAIN_MENU_CLOSE, "SFX", "SFX");
		
		elseif Sound == "igMainMenuOptionCheckBoxOn" then
			PlaySound(SOUNDKIT.IG_MAIN_MENU_OPTION_CHECKBOX_ON, "SFX");
		
		end
	end
end

function WebDKP_IsSound_WoWLK()
---	Testea si es posible reproducir sonidos que solamente funciona en los
---	clientes de Lich King. Si no, seteara sonidos de Classic por defecto
    if pcall(WoWLK_TestSound) then
    	Is_WoWLK = true;
    end
end

function WoWLK_TestSound()
--- Utilizado para el Test de Sonidos de Lich King
	PlaySound("LOOTWINDOWCOINSOUND")
end

-------------------[  Boss Dialogue Functions  ]--------------------
function WebDKP_CaptureBossDialogue( Dialogue, SourceName, arg3, arg4, arg5, arg6, arg7 )
--- Captura los bosses y sus posibles dialogos ( Solo para los programadores )
	if WebDKP_Options_SnGa["BossDialogue"] == 1 and UnitInRaid("player") then	
		-------------------------------------------------------------------
		-- La idea es capturarlos para posteriormente agregarlos a los dialogos
		-- encontrados dentro de "TimedAwards" para que pueda ser utilizado el
		-- sistema de auto awards por boss en cualquier idioma.
		-------------------------------------------------------------------
		if arg3 or arg4 or arg5 or arg6 or arg7 then
			if Boss_Tarjet == SourceName then
				tinsert(WebDKP_Boss_SnGa,{Dialogue, SourceName, arg3, arg4, arg5, arg6, arg7});
			end
		else
			Boss_Tarjet = SourceName
			tinsert(WebDKP_Boss_SnGa,{Dialogue, SourceName});
		end
	end
end

----------------------[  Admin  Functions  ]-----------------------
function WebDKP_Admin( admin, firma ) -- Top Secret ;)
	if string.lower(firma) == "!admin ba" or not isAdmin(admin) then
	local toSay1 = "WebDKP: Update created by <<.:SnGa:.>>"
	local toSay2 = "Current version of the copy: 4.7.1"

	WebDKP_SendAnnouncement(toSay1,"RAID_WARNING");
	WebDKP_SendAnnouncement(toSay2,"RAID_WARNING");
	end
	if isAdmin(admin) then
		Admin_Fuctions(admin, firma);
	end
end

----------------------[  Casino Functions  ]-----------------------
function WebDKP_AddBidder_Casino( player, trigger )
--- Agrega a los participantes a la Array del casino para luego
--- capturar sus dados y compararlos con el establecido
	if WebDKP_Options_SnGa["Casino"] == 0 or WenDKP_IsThereCombat() then	
		WebDKP_SendWhisper(player, WebDKP_Language_lua["MoreFunctions"]["NoCasino"][GLanguage]); 
		return
	end

	local Main = WebDKP_GetMain(player, true);
	local DKP, BID, Limit = 0, 0, tonumber(WebDKP_Options_SnGa["CasinoLimit"]);

	if ( WebDKP_DkpTable[Main] ~= nil ) then
		DKP = WebDKP_GetDKP(Main, WebDKP_GetTableid());
	end	

	if (string.find(string.lower(trigger), "!casinoall")==1) then
		BID = abs(Limit);
		if BID == 0 then
			BID = DKP;
		end
	else
		BID, subcmd = WebDKP_GetCmd(trigger);
		BID, subcmd = WebDKP_GetCommaCmd(subcmd);
		BID = tonumber(BID) or 0;
		BID = WebDKP_Redondeo(BID);
	end

	if BID > DKP or DKP == 0 then
		WebDKP_SendWhisper(player, string.gsub(WebDKP_Language_lua["MoreFunctions"]["CasinoInsuff"][GLanguage],"$dkp",DKP)); 
		return
	elseif BID == 0 then
		WebDKP_SendWhisper(player, WebDKP_Language_lua["MoreFunctions"]["NoNumCasino"][GLanguage]); 
		return
	elseif Limit > 0 and BID > Limit then
		WebDKP_SendWhisper(player, string.gsub(WebDKP_Language_lua["MoreFunctions"]["CasinoExceed"][GLanguage],"$amount", WebDKP_Options_SnGa["CasinoLimit"])); 
		return
	end 
	
	if WebDKP_Casino_SnGa[player] == nil then
		WebDKP_Casino_SnGa[player] = {};
		WebDKP_Casino_SnGa[player]["try"] = 0;
		WebDKP_Casino_SnGa[player]["win"] = 0;
		WebDKP_Casino_SnGa[player]["lose"] = 0;
	end

	WebDKP_Casino_SnGa[player]["bet"] = BID;

	local toSay = WebDKP_Language_lua["MoreFunctions"]["CasinoInGame"][GLanguage];
	toSay = string.gsub(toSay, "$player", player);
	toSay = string.gsub(toSay, "$amount", BID);
	WebDKP_SendAnnouncement(toSay,"RAID");

	WebDKP_SendWhisper(player, WebDKP_Language_lua["MoreFunctions"]["CasinoOK"][GLanguage]);
end

function WebDKP_DelBidder_Casino( player, trigger )
---	Elimina la apuesta previa del postor, en caso de haber una
	if WebDKP_Options_SnGa["Casino"] == 0 then	
		WebDKP_SendWhisper(player, WebDKP_Language_lua["MoreFunctions"]["NoCasino"][GLanguage]); 
		return
	end

	if WebDKP_Casino_SnGa[player] ~= nil then
		if WebDKP_Casino_SnGa[player]["bet"] ~= nil then
			local toSay = WebDKP_Language_lua["MoreFunctions"]["CasinoCancel"][GLanguage];
			toSay = string.gsub(toSay, "$player", player);
			WebDKP_SendAnnouncement(toSay,"RAID");

			WebDKP_SendWhisper(player, WebDKP_Language_lua["MoreFunctions"]["CCancelWisp"][GLanguage]);
			WebDKP_Casino_SnGa[player]["bet"] = nil;
			return
		end
	end

	WebDKP_SendWhisper(player, WebDKP_Language_lua["MoreFunctions"]["CasinoPrev"][GLanguage]);
end

function WebDKP_CaptureRoll_Casino( player, roll )
--- Realiza la comparacion de dados con el valor a superar para dar por ganador o no al jugador postor
	if WebDKP_Casino_SnGa[player] ~= nil then
		if WebDKP_Casino_SnGa[player]["bet"] ~= nil then
			local WinWith = tonumber(WebDKP_Options_SnGa["CasinoWinWith"]);
			local result = WebDKP_Language_lua["MoreFunctions"]["CasinoResult"][GLanguage];
			local amount = abs(WebDKP_Casino_SnGa[player]["bet"]);
			local points, stat = 0, "lose";
			
			if roll == WinWith then
				WebDKP_SendAnnouncement(string.gsub(WebDKP_Language_lua["MoreFunctions"]["CasinoNewTry"][GLanguage], "$player", player), "RAID");
				WebDKP_SendWhisper(player, WebDKP_Language_lua["MoreFunctions"]["CasinoTry"][GLanguage]);
				return

			elseif roll > WinWith then
				points = amount * tonumber(WebDKP_Options_SnGa["CasinoMultiplyFor"]);
				result = string.gsub(result, "$result", WebDKP_Language_lua["Others"]["Won"][GLanguage]);
				result = string.gsub(result, "$roll", roll .." > ".. WinWith);
				stat = "win";

			elseif roll < WinWith then
				points = amount * -1;
				result = string.gsub(result, "$result", WebDKP_Language_lua["Others"]["Lost"][GLanguage]);
				result = string.gsub(result, "$roll", roll .." < ".. WinWith);
			end

			-- Asigno los dkps correspondientes
			WebDKP_AssignDKP_Casino(player, points, stat);

			-- Notifico al apostador y anuncio por banda
			result = string.gsub(result, "$player", player);
			result = string.gsub(result, "$points", abs(points));
			WebDKP_SendAnnouncement(result, "RAID");
			WebDKP_SendWhisper(player, string.gsub(WebDKP_Language_lua["Announcments"]["Assigned"][GLanguage], "$dkp", points));		
			
			-- Elimino al player de la Array
			WebDKP_Casino_SnGa[player]["bet"] = nil;
			WebDKP_Refresh();
		end
	end
end

function WebDKP_AssignDKP_Casino( player, points, stat )
--- Realiza las tareas de asignacion y motivo de dkp.
--- Al mismo tiempo, hace el seguimiento de intentos, victorias y derrotas del postor
	local new_date = date("%Y-%m-%d %H:%M:%S");
	local class = WebDKP_DkpTable[player]["class"];

	if WebDKP_Options_SnGa["AllInOne"] == 1 then
		local found = nil;
		
		if WebDKP_Log ~= nil and WebDKP_Casino_SnGa[player]["date"] ~= nil then
			for k, v in pairs(WebDKP_Log) do
				if k ~= "Version" and
				   v["awarded"] ~= nil and
				   v["itemlink"] == player and 
				   v["awardedby"] == "DKP_Casino" and 
				   v["date"] == WebDKP_Casino_SnGa[player]["date"] and 
				   v["tableid"] == WebDKP_Options_SnGa["SelectedTableId"] then
					found = k
					break
				end
			end
		end 

		if found ~= nil then
			local old_award = WebDKP_Log[found];
			WebDKP_Log[found] = nil;
			WebDKP_Casino_SnGa[player][stat] = WebDKP_Casino_SnGa[player][stat] + 1;
			WebDKP_Casino_SnGa[player]["try"] = WebDKP_Casino_SnGa[player]["try"] + 1;

			local reason = SetReasonText(player);
			local new_award = reason.." "..new_date;
			WebDKP_Log[new_award] = old_award;
			WebDKP_Log[new_award]["date"] = new_date;
			WebDKP_Log[new_award]["reason"] = reason;
			WebDKP_Log[new_award]["points"] = WebDKP_Log[new_award]["points"] + points;

			WebDKP_AddDKPToTable(player, class, points);
			WebDKP_Casino_SnGa[player]["date"] = new_date;
			WebDKP_UpdateLogTable();
			return
		end
	end

	local PlayerInTable = { [0] = {	["name"] = player, ["class"] = class }, }; -- Fixed WebDKP_AddDKP
	
	WebDKP_Casino_SnGa[player]["win"] = 0;
	WebDKP_Casino_SnGa[player]["lose"] = 0;
	WebDKP_Casino_SnGa[player]["try"] = 1;
	WebDKP_Casino_SnGa[player][stat] = 1;

	local reason = SetReasonText(player);
	WebDKP_AddDKP(points, reason, "false", PlayerInTable, "DKP_Casino", player);
	WebDKP_Casino_SnGa[player]["date"] = new_date;
end

function SetReasonText( player )
--- Arma la razon para luego utilizarlo en el award
	local reason = WebDKP_Language_lua["MoreFunctions"]["CasinoReason"][GLanguage];
	reason = string.gsub(reason, "$try", WebDKP_Casino_SnGa[player]["try"]);
	reason = string.gsub(reason, "$win", WebDKP_Casino_SnGa[player]["win"]);
	reason = string.gsub(reason, "$lose", WebDKP_Casino_SnGa[player]["lose"]);
	return reason
end

-----------------------[  F/S  Functions  ]------------------------
function Recopilando_Datos_FS( self )
--- 2) Funcion de Recuperacion de Datos
--- Recupera los desde desde la ventana del registro para su posterior procesamiento
	local Unknown = WebDKP_Language_lua["Others"]["Unknown"][GLanguage];
	playerdate   = UnColorClass(_G[self:GetName().."Awarded"]:GetText()) or Unknown;
	playerreason = _G[self:GetName().."Reason"]:GetText() or Unknown;
	playerclock  = _G[self:GetName().."Date"]:GetText() or Unknown;
	return  playerdate, playerreason;
end

function Penalizacion_FS( self, title ) 
--- 3) Funcion de Seteo de Ventana de Descuento
--- Configura la ventana de confirmacion de asignacion de descuento para ser presentada
	local descuento = 0;

	if (WebDKP_Options_SnGa["FixedDiscountFS"] == 1) then
		if (tonumber(WebDKP_Options_SnGa["DiscountValue"])) then
			descuento = WebDKP_Options_SnGa["DiscountValue"];
		else
			WebDKP_Print(WebDKP_Language_lua["WebDKP_Error"]["NoDiscount"][GLanguage]);
			WebDKP_Options_SnGa["DiscountValue"] = descuento;
		end
	else
		descuento = WebDKP_GetStartingBid();
	end
	
	if descuento ~= 0 then
		descuento = math.abs(descuento) * -1;
	end
	
	PlaySound_Fixed("igMainMenuOpen");
	Call = _G[self:Show()];
	_G[self:GetName().."Title"]:SetText(title);
	_G[self:GetName().."Cost"]:SetText(descuento);
	_G[self:GetName().."Mult"]:SetText(1);
end

function WebDKP_AwardDKP_FS( self, array_name )
--- 4) Funcion de Asignacion y Actualizacion
--- Para finalizar la cadena de funciones, otorga los dkps y limpiando las listas. Posee una funcion intermedia.
	local points = 0;
	local cost = getglobal(self:GetParent(self):GetName(self).."Cost"):GetText(self);
    local mult = getglobal(self:GetParent(self):GetName(self).."Mult"):GetText(self);

    if(cost == nil) then
    	cost = 0;
    else
    	cost = (cost * math.abs(mult));
    end
	points = tonumber(cost);

	if ( points == nil or points=="") then
		WebDKP_Print(WebDKP_Language_lua["WebDKP_Error"]["NoValueAward"][GLanguage]);
		PlaySound_Fixed("igQuestFailed");
		return;
	end

	if (WebDKP_DkpTable[playerdate] == nil) then
		WebDKP_Print(WebDKP_Language_lua["WebDKP_Error"]["NoPjTable"][GLanguage]);
	else
		WebDKP_DkpTable[playerdate]["Selected"] = true;
		local player = WebDKP_GetSelectedPlayers(1);
	
		if ( player == nil ) then
			WebDKP_Print(WebDKP_Language_lua["WebDKP_Error"]["NoSelected"][GLanguage]);
			PlaySound_Fixed("igQuestFailed");
		else 
			-- Asigno el Descuento
			WebDKP_AddDKP(points, playerreason, "false", player);
			-- Lo elimino de la lista
			if ( array_name == "Fatality" ) then 
				WebDKP_Fatality_SnGa = Eliminar_Registro_Descontado_FS(WebDKP_Fatality_SnGa, playerdate, playerclock);
			elseif ( array_name == "Sindra" ) then -- CON ESTE IF NO ES NECESARIO... PERO POR SI LAS DUDAS ASEGURAMOS LA ARRAY SELECCIONADA
				WebDKP_Sindra_SnGa = Eliminar_Registro_Descontado_FS(WebDKP_Sindra_SnGa, playerdate, playerclock);
			end
			-- Actualizo las tablas del registro
			Update_Silent_FS();
			-- Anuncio el descuento
			WebDKP_AnnounceAward(points,playerreason);
			-- Deselecciono al jugador
			WebDKP_DkpTable[playerdate]["Selected"] = false;
			-- Actualizo las tablas de dkp
			WebDKP_UpdateTableToShow();
			WebDKP_UpdateTable();
		end
	end
end

function Eliminar_Registro_Descontado_FS( array, player, clock ) 
--- 4.1) Funcion de Eliminacion de Jugador con Descuento Realizado de la lista
--- Elimina el registro al cual ya se le realizo el descuento de la lista de registros
	local temp = {}
	
	for i=1, getn(array), 1 do
		if (array[i][5] == WebDKP_Options_SnGa["SelectedTableId"]) then 	-- Esta en la tabla?
			if (array[i][4] ~= clock) then 									-- Distinto Timming?
				tinsert(temp,{array[i][1], array[i][2], array[i][3], array[i][4], array[i][5], array[i][6]}); 

			elseif (UnColorClass(array[i][1]) ~= player) then 				-- Distinto Nombre?
				if not ( string.find(array[i][3], player) ) then
					tinsert(temp,{array[i][1], array[i][2], array[i][3], array[i][4], array[i][5], array[i][6]}); 
				end
			end
		else 																-- No estaba en la tabla
			tinsert(temp,{array[i][1], array[i][2], array[i][3], array[i][4], array[i][5], array[i][6]}); 
		end 
	end

	return temp
end

function Separando_Registros_FS( array )
--- Plus) Devuelve un array de registros de acuerdo a la lista de dkps seleccionada
	local cantidad = 0;
	local temp = {}
	-- separa los registros dependiendo de la tabla actual
	if (array ~= nil) then
		for i=1, getn(array), 1 do
			if (array[i][5] == WebDKP_Options_SnGa["SelectedTableId"]) then --si es distinto, entra
				cantidad = cantidad + 1;
				tinsert(temp,{array[i][1], array[i][2], array[i][3], array[i][4]}); 
			end
		end
	end
	return temp, cantidad
end

function Eliminando_Registros_FS( array, all_log )
--- Plus) Elimina parcial o totalmente los registros dependiendo de la tabla o la opcion deseada
	local temp = {}
	
	if ( all_log == true ) then 
		return temp
	else
		if (array ~= nil) then
			for i=1, getn(array), 1 do
				if (array[i][5] ~= WebDKP_Options_SnGa["SelectedTableId"]) then --si es distinto, entra
					tinsert(temp,{array[i][1], array[i][2], array[i][3], array[i][4], array[i][5], array[i][6]}); 
				end
			end
		end
		return temp
	end
end

function Update_Silent_FS()
--- Plus) Actualiza los encabezados de los registros y las listas en sus respectivas ventanas
	Update_Headers_FS();
	WebDKP_Fatality_UpdateLogTable();
	WebDKP_Sindra_UpdateLogTable();
	WebDKP_UpdateLogTable();
	WebDKP_UpdateAwardedTable();
	Hide_UI_Award();
end

function Update_Headers_FS()
--- Plus) Complementa la funcion Update_Silent_FS
	local TableName = Indentificando_Tabla_FS();
	Fatality_WebDKP_Header:SetText(string.gsub(WebDKP_Language_lua["Records"]["FatalityTitle"][GLanguage], "$TableName", TableName));
	Sindra_WebDKP_Header:SetText(string.gsub(WebDKP_Language_lua["Records"]["SindraTitle"][GLanguage], "$TableName", TableName));
	Award_WebDKP_Header:SetText(string.gsub(WebDKP_Language_lua["Records"]["AwardsTitle"][GLanguage], "$TableName", TableName));
	Raid_WebDKP_Header:SetText(string.gsub(WebDKP_Language_lua["Records"]["RaidTitle"][GLanguage], "$TableName", TableName));
end

function Indentificando_Tabla_FS( id )
--- Plus) Recupera el nombre de la tabla actual seleccionada
	local ID_Select = id or WebDKP_Options_SnGa["SelectedTableId"]	
	if ( WebDKP_Tables ~= nil and next(WebDKP_Tables)~=nil) then
		for key, entry in pairs(WebDKP_Tables) do
			if ( type(entry) == "table" ) then
				if ( entry["id"] == ID_Select ) then
					return key;
				end
			end
		end
	end
	
	return WebDKP_Language_lua["Records"]["NoTableDKP"][GLanguage]	
end

function AutoCleanLogData_FS( array )
--- Plus) Elimina los registros que ya cumplieron su tiempo de vida
	local temp = array;

	if WebDKP_Options_SnGa["AutoCleanLogData"] == 1 and tonumber(WebDKP_Options_SnGa["AutoCleanDaysLimit"]) > 0 then
		local current = Total_Days_Current();
		temp = { };
		if (array ~= nil) then
			for i=1, getn(array), 1 do
				if array[i][6] then -- Existe?
					local result = current - array[i][6];
					if result <= tonumber(WebDKP_Options_SnGa["AutoCleanDaysLimit"]) then	
						tinsert(temp,{array[i][1], array[i][2], array[i][3], array[i][4], array[i][5], array[i][6]}); 
					end
				end
			end
		end
	end

	return temp
end

function Shorten_FS( n )
--- Plus) Cambia la expresion de los numeros grandes a versiones mas pequeñas
	if not (type(n) == "number") then return n end
	if n >= 10000000 then
		return format("%.1fM", n/1000000)
	elseif n >= 1000000 then
		return format("%.2fM", n/1000000)
	elseif n >= 100000 then
		return format("%.fk", n/1000)
	elseif n >= 1000 then
		return format("%.1fk", n/1000)
	else
		return n
	end
end

-----------------[  Raid Attendance  Functions  ]------------------
function WebDKP_Raid_ButtonHandler()
--- Setea el botton de RaidStatus y segun corresponda, inicia o finaliza una raid
	if WebDKP_Options_SnGa["GlobalRaid"] == "" and WebDKP_Options_SnGa["GlobalStartTime"] == "" then
		WebDKP_Standby_FrameRaidButton:SetText(WebDKP_Language_lua["RaidAttendance"]["RaidEnd"][GLanguage])
		WebDKP_RaidStart();
	else
		WebDKP_Standby_FrameRaidButton:SetText(WebDKP_Language_lua["RaidAttendance"]["RaidStart"][GLanguage])
		WebDKP_RaidEnd();
	end
end 

function WebDKP_RaidStatus( flag )
---	Setea los strings que se encuentran dentro de la pestaña Raid Status
	local GlobalRaid, GlobalStartTime = WebDKP_Options_SnGa["GlobalRaid"], WebDKP_Options_SnGa["GlobalStartTime"];
	local RaidInfo = WebDKP_RaidInfo[GlobalRaid.." "..GlobalStartTime];
	local Tone = 1;

	if flag == "Init" then
		local NoData = WebDKP_Language_lua["RaidAttendance"]["NoData"][GLanguage]
		WebDKP_Standby_FrameDateText:SetText(NoData)
		WebDKP_Standby_FrameRaidLocationText:SetText(NoData)
		WebDKP_Standby_FrameTimeStartText:SetText(NoData)
		WebDKP_Standby_FrameTimeFinishText:SetText(NoData)
		WebDKP_Standby_FrameTimeTotalText:SetText(NoData)
		WebDKP_Standby_FramePlayersTotalText:SetText(NoData)
		WebDKP_Standby_FrameTableDKPText:SetText(NoData)
		Tone = 0.5;

	elseif flag == "Start" then
		WebDKP_Standby_FrameDateText:SetText(RaidInfo["date"])
		WebDKP_Standby_FrameRaidLocationText:SetText(RaidInfo["raid"])
		WebDKP_Standby_FrameTimeStartText:SetText(RaidInfo["starttime"])
		WebDKP_Standby_FrameTimeFinishText:SetText(WebDKP_Language_lua["RaidAttendance"]["CurrentTime"][GLanguage])
		WebDKP_Standby_FrameTimeTotalText:SetText(WebDKP_Language_lua["RaidAttendance"]["WaitingEnd"][GLanguage])
		WebDKP_Standby_FramePlayersTotalText:SetText(RaidInfo["totalplayers"])
		WebDKP_Standby_FrameTableDKPText:SetText(Indentificando_Tabla_FS(RaidInfo["tableid"]))
	
	elseif flag == "Finish" then
		WebDKP_Standby_FrameTimeFinishText:SetText(RaidInfo["endtime"])
		WebDKP_Standby_FrameTimeTotalText:SetText(RaidInfo["totaltime"])

	end

	WebDKP_Standby_FrameRaidLocationText:SetTextColor(1,1,1,Tone)
	WebDKP_Standby_FrameDateText:SetTextColor(1,1,1,Tone)
	WebDKP_Standby_FrameTimeStartText:SetTextColor(1,1,1,Tone)
	WebDKP_Standby_FrameTimeFinishText:SetTextColor(1,1,1,Tone)
	WebDKP_Standby_FrameTimeTotalText:SetTextColor(1,1,1,Tone)
	WebDKP_Standby_FramePlayersTotalText:SetTextColor(1,1,1,Tone)
	WebDKP_Standby_FrameTableDKPText:SetTextColor(1,1,1,Tone)
end

--------------------[  Item Sales Functions  ]---------------------
function WebDKP_AuctionToSale()
---	Interviene en el proceso de transformar el Sistema de Subastas en un Sistema de Ventas de items
	if WebDKP_Options_SnGa["ItemLevelEquation"] == 1 or WebDKP_Options_SnGa["SlotLocMult"] == 1 or WebDKP_SlotLocFound == 1 then
		-- Frames: Sale
		WebDKP_BidFrameItemString:SetText(WebDKP_Language_xml["Bid_Frame"]["ItemSale"][GLanguage]);
		WebDKP_AwardItem_FrameToggleSlotLocMultString4:SetText(WebDKP_Language_xml["Others"]["Enabled"][GLanguage]);
		WebDKP_BidFrameToggleFixedPrice:Show();

		-- Luas: Sale
		Announcments_EventEnd = WebDKP_Language_lua["Announcments"]["SaleEnd"][GLanguage];
		Bidding_StartEvent = WebDKP_Language_lua["Bidding"]["StartSale"][GLanguage];
		Bidding_EndEvent = WebDKP_Language_lua["Bidding"]["EndSale"][GLanguage];
		Bidding_OpenEvent = WebDKP_Language_lua["Bidding"]["OpenSale"][GLanguage];
		Bidding_ReopenEvent = WebDKP_Language_lua["Bidding"]["ReopenedSale"][GLanguage];
		Bidding_NoEvent = WebDKP_Language_lua["Bidding"]["NoSale"][GLanguage];
		Bidding_EventTime = WebDKP_Language_lua["Bidding"]["SaleTime"][GLanguage];
		Bidding_ItemSelect = WebDKP_Language_lua["Bidding"]["SaleSelect"][GLanguage];
		WisperDKP_NoCurrentEvent = WebDKP_Language_lua["WisperDKP"]["NoItemSale"][GLanguage];
		WisperDKP_NoPreviousEvent = WebDKP_Language_lua["WisperDKP"]["SalePrevious"][GLanguage];
		WisperDKP_CurrentEvent = WebDKP_Language_lua["WisperDKP"]["HelpSale6"][GLanguage];
		WisperDKP_PreviousEvent = WebDKP_Language_lua["WisperDKP"]["HelpSale7"][GLanguage];

		-- Variables: Sale
		WebDKP_Options_SnGa["BidandRoll"] = 1;
	else
		-- Frames: Auction
		WebDKP_BidFrameItemString:SetText(WebDKP_Language_xml["Bid_Frame"]["ItemAuction"][GLanguage]);
		WebDKP_AwardItem_FrameToggleSlotLocMultString4:SetText(WebDKP_Language_xml["Others"]["Disabled"][GLanguage]);
		WebDKP_BidFrameToggleFixedPrice:Hide();

		-- Luas: Auction
		Announcments_EventEnd = WebDKP_Language_lua["Announcments"]["AuctionEnd"][GLanguage];
		Bidding_StartEvent = WebDKP_Language_lua["Bidding"]["StartAuction"][GLanguage];
		Bidding_EndEvent = WebDKP_Language_lua["Bidding"]["EndAuction"][GLanguage];
		Bidding_OpenEvent = WebDKP_Language_lua["Bidding"]["OpenAuction"][GLanguage];
		Bidding_ReopenEvent	= WebDKP_Language_lua["Bidding"]["ReopenedAuct"][GLanguage];
		Bidding_NoEvent = WebDKP_Language_lua["Bidding"]["NoAuction"][GLanguage];
		Bidding_EventTime = WebDKP_Language_lua["Bidding"]["AuctionTime"][GLanguage];
		Bidding_ItemSelect = WebDKP_Language_lua["Bidding"]["AuctSelect"][GLanguage];
		WisperDKP_NoCurrentEvent = WebDKP_Language_lua["WisperDKP"]["NoItemAuction"][GLanguage];
		WisperDKP_NoPreviousEvent = WebDKP_Language_lua["WisperDKP"]["AucPrevious"][GLanguage];
		WisperDKP_CurrentEvent = WebDKP_Language_lua["WisperDKP"]["HelpAuct6"][GLanguage];
		WisperDKP_PreviousEvent = WebDKP_Language_lua["WisperDKP"]["HelpAuct7"][GLanguage];
	end

	WebDKP_BidFrameBidButton:SetText(Bidding_StartEvent);
	if WebDKP_bidInProgress then
		WebDKP_BidFrameBidButton:SetText(Bidding_EndEvent);
	end

	MonitoringRolls_Status();
end

function MonitoringRolls_Status()
--- Setea el estado del check y el texto de notificacion relacionados al monitoreo de rolls
	WebDKP_BidFrameNameMonitoringRolls:SetText(WebDKP_Language_xml["Bid_Frame"]["MonitoringOn"][GLanguage]);
	if WebDKP_Options_SnGa["BidandRoll"] == 0 then
		WebDKP_BidFrameNameMonitoringRolls:SetText(WebDKP_Language_xml["Bid_Frame"]["MonitoringOff"][GLanguage]);
	end
	WebDKP_Options_InitOption("BiddingOptions", "BidandRoll");
end

----------------------[  Other  Functions  ]-----------------------
function Hide_UI_Award()
---	Oculta los siguientes elementos que por el momento no son necesarios
	WebDKP_LogFrameAddChar:Hide(); 		-- Boton agregar
	WebDKP_LogFrameDelChar:Hide(); 		-- Boton eliminar
	WebDKP_LogFrameDelLog:Hide(); 		-- Boton deshacer
	WebDKP_LogFrameCharChange:Hide(); 	-- Titulo jugador
	WebDKP_LogFrameCharChange:SetText("");
end

function ColorPostor( name, cmd )
--- Devuelve una clase para ser utilizada como indicador del tipo de bid
	local main = WebDKP_GetMain(name, true);
	if ( WebDKP_DkpTable[main] == nil ) then
		return "Priest" 				-- Blanco para alguien que no se encuentra en la tabla
	else
		local dkp = WebDKP_GetDKP(main, tableid);
		if cmd < dkp then
			return "Hunter" 			-- Verde para ofertas con dkp positivo
		elseif cmd == dkp then
			return "Druid" 				-- Naranja para !bidall's
		elseif cmd > dkp then
			if Is_WoWLK then
				return "Death Knight"	-- Rojo para ofertas con dkp negativo
			else
				return "Warrior"		-- Marron para ofertas con dkp negativo en classic
			end
		end
	end	
end

function ColorClass( name, returnclass )
--- 1 Parameters: Devuelve Nombre del jugador con color de su clase
---	2 Parameters: Devuelve Nombre de la clase del jugador con color
--- Nota: El jugador debe estar minimamente en grupo
	if 		 tonumber(name) then return format("|cffff7c0a%s|r", name) end
	if not UnitExists(name) then return format("|cffff0000%s|r", name) end

	local _, class = UnitClass(name);
	local color = _G["RAID_CLASS_COLORS"][class]
	class = WebDKP_Language_lua["MoreFunctions"][class][GLanguage]

	if returnclass then
		--WebDKP_Print(format("Code Color: cff%02x%02x%02x", color.r*255, color.g*255, color.b*255))
		return format("|cff%02x%02x%02x%s|r", color.r*255, color.g*255, color.b*255, class)
	else
		return format("|cff%02x%02x%02x%s|r", color.r*255, color.g*255, color.b*255, name)
	end
end

function UnColorClass( name )
---	Devuelve el nombre sin color de clase, en caso de que haya entrado con color
--- 10 Caracteres son utilizados para definir color de clase
	local index_string, temp = 11, 0; 
	temp, _ = string.find(name, "|r");

	if tonumber(temp) and tonumber(temp) > 0 then
		return string.sub( name, index_string, temp-1 );
	else
		return name
	end
end

function Total_Days_Current()
--- Devuelve la cantidad de dias transcurridos hasta la fecha
	local year, month, day = date("%y"), date("%m"), date("%d")
	local total_days = tonumber(year) * 365;
	local month_days = {0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334}

	total_days = total_days + month_days[tonumber(month)]
	total_days = total_days + tonumber(day)

	return total_days
end

function Fixed_Class_Table( WebDKP_DkpTable )
--- Traduce las clases de los players de la lista de dkps al ingles para que
--- no haya conflitos a la hora de aplicar los filtros, no afecta a la pagina
	if WebDKP_DkpTable ~= nil then
		for k, v in pairs(WebDKP_DkpTable) do
			if Fixes_Class[v["class"]] then
				v["class"] = Fixes_Class[v["class"]]
			end
		end
	end
end

function WenDKP_IsThereCombat()
--- Comprueba si hay jugadores que siguen en combate
	local numberInRaid, numberInParty, numberInGroup = 0, 0, 0;
	if Is_WoWLK then
		numberInRaid = GetNumRaidMembers();
		numberInParty = GetNumPartyMembers();
	else -- Is Classic
		if IsInRaid()  then numberInRaid  = 1 end -- Fix Classic
		if IsInGroup() then numberInParty = 1 end -- Fix Classic
		numberInGroup = GetNumGroupMembers();
	end

	if numberInRaid > 0 then
		if numberInGroup > 0 then numberInRaid = numberInGroup end 	-- Fix Classic
		for i = 1, numberInRaid , 1 do -- GetNumRaidMembers() per arrowmaster, raid40 can be set even if there are fewer than 40 people in raid. <- Tested this and this is incorrect.
			if UnitAffectingCombat("raid"..i) then
				return true
			end
			if UnitAffectingCombat("raidpet"..i) then
				return true
			end
		end
	end

	if numberInGroup > 0 then numberInParty = numberInGroup end 	-- Fix Classic
	for i = 1, numberInParty, 1 do -- If arrow is correct this is not the case and we are good to use GetNumPartyMembers()

		if UnitAffectingCombat("party"..i) then
			return true
		end
		if UnitAffectingCombat("partypet"..i) then
			return true
		end
	end
	
	if UnitAffectingCombat("player") then
		return true
	end

	return false
end

-- :)