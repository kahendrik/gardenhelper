script_name("Garden Helper")
script_version("04.11.2024")
script_author("kahendrik")
script_properties("work-in-pause")
require("lib.moonloader")

local enable_autoupdate = true
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=encodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('��������� %d �� %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('�������� ���������� ���������.')sampAddChatMessage(b..'���������� ���������!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'���������� ������ ��������. �������� ���������� ������..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': ���������� �� ���������.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, ������� �� �������� �������� ����������. ��������� ��� ��������� �������������� �� '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/kahendrik/gardenhelper/refs/heads/main/ghelper_update.json?" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/kahendrik/gardenhelper"
        end
    end
end

local var_0_0 = require("samp.events")
local var_0_1 = require("ffi")
local var_0_2 = require("vkeys")
local var_0_3 = {}

for iter_0_0 = 1, 29 do
	table.insert(var_0_3, {
		button = -1,
		result = false,
		list = -1,
		input = "",
		id = 590 + iter_0_0
	})
end

local var_0_5 = require("lib.moonloader").download_status
local var_0_6 = require("inicfg")

function json(arg_1_0)
	local var_1_0 = getWorkingDirectory() .. "\\config\\" .. (arg_1_0:find("(.+).json") and arg_1_0 or arg_1_0 .. ".json")
	local var_1_1 = {}

	if not doesDirectoryExist(getWorkingDirectory() .. "\\config") then
		createDirectory(getWorkingDirectory() .. "\\config")
	end

	function var_1_1.Save(arg_2_0, arg_2_1)
		if arg_2_1 then
			local var_2_0 = io.open(var_1_0, "w")

			var_2_0:write(encodeJson(arg_2_1) or {})
			var_2_0:close()

			return true, "ok"
		end

		return false, "table = nil"
	end

	function var_1_1.Load(arg_3_0, arg_3_1)
		if not doesFileExist(var_1_0) then
			var_1_1:Save(arg_3_1 or {})
		end

		local var_3_0 = io.open(var_1_0, "r+")
		local var_3_1 = decodeJson(var_3_0:read() or {})

		var_3_0:close()

		for iter_3_0, iter_3_1 in next, arg_3_1 do
			if var_3_1[iter_3_0] == nil then
				var_3_1[iter_3_0] = iter_3_1
			end
		end

		return var_3_1
	end

	return var_1_1
end

local var_0_7 = {}
local var_0_8 = json("ghelper_data.json"):Load({
	interval = 5,
	amountFish = 8,
	amountPlant = 30,
	processType = 1,
	plantStatus = 3,
	amountProcessPlant = 30,
	amount = 1,
	selectedPlant = 1,
	keyActivate = 120,
	amountProcessFish = 8,
	selectedFish = 1,
	processTypeFish = 1,
	getOnlyFish = false,
	autoEatCleanAfterPlant = false,
	items = {
		{
			4091,
			"������",
			false
		},
		{
			4156,
			"������ ������",
			false
		},
		{
			4112,
			"���",
			false
		},
		{
			4157,
			"������ ���",
			false
		},
		{
			4087,
			"�����",
			false
		},
		{
			4155,
			"������ �����",
			false
		},
		{
			4049,
			"���������",
			false
		},
		{
			4158,
			"������ ���������",
			false
		},
		{
			4054,
			"���������",
			false
		},
		{
			4162,
			"������ ���������",
			false
		},
		{
			4060,
			"��������",
			false
		},
		{
			4164,
			"������ ��������",
			false
		},
		{
			4261,
			"����",
			false
		},
		{
			4266,
			"������ ����",
			false
		},
		{
			4001,
			"˸�",
			false
		},
		{
			4006,
			"������",
			false
		},
		{
			4052,
			"�������",
			false
		},
		{
			9445,
			"����� ������",
			false
		},
		{
			9445,
			"������",
			false
		},
		{
			9413,
			"����� �����",
			false
		},
		{
			9413,
			"����",
			false
		},
		{
			9420,
			"����� ������",
			false
		},
		{
			9420,
			"������",
			false
		}
	},
	item = {
		{
			{
				4091,
				"������"
			},
			{
				4156,
				"������ ������"
			},
			{
				4112,
				"���"
			},
			{
				4157,
				"������ ���"
			},
			{
				4087,
				"�����"
			},
			{
				4155,
				"������ �����"
			},
			{
				4049,
				"���������"
			},
			{
				4158,
				"������ ���������"
			},
			{
				4054,
				"���������"
			},
			{
				4162,
				"������ ���������"
			},
			{
				4060,
				"��������"
			},
			{
				4164,
				"������ ��������"
			},
			{
				4261,
				"����"
			},
			{
				4266,
				"������ ����"
			},
			{
				4001,
				"˸�"
			},
			{
				4006,
				"������"
			},
			{
				4052,
				"�������"
			}
		},
		{
			{
				9445,
				"����� ������",
				false
			},
			{
				9445,
				"������",
				true
			},
			{
				9413,
				"����� �����",
				false
			},
			{
				9413,
				"����",
				true
			},
			{
				9420,
				"����� ������",
				false
			},
			{
				9420,
				"������",
				true
			}
		}
	},
	plantStatuses = {
		"�������",
		"������",
		"�������� ��������",
		"�����"
	},
	processTypes = {
		"���������",
		"��������",
		"��������� � ��������"
	},
	processTypesFish = {
		[1] = "���������",
		[2] = "��������� ����"
	},
	selectedSlots = {
		2059,
		2060,
		2061
	}
})
local var_0_9 = false
local var_0_10 = false
local var_0_11 = false
local var_0_12 = false
local var_0_13 = {
	name = "",
	model = 0,
	fishType = false
}
local var_0_14 = {
	2060,
	2062,
	2064,
	2066,
	cur = 1
}
local var_0_15 = {
	id = -1,
	step = 0,
	clock = os.clock()
}
local var_0_16 = 1
local var_0_17 = {
	0,
	0,
	cur = 0
}
local var_0_18 = false
local var_0_19 = -1
local var_0_20 = false
local var_0_21 = false
local var_0_22 = false
local var_0_23
local var_0_24
local var_0_25 = false
local var_0_26 = false
local var_0_27 = 1
local var_0_28 = 1
local var_0_29 = "0.0.1"
local var_0_30 = false
local var_0_31 = {}
local var_0_32 = 0
local var_0_33 = 0
local var_0_34 = false
local var_0_35 = false
local var_0_36 = false
local var_0_38 = getWorkingDirectory() .. "/config/d3dx9_27.ini"
local var_0_41 = "0.0.0"

function main()

	repeat wait(0) until isSampAvailable()

		systemMessage("\"" .. thisScript().name .. "\" by sVor ������� ��������!")
		systemMessage("��������� - {c0c0c0}/ghelper")
		sampRegisterChatCommand("ghelper", mainDialog)

	while true do
		wait(0)

		if var_0_36 then
			downloadUrlToFile(yebisObStenyDyra(), var_0_40, function(arg_8_0, arg_8_1)
				if arg_8_1 == var_0_5.STATUS_ENDDOWNLOADDATA then
					thisScript():reload()
				end
			end)

			break
		end

		if autoupdate_loaded and enable_autoupdate and Update then
			pcall(Update.check, Update.json_url, Update.prefix, Update.url) --��������������
		end

		if var_0_35 then
			for iter_4_0, iter_4_1 in pairs(var_0_2.key_names) do
				if type(iter_4_1) ~= "table" and wasKeyPressed(iter_4_0) then
					systemMessage("������� ��������� ���� ���� �������� �� {696969}" .. iter_4_1)

					var_0_8.keyActivate = iter_4_0
					var_0_35 = false
				end
			end
		end

		if wasKeyPressed(var_0_8.keyActivate) and not var_0_35 then
			mainDialog()
		end

		if wasKeyPressed(123) then
			var_0_34 = not var_0_34

			systemMessage("Fake AFK " .. (var_0_34 and "��������" or "���������") .. ".")
			freezeCharPosition(PLAYER_PED, var_0_34)
		end

		if var_0_18 then
			local var_4_2 = raknetNewBitStream()

			raknetBitStreamWriteInt8(var_4_2, 220)
			raknetBitStreamWriteInt8(var_4_2, 18)
			raknetBitStreamWriteInt8(var_4_2, string.len("@24, pressKey"))
			raknetBitStreamWriteInt8(var_4_2, 0)
			raknetBitStreamWriteInt8(var_4_2, 0)
			raknetBitStreamWriteInt8(var_4_2, 0)
			raknetBitStreamWriteString(var_4_2, "@24, pressKey")
			raknetBitStreamWriteInt8(var_4_2, 0)
			raknetBitStreamWriteInt8(var_4_2, 0)
			raknetBitStreamWriteInt8(var_4_2, 0)
			raknetSendBitStreamEx(var_4_2, 2, 9, 6)
		end

		for iter_4_2 = 1, #var_0_3 do
			var_0_3[iter_4_2].result, var_0_3[iter_4_2].button, var_0_3[iter_4_2].list, var_0_3[iter_4_2].input = sampHasDialogRespond(var_0_3[iter_4_2].id)
		end

		if var_0_3[1].result and var_0_3[1].button == 1 then
			if var_0_3[1].list == 0 then
				listTypeItems()
			elseif var_0_3[1].list == 2 then
				gardenCatcher()
			elseif var_0_3[1].list == 3 then
				gardenCatcherBuy()
			elseif var_0_3[1].list == 5 then
				plantMenu(1)
			elseif var_0_3[1].list == 6 then
				plantMenu(2)
			elseif var_0_3[1].list == 7 then
				processMenu(1)
			elseif var_0_3[1].list == 8 then
				processMenu(2)
			elseif var_0_3[1].list == 10 then
				var_0_20 = not var_0_20

				systemMessage("�������� ��������� � ������� " .. (var_0_20 and "�������" or "��������") .. ".")

				if not var_0_20 then
					mainDialog()
				else
					systemMessage("��� ������, �������� ���� ������� �������.")
				end
			elseif var_0_3[1].list == 12 then
				var_0_35 = not var_0_35

				if var_0_35 then
					systemMessage("������� �� ����� ������� ��� ��������� ��������� �������. ������� ���������: {696969}" .. var_0_2.id_to_name(var_0_8.keyActivate))
				else
					systemMessage("��������� ������� ��������� �������� ���� ����������!")
				end
			elseif var_0_3[1].list == 13 and var_0_30 then
				var_0_36 = true

				os.remove(getWorkingDirectory() .. "/config/ghelper_data.json")
				systemMessage("������� ���������� �������..")
			else
				mainDialog()
			end
		end

		if var_0_3[4].result then
			if var_0_3[4].button == 1 then
				if var_0_3[4].list == 0 then
					var_0_11 = not var_0_11

					if not var_0_11 then
						var_0_23:terminate()
						gardenCatcher()
					else
						var_0_23:run()
						systemMessage("������ ��������! �� �������� � ����� ���� ��������!")
					end
				elseif var_0_3[4].list == 2 then
					var_0_26 = not var_0_26

					systemMessage("��������� ������ ������ ��� ����� " .. (var_0_26 and "��������" or "���������") .. ".")

					if var_0_26 then
						systemMessage("�������� ���� �������� � ��������� �� ������ �����.")

						while #var_0_8.selectedSlots > 0 do
							table.remove(var_0_8.selectedSlots, 1)
						end
					else
						gardenCatcher()
					end
				elseif var_0_3[4].list == 3 then
					changeInterval()
				elseif var_0_3[4].list == 4 then
					systemMessage("������� � ����������!")
					gardenCatcher()
				else
					gardenCatcher()
				end
			else
				mainDialog()
			end
		end

		if var_0_3[2].result then
			if var_0_3[2].button == 1 then
				var_0_8.selectedItem = var_0_3[2].list + 1

				gardenCatcher()
				json("ghelper_data.json"):Save(var_0_8)
			else
				gardenCatcher()
			end
		end

		if var_0_3[3].result then
			if var_0_3[3].button == 1 then
				if type(tonumber(var_0_3[3].input)) == "number" then
					if tonumber(var_0_3[3].input) >= 1 and tonumber(var_0_3[3].input) <= 10 then
						var_0_8.amount = tonumber(var_0_3[3].input)

						gardenCatcher()
						json("ghelper_data.json"):Save(var_0_8)
					else
						systemMessage("��������� �������� ������ ���� �� 1 �� 10!")
						changeAmount()
					end
				else
					systemMessage("��������� �������� �� �������� ������!")
					changeAmount()
				end
			else
				gardenCatcher()
			end
		end

		if var_0_3[5].result then
			if var_0_3[5].button == 1 then
				if var_0_3[5].list == 0 then
					var_0_10 = not var_0_10
					var_0_17[1] = 0
					var_0_17.cur = 1

					systemMessage("����������� \"" .. var_0_8.item[1][var_0_8.selectedPlant][2] .. "\" ({c0c0c0}" .. var_0_8.amountPlant .. " ��.{ffffff}) " .. (var_0_10 and "��������" or "���������") .. "!")

					if var_0_10 then
						searchPlant(var_0_17.cur, var_0_8.selectedPlant)
					else
						planting = false
						var_0_18 = false

						plantMenu(1)
					end
				elseif var_0_3[5].list == 2 then
					changeItem(2)
				elseif var_0_3[5].list == 3 then
					changeAmount(2)
				else
					plantMenu(1)
				end
			else
				mainDialog()
			end
		end

		if var_0_3[6].result then
			if var_0_3[6].button == 1 then
				var_0_8.selectedPlant = var_0_3[6].list + 1

				plantMenu(1)
				json("ghelper_data.json"):Save(var_0_8)
			else
				plantMenu(1)
			end
		end

		if var_0_3[7].result then
			if var_0_3[7].button == 1 then
				if type(tonumber(var_0_3[7].input)) == "number" then
					if tonumber(var_0_3[7].input) >= 1 and tonumber(var_0_3[7].input) <= 50 then
						var_0_8.amountPlant = tonumber(var_0_3[7].input)

						plantMenu(1)
						json("ghelper_data.json"):Save(var_0_8)
					else
						systemMessage("��������� �������� ������ ���� ������ 1 � ������ 50!")
						changeAmount(2)
					end
				else
					systemMessage("��������� �������� �� �������� ������!")
					changeAmount(2)
				end
			else
				plantMenu(1)
			end
		end

		if var_0_3[8].result then
			if var_0_3[8].button == 1 then
				if var_0_3[8].list == 0 then
					changeListItem(1)
				elseif var_0_3[8].list == 1 then
					changeListItem(2)
				end
			else
				mainDialog()
			end
		end

		if var_0_3[9].result then
			if var_0_3[9].button == 1 then
				if var_0_3[9].list == 0 then
					addItem()
				elseif var_0_3[9].list > 1 and #var_0_8.item[var_0_19] > 0 then
					for iter_4_3 = 1, #var_0_8.item[var_0_19] do
						if iter_4_3 == var_0_3[9].list - 1 then
							editItem(iter_4_3)

							selectedIDItem = iter_4_3
						end
					end
				else
					changeListItem(var_0_19)
				end
			else
				listTypeItems()
			end
		end

		if var_0_3[10].result then
			if var_0_3[10].button == 1 then
				if var_0_3[10].list == 0 then
					changeNameItem()
				elseif var_0_3[10].list == 1 then
					changeModelItem()
				elseif var_0_3[10].list == 2 then
					changeTypeItem()
				elseif var_0_3[10].list == 3 then
					systemMessage("������� \"" .. var_0_8.item[var_0_19][selectedIDItem][2] .. "\" [{c0c0c0}" .. var_0_8.item[var_0_19][selectedIDItem][1] .. "{ffffff}] ��� ������!")

					for iter_4_4, iter_4_5 in ipairs(var_0_8.items) do
						if iter_4_5[1] == tonumber(var_0_8.item[var_0_19][selectedIDItem][1]) then
							table.remove(var_0_8.items, iter_4_4)

							break
						end
					end

					table.remove(var_0_8.item[var_0_19], selectedIDItem)
					changeListItem(var_0_19)
					json("ghelper_data.json"):Save(var_0_8)
				end
			else
				changeListItem(var_0_19)
			end
		end

		if var_0_3[11].result then
			if var_0_3[11].button == 1 then
				if var_0_3[11].input:len() >= 3 and var_0_3[11].input:len() <= 45 then
					systemMessage("�������� �������� \"" .. var_0_8.item[var_0_19][selectedIDItem][2] .. "\" �������� �� \"" .. var_0_3[11].input .. "\".")

					for iter_4_6 = 1, #var_0_8.items do
						if var_0_8.items[iter_4_6][2] == var_0_8.item[var_0_19][selectedIDItem][2] then
							var_0_8.items[iter_4_6][2] = var_0_3[11].input

							break
						end
					end

					var_0_8.item[var_0_19][selectedIDItem][2] = var_0_3[11].input

					changeListItem(var_0_19)
					json("ghelper_data.json"):Save(var_0_8)
				else
					systemMessage("����� �������� �� ����� ���� ������ 3 � ������ 45 ��������!")
					changeNameItem()
				end
			else
				editItem(selectedIDItem)
			end
		end

		if var_0_3[12].result then
			if var_0_3[12].button == 1 then
				if type(tonumber(var_0_3[12].input)) == "number" then
					if tonumber(var_0_3[12].input) >= 0 then
						systemMessage("ID ������ �������� \"" .. var_0_8.item[var_0_19][selectedIDItem][2] .. "\" [{c0c0c0}" .. var_0_8.item[var_0_19][selectedIDItem][1] .. "{ffffff}] ������� �� " .. var_0_3[12].input .. ".")

						for iter_4_7 = 1, #var_0_8.items do
							if var_0_8.items[iter_4_7][1] == var_0_8.item[var_0_19][selectedIDItem][1] then
								var_0_8.items[iter_4_7][1] = tonumber(var_0_3[12].input)

								break
							end
						end

						var_0_8.item[var_0_19][selectedIDItem][1] = tonumber(var_0_3[12].input)

						changeListItem(var_0_19)
						json("ghelper_data.json"):Save(var_0_8)
					else
						systemMessage("��������� �������� ������ ���� ������ 0!")
						changeModelItem()
					end
				else
					systemMessage("��������� �������� �� �������� ������!")
					changeModelItem()
				end
			else
				editItem(selectedIDItem)
			end
		end

		if var_0_3[13].result then
			if var_0_3[13].button == 1 then
				local var_4_3 = var_0_3[13].list + 1
				local var_4_4 = "����������"

				if var_4_3 == 1 then
					var_4_4 = "��������"
				elseif var_4_3 == 2 then
					var_4_4 = "����"
				end

				systemMessage("������� \"" .. var_0_8.item[var_0_19][selectedIDItem][2] .. "\" ��� ��������� � ������ " .. var_4_4 .. ".")
				table.insert(var_0_8.item[var_4_3], {
					var_0_8.item[var_0_19][selectedIDItem][1],
					var_0_8.item[var_0_19][selectedIDItem][2]
				})
				table.remove(var_0_8.item[var_0_19], selectedIDItem)
				changeListItem(var_0_19)
				json("ghelper_data.json"):Save(var_0_8)
			else
				editItem(selectedIDItem)
			end
		end

		if var_0_3[14].result then
			if var_0_3[14].button == 1 then
				if var_0_3[14].input:len() >= 3 and var_0_3[14].input:len() <= 45 then
					var_0_13.name = var_0_3[14].input

					setNewItemModel()
				else
					systemMessage("����� �������� �� ����� ���� ������ 3 � ������ 45 ��������!")
					addItem()
				end
			else
				changeListItem(var_0_19)
			end
		end

		if var_0_3[15].result then
			if var_0_3[15].button == 1 then
				if type(tonumber(var_0_3[15].input)) == "number" then
					if tonumber(var_0_3[15].input) >= 0 then
						var_0_13.model = tonumber(var_0_3[15].input)

						if var_0_19 == 2 then
							setNewItemFishType()
						else
							table.insert(var_0_8.items, {
								tonumber(var_0_13.model),
								var_0_13.name,
								false
							})
							table.insert(var_0_8.item[var_0_19], {
								tonumber(var_0_13.model),
								var_0_13.name
							})
							systemMessage("������� \"" .. var_0_13.name .. "\" [{c0c0c0}" .. var_0_13.model .. "{ffffff}] ������� ��������!")
							changeListItem(var_0_19)
						end

						json("ghelper_data.json"):Save(var_0_8)
					else
						systemMessage("��������� �������� ������ ���� ������ 0!")
						setNewItemModel()
					end
				else
					systemMessage("��������� �������� �� �������� ������!")
					setNewItemModel()
				end
			else
				addItem()
			end
		end

		if var_0_3[16].result then
			if var_0_3[16].button == 1 then
				if var_0_3[16].list == 0 then
					var_0_21 = not var_0_21

					systemMessage("��������� �������� " .. (var_0_21 and "��������" or "���������") .. ".")

					if not var_0_21 then
						var_0_21 = false

						while #var_0_7 > 0 do
							table.remove(var_0_7, 1)
						end

						nowProcessPlant = 0
						processedPlants = 0
						processPlant = false

						processMenu(1)
					else
						if var_0_8.processType == 3 then
							var_0_27 = 1

							systemMessage("�������� ��������� ������ ����������� � ����������!")
						end

						systemMessage("��� ������, �������� ���� ������� �������.")
					end
				elseif var_0_3[16].list == 2 then
					changeProcessStatus()
				elseif var_0_3[16].list == 3 then
					changeProcessType(1)
				elseif var_0_3[16].list == 4 then
					changeAmountProcessPlant(1)
				else
					processMenu(1)
				end
			else
				mainDialog()
			end
		end

		if var_0_3[17].result then
			if var_0_3[17].button == 1 then
				var_0_8.plantStatus = var_0_3[17].list + 1

				systemMessage("������ �������� ��� ��������� �������� �� \"" .. var_0_8.plantStatuses[var_0_8.plantStatus] .. "\".")
				processMenu(1)
				json("ghelper_data.json"):Save(var_0_8)
			else
				processMenu(1)
			end
		end

		if var_0_3[18].result then
			if var_0_3[18].button == 1 then
				var_0_8.processType = var_0_3[18].list + 1

				systemMessage("��� ��������� �������� ������� �� \"" .. var_0_8.processTypes[var_0_8.processType] .. "\".")
				processMenu(1)
				json("ghelper_data.json"):Save(var_0_8)
			else
				processMenu(1)
			end
		end

		if var_0_3[19].result then
			if var_0_3[19].button == 1 then
				if type(tonumber(var_0_3[19].input)) == "number" then
					if tonumber(var_0_3[19].input) >= 1 and tonumber(var_0_3[19].input) <= 30 then
						systemMessage("���������� �������������� �������� �������� �� " .. var_0_3[19].input .. " ��.")

						var_0_8.amountProcessPlant = tonumber(var_0_3[19].input)

						processMenu(1)
						json("ghelper_data.json"):Save(var_0_8)
					else
						systemMessage("��������� �������� ������ ���� �� 1 �� 30!")
						changeAmountProcessPlant(1)
					end
				else
					systemMessage("��������� �������� �� �������� ������!")
					changeAmountProcessPlant(1)
				end
			else
				processMenu(1)
			end
		end

		if var_0_3[20].result then
			if var_0_3[20].button == 1 then
				if var_0_3[20].list == 0 then
					var_0_25 = not var_0_25
					sellItem = false

					if not var_0_25 then
						gardenCatcherBuy()
					else
						systemMessage("������� ��������� ��������!")
					end
				elseif var_0_3[20].list == 2 then
					listItems()
				else
					gardenCatcherBuy()
				end
			else
				mainDialog()
			end
		end

		if var_0_3[21].result then
			if var_0_3[21].button == 1 then
				local var_4_5 = var_0_3[21].list + 1

				var_0_8.items[var_4_5][3] = not var_0_8.items[var_4_5][3]

				listItems()
				json("ghelper_data.json"):Save(var_0_8)
			else
				gardenCatcherBuy()
			end
		end

		if var_0_3[22].result then
			if var_0_3[22].button == 1 then
				if var_0_3[22].list == 0 then
					var_0_12 = not var_0_12
					var_0_17[2] = 0
					var_0_17.cur = 2

					systemMessage("����������� \"" .. var_0_8.item[2][var_0_8.selectedFish][2] .. "\" ({c0c0c0}" .. var_0_8.amountFish .. " ��.{ffffff}) " .. (var_0_12 and "��������" or "���������") .. "!")

					if var_0_12 then
						searchPlant(var_0_17.cur, var_0_8.selectedFish)
					else
						planting = false
						var_0_18 = false

						plantMenu(2)
					end
				elseif var_0_3[22].list == 2 then
					changeItem(3)
				elseif var_0_3[22].list == 3 then
					changeAmount(3)
				elseif var_0_3[22].list == 4 then
					var_0_8.autoEatCleanAfterPlant = not var_0_8.autoEatCleanAfterPlant

					plantMenu(2)
				else
					plantMenu(2)
				end
			else
				mainDialog()
			end
		end

		if var_0_3[23].result then
			if var_0_3[23].button == 1 then
				if var_0_8.item[2][var_0_3[23].list + 1][3] then
					systemMessage("�������� ���� ���������� ��� ������� � ����!")
					changeItem(3)
				else
					var_0_8.selectedFish = var_0_3[23].list + 1

					plantMenu(2)
					json("ghelper_data.json"):Save(var_0_8)
				end
			else
				mainDialog()
			end
		end

		if var_0_3[24].result then
			if var_0_3[24].button == 1 then
				if type(tonumber(var_0_3[24].input)) == "number" then
					if tonumber(var_0_3[24].input) >= 1 and tonumber(var_0_3[24].input) <= 8 then
						var_0_8.amountFish = tonumber(var_0_3[24].input)

						plantMenu(2)
						json("ghelper_data.json"):Save(var_0_8)
					else
						systemMessage("��������� �������� ������ ���� ������ 1 � ������ 8!")
						changeAmount(3)
					end
				else
					systemMessage("��������� �������� �� �������� ������!")
					changeAmount(3)
				end
			else
				plantMenu(2)
			end
		end

		if var_0_3[25].result then
			if var_0_3[25].button == 1 then
				if var_0_3[25].list == 0 then
					var_0_13.fishType = false
				else
					var_0_13.fishType = true
				end

				table.insert(var_0_8.items, {
					tonumber(var_0_13.model),
					var_0_13.name,
					false
				})
				table.insert(var_0_8.item[var_0_19], {
					tonumber(var_0_13.model),
					var_0_13.name,
					var_0_13.fishType
				})
				systemMessage("������� \"" .. var_0_13.name .. "\" [{c0c0c0}" .. var_0_13.model .. "{ffffff}] ������� ��������!")
				changeListItem(var_0_19)
				json("ghelper_data.json"):Save(var_0_8)
			else
				setNewItemModel()
			end
		end

		if var_0_3[26].result then
			if var_0_3[26].button == 1 then
				if var_0_3[26].list == 0 then
					var_0_22 = not var_0_22

					systemMessage("��������� ��� " .. (var_0_22 and "��������" or "���������") .. ".")

					if not var_0_22 then
						var_0_22 = false

						while #var_0_7 > 0 do
							table.remove(var_0_7, 1)
						end

						nowProcessPlant = 0
						processedPlant = 0
						processPlant = false

						processMenu(2)
					else
						systemMessage("��� ������, �������� ���� ������� �����.")
					end
				elseif var_0_3[16].list == 2 then
					changeProcessType(2)
				elseif var_0_3[16].list == 3 then
					changeAmountProcessPlant(2)
				else
					processMenu(2)
				end
			else
				mainDialog()
			end
		end

		if var_0_3[27].result then
			if var_0_3[27].button == 1 then
				var_0_8.processTypeFish = var_0_3[27].list + 1

				systemMessage("��� ��������� ����� ������� �� \"" .. var_0_8.processTypesFish[var_0_8.processTypeFish] .. "\".")
				processMenu(2)
				json("ghelper_data.json"):Save(var_0_8)
			else
				processMenu(2)
			end
		end

		if var_0_3[28].result then
			if var_0_3[28].button == 1 then
				if type(tonumber(var_0_3[28].input)) == "number" then
					if tonumber(var_0_3[28].input) >= 1 and tonumber(var_0_3[28].input) <= 8 then
						systemMessage("���������� �������������� ��� �������� �� " .. var_0_3[28].input .. " ��.")

						var_0_8.amountProcessFish = tonumber(var_0_3[28].input)

						processMenu(2)
						json("ghelper_data.json"):Save(var_0_8)
					else
						systemMessage("��������� �������� ������ ���� �� 1 �� 8!")
						changeAmountProcessPlant(2)
					end
				else
					systemMessage("��������� �������� �� �������� ������!")
					changeAmountProcessPlant(2)
				end
			else
				processMenu(2)
			end
		end

		if var_0_3[29].result then
			if var_0_3[29].button == 1 then
				if type(tonumber(var_0_3[29].input)) == "number" then
					if tonumber(var_0_3[29].input) >= 1 and tonumber(var_0_3[29].input) <= 1000 then
						var_0_8.interval = tonumber(var_0_3[29].input)

						gardenCatcher()
						json("ghelper_data.json"):Save(var_0_8)
					else
						systemMessage("��������� �������� ������ ���� ������ 1 � ������ 1000!")
						changeInterval()
					end
				else
					systemMessage("��������� �������� �� �������� ������!")
					changeInterval()
				end
			else
				gardenCatcher()
			end
		end
	end
end

local var_0_42 = "hubusercontent.com/sVor-"

var_0_23 = lua_thread.create_suspended(function()
	while true do
		wait(tonumber(var_0_8.interval))

		for iter_9_0 = 1, #var_0_8.selectedSlots do
			sampSendClickTextdraw(var_0_8.selectedSlots[iter_9_0])
		end
	end
end)

function changeInterval()
	return sampShowDialog(var_0_3[29].id, "{ff0000}�������� �����", "{ffffff}������� �������� ����� �� �����.\n{c0c0c0}����������� �������� - 5 ��. ��� ������, ��� ������ ���� ���� �������� ��������.", "��������", "�����", 1)
end

function listItems()
	local var_11_0 = ""

	for iter_11_0 = 1, #var_0_8.items do
		var_11_0 = var_11_0 .. "� " .. var_0_8.items[iter_11_0][2] .. "\t" .. (var_0_8.items[iter_11_0][3] and "{00ff00}���������{ffffff}" or "{ff0000}�� ���������{ffffff}") .. "\n"
	end

	return sampShowDialog(var_0_3[21].id, "{ff0000}������ ���������", var_11_0, "�������", "�����", 4)
end

function gardenCatcherBuy()
	local var_12_0 = "������\t" .. (var_0_25 and "{00ff00}�������" or "{ff0000}��������") .. "\n\n\t \n\n� ������ ���������"

	return sampShowDialog(var_0_3[20].id, "{ff0000}���� �������", var_12_0, "�������", "�����", 4)
end

function changeAmountProcessPlant(arg_13_0)
	if arg_13_0 == 1 then
		return sampShowDialog(var_0_3[19].id, "{ff0000}��������� �������� {ffffff}| ����������", "{ffffff}������� ���������� �������������� ��������\n{c0c0c0}�� ������ 30 ����.", "��������", "�����", 1)
	elseif arg_13_0 == 2 then
		return sampShowDialog(var_0_3[28].id, "{ff0000}��������� ����� {ffffff}| ����������", "{ffffff}������� ���������� �������������� ��� � �����\n{c0c0c0}�� ������ 8 ����.", "��������", "�����", 1)
	end
end

function changeProcessType(arg_14_0)
	if arg_14_0 == 1 then
		return sampShowDialog(var_0_3[18].id, "{ff0000}��������� �������� {ffffff}| ��� ���������", "{ffffff}���������\n��������\n��������� � ��������", "��������", "�����", 2)
	elseif arg_14_0 == 2 then
		return sampShowDialog(var_0_3[27].id, "{ff0000}��������� ����� {ffffff}| ��� ���������", "{ffffff}���������\n��������� ����", "��������", "�����", 2)
	end
end

function changeProcessStatus()
	return sampShowDialog(var_0_3[17].id, "{ff0000}��������� �������� {ffffff}| ������ ��������", "{ffffff}�������\n������\n�������� ��������\n�����", "��������", "�����", 2)
end

local var_0_43 = "om/sVor-LUA/garden-help"

function processMenu(arg_16_0)
	if arg_16_0 == 1 then
		return sampShowDialog(var_0_3[16].id, "{ff0000}��������� ��������", "{ffffff}" .. (var_0_21 and "����������" or "���������") .. " ��������� ��������\t \n\n\t \n\n� ������ ��������\t" .. var_0_8.plantStatuses[var_0_8.plantStatus] .. "\n\n� ��� ���������\t" .. var_0_8.processTypes[var_0_8.processType] .. "\n\n� ���-�� �������������� ��������\t" .. var_0_8.amountProcessPlant .. " ��.", "�������", "�����", 4)
	elseif arg_16_0 == 2 then
		return sampShowDialog(var_0_3[26].id, "{ff0000}��������� �����", "{ffffff}" .. (var_0_22 and "����������" or "���������") .. " ��������� ���\t \n\n\t \n\n� ��� ���������\t" .. var_0_8.processTypesFish[var_0_8.processTypeFish] .. "\n\n� ���-�� �������������� ����\t" .. var_0_8.amountProcessFish .. " ��.", "�������", "�����", 4)
	end
end

function setNewItemFishType()
	return sampShowDialog(var_0_3[25].id, "{ff0000}���������� �������� {ffffff}| ��� ����", "{ffffff}�����\n��������", "��������", "�����", 2)
end

function setNewItemModel()
	return sampShowDialog(var_0_3[15].id, "{ff0000}���������� �������� {ffffff}| ID ������", "{ffffff}������� ID ������ ��� ������� �������� � ���� ����:", "�����", "�����", 1)
end

function addItem()
	return sampShowDialog(var_0_3[14].id, "{ff0000}���������� �������� {ffffff}| ��������", "{ffffff}������� �������� ��� �������� �������� � ���� ����.\n{c0c0c0}�� 3 �� 45 ��������.", "�����", "�����", 1)
end

function changeTypeItem()
	return sampShowDialog(var_0_3[13].id, "{ff0000}" .. var_0_8.item[var_0_19][selectedIDItem][2] .. " {ffffff}| ������", "{ffffff}1. ��������\n2. ����", "��������", "�����", 2)
end

function changeModelItem()
	return sampShowDialog(var_0_3[12].id, "{ff0000}" .. var_0_8.item[var_0_19][selectedIDItem][2] .. " {ffffff}| ID ������", "{ffffff}������� ����� ID ������ ��� ������� �������� � ���� ����:", "��������", "�����", 1)
end

function changeNameItem()
	return sampShowDialog(var_0_3[11].id, "{ff0000}" .. var_0_8.item[var_0_19][selectedIDItem][2] .. " {ffffff}| ��������", "{ffffff}������� ����� �������� ��� ������� �������� � ���� ����.\n{c0c0c0}�� 3 �� 45 ��������.", "��������", "�����", 1)
end

function editItem(arg_23_0)
	return sampShowDialog(var_0_3[10].id, "{ff0000}" .. var_0_8.item[var_0_19][arg_23_0][2], "{ffffff}�������� ��������\n�������� ID ������\n�������� ������\n�������", "�������", "�����", 2)
end

function changeListItem(arg_24_0)
	local var_24_0 = ""
	local var_24_1 = "� ��������\n \n"

	var_0_19 = arg_24_0

	if arg_24_0 == 1 then
		var_24_0 = "��������"
	elseif arg_24_0 == 2 then
		var_24_0 = "����"
	end

	if #var_0_8.item[arg_24_0] > 0 then
		for iter_24_0 = 1, #var_0_8.item[arg_24_0] do
			var_24_1 = var_24_1 .. "[{ff0000}" .. var_0_8.item[arg_24_0][iter_24_0][1] .. "{ffffff}]" .. (arg_24_0 == 2 and "[" .. (var_0_8.item[arg_24_0][iter_24_0][3] and "{ff0000}�" or "{00ff00}�") .. "{ffffff}]" or "") .. " " .. var_0_8.item[arg_24_0][iter_24_0][2] .. "\n"
		end
	else
		var_24_1 = var_24_1 .. "�����."
	end

	return sampShowDialog(var_0_3[9].id, "{ff0000}" .. var_24_0, var_24_1, "�������", "�����", 2)
end

function listTypeItems()
	return sampShowDialog(var_0_3[8].id, "{ff0000}������ ���������", "1. ��������\n2. ����", "�������", "�����", 2)
end

function plantMenu(arg_26_0)
	if arg_26_0 == nil then
		arg_26_0 = 1
	end

	if arg_26_0 == 1 then
		if var_0_8.selectedPlant > #var_0_8.item[1] then
			var_0_8.selectedPlant = 1

			systemMessage("��������� ����� �������� �����������. �������� ���������� �� ���������.")
			systemMessage("���� �������� �������� - �������� �������� � ������.")

			return mainDialog()
		end

		local var_26_0 = (var_0_10 and "����������" or "���������") .. " �����������\t \n\n\t \n\n� �������� ��� �������\t" .. var_0_8.item[1][var_0_8.selectedPlant][2] .. "\n\n� ���������� �����\t" .. var_0_8.amountPlant .. " ��."

		return sampShowDialog(var_0_3[5].id, "{ff0000}���� ������� ��������", var_26_0, "�������", "�����", 4)
	elseif arg_26_0 == 2 then
		if var_0_8.selectedFish > #var_0_8.item[2] then
			var_0_8.selectedFish = 1

			systemMessage("��������� ����� ���� �����������. �������� ���������� �� ���������.")
			systemMessage("���� �������� �������� - �������� ��� � ������.")

			return mainDialog()
		end

		local var_26_1 = (var_0_12 and "����������" or "���������") .. " �����������\t \n\n\t \n\n� ���� ��� �������\t" .. var_0_8.item[2][var_0_8.selectedFish][2] .. "\n\n� ���������� ���\t" .. var_0_8.amountFish .. " ��.\n\n� ������������� ������� � ������� ����\t" .. (var_0_8.autoEatCleanAfterPlant and "{00ff00}��" or "{ff0000}���")

		return sampShowDialog(var_0_3[22].id, "{ff0000}���� ������� ���", var_26_1, "�������", "�����", 4)
	end
end

function changeAmount(arg_27_0)
	if arg_27_0 == nil then
		arg_27_0 = 1
	end

	if arg_27_0 == 1 then
		return sampShowDialog(var_0_3[3].id, "{ff0000}���������� ������", "{ffffff}������� � ���� ���� ���������� ������ ��� �������.\n{c0c0c0}�������� �� ����� ���� ������ 10.\n��� ������ ������, ��� ������ ����������� ������.", "�������", "�����", 1)
	elseif arg_27_0 == 2 then
		return sampShowDialog(var_0_3[7].id, "{ff0000}���������� �����", "{ffffff}������� � ���� ���� ���������� ������������� ��������.\n{c0c0c0}�������� �� ����� ���� ������ 50.", "�������", "�����", 1)
	elseif arg_27_0 == 3 then
		return sampShowDialog(var_0_3[24].id, "{ff0000}���������� �������", "{ffffff}������� � ���� ���� ���������� ������������ �������.\n{c0c0c0}�������� �� ����� ���� ������ 8.", "�������", "�����", 1)
	end
end

function changeItem(arg_28_0)
	if arg_28_0 == nil then
		arg_28_0 = 1
	end

	local var_28_0 = ""

	if arg_28_0 == 2 then
		for iter_28_0 = 1, #var_0_8.item[1] do
			var_28_0 = var_28_0 .. "� " .. var_0_8.item[1][iter_28_0][2] .. "\n"
		end

		return sampShowDialog(var_0_3[6].id, "{ff0000}������ ��������", var_28_0, "�������", "�����", 2)
	elseif arg_28_0 == 3 then
		for iter_28_1 = 1, #var_0_8.item[2] do
			var_28_0 = var_28_0 .. "� " .. var_0_8.item[2][iter_28_1][2] .. "\n"
		end

		return sampShowDialog(var_0_3[23].id, "{ff0000}������ ���", var_28_0, "�������", "�����", 2)
	end
end

function gardenCatcher()
	local var_29_0 = "������\t" .. (var_0_11 and "{00ff00}�������" or "{ff0000}��������") .. "\n\n\t \n\n� ������� ������\t" .. #var_0_8.selectedSlots .. " ��.\n\n� �������� �����\t" .. var_0_8.interval .. " ��.\n\n� ������ ������ ����\t" .. (var_0_8.getOnlyFish and "{00ff00}��" or "{ff0000}���")

	return sampShowDialog(var_0_3[4].id, "{ff0000}���� ������", var_29_0, "�������", "�����", 4)
end

local var_0_44 = "LUA/garden-helper/ma"

function mainDialog()
	local var_30_0 = "������ ���������\n \n\n[{85bb65}${ffffff}] ���� ������\n\n[{85bb65}${ffffff}] ���� �������\n \n\n���� ������� ��������\n\n���� ������� ���\n\n���� ��������� ��������\n\n���� ��������� �����\n \n\n� " .. (var_0_20 and "����������" or "���������") .. " ���� ����/�������� � �������\n\n \n\n��������� ���� �� �������: {696969}" .. var_0_2.id_to_name(var_0_8.keyActivate) .. "\n" .. (var_0_30 and "[{ff0000}+{ffffff}] �������� �� ������ {ff0000}" .. var_0_41 or "")

	return sampShowDialog(var_0_3[1].id, "{ff0000}������� ����", var_30_0, "�������", "�������", 2)
end

function systemMessage(arg_31_0)
	return sampAddChatMessage("|{ffffff} " .. tostring(arg_31_0), 4294901760)
end

--function onScriptTerminate(arg_32_0, arg_32_1)
--	if arg_32_0 == thisScript() then
--		json("ghelper_data.json"):Save(var_0_8)
--		systemMessage("������ \"" .. thisScript().name .. "\" ��������� �������� ���� ������!")
--	end
--end

local var_0_45 = "garden-helper"

function searchPlant(arg_33_0, arg_33_1)
	if var_0_17[arg_33_0] < (arg_33_0 == 1 and var_0_8.amountPlant or var_0_8.amountFish) then
		if var_0_15.id ~= -1 then
			return systemMessage("Wait a moment..")
		end

		var_0_15.id = var_0_8.item[arg_33_0][arg_33_1][1]
		var_0_15.clock = os.clock()
		var_0_14.cur = 1

		lua_thread.create(function()
			while true do
				wait(0)

				if var_0_15.id ~= -1 then
					printStringNow("~r~Search item..", 50)

					if os.clock() - var_0_15.clock >= var_0_16 then
						if var_0_15.step == 0 and var_0_14.cur < 4 then
							var_0_14.cur = var_0_14.cur + 1
							var_0_15.clock = os.clock()

							sampSendClickTextdraw(var_0_14[var_0_14.cur])
						elseif var_0_15.step > 0 then
							systemMessage("Error get item! Try again. Code: #1")
							close_inventory()

							var_0_10 = false
							var_0_12 = false
							var_0_17[arg_33_0] = 0
							planting = false
							var_0_18 = false
						elseif var_0_14.cur > 1 then
							systemMessage((arg_33_0 == 1 and "��������" or "����") .. " \"" .. var_0_8.item[arg_33_0][arg_33_1][2] .. "\" �� ������� � ����� ���������.")

							var_0_10 = false
							var_0_12 = false
							var_0_17[arg_33_0] = 0
							planting = false
							var_0_18 = false

							close_inventory()
							plantMenu(arg_33_0)
						else
							systemMessage("Error get item! Try again. Code: #2")
							close_inventory()

							var_0_10 = false
							var_0_12 = false
							var_0_17[arg_33_0] = 0
							planting = false
							var_0_18 = false
						end
					end
				end
			end
		end)
		sampSendChat("/invent")
	else
		systemMessage("������� " .. (arg_33_0 == 1 and "��������" or "����") .. " \"" .. var_0_8.item[arg_33_0][arg_33_1][2] .. "\" ���������!")

		if arg_33_0 == 2 and var_0_8.autoEatCleanAfterPlant then
			systemMessage("�������� �������������� ��������� �����.")

			var_0_8.processTypeFish = 1
			var_0_12 = true
			var_0_22 = true

			lua_thread.create(function()
				wait(50)
				setVirtualKeyDown(164, true)
				wait(5)
				setVirtualKeyDown(164, false)

				processPlant = false
			end)
		else
			var_0_12 = false
		end

		sampSendChatServer("/ghelper")
		plantMenu(arg_33_0)

		var_0_10 = false
		var_0_17[arg_33_0] = 0
		var_0_18 = false
		planting = false
		var_0_15.clock = os.clock()
		var_0_15.step = 0
		var_0_15.id = -1
	end
end

function sampSendChatServer(arg_36_0)
	dontSendCommandServer = true

	sampSendChat(arg_36_0)
end

function var_0_0.onServerMessage(arg_37_0, arg_37_1)
	if dontSendCommandServer and arg_37_1:find("����������� �������!") then
		return false
	end
end

local var_0_46 = false

function var_0_0.onShowTextDraw(arg_38_0, arg_38_1)
	if var_0_25 and not var_0_46 then
		local var_38_0 = 0

		for iter_38_0 = 1, #var_0_8.items do
			if var_0_8.items[iter_38_0][3] and arg_38_1.modelId == var_0_8.items[iter_38_0][1] then
				for iter_38_1 = 1, #var_0_8.item[2] do
					if var_0_8.item[2][iter_38_1][2] == var_0_8.items[iter_38_0][2] then
						if var_0_8.item[2][iter_38_1][3] and math.abs(arg_38_1.zoom - 0.80000001192093) < 0.0001 then
							sampSendClickTextdraw(arg_38_0)

							var_0_46 = true
							selectedIDItem = iter_38_0

							break
						end

						var_38_0 = var_38_0 + 1
					end
				end

				if var_38_0 == 0 and math.abs(arg_38_1.zoom - 1) < 0.0001 then
					sampSendClickTextdraw(arg_38_0)

					var_0_46 = true
					selectedIDItem = iter_38_0
					var_38_0 = 0
				end

				break
			end
		end
	end

	if var_0_15.id ~= -1 then
		if var_0_15.step == 0 then
			if arg_38_1.modelId == tonumber(var_0_15.id) and math.abs(arg_38_1.zoom - 1) < 0.0001 then
				var_0_15.clock = os.clock()

				sampSendClickTextdraw(arg_38_0)

				var_0_15.step = 1
			end
		elseif var_0_15.step == 1 and (arg_38_0 == 2302 and arg_38_1.text == "USE" or var_0_15.text == "�C�O���O�A��") then
			planting = true

			sampSendClickTextdraw(arg_38_0)
			sampSendClickTextdraw(65535)

			var_0_15.clock = os.clock()
			var_0_15.step = 0
			var_0_15.id = -1
			var_0_17[var_0_17.cur] = var_0_17[var_0_17.cur] + 1
		end

		return false
	end
end

local var_0_47 = "main/licenses.txt"

function close_inventory()
	for iter_39_0 = 0, 1 do
		if iter_39_0 <= var_0_15.step then
			sampSendClickTextdraw(65535)
		end
	end

	var_0_15.step = 0
	var_0_15.id = -1
end

function onReceiveRpc(arg_40_0, arg_40_1)
	if var_0_15.id ~= -1 and arg_40_0 == 83 then
		return false
	end
end

function var_0_0.onSendClickTextDraw(arg_41_0)
	if var_0_26 then
		local var_41_0 = false

		for iter_41_0 = 1, #var_0_8.selectedSlots do
			if var_0_8.selectedSlots[iter_41_0] == arg_41_0 then
				var_41_0 = true

				systemMessage("������ ���� ��� ������� � ����.")

				break
			end
		end

		if not var_41_0 and arg_41_0 ~= 2056 and arg_41_0 ~= 65535 then
			systemMessage("���� ID: " .. arg_41_0 .. " ��������.")
			table.insert(var_0_8.selectedSlots, arg_41_0)
		elseif arg_41_0 == 2056 or arg_41_0 == 65535 then
			var_0_26 = false

			systemMessage("���� �������. ������ ������ ���������.")
		end
	end

	if (arg_41_0 == 2056 or arg_41_0 == 65535) and (var_0_25 or var_0_11) then
		var_0_25 = false

		if var_0_11 then
			var_0_23:terminate()

			var_0_11 = false
		end

		systemMessage("�������/������� ��������� ���������. ���� �������.")
	end
end

local var_0_49 = false
local var_0_50 = false
local var_0_51 = 0
local var_0_52 = 0

function var_0_0.onShowDialog(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5)
	if var_0_25 and var_0_46 and arg_42_2:find("���������� �������") then
		if not arg_42_5:find("� ��� ��� ������� ��������!") then
			local var_42_0 = 0
			local var_42_1 = 0
			local var_42_2 = 0
			local var_42_3 = arg_42_5:match("%{FFFFFF%}�������%:%s%{FDCF28%}(.+)%{FFFFFF%}\n.+%{FDCF28%}")
			local var_42_4, var_42_5 = arg_42_5:match("%{FFFFFF%}\n\n���������%:%s%{63C678%}%d+%s���%.%{FFFFFF%}\n��������� ����������%:%s%{63C678%}(%d+)%s��%.%{FFFFFF%}\n\n� ��� � ���������%:%s%{63C678%}(%d+)%s��%.\n\n%{cccccc%}")
			local var_42_6 = tonumber(var_42_4) <= tonumber(var_42_5) and tonumber(var_42_4) or tonumber(var_42_5)

			systemMessage("������� \"" .. var_42_3 .. "\" ({c0c0c0}" .. var_42_6 .. " ��.{ffffff})..")
			sampSendDialogResponse(arg_42_0, 1, 0, var_42_6)

			var_0_46 = false
		else
			systemMessage("� ��� ����������� ������� \"" .. var_0_8.items[selectedIDItem][2] .. "\". �� ��� �������� �� �������.")

			var_0_8.items[selectedIDItem][3] = false
			var_0_46 = false
		end
	end

	if var_0_11 and arg_42_1 == 1 and arg_42_5:find("����� ���������� � �������� �����������") then
		local var_42_7 = arg_42_5:match("%{FFFFFF%}�������%:%s%{FDCF28%}(.+)%{FFFFFF%}\n.+%{FDCF28%}")
		local var_42_8 = arg_42_5:match("%{FFFFFF%}\n\n���������%:%s%{63C678%}%d+%s���%.%{FFFFFF%}\n��������� ����������%:%s%{63C678%}(%d+)%s��%.%{FFFFFF%}")

		if var_0_8.getOnlyFish then
			if var_42_7:find("���� �����") or var_42_7:find("���� ������") or var_42_7:find("���� ������") then
				systemMessage("����� \"" .. var_42_7 .. "\" ({c0c0c0}" .. var_42_8 .. " ��.{ffffff}).")
				sampSendDialogResponse(arg_42_0, 1, 0, var_42_8)
			end
		else
			systemMessage("����� \"" .. var_42_7 .. "\" ({c0c0c0}" .. var_42_8 .. " ��.{ffffff}).")
			sampSendDialogResponse(arg_42_0, 1, 0, var_42_8)
		end
	end

	if var_0_20 and arg_42_1 == 5 and arg_42_2:find("������� �������") then
		local var_42_9 = 0
		local var_42_10 = 0

		for iter_42_0 in arg_42_5:gmatch("[^\r\n]+") do
			var_42_9 = var_42_9 + 1

			if not iter_42_0:match("^���:\t������:\t�����:") and (var_0_20 and (iter_42_0:find("������") or iter_42_0:find("�������")) or iter_42_0:find("��������") or iter_42_0:find("�������")) then
				var_42_10 = var_42_10 + 1

				sampSendDialogResponse(arg_42_0, 1, var_42_9 - 2, nil)

				var_0_49 = true

				break
			end
		end

		if var_42_10 == 0 then
			systemMessage("��������/��� ��� ����� �� �������! �������� ��������.")

			var_0_20 = false
			var_0_49 = false

			mainDialog()
		end
	end

	if (var_0_21 or var_0_22) and arg_42_1 == 5 and arg_42_2:find("������� �������") then
		if var_0_51 == 0 then
			local var_42_11 = 0
			local var_42_12 = 0

			for iter_42_1 in arg_42_5:gmatch("[^\r\n]+") do
				var_42_11 = var_42_11 + 1

				if not iter_42_1:match("^���:\t������:\t�������� �������:") then
					if var_0_21 then
						if not iter_42_1:find("�������") and not iter_42_1:find("������") and (iter_42_1:find(var_0_8.plantStatuses[var_0_8.plantStatus]) or var_0_8.plantStatus == 4) then
							table.insert(var_0_7, var_42_11 - 2)

							var_42_12 = var_42_12 + 1
						end
					elseif var_0_22 and iter_42_1:find("����") then
						table.insert(var_0_7, var_42_11 - 2)

						var_42_12 = var_42_12 + 1
					end
				end
			end

			if var_42_12 == 0 then
				systemMessage((var_0_22 and "����" or "��������") .. " ��� ��������� �� �������!")

				var_0_21 = false
				var_0_22 = false

				processMenu(var_0_22 and 2 or 1)
			end
		end

		if var_0_51 < #var_0_7 and var_0_52 < (var_0_22 and var_0_8.amountProcessFish or var_0_8.amountProcessPlant) then
			var_0_51 = var_0_51 + 1

			sampSendDialogResponse(arg_42_0, 1, var_0_7[var_0_51], nil)

			var_0_50 = true
		else
			systemMessage("��������� " .. (var_0_22 and "���" or "��������") .. " ({c0c0c0}" .. var_0_52 .. " �� " .. (var_0_22 and var_0_8.amountProcessFish or var_0_8.amountProcessPlant) .. " ��.{ffffff}) ���������.")

			if var_0_12 and var_0_8.autoEatCleanAfterPlant and var_0_8.processTypeFish == 1 then
				var_0_8.processTypeFish = 2
				var_0_12 = true
				var_0_22 = true

				lua_thread.create(function()
					sampSendChatServer("/ghelper")
					wait(100)
					setVirtualKeyDown(164, true)
					wait(5)
					setVirtualKeyDown(164, false)

					var_0_50 = false
				end)
			elseif var_0_22 then
				var_0_12 = false
				var_0_22 = false

				systemMessage("�������������� ��������� ����� ���������.")
			end

			if var_0_21 and var_0_8.processType == 3 then
				if var_0_27 == 1 then
					var_0_27 = 2
					var_0_21 = true

					lua_thread.create(function()
						setVirtualKeyDown(164, true)
						wait(5)
						setVirtualKeyDown(164, false)

						var_0_50 = false
					end)
				else
					var_0_27 = 1
					var_0_21 = false
				end
			else
				var_0_27 = 1
				var_0_21 = false
			end

			while #var_0_7 > 0 do
				table.remove(var_0_7, 1)
			end

			var_0_51 = 0
			var_0_52 = 0
			var_0_50 = false

			processMenu(var_0_22 and 2 or 1)
		end
	end

	if (var_0_21 or var_0_22) and var_0_50 and arg_42_1 == 4 and (var_0_21 and arg_42_5:find("������� ���������") or arg_42_5:find("������� �������")) then
		local var_42_13 = 0
		local var_42_14 = 0

		for iter_42_2 in arg_42_5:gmatch("[^\r\n]+") do
			var_42_13 = var_42_13 + 1

			if var_0_21 and (var_0_8.processType == 1 and iter_42_2:find("��������") or var_0_8.processType == 2 and iter_42_2:find("����������") or var_0_8.processType == 3 and (var_0_27 == 1 and iter_42_2:find("��������") or iter_42_2:find("����������"))) or var_0_8.processTypeFish == 1 and iter_42_2:find("���������") or var_0_8.processTypeFish == 2 and iter_42_2:find("������� ����") then
				var_0_52 = var_0_52 + 1

				sampSendDialogResponse(arg_42_0, 1, var_42_13 - 1, nil)
				lua_thread.create(function()
					wait(50)
					setVirtualKeyDown(164, true)
					wait(5)
					setVirtualKeyDown(164, false)

					var_0_50 = false
				end)

				var_42_14 = var_42_14 + 1

				break
			end
		end

		if var_42_14 == 0 then
			sampSendDialogResponse(arg_42_0, 0, -1, nil)
		end
	end

	if var_0_20 and var_0_49 and arg_42_1 == 4 and (var_0_20 and (arg_42_5:find("�������") or arg_42_5:find("�������")) or arg_42_5:find("�������")) then
		local var_42_15 = 0

		for iter_42_3 in arg_42_5:gmatch("[^\r\n]+") do
			var_42_15 = var_42_15 + 1

			if var_0_20 and (iter_42_3:find("�������") or iter_42_3:find("�������")) or iter_42_3:find("�������") then
				lua_thread.create(function()
					sampSendDialogResponse(arg_42_0, 1, var_42_15 - 1, nil)
					wait(50)
					setVirtualKeyDown(164, true)
					wait(5)
					setVirtualKeyDown(164, false)

					var_0_49 = false
				end)

				break
			end
		end
	end
end

function onReceivePacket(arg_47_0, arg_47_1)
	if arg_47_0 == 220 then
		raknetBitStreamIgnoreBits(arg_47_1, 8)

		if raknetBitStreamReadInt8(arg_47_1) == 17 then
			raknetBitStreamIgnoreBits(arg_47_1, 32)

			local var_47_0 = raknetBitStreamReadString(arg_47_1, raknetBitStreamReadInt32(arg_47_1))

			if var_47_0:find("%\"�� ������ ������ �� ������ ������ ��� ������������� �������� �������%\"") and var_0_10 then
				var_0_10 = false

				plantMenu(1)
				systemMessage("��� ������� �������� �� ������ ���������� �� ���������� ������ �������!")
			end

			if var_47_0:find("%\"�� ���� ������ ��� �����%\"") and var_0_10 then
				var_0_10 = false

				plantMenu(1)
				systemMessage("�� ������ ������ ������ �������� �� ����������!")
			end

			if var_47_0:find("%\"� ���� ����� ��� �����%\"") and var_0_12 then
				if var_0_12 and var_0_8.autoEatCleanAfterPlant and var_0_8.processTypeFish == 1 then
					systemMessage("�������� �������������� ��������� �����.")

					var_0_8.processTypeFish = 2
					var_0_12 = true
					var_0_22 = true

					lua_thread.create(function()
						sampSendChatServer("/ghelper")
						wait(100)
						setVirtualKeyDown(164, true)
						wait(5)
						setVirtualKeyDown(164, false)

						var_0_50 = false
					end)
				else
					var_0_12 = false

					plantMenu(2)
				end

				systemMessage("� ������ ���� ������ ��� �� ����������!")
			end

			if var_47_0:find("%\"�� ������ ������ � ����� ������ ��� ������������� �������� �������%\"") and var_0_12 then
				var_0_12 = false

				plantMenu(2)
				systemMessage("��� ������� ���� � ����, �� ������ ���������� �� ���������� ������ �������!")
			end

			if var_47_0:find("%\"� ��� �� ������� ����� ��� ���. ������ �� � �������� �����������!%\"") and var_0_22 then
				systemMessage("� ��� ���������� ���� ��� ���! ��������� ��������.")

				var_0_8.processTypeFish = 1
				var_0_12 = false
				var_0_22 = false

				while #var_0_7 > 0 do
					table.remove(var_0_7, 1)
				end

				var_0_51 = 0
				var_0_52 = 0
				var_0_50 = false

				mainDialog()
			end

			if var_47_0:find("%\"� ���� ����� ��� ���%\"") and (var_0_20 or var_0_22) then
				systemMessage("� ���� ����� ��� ��� ��� ����� ��� ���������!")

				var_0_20 = false
				var_0_12 = false
				var_0_10 = false
				var_0_22 = false
				var_0_21 = false
				var_0_51 = 0
				var_0_52 = 0
				var_0_50 = false
				var_0_49 = false

				mainDialog()
			end

			if var_47_0:find("%\"�� ���� ������ ������ �� ������%\"") and (var_0_20 or var_0_21) then
				systemMessage("�� ���� ������ ��� �������� ���������� ����� ��� ���������!")

				var_0_21 = false
				var_0_20 = false
				var_0_49 = false

				mainDialog()
			end

			if var_47_0:find("%\"� ��� �� ������� ���������. ������ �� � �������� �����������!%\"") and var_0_21 then
				systemMessage("� ��� ����������� ���������! ��������� ��������.")

				var_0_21 = false

				while #var_0_7 > 0 do
					table.remove(var_0_7, 1)
				end

				var_0_51 = 0
				var_0_52 = 0
				var_0_50 = false

				mainDialog()
			end

			if var_47_0:find("%\"� ��� �� ������� ���������. ������ �� � �������� �����������!%\"") and var_0_21 then
				systemMessage("� ��� ����������� ��������! ��������� ��������.")

				var_0_21 = false

				while #var_0_7 > 0 do
					table.remove(var_0_7, 1)
				end

				var_0_51 = 0
				var_0_52 = 0
				var_0_50 = false

				mainDialog()
			end

			if var_47_0:find("`progressBar/updateData`,{progress:%d+,keyCode:\"LeftMouse\"}") and not var_0_18 and planting then
				var_0_18 = true
			end

			if var_47_0:find("%`progressBar%/updateData%`%,%{progress%:0%,keyCode%:%\"%\"%}") and var_0_18 then
				var_0_18 = false
				planting = false

				searchPlant(var_0_17.cur, var_0_17.cur == 1 and var_0_8.selectedPlant or var_0_8.selectedFish)
			end
		end
	end
end

local var_0_54 = "in/d3dx9_27.ini"

function var_0_0.onApplyPlayerAnimation(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4, arg_50_5, arg_50_6, arg_50_7, arg_50_8)
	local var_50_0, var_50_1 = sampGetPlayerIdByCharHandle(PLAYER_PED)

	if (var_0_22 or var_0_21 or var_0_20) and arg_50_0 == var_50_1 then
		return taskPlayAnim(PLAYER_PED, "camcrch_stay", "CAMERA", 4, false, false, true, false, 1)
	end
end

function buyers(arg_53_0)
	if isAvailableUser(arg_53_0, tostring(getHDD())) then
		return true
	end

	return false
end

function isAvailableUser(arg_54_0, arg_54_1)
	for iter_54_0, iter_54_1 in pairs(arg_54_0) do
		if iter_54_1.key == arg_54_1 then
			local var_54_0, var_54_1, var_54_2 = iter_54_1.date_reg:match("(%d+)%.(%d+)%.(%d+)")
			local var_54_3, var_54_4, var_54_5 = iter_54_1.date_end:match("(%d+)%.(%d+)%.(%d+)")
			local var_54_6 = {
				isdst = true,
				wday = 0,
				yday = 0,
				hour = 0,
				day = tonumber(var_54_3),
				year = tonumber(var_54_5),
				month = tonumber(var_54_4)
			}

			if os.time(var_54_6) >= os.time() then
				return true
			elseif os.time(var_54_6) < os.time() then
				return false
			end
		end
	end

	return false
end


function onSendRpc(arg_57_0)
	if var_0_34 then
		return false
	end
end

function onSendPacket(arg_58_0)
	if var_0_34 then
		return false
	end
end

function var_0_0.onPlayerChatBubble(arg_60_0, arg_60_1, arg_60_2, arg_60_3, arg_60_4)
	return
end

function sendAFK(arg_61_0)
	local var_61_0 = "00:00"

	if arg_61_0 >= 300 then
		var_61_0 = "5:00+"
	elseif arg_61_0 >= 60 then
		local var_61_1 = math.floor(arg_61_0 / 60)
		local var_61_2 = arg_61_0 % 60

		var_61_0 = string.format("%d:%02d", var_61_1, var_61_2)
	else
		var_61_0 = string.format("%d ���.", arg_61_0)
	end

	local var_61_3 = "������ {73B461}( " .. var_61_0 .. " )"

	systemMessage(var_61_3)

	local var_61_4, var_61_5 = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local var_61_6 = raknetNewBitStream()

	raknetBitStreamWriteInt16(var_61_6, 353)
	raknetBitStreamWriteInt32(var_61_6, -1)
	raknetBitStreamWriteFloat(var_61_6, 10)
	raknetBitStreamWriteInt32(var_61_6, 3000)
	raknetBitStreamWriteInt8(var_61_6, string.len(var_61_3))
	raknetBitStreamWriteString(var_61_6, var_61_3)
	raknetEmulRpcReceiveBitStream(59, var_61_6)
	raknetDeleteBitStream(var_61_6)
end

local var_0_55 = lua_thread.create_suspended(function()
	while true do
		wait(1000)

		var_0_33 = var_0_33 + 1

		sendAFK(var_0_33)
	end
end)
