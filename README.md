WebDKP v4.7.1: By SnGa (20/06/21)
WebDKP_Options:
Se agrego una extensión como parte fundamental y necesaria para el correcto funcionamiento del WebDKP, la cual tendrá un fuerte impacto sobre él y se requiere loguear con todos los personajes de una cuenta antes de personalizar las opciones del AddOn.

Configuración Global:
Gracias a la nueva extensión, desde ahora se guardara todas las opciones del WebDKP en su extensión para que estas sean iguales en todos los personajes que se encuentren en una misma cuenta.

Nueva ubicación de datos de los Registros (F/S/R&A): 
En consecuencia a esta nueva extensión, ahora los datos los registros son guardados en el archivo WebDKP_Options.lua que se encuentra dentro de Saved Variables. Esto permite que los registros se mantengan sin cambios aun realizando la actualización del archivo WebDKP.lua, ya que son archivos totalmente distintos.

GUI Language ( Solo WebDKP ):
Se agrego múltiples idiomas al AddOn ( Ingles por Defecto ), con la posibilidad de ampliar a mas idiomas en un futuro. 

Sistema de Ventas de Items Mejorado:
Permite transformar la subasta de items en un sistema de ventas. Para ello, es necesario tener activado Loot Table en las opciones de la pagina oficial y agregar desde allí los precios de los items.
También puede definir desde el addon el precio del ítem según su nivel y/o tipo.

Sistema de Asistencias y Registros de Raids Mejorados:
Ahora podrá registrar la asistencia al inicio de su Raid y finalizarla en cualquier momento sin importar si cambio a otro avatar.  Esto le ayudara a realizar el seguimiento de asistencias de los participantes en cada Raid. 

DKP Casino:
Los jugadores podrán apostar un cierto monto de DKPs utilizando los comandos !casino + monto y luego tipear /dados para intentar duplicarlos. En caso de arrepentirse, puede tipear !cancelar para anular la apuesta.

FIX Realizados:
Ofertas Anónimas & Subastas Silenciosas: Ahora ya no notificará por banda que hubo un ganador al tener estas dos opciones activadas al mismo tiempo.
Post Eliminación de un Award: Ahora deshabilitará el cuadro de ingreso de nombres y las opciones Agregar, Eliminar y Deshacer award despues de la eliminación de un award correctamente.
Search by Name: Se agrego un buscador por nombres en la tabla DKP
Código de Colores en la ventada de Bidding: Los nombres de los postores se coloreará de acuerdo al tipo de oferta aceptada (verde para !bid normal positiva, roja para !bid normal negativa, naranja para !bidall)
Ajustes Visuales: Se perfilaron de manera mas prolija cuadros, botones, textos, etc. para una mejor experiencia de uso.
Asignar Item: Corregido error que no dejaba asignar items al ganador.
Casino: Corregido error que realizaba la sumatoria de varios jugadores en uno solo.
Casino in Combat: Ahora solamente se podrá jugar en el casino cuando no haya combate.



WebDKP v4.5.7: By SnGa (21/04/21)
Agregado Borrado Automático de Registros:
Para aquellas personas que no actualizan el archivo .lua en la pagina o que ya no administran los dkps de alguna raid o que simplemente usan el WebDKP para estar al tanto de los registros de inestabilidad y los registros de muertes. 
Al no actualizar el archivo .lua, los registros siguen estando vigentes (a menos que sean borrados manualmente) y por lo tanto puede hacer que el tamaño del archivo local crezca, ralentizando la carga de la interfaz del juego.
Para solucionar esto, se implemento un sistema que auto elimina los registros viejos con respecto a una duración definida por el usuario. Este sistema se puede activar o no, y en caso de estarlo, se puede configurar la duración máxima de los registros (se eliminaran solamente los que ya tengan dicha duración cumplida).

FIX Realizados:
Agregado mas botones de acceso directo en DKP Tabla ( Ayuda, Bidding Table, Options ).
Se elimino el comando !item y en su lugar se agregaron los comandos !actual y !anterior.
IA de los Registros: Con la ayuda de los feedbacks obtenidos, se logro perfeccionar el algoritmo de ambos registros y, por lo tanto, se maximizo su eficiencia y se redujo el margen de error en comparación a versiones anteriores.
Fatality: Anunciar Muertes: Ahora se puede activar o desactivar los mensajes de banda del registro de muertes, independientemente si el registro esta capturando datos o no. 
Sindra: Anunciar Contragolpes: Ahora se puede activar o desactivar los mensajes de banda del registro de inestabilidad, independientemente si el registro esta capturando datos o no (en caso de estar activado, se requiere para ser anunciado que el contragolpe se haya producido de la perdida de al menos 5 marcas de inestabilidad acumuladas)
Registro de Awards: Ahora también se dividirán de acuerdo a la tabla de dkps seleccionada.



WebDKP v4.5: By SnGa (13/04/21)
Traducción al español del 98% alcanzado

Agregado botones de acceso directo en la ventana de DKP Tabla ( Sindra Log, Fatality Log, Award Log )

Agregado sistema de Ofertas Anonimas, los jugadores podrán apostar por un ítem ( siempre por /wisp ) de manera anónima, es decir, los anuncios relacionados a la subasta no contendrá el nombre del postor ( Esta función es activable de manera manual )

Agregado sistema de Descuentos Directos: a traves de la ventana del Registro de muertes ( Fatality ) y del Registro de Inestabilidad ( Sindragosa ) se podrán realizar sanciones a los jugadores directamente desde el mismo registro, con la opción de personalizar el monto del descuento.

Agregado funciones con Shift + Click, ahora al abrir la tabla de dkp y los registros al mismo tiempo y al realizar esta combinación sobre el botón de cerrar, cerrara ademas todos los registros. También al hacer esta combinación sobre los registros del Fatality, linkeará la razón para poder verla con mas detalle.

FIX Realizados:
Notificar Oferta Superada: Ahora es posible activar o desactivar los /wisp que notifican a un postor que su oferta fue superada por alguien mas
Porcentaje entre Bid Custom: Ahora se puede activar o desactivar el porcentaje entre ofertas y personalizar dicho porcentaje a gusto del portador del addon.
Subastas Sileciosas: Incrementado el nivel de silencio, ahora el addon no hará ningún tipo de anuncio relacionado  a la subasta, solo notificara por /wisp a los postores que participen de ella.
!Bid Automatico: Ahora se puede activar o desactivar y personalizar el monto a alcanzar antes de activarse
Registros Mejorados: Se ha optimizado la codificación de los registros de Fatality y Sindragosa, como así también el sistema de registros de ambos de acuerdo a la tabla de dkps seleccionada, es decir, los registros se dividirán de acuerdo a dicha tabla.



WebDKP v4.3.089: By SnGa (11/09/20)
Agregado Traducción al español (75%)

Agregado Registro de Inestabilidad ( Sindragosa ): 
Se almacena y se imprime en pantalla los contragolpes de las explosiones del debuff de inestabilidad de los PJs, cuantos stacks de inestabilidad y/o sacudida mística tenían en el momento y el daño y/o muerte por contragolpe.

Agregado porcentaje entre !bid (5%)

Agregado Anuncios varios (!bid aceptados, reapertura de subasta, !bidall realizados, anulación de Award)

Agregado Wisp varios (oferta superada, oferta rechazada, oferta incorrecta)

Agregado Multiplicador de Award en ventada de confirmación.

Agregado botón Limpiar Ofertas! para subastas con ofertas incorrectas.

Agregado elección del canal de !bid (/raid o /wisp)

Agregado comando !item para informar el estado del ítem que se encuentre actualmente en subasta.

Agregado Multifunción del comando !bid, a partir de 2500, al escribir el comando sin oferta, ofertara automáticamente el mínimo posible.

Agregado Registro de Muertes ( Fatality ): 
Se anuncia, se almacena y se imprime en pantalla la muertes de los PJs en todo momento y duración de la instancia, de igual forma que el AddOn Fatality original (Quien murió, que o quien lo mato, con que lo mato y en que momento).

FIX Realizados:
Excepción agregada: Los !bidall NO respetan el 5% entre !bid.
Los comandos !bidall y !bid (el automático después de 2500) realizados por el channel de banda ahora si funcionan como deben.
Ampliado el catalogo de Instancias admitidas por el Registro de Muertes ( Fatality ) (Todas las de 10/25 PJs de Lich King)
El botón Limpiar Ofertas! ahora si limpia el historial de ofertas de manera visualmente correcta en la ventana Bidding.
Al reanudar una subasta ahora se mantendrá el ultimo !bid mas alto aceptado correctamente en la ventana Bidding.



Nota: El archivo .lua generado por mi versión del AddOn sigue siendo retrocompatible con versiones anteriores y originales de la pagina oficial, es decir, que no tendrán problema si pasan de una versión a otra.
