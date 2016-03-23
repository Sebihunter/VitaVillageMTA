--[[
Project: VitaOnline
File: trucker-client.lua
Author(s):	Golf_R32
]]--

local tourVehicle = false
local cooldown = false

local theMissiTruckerMarker = {}
function startthetruckermarker()
	theMissiTruckerMarkerMain = createMarker(1051.328,2134.599,9.8203,"cylinder",4,95,255,0,100) -- mainmarker
        theMissiTruckerMarker[1] = createMarker(-1709.9001464844, 391.71633911133, 6.1887049674988, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[2] = createMarker(-1810.8876953125, 614.88592529297, 34.16529083252, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[3] = createMarker(-1936.3981933594, 274.23913574219, 40.080673217773, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[4] = createMarker(-2647.84375, 701.35101318359, 26.866451263428, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[5] = createMarker(-2862.5993652344, 814.04547119141, 38.02014541626, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[6] = createMarker(-2490.0041503906, 732.36120605469, 33.943077087402, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[7] = createMarker(-2834.6108398438, 926.03515625, 43.136627197266, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[8] = createMarker(-2868.1850585938, 994.83862304688, 39.412666320801, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[9] = createMarker(-2888.6259765625, 1065.9006347656, 30.698028564453, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[10] = createMarker(-2575.1850585938, 1365.7586669922, 6.1911039352417, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[11] = createMarker(-2438.7331542969, 1331.3016357422, 9.610990524292, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[12] = createMarker(-2438.8439941406, 1304.0421142578, 17.067361831665, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[13] = createMarker(-1016.112121582, -635.7568359375, 32.0078125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[14] = createMarker(-2438.6450195313, 1277.6154785156, 24.259830474854, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[15] = createMarker(-2439.669921875, 1257.2619628906, 29.7780418396, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[16] = createMarker(-2471.5395507813, 1247.880859375, 32.316371917725, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[17] = createMarker(-2359.4968261719, 1305.4080810547, 17.34458732605, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[18] = createMarker(-148.0934753418, -365.96099853516, 0.4296875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[19] = createMarker(-2359.7866210938, 1230.8950195313, 31.489574432373, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[20] = createMarker(-2151.3256835938, 1185.6309814453, 54.578125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[21] = createMarker(-2080.0891113281, 1168.4533691406, 48.234848022461, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[22] = createMarker(-2043.1862792969, 1107.9660644531, 52.2890625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[23] = createMarker(-2084.4055175781, 1138.5517578125, 49.311019897461, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[24] = createMarker(-2011.4503173828, 996.26123046875, 49.056804656982, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[25] = createMarker(-2134.4096679688, 947.17407226563, 78.8515625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[26] = createMarker(-2152.2685546875, 1046.9237060547, 79, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[27] = createMarker(-2223.4143066406, 1088.5659179688, 78.8515625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[28] = createMarker(-2273.7824707031, 1018.4309082031, 83.641723632813, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[29] = createMarker(-1642.2476806641, 1214.5634765625, 6.0390625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[30] = createMarker(-1536.9792480469, 724.47503662109, 6.0390625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[31] = createMarker(-1908.03515625, 832.62634277344, 34.015625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[32] = createMarker(-2011.3287353516, 835.56829833984, 44.296875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[33] = createMarker(-1728.2998046875, 1353.3537597656, 6.1874995231628, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[34] = createMarker(-2052.5893554688, 1267.8181152344, 7.2477550506592, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[35] = createMarker(-1951.6195068359, 724.51873779297, 44.296875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[36] = createMarker(-2248.2709960938, 694.19348144531, 48.296875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[37] = createMarker(-2018.4108886719, 158.4437713623, 27.067810058594, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[38] = createMarker(-2080.5234375, -75.234649658203, 34.171875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[39] = createMarker(-2309.1909179688, -149.42442321777, 34.3203125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[40] = createMarker(-2505.7087402344, -18.530809402466, 24.609375, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[41] = createMarker(-2353.4152832031, 663.82171630859, 34.476009368896, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[42] = createMarker(-2553.4384765625, 713.16125488281, 26.8125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[43] = createMarker(-2732.2648925781, -309.74694824219, 6.0390625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[44] = createMarker(-2858.5588378906, 448.86981201172, 3.3593559265137, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[45] = createMarker(-2798.6879882813, 209.6136932373, 6.1875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[46] = createMarker(-2710.2126464844, 197.18249511719, 3.1796875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[47] = createMarker(-2804.3195800781, 101.55618286133, 6.03125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[48] = createMarker(-2759.4230957031, -44.918567657471, 5.9771127700806, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[49] = createMarker(-2601.8869628906, 326.73663330078, 3.1796879768372, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[50] = createMarker(-2702.267578125, -289.7900390625, 6.0390625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[51] = createMarker(-2434.8833007813, -602.07202148438, 131.37902832031, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[52] = createMarker(-2624.8002929688, 213.37246704102, 3.5002665519714, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[53] = createMarker(-1945.3172607422, -854.93481445313, 31.0234375, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[54] = createMarker(-2767.6203613281, -1530.5897216797, 139.12942504883, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[55] = createMarker(-1578.1895751953, -2723.2185058594, 47.5390625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[56] = createMarker(-2045.8089599609, 558.70751953125, 34.015625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[57] = createMarker(-2050.1228027344, -2523.6096191406, 29.625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[58] = createMarker(-2121.669921875, -2517.2551269531, 29.46875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[59] = createMarker(-2198.7578125, -2273.0964355469, 29.46875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[60] = createMarker(435.38311767578, -1340.3448486328, 13.959060668945, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[61] = createMarker(1204.9738769531, -931.33129882813, 41.726898193359, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[62] = createMarker(1956.8190917969, -1776.9952392578, 12.3828125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[63] = createMarker(1966.4892578125, -1997.1569824219, 12.3828125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[64] = createMarker(2220.84375, -2647.8955078125, 12.377377510071, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[65] = createMarker(2489.66015625, -2595.6791992188, 12.452066421509, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[66] = createMarker(2862.7722167969, -1903.3070068359, 9.9346122741699, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[67] = createMarker(2743.1296386719, -1305.1416015625, 51.923988342285, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[68] = createMarker(2637.52734375, -1070.0272216797, 68.625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[69] = createMarker(2587.7578125, -960.2724609375, 81.3515625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[70] = createMarker(2506.3864746094, -1042.2943115234, 68.044136047363, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[71] = createMarker(2173.6145019531, -1001.546875, 61.79825592041, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[72] = createMarker(1959.1844482422, -1093.5300292969, 24.358345031738, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[73] = createMarker(1789.1231689453, -1168.0037841797, 22.652067184448, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[74] = createMarker(1885.4973144531, -1345.7564697266, 12.3828125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[75] = createMarker(1634.7884521484, -1727.4923095703, 12.3828125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[76] = createMarker(1342.2863769531, -1745.3895263672, 12.379270553589, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[77] = createMarker(1200.8518066406, -1707.4287109375, 12.382811546326, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[78] = createMarker(1151.0959472656, -1745.8411865234, 12.3984375, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[79] = createMarker(1728.9366455078, -2324.2111816406, -3.8515625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[80] = createMarker(1279.3673095703, -2051.4331054688, 57.902637481689, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[81] = createMarker(1392.9553222656, -1877.0593261719, 12.3828125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[82] = createMarker(1365.1192626953, -1660.0715332031, 12.3828125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[83] = createMarker(1423.0080566406, -1297.3889160156, 12.5546875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[84] = createMarker(2397.8664550781, -1484.1767578125, 22.828125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[85] = createMarker(1245.4736328125, 350.19888305664, 18.40625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[86] = createMarker(2415.6804199219, -1251.5372314453, 22.8125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[87] = createMarker(1337.5200195313, 347.00531005859, 18.40625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[88] = createMarker(759.41595458984, -1705.7353515625, 4.6733708381653, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[89] = createMarker(647.76794433594, -1462.3079833984, 13.50728225708, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[90] = createMarker(548.10925292969, -1254.9055175781, 15.706645965576, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[91] = createMarker(1350.9078369141, 254.46139526367, 19.40625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[92] = createMarker(2486.8295898438, 2768.5473632813, 9.7776794433594, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[93] = createMarker(-1317.1064453125, 2695.6713867188, 49.0625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[94] = createMarker(1369.2945556641, 453.0182800293, 18.872745513916, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[95] = createMarker(-1532.46875, 2638.6413574219, 54.8359375, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[96] = createMarker(-2524.3811035156, 2267.6066894531, 3.8359375, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[97] = createMarker(-2452.966796875, 2501.6416015625, 14.60237121582, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[98] = createMarker(318.81384277344, -67.389060974121, 0.4296875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[99] = createMarker(-2662.6958007813, 999.35217285156, 63.595336914063, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[100] = createMarker(-2799.3325195313, 774.05505371094, 48.982788085938, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[101] = createMarker(267.98699951172, -216.37219238281, 1.4296875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[102] = createMarker(-2464.1669921875, -128.94694519043, 24.6171875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[103] = createMarker(-2216.1213378906, 105.90760040283, 34.3203125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[104] = createMarker(-1420.1363525391, -298.36764526367, 13, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[105] = createMarker(-700.81237792969, 953.93780517578, 11.35057926178, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[106] = createMarker(178.01554870605, -49.396812438965, 0.43465137481689, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[107] = createMarker(-320.685546875, 1314.3659667969, 52.083503723145, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[108] = createMarker(-138.84210205078, 1209.1040039063, 18.7421875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[109] = createMarker(128.38565063477, -172.64990234375, 0.42968654632568, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[110] = createMarker(1066.1771240234, 1366.865234375, 9.8214225769043, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[111] = createMarker(1002.7250976563, 1739.4252929688, 9.7734375, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[112] = createMarker(1002.4885253906, 2337.3005371094, 9.671875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[113] = createMarker(1340.6479492188, 1948.5180664063, 9.671875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[114] = createMarker(-422.07717895508, -633.1826171875, 10.368284225464, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[115] = createMarker(2620.6821289063, 1678.3857421875, 9.8203125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[116] = createMarker(2609.4914550781, 1431.5422363281, 9.8203125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[117] = createMarker(2422.5834960938, 1126.2116699219, 9.671875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[118] = createMarker(2387.0671386719, 1037.2781982422, 9.8203125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[119] = createMarker(2124.9638671875, 955.13287353516, 9.8203125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[120] = createMarker(1702.6766357422, 2083.2819824219, 9.671875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[121] = createMarker(2040.3646240234, 1007.5025024414, 9.671875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[122] = createMarker(1667.3326416016, 1981.7965087891, 9.8203125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[123] = createMarker(-286.06448364258, -2189.876953125, 27.406337738037, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[124] = createMarker(-1204.1103515625, 1837.5921630859, 40.71875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[125] = createMarker(-1421.7895507813, 2170.9663085938, 48.846664428711, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[126] = createMarker(-1518.8649902344, 2556.8049316406, 54.839199066162, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[127] = createMarker(-1348.5953369141, 2055.6911621094, 51.701564788818, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[128] = createMarker(-1471.6215820313, 1850.4403076172, 31.588260650635, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[129] = createMarker(-1494.0944824219, 1966.2507324219, 47.417137145996, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[130] = createMarker(-675.32897949219, 2310.48828125, 133.26840209961, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[131] = createMarker(-532.04528808594, 2593.8559570313, 52.4140625, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[132] = createMarker(-848.06475830078, 1528.3933105469, 20.557970046997, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[133] = createMarker(-240.37280273438, 2602.1015625, 61.703125, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[134] = createMarker(688.31677246094, 1934.0352783203, 4.5390625, "cylinder", 4, 95, 255, 0, 0)
		theMissiTruckerMarker[135] = createMarker(1464.5014648438, 2775.4958496094, 9.671875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[136] = createMarker(783.42138671875, 1873.6134033203, 3.8562307357788, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[137] = createMarker(-294.85479736328, 1764.865234375, 41.6875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[138] = createMarker(-204.93521118164, 977.81756591797, 17.946128845215, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[149] = createMarker(276.84951782227, 1410.4890136719, 9.4341163635254, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[140] = createMarker(1069.9010009766, -311.64471435547, 72.9921875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[141] = createMarker(2304.7446289063, -1654.3310546875, 13.443879127502, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[142] = createMarker(374.29183959961, -2040.9114990234, 6.671875, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[143] = createMarker(322.52169799805, -1774.4357910156, 3.8449296951294, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[144] = createMarker(162.21017456055, 1159.9268798828, 13.597456932068, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[145] = createMarker(308.22692871094, -1510.6580810547, 23.59375, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[146] = createMarker(264.83084106445, -1233.8726806641, 72.645133972168, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[147] = createMarker(-83.527297973633, -1586.984375, 1.6107196807861, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[148] = createMarker(204.79229736328, -232.54284667969, 0.77861881256104, "cylinder", 4, 95, 255, 0, 0)
        theMissiTruckerMarker[149] = createMarker(-16.193840026855, 1194.4222412109, 18.2109375, "cylinder", 4, 95, 255, 0, 0)
		for i = 1,#theMissiTruckerMarker do
			if isElement(theMissiTruckerMarker[i]) then
				setElementDimension(theMissiTruckerMarker[i], 1234)
			end
		end
		addEventHandler("onClientMarkerHit", theMissiTruckerMarkerMain,startminimission2)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), startthetruckermarker)

local theminitruckermissiontext = ""
local neuesgeldblub = 0
local erreichteziele = 0
function startmissi2 ()
	local x,y = guiGetScreenSize()

	dxDrawText(theminitruckermissiontext, 5,0,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminitruckermissiontext, 0,5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminitruckermissiontext, 0,-5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminitruckermissiontext, -5,0,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)

	dxDrawText(theminitruckermissiontext, 5,5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminitruckermissiontext, -5,5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminitruckermissiontext, 5,-5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminitruckermissiontext, -5,-5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)

	dxDrawText(theminitruckermissiontext, 0,0,x,y*0.25,tocolor(255,100,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
end

setElementData(getLocalPlayer(), "isMiniMissionActivatedTruck", false)
exports.customblips:createCustomBlip(1051.328,2134.599, 16, 16, "images/blips/transportjob.png")
function startminimission2(player)
	if getLocalPlayer() == player then
		veh = getPedOccupiedVehicle(player)
		if not veh then addNotification(1, 255, 0, 0, "Du kannst den Minijob nur in einem 'Benson' beginnen.") return end
		if veh then
			if cooldown == true then return end
			if getElementData(getLocalPlayer(), "dienst") == 1 then addNotification(1, 255, 0, 0, "Du kannst keinen Nebenjob beginnen\nwenn du im Dienst bist.") return end
			if getVehicleOccupant(veh) == getLocalPlayer() then
				if getVehicleName(veh) ==  "Benson" then
				if getElementData(getLocalPlayer(), "isMiniMissionActivatedTruckPizza") ~= true then
					if getElementData(getLocalPlayer(), "isMiniMissionActivatedTruck") == false then
							if killermission and isTimer(killermission) then killTimer(killermission) end
							if isTimer(theverdienstgeldtimer) then killTimer(theverdienstgeldtimer) end
							addEventHandler("onClientRender", getRootElement(), startmissi2)
							theminitruckermissiontext = "Tour wurde gestartet!"
							showTutorialMessage("trucker_1", "Bringe die Ware zum Bestimmungspunkt. Du kannst nach jeder Lieferung auch wieder zurück zum Depot kommen um deinen Lohn und XP abzuholen.")
							tourVehicle = veh
							neuesgeldblub = 0
							setElementData(getLocalPlayer(), "isMiniMissionActivatedTruck", true)
							showPlayerHudComponent ( "radar", true )
							thebishergestartedtimer = setTimer(
														function()
															theminitruckermissiontext = "Bisher erreichte Ziele: "..erreichteziele
														end
														,3000,1)
							damarkerdenduhittenmsusst = math.random(1,#theMissiTruckerMarker)
							setMarkerColor(theMissiTruckerMarker[damarkerdenduhittenmsusst], 95, 255, 0,100)
							setElementDimension(theMissiTruckerMarker[damarkerdenduhittenmsusst], 0)
							thetruckermissionblip = createBlip(getElementPosition(theMissiTruckerMarker[damarkerdenduhittenmsusst]))
							addEventHandler("onClientMarkerHit", theMissiTruckerMarker[damarkerdenduhittenmsusst], markerhitofitititi2)
						elseif getElementData(getLocalPlayer(), "isMiniMissionActivatedTruck") == "neuensuchen" then
							if isTimer(theverdienstgeldtimer) then killTimer(theverdienstgeldtimer) end
							setElementData(getLocalPlayer(), "isMiniMissionActivatedTruck", true)
							damarkerdenduhittenmsusst = math.random(1,#theMissiTruckerMarker)
							setMarkerColor(theMissiTruckerMarker[damarkerdenduhittenmsusst], 95, 255, 0,100)
							setElementDimension(theMissiTruckerMarker[damarkerdenduhittenmsusst], 0)
							thetruckermissionblip = createBlip(getElementPosition(theMissiTruckerMarker[damarkerdenduhittenmsusst]))
							addEventHandler("onClientMarkerHit", theMissiTruckerMarker[damarkerdenduhittenmsusst], markerhitofitititi2)
						else
							if isTimer(thebishergestartedtimer) then killTimer(thebishergestartedtimer) end
								setElementData(getLocalPlayer(), "isMiniMissionActivatedTruck", false)
								theminitruckermissiontext = "Tour wurde abgebrochen!"
								if killermission and isTimer(killermission) then killTimer(killermission) end
								destroyElement(thetruckermissionblip)
								setMarkerColor(theMissiTruckerMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
								setElementDimension(theMissiTruckerMarker[damarkerdenduhittenmsusst], 1234)
								removeEventHandler("onClientMarkerHit", theMissiTruckerMarker[damarkerdenduhittenmsusst], markerhitofitititi2)
								cooldown = true
								setTimer(function() cooldown = false end, 15000, 1)
								theverdienstgeldtimer = setTimer(
								function()
									neuesgeldblub = math.floor(neuesgeldblub)
									theminitruckermissiontext = "Du hast "..neuesgeldblub.. " Vero verdient!"
									triggerServerEvent("giveTheMiniMissionPrize", getLocalPlayer(),getLocalPlayer(), neuesgeldblub)
									erreichteziele = 0
									showPlayerHudComponent ( "radar", false )
									theverdienstgeldtimer = setTimer(function() theminitruckermissiontext = ""  neuesgeldblub = 0  removeEventHandler("onClientRender", getRootElement(), startmissi2) end , 2000,1)
								end
								,3000,1)
			
					end
					end
								else
				theminitruckermissiontext = "Du brauchst einen 'Benson' um diese Tour zu starten!"
				if isTimer(theshitcarisfalschtimer) then
					killTimer(theshitcarisfalschtimer)
				end
				theshitcarisfalschtimer = setTimer(
				function()
					theminitruckermissiontext = ""
					end
				,3000,1)
				end
			end
		end
	end
end



function leftthemarkerofthemissi2(source)
	if source == getLocalPlayer() then
		if isTimer(theidletimerstart) then
			killTimer(theidletimerstart)
			theminitruckermissiontext = "Liefern unterbrochen! Bitte wiederholen!"
			removeEventHandler("onClientMarkerLeave", theMissiTruckerMarker[damarkerdenduhittenmsusst],leftthemarkerofthemissi2)
		end
	end
end
function markerhitofitititi2(player)
	if player == getLocalPlayer() then
		veh = getPedOccupiedVehicle(player)
		if veh then
			if getVehicleName(veh) ==  "Benson" then
				theminitruckermissiontext = "Wird abgeliefert!"
				theidletimerstart = setTimer(acceptthedurin2, 3000,1, player)
				addEventHandler("onClientMarkerLeave", theMissiTruckerMarker[damarkerdenduhittenmsusst], leftthemarkerofthemissi2)
			end
		end
	end
end
function acceptthedurin2(source)
	destroyElement(thetruckermissionblip)
	setMarkerColor(theMissiTruckerMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
	removeEventHandler("onClientMarkerHit", theMissiTruckerMarker[damarkerdenduhittenmsusst], markerhitofitititi2)
	erreichteziele = erreichteziele+1
	local theveh = getElementHealth(veh)
	neuesgeldblub = neuesgeldblub+((theveh/1000)*750)
	theminitruckermissiontext = "Bisher erreichte Ziele: "..erreichteziele
	setElementData(getLocalPlayer(), "isMiniMissionActivatedTruck", "neuensuchen")
	startminimission2(getLocalPlayer())	
end


addEventHandler("onClientVehicleExit", getRootElement(),
	function(thePlayer,seat)
		if thePlayer == getLocalPlayer() and seat == 0 and getElementData(getLocalPlayer(), "isMiniMissionActivatedTruck") == true then
			if source == tourVehicle then
				timemissi = 30
				theminitruckermissiontext = "Tour wird beendet in 30 Sekunden"
				killermission = setTimer(function()
				timemissi = timemissi-1
				theminitruckermissiontext = "Tour wird beendet in "..timemissi.." Sekunden"
				if timemissi == 0 then
					killTimer(killermission)
					theminitruckermissiontext = "Tour fehlgeschlagen!"
					setTimer(function()
							theminitruckermissiontext = ""
							removeEventHandler("onClientRender", getRootElement(), startmissi2)
							timemissi = 30
							erreichteziele = 0
							neuesgeldblub = 0
							destroyElement(thetruckermissionblip)
							setMarkerColor(theMissiTruckerMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
							setElementDimension(theMissiTruckerMarker[damarkerdenduhittenmsusst], 1234)
							removeEventHandler("onClientMarkerHit", theMissiTruckerMarker[damarkerdenduhittenmsusst], markerhitofitititi2)
							setElementData(getLocalPlayer(), "isMiniMissionActivatedTruck", false)
							showPlayerHudComponent ( "radar", false )
						end 
					,3500,1)
				end
			end
			,1000,0)
			end
		end
	end
)
addEventHandler("onClientVehicleEnter", getRootElement(),
	function(theplayer,seat)
		if theplayer == getLocalPlayer() and seat == 0 and getElementData(getLocalPlayer(), "isMiniMissionActivatedTruck") == true then
			if source == tourVehicle then
				if isTimer(killermission) then
					killTimer(killermission)
					theminitruckermissiontext = "Tour wird fortgefahren!"
					setTimer(
							function()
								theminitruckermissiontext = "Bisher erreichte Ziele: "..erreichteziele
							end
						,3000,1)
				end
			end
		end
	end
)
addEventHandler("onClientPlayerWasted", getLocalPlayer(),
	function()
		if getElementData(getLocalPlayer(), "isMiniMissionActivatedTruck") == true then
			theminitruckermissiontext = "Tour fehlgeschlagen!"
			setTimer(
				function()
					removeEventHandler("onClientRender", getRootElement(), startmissi2)
					theminitruckermissiontext = ""
					timemissi = 30
					erreichteziele = 0
					neuesgeldblub = 0
					destroyElement(thetruckermissionblip)
					setMarkerColor(theMissiTruckerMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
					removeEventHandler("onClientMarkerHit", theMissiTruckerMarker[damarkerdenduhittenmsusst], markerhitofitititi2)
					setElementData(getLocalPlayer(), "isMiniMissionActivatedTruck", false)
					showPlayerHudComponent ( "radar", false )
				end 
			,3500,1)
		end
	end
)




