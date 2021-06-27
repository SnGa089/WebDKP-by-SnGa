------------[ Sistema de Lenguajes agregado por SnGa ]-------------
-- Para que el WebDKP pueda ser utilizado en muchas partes del 
-- mundo, se creo un sistema de idiomas que adaptara el lenguaje
-- del addon al idioma elegido por el portador de manera manual
-- Atención:
-- Puede que todas las traducciones no sean 100% correctas. 
-- Es necesario coordinar con el grupo de developers que diseñaron
-- el complemento para facilitar su traduccion.

------------------------[  Language DropDown  ]-------------------------
function WebDKP_Options_Language_OnLoad()
	UIDropDownMenu_Initialize(WebDKP_GeneralOptions_FrameLanguageDropDown, WebDKP_Options_Language_Init);
end

function WebDKP_Options_Language_Init()
	local info;
	local selected = "";
	WebDKP_LanguageChoice("Español", "SPANISH");
	WebDKP_LanguageChoice("English", "ENGLISH");
	
	UIDropDownMenu_SetWidth(WebDKP_GeneralOptions_FrameLanguageDropDown, 130);
end

function WebDKP_LanguageChoice( text, value )
	info = { };
	info.text = text;
	info.value = value; 
	info.func = LanguageDropDown_OnClick;
	if ( value == WebDKP_Options_SnGa["Language"] ) then
		info.checked = ( 1 == 1 );
		UIDropDownMenu_SetSelectedName(WebDKP_GeneralOptions_FrameLanguageDropDown, info.text );
	end
	UIDropDownMenu_AddButton(info);
end

function LanguageDropDown_OnClick( self )
local this = self;
	WebDKP_Options_SnGa["Language"] = this.value; 
	WebDKP_Options_Language_Init();
	WebDKP_LoadLanguageGUI(WebDKP_Options_SnGa["Language"]);
end

---------------------[  Languages  By SnGa  ]----------------------
WebDKP_Language_lua =	
{
["Others"]	 	 =	{
				["Unknown"] 	 =	{
										["SPANISH"] = "Desconocido",
										["ENGLISH"] = "Unknown",
									},
				["Winner"]		 = {
										["SPANISH"] = "ganador",
										["ENGLISH"] = "winner",
									},
				["Undefined"]	 = 	{
										["SPANISH"] = "Indefinido",
										["ENGLISH"] = "Undefined",
									},
				["Previously"]	 = 	{
										["SPANISH"] = "anteriormente",
										["ENGLISH"] = "previously",
									},
				["NoOne"]		 =	{
										["SPANISH"] = "Nadie",
										["ENGLISH"] = "No one",
									},
				["SomeOne"]		 =	{
										["SPANISH"] = "Alguien",
										["ENGLISH"] = "Someone",
									},
				["Of"]			 =	{
										["SPANISH"] = " de $name!",
										["ENGLISH"] = " of $name!",
									},
				["Stop"]		 =	{
										["SPANISH"] = "Detener",
										["ENGLISH"] = "Stop",
									},
				["Start"]		 =	{
										["SPANISH"] = "Iniciar",
										["ENGLISH"] = "Start",
									},
				["Exploded"]	 =	{
										["SPANISH"] = "Exploto!",
										["ENGLISH"] = "Exploded!",
									},
				["Reached"]		 =	{
										["SPANISH"] = "Alcanzo:",
										["ENGLISH"] = "Reached:",
									},
				["Killed"]		 =	{
										["SPANISH"] = "Asesino:",
										["ENGLISH"] = "Murders:",
									},
				["Won"]			 =	{
										["SPANISH"] = "ha ganado",
										["ENGLISH"] = "has won",
									},
				["Lost"]		 =	{
										["SPANISH"] = "ha perdido",
										["ENGLISH"] = "has lost",
									},
				},

["Announcments"] = {

				["ItemAward"] 	 = 	{
										["SPANISH"] = "Se han descontado $cost dkp por $item al player $player!",
										["ENGLISH"] = "$cost dkp for $item has been discounted to player $player!",
									},

				["DkpAwardAll"]  = 	{
										["SPANISH"] = "$dkp dkp asignados a todos los jugadores por: $reason!",
										["ENGLISH"] = "$dkp dkp assigned to all players by: $reason!",
									},
				["DkpAwardSome"] = 	{
										["SPANISH"] = "$dkp dkp asignados a los jugadores seleccionados por: $reason. \nTodos ellos han sido avisados.",
										["ENGLISH"] = "$dkp dkp assigned to selected players by: $reason. \n All of them have been notified.",
									},
				["BidStart"]	 =	{
										["SPANISH"] = "Item: $item! $time " .. "$startingBid".. "$instructions",
										["ENGLISH"] = "Item: $item! $time " .. "$startingBid".. "$instructions",
									},
				["Winner"]		 =	{
										["SPANISH"] = "$name ha ganado $win con: $dkp dkp!",
										["ENGLISH"] = "$name has won $win with: $dkp dkp!",
									},
				["RollEnd"]		 =	{
										["SPANISH"] = "Roll por $item finalizado!. $name ha ganado con: $roll",
										["ENGLISH"] = "Roll for $item finished!. $name has won with: $roll",
									},
				["TimedAward"]	 = 	{
										["SPANISH"] = "Premio de $dkp dkp otorgados por $minutes Minutos",
										["ENGLISH"] = "Prize of $dkp dkp awarded for $minutes Minutes",
									},
				["BossAwardNum"] =	{
										["SPANISH"] = "Premio de $dkp dkp otorgados por Boss derrotado!",
										["ENGLISH"] = "$dkp dkp prize awarded by defeated Boss!",
									},
				["AuctionEnd"]	 =	{
										["SPANISH"] = "Subasta por $item finalizada!",
										["ENGLISH"] = "Auction for $item finished!",
									},
				["SaleEnd"]		 =	{
										["SPANISH"] = "Venta del $item finalizada!",
										["ENGLISH"] = "Sale of $item finished!",
									},
				["Wisp"]		 = 	{
										["SPANISH"] = "Felicidades! Ganaste: $item! Pídeselo al Masterloot!",
										["ENGLISH"] = "Congratulations! You won: $item! Ask the Masterloot for it!",
									},
				["Assigned"]	 =	{
										["SPANISH"] = "Se te han asignado $dkp dkp.",
										["ENGLISH"] = "You have been assigned $dkp dkp.",
									},
				["Time"]		 = {
										["SPANISH"] = "( $time segundos )",
										["ENGLISH"] = "( $time seconds )",
									},
				["Instructions"] =	{
										["SPANISH"] = "Para ofertar debe tipear !bid <valor> (ejemplo: !bid 50)",
										["ENGLISH"] = "To bid you must type !bid <value> (Example: !bid 50)",
									},
				["StartBidText"] =	{
										["SPANISH"] = "La oferta inicial es de $StartBid dkp's.",
										["ENGLISH"] = "Starting bid is $StartBid dkp's.",
									},
				["StartBidValue"]=	{
										["SPANISH"] = "Sin oferta inicial",
										["ENGLISH"] = "No init bid",
									},
				["RollStart"] 	 =	{
										["SPANISH"] = "Roll por el item $item iniciado!. Tipear /dados para participar.",
										["ENGLISH"] = "Roll by item $item started!. Type /rolls to participate.",
									},
				["TimeRemaining"]=	{
										["SPANISH"] = "Tiempo restante: $time",
										["ENGLISH"]	= "Time remaining: $time",
									},
				["AuctionOld"]	 = 	{
										["SPANISH"] = "El item $item no ha recibido ofertas anteriormente.",
										["ENGLISH"] = "The item $item has not received bids before.",
									},
				["Top3"]		 =	{
										["SPANISH"] = "WebDKP: Ofertas actuales:",
										["ENGLISH"] = "WebDKP: Current bids:",
									},
				["NoneBids"]	 =	{
										["SPANISH"] = "Aun no se han realizado ofertas!",
										["ENGLISH"] = "No bids have been made yet!",
									},
					},

["Autofill"] 	 =	{
				["LootReceived"] =	{
										["SPANISH"] = "([^%s]+) Recibiste el loot: (.+)%.",
										["ENGLISH"] = "([^%s]+) You received the loot: (.+)%.",
									},
				["Question"]	 =	{
										["SPANISH"] = "Entregar a $sPlayer el item $sLink por $cost? \r\n (Ingresar DKP debajo, Solamente Numeros positivos)",
										["ENGLISH"] = "Give to $sPlayer the item $sLink for $cost? \r\n (Enter DKP below, Only positive Numbers)",
									},
					},

["Awards"]		 =	{
				["Decay"]		 =	{
										["SPANISH"] = "WebDKP: El Decay ha sido aplicado.",
										["ENGLISH"] = "WebDKP: The Decay has been applied.",
									},
					},

["Bidding"]		 =	{
				["AuctionTime"]	 =	{
										["SPANISH"] = "$name va ganando con $dkp dkp. La Subasta por $item se cerrara en $time segundos!",
										["ENGLISH"] = "$name is winning with $dkp dkp. Auction for $item will close in $time seconds!",
									},
				["SaleTime"]	 =	{
										["SPANISH"] = "$name va ganando con $dkp dkp. La Venta del $item se cerrara en $time segundos!",
										["ENGLISH"] = "$name is winning with $dkp dkp. The Sale of $item will close in $time seconds!",
									},
				["BidReceived"]	 =	{
										["SPANISH"] = "Ya realizaste una oferta por $item, ahora es cuestión de Roll entre los participantes.",
										["ENGLISH"] = "You already made a bid for $item, now it is a matter of Roll among the participants.",
									},
				["AuctionSec"]	 =	{
										["SPANISH"] = "Ultimos $time segundos para ofertar por $item!",
										["ENGLISH"] = "Last $time seconds to bid for $item!",
									},
				["RollTime"]	 =	{
										["SPANISH"] = "El roll mas alto es de $name con $roll. $time segundos para rollear por $item.",
										["ENGLISH"] = "The highest roll is of $name with $roll. $Time seconds to roll for $item.",
									},
				["EndAuction"]	 =	{
										["SPANISH"] = "Finalizar Subasta!",
										["ENGLISH"] = "End Auction!",
									},
				["EndSale"]		 =	{
										["SPANISH"] = "Finalizar Venta!",
										["ENGLISH"] = "End Sale!",
									},
				["StartAuction"] =	{
										["SPANISH"] = "Iniciar Subasta!",
										["ENGLISH"] = "Start Auction!",
									},
				["StartSale"]	 =	{
										["SPANISH"] = "Iniciar Venta!",
										["ENGLISH"] = "Start Sale!",
									},
				["EndRoll"]		 =	{
										["SPANISH"] = "Finalizar Roll!",
										["ENGLISH"] = "Finish Roll!",
									},
				["StartRoll"] 	 =	{
										["SPANISH"] = "Iniciar Roll!",
										["ENGLISH"] = "Start Roll!",
									},
				["OpenAuction"]	 =	{
										["SPANISH"] = "Subasta por $item Iniciada!\nInteresados bidear por",
										["ENGLISH"] = "Auction for $item Started!\nInterested bidding for",
									},
				["OpenSale"]	 =	{
										["SPANISH"] = "Venta del $item Iniciada!\nInteresados bidear por",
										["ENGLISH"] = "Sale for $item Started!\nInterested bidding for",
									},
				["ReopenedAuct"] =	{
										["SPANISH"] = "Subasta por $item Reabierta!\nInteresados bidear por",
										["ENGLISH"] = "Auction for $item Reopened!\nInterested bid for",
									},
				["ReopenedSale"] =	{
										["SPANISH"] = "Venta del $item Reabierta!\nInteresados bidear por",
										["ENGLISH"] = "Sale for $item Reopened!\nInterested bid for",
									},
				["AuctSelect"]	 =	{
										["SPANISH"] = "Debes seleccionar un item para iniciar una Subasta.",
										["ENGLISH"] = "You must select an item to start an Auction.",
									},
				["SaleSelect"]	 =	{
										["SPANISH"] = "Debes seleccionar un item para iniciar una Venta.",
										["ENGLISH"] = "You must select an item to start an Sale.",
									},
				["Insufficient"] =	{
										["SPANISH"] = "Oferta rechazada, no cuentas con los dkp suficientes! Tu maxima oferta es de $dkp dkp.",
										["ENGLISH"] = "Bid rejected, you do not have enough dkp! Your maximum bid is $dkp dkp.",
									},
				["NoAuction"]	 =	{
										["SPANISH"] = "No hay ninguna subasta en proceso.",
										["ENGLISH"] = "There is no auction in process.",
									},
				["NoSale"]		 =	{
										["SPANISH"] = "No hay ninguna venta de item en proceso.",
										["ENGLISH"] = "There is no item sale in process.",
									},
				["NoPJ"]		 =	{
										["SPANISH"] = "Pj no selecionado, primero seleccione uno!",
										["ENGLISH"] = "Pj not selected, first select one!",
									},
				["AssignPJ"]	 =	{
										["SPANISH"] = "Asignar $link a $player por $bid dkp?",
										["ENGLISH"] = "Assign $link to $player for $bid dkp?",
									},
				["AlertRoll"]	 =	{
										["SPANISH"] = "Roll por $item Iniciado!",
										["ENGLISH"] = "Roll for $item Started!",
									},
				["NoNumber"]	 =	{
										["SPANISH"] = "Oferta rechazada, Debes utilizar !bid seguido de un monto numerico que deseas ofertar.",
										["ENGLISH"] = "Bid rejected, You must use !Bid followed by a numerical amount you wish to bid.",
									},
				["MinimumBid"]	 =	{
										["SPANISH"] = "Oferta rechazada, el minimo actual es de $amount dkp",
										["ENGLISH"] = "Bid rejected, the current minimum is $amount dkp",
									},
				["NotNecessary"] =	{
										["SPANISH"] = "Vas ganando, no es necesario superar tu oferta anterior de $dkp dkp.",
										["ENGLISH"] = "You are winning, it is not necessary to beat your previous bid of $dkp dkp.",
 									},
 				["GreatOrEqual"] =	{
 										["SPANISH"] = "Oferta rechazada, debe ser igual o mayor a $dkp dkp.",
 										["ENGLISH"] = "Bid rejected, must be equal to or greater than $dkp dkp.",
 									},
 				["BidAcepted"]	 =	{
 										["SPANISH"] = "$cmd dkps aceptados!",
 										["ENGLISH"] = "$cmd dkps accepted!",
 									},
 				["Notify"]		 =	{
 										["SPANISH"] = "superado tu oferta! Para seguir debes ofertar minimo $dkp dkp.",
 										["ENGLISH"] = "exceeded your bid! To continue you must bid at least $dkp dkp.",
 									},
 				["Attention"]	 =	{
 										["SPANISH"] = "Atencion! $name ha ",
 										["ENGLISH"]	= "Attention! $name has ",
 									},
 				["Anonymus"]	 =	{
 										["SPANISH"] = "Atencion! han ",
 										["ENGLISH"] = "Attention! someone has ",
 									},
 				["BidAll"]		 =	{
 										["SPANISH"] = "$name ha ofertado todo por $item!",
 										["ENGLISH"] = "$name has bid all for $item!",
 									},
					},

["Help"]		 =	{
				["Welcome"]		 =	{
										["SPANISH"] = "Bienvenido",
										["ENGLISH"] = "Welcome",
									},
				["Text_1"]		 =	{
										["SPANISH"]	= "|cFFFF0000Bienvenido a WebDKP|r"..
													  "|n|n"..
													  "Este AddOn está destinado a facilitar la tarea de administrar DKP mediante la automatización de muchas de las tareas administrativas. Facilita tanto la visualización como la realización de cambios en los DKP de tu Raid. Los cambios realizados en el juego se pueden sincronizar con el sitio web oficial utilizando la herramienta de sincronización incluida o cargando su archivo de registro desde el centro de control del sitio web."..
													  "|n|n"..
													  "Este documento de ayuda se proporcionará para guiarlo a través del uso básico y más avanzado del AddOn. Si es la primera vez que lo usa, puede encontrar un tutorial útil en el archivo zip de WebDKP. Si tiene preguntas adicionales que no se tratan en este documento, o tiene sugerencias, utilice uno de los foros en www.webdkp.com o www.dkptracker.com."..
													  "|n|n"..
													  "|cFFFF0000Agradecimientos especiales a:|r"..
													  "|n|n"..
													  "Quartal, Xenosian, Agard, Zevious, Zedd y SnGa",

										["ENGLISH"] = "|cFFFF0000Welcome to WebDKP|r"..
													  "|n|n"..
													  "This AddOn is intended to ease the task of managing DKP by automating many of the administrative tasks. It makes it easy to view and make changes to your Raid's DKPs. Changes made to the game can be synced to the official website using the included sync tool or by uploading your log file from the website's control center."..
													  "|n|n"..
													  "This help document is provided to guide you through the basic and more advanced use of the AddOn. If you are using it for the first time, you can find a useful tutorial in the WebDKP zip file. If you have additional questions not covered in this document, or have suggestions, please use one of the forums at www.webdkp.com or www.dkptracker.com."..
													  "|n|n"..
													  "|cFFFF0000Special thanks to:|r"..
													  "|n|n"..
													  "Quartal, Xenosian, Agard, Zevious, Zedd y SnGa",
									},
				["GeneralUse"]	 =	{
										["SPANISH"] = "Uso General",
										["ENGLISH"] = "General Use",
									},
				["Text_2"]		 =	{
										["SPANISH"] = "|cFFFF0000Uso General:|r"..
													  "|n|n"..
													  "Se puede acceder a la mayoría de las funciones del complemento seleccionando |cFFFF0000DKP Table|r en el menú desplegable principal (fuera del minimapa)."..
													  "|n|n"..
													  "Al hacer clic en esto, se mostrará la lista principal de DKP a la izquierda y una ventana con un conjunto de pestañas a la derecha. Si es la primera vez que usa el AddOn, la lista de la izquierda probablemente estará vacía. Eso es porque la lista está predeterminada para mostrar solo a las personas que están en su grupo actual. Si te unieras a un grupo o una raid, verías que la lista comenzaba a llenarse de personas."..
													  "|n|n"..
													  "En las opciones de la derecha podra encontrar todas las funciones principales disponibles. Esta área tiene 4 pestañas accesibles con las que puede trabajar: Filters, Assign DKP, Item Sales y Raid Status."..
													  "|n|n"..
													  "La pestaña |cFFFF0000Filters|r le permitirá filtrar lo que desea que se muestre en su tabla DKP. Puede limitar la tabla a determinadas clases, lo que facilita la búsqueda de las personas que desee. Aquí también tiene la opción de mostrar a todas las personas en su tabla, incluidas las que no están en su grupo actual, desmarcando 'Solo players en mi grupo actual'. Aun asi, si lo prefiere, puede buscar a los jugadores por nombre."..
													  "|n|n"..
													  "La pestaña |cFFFF0000Assign DKP|r cuenta con 3 opciones:"..
													  "|n"..
													  "|cFFFF0000Asignar DKP|r le permitirá asignar DKP a los jugadores. Tenga en cuenta que esto solo se usa para otorgar DKP unicamente, no para asignar items. Para otorgar DKP, todo lo que necesita hacer es seleccionar a las personas que desea otorgar desde la izquierda, ingresar un motivo y un número de puntos a otorgar, luego hacer click en 'Asignar DKP'."..
													  "|n"..
													  "|cFFFF0000DKP Decay|r le permitirá ingresar un valor para multiplicar el DKP de las personas por un X porcentaje. Ingresar un valor de .4 RESTARÍA el 40% del DKP de los que tengan DKP positivo. Ingresar un valor de -.4 AGREGARÍA el 40% del DKP SOLO si tienen DKP negativo."..
													  "|n"..
													  "|cFFFF0000DKP Casino|r permitira que los jugadores puedan apostar un cierto monto de DKPs utilizando los comandos !casino + monto y luego tipear /dados para intentar multiplicarlos. En caso de arrepentirse, puede tipear !cancelar para anular la apuesta."..
													  "|n|n"..
													  "La pestaña |cFFFF0000Item Sales|r cuenta con 2 opciones:"..
													  "|n"..
													  "|cFFFF0000Venta de Items|r transformará la subasta de items en un sistema de ventas, si tienes activo en la pagina oficial la Tabla de Botin, tomara los precios para los items desde ella. Sino, puedes establecer manualmente los precios para los items dependiendo de su nivel y/o tipo de item."..	  
													  "|n"..
													  "|cFFFF0000Asignar Item a un jugador|r le permitirá otorgar un artículo a un solo jugador. Para usarlo, seleccione un jugador en la tabla, el articulo a asignar (También puede completar el nombre del elemento presionando Shift + haciendo clic en el item o en el nombre de un elemento en el chat) y un costo para dicho item (en números positivos) y luego seleccione 'Asignar Item'."..
													  "|n|n"..
													  "La pestaña |cFFFF0000Raid Status|r cuenta con 2 opciones:"..
													  "|n"..
													  "|cFFFF0000Estado de la Raid|r le permitira llevar un seguimiento de asistencias de jugadores por Raid iniciada. Estos datos se almacenan en dos lugares diferentes, uno para las Raids Guardadas y otro para las Asistencias de los jugadores que participaron en dichas raids. puede iniciar una raid y cambiar a otro personaje de la misma cuenta sin mayor inconveniente."..
													  "|n"..
													  "|cFFFF0000Jugadores en Espera|r le permitira crear una lista de jugadores en espera, en el caso de estar completa la Raid, para despues filtrarlos en la tabla, y a su vez, otorgarles DKPs, si asi lo desea. Estos jugadores podran agregarse o elmininarse de dicha lista con los comandos '!standby add' y '!standby del' respectivamente.",

										["ENGLISH"] = "|cFFFF0000General Use:|r"..
													  "|n|n"..
													  "Most of the plugin's functions can be accessed by selecting |cFFFF0000DKP Table|r from the main drop-down menu (outside the minimap)."..
													  "|n|n"..
													  "Clicking on this will bring up the main DKP list on the left and a window with a set of tabs on the right. If this is your first time using the AddOn, the list on the left will probably be empty. That's because the list is defaulted to show only people who are in your current group. If you joined a group or a raid, you would see that the list began to fill with people."..
													  "|n|n"..
													  "In the options on the right you can find all the main functions available. This area has 4 accessible tabs that you can work with: Filters, Assign DKP, Item Sales, and Raid Status."..
													  "|n|n"..
													  "The |cFFFF0000Filters|r tab will allow you to filter what you want to display in your DKP table. You can limit the table to certain classes, making it easy to find the people you want. Here you also have the option to show all the people in your table, including those who are not in your current group, by unchecking 'Only players in my current group'. Still, if you prefer, you can search for players by name."..
													  "|n|n"..
													  "The |cFFFF0000Assign DKP|r tab has 3 options:"..
													  "|n"..
													  "|cFFFF0000Assign DKP|r will allow you to assign DKP to players. Note that this is only used to grant DKP only, not to assign items. To award DKP, all you need to do is select the people you want to award from the left, enter a reason and a number of points to award, then click 'Assign DKP'."..
													  "|n"..
													  "|cFFFF0000DKP Decay|r will allow you to enter a value to multiply people's DKP by X percent. Entering a value of .4 WOULD SUBTRACT 40% of the DKP from those with positive DKP. Entering a value of -.4 WOULD ADD 40% of the DKP ONLY if they have negative DKP."..
													  "|n"..
													  "|cFFFF0000DKP Casino|r will allow players to bet a certain amount of DKPs using the !casino + amount commands and then type /roll to try to double them. In case of regret, you can type !cancel to void the bet."..
													  "|n|n"..
													  "The |cFFFF0000Item Sales|r tab has 2 options:"..
													  "|n"..
													  "| cFFFF0000Item Sales|r will transform the Auction of items into a Sales system, if you have the Loot Table active on the official page, it will take the prices for the items from it. If not, you can manually set the prices for the items depending on their level and/or item type."..	  
													  "|n"..
													  "|cFFFF0000Assign item to a Player|r will allow you to award an item to a single player. To use it, select a player in the table, the item to assign (You can also fill in the item name by pressing Shift + clicking on the item or on the name of an item in the chat) and a cost for that item (in numbers positive) and then select 'Assign Item'."..
													  "|n|n"..
													  "The |cFFFF0000Raid Status|r tab has 2 options:"..
													  "|n"..
													  "|cFFFF0000Raid Status|r will allow you to track player assists per Raid started. This data is stored in two different places, one for the Saved Raids and one for the Assists of the players who participated in those raids. You can start a raid and switch to another character on the same account without any major inconvenience."..
													  "|n"..
													  "|cFFFF0000Standby Players|r will allow you to create a list of standby players, if the Raid is complete, and then filter them in the table, and in turn, grant them DKPs, if you wish. These players can be added or removed from the list with the commands '!standby add' and '!standby del' respectively.",
									},
				["GeneralOptions"]=	{
										["SPANISH"] = "Opciones Generales",
										["ENGLISH"] = "General Options",
									},
				["Text_3"]		 =	{
										["SPANISH"] = "|cFFFF0000Opciones Generales|r"..
													  "|n|n"..
													  "WebDKP tiene una variedad de opciones que le permiten ajustarlo a las necesidades de su raid. La ventana de opciones se puede encontrar haciendo clic en 'Options' en el mini mapa desplegable.".. 
													  "|n|n"..
													  "|cFFFF0000Autocompletar info. del Item desde el Drop|r: Cuando está habilitado, WebDKP monitoreará su ventana de chat para detectar cualquier anuncio de personas que reciban artículos (por ejemplo: Kuruk recibió [Crown of Destruction]). Cuando los detecte, seleccionará automáticamente al jugador receptor en la tabla y completará el cuadro del nombre del elemento en la pestaña Award Item."..
													  "|n|n"..
													  "|cFFFF0000Limite / Rango|r: Establece el nivel del elemento que el AutoFill tomará. Por ejemplo, cuestionese si ¿debería rellenar automáticamente la información de los elementos azules o mejor, o también debería incluir elementos verdes?"..
													  "|n|n"..
													  "|cFFFF0000Registro de Inestabilidad ( Sindra )|r: Permite activar o desactivar el sistema de registros de los debuff de Sindragosa ( para mas informacion, dirigirse a seccion 'Registros Agregados' )."..
													  "|n|n"..
													  "|cFFFF0000Anunciar Contragolpes|r: Permite activar o desactivar los anuncios de contragolpe de los Casters por banda. ( Se requiere como minimo que el Caster que produjo el contragolpe lo haya hecho con al menos 5 marcas de Inestabilidad )"..
													  "|n|n"..
													  "|cFFFF0000Registro de Muertes ( Fatality )|r: Permite activar o desactivar el sistema de registros de muertes durante toda la instancia ( para mas informacion, dirigirse a seccion 'Registros Agregados' )."..
													  "|n|n"..
													  "|cFFFF0000Anunciar Muertes|r: Permite activar o desactivar los anuncios de las muertes de los jugadores por banda."..
													  "|n|n"..
													  "|cFFFF0000Award auto. por Boss eliminado|r: Al activarlo, en el cuadro de texto podra especificar cuánto dkp se otorga automáticamente por cada muerte de un Boss. Puede activarlo de manera independiente tanto para instancias de 10 como de 25 personas."..
													  "|n|n"..
													  "|cFFFF0000Borrado Automatico de Registros|r: Permite activar o desactivar el auto borrado de los registros de Inestabilidad y de Muertes. Al activarlo, puede fijar el numero maximo de dias que durara el registro antes de eliminarse. Si esta activado, pero se deja la cantidad de dias en cero, no borrara los registros, ya que se requiere un numero de dias valido para hacerlo."..
													  "|n|n"..
													  "|cFFFF0000Especificar un DKP Cap|r: Permite activar o desactivar el limite de dkps que puede alcanzar los jugadores. Una vez que se llega a la cifra establecida por usted, los jugadores que ya hayan llegado a este limite dejaran de recibir dkps de los futuros Adward hasta que su acumulado baje. ya sea por gastar en un item o por penalizaciones y/o sanciones.",

										["ENGLISH"] = "|cFFFF0000General Options|r"..
													  "|n|n"..
													  "WebDKP has a variety of options that allow you to adjust it to the needs of your raid. The options window can be found by clicking on 'Options' on the drop down mini map.".. 
													  "|n|n"..
													  "|cFFFF0000Autofill Item Details From Drops|r: When enabled, WebDKP will monitor your chat window for any announcements from people receiving items (for example: Kuruk received [Crown of Destruction]). When detected, it will automatically select the receiving player from the table and fill in the item name box on the Award Item tab."..
													  "|n|n"..
													  "|cFFFF0000Limit / Range|r: Sets the level of the element that the AutoFill will take. For example, ask yourself whether you should automatically fill in the information for blue items or better, or should you also include green items?"..
													  "|n|n"..
													  "|cFFFF0000Instability Record (Sindra)|r: Allows you to activate or deactivate the Sindragosa debuff record system (for more information, go to the 'Added Records' section)."..
													  "|n|n"..
													  "|cFFFF0000Announce Backlash|r: Allows you to enable or disable backlash announcements for casters per band. (It is required as a minimum that the Caster that produced the backlash has done so with at least 5 marks of Instability)"..
													  "|n|n"..
													  "|cFFFF0000 Fatality Record|r: Allows you to activate or deactivate the death record system during the entire instance (for more information, go to the 'Added Records' section)."..
													  "|n|n"..
													  "|cFFFF0000Announce Deaths|r: Allows you to activate or deactivate the announcements of the deaths of the players by raid."..
													  "|n|n"..
													  "|cFFFF0000Award auto. by Kill Boss|r: When activated, in the text box you can specify how much dkp is automatically awarded for each boss death. You can activate it independently for both 10 and 25 person instances."..
													  "|n|n"..
													  "|cFFFF0000Automatic Deletion of Records|r: It allows activating or deactivating the automatic deletion of Instability and Death records. By activating it, you can set the maximum number of days the record will last before being deleted. If it is activated, but the number of days is left at zero, it will not delete the records, since a valid number of days is required to do so."..
													  "|n|n"..
													  "|cFFFF0000Specify a DKP Cap|r: Allows you to enable or disable the limit of dkps that players can reach. Once the figure set by you is reached, players who have already reached this limit will stop receiving dkps from future Adward until their accumulated drop. either for spending on an item or for penalties and/or sanctions.",
									},
				["Events&Bids"]	 =	{
										["SPANISH"] = "Eventos y Ofertas",
										["ENGLISH"] = "Events and Bids",
									},
				["Text_4"]		 =	{
										["SPANISH"] = "|cFFFF0000Eventos y Ofertas: Opciones|r"..
													  "|n|n"..
													  "|cFFFF0000Anunciar por Alerta de Banda|r: Realiza los anuncios mas importantes a traves de alertas de banda, ya sea el inicio de un evento, su finalizacion, su reapertura y en el caso de que alguien utilice el comando !bidall tambien lo anunciara."..
													  "|n|n"..
													  "|cFFFF0000Activar Ventana de Confirm.|r: Cuando esté a punto de adjudicar un artículo a un postor ganador, se mostrará un cuadro de diálogo que le permitirá personalizar lo que el jugador está pagando por el artículo, ya sea aumentando manualmente la cantidad ofrecida o bien multiplicarla por un numero especifico."..
													  "|n|n"..
													  "|cFFFF0000Permitir Ofertas Negativas|r: Permite a los jugadores ofrecer más DKP del que tienen actualmente. El ganador quedaria con puntos DKP negativos."..
													  "|n|n"..
													  "|cFFFF0000Notificar Oferta Superada|r: (Solo para Subastas) Al activar esta opcion, se le notificara a traves de un mensaje privado al anterior apostador que su oferta fue superada y cuanto debe ofertar si quiere superar a la nueva."..
													  "|n|n"..
													  "|cFFFF0000Activar Ofertas por Banda|r: Permite seleccionar el canal por el cual usted recibira las ofertas de los apostadores, ya que puede recibir por mensaje privado, o bien, por mensaje de banda. "..
													  "|n|n"..
													  "|cFFFF0000Auto Entregar Items Finalizados|r: Se requiere acceso al botin del Boss. Al activarlo, automaticamente al cerrar un evento, el item sera entregado al jugador ganador desde el Loot siempre y cuando se tenga los privilegios para realizar dicha accion. Tenga preacucion con su uso."..
													  "|n|n"..
													  "|cFFFF0000Activar Ofertas Anonimas|r: Permite ocultar toda informacion sobre los apostadores a la hora de hacer el seguimiento de un evento. Solo se podra visualizar las ofertas realizadas y las entregas de items pero sin informacion del postor."..
													  "|n|n"..
													  "|cFFFF0000Eventos Silenciosos|r: Al activar, oculta toda informacion relacionada al evento, es decir, no anuncia ni apertura ni cierre, ni ofertas aceptadas ni entrega de items, aun asi, los apostadores estaran al tanto del evento por medio de mensajes privados."..
													  "|n|n"..
													  "|cFFFF0000Capturar Rolls en Eventos|r: Permite capturar los '/rolls' o '/dados' independientemente de los !bid realizados y agregarlos a la lista de ofertas de un evento."..
													  "|n|n"..
													  "|cFFFF0000Activar Porcentaje entre !bid|r: (Solo para Subastas) Al activarlo, obliga a los apostadores a realizar una suba minima para poder apostar ante una oferta anterior. Esta diferencia se calcula en base a un porcentaje sobre la oferta anterior. Por ejemplo, si el !bid anterior era 1000 y el porcentaje esta fijado en 10%, para subir la apuesta debera ofertar 1000 + 10% = 1100dkp (Los '!bidall' no respetan este porcentaje)."..
													  "|n|n"..
													  "|cFFFF0000Fijar Coste por Defecto F/S|r: Al activar, permite fijar un precio personalizado para los descuentos realizados en las ventanas de los registros de Muertes y de Inestabilidad. Si la opcion esta desactivada, utiliza como precio por defecto el numero que se establecio como 'Starting Bid' de la ventana 'Bidding'."..
													  "|n|n"..
													  "|cFFFF0000Activar !bid Automatico|r: (Solo para Subastas) Si se desactiva, el comando para apostar '!bid' debera ir siempre acompañado de un numero que represente la oferta. Por el contrario, al activarlo, se podra utilizar el comando '!bid' sin monto dkp a partir de una oferta preestablecida. Al utilizar el '!bid' sin oferta, el AddOn automaticamente tomara el siguiente monto minimo a ofertar y ofertará por el apostador siempre y cuando este cuente con los dkps sufientes para realizarla.",

										["ENGLISH"] = "|cFFFF0000Events and Bids: Options|r"..
													  "|n|n"..
													  "|cFFFF0000Announce by Band Alert|r: Make the most important announcements through band alerts, be it the start of an event, its end, its reopening and in the event that someone uses the !bidall command, it will also announce it."..
													  "|n|n"..
													  "|cFFFF0000Enable Confirmation Window|r: When you are about to award an item to a winning bidder, a dialog box will be displayed allowing you to customize what the player is paying for the item, either by manually increasing the bid amount or by multiply it by a specific number."..
													  "|n|n"..
													  "|cFFFF0000Allow Negative Bids|r: Allows players to bid more DKP than they currently have. The winner would be left with negative DKP points."..
													  "|n|n"..
													  "|cFFFF0000Notify Bid Exceeded|r: (Only for Auctions) By activating this option, the previous bettor will be notified through a private message that his bid was exceeded and how much he must bid if he wants to exceed the new one."..
													  "|n|n"..
													  "|cFFFF0000Enable Bids by Band|r: Allows you to select the channel through which you will receive bids from bettors, since you can receive by private message, or by band message."..
													  "|n|n"..
													  "|cFFFF0000Auto Give Finished Items|r: Access to Boss loot is required. When activated, automatically when closing an event, the item will be delivered to the winning player from the Loot as long as they have the privileges to perform said action. Be careful with its use."..
													  "|n|n"..
													  "|cFFFF0000Enable Anonymous Bids|r: Allows you to hide all information about bettors when monitoring an event. You will only be able to view the bids made and the deliveries of items but without information about the bidder."..
													  "|n|n"..
													  "|cFFFF0000Silent Events|r: When activating, it hides all information related to the event, that is, it does not announce neither opening nor closing, nor accepted bids nor delivery of items, even so, bettors will be aware of the event through messages private."..
													  "|n|n"..
													  "|cFFFF0000Capture Rolls in Events|r: Allows you to capture the '/rolls' or '/dados' independently of the !bids made and add them to the list of bids of an event."..
													  "|n|n"..
													  "|cFFFF0000Enable Percentage between !bid|r: (Only for Auctions) When activated, it forces bettors to make a minimum raise to be able to bet on a previous bid. This difference is calculated based on a percentage of the previous bid. For example, if the previous !Bid was 1000 and the percentage is set at 10%, to raise the bet you would have to bid 1000 + 10% = 1100dkp (The '!Bidall' do not respect this percentage)."..
													  "|n|n"..
													  "|cFFFF0000Set Default Cost F/S|r: When activated, it allows setting a custom price for the discounts made in the Deaths and Instability registers windows. If the option is disabled, it uses as default price the number that was established as 'Starting Bid' in the 'Bidding' window."..
													  "|n|n"..
													  "|cFFFF0000Enable Automatic !bid|r: (Only for Auctions) If disabled, the command to bet '!bid' must always be accompanied by a number that represents the bid. On the contrary, when activating it, the command '!bid' can be used without a dkp amount from a pre-established bid. When using the '!bid' without bid, the AddOn will automatically take the next minimum amount to bid and will bid for the bettor as long as he has the sufficient dkps to do it.",
									},
				["Bidding&Wisper"]=	{
										["SPANISH"] = "Bidding y Wisper",
										["ENGLISH"] = "Bidding and Wisper",
									},
				["Text_5"]		 =	{
										["SPANISH"] = "|cFFFF0000Whisper DKP|r"..
													  "|n|n"..
													  "Whisper DKP es una función que permite a las personas enviarle susurros para ver su monto DKP actual, entre otras cosas. Lo bueno de esta función es que los susurros entrantes y salientes relacionados con Whisper DKP están ocultos para usted, por lo que su cuadro de chat no estará lleno. "..
													  "|n|n"..
													  "Para usar dicha función, cualquiera puede y solo necesita susurrarle uno de los siguientes comandos:"..
													  "|n|n"..
													  "|cFFFF0000!dkp|r - Devuelve al usuario la cantidad de dkps con la que cuenta actualmente.|n|n"..
													  "|cFFFF0000!actual|r - Devuelve al usuario el estado del item actual en subasta/venta (en caso de haber una) y todo lo relacionado a el.|n|n"..
													  "|cFFFF0000!anterior|r - Devuelve al usuario ganador del anterior item ( si es que hubo un previo evento ) y el monto apostado por el mismo.|n|n"..
													  "|cFFFF0000!ayuda|r - Devuelve una lista de comandos disponibles al jugador que consulto, con una breve explicacion de la utilidad de cada uno.|n|n"..
													  "|cFFFF0000!asistencia|r - Devuelve al usuario la cantidad de raids a las que asistio y el porcentaje realizado de el en dichas raids.|n|n"..
													  "|cFFFF0000!casino # / !casinoall|r - Permite apostar DKP en el casino por /wisp o por /banda. El # representa el monto numerico a apostar.|n|n"..
													  "|cFFFF0000!cancelar|r - Permite cancelar una apuesta del casino al jugador, si este tubiese una.|n"..
													  "|n|n"..
													  "|cFFFF0000Bidding|r"..
													  "|n|n"..
													  "Al iniciar un Evento (Subasta o Venta), los jugadores en su grupo pueden escribir por /wisp o por /banda cuántos puntos dkp quieren/deben ofertar por un item y el AddOn recogerá esta información automaticamente y se la mostrará en la misma ventana. Una vez finalizado el evento, puede seleccionar al jugador ganador y hacer click en 'Asignar Item al Jugador'. La informacion de este evento sera registrado automáticamente en su tabla DKP."..
													  "|n|n"..
													  "Para iniciar un evento dirijase a la ventana Bidding, luego puede ingresar el nombre del artículo a subastar/vender, el cual puede autorrellenar hanciendo la combinacion Alt+Click izquierdo sobre un item, luego, si asi lo desea, puede agregar un tiempo opcional en segundos para la duración de la misma. (Ingresar 0 aquí significa que no habrá límite de tiempo). Haga clic en 'Iniciar Subasta/Venta!' para iniciar."..
													  "|n|n"..
													  "Los jugadores pueden realizar ofertas mediante un mensaje de banda o un susurrar con los siguientes comandos:|n|n"..
													  "|cFFFF0000!bid #|r - Donde # representa la oferta en dkp que el jugador quiere realizar (Por ejemplo: !bid 20)"..
													  "|n|n"..
													  "|cFFFF0000!bid (automatico)|r - Despues de que alguien realice una oferta con el minimo monto requerido para activar el !bid automatico, los jugadores pueden apostar con el monto minimo siguiente solamente utilizando el comando '!bid' sin oferta."..
													  "|n|n"..
													  "|cFFFF0000!bidall|r - Al utilizar este comando, y si el jugador cuenta con la cantidad necesaria para subir el precio del item, el AddOn tomara todos sus puntos dkp y los ofertara por el item que se encuentre subastandose en ese momento."..
													  "|n|n"..
													  "Si utiliza el Sistema de Ventas, cualquiera de los tres comandos realizaran la misma acción, es decir, tomaran la oferta del jugador y se la mostraran en la ventana con el precio del item.",

										["ENGLISH"] = "|cFFFF0000Whisper DKP|r"..
													  "|n|n"..
													  "Whisper DKP is a feature that allows people to whisper to you to see their current DKP amount, among other things. The great thing about this feature is that the incoming and outgoing whispers related to Whisper DKP are hidden from you, so your chat box will not be cluttered."..
													  "|n|n"..
													  "To use such a feature, anyone can and only needs to whisper one of the following commands to it:"..
													  "|n|n"..
													  "|cFFFF0000!dkp|r - Returns the current amount of dkps to the user.|n|n"..
													  "|cFFFF0000!current|r - Returns to the user the status of the current item in auction/sale (if there is one) and everything related to it.|n|n"..
													  "|cFFFF0000!previous|r - Returns the winning user of the previous item (if there was a previous event) and the amount bet on it.|n|n"..
													  "|cFFFF0000!helpme|r - Returns a list of commands available to the player I consult, with a brief explanation of the usefulness of each.|n|n"..
													  "|cFFFF0000!attendance|r - Returns to the user the number of raids they attended and the percentage of them completed in those raids.|n|n"..
													  "|cFFFF0000!casino # / !casinoall|r - Allows to bet DKP in the casino by /wisp or by /raid. The # represents the numerical amount to bet.|n|n"..
													  "|cFFFF0000!cancel|r - Allows the player to cancel a casino bet, if he had one.|n"..
													  "|n|n"..
													  "|cFFFF0000Bidding|r"..
													  "|n|n"..
													  "When starting an Event (Auction or Sale), the players in their group can write by /wisp or by /raid how many dkp points they want/must to bid for an item and the AddOn will automatically collect this information and show it to them in the same window. After the event is over, you can select the winning player and click on 'Award Item To Player'. The information of this event will be automatically recorded in your DKP table."..
													  "|n|n"..
													  "To start an event go to the Bidding window, then you can enter the name of the item to be auctioned/saled, which you can autofill by doing the combination Alt + Left click on an item, then, if you wish, you can add an optional time in seconds to the duration of it. (Entering 0 here means there will be no time limit). Click 'Start the Bidding/Sale!' to start."..
													  "|n|n"..
													  "The players can bid via raid message or whisper with the following commands:|n|n"..
													  "|cFFFF0000!bid #|r - Where # represents the offer in dkp that the player wants to make (For example: !bid 20)"..
													  "|n|n"..
													  "|cFFFF0000!bid (automatic)|r - After someone bids the minimum amount required to trigger the automatic !bid, players can bet with the next minimum amount only by using the '!bid' command without bid."..
													  "|n|n"..
													  "|cFFFF0000!bidall|r - When using this command, and if the player has the necessary amount to raise the price of the item, the AddOn will take all your dkp points and bid them for the item that is being auctioned in that moment."..
													  "|n|n"..
													  "If you use the Sales System, any of the three commands will perform the same action, that is, they will take the player's bid and show it to them in the window with the price of the item.",
									},
				["AddedRecords"]=	{
										["SPANISH"] = "Registros Agregados",
										["ENGLISH"] = "Added Records",
									},
				["Text_6"]		 =	{
										["SPANISH"] = "|cFFFF0000Registro de Muertes ( Fatality )|r"..
													  "|n|n"..
													  "Se agrego un complemento al WebDKP que funciona exactamente como el conocido AddOn 'Fatality', pero con la ventaja de que todo anuncio realizado por la muerte de los jugadores queda regitrado en los datos del WebDKP y ademas pueden ser visualizados a traves de su propia ventana individual."..
													  "|n|n|n"..
													  "EL registro es capas de capturar:|n"..
													  "|n*)Quien murio.|n"..
													  "|n*)Que lo mato.|n"..
													  "|n*)Con que lo mataron.|n"..
													  "|n*)Hora de la muerte.|n"..
													  "|n|n|n"..
													  "|cFFFF0000Registro de Inestabilidad ( Sindra )|r"..
													  "|n|n"..
													  "Registro ideado y diseñado por Sebas G, con la idea de capturar toda la informacion posible sobre los debuff de Sindragosa(*) que fueron aplicados sobre los jugadores. La logica aplicada es bastante compleja, por lo que puede tener un muy pequeño margen de error ante los registros optenidos (99% de efectividad)."..
													  "|n(*):Boss de ICC (WoW Lich King)|n|n|n"..
													  "EL registro es capas de capturar:|n"..
													  "|n*)Nombre del jugador que produjo un Contragolpe.|n"..
													  "|n*)Cantidad de Marcas de Inestabilidad optenidas antes del Contragolpe.|n"..
													  "|n*)Cantidad de Marcas de Helado Hasta los Huesos en el caso de que haya muerto por este deduff.|n"..
													  "|n*)Cantidad de Marcas de Sacudida Mistica en el caso de que el jugador haya llegado a la ultima fase del boss.|n"..
													  "|n*)Numero de jugadores alcanzados por la explocion del Contragolpe, en el caso de que hubiese.|n"..
													  "|n*)Numero de jugadores asesinados por el Contragolpe, en el caso de que hubiese."..
													  "|n|n|n"..
													  "|cFFFF0000Almacenamiento de datos|r"..
													  "|n|n"..
													  "Los datos optenidos y procesados de ambos registros se guardaran de acuerdo a la tabla seleccionada actualmente en la ventana 'DKP Table', por lo que alternar entre tablas tambien alterna entre registros. Se pueden realizar descuentos directamente desde la ventana de los registros, simplemente con clikear en el jugador aparecera una ventana para confirmar el descuento. En el caso del Registros de Muertes, si presionamos Shift mientras clickeamos a un jugador, nos linkeara el motivo o la razón de su muerte.",
	
										["ENGLISH"] = "|cFFFF0000Death Record ( Fatality )|r"..
													  "|n|n"..
													  "A complement was added to the WebDKP that works exactly like the well-known AddOn 'Fatality', but with the advantage that any announcement made by the death of the players is registered in the WebDKP data and can also be viewed through its own window individual."..
													  "|n|n|n"..
													  "The registry is capable of capturing:|n"..
													  "|n*)Who died.|n"..
													  "|n*)That killed him.|n"..
													  "|n*)With what they killed him.|n"..
													  "|n*)Time of death.|n"..
													  "|n|n|n"..
													  "|cFFFF0000Instability Record ( Sindra )|r"..
													  "|n|n"..
													  "Registry conceived and designed by SnGa, with the idea of ​​capturing all the possible information about the Sindragosa(*) debuff that were applied to the players. The applied logic is quite complex, so it can have a very small margin of error before the obtained records (99% of effectiveness)."..
													  "|n(*):ICC Boss (WoW Lich King)|n|n|n"..
													  "The registry is capable of capturing:|n"..
													  "|n*)Name of the player who produced a backlash.|n"..
													  "|n*)Number of Instability Marks obtained before backlash.|n"..
													  "|n*)Amount of Brands of Ice Cream to the Bones in case you died from this deduff.|n"..
													  "|n*)Amount of Mystic Shock Marks in case the player has reached the last phase of the boss.|n"..
													  "|n*)Number of players reached by the backlash explosion, if any.|n"..
													  "|n*)Number of players killed by the backlash, if any."..
													  "|n|n|n"..
													  "|cFFFF0000Data storage|r"..
													  "|n|n"..
													  "The data obtained and processed from both records will be saved according to the table currently selected in the 'DKP Table' window, so switching between tables also alternates between records. Discounts can be made directly from the registration window, simply by clicking on the player a window will appear to confirm the discount. In the case of Death Records, if we press Shift while clicking on a player, it will link us to the reason or reason for their death.",
									},
				["SlashCommands"]=	{
										["SPANISH"] = "Slash Comandos",
										["ENGLISH"] = "Slash Commands",
									},
				["Text_7"]		 =	{
										["SPANISH"] = "|cFFFF0000Slash Comandos|r"..
													  "|n|n"..
													  "Los siguientes son comandos de barra que se pueden usar en el juego:"..
													  "|n|n"..
													  "1.) /webdkp show table - Muestra la ventana de DKP Tabla."..
													  "|n|n"..
													  "2.) /webdkp show bidding - Muestra la ventana de Bidding."..
													  "|n|n"..
													  "3.) /webdkp show synch - Muestra la ventana de configuracion de sincronizacion en pleno juego."..
													  "|n|n"..
													  "4.) /webdkp show options - Muestra la ventana de Opciones."..
													  "|n|n"..
													  "5.) /webdkp show timed - Muestra la ventana de Time Award."..
													  "|n|n"..
													  "6.) /webdkp show help - Muestra la ventana de Ayuda."..
													  "|n|n"..
													  "7.) /webdkp show log - Muestra la ventana de Registro de Award."..
													  "|n|n"..
													  "8.) /webdkp show raidlog - Muestra la ventana de Registro de Raid."..
													  "|n|n"..
													  "9.) /webdkp show fatality - Muestra la ventana de Registro de Muertes."..
													  "|n|n"..
													  "10.) /webdkp show sindra - Muestra la ventana de Registro de Inestabilidad."..
													  "|n|n"..
													  "11.) /webdkp show charlog - Muestra la ventana de Caracteristicas de Raid."..
													  "|n|n"..
													  "12.) /webdkp ignore list - Muestra la Listas de todos los items ignorados."..
													  "|n|n"..
													  "13.) /webdkp ignore add - Agrega un item a la lista de items ignorados."..
													  "|n|n"..
													  "14.) /webdkp ignore del - Elimina un item a la lista de items ignorados.",

										["ENGLISH"] = "|cFFFF0000Slash Commands|r"..
													  "|n|n"..
													  "The following are slash commands that can be used in the game:"..
													  "|n|n"..
													  "1.) /webdkp show table - Displays the DKP Table window."..
													  "|n|n"..
													  "2.) /webdkp show bidding - Displays the Bidding window."..
													  "|n|n"..
													  "3.) /webdkp show synch - Show the sync settings window in full game."..
													  "|n|n"..
													  "4.) /webdkp show options - Displays the Options window."..
													  "|n|n"..
													  "5.) /webdkp show timed - Displays the Time Award window."..
													  "|n|n"..
													  "6.) /webdkp show help - Displays the Help window."..
													  "|n|n"..
													  "7.) /webdkp show log - Displays the Award Registration window."..
													  "|n|n"..
													  "8.) /webdkp show raidlog - Displays the Raid Log window."..
													  "|n|n"..
													  "9.) /webdkp show fatality - Displays the Death Record window."..
													  "|n|n"..
													  "10.) /webdkp show sindra - Displays the Instability Log window."..
													  "|n|n"..
													  "11.) /webdkp show charlog - Displays the Raid Features window."..
													  "|n|n"..
													  "12.) /webdkp ignore list - Show the Lists of all ignored items."..
													  "|n|n"..
													  "13.) /webdkp ignore add - Add an item to the list of ignored items."..
													  "|n|n"..
													  "14.) /webdkp ignore del - Remove an item from the list of ignored items.",
									},
				["IgnoredItems"] =	{
										["SPANISH"] = "Items Ignorados",
										["ENGLISH"] = "Ignored Items",
									},
				["Text_8"]		 =	{
										["SPANISH"] = "|cFFFF0000Items Ignorados|r"..
													  "|n|n"..
													  "WebDKP le permite agregar elementos a la lista predeterminada de ignorados. La lista de ignorados predeterminada está contenida en webdkp.lua y no se puede editar desde el juego. Los siguientes son los comandos que le permiten enumerar, agregar y eliminar elementos ignorados dentro de WoW."..
													  "|n|n"..
													  " 1.) El siguiente es un ejemplo de cómo enumerar todos los elementos que ha agregado:"..
													  "|n|n"..
													  "Comando: /webdkp ignore list"..
													  "|n|n"..
													  " 2.) El siguiente es un ejemplo de cómo agregar un elemento a la lista de ignorados:"..
													  "|n|n"..
													  "Comando: /webdkp ignore add itemname"..
													  "|n"..
													  "Ejemplo: /webdkp ignore add Cloth Boots"..
													  "|n|n"..
													  " 3.) El siguiente es un ejemplo de cómo eliminar un elemento de la lista de ignorados:"..
													  "|n|n"..
													  "Comando: /webdkp ignore del itemname"..
													  "|n"..
													  "Ejemplo: /webdkp ignore del Cloth Boots",

										["ENGLISH"] = "|cFFFF0000Ignored Items|r"..
													  "|n|n"..
													  "WebDKP allows you to add items to the default ignore list. The default ignore list is contained in webdkp.lua and cannot be edited from within the game. The following are the commands that allow you to list, add, and remove ignored items within WoW."..
													  "|n|n"..
													  " 1.) The following is an example of how to list all the items you have added:"..
													  "|n|n"..
													  "Command: /webdkp ignore list"..
													  "|n|n"..
													  " 2.) The following is an example of how to add an item to the ignore list:"..
													  "|n|n"..
													  "Command: /webdkp ignore add itemname"..
													  "|n"..
													  "Example: /webdkp ignore add Cloth Boots"..
													  "|n|n"..
													  " 3.) The following is an example of how to remove an item from the ignore list:"..
													  "|n|n"..
													  "Command: /webdkp ignore del itemname"..
													  "|n"..
													  "Example: /webdkp ignore del Cloth Boots",
									},
					},

["RaidAttendance"]=	{
				["RaidStart"]	 =	{
										["SPANISH"] = "Iniciar Raid!",
										["ENGLISH"] = "Start Raid!",
									},
				["RaidEnd"]		 =	{
										["SPANISH"] = "Finalizar Raid!",
										["ENGLISH"] = "Finish Raid!",
									},
				["Filters"]		 =	{
										["SPANISH"] = "Por favor ingrese un fecha apropiada como para filtrar. Ej: 11-20-2010",
										["ENGLISH"] = "Please enter an appropriate date to filter. Ex: 11-20-2010",
									},
				["RStartPrint"]	 =	{
										["SPANISH"] = "Raid Iniciada! Hora de inicio: $Start",
										["ENGLISH"] = "Raid Started! Start time: $Start",
									},
				["REndPrint"]	 =	{
										["SPANISH"] = "Raid Finalizada! Hora de finalizacion: $endTime, Tiempo Total: $totaltimeraid",
										["ENGLISH"] = "Raid Finished! End Time: $endTime, Total Time: $totaltimeraid",
									},
				["CurrentTime"]	 =	{
										["SPANISH"] = "Actualmente en curso",
										["ENGLISH"] = "Currently ongoing",
									},
				["WaitingEnd"]	 =	{
										["SPANISH"] = "Esperando cierre",
										["ENGLISH"] = "Awaiting completion",
									},
				["NoData"]		 =	{
										["SPANISH"] = "Sin Datos",
										["ENGLISH"] = "No Data",
									},
					},

["Standby"] 	 =	{
				["SelectPlayer"] =	{
										["SPANISH"] = "Debes ingresar un jugador o seleccionarlo para agregarlo o eliminarlo a la lista.",
										["ENGLISH"] = "You must enter or select a player to add or remove him from the list.",
									},
				["AddPlayer"]	 =	{
										["SPANISH"] = "Ahora estás en la lista como jugador en espera.",
										["ENGLISH"] = "You are now on the list as a player in standby.",
									},
				["NoExistPlayer"]=	{
										["SPANISH"] = "Este jugador no existe en tu tabla.",
										["ENGLISH"] = "This player does not exist on your table.",
									},
				["DelPlayer"]	 =	{
										["SPANISH"] = "Has sido eliminado como jugador en espera.",
										["ENGLISH"] = "You have been eliminated as a standby player.",
									},
				["ResetList"]	 =	{
										["SPANISH"] = "La lista de jugadores en espera fue reseteada correctamente!.",
										["ENGLISH"] = "The list of players in Standby was reset correctly!.",
									},
				},

["TimedAward"]	 =	{
				["AutoBossKill"] =	{
										["SPANISH"] = "Award Auto. por Boss Eliminado: $arg2",
										["ENGLISH"] = "Auto Award Boss Kill: $arg2",
									},
				["AutoAward"]	 =	{
										["SPANISH"] = "Award de Tiempo Automatico",
										["ENGLISH"] = "Timed Automatic Award",
									},
					},

["WebDKP"]		 =	{
				["Disabled"]	 =	{
										["SPANISH"] = "WebDKP ha sido desactivado.",
										["ENGLISH"] = "WebDKP has been disabled.",
									},
				["IgnoreList"]	 =	{
										["SPANISH"] = "Elementos ignorados definidos por el usuario:",
										["ENGLISH"] = "User Defined Ignored Items:",
									},
				["ItemIgnore"]	 =	{
										["SPANISH"] = "Item ignorado = $item",
										["ENGLISH"] = "Item Ignored = $item",
									},
				["ItemAdd"]		 =	{
										["SPANISH"] = "Item Agregado Correctamente!",
										["ENGLISH"] = "Item Add Successfully!",
									},
				["ItemDel"]		 =	{
										["SPANISH"] = "Item Eliminado Correctamente!",
										["ENGLISH"] = "Item Del Successfully!",
									},
				["RaidInProcess"]=	{
										["SPANISH"] = "WebDKP_RaidStatus: Hay una Raid en Proceso!",
										["ENGLISH"] = "WebDKP_RaidStatus: There is a Raid in Progress!",
									},
				["RollsSystem"]	 =	{
								   --[[ ["SPANISH"] = ]] "(.+) tira los dados y obtiene (%d+) %((%d+)%-(%d+)%)", 	
								   --[[ ["ENGLISH"] = ]] "(.+) rolls (%d+) %((%d+)%-(%d+)%)",
									},
					},

["WisperDKP"]	 =	{
				["NoDKP"]		 =	{
										["SPANISH"] = "No posees historial de DKP",
										["ENGLISH"] = "You have no history of DKP",
									},
				["CurrentDKP"]	 =	{
										["SPANISH"] = "Tus dkp actuales son: $dkp",
										["ENGLISH"] = "Your current dkp are: $dkp",
									},
				["Current"]		 =	{
										["SPANISH"] = "!actual",
										["ENGLISH"] = "!current",
									},
				["Previous"]	 =	{
										["SPANISH"] = "!anterior",
										["ENGLISH"] = "!previous",
									},
				["Help"]		 =	{
										["SPANISH"] = "!ayuda",
										["ENGLISH"] = "!helpme",
									},
				["Attendance"]	 =	{
										["SPANISH"] = "!asistencia",
										["ENGLISH"] = "!attendance",
									},
				["Cancel"]		 =	{
										["SPANISH"] = "!cancelar",
										["ENGLISH"] = "!cancel",
									},
				["NoItemAuction"]=	{
										["SPANISH"] = "No hay ningun item subastandose actualmente.",
										["ENGLISH"] = "There are no items currently auctioning.",
									},
				["NoItemSale"]	 =	{
										["SPANISH"] = "No hay ningun item en venta actualmente",
										["ENGLISH"] = "There are no items for sale currently",
									},
				["ItemCurrent"]	 =	{
										["SPANISH"] = "$item! Oferta actual: $current dkp!",
										["ENGLISH"] = "$item! Current bid: $current dkp!",
									},
				["NextBid"]	 	 =	{
										["SPANISH"] = "Siguiente Oferta Minima: $min dkp!",
										["ENGLISH"] = "Next Minimum bid: $min dkp!",
									},
				["AucPrevious"]	 =	{
										["SPANISH"] = "No hay registros de una Subasta anterior.",
										["ENGLISH"] = "There are no records of a previous Auction.",
									},
				["SalePrevious"] =	{
										["SPANISH"] = "No hay registros de una Venta anterior.",
										["ENGLISH"] = "There are no records of a previous Sale.",
									},
				["HelpText1"]	 =	{
										["SPANISH"] = "Comandos Disponibles:",
										["ENGLISH"] = "Available Commands:",
									},
				["HelpText2"]	 =	{
										["SPANISH"] = "!dkp - Devuelve tu total de dkps acumulados.",
										["ENGLISH"] = "!dkp - Returns your total accumulated dkps.",
									},
				["HelpText3"]	 =	{
										["SPANISH"] = "!bid # / !bidall - Te permite realizar una oferta por un item. Si el '!bid auto.' esta activado y los !bid llegaron a una cierta cantidad, el !bid sin # subirá automaticamente la oferta anterior.",
										["ENGLISH"] = "!bid # / !bidall - Allows you to bid for an item. If '!bid auto.' is activated and the bids reached a certain amount, !bid without # automatically raises the previous bid.",
									},
				["HelpText4"]	 =	{
										["SPANISH"] = "!casino # / !casinoall - Te permite apostar DKP en el casino para intentar multiplicarla con /dados. Puedes anular tu apuesta con !cancelar",
										["ENGLISH"] = "!casino # / !casinoall -  It allows you to bet DKP in the casino to try to multiply it with /roll. You can nulled your bet with !cancel",
									},
				["HelpText5"]	 =	{
										["SPANISH"] = "!asistencia - Devuelve el total de raids asistidas por ti",
										["ENGLISH"] = "!attendance - Returns the total number of raids assisted by you",
									},
				["HelpAuct6"]	 =	{
										["SPANISH"] = "!actual - Devuelve el item actualmente en subasta",
										["ENGLISH"] = "!current - Returns the item currently in auction",
									},
				["HelpSale6"]	 =	{
										["SPANISH"] = "!actual - Devuelve el item actualmente en venta",
										["ENGLISH"] = "!current - Returns the item currently for sale",
									},
				["HelpAuct7"]	 =	{
										["SPANISH"] = "!anterior - Devuelve el ganador de la subasta anterior",
										["ENGLISH"] = "!previous - Returns the winner of the previous auction",
									},
				["HelpSale7"]	 =	{
										["SPANISH"] = "!anterior - Devuelve el ganador de la venta anterior",
										["ENGLISH"] = "!previous - Returns the winner of the previous sale",
									},
				["AttenCurrent"] =	{
										["SPANISH"]	= "Has asistido a: $attended_raids de $total_raids raids. Tu porcentaje realizado es $percent.",
										["ENGLISH"] = "You have attended: $attended_raids out of $total_raids raids. Your percent made is $percent.",
									},
				["NoAttendance"] =	{
										["SPANISH"] = "Actualmente no cuentas con datos de asistencia.",
										["ENGLISH"] = "You currently have no attendance data.",
									},
					},

["Records"]	 	 =	{
				["AwardReason"]	 =	{
										["SPANISH"] = "Award: Razón / Motivo >>",
										["ENGLISH"] = "Award: Reason >>",
									},
				["AwardCancel"]	 =	{
										["SPANISH"] = "El award [ $award ] ha sido anulado!",
										["ENGLISH"] = "The award [ $award ] has been canceled!",
									},
				["FatalityBand"] =	{
										["SPANISH"] = "$dName Murio por $report! Origen: $sName",
										["ENGLISH"] = "$dName Died for $report! Source: $sName",
									},
				["PaladinKill"]	 =	{
										["SPANISH"] = "Intervención divina",
										["ENGLISH"] = "Divine Intervention",
									},
				["DeleteLog"]	 =	{
										["SPANISH"] = "WebDKP: Registros eliminados parcialmente. Para eliminación permanente recarge la interfaz ( /reload ).",
										["ENGLISH"] = "WebDKP: Partially deleted records. For permanent deletion reload the interface ( /reload )."
									},
				["UpdateLog"]	 =	{
										["SPANISH"] = "WebDKP: Registros actualizados. Presione 'Salvar Registros' para guardarlos ante cualquier inconveniente.",
										["ENGLISH"] = "WebDKP: Updated records. Press 'Save Records' to save them in case of any inconvenience.",
									},
				["FatalityReason"]=	{
										["SPANISH"] = "Fatality: Razón / Motivo >> $playerreason",
										["ENGLISH"] = "Fatality: Reason >> $playerreason",
									},
				["FatalityPopUp"]=	{
										["SPANISH"] = "$playerdate fue eliminado con >> $playerreason <<",
										["ENGLISH"] = "$playerdate was eliminated with >> $playerreason <<",
									},
				["SindraBand_N"] =	{
										["SPANISH"] = "$destName explotó con $Stacks y se causó $amount de daño!",
										["ENGLISH"] = "$destName exploded with $Stacks causing $amount of damage!",
									},
				["SindraBand_H"] =	{
										["SPANISH"] = "$destName explotó con $Stacks y causó $amount de daño en AOE!",
										["ENGLISH"] = "$destName exploded with $Stacks and caused $amount of damage in AOE!",
									},
				["SindraBand_M"] =	{
										["SPANISH"] = "$destName se mató con $Stacks que le causarón $amount de daño periodico!",
										["ENGLISH"] = "$destName killed himself with $Stacks that caused $amount of periodic damage!",
									},
				["AutoKill_C"]	 =	{
										["SPANISH"] = "Explotó y murio por su propio Contragolpe!",
										["ENGLISH"] = "It exploded and was killed by its own Backlash!",
									},
				["AutoKill_M"]	 =	{
										["SPANISH"] = "Murio por Debuff Melee!",
										["ENGLISH"] = "Died for Debuff Melee!",
									},
				["MurderedBy"]	 =		{
										["SPANISH"] = "Fue Asesinado Por $autor",
										["ENGLISH"] = "Was Killed By $autor",
									},
				["SindraTitle"]	=	{
										["SPANISH"] = "Registro de Inestabilidad ( Sindra ):       >>> $TableName <<< ",
										["ENGLISH"] = "Instability Record ( Sindra Log ):            >>> $TableName <<< ",
									},
				["FatalityTitle"]=	{
										["SPANISH"] = "Registro de Muertes ( Fatality ):             >>> $TableName <<< ",
										["ENGLISH"] = "Death Record ( Fatality Log ):                 >>> $TableName <<< ",
									},
				["AwardsTitle"]	 =	{
										["SPANISH"] = "Registro de Awards:                               >>> $TableName <<< ",
										["ENGLISH"] = "Awards Log:                                           >>> $TableName <<< ",
									},
				["RaidTitle"]	 =	{
										["SPANISH"] = "Registro de Raids:                                 >>> $TableName <<< ",
										["ENGLISH"] = "Raid Log:                                               >>> $TableName <<< ",
									},
				["NoTableDKP"]	 =	{
										["SPANISH"] = "Sin Tabla DKP",
										["ENGLISH"] = "No DKP Table",
									},
					},

["MoreFunctions"]=	{
				["CasinoInGame"] =	{
										["SPANISH"] = "$player ha apostado en el casino $amount dkp! Esperando el resultado de sus dados.",
										["ENGLISH"] = "$player has bet in the casino $amount dkp! Waiting for the result of your roll.",
									},
				["CasinoCancel"] =	{
										["SPANISH"] = "$player ha cancelado su apuesta!",
										["ENGLISH"] = "$player has canceled his bet!",
									},
				["CasinoNewTry"] =	{
										["SPANISH"] = "$player obtiene otro intento al igualar el valor definido a superar.",
										["ENGLISH"] = "$player gets another attempt at matching the set value to exceed.",
									},
				["CasinoResult"] =	{
										["SPANISH"] = "$player $result en el Casino $points dkp con $roll",
										["ENGLISH"] = "$player $result in the Casino $points dkp with $roll",
									},
				["CasinoReason"] =	{
										["SPANISH"] = "Aposto en el Casino x$try! [G:$win][P:$lose]",
										["ENGLISH"] = "Bet in the Casino x$try! [W:$win][L:$lose]",
									},
				["NoCasino"]	 =	{
										["SPANISH"] = "El Casino no está disponible actualmente.",
										["ENGLISH"] = "The Casino is currently not available.",
									},
				["NoNumCasino"]	 =	{
										["SPANISH"] = "Rechazado! Debes utilizar !casino seguido de un monto numerico que deseas ofertar.",
										["ENGLISH"] = "Rejected! You must use !casino followed by a numerical amount you wish to bid.",
									},
				["CasinoExceed"] =	{
										["SPANISH"] = "Rechazado! El maximo monto permitido es de $amount dkp.",
										["ENGLISH"] = "Rejected! The maximum amount allowed is $amount dkp.",
									},
				["CasinoInsuff"] =	{
										["SPANISH"] = "Rechazado! No cuentas con los dkp suficientes! Tu monto maximo es de $dkp dkp.",
										["ENGLISH"] = "Rejected! You do not have enough dkp! Your maximum amount is $dkp dkp.",
									},
				["CasinoOK"]	 =	{
										["SPANISH"] = "Monto Aceptado! Ahora debes tipear /dados para continuar o !cancelar para anular. Tambien puedes editar el monto volviendo a wispear !casino + nuevo monto.",
										["ENGLISH"] = "Amount Accepted! Now you must type /roll to continue or !cancel for to null. You can also edit the amount by re-wisping !casino + new amount.",
									},
				["CasinoPrev"]	 =	{
										["SPANISH"] = "No cuentas con una apuesta previa en el casino.",
										["ENGLISH"] = "You do not have a pre-bet at the casino.",
									},
				["CCancelWisp"]  =	{
										["SPANISH"] = "Tu apuesta ha sido anulada.",
										["ENGLISH"] = "Your bet has been nulled.",
									},
				["CasinoTry"]	 =	{
										["SPANISH"] = "Has conseguido otro intento, vuelve a tipear /dados.",
										["ENGLISH"] = "You have gotten another try, retype /roll.",
									},
				["DEATHKNIGHT"]	 =	{
										["SPANISH"] = "Caballero de la Muerte",
										["ENGLISH"]	= "Death Knight"
									},
				["WARRIOR"]		 =	{
										["SPANISH"] = "Guerrero",
										["ENGLISH"] = "Warrior",
									},
				["PALADIN"]		 =	{
										["SPANISH"] = "Paladín",
										["ENGLISH"] = "Paladin",
									},
				["WARLOCK"]		 =	{
										["SPANISH"] = "Brujo",
										["ENGLISH"] = "Warlock",
									},
				["PRIEST"]		 =	{
										["SPANISH"] = "Sacerdote",
										["ENGLISH"] = "Priest",
									},
				["SHAMAN"]		 =	{
										["SPANISH"] = "Chamán",
										["ENGLISH"] = "Shaman",
									},
				["HUNTER"]		 =	{
										["SPANISH"] = "Cazador",
										["ENGLISH"]	= "Hunter",
									},
				["DRUID"]		 =	{
										["SPANISH"] = "Druida",
										["ENGLISH"] = "Druid",
									},
				["ROGUE"]		 =	{
										["SPANISH"] = "Pícaro",
										["ENGLISH"]	= "Rogue",
									},
				["MAGE"]		 =	{
										["SPANISH"] = "Mago",
										["ENGLISH"] = "Mage",
									},
					},

["WebDKP_Error"] =	{
				["Top3Silent"]	 =	{
										["SPANISH"] = "WebDKP_Error: La opción 'Eventos Silenciosos' se encuentra activado, por lo que 'Announce Top 3 Bids' no esta permitido a menos que la desactive.",
										["ENGLISH"] = "WebDKP_Error: The 'Silent Events' option is enabled, so 'Announce Top 3 Bids' is not allowed unless you disable it.",
									},
				["NoValue"]		 =	{
										["SPANISH"] = "WebDKP_Error: No se ha ingresado valor, se usará por defecto 0.",
										["ENGLISH"] = "WebDKP_Error: No value has been entered, 0 will be used by default.",
									},
				["NoSelected"]	 =	{
										["SPANISH"] = "WebDKP_Error: Jugador/es no seleccionado/s. Award no realizado.",
										["ENGLISH"] = "WebDKP_Error: Player not selected. Award not made.",
									},
				["NoNameItem"]	 =	{
										["SPANISH"]	= "WebDKP_Error: Debes ingresar el nombre del item.",
										["ENGLISH"]	= "WebDKP_Error: You must enter the name of the item.",
									},
				["NoValueAward"] =	{
										["SPANISH"] = "WebDKP_Error: Debes ingresar el valor del award.",
										["ENGLISH"] = "WebDKP_Error: You must enter the award value.",
									},
				["NoItemRoll"]	 =	{
										["SPANISH"] = "WebDKP_Error: Necesita ingresar un item para Roll.",
										["ENGLISH"] = "WebDKP_Error: You need to enter an item for Roll.",
									},
				["DkpCapConflict"]=	{
										["SPANISH"] = "WebDKP_Error: No se puede agregar Jugador al Award! lo dejaria por encima del DKP Cap establecido.",
										["ENGLISH"] = "WebDKP_Error: Cannot add Player to Award! It would leave it above the set DKP Cap.",
									},
				["NoDiscount"]	 =	{
										["SPANISH"] = "WebDKP_Error: Valor del descuento invalido, se usará por defecto 0.",
										["ENGLISH"] = "WebDKP_Error: Invalid discount value, 0 will be used by default.",
									},
				["NoPjTable"]	 =	{
										["SPANISH"] = "WebDKP_Error: No se encontro el player en la tabla. Award no realizado.",
										["ENGLISH"] = "WebDKP_Error: The player was not found in the table. Award not made.",
									},
				["SaleEnabled"]	 =	{
										["SPANISH"] = "WebDKP_Error: No esta permitido desactivar la captura de dados cuando el sistema de ventas de items esta activo.",
										["ENGLISH"] = "WebDKP_Error: It is not allowed to disable rolls capture when the item sales system is active.",
									},
				["NoFinished"]	 =	{
										["SPANISH"] = "WebDKP_Error: Solo se puede ajustar el Tiempo Total a Raids finalizadas.",
										["ENGLISH"] = "WebDKP_Error: You can only adjust the Total Time to finished Raids.",
									},
				["NoDelete"]	 =	{
										["SPANISH"] = "WebDKP_Error: Solo se puede eliminar Raids finalizadas.",
										["ENGLISH"] = "WebDKP_Error: Only finished Raids can be removed.",
									},
					},
}				



WebDKP_Language_xml = 
{
["Others"]		 =	{
				["Yes"]			 =	{
										["SPANISH"] = "Si, Dale!",
										["ENGLISH"] = "Yes, of course!",
									},	
				["No"]			 =	{
										["SPANISH"] = "Mejor No..",
										["ENGLISH"] = "Better Not..",
									},
				["Name"]		 =	{
										["SPANISH"] = "Nombre",
										["ENGLISH"] = "Name",
									},
				["Class"]		 =	{
										["SPANISH"] = "Clase",
										["ENGLISH"] = "Class",
									},
				["GuildRank"]	 =	{
										["SPANISH"] = "Rango de Guild",
										["ENGLISH"] = "Guild Rank",
									},
				["OnlyInGroup"]	 =	{
										["SPANISH"] = "Solo jugadores en mi grupo actual",
										["ENGLISH"] = "Only show players in my current group",
									},
				["Enabled"]	 	=	{
										["SPANISH"] = "Estado: Activado",
										["ENGLISH"] = "Status: Enabled",
									},
				["Disabled"]	 =	{
										["SPANISH"] = "Estado: Desactivado",
										["ENGLISH"] = "Status: Disabled",
									},
				["Date"]		 = 	{
										["SPANISH"] = "Fecha",
										["ENGLISH"] = "Date",
									},
				["Amount"]		 =	{
										["SPANISH"] = "Monto",
										["ENGLISH"] = "Amount",
									},
				["Time"]		 =	{
										["SPANISH"] = "Hora",
										["ENGLISH"] = "Time",
									},
				["Details"]		 =	{
										["SPANISH"] = "Detalles",
										["ENGLISH"] = "Details",
									},
				["Dramage"]		 =	{
										["SPANISH"] = "Daño",
										["ENGLISH"] = "Dramage",
									},
				},

["Bid_Frame"]	 =	{
				["ItemAuction"]	 =	{
										["SPANISH"] = "Ítem a Subastar:",
										["ENGLISH"] = "Item to Auction:",
									},
				["ItemSale"]	 =	{
										["SPANISH"] = "Ítem a Vender:",
										["ENGLISH"] = "Item to Sale:",
									},
				["FixedPrice"]	 =	{
										["SPANISH"] = "Precio Fijo",
										["ENGLISH"] = "Fixed Price",
									},
				["StartingBid"]	 =	{
										["SPANISH"] = "Oferta Inicial:",
										["ENGLISH"] = "Starting Bid:",
									},
				["Bid/Roll"]	 =	{
										["SPANISH"] = "Bid/Roll Tiempo:",
										["ENGLISH"] = "Bid/Roll Time:",
									},
				["TimeDescrip"]	 =	{
										["SPANISH"] = "(en segundos - use 0 para iniciar sin limite de tiempo)",
										["ENGLISH"] = "(in seconds - use 0 for no limit)",
									},
				["Top3Button"]	 =	{
										["SPANISH"] = "Anunciar Top3 Bids",
										["ENGLISH"] = "Announce Top3 Bids",
									},
				["ResetButton"]	 =	{
										["SPANISH"] = "Limpiar Ofertas!",
										["ENGLISH"] = "Clean Bids!",
									},
				["Received"]	 =	{
										["SPANISH"] = "Ofertas/Rolls Recibidos:",
										["ENGLISH"] = "Received Bids/Rolls:",
									},
				["MonitoringOn"] =	{
										["SPANISH"] = "Captura de Dados en Eventos Activado!",
										["ENGLISH"] = "Capture Rolls in Bid Events Activated!",
									},

				["MonitoringOff"]=	{
										["SPANISH"] = "Captura de Dados en Eventos Desactivado!",
										["ENGLISH"] = "Capture Rolls in Bid Events Disabled!",
									},
				["Bid"]			 =	{
										["SPANISH"] = "Oferta",
										["ENGLISH"] = "Bid",
									},
				["AssingButton"] =	{
										["SPANISH"] = "Asignar Item al Jugador",
										["ENGLISH"] = "Award Item To Player",
									},	
				["ConfirmBid"]	 =	{
										["SPANISH"] = "Y a su Oferta de:",
										["ENGLISH"] = "And The Bid of:",
									},
				["ConfirmMult"]	 =	{
										["SPANISH"] = "Multiplicar por:",
										["ENGLISH"] = "Multiply by:",
									},
					},

["CharRaidFrame"]=	{
				["Title"]		 =	{
										["SPANISH"] = "Tabla de registro de Jugadores por Raid:",
										["ENGLISH"] = "Character Raid Log Table:",
									},
				["Header"]		 =	{
										["SPANISH"] = "Raid asistidas por el jugador:",
										["ENGLISH"] = "Raids assisted by the player:",
									},
				["Attended"]	 =	{
										["SPANISH"] = "Asistencias",
										["ENGLISH"] = "Attended",
									},
				["FiltersDays"]	 =	{
										["SPANISH"] = "Ingrese una fecha de inicio para filtrar los datos hasta la fecha actual: (Ej: 24-08-2021)",
										["ENGLISH"] = "Enter a start date to filter the data up to the current date:(Ex:24-08-2021)",
									},
				["Percent"]		 =	{
										["SPANISH"] = "Porcentaje",
										["ENGLISH"] = "Percent",
									},
				["TotalRaids"]	 =	{
										["SPANISH"] = "Raids en Total",
										["ENGLISH"] = "Total Raids",
									},
				["Location"]	 =	{
										["SPANISH"] = "Ubicacion",
										["ENGLISH"] = "Location",
									},	
				["DateTime"]	 =	{
										["SPANISH"] = "Fecha y Hora",
										["ENGLISH"] = "Date and Time",
									},
				["RemoveChar"]	 =	{
										["SPANISH"] = "Eliminar Jugador",
										["ENGLISH"] = "Remove Character",
									},
				["StartDate"]	 =	{
										["SPANISH"] = "Fecha Inicial:",
										["ENGLISH"] = "Start Date:",
									},
				["ApplyFilter"]	 =	{
										["SPANISH"] = "Aplicar filtro",
										["ENGLISH"] = "Apply the filter",
									},
					},

["WebDKP_Frame"] =	{
				["Title"]		 =	{
										["SPANISH"] = "Tabla DKP:",
										["ENGLISH"] = "DKP Table:",
									},
				["Help"]		 =	{
										["SPANISH"] = "Ayuda",
										["ENGLISH"] = "Help",
									},
				["SelectAll"]	 =	{
										["SPANISH"] = "Seleccionar Todo",
										["ENGLISH"] = "Select All",
									},
				["DeselectAll"]	 =	{
										["SPANISH"] = "Deseleccionar Todo",
										["ENGLISH"] = "Deselect All",
									},
				["SaveLog"]		 =	{
										["SPANISH"] = "Salvar WebDKP.lua",
										["ENGLISH"] = "Save WebDKP.lua",
									},
				["RefreshGroup"] =	{
										["SPANISH"] = "Refrescar Grupos",
										["ENGLISH"] = "Refresh Group",
									},
				["Filters"]		 =	{
										["SPANISH"] = "Filtros:",
										["ENGLISH"] = "Filters:",
									},
				["Chain"]		 =	{
										["SPANISH"] = "Malla",
										["ENGLISH"] = "Chain",
									},
				["Cloth"]		 =	{
										["SPANISH"] = "Tela",
										["ENGLISH"] = "Cloth",
									},
				["Leather"]		 =	{
										["SPANISH"] = "Cuero",
										["ENGLISH"] = "Leather",
									},
				["Plate"]		 =	{
										["SPANISH"] = "Placas",
										["ENGLISH"] = "Plate",
									},
				["CheckAll"]	 =	{
										["SPANISH"] = "Check Todo",
										["ENGLISH"] = "Check All",
									},
				["UncheckAll"]	 =	{
										["SPANISH"] = "Descheck Todo",
										["ENGLISH"] = "Uncheck All",
									},
				["Search"]		 =	{
										["SPANISH"] = "Buscar por Nombre:",
										["ENGLISH"] = "Search by Name:",
									},
				["Guild"]		 =	{
										["SPANISH"] = "Solo jugadores en mi hermandad actual", 
										["ENGLISH"] = "Only show players in your guild",
									},
				["GuildOnline"]	 =	{
										["SPANISH"]	= "Solo miembros de hermandad en linea",
										["ENGLISH"] = "Only Online Guild Members",
									},
				["LimitAlts"]	 =	{
										["SPANISH"] = "Excludir todos los alters",
										["ENGLISH"] = "Exclude All Alts",
									},
				["LimitAlts2"]	 =	{
										["SPANISH"] = "Excludir alters que no estan en mi grupo",
										["ENGLISH"] = "Exclude Alts Not In Party",
									},
				["Standby1"]	 =	{
										["SPANISH"] = "Incluir jugadores en espera",
										["ENGLISH"] = "Include Standby Players",
									},
				["Standby2"]	 =	{
										["SPANISH"] = "Limitar a players en espera",
										["ENGLISH"] = "Limit to Standby Players",
									},
				["AwardDKP"]	 =	{
										["SPANISH"] = "Asignar DKP",
										["ENGLISH"] = "Assign DKP",
									},
				["DKPInfo1"]	 =	{
										["SPANISH"] = "Seleccione el/los player/s a asignar el award\ny luego ingrese la informacion del mismo.",
										["ENGLISH"] = "Select recieving players on left and enter\naward information below.",
									},
				["DKPInfo2"]	 =	{
										["SPANISH"] = "Seleccione el/los player/s a recibir el decay.",
										["ENGLISH"] = "Select recieving players on left.",
									},
				["DKPInfo3"]	 =	{
										["SPANISH"] = "Los players podrán apostar un cierto monto de\nDKP e intentar multiplicarlos tirando /dados",
										["ENGLISH"] = "Players will be able to bet a certain amount of\nDKP and try to multiply them with /roll",
									},
				["Reason"]		 =	{
										["SPANISH"] = "Razón / Motivo",
										["ENGLISH"] = "Reason / Motive",
									},
				["Points"]		 =	{
										["SPANISH"] = "Puntos: (Ej: 50 / -100)",
										["ENGLISH"] = "Points: (Ex: 50 / -100)",
									},
				["Decay"]		 =	{
										["SPANISH"] = "Ej 0.4 es -40% => 100dkp - 0.4 = 60dkp.",
										["ENGLISH"] = "Ex 0.4 is -40% => 100dkp - 0.4 = 60dkp.",
									},
				["AwardDecay"]	 =	{
										["SPANISH"] = "Realizar Decay",
										["ENGLISH"] = "Perform Decay",
									},
				["CasinoCheck"]  =	{
										["SPANISH"] = "Activar",
										["ENGLISH"] = "Enable",
									},
				["Unmodifiable"] =	{
										["SPANISH"] = "Para modificar los valores,\nprimero desactive el casino.",
										["ENGLISH"] = "To change the values,\nfirst disable the casino.",
									},
				["AllInOne"]	 =	{
										["SPANISH"] = "Todas las apuestas en un\nsolo award por jugador",
										["ENGLISH"] = "All bets in one single\naward per player",
									},
				["RollLimit"]	 =	{
										["SPANISH"] = "Monto Limite:",
										["ENGLISH"] = "Limit Amount:",
									},
				["RollWin"]		 =	{
										["SPANISH"] = "Ganan los dados mayores a:",
										["ENGLISH"] = "Win rolls greater than:",
									},
				["RollMultiply"] =	{
										["SPANISH"] = "Si ganan, multiplicar award por:",
										["ENGLISH"] = "If they win, multiply award by:",	
									},
				["Bidding"]		 =	{
										["SPANISH"] = "Tabla de Ofertas",
										["ENGLISH"] = "Bidding Table",
									},
				["Settings"]	 =	{
										["SPANISH"] = "Opciones",
										["ENGLISH"] = "Options",
									},
				["TimedAwards"]	 =	{
										["SPANISH"] = "Premios por Tiempo",
										["ENGLISH"] = "Timed Awards",
									},
				["AwardItem"]	 =	{
										["SPANISH"] = "Asignar item a un Jugador:",
										["ENGLISH"] = "Assign item to a Player:",
									},
				["ItemInfo1"]	 =	{
										["SPANISH"] = "Seleccione al player en la tabla DKP",
										["ENGLISH"] = "Select recieving player from DKP table",
									},
				["ItemFound"]	 =	{
										["SPANISH"] = "Item encontrado en tu \nTabla de Botin!\nPrecio inicial: $pricedkp",
										["ENGLISH"] = "Item found in your Loot Table!\nStart price: $pricedkp",
									},
				["ItemName"]	 =	{
										["SPANISH"] = "Item: (Puede linkearlo haciendo Shift+Click)",
										["ENGLISH"] = "Item: (You can link it by Shift + Click)",
									},
				["ItemCost1"]	 =	{
										["SPANISH"] = "Precio / Costo: (Solo numeros positivos)",
										["ENGLISH"] = "Item Cost: (Positive numbers only)",
									},
				["ItemCost2"]	 =	{
										["SPANISH"] = "(Incluye porcentajes si es que estan activos)",
										["ENGLISH"] = "(Include the percentages if they are active)",
									},
				["ItemButton"]	 =	{
										["SPANISH"] = "Asignar Item",
										["ENGLISH"] = "Assign Item",
									},
				["ItemWeapons"]  =	{
										["SPANISH"] = "Armas:",
										["ENGLISH"] = "Weapons:",
									},
				["ItemSets"] 	 =	{
										["SPANISH"] = "Equipamiento:",
										["ENGLISH"] = "Sets Parts:",
									},
				["ItemLevel"]	 =	{
										["SPANISH"] = "Precio por el nivel del item",
										["ENGLISH"] = "Price by item level",
									},
				["ItemType"]	 =	{
										["SPANISH"] = "Precio por el tipo de item",
										["ENGLISH"] = "Price by item type",
									},
				["ItemMult"]	 =	{
										["SPANISH"] = "Tambien multiplicar por tipo",
										["ENGLISH"] = "Also multiply by item type",
									},
				["MultFound"]	 =	{
										["SPANISH"] = "Multiplicar por tipo",
										["ENGLISH"] = "Multiply by item type",
									},
				["ItemValue"]	 =	{
										["SPANISH"] = "Multiplicar por:",
										["ENGLISH"] = "Multiply by:",
									},
				["ItemTitle"]	 =	{
										["SPANISH"] = "Venta de Items:",
										["ENGLISH"] = "Items Sales:",									
									},
				["ItemSale"]	 =	{
										["SPANISH"] = "Convierte la Subasta en un Sistema de Ventas.\nLos bids serán iguales y se decidirá por dados.",
										["ENGLISH"] = "Turn the Auction into an Items Sales System.\nThe bids will be equal, will be decided by Rolls.",
									},
				["DefaultPrice"] =	{
										["SPANISH"] = "Precio predeter.:",
										["ENGLISH"] = "Default price:",
									},
				["RaidStatus"]	 =	{
										["SPANISH"] = "Estado de la Raid:",
										["ENGLISH"] = "Raid Status:",
									},
				["StandInfo2"]	 =	{
										["SPANISH"] = "Ellos también pueden agregarse o eliminarse\nsolos con: !standby add o !standby del",
										["ENGLISH"] = "They can also be added or removed on their\nown with: !standby add or !standby del",
									},
				["StandInfo1"]	 =	{
										["SPANISH"] = "Puede crear una lista de jugadores que están\nen la espera de ingresar a la instancia.\nEsta lista se utilizará en la pestaña 'Filtros'.",
										["ENGLISH"] = "You can create a list of players who are\nwaiting to enter the instance.\nThis list will be used in the 'Filters' tab.",
									},
				["StandBox"]	 =	{
										["SPANISH"] = "Jugadores en Espera:",
										["ENGLISH"] = "Standby Players:",
									},
				["AddToStand"]	 =	{
										["SPANISH"] = "Agregar",
										["ENGLISH"] = "Add",
									},
				["DelToStand"]	 =	{
										["SPANISH"]	= "Quitar",
										["ENGLISH"] = "Remove",
									},
				["ResetToStand"] =	{
										["SPANISH"] = "Reiniciar",
										["ENGLISH"] = "Reset",
									},
				["PlayerInfo"]	 =	{
										["SPANISH"] = "Nombre del Jugador:",
										["ENGLISH"] = "Player Name:",
									},
				["ResetInfo"]	 =	{
										["SPANISH"] = "Reiniciar lista de jugadores:",
										["ENGLISH"] = "Reset All Standby Players:",
									},
				["RaidDescrip"]	 =	{
										["SPANISH"] = "Inicie o finalice una instancia para realizar el\nseguimiento de asistencias de los jugadores.",
										["ENGLISH"] = "Start or end an raid to track players attendance."
									},
				["StartTime"]	 =	{
										["SPANISH"] = "Hora de Inicio",
										["ENGLISH"] = "Start Time",
									},
				["FinishTime"]	 =	{
										["SPANISH"] = "Hora de Cierre",
										["ENGLISH"] = "End Time",
									},
				["TotalTime"]	 =	{
										["SPANISH"] = "Total Tiempo Jugado:",
										["ENGLISH"] = "Total Time Played:",
									},
				["TotalPlayers"] =	{
										["SPANISH"] = "Total Jugadores Presentes:",
										["ENGLISH"] = "Total Players Present:",
									},
				["TableDKP"]	 =	{
										["SPANISH"] = "Tabla Relacionada:",
										["ENGLISH"] = "Related Table:",
									},
				["Attendance"]	 =	{
										["SPANISH"] = "Asistencias",
										["ENGLISH"] = "Attendances",
									},
				["RaidLog"]		 =	{
										["SPANISH"] = "Raid Guardadas",
										["ENGLISH"] = "Raid Log",
									},
				["SaveLua"]		 =	{
										["SPANISH"] = "WTF/Account/*Tu cuenta*/SavedVariables",
										["ENGLISH"] = "WTF/Account/*Your account*/SavedVariables",
									},
					},

["Help_Frame"]	 =	{
				["Categories"]	 =	{
										["SPANISH"] = "Categorias:",
										["ENGLISH"] = "Categories:",
									},
					},

["Options_Frame"]=	{
				["TitleGral"]	 =	{
										["SPANISH"] = "Opciones Generales:",
										["ENGLISH"] = "General Options:",
									},
				["Info1Gral"]	 =	{
										["SPANISH"] = "Autocompletar info. del Item desde el Drop:",
										["ENGLISH"] = "Autofill Item Details From Drops:",
									},
				["Info2Gral"]	 =	{
										["SPANISH"] = "Registro de Inestabilidad ( Sindra ):",
										["ENGLISH"] = "Instability Record ( Sindra ):",
									},
				["Info3Gral"]	 =	{
										["SPANISH"] = "Award auto. por Boss Eliminado: (Solo clientes en ingles)",
										["ENGLISH"] = "Award auto. by Kill Boss: (English clients only)",
									},
				["Info4Gral"]	 =	{
										["SPANISH"] = "Activar/Desactivar",
										["ENGLISH"] = "Enable/Disable",
									},
				["Info5Gral"]	 =	{
										["SPANISH"] = "Alt + Click sobre un item para abrir Bidding",
										["ENGLISH"] = "Alt + Click on an item to open Bidding",
									},
				["Info6Gral"]	 =	{
										["SPANISH"] = "Ignorar /wisp de los que no estan en party",
										["ENGLISH"] = "Ignore /wisp of players who are not in party",
									},
				["Info7Gral"]	 =	{
										["SPANISH"] = "Especificar un DKP Cap",
										["ENGLISH"] = "Specify a DKP Cap",
									},
				["Info8Gral"]	 =	{
										["SPANISH"] = "GUI Language ( Solo WebDKP ):",
										["ENGLISH"] = "GUI Language ( Only WebDKP ):",
									},
				["Info9Gral"]	 =	{
										["SPANISH"] = "Registro de Muertes ( Fatality ):",
										["ENGLISH"] = "Death Record ( Fatality ):",
									},
				["Info10Gral"]	 =	{
										["SPANISH"] = "Borrado Automatico de Registros:",
										["ENGLISH"] = "Automatic Deletion of Records:",
									},
				["EnabledFill"]	 =	{
										["SPANISH"] = "Activar AutoCompl.",
										["ENGLISH"] = "Enable Autofill",
									},
				["LimitedFill"]	 =	{
										["SPANISH"] = "Limite / Rango:",
										["ENGLISH"] = "Limit / Range:",
									},
				["LDescrip"]	 =	{
										["SPANISH"] = "Puede requerir un /reload",
										["ENGLISH"] = "May require a /reload",
									},
				["LString"]		 =	{
										["SPANISH"] = "Idiomas Disponibles:",
										["ENGLISH"] = "Available Languages:",
									},
				["Fatality1"]	 =	{
										["SPANISH"] = "Activar Fatality Log",
										["ENGLISH"] = "Enable Fatality Log",
									},
				["Fatality2"]	 =	{
										["SPANISH"] = "Anunciar Muertes",
										["ENGLISH"] = "Announce Deaths",
									},
				["AutoClean1"]	 =	{
										["SPANISH"] = "Activar Auto Borrado",
										["ENGLISH"] = "Enable Auto Clear",
									},
				["AutoClean2"]	 =	{
										["SPANISH"] = "Borrar registros despues de:",
										["ENGLISH"] = "Delete records after:",
									},
				["AutoClean3"]	 =	{
										["SPANISH"] = "Dias! ( 0 No borra )",
										["ENGLISH"] = "Days! ( 0 Does not erase )",
									},
				["Sindra1"]		 =	{
										["SPANISH"] = "Activar Sindra Log",
										["ENGLISH"] = "Enable Sindra Log",
									},
				["Sindra2"]		 =	{
										["SPANISH"] = "Anunciar Contragolpes",
										["ENGLISH"] = "Announce Backlash",
									},
				["AltClick"]	 =	{
										["SPANISH"] = "Activar Alt+Click",
										["ENGLISH"] = "Enable Alt+Click",
									},
				["Ignore"]		 =	{
										["SPANISH"] = "Ignorar Activado",
										["ENGLISH"] = "Ignore Enabled",
									},
				["DKPCap"]		 =	{
										["SPANISH"] = "Activar DKP Cap",
										["ENGLISH"] = "Enable DKP Cap",
									},
				["CapLimit"]	 =	{
										["SPANISH"] = "Cap Limite:",
										["ENGLISH"] = "Cap Limit:",
									},
				["AmoutDKP"]	 =	{
										["SPANISH"] = "Monto DKP:",
										["ENGLISH"] = "Amount DKP:",
									},
				["EnableFor"]	 =	{
										["SPANISH"] = "Activar para",
										["ENGLISH"] = "Enable for",
									},
				["EnableWebDKP"] =	{
										["SPANISH"] = "Activar WebDKP",
										["ENGLISH"] = "Enable WebDKP",
									},
				["OptionsTitle"] =	{
										["SPANISH"] = "Eventos y Ofertas: Opciones",
										["ENGLISH"] = "Events and Bids: Options",
									},
				["AnnounceBidD"] =	{
										["SPANISH"] = "Anunciar por Alerta de Banda",
										["ENGLISH"] = "Announce by Band Alert",
									},
				["AnnounceBidN"] =	{
										["SPANISH"] = "(Al desactivar, solo anunciará por el canal /Banda)",
										["ENGLISH"] = "(When deactivated, it will only announce by /Raid)",
									},
				["ConfirmPopupD"]=	{
										["SPANISH"] = "Activar Ventana de Confirm.",
										["ENGLISH"] = "Enable Confirmation Window",
									},
				["ConfirmPopupN"]=	{
										["SPANISH"] = "(Podra modificar el coste del item antes de asignarlo)",
										["ENGLISH"] = "(You can modify the item cost before assigning it)",
									},
				["NegativeBidsD"]=	{
										["SPANISH"] = "Permitir Ofertas Negativas",
										["ENGLISH"] = "Allow Negative Bids",
									},
				["NegativeBidsN"]=	{
										["SPANISH"] = "(Los Jugadores podran ofertar sin limite DKP)",
										["ENGLISH"] = "(The Players can bid without limit DKP)",
									},
				["NotifyBidD"]	 =	{
										["SPANISH"] = "Notificar Oferta Superada",
										["ENGLISH"] = "Notify Bid Exceeded",
									},
				["NotifyBidN"]	 =	{
										["SPANISH"] = "(Notifica al anterior postor que su !bid fue superado)",
										["ENGLISH"] = "(Notify previous bidder that their !bid was exceeded)",
									},
				["BidsPerBandD"] =	{
										["SPANISH"] = "Activar Ofertas por Banda",
										["ENGLISH"] = "Enable Bids Per Band",
									},
				["BidsPerBandN"] =	{
										["SPANISH"] = "(Recibe/Rechaza los '!bid' por /Banda)",
										["ENGLISH"] = "(Receive/Reject the '!bid' by /Raid)",
									},
				["AutoGiveD"]	 =	{
										["SPANISH"] = "Auto Entregar Items Finalizados",
										["ENGLISH"] = "Auto Give Finished Items",
									},
				["AutoGiveN"]	 =	{
										["SPANISH"] = "(Requiere ML, entrega desde el Loot el item al player)",
										["ENGLISH"] = "(Requires ML, give the item from the Loot to player)",
									},
				["AnonymusBidsD"]=	{
										["SPANISH"] = "Activar Ofertas Anonimas",
										["ENGLISH"] = "Enable Anonymous Bids",
									},
				["AnonymusBidsN"]=	{
										["SPANISH"] = "(Oculta toda info de los postores durante el evento)",
										["ENGLISH"] = "(Hides all info of the bidders during the event)",
									},
				["SilentEventsD"]=	{
										["SPANISH"] = "Eventos Silenciosos",
										["ENGLISH"] = "Silent Events",
									},
				["SilentEventsN"]=	{
										["SPANISH"] = "(No habra ningun anuncio relacionado al evento)",
										["ENGLISH"] = "(There will be no announcement related to the event)",
									},
				["BidsAndRollD"] =	{
										["SPANISH"] = "Capturar Rolls en Eventos",
										["ENGLISH"] = "Capture Rolls in Events",
									},
				["BidsAndRollN"] =	{
										["SPANISH"] = "(Al activar, aparte del !bid, captura los /dados)",
										["ENGLISH"] = "(When Enabled, apart from the !bid, it captures /Roll)",
									},
				["PercentageD"]	 =	{
										["SPANISH"] = "Activar Porcentaje entre !bid",
										["ENGLISH"] = "Enable Percentage between !Bid",
									},
				["PercentageN"]	 =	{
										["SPANISH"] = "(Distancia las ofertas a traves de un porcentaje fijo)",
										["ENGLISH"] = "(Distance the bids through a fixed percentage)",
									},
				["ValuePercent"] =	{
										["SPANISH"] = "Porcentaje (%):",
										["ENGLISH"] = "Percentage (%):",
									},
				["CostFixedFSD"] =	{
										["SPANISH"] = "Fijar Coste por Defecto F/S",
										["ENGLISH"] = "Set Default Cost F/S",
									},
				["CostFixedFSN"] =	{
										["SPANISH"] = "(Al desactivarlo, usa el 'Oferta Inicial' de Bidding)",
										["ENGLISH"] = "(When disabled, use 'Starting Bid' of Bidding)",
									},
				["ValueCost"]	 =	{
										["SPANISH"] = "Coste fijo (DKP):",
										["ENGLISH"] = "Fixed cost (DKP):",
									},
				["AutomaticBidD"]=	{
										["SPANISH"] = "Activar !bid Automatico",
										["ENGLISH"] = "Enable Automatic !bid",
									},
				["AutomaticBidN"]=	{
										["SPANISH"] = "(Si desactiva, el formato sera !bid + monto siempre)",
										["ENGLISH"] = "(If disabled, the format will be !bid + amount always)",
									},
				["ValueAutoBid"] =	{
										["SPANISH"] = "Inicio del !bid Auto:",
										["ENGLISH"] = "Start Automatic !bid:",
									},
				["PlayersFail"]	 =	{
										["SPANISH"] = "Registro de Fallos del Jugador: Seleccionar Preferencias",
										["ENGLISH"] = "Player's Fail Log: Select Preferences",
									},
				["ComingSoon"]	 =	{
										["SPANISH"] = "Proximamente :)",
										["ENGLISH"] = "Coming Soon :)",
									},
				["Announce1"]	 =	{
										["SPANISH"] = "Anuncio Personalizado Para:",
										["ENGLISH"] = "Custom Announcement For:",
									},
				["Announce2"]	 =	{
										["SPANISH"]	= "Anuncios Personalizados:",
										["ENGLISH"] = "Custom Announcements",
									},
				["Announce3"]	 =	{
										["SPANISH"] = "Iniciar un Evento",
										["ENGLISH"] = "Start an Event",
									},
				["Announce4"]	 =	{
										["SPANISH"] = "Durante un Evento ( Con Limite de Tiempo )",
										["ENGLISH"] = "During an Event ( With Time Limit )",
									},
				["Announce5"]	 =	{
										["SPANISH"] = "Finalizar un Evento",
										["ENGLISH"] = "End an Event",
									},
				["Announce6"]	 =	{
										["SPANISH"] = "Iniciar un Roll",
										["ENGLISH"] = "Start a Roll",
									},
				["Announce7"]	 =	{
										["SPANISH"] = "Durante un Roll ( Con Limite de Tiempo )",
										["ENGLISH"] = "During a Roll ( With Time Limit )",
									},
				["Announce8"]	 =	{
										["SPANISH"] = "Finalizar un Roll",
										["ENGLISH"] = "End a Roll",
									},
				["Customing"]	 =	{
										["SPANISH"] = "Activar Personalización",
										["ENGLISH"]	= "Enable Customing",
									},
					},
					
["RaidInfoFrame"]=	{
				["Attended"]	 =	{
										["SPANISH"] = "Asistencias",
										["ENGLISH"] = "Attendances",
									},
				["DirTime"]		 =	{
										["SPANISH"] = "Aqui puede ajustar el tiempo total jugado de una Raid.",
										["ENGLISH"] = "Here you can adjust the total time played for a Raid.",
									},
				["DirChar"]		 =	{
										["SPANISH"] = "Aqui puede agregar o quitar a un player de la lista de asistencia.",
										["ENGLISH"] = "Here you can add or remove a player from the attendance list.",
									},
				["TotalTime"]	 =	{
										["SPANISH"] = "Tiempo Total",
										["ENGLISH"] = "Total Time",
									},
				["EndTimeAdjust"]=	{
										["SPANISH"] = "Tiempo en Horas:",
										["ENGLISH"] = "Time in Hours:",
									},
				["AdjustTime"]	 =	{
										["SPANISH"] = "Ajustar Tiempo",
										["ENGLISH"] = "Adjust Time",
									},
				["DeleteRaid"]	 =	{
										["SPANISH"] = "Eliminar Raid",
										["ENGLISH"] = "Delete Raid",
									},
					},

["TimedAward_Frame"]={
				["HeaderText"]	 =	{
										["SPANISH"] = "Los premios cronometrados le permiten otorgar DKP automáticamente\ndespués de que haya pasado un tiempo establecido",
										["ENGLISH"] = "Timed awards allow you to automatically award DKP\nafter a set time has passed",
									},
				["Points"]		 =	{
										["SPANISH"] = "Puntos:",
										["ENGLISH"] = "Points:",
									},
				["TimeString1"]  =	{
										["SPANISH"] = "Tiempo:",
										["ENGLISH"] = "Time:",
									},
				["TimeString2"]	 =	{
										["SPANISH"] = "( en minutos )",
										["ENGLISH"] = "( in minutes )",
									},
				["RepeatAward"]	 =	{
										["SPANISH"] = "Repetir Award",
										["ENGLISH"] = "Repeat Award",
									},
					},

["Records_Frame"]=	{
				["SaveLog"]		 =	{
										["SPANISH"] = "Salvar Registro",
										["ENGLISH"] = "Save Log",
									},
				["DelLog"]		 =	{
										["SPANISH"] = "Eliminar Registro",
										["ENGLISH"] = "Delete Log",
									},
				["UndoAward"]	 =	{
										["SPANISH"] = "Deshacer Award",
										["ENGLISH"] = "Undo Award",
									},
				["UpdateLog"]	 =	{
										["SPANISH"] = "Actulizar Registro",
										["ENGLISH"] = "Update Log",
									},
				["AssignTo"]	 =	{
										["SPANISH"] = "Asignado a",
										["ENGLISH"] = "Assign To",
									},
				["MurderedBy"]	 =	{
										["SPANISH"] = "Asesinado Por",
										["ENGLISH"] = "Murdered By",
									},
				["ReasonFLog"]	 =	{
										["SPANISH"] = "Razón o Motivo de la Muerte",
										["ENGLISH"] = "Reason or Motive for Death",
									},
				["Penalty"]		 =	{
										["SPANISH"] = "Penalizarlo con:",
										["ENGLISH"] = "Penalize him with:",
									},
				["Question"]	 =	{
										["SPANISH"] = "Esta seguro que quiere eliminar TODOS los registros?",
										["ENGLISH"] = "Are you sure you want to delete ALL records?",
									},
				["FileDir"]		 =	{
										["SPANISH"] = "Ubicacion del Archivo de Datos:                     WTF/Account/*tu cuenta*/SavedVariables/WebDKP_Options.lua",
										["ENGLISH"] = "Data File Location:                                       WTF/Account/*your account*/SavedVariables/WebDKP_Options.lua",
									},
				["SelectAward"]	 =	{
										["SPANISH"] = "Puedes agregar o quitar a un personaje de un award aquí. Primero, seleccione el award.",
										["ENGLISH"] = "You can add or remove a character from an award here. First, select the award.",
									},
					},

["Equipament"]	 =	{
				["HeadSlot"]	 =	{
										["SPANISH"] = "Cabeza",
										["ENGLISH"] = "Head",
									},
				["NeckSlot"]	 =	{
										["SPANISH"] = "Collar",
										["ENGLISH"] = "Neck",
									},
				["ShouldersSlot"]=	{
										["SPANISH"] = "Hombros",
										["ENGLISH"] = "Shoulders",
									},
				["BackSlot"]	 =	{
										["SPANISH"] = "Espalda",
										["ENGLISH"] = "Back",
									},
				["ChestSlot"]	 =	{
										["SPANISH"] = "Pecho",
										["ENGLISH"] = "Chest",
									},
				["WristsSlot"]	 =	{
										["SPANISH"] = "Muñeca",
										["ENGLISH"] = "Wrists",
									},
				["HandsSlot"]	 =	{
										["SPANISH"] = "Manos",
										["ENGLISH"] = "Hands",
									},
				["WaistSlot"]	 =	{
										["SPANISH"] = "Cintura",
										["ENGLISH"] = "Waist",
									},
				["LegsSlot"]	 =	{
										["SPANISH"] = "Piernas",
										["ENGLISH"] = "Legs",
									},
				["FeetSlot"]	 =	{
										["SPANISH"] = "Pies",
										["ENGLISH"] = "Feet",
									},
				["FingersSlot"]	 =	{
										["SPANISH"] = "Dedo",
										["ENGLISH"] = "Fingers",
									},
				["TrinketsSlot"] =	{
										["SPANISH"] = "Abalorio",
										["ENGLISH"] = "Trinkets",
									},
				["MainHandSlot"] =	{
										["SPANISH"] = "Arma Principal",
										["ENGLISH"] = "Mainhand Weapon",
									},
				["ShieldSlot"]	 =	{
										["SPANISH"] = "Escudo",
										["ENGLISH"] = "Shield",
									},
				["RangedSlot"]	 =	{
										["SPANISH"] = "A Distancia",
										["ENGLISH"] = "Ranged",
									},
				["RelicSlot"]	 =	{
										["SPANISH"] = "Reliquia",
										["ENGLISH"] = "Relic",
									},
				["TwoHandSlot"]	 =	{
										["SPANISH"] = "Arma de Dos Manos",
										["ENGLISH"] = "Two Hand",
									},
				["OneHandSlot"]	 =	{
										["SPANISH"] = "Arma de Una Mano",
										["ENGLISH"] = "One Hand",
									},
				["OffhandWeapon"]=	{
										["SPANISH"] = "Arma Secundaria",
										["ENGLISH"] = "Offhand Weapon",
									},
				["HeldInOffhand"]=	{
										["SPANISH"] = "Sostener con la Mano Izquierda",
										["ENGLISH"] = "Held In Offhand",
									},
				["IdolSlot"]	 =	{
										["SPANISH"] = "Idolo",
										["ENGLISH"] = "Idol",
									},
					},
}

-- :)