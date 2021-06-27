------------------------[  Powered By Fatality ]------------------------
local special = { ["SPELL_DAMAGE"] = true, ["SPELL_PERIODIC_DAMAGE"] = true, ["RANGE_DAMAGE"] = true }
local candidates = {}
local history = 1

local UnitInRaid, UnitIsFeignDeath = UnitInRaid, UnitIsFeignDeath
local format, wipe = string.format, wipe

-------------------------[  Created By SnGa  ]--------------------------
local PlayerName, DeathSource 	= "", "";  		-- For the Save and Print
local playerHP, playerOV 		= "", ""; 		-- For Announcement Band
local Tabla_Seleccionada 		= {}; 			-- For Selected Logs 
local numEntries 				= 0;			-- Count of Array Entries

------------------------[  Fatality  Functions  ]-----------------------
function Fatality_Complement( timestamp, event, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, ... ) -- Modified by SnGa
	if not UnitInRaid(destName) then return end
	local spellID, spellName, amount, overkill, environment, crit, crush

	if special[event] then
		spellID, spellName, spellSchool, amount, overkill, _, _, _, _, crit, _, crush = select(9, ...)
	elseif event == "SWING_DAMAGE" then
		amount, overkill, _, _, _, _, crit, _, crush = select(9, ...)
	elseif event == "SPELL_INSTAKILL" then
		spellID = ...
		amount = -1
	elseif event == "ENVIRONMENTAL_DAMAGE" then
		environment, amount, overkill = select(9, ...)
	end
	 
	if amount then
		RecordDamage(srcName, destGUID, destName, spellID, environment, amount, overkill)
	end
	
	if event == "UNIT_DIED" and not UnitIsFeignDeath(destName) then
		ReportDeath(destGUID)
	end
	
end

function ReportDeath( guid ) -- Modified by SnGa
	if not candidates[guid] then return end
		local sName, dName, report, candidate = WebDKP_Language_lua["Others"]["Unknown"][GLanguage], "", "", candidates[guid]
		local id = candidate.destGUID
		local toSay = ""

	if candidate then

		dName, sName, report = FormatOutput(id) 											-- Le doy formato para anunciarlo y guardarlo correctamente

		if PlayerName and PlayerName ~= nil or PlayerName ~= "" then

			Save_Fatality(report) 															-- Guardo la muerte

			if WebDKP_Options_SnGa["FatalityBand"] == 1 then
				toSay = WebDKP_Language_lua["Records"]["FatalityBand"][GLanguage];
				toSay = string.gsub(toSay, "$dName", dName);
				toSay = string.gsub(toSay, "$report", report);
				toSay = string.gsub(toSay, "$sName", sName);
				if playerHP ~= "" then toSay = toSay.." [Hit: "..playerHP.."]" end
				if playerOV ~= "" then toSay = toSay.." [Over: "..playerOV.."]" end

				WebDKP_SendAnnouncement(toSay,"RAID"); 										-- Lo anuncio por banda
			end 
			
		end

		candidates[guid] = nil

	end
end

function FormatOutput( guid ) -- Modified by SnGa
	local e = candidates[guid]
	if not e then return end

	------------[ For Saved ]-------------
	PlayerName = ColorClass(e.destName)														-- Quien murio
	DeathSource = ColorClass(WebDKP_Language_lua["Others"]["Unknown"][GLanguage])
	if e.srcName then
		DeathSource = format("%s", ColorClass(e.srcName)) 									-- Quien o Que lo mato 
	end
	-------------------------------------- 

	local ability = (e.spellID and GetSpellLink(e.spellID)) or e.environment or "Hit Melee" -- Razon de muerte
	
	if e.amount > 0 then 
		local amount = (e.amount - e.overkill) or e.amount
		playerHP = Shorten_FS(amount) or "" 												-- Daño recibido
		playerOV = (e.overkill > 0) and Shorten_FS(e.overkill) or "" 						-- Daño sobrante
	else
		-- SPELL_INSTAKILL
		ability = WebDKP_Language_lua["Records"]["PaladinKill"][GLanguage] -- Paladin
	end

	local source = e.srcName or WebDKP_Language_lua["Others"]["Unknown"][GLanguage]
	return e.destName, source, ability

end

function RecordDamage( srcName, destGUID, destName, spellID, environment, amount, overkill )-- Modified by SnGa
	-- If the table doesn't already exist, create it 										-- Crea la variable que contendra el historial del player
	if not candidates[destGUID] then
		candidates[destGUID] = {} 															
	end

	-- Store the table in a temporary variable												-- Registra todos los datos del evento de daño antes de su muerte
	candidates[destGUID].srcName     = srcName
	candidates[destGUID].destGUID    = destGUID
	candidates[destGUID].destName    = destName
	candidates[destGUID].spellID  	 = spellID
	candidates[destGUID].environment = environment
	candidates[destGUID].amount      = amount
	candidates[destGUID].overkill    = overkill
end

-------------------------[  SnGa  Functions  ]--------------------------
function Save_Fatality( description )
--- Utilizado para guardar las muertes
	local dateTime  = date("%H:%M:%S");
	local CurrentDay = Total_Days_Current();
	tinsert(WebDKP_Fatality_SnGa,{PlayerName, DeathSource, description, dateTime, WebDKP_Options_SnGa["SelectedTableId"], CurrentDay});
end

function Clear_Fatality( boolean )
---	Elimina los registros para la tabla seleccionada.
--- Si boolean es True, elimina todos los registros
	WebDKP_Fatality_SnGa = Eliminando_Registros_FS(WebDKP_Fatality_SnGa, boolean);
	WebDKP_Fatality_UpdateLogTable();
	WebDKP_Print(WebDKP_Language_lua["Records"]["DeleteLog"][GLanguage]);
	wipe(candidates);
end

function Update_Fatality()
--- Actualiza los registros de la ventana de muertes
	WebDKP_Fatality_UpdateLogTable();
	WebDKP_Print(WebDKP_Language_lua["Records"]["UpdateLog"][GLanguage]);
end

function WebDKP_Fatality_UpdateLogTable()
--- Realiza la carga de registros en la ventana de muertes
	Tabla_Seleccionada, numEntries = Separando_Registros_FS(WebDKP_Fatality_SnGa)
	local offset = FauxScrollFrame_GetOffset(WebDKP_FatalityFrameScrollLogFrame);
	FauxScrollFrame_Update(WebDKP_FatalityFrameScrollLogFrame, numEntries, 23, 20);

	for i=1, 23, 1 do
		local line = getglobal("WebDKP_FatalityFrameLine" .. i);
		local awardedText = getglobal("WebDKP_FatalityFrameLine" .. i .. "Awarded");
		local amountText = getglobal("WebDKP_FatalityFrameLine" .. i .. "Amount");
		local reasonText = getglobal("WebDKP_FatalityFrameLine" .. i .. "Reason");
		local dateText = getglobal("WebDKP_FatalityFrameLine" .. i .. "Date");
		local index = i + FauxScrollFrame_GetOffset(WebDKP_FatalityFrameScrollLogFrame);
			
		if ( index <= numEntries) then
			line:Show();
			awardedText:SetText(Tabla_Seleccionada[index][1]);  		-- Nombre
			amountText:SetText(Tabla_Seleccionada[index][2]); 			-- Daño
			reasonText:SetText(Tabla_Seleccionada[index][3]);			-- Descripción
			dateText:SetText(Tabla_Seleccionada[index][4]);				-- Hora
		else
			line:Hide();
		end
	end
end

function WebDKP_Fatality_ScrollLogListToggle()
--- Permite Scrollear por los registros de la ventana de muertes
	WebDKP_Fatality_UpdateLogTable();
	if Tabla_Seleccionada ~= nil then
		
		if _G["AwardedReason"] ~= "" and _G["AwardedDate"] ~= "" then
			Tabla_Seleccionada[_G["AwardedReason"].." ".._G["AwardedDate"]]["selected"] = false;
		end
		if _G["LineLocation"] ~= "" then
			_G["LineLocation"]:SetVertexColor(0, 0, 0, 0);
		end
	end
end

function Penalizacion_Fatality( self )
--- 1) Funcion de Activacion de Secuencia
--- Llama a las funciones necesarias para el descuento
	local playerdate, playerreason = Recopilando_Datos_FS(self);

	if IsShiftKeyDown() then
		WebDKP_Print(string.gsub(WebDKP_Language_lua["Records"]["FatalityReason"][GLanguage], "$playerreason", playerreason));
	else 
		local title = WebDKP_Language_lua["Records"]["FatalityPopUp"][GLanguage];
		title = string.gsub(title, "$playerdate", playerdate);
		title = string.gsub(title, "$playerreason", playerreason);
		Penalizacion_FS(WebDKP_Fatality_ToDiscount, title)
	end
end

-- :)