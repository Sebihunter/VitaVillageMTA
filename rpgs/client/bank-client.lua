--[[
Project: VitaOnline
File: bank-client.lua
Author(s):	MrX
			CubedDeath
]]--

BankKontoEinloggenWindow = {}
BankKontoEinloggenButton = {}
BankKontoEinloggenLabel = {}
BankKontoEinloggenEdit = {}
 
BankKontoEinloggenWindow[1] = guiCreateWindow(screenWidth/2-311/2,screenHeight/2-225/2,311,225,"Bank von San Andreas",false)
BankKontoEinloggenLabel[1] = guiCreateLabel(10,37,161,15,"Bitte tragen sie Ihren Kontonamen ein:",false,BankKontoEinloggenWindow[1])
guiLabelSetColor(BankKontoEinloggenLabel[1],255,255,255)
guiLabelSetVerticalAlign(BankKontoEinloggenLabel[1],"top")
guiLabelSetHorizontalAlign(BankKontoEinloggenLabel[1],"left",false)
guiSetFont(BankKontoEinloggenLabel[1],"default-small")
BankKontoEinloggenEdit[1] = guiCreateEdit(9,56,161,19,"",false,BankKontoEinloggenWindow[1])
BankKontoEinloggenButton[1] = guiCreateButton(202,57,98,18,"Einloggen",false,BankKontoEinloggenWindow[1])
guiSetFont(BankKontoEinloggenButton[1],"default-small")
BankKontoEinloggenLabel[2] = guiCreateLabel(10,109,177,17,"Sie haben noch gar kein Konto?",false,BankKontoEinloggenWindow[1])
guiLabelSetColor(BankKontoEinloggenLabel[2],255,0,0)
guiLabelSetVerticalAlign(BankKontoEinloggenLabel[2],"top")
guiLabelSetHorizontalAlign(BankKontoEinloggenLabel[2],"left",false)
guiSetFont(BankKontoEinloggenLabel[2],"default-bold-small")
BankKontoEinloggenLabel[3] = guiCreateLabel(10,126,296,51,"Kein Problem! Bei uns koennen Sie innerhalb von einer Minute schon Inhaber eines neuen Girokontos sein!",false,BankKontoEinloggenWindow[1])
guiLabelSetColor(BankKontoEinloggenLabel[3],125,125,125)
guiLabelSetVerticalAlign(BankKontoEinloggenLabel[3],"top")
guiLabelSetHorizontalAlign(BankKontoEinloggenLabel[3],"left",true)
guiSetFont(BankKontoEinloggenLabel[3],"clear-normal")
BankKontoEinloggenButton[2] = guiCreateButton(9,187,132,25,"Neues Konto Erstellen",false,BankKontoEinloggenWindow[1])
guiSetFont(BankKontoEinloggenButton[2],"default-small")
BankKontoEinloggenButton[3] = guiCreateButton(168,187,132,25,"Schliessen",false,BankKontoEinloggenWindow[1])
guiSetAlpha(BankKontoEinloggenButton[3],1)
guiSetFont(BankKontoEinloggenButton[3],"default-small")
BankKontoEinloggenLabel[4] = guiCreateLabel(9,80,270,15,"Sie haben keinen Zugriff auf dieses Konto!",false,BankKontoEinloggenWindow[1])
guiLabelSetColor(BankKontoEinloggenLabel[4],125,125,0)
guiLabelSetVerticalAlign(BankKontoEinloggenLabel[4],"top")
guiLabelSetHorizontalAlign(BankKontoEinloggenLabel[4],"left",false)

guiWindowSetSizable(BankKontoEinloggenWindow[1], false)
guiSetVisible(BankKontoEinloggenWindow[1], false)
guiSetVisible(BankKontoEinloggenLabel[4], false)
 
BankKontoUebersichtWindow = {}
BankKontoUebersichtButton = {}
BankKontoUebersichtLabel = {}
BankKontoUebersichtEdit = {}
    
BankKontoUebersichtWindow[1] = guiCreateWindow(screenWidth/2-311/2,screenHeight/2-225/2,311,225,"Bank von San Andreas",false)
BankKontoUebersichtLabel[1] = guiCreateLabel(10,27,290,20,"Kontoname: Deine Mutter",false,BankKontoUebersichtWindow[1])
guiLabelSetColor(BankKontoUebersichtLabel[1],125,125,125)
guiLabelSetVerticalAlign(BankKontoUebersichtLabel[1],"top")
guiSetFont(BankKontoUebersichtLabel[1],"clear-normal")
BankKontoUebersichtButton[1] = guiCreateButton(168,90,98,18,"Einzahlen",false,BankKontoUebersichtWindow[1])
guiSetFont(BankKontoUebersichtButton[1],"default-small")
BankKontoUebersichtButton[2] = guiCreateButton(223,196,77,20,"Schliessen",false,BankKontoUebersichtWindow[1])
guiSetFont(BankKontoUebersichtButton[2],"default-small")
BankKontoUebersichtLabel[2] = guiCreateLabel(10,52,41,16,"Saldo:",false,BankKontoUebersichtWindow[1])
guiLabelSetColor(BankKontoUebersichtLabel[2],0,255,0)
guiLabelSetVerticalAlign(BankKontoUebersichtLabel[2],"top")
guiSetFont(BankKontoUebersichtLabel[2],"default-bold-small")
BankKontoUebersichtEdit[1] = guiCreateEdit(10,87,143,22,"Geldbetrag...",false,BankKontoUebersichtWindow[1])
BankKontoUebersichtLabel[3] = guiCreateLabel(51,43,249,33,"5000 Vero",false,BankKontoUebersichtWindow[1])
guiLabelSetColor(BankKontoUebersichtLabel[3],255,255,255)
guiLabelSetVerticalAlign(BankKontoUebersichtLabel[3],"center")
guiSetFont(BankKontoUebersichtLabel[3],"default-small")
BankKontoUebersichtButton[3] = guiCreateButton(168,118,98,18,"Abheben",false,BankKontoUebersichtWindow[1])
guiSetFont(BankKontoUebersichtButton[3],"default-small")
BankKontoUebersichtButton[5] = guiCreateButton(168,140,98,18,"Spende für Events",false,BankKontoUebersichtWindow[1])
guiSetFont(BankKontoUebersichtButton[5],"default-small")
BankKontoUebersichtButton[4] = guiCreateButton(168,166,98,18,"Überweisungen",false,BankKontoUebersichtWindow[1])
guiSetFont(BankKontoUebersichtButton[4],"default-small")
BankKontoUebersichtLabel[4] = guiCreateLabel(10,195,190,20,"Fehler: Konto nicht gefunden!",false,BankKontoUebersichtWindow[1])
guiLabelSetColor(BankKontoUebersichtLabel[4],255,0,0)
guiLabelSetVerticalAlign(BankKontoUebersichtLabel[4],"top")
guiSetFont(BankKontoUebersichtLabel[4],"clear-normal")
--BankKontoUebersichtButton[5] = guiCreateButton(32,156,98,18,"Dispokredit",false,BankKontoUebersichtWindow[1])
--guiSetFont(BankKontoUebersichtButton[5],"default-small")
BankKontoUebersichtEdit[2] = guiCreateEdit(10,115,143,22,"Grund....",false,BankKontoUebersichtWindow[1])
 
 
guiWindowSetSizable(BankKontoUebersichtWindow[1], false)
guiSetVisible(BankKontoUebersichtWindow[1], false)

BankKontoUeberweisenWindow = {}
BankKontoUeberweisenButton = {}
BankKontoUeberweisenLabel = {}
BankKontoUeberweisenEdit = {}
BankKontoUberweisenGridList = {}
BankKontoUeberweisenWindow[1] = guiCreateWindow(screenWidth/2-500/2,screenHeight/2-300/2,500,300,"Bank von San Andreas",false)
BankKontoUeberweisenButton[1] = guiCreateButton(400,270,77,20,"Schliessen",false,BankKontoUeberweisenWindow[1])

BankKontoUeberweisenLabel[1] = guiCreateLabel(10,27,41,16,"Geld",false,BankKontoUeberweisenWindow[1])
BankKontoUeberweisenLabel[2] = guiCreateLabel(95,27,90,16,"Empfänger",false,BankKontoUeberweisenWindow[1])
BankKontoUeberweisenEdit[1] = guiCreateEdit(10,47,80,22,"",false,BankKontoUeberweisenWindow[1])
BankKontoUeberweisenEdit[2] = guiCreateEdit(95,47,80,22,"",false,BankKontoUeberweisenWindow[1])
BankKontoUeberweisenLabel[3] = guiCreateLabel(10,77,250,16,"Überweisungsgrund",false,BankKontoUeberweisenWindow[1])
BankKontoUeberweisenEdit[3] = guiCreateEdit(10,97,165,22,"",false,BankKontoUeberweisenWindow[1])
BankKontoUeberweisenButton[2] = guiCreateButton(185,98,98,18,"Überweisen",false,BankKontoUeberweisenWindow[1])
guiSetFont(BankKontoUeberweisenButton[2],"default-small")
guiSetFont(BankKontoUeberweisenButton[1],"default-small")
 

BankKontoUberweisenGridList[1] = guiCreateGridList(6,130,470,120,false,BankKontoUeberweisenWindow[1])
guiGridListAddColumn(BankKontoUberweisenGridList[1],"Geld",0.1)
guiGridListAddColumn(BankKontoUberweisenGridList[1],"Typ",0.3)
guiGridListAddColumn(BankKontoUberweisenGridList[1],"Info",0.5)

addEventHandler("onClientGUIClick", BankKontoUeberweisenButton[2], function()
	if source ~= BankKontoUeberweisenButton[2] then return end
	if tonumber(guiGetText(BankKontoUeberweisenEdit[1])) and guiGetText(BankKontoUeberweisenEdit[2]) ~= "" then
		if tonumber(guiGetText(BankKontoUeberweisenEdit[1])) ~= math.round(tonumber(guiGetText(BankKontoUeberweisenEdit[1]))) then return addNotification(1, 255, 0, 0, "Kommazahlen sind nicht erlaubt.") end
		triggerServerEvent("bank2:transfer", getLocalPlayer(), bankGUI.accountname , guiGetText(BankKontoUeberweisenEdit[2] ), math.round(tonumber(guiGetText(BankKontoUeberweisenEdit[1]))), guiGetText(BankKontoUeberweisenEdit[3]))
	end
end)

guiWindowSetSizable( BankKontoUeberweisenWindow[1], false)
guiSetVisible( BankKontoUeberweisenWindow[1], false)
 
BankKontoDispoWindow = {}
BankKontoDispoButton = {}
BankKontoDispoLabel = {}
BankKontoDispoGrid = {}
 
BankKontoDispoWindow[1] = guiCreateWindow(screenWidth/2-243/2,screenHeight/2-225/2,243,225,"Bank von San Andreas",false)
BankKontoDispoLabel[1] = guiCreateLabel(10,27,190,20,"Dispokredit:",false,BankKontoDispoWindow[1])
guiLabelSetColor(BankKontoDispoLabel[1],125,125,125)
guiLabelSetVerticalAlign(BankKontoDispoLabel[1],"top")
guiSetFont(BankKontoDispoLabel[1],"clear-normal")
BankKontoDispoButton[1] = guiCreateButton(154,196,77,20,"Schliessen",false,BankKontoDispoWindow[1])
guiSetFont(BankKontoDispoButton[1],"default-small")
BankKontoDispoLabel[2] = guiCreateLabel(12,57,60,16,"Dispoauswahl:",false,BankKontoDispoWindow[1])
guiLabelSetColor(BankKontoDispoLabel[2],255,255,255)
guiLabelSetVerticalAlign(BankKontoDispoLabel[2],"center")
guiSetFont(BankKontoDispoLabel[2],"default-small")
BankKontoDispoButton[2] = guiCreateButton(10,198,95,18,"Dispo beantragen",false,BankKontoDispoWindow[1])
guiSetFont(BankKontoDispoButton[2],"default-small")
BankKontoDispoGrid[1] = guiCreateGridList(10,77,221,111,false,BankKontoDispoWindow[1])
guiGridListSetSelectionMode(BankKontoDispoGrid[1],2)
guiGridListAddColumn(BankKontoDispoGrid[1], "Dispo", 0.4)
guiGridListAddColumn(BankKontoDispoGrid[1], "Kosten", 0.4)

guiWindowSetSizable(BankKontoDispoWindow[1], false)
guiSetVisible(BankKontoDispoWindow[1], false)

bankGUI = {}
bankGUI.loginWindow = {}
bankGUI.uebersichtWindow = {}
bankGUI.dispoWindow = {}
bankGUI.ueberweisenWindow = {}
bankGUI.account = 0
bankGUI.accountname = ""
bankGUI.accountState = 0
bankGUI.isOpen = false

function bankGUI.loginWindow.close()
	bankGUI.isOpen = false
	guiSetInputEnabled(false)
	showCursor(false)
	removeEventHandler("onClientGUIClick", BankKontoEinloggenButton[1],  bankGUI.loginWindow.openAccount)
	removeEventHandler("onClientGUIAccepted", BankKontoEinloggenEdit[1],  bankGUI.loginWindow.openAccount)
	removeEventHandler("onClientGUIClick", BankKontoEinloggenButton[3],  bankGUI.loginWindow.close)
	guiSetVisible(BankKontoEinloggenWindow[1], false)
	removeEventHandler("onClientGUIClick", BankKontoEinloggenButton[2],  bankGUI.loginWindow.createAccount)
end
function bankGUI.loginWindow.open()
	if bankGUI.isOpen then return end
	bankGUI.isOpen = true
	guiSetInputEnabled(true)
	guiSetVisible(BankKontoEinloggenWindow[1], true)
	guiSetVisible(BankKontoEinloggenLabel[4], false)
	addEventHandler("onClientGUIClick", BankKontoEinloggenButton[1],  bankGUI.loginWindow.openAccount, false)
	addEventHandler("onClientGUIClick", BankKontoEinloggenButton[2],  bankGUI.loginWindow.createAccount, false)
	addEventHandler("onClientGUIClick", BankKontoEinloggenButton[3],  bankGUI.loginWindow.close, false)
	addEventHandler("onClientGUIAccepted", BankKontoEinloggenEdit[1],  bankGUI.loginWindow.openAccount, false)
	showTutorialMessage("bank_1", "Du kannst dich beim ATM jeweils mit 'Vorname.Nachname' mit deinem Konto authentifizieren. Als Fraktions- oder Gangchef kannst du mit dem Kontonamen der Organisation auf ihr Konto zugreifen.")
end
function bankGUI.loginWindow.openAccount()
	local text = guiGetText(BankKontoEinloggenEdit[1])
	bankGUI.accountname = text
	triggerServerEvent("bank2:openAccount", getLocalPlayer(), text)
	addEventHandler("bank2.client:openAccount:return", getRootElement(), bankGUI.loginWindow.openAccountreturn, false)
	guiSetInputEnabled(true)
end

function bankGUI.loginWindow.openAccountreturn(retval)
	outputDebugString(tostring(retval))
	if retval ~= -1 then
		bankGUI.account = retval -- Account laden bzw. zwischenspeichern
		bankGUI.loginWindow.close()
		bankGUI.uebersichtWindow.open()
	else
		guiSetText(BankKontoEinloggenLabel[4], "Sie haben keine Zugriff auf dieses Konto!")
		guiSetVisible(BankKontoEinloggenLabel[4], true)
	end
	removeEventHandler("bank2.client:openAccount:return", getRootElement(), bankGUI.loginWindow.openAccountreturn)
end

function bankGUI.loginWindow.createAccount()
	local dispo = 0
	triggerServerEvent("bank2:createNewAccount", getLocalPlayer(), dispo)
	addEventHandler("bank2.client:createAccount:return", getRootElement(), bankGUI.loginWindow.openAccountreturn, false)
	guiSetInputEnabled(true)
end

function bankGUI.loginWindow.createAccountreturn(retval)
	if retval == 1 then
		guiSetText(BankKontoEinloggenLabel[4], "Konto erfolgreich erstellt.")
		setTimer(bankGUI.loginWindow.close, 3000, 1)
		setTimer(bankGUI.uebersichtWindow.open, 3000, 1)
	elseif retval == -1 then
		guiSetText(BankKontoEinloggenLabel[4], "Sie besitzen bereits ein Konto!")
	end
	removeEventHandler("bank2.client:createAccount:return", getRootElement, bankGUI.loginWindow.createAccountreturn)
end

function bankGUI.uebersichtWindow.open()
	bankGUI.isOpen = true
	guiSetInputEnabled(true)
	guiSetText(BankKontoUebersichtLabel[1], "Kontoname: "..bankGUI.account["name"])
	guiSetText(BankKontoUebersichtLabel[3], bankGUI.account["geld"].." Vero")
	if bankGUI.account["type"] == 1 then
		guiSetVisible(BankKontoUebersichtEdit[2], true)
	else
		guiSetVisible(BankKontoUebersichtEdit[2], false)
	end
	guiSetVisible(BankKontoUebersichtLabel[4], false)
	guiSetVisible(BankKontoUebersichtWindow[1], true)
	guiSetInputEnabled(true)
	addEventHandler("onClientGUIClick", BankKontoUebersichtButton[2],  bankGUI.uebersichtWindow.close, false)
	addEventHandler("onClientGUIClick", BankKontoUebersichtButton[1],  bankGUI.uebersichtWindow.einzahlen, false)
	addEventHandler("onClientGUIClick", BankKontoUebersichtButton[3],  bankGUI.uebersichtWindow.auszahlen, false)
	addEventHandler("onClientGUIClick", BankKontoUebersichtButton[5],  spendeReporter, false)
	addEventHandler("onClientGUIClick", BankKontoUebersichtButton[4],  bankGUI.ueberweisenWindow.open)
	--addEventHandler("onClientGUIClick", BankKontoUebersichtButton[5],  bankGUI.dispoWindow.open, false)
end

function bankGUI.uebersichtWindow.close()
	bankGUI.isOpen = false
	guiSetInputEnabled(false)
	guiSetVisible(BankKontoUebersichtWindow[1], false)
	removeEventHandler("onClientGUIClick", BankKontoUebersichtButton[2],  bankGUI.uebersichtWindow.close)
	removeEventHandler("onClientGUIClick", BankKontoUebersichtButton[1],  bankGUI.uebersichtWindow.einzahlen)
	removeEventHandler("onClientGUIClick", BankKontoUebersichtButton[3],  bankGUI.uebersichtWindow.auszahlen)
	removeEventHandler("onClientGUIClick", BankKontoUebersichtButton[5],  spendeReporter)
	removeEventHandler("onClientGUIClick", BankKontoUebersichtButton[4],  bankGUI.ueberweisenWindow.open)
	--removeEventHandler("onClientGUIClick", BankKontoUebersichtButton[5],  bankGUI.dispoWindow.open)	
end

function bankGUI.uebersichtWindow.einzahlen()
	if isTimer ( timer )
	then
		cancelEvent()
	else
		timer = setTimer ( function () end, 1000, 1 )
		local amount = guiGetText(BankKontoUebersichtEdit[1])
		amount = tonumber(amount)
		if amount ~= math.round(amount) then return addNotification(1, 255, 0, 0, "Kommazahlen sind nicht erlaubt.") end
		local betreff = nil
		triggerServerEvent("bank2:deposit", getLocalPlayer(), bankGUI.account, math.round(amount), betreff)
		bankGUI.accountState = amount
		addEventHandler("bank2.client:deposit:return", getRootElement(), bankGUI.uebersichtWindow.einzahlenreturn)
	end
end

function bankGUI.uebersichtWindow.einzahlenreturn(retval)
	removeEventHandler("bank2.client:deposit:return", getRootElement(), bankGUI.uebersichtWindow.einzahlenreturn)
	if retval == -2 then
		guiSetText(BankKontoUebersichtLabel[4], "Sie fuehren nicht genuegend Geld mit sich!")
		guiSetVisible(BankKontoUebersichtLabel[4], true)
	elseif retval == -1 then
		guiSetText(BankKontoUebersichtLabel[4], "Sie haben keinen Zugriff auf dieses Konto!")
		guiSetVisible(BankKontoUebersichtLabel[4], true)
	elseif retval == -4 then
		guiSetText(BankKontoUebersichtLabel[4], "Negative Geldbetraege koennen nicht eingezahlt werden.")
		guiSetVisible(BankKontoUebersichtLabel[4], true)
	else
		bankGUI.account["geld"] = bankGUI.account["geld"] + bankGUI.accountState
		guiSetText(BankKontoUebersichtLabel[3], bankGUI.account["geld"].." Vero")
	end
end

function spendeReporter()
	if tonumber(guiGetText(BankKontoUebersichtEdit[1])) then
		if tonumber(guiGetText(BankKontoUebersichtEdit[1])) ~= math.round(tonumber(guiGetText(BankKontoUebersichtEdit[1]))) then return addNotification(1, 255, 0, 0, "Kommazahlen sind nicht erlaubt.") end
		triggerServerEvent("bank2:transfer", getLocalPlayer(), bankGUI.accountname , "Reporter", math.round(tonumber(guiGetText(BankKontoUebersichtEdit[1]))), "Spende")
	end
end

function bankGUI.uebersichtWindow.auszahlen()
	if isTimer ( timer2 )
	then
		cancelEvent()
	else
		timer2 = setTimer ( function () end, 1000, 1 )
		local amount = guiGetText(BankKontoUebersichtEdit[1])
		amount = tonumber(amount)
		if amount ~= math.round(amount) then return addNotification(1, 255, 0, 0, "Kommazahlen sind nicht erlaubt.") end
		local betreff = nil
		triggerServerEvent("bank2:withdraw", getLocalPlayer(), bankGUI.account, math.round(amount), betreff)
		addEventHandler("bank2.client:withdraw:return", getRootElement(),  bankGUI.uebersichtWindow.auszahlenreturn)
		bankGUI.accountState = amount
	end
end

function bankGUI.uebersichtWindow.auszahlenreturn(retval)
	removeEventHandler("bank2.client:withdraw:return", getRootElement(),  bankGUI.uebersichtWindow.auszahlenreturn)
	if retval == -2 then
		guiSetText(BankKontoUebersichtLabel[4], "Es ist nicht genuegend Geld auf dem Konto vorhanden!")
		guiSetVisible(BankKontoUebersichtLabel[4], true)
	elseif retval == -1 then
		guiSetText(BankKontoUebersichtLabel[4], "Sie haben keinen Zugriff auf dieses Konto!")
		guiSetVisible(BankKontoUebersichtLabel[4], true)
	elseif retval == -4 then
		guiSetText(BankKontoUebersichtLabel[4], "Negative Geldbetraege koennen nicht eingezahlt werden.")
		guiSetVisible(BankKontoUebersichtLabel[4], true)
	else
		bankGUI.account["geld"] = bankGUI.account["geld"] - bankGUI.accountState
		guiSetText(BankKontoUebersichtLabel[3], bankGUI.account["geld"].." Vero")
	end
end	

function receiveUberweisenData(tbl)
	for i,v in ipairs(tbl) do
		local row = guiGridListAddRow(BankKontoUberweisenGridList[1])
		guiGridListSetItemText ( BankKontoUberweisenGridList[1], row, 1, v.amount, false, false )
		guiGridListSetItemText ( BankKontoUberweisenGridList[1], row, 2, v.typ, false, false )	
		guiGridListSetItemText ( BankKontoUberweisenGridList[1], row, 3, v.info, false, false )	
	end
end

function bankGUI.ueberweisenWindow.open()
	callServerFunction("getBankLogs", getLocalPlayer(),bankGUI.accountname)
	guiGridListClear( BankKontoUberweisenGridList[1] )
	guiSetVisible(BankKontoUebersichtWindow[1], false)
	guiSetVisible(BankKontoUeberweisenWindow[1], true)
	addEventHandler("onClientGUIClick", BankKontoUeberweisenButton[1],  bankGUI.ueberweisenWindow.close, false)
end

function bankGUI.ueberweisenWindow.close()
	guiSetVisible(BankKontoUeberweisenWindow[1], false)
	bankGUI.uebersichtWindow.close()
	removeEventHandler("onClientGUIClick", BankKontoUeberweisenButton[1],  bankGUI.ueberweisenWindow.close)
end

function bankGUI.dispoWindow.open()
	guiSetVisible(BankKontoDispoWindow[1], true)
	guiGridListClear(BankKontoDispoGrid[1])
	guiGridListAddRow(BankKontoDispoGrid[1])
	guiGridListAddRow(BankKontoDispoGrid[1])
	guiGridListAddRow(BankKontoDispoGrid[1])
	guiGridListSetSelectionMode(BankKontoDispoGrid[1], 0)
	guiGridListSetItemText(BankKontoDispoGrid[1], 0, 1, "1000", false, true)
	guiGridListSetItemText(BankKontoDispoGrid[1], 1, 1, "2000", false, true)
	guiGridListSetItemText(BankKontoDispoGrid[1], 2, 1, "3000", false, true)
	guiGridListSetItemText(BankKontoDispoGrid[1], 0, 2, "5%", false, false)
	guiGridListSetItemText(BankKontoDispoGrid[1], 1, 2, "10%", false, false)
	guiGridListSetItemText(BankKontoDispoGrid[1], 2, 2, "15%", false, false)
	addEventHandler("onClientGUIClick", BankKontoDispoButton[1], bankGUI.dispoWindow.close, false)
	addEventHandler("onClientGUIClick", BankKontoDispoButton[2], bankGUI.dispoWindow.request, false)
end

function bankGUI.dispoWindow.open()
	guiSetVisible(BankKontoDispoWindow[1], true)
	guiGridListClear(BankKontoDispoGrid[1])
	guiGridListAddRow(BankKontoDispoGrid[1])
	guiGridListAddRow(BankKontoDispoGrid[1])
	guiGridListAddRow(BankKontoDispoGrid[1])
	guiGridListSetSelectionMode(BankKontoDispoGrid[1], 0)
	guiGridListSetItemText(BankKontoDispoGrid[1], 0, 1, "1000", false, true)
	guiGridListSetItemText(BankKontoDispoGrid[1], 1, 1, "2000", false, true)
	guiGridListSetItemText(BankKontoDispoGrid[1], 2, 1, "3000", false, true)
	guiGridListSetItemText(BankKontoDispoGrid[1], 0, 2, "5%", false, false)
	guiGridListSetItemText(BankKontoDispoGrid[1], 1, 2, "10%", false, false)
	guiGridListSetItemText(BankKontoDispoGrid[1], 2, 2, "15%", false, false)
	addEventHandler("onClientGUIClick", BankKontoDispoButton[1], bankGUI.dispoWindow.close, false)
	addEventHandler("onClientGUIClick", BankKontoDispoButton[2], bankGUI.dispoWindow.request, false)
end

function bankGUI.dispoWindow.request()
	local row, col = guiGridListGetSelectedItem(BankKontoDispoGrid[1])
	if row == -1 then
		outputDebugString("Fehler: Hier nix Dispo!")
		return
	end
	triggerServerEvent("bank2:requestDispo", getLocalPlayer(), row)
	addEventHandler("bank2.client:requestDispo:return", getRootElement(), bankGUI.dispoWindow.requestreturn, false)
end
function bankGUI.dispoWindow.requestreturn(retval)
	removeEventHandler("bank2.client:requestDispo:return", getRootElement(), bankGUI.dispoWindow.requestreturn)
	if retval == 1 then
		outputDebugString("Erfolg!")
		return
	end	
end


function bankGUI.dispoWindow.close()
	guiSetVisible(BankKontoDispoWindow[1], false)
	removeEventHandler("onClientGUIClick", BankKontoDispoButton[1], bankGUI.dispoWindow.close)
end
	
addEvent("bank2.client:deposit:return", true)
addEvent("bank2.client:withdraw:return", true)
addEvent("bank2.client:openAccount:return", true)
addEvent("bank2.client:createAccount:return", true)
addEvent("bank2.client:openWindow", true)
addEventHandler("bank2.client:openWindow", getRootElement(),
	function()
		bankGUI.loginWindow.open()
	end
)


