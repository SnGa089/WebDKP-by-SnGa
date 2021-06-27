-------------------------[  Created By SnGa  ]-------------------------- 
local Tabla_Seleccionada 			= {};						-- Array de registros procesados segun tabla dkp seleccionada					
local Sindra_Record					= {};						-- Array de registros recuperados 
local PlayersM 						= {};						-- Array de Marcas Melee
local PlayersC 						= {};						-- Array de Marcas Caster
local FaseThree 					= {}; 						-- Array de Marcas de Sacudida Mistica
local IntervaloTime 				= 0.05;						-- Intervalo de tiempo entre hits de un contragolpe
local numEntries 					= 0;						-- Cantidad de registros dentro de un array
local autorStacks 					= 0; 						-- Cantidad de Marcas del autor del contragolpe
local playerName 					= nil; 						-- Nombre del jugador
local exploded 						= "";						-- Explotó ( seteable en varios idiomas )
local reached 						= "";						-- Alcanzó ( seteable en varios idiomas )
local killed 						= "";						-- Asesinó ( seteable en varios idiomas )

-------------------------[  SnGa  Functions  ]--------------------------
function Sindra_Complement( timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, SpellID, spellName, spellSchool, amount, overkill )
	if not UnitInRaid(destName) then return end
	if (tostring(UnitIsPlayer(destName)) ~= "nil") then 		-- Es un jugador fisico?
		if (event == "SPELL_AURA_APPLIED") then 				-- Primer Marca
			if (SpellID == 69766) then 							-- Inestabilidad ( Stacks )
				PlayersC[destName] = 1; 					
			elseif (SpellID == 70106) then 						-- Helado hasta los Huesos ( Stacks )
				PlayersM[destName] = 1; 					
			elseif (SpellID == 70127 or SpellID == 72528 or SpellID == 72529 or SpellID == 72530) then -- Sacudida mistica ( Stacks )
				FaseThree[destName] = 1; 					
			end

		elseif (event == "SPELL_AURA_APPLIED_DOSE") then 		-- Mas de una Marca
			if (SpellID == 69766) then 							-- Inestabilidad ( Stacks )
				PlayersC[destName] = overkill; 				
			elseif (SpellID == 70106) then 						-- Helado hasta los Huesos ( Stacks )
				PlayersM[destName] = overkill; 				
			elseif (SpellID == 70127 or SpellID == 72528 or SpellID == 72529 or SpellID == 72530) then -- Sacudida mistica ( Stacks )
				FaseThree[destName] = overkill; 			
			end

		elseif (event == "SPELL_AURA_REMOVED") then 			-- Perdio Marca/s
			if (SpellID == 69766) then  						-- Inestabilidad ( Stacks )
				if (GetInstanceDifficulty() >= 3) then 			-- Heroico
					local StacksT = PlayersC[destName] or 0;
					FaseThree[destName] = FaseThree[destName] or 0;
					-- Heroico	
					Save_Sindra(destName, StacksT, amount, timestamp, FaseThree[destName], "REMOVED");
					playerName, autorStacks = destName, StacksT;
					PlayersC[destName] = nil; 			
				end
			elseif (SpellID == 70106) then 						-- Helado hasta los Huesos( Stacks )
				PlayersM[destName] = nil;  					
			elseif (SpellID == 70127 or SpellID == 72528 or SpellID == 72529 or SpellID == 72530) then -- Sacudida mistica ( Stacks )
				FaseThree[destName] = 0;  					
			end

        elseif (event == "SPELL_DAMAGE") then 
	        	if (SpellID == 69770 or SpellID == 71044 or SpellID == 71045 or SpellID == 71046) then -- Contragolpe
	        		local StacksT = PlayersC[destName] or 0;
	        		FaseThree[destName] = FaseThree[destName] or 0;

	        		if (GetInstanceDifficulty() <= 2) then 
	        			-- En 10/25 Normal, la perdida del debuff no produce un evento distinto, 
	        			-- por lo que hago una falsa perdida del debuff insertando dos veces el mismo registro 
	        			-- pero modificando el primero haciendolo aparentar un "REMOVED" de 25 heroico
	        			Save_Sindra(destName, StacksT, amount, timestamp, FaseThree[destName], "REMOVED");
	    				Save_Sindra(destName, StacksT, amount, timestamp, FaseThree[destName], overkill);
		    		else 
		    			-- Heroico
		    			Save_Sindra(destName, StacksT, amount, timestamp, FaseThree[destName], overkill);
		    		end

	    			if WebDKP_Options_SnGa["SindraBand"] == 1 then 	-- Anunciar Contrgolpes ( Mayores o iguales a 5 Marcas )
	    				local toSay = "";
		    			
		    			if (GetInstanceDifficulty() <= 2) then 	-- ICC25 Normal
				    		PlayersC[destName] = 0;
				    		playerName, autorStacks = destName, StacksT;
							toSay = WebDKP_Language_lua["Records"]["SindraBand_N"][GLanguage];	
		    			else 									-- ICC25 Heroic
							toSay = WebDKP_Language_lua["Records"]["SindraBand_H"][GLanguage];	
		    			end

		    			if playerName == destName and autorStacks >= 5 then
			    			toSay = string.gsub(toSay, "$destName", playerName);
							toSay = string.gsub(toSay, "$Stacks", autorStacks);
							toSay = string.gsub(toSay, "$amount", amount);
			    			WebDKP_SendAnnouncement(toSay,"RAID");
		    			end
		    		end
	    		end

        elseif (event == "SPELL_PERIODIC_DAMAGE") then 
    		if (SpellID == 70106) and (overkill > 0) then 		-- Helado Hasta los Huesos
				local StacksT = PlayersM[destName] or 0;
				FaseThree[destName] = FaseThree[destName] or 0;
    			Save_Sindra(destName, StacksT, amount, timestamp, FaseThree[destName], "SUICIDE");
    			if WebDKP_Options_SnGa["SindraBand"] == 1 then 		-- Anunciar Contrgolpes ( En este caso, Muerte por Debuff Melee )
    				local toSay = WebDKP_Language_lua["Records"]["SindraBand_M"][GLanguage];	
    				toSay = string.gsub(toSay, "$destName", destName);
					toSay = string.gsub(toSay, "$Stacks", StacksT);
					toSay = string.gsub(toSay, "$amount", amount);
    				WebDKP_SendAnnouncement(toSay,"RAID"); 
    			end
    			PlayersM[destName] = nil;
    		end
    	end
    end 
end

function Save_Sindra( name, stacks, dagame, timestamp, buffet, overkill )
--- Utilizado para guardar los contragolpes
	local dateTime  = date("%H:%M:%S");
	tinsert(Sindra_Record,{ColorClass(name),stacks,dagame,timestamp,buffet,tostring(overkill), dateTime});
end

function Clear_Sindra( boolean ) 
---	Elimina los registros para la tabla seleccionada.
--- Si boolean es True, elimina todos los registros
	WebDKP_Sindra_SnGa = Eliminando_Registros_FS(WebDKP_Sindra_SnGa, boolean);
	WebDKP_Sindra_UpdateLogTable()
	WebDKP_Print(WebDKP_Language_lua["Records"]["DeleteLog"][GLanguage])
	Sindra_Record = {};
end

function Update_Sindra()
--- Actualiza los registros de la ventana de Inestabilidad
	WebDKP_Sindra_UpdateLogTable()
	WebDKP_Print(WebDKP_Language_lua["Records"]["UpdateLog"][GLanguage])
end

function Processing_Sindra_Record()
--- Optiene la lista final procesando los datos de los contragolpes optenidos durante el registro.
	if Sindra_Record ~= nil then
		local CurrentDay = Total_Days_Current();
		local Preview_Dead = {};
		local List_Removed, List_Dead = { }, { };
		-- Primero separo a los jugadores que se les removio las marcas y produjieron un contragolpe
		for k, v in pairs(Sindra_Record) do -- v[1]Nombre | v[2]M-F1 | v[3]Daño Realizado/Sufrido | v[4]Timestamp | v[5]M-F3 | v[6]Overkill | v[7]Time
			if tonumber(v[6]) and tonumber(v[6]) > 0 then
				tinsert(Preview_Dead,{v[1],v[4]}) -- Util para despues ;)

			elseif v[6] == "REMOVED" then
				if Preview_Dead ~= nil then
					local temp = false
					for o, p in pairs(Preview_Dead) do --p[1]Nombre | p[2]Timestamp
						local result = v[4] - p[2]
						if p[1] == v[1] and result <= IntervaloTime and result >= 0 then 
							-- Suele pasar que alguien que tenia magia se muere por contragolpe de alguien mas y al morir queda guardado su perdida
							-- del debuff, por lo que no tendria que guardarse ya que no llego a explotar, por lo tanto, es ignorado con este for
							temp = true 
							break		
						end
					end
					if temp == false then
						tinsert(List_Removed,{v[1], 0, v[7], v[4], v[2], v[5], 0, 0});
					end
				else
				tinsert(List_Removed,{v[1], 0, v[7], v[4], v[2], v[5], 0, 0});
				end

			elseif v[6] == "SUICIDE" then 
				tinsert(List_Removed,{v[1], v[3], v[7], v[4], v[2], v[5], 0, "SUICIDE"});
			end
		end

		-- Ahora separo a los jugadores que fueron alcanzados por los contragolpes y / murieron a causa de uno
		for k, v in pairs(Sindra_Record) do -- v[1]Nombre | v[2]M-F1 | v[3]Daño Realizado/Sufrido | v[4]Timestamp | v[5]M-F3 | v[6]Overkill | v[7]Time
			for l, m in pairs(List_Removed) do -- m[1]Nombre | m[2]Daño total | m[3]Time | m[4]Timestamp | m[5]M-F1 | m[6]M-F3 | m[7]Alcanzados | m[8]Muertos
				local result = v[4] - m[4];
				if result <= IntervaloTime and result >= 0 then 	-- Intervalo de tiempo. Descubri que no todos los hits de un contragolpe impactan al mismo tiempo.
					if v[6] ~= "REMOVED" and v[6] ~= "SUICIDE" then -- Salteamos al jugador que produjo el contragolpe en caso de que sea el
						m[2] = m[2] + v[3];
						if v[1] ~= m[1] then
							if v[6] == "0" then -- fue alcanzado por el contragolpe
								m[7] = m[7] + 1;
							else 				-- fue asesinado por el contragolpe
								m[8] = m[8] + 1;
								tinsert(List_Dead,{v[1], v[3], m[1] , v[4], v[2], v[5], v[7]}); 
							end
						elseif v[1] == m[1] and tonumber(v[6]) > 0 then -- se mato solo
							m[8] = m[8] + 1;
							tinsert(List_Dead,{v[1], v[3], m[1] , v[4], v[2], v[5], v[7]}); 
						end
						break
					end
				end
			end
		end

		-- Finalmente ordeno los registros procesados para ser luego presentados ordenadamente en la ventana de Inestabilidad
		local temp, Reason = "", "";
		Load_Labels();
		-- Siempre iran primero los que produjeron un contragolpe 
		for l, m in pairs(List_Removed) do -- m[1]Nombre | m[2]Daño total | m[3]Time | m[4]Timestamp | m[5]M-F1 | m[6]M-F3 | m[7]Alcanzados | m[8]Muertos
			if tostring(m[8]) ~= "SUICIDE" and m[2] > 0 then
				Reason = string.gsub(exploded.." / M-F1: $MF1", "$MF1", m[5])
				-- Control de marcas y alcance
				if m[6] > 0 then -- Tenia Marcas de Fase 3?
					temp = string.gsub("M-F3: $MF3", "$MF3", m[6])
					Reason = Reason.." / "..temp;
					temp = "";
				end
				if m[7] > 0 then -- Cuantos jugadores fueron alcanzados por su contragolpe? Mayor a 1 para no contarse a uno mismo
					temp = string.gsub(reached.." $Players P", "$Players", m[7])
					Reason = Reason.." / "..temp;
					temp = "";
				end
				if m[8] > 0 then -- Cuantos murieron por su contragolpe?
					temp = string.gsub(killed.." $Deads P", "$Deads", m[8])
					Reason = Reason.." / "..temp;
					temp = "";
				end
				-- Agrego a la lista final el responsable del contragolpe
				tinsert(WebDKP_Sindra_SnGa,{m[1], Shorten_FS(m[2]), Reason, m[3], WebDKP_Options_SnGa["SelectedTableId"], CurrentDay});

				-- Compruebo la lista de muertos
				if m[8] > 0 then -- Mato a alguien?
					for a, b in pairs(List_Dead) do --b[1]Nombre | b[2]Daño recibido | b[3]Quien lo mato |  b[4]Timestamp | b[5]M-F1 | b[6]M-F3 | b[7]Time
						local result = b[4] - m[4];
						if result <= IntervaloTime and result >= 0 then -- Su muerte cohincide con el contragolpe de alguien?
							if b[1] == m[1] then
								Reason = WebDKP_Language_lua["Records"]["AutoKill_C"][GLanguage]
							else
								Reason = string.gsub(WebDKP_Language_lua["Records"]["MurderedBy"][GLanguage], "$autor", b[3])
								-- Control de Marcas antes de su muerte
								if b[5] > 0 then -- Tenia Marcas de Fase 1?
									temp = string.gsub("M-F1: $MF1", "$MF1", b[5])
									Reason = Reason.." / "..temp;
									temp = "";
								end
								if b[6] > 0 then -- Tenia Marcas de Fase 3?
									temp = string.gsub("M-F3: $MF3", "$MF3", b[6])
									Reason = Reason.." / "..temp;
									temp = "";
								end
							end
							-- Agrego a la lista final al jugador muerto
							tinsert(WebDKP_Sindra_SnGa,{b[1], Shorten_FS(b[2]), Reason, b[7], WebDKP_Options_SnGa["SelectedTableId"], CurrentDay});
							-- Anulo el timestamp
							--b[4] = 0;
						end
					end
				end
			elseif tostring(m[8]) == "SUICIDE" then -- Murio por Helado hasta los Huesos?
				Reason = WebDKP_Language_lua["Records"]["AutoKill_M"][GLanguage]
				if m[5] > 0 then -- Tenia Marcas de Fase 1?
					temp = string.gsub("M-Melee: $MF1", "$MF1", m[5])
					Reason = Reason.." / "..temp;
					temp = "";
				end
				if m[6] > 0 then -- Tenia Marcas de Fase 3?
					temp = string.gsub("M-F3: $MF3", "$MF3", m[6])
					Reason = Reason.." / "..temp;
					temp = "";
				end
				-- Agrego a la lista final al jugador muerto
				tinsert(WebDKP_Sindra_SnGa,{m[1], Shorten_FS(m[2]), Reason, m[3], WebDKP_Options_SnGa["SelectedTableId"], CurrentDay});
			end
		end
		-- Una todo procesado, limpio la array
		Sindra_Record = {};
	end
end

function WebDKP_Sindra_UpdateLogTable()
--- Realiza la carga de registros en la ventana de Inestabilidad
	Tabla_Seleccionada, numEntries = Separando_Registros_FS(WebDKP_Sindra_SnGa)
	local offset = FauxScrollFrame_GetOffset(WebDKP_SindraFrameScrollLogFrame);
	FauxScrollFrame_Update(WebDKP_SindraFrameScrollLogFrame, numEntries, 23, 20);

	for i=1, 23, 1 do
		local line = getglobal("WebDKP_SindraFrameLine" .. i);
		local awardedText = getglobal("WebDKP_SindraFrameLine" .. i .. "Awarded");
		local amountText = getglobal("WebDKP_SindraFrameLine" .. i .. "Amount");
		local reasonText = getglobal("WebDKP_SindraFrameLine" .. i .. "Reason");
		local dateText = getglobal("WebDKP_SindraFrameLine" .. i .. "Date");
		local index = i + FauxScrollFrame_GetOffset(WebDKP_SindraFrameScrollLogFrame);

		if ( index <= numEntries) then --x[1] = nombre | x[2] = daño total | x[3] = reason | x[4] = hora
			line:Show();
			awardedText:SetText(Tabla_Seleccionada[index][1]);  		-- Nombre
			amountText:SetText(Tabla_Seleccionada[index][2]); 			-- Daño
			reasonText:SetText(Tabla_Seleccionada[index][3]); 			-- Descripción
			dateText:SetText(Tabla_Seleccionada[index][4]); 			-- Hora
		else
			line:Hide();
		end
	end
end

function WebDKP_Sindra_ScrollLogListToggle()
--- Permite Scrollear por los registros de la ventana de Inestabilidad
	WebDKP_Sindra_UpdateLogTable()
	if Tabla_Seleccionada ~= nil then
		
		if _G["AwardedReason"] ~= "" and _G["AwardedDate"] ~= "" then
			Tabla_Seleccionada[_G["AwardedReason"].." ".._G["AwardedDate"]]["selected"] = false;
		end
		if _G["LineLocation"] ~= "" then
			_G["LineLocation"]:SetVertexColor(0, 0, 0, 0);
		end
	end
end

function Penalizacion_Sindra( self )
--- 1) Funcion de Activacion de Secuencia
--- Llama a las funciones necesarias para el descuento
	local playerdate, playerreason = Recopilando_Datos_FS(self);
	Penalizacion_FS(WebDKP_Sindra_ToDiscount, playerdate.." >> "..playerreason.." <<")
end

function Load_Labels()
--- Para no sobrecargar de code en el analisis de la matriz, los renuevo aqui
	exploded = WebDKP_Language_lua["Others"]["Exploded"][GLanguage]
	reached  = WebDKP_Language_lua["Others"]["Reached"][GLanguage]
	killed	 = WebDKP_Language_lua["Others"]["Killed"][GLanguage]
end

-- :)