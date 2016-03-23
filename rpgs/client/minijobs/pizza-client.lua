--[[
Project: VitaOnline
File: pizza-client.lua
Author(s):	Golf_R32
			Sebihunter
]]--

local pizzaTourVehicle = false
local pizzaCooldown = false

local pizzaPos = {
    [1] = {x = 1917.5682,y = 2772.3608,z = 10.4427},
    [2] = {x = 2039.6875,y = 2657.9197,z = 10.4451},
    [3] = {x = 1952.1135,y = 2658.8271,z = 10.4452},
    [4] = {x = 1677.9829,y = 2695.9146,z = 10.4450},
    [5] = {x = 1624.6128,y = 2716.1995,z = 10.4449},
    [6] = {x = 1556.5555,y = 2755.8870,z = 10.4453},
    [7] = {x = 1622.1414,y = 2834.4451,z = 10.4454},
    [8] = {x = 1460.6370,y = 2773.5288,z = 10.4453},
    [9] = {x = 1600.4808,y = 2650.1497,z = 10.4452},
    [10] = {x = 1620.0356,y = 2578.9216,z = 10.4468},
    [11] = {x = 1944.5940,y = 2602.7224,z = 10.4451},
    [12] = {x = 1843.8279,y = 2645.0649,z = 10.4454},
    [13] = {x = 1348.1985,y = 2578.0061,z = 10.4450},
    [14] = {x = 1235.9042,y = 2585.8123,z = 10.4451},
    [15] = {x = 1308.9415,y = 2524.2925,z = 10.4452},
    [16] = {x = 1459.9569,y = 2522.3887,z = 10.4450},
    [17] = {x = 1545.8271,y = 2090.5479,z = 11.0487},
    [18] = {x = 1636.4094,y = 2039.8854,z = 10.8750},
    [19] = {x = 1646.2472,y = 2130.9280,z = 10.8281},
    [20] = {x = 1690.7598,y = 2090.5361,z = 11.0206},
    [21] = {x = 1630.2762,y = 1973.6566,z = 10.4452},
    [22] = {x = 1530.5337,y = 1913.0570,z = 10.4764},
    [23] = {x = 1538.0496,y = 2024.2548,z = 10.4454},
    [24] = {x = 1456.3345,y = 2026.0061,z = 10.4448},
    [25] = {x = 1416.3021,y = 1954.8884,z = 11.0697},
    [26] = {x = 1367.6740,y = 2008.1423,z = 11.0874},
    [27] = {x = 1067.8674,y = 1737.1266,z = 10.4453},
    [28] = {x = 1606.8096,y = 1821.0052,z = 10.4492},
    [29] = {x = 2020.7587,y = 1905.2867,z = 11.9209},
    [30] = {x = 2437.4382,y = 2061.9729,z = 10.4451},
    [31] = {x = 2634.9785,y = 2016.0648,z = 10.4453},
    [32] = {x = 2619.9336,y = 2182.9165,z = 10.4887},
    [33] = {x = 2835.6907,y = 2067.6904,z = 10.4451},
    [34] = {x = 2821.8845,y = 2141.3337,z = 10.4867},
    [35] = {x = 2795.2234,y = 2225.5781,z = 10.4459},
    [36] = {x = 2633.4253,y = 2347.8914,z = 10.2970},
    [37] = {x = 2296.2061,y = 2429.9285,z = 10.4450},
    [38] = {x = 2089.4634,y = 2077.4277,z = 10.5823},
    [39] = {x = 2127.0771,y = 1483.7570,z = 10.4452},
    [40] = {x = 1962.6752,y = 922.5854,z = 10.4454},
    [41] = {x = 1858.6407,y = 970.4388,z = 10.4524},
    [42] = {x = 1857.5586,y = 1097.0818,z = 10.4431},
    [43] = {x = 1917.0452,y = 739.9970,z = 10.4454},
    [44] = {x = 1900.1559,y = 668.8907,z = 10.4452},
    [45] = {x = 2046.5809,y = 693.2980,z = 11.0781},
    [46] = {x = 2090.0791,y = 654.3246,z = 11.0521},
    [47] = {x = 2089.8364,y = 771.3110,z = 11.0569},
    [48] = {x = 2059.9717,y = 734.8697,z = 11.0347},
    [49] = {x = 2172.0166,y = 693.6989,z = 11.0844},
    [50] = {x = 2262.2915,y = 731.7529,z = 11.0593},
    [51] = {x = 2362.0881,y = 736.3741,z = 11.0856},
    [52] = {x = 2402.5039,y = 651.4893,z = 11.0465},
    [53] = {x = 2445.0898,y = 695.4839,z = 11.0536},
    [54] = {x = 2617.6277,y = 719.6056,z = 10.4456},
    [55] = {x = 2537.5906,y = 722.8360,z = 10.4465},
    [56] = {x = 2814.6399,y = 970.9040,z = 10.3747}
}


local theMissiPizzaMarker = {}

function startthePizzamarker()
	theMissiPizzaMarkerMain = createMarker(2290.26,2524.74,9.820, "cylinder", 1, 245,158,9, 255)
	for i,v in ipairs(pizzaPos) do
		theMissiPizzaMarker[#theMissiPizzaMarker+1] = createMarker(v.x,v.y,v.z,"cylinder", 2, 245,158,9, 0)
	end

	--SF Marker
	--[[theMissiPizzaMarkerMain = createMarker(-1805.12, 964.04,24, "cylinder", 1, 245,158,9, 255)
    theMissiPizzaMarker[1] = createMarker(-2275.3444824219, 787.96044921875, 48.4453125, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[2] = createMarker(-2275.3444824219, 768.00634765625, 48.4453125, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[3] = createMarker(-2275.3444824219, 747.80969238281, 48.4453125, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[4] = createMarker(-2293.6481933594, 730.37261962891, 48.442165374756, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[5] = createMarker(-2303.2458496094, 730.37261962891, 48.442165374756, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[6] = createMarker(-2904.572265625, 1178.8305664063, 12.6640625, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[7] = createMarker(-2904.5031738281, 1171.6368408203, 12.6640625, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[8] = createMarker(-2904.5031738281, 1164.9073486328, 12.6640625, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[9] = createMarker(-2323.1228027344, 660.96069335938, 40.957786560059, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[10] = createMarker(-2340.2990722656, 661.15118408203, 37.450981140137, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[11] = createMarker(-2904.5031738281, 1154.8325195313, 12.6640625, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[12] = createMarker(-2304.9052734375, 661.04260253906, 44.076316833496, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[13] = createMarker(-2304.8115234375, 675.33959960938, 44.09464263916, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[14] = createMarker(-2358.6047363281, 660.58709716797, 34.671875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[15] = createMarker(-2903.3220214844, 1118.8059082031, 26.069543838501, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[16] = createMarker(-2321.5048828125, 674.97711181641, 41.78539276123, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[17] = createMarker(-2375.662109375, 692.51635742188, 34.171875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[18] = createMarker(-2340.9992675781, 675.060546875, 38.259925842285, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[19] = createMarker(-2375.69140625, 711.72210693359, 34.171875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[20] = createMarker(-2376.0637207031, 740.83728027344, 34.171875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[21] = createMarker(-2358.5871582031, 675.93627929688, 35.171875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[22] = createMarker(-2903.3220214844, 1111.6437988281, 26.069543838501, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[23] = createMarker(-2375.9643554688, 763.41088867188, 34.171875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[24] = createMarker(-2377.4348144531, 643.95733642578, 35.171875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[25] = createMarker(-2903.3220214844, 1101.0841064453, 26.069543838501, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[26] = createMarker(-2376.107421875, 784.22320556641, 34.171875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[27] = createMarker(-2896.7131347656, 1073.9483642578, 30.916297912598, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[28] = createMarker(-2377.8803710938, 632.20599365234, 34.341083526611, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[29] = createMarker(-2898.7648925781, 1080.8983154297, 31.13224029541, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[30] = createMarker(-2377.6220703125, 614.18646240234, 31.081489562988, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[31] = createMarker(-2896.8078613281, 1067.6453857422, 31.947994232178, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[32] = createMarker(-2378.0827636719, 596.11975097656, 27.814380645752, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[33] = createMarker(-2898.8950195313, 1034.6019287109, 36.516647338867, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[34] = createMarker(-2356.26953125, 574.86212158203, 24.928440093994, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[35] = createMarker(-2896.5390625, 1028.1791992188, 36.605876922607, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[36] = createMarker(-2339.125, 574.19848632813, 27.770015716553, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[37] = createMarker(-2320.6850585938, 575.38238525391, 31.10595703125, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[38] = createMarker(-2302.2902832031, 575.15869140625, 34.426975250244, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[39] = createMarker(-2358.0930175781, 801.38452148438, 37.438209533691, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[40] = createMarker(-2340.1494140625, 802.19982910156, 40.845962524414, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[41] = createMarker(-2894.3364257813, 1017.3015136719, 35.828125, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[42] = createMarker(-2321.38671875, 801.931640625, 44.26443862915, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[43] = createMarker(-2303.4016113281, 801.31311035156, 47.511726379395, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[44] = createMarker(-2286.2839355469, 800.09033203125, 48.4453125, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[45] = createMarker(-2303.876953125, 814.58026123047, 47.426574707031, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[46] = createMarker(-2321.4396972656, 815.00115966797, 44.247741699219, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[47] = createMarker(-2886.3483886719, 1002.7391357422, 40.705375671387, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[48] = createMarker(-2882.7145996094, 996.42236328125, 40.723297119141, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[49] = createMarker(-2358.3647460938, 815.0869140625, 37.370555877686, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[50] = createMarker(-2879.2739257813, 990.86206054688, 40.703792572021, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[51] = createMarker(-2339.970703125, 814.84271240234, 40.880386352539, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[52] = createMarker(-2874.30078125, 981.99383544922, 40.726837158203, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[53] = createMarker(-2859.3205566406, 964.18188476563, 44.048927307129, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[54] = createMarker(-2856.30859375, 957.74548339844, 44.051681518555, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[55] = createMarker(-2851.7939453125, 948.09918212891, 44.052429199219, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[56] = createMarker(-2843.3618164063, 928.53033447266, 44.0546875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[57] = createMarker(-2842.6831054688, 921.42401123047, 44.0546875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[58] = createMarker(-2842.208984375, 914.71136474609, 44.0546875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[59] = createMarker(-2841.1899414063, 904.61804199219, 44.0546875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[60] = createMarker(-2376.9938964844, 833.82513427734, 36.690277099609, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[61] = createMarker(-2838.6044921875, 884.50146484375, 44.0546875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[62] = createMarker(-2838.6352539063, 877.24279785156, 44.061824798584, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[63] = createMarker(-2838.7341308594, 866.818359375, 44.0546875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[64] = createMarker(-2853.8994140625, 840.32891845703, 40.587131500244, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[65] = createMarker(-2857.3911132813, 834.13201904297, 40.236869812012, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[66] = createMarker(-2861.1477050781, 828.36505126953, 39.724983215332, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[67] = createMarker(-2866.5546875, 819.88415527344, 39.198570251465, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[68] = createMarker(-2877.9252929688, 797.41168212891, 35.735897064209, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[69] = createMarker(-2377.9326171875, 872.63891601563, 43.703491210938, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[70] = createMarker(-2878.9802246094, 790.29382324219, 35.497982025146, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[71] = createMarker(-2880.1159667969, 779.75140380859, 35.139125823975, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[72] = createMarker(-2883.0463867188, 750.70416259766, 29.323783874512, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[73] = createMarker(-2882.0979003906, 743.94610595703, 29.436708450317, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[74] = createMarker(-2881.2897949219, 736.98791503906, 29.443704605103, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[75] = createMarker(-2879.4367675781, 727.31774902344, 29.303726196289, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[76] = createMarker(-2870.9487304688, 698.23834228516, 23.488273620605, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[77] = createMarker(-2868.0495605469, 691.68170166016, 23.486896514893, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[78] = createMarker(-2863.3332519531, 682.1650390625, 23.455528259277, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[79] = createMarker(-2396.0615234375, 886.28466796875, 44.4453125, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[80] = createMarker(-2740.9892578125, 801.69909667969, 53.1813621521, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[81] = createMarker(-2740.8251953125, 797.87341308594, 53.099201202393, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[82] = createMarker(-2743.2600097656, 789.31304931641, 53.75919342041, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[83] = createMarker(-2395.8127441406, 869.34741210938, 43.108112335205, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[84] = createMarker(-2740.2253417969, 771.57092285156, 54.3828125, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[85] = createMarker(-2395.6960449219, 849.35437011719, 39.494815826416, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[86] = createMarker(-2737.962890625, 771.65942382813, 55.910850524902, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[87] = createMarker(-2396.1081542969, 829.47906494141, 35.904144287109, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[88] = createMarker(-2740.9584960938, 758.93872070313, 54.182460784912, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[89] = createMarker(-2447.6164550781, 815.05255126953, 35.1796875, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[90] = createMarker(-2741.4011230469, 755.15142822266, 52.983108520508, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[91] = createMarker(-2741.4682617188, 746.59643554688, 50.072608947754, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[92] = createMarker(-2731.5021972656, 718.31268310547, 40.2734375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[93] = createMarker(-2723.4536132813, 717.134765625, 40.2734375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[94] = createMarker(-2710.7653808594, 718.30285644531, 38.665412902832, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[95] = createMarker(-2706.9501953125, 718.03765869141, 37.368831634521, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[96] = createMarker(-2686.0170898438, 718.09466552734, 30.381935119629, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[97] = createMarker(-2678.1806640625, 718.28607177734, 27.916467666626, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[98] = createMarker(-2665.5036621094, 718.31622314453, 26.920082092285, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[99] = createMarker(-2661.5180664063, 718.41064453125, 26.921096801758, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[100] = createMarker(-2642.1650390625, 726.72149658203, 26.9609375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[101] = createMarker(-2618.6416015625, 733.17437744141, 27.957414627075, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[102] = createMarker(-2616.498046875, 749.87915039063, 32.338413238525, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[103] = createMarker(-2616.4428710938, 757.92980957031, 35.31470489502, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[104] = createMarker(-2616.373046875, 766.26177978516, 38.336421966553, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[105] = createMarker(-2621.4443359375, 770.39971923828, 39.765777587891, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[106] = createMarker(-2620.9743652344, 778.46563720703, 43.545486450195, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[107] = createMarker(-2619.2766113281, 790.75140380859, 47.234798431396, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[108] = createMarker(-2617.9409179688, 802.9150390625, 48.984375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[109] = createMarker(-2645.6691894531, 805.74829101563, 48.984375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[110] = createMarker(-2660.087890625, 806.25897216797, 48.984375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[111] = createMarker(-2670.4975585938, 805.05535888672, 48.9765625, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[112] = createMarker(-2677.3732910156, 805.28875732422, 48.984375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[113] = createMarker(-2687.7578125, 805.40942382813, 48.984375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[114] = createMarker(-2698.7502441406, 805.92047119141, 48.984375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[115] = createMarker(-2709.5715332031, 806.21734619141, 48.984375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[116] = createMarker(-2726.8664550781, 820.63543701172, 52.215423583984, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[117] = createMarker(-2737.224609375, 820.62316894531, 52.2109375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[118] = createMarker(-2741.2509765625, 836.82769775391, 56.527942657471, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[119] = createMarker(-2741.7192382813, 846.62554931641, 58.548862457275, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[120] = createMarker(-2741.2590332031, 866.18072509766, 63.976593017578, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[121] = createMarker(-2709.4826660156, 869.87371826172, 69.703125, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[122] = createMarker(-2661.9545898438, 878.68353271484, 79.773796081543, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[123] = createMarker(-2641.1701660156, 933.63299560547, 71.953125, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[124] = createMarker(-2597.2951660156, 928.14617919922, 66.820701599121, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[125] = createMarker(-2597.0402832031, 936.31085205078, 69.80354309082, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[126] = createMarker(-2597.8344726563, 944.07360839844, 72.627044677734, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[127] = createMarker(-2597.0363769531, 960.20281982422, 78.104530334473, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[128] = createMarker(-2598.3581542969, 968.78161621094, 78.284530639648, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[129] = createMarker(-2597.9890136719, 979.57684326172, 78.2734375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[130] = createMarker(-2597.6484375, 986.38696289063, 78.2734375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[131] = createMarker(-2583.9196777344, 995.87536621094, 77.2890625, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[132] = createMarker(-2573.5629882813, 995.46411132813, 77.2890625, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[133] = createMarker(-2564.2468261719, 995.47125244141, 77.2890625, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[134] = createMarker(-2553.80859375, 995.46368408203, 77.5390625, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[135] = createMarker(-2535.7678222656, 987.88226318359, 77.453742980957, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[136] = createMarker(-2535.6372070313, 975.75524902344, 76.131072998047, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[137] = createMarker(-2535.4790039063, 967.86853027344, 73.056503295898, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[138] = createMarker(-2536.2856445313, 951.22613525391, 66.811653137207, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[139] = createMarker(-2535.8422851563, 943.25787353516, 64.39958190918, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[140] = createMarker(-2535.419921875, 929.46496582031, 64.234046936035, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[141] = createMarker(-2535.783203125, 883.07763671875, 60.742332458496, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[142] = createMarker(-2535.9780273438, 855.49694824219, 53.196090698242, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[143] = createMarker(-2535.400390625, 830.13031005859, 49.975059509277, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[144] = createMarker(-2548.6745605469, 817.17388916016, 48.977886199951, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[145] = createMarker(-2565.8718261719, 817.48382568359, 48.984375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[146] = createMarker(-2590.814453125, 817.0478515625, 48.984375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[147] = createMarker(-2598.1804199219, 733.14947509766, 28.251682281494, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[148] = createMarker(-2581.5363769531, 715.7705078125, 26.961023330688, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[149] = createMarker(-2693.7670898438, 130.53755187988, 3.3359375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[150] = createMarker(-2693.0161132813, 123.56894683838, 3.3435645103455, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[151] = createMarker(-2694.4135742188, 112.51108551025, 3.5859375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[152] = createMarker(-2696.2485351563, 102.23123931885, 3.5935649871826, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[153] = createMarker(-2698.431640625, 62.944702148438, 3.3359375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[154] = createMarker(-2717.5727539063, 14.964395523071, 3.5859375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[155] = createMarker(-2719.2854003906, -11.20760345459, 3.3359375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[156] = createMarker(-2717.8247070313, -35.87523651123, 3.3432350158691, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[157] = createMarker(-2717.3505859375, -51.800045013428, 4.3359375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[158] = createMarker(-2717.4436035156, -92.589935302734, 3.5859375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[159] = createMarker(-2718.2937011719, -100.20658874512, 3.3609356880188, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[160] = createMarker(-2718.6936035156, -120.33995819092, 3.5761218070984, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[161] = createMarker(-2717.3559570313, -146.93061828613, 3.5859375, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[162] = createMarker(-2718.5405273438, -166.3263092041, 3.5929718017578, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[163] = createMarker(-2719.1318359375, -174.53555297852, 3.5559396743774, "cylinder", 2, 245,158,9, 0)
    theMissiPizzaMarker[164] = createMarker(-2718.3806152344, -191.17121887207, 3.6079359054565, "cylinder", 2, 245,158,9, 0)]]
		for i = 1,#theMissiPizzaMarker do
			if isElement(theMissiPizzaMarker[i]) then
				setElementDimension(theMissiPizzaMarker[i], 1234)
			end
		end
		addEventHandler("onClientMarkerHit", theMissiPizzaMarkerMain,startminimission1)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), startthePizzamarker)

local theminiPizzamissiontext = ""
local neuesgeldblub = 0
local erreichteziele = 0
function startmissi1 ()
	local x,y = guiGetScreenSize()

	dxDrawText(theminiPizzamissiontext, 5,0,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiPizzamissiontext, 0,5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiPizzamissiontext, 0,-5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiPizzamissiontext, -5,0,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)

	dxDrawText(theminiPizzamissiontext, 5,5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiPizzamissiontext, -5,5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiPizzamissiontext, 5,-5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
	dxDrawText(theminiPizzamissiontext, -5,-5,x,y*0.25,tocolor(0,0,0,255), 1.4, "bankgothic", "center", "center",true,true,true)

	dxDrawText(theminiPizzamissiontext, 0,0,x,y*0.25,tocolor(255,100,0,255), 1.4, "bankgothic", "center", "center",true,true,true)
end
setElementData(getLocalPlayer(), "isMiniMissionActivatedPizza", false)
exports.customblips:createCustomBlip(2290.26,2524.74, 16, 16, "images/blips/pizzajob.png")
function startminimission1(player)
	if getLocalPlayer() == player then
		if pizzaCooldown == true then return end
		if getElementData(getLocalPlayer(), "dienst") == 1 then addNotification(1, 255, 0, 0, "Du kannst keinen Nebenjob beginnen\nwenn du im Dienst bist.") return end
		veh = getPedOccupiedVehicle(player)
		if not veh then addNotification(1, 255, 0, 0, "Du kannst den Minijob nur in einem 'Sweeper' oder 'Pizzaboy' beginnen.") return end
		if veh then
			if getVehicleOccupant(veh) == getLocalPlayer() then
				if getVehicleName(veh) ==  "Sweeper" or getVehicleName(veh) ==  "Pizzaboy" then
				if getElementData(getLocalPlayer(), "isMiniMissionActivatedPizzaPizza") ~= true then
					if getElementData(getLocalPlayer(), "isMiniMissionActivatedPizza") == false then
							if killermission and isTimer(killermission) then killTimer(killermission) end
							if isTimer(theverdienstgeldtimer) then killTimer(theverdienstgeldtimer) end
							addEventHandler("onClientRender", getRootElement(), startmissi1)
							theminiPizzamissiontext = "Tour wurde gestartet!"
							showTutorialMessage("pizza_1", "Hilf Luigi die heiße Pizza schnell zum Kunden zu bringen. Fahre dazu einfach vor das Haus um die Pizza zu abzuliefern.")
							pizzaTourVehicle = veh
							neuesgeldblub = 0
							setElementData(getLocalPlayer(), "isMiniMissionActivatedPizza", true)
							showPlayerHudComponent ( "radar", true )
							thebishergestartedtimer = setTimer(
														function()
															theminiPizzamissiontext = "Bisher erreichte Kunden: "..erreichteziele
														end
														,3000,1)
							damarkerdenduhittenmsusst = math.random(1,#theMissiPizzaMarker)
							setMarkerColor(theMissiPizzaMarker[damarkerdenduhittenmsusst], 95, 255, 0,100)
							setElementDimension(theMissiPizzaMarker[damarkerdenduhittenmsusst], 0)
							thePizzamissionblip = createBlip(getElementPosition(theMissiPizzaMarker[damarkerdenduhittenmsusst]))
							addEventHandler("onClientMarkerHit", theMissiPizzaMarker[damarkerdenduhittenmsusst], markerhitofitititi1)
						elseif getElementData(getLocalPlayer(), "isMiniMissionActivatedPizza") == "neuensuchen" then
							if isTimer(theverdienstgeldtimer) then killTimer(theverdienstgeldtimer) end
							setElementData(getLocalPlayer(), "isMiniMissionActivatedPizza", true)
							damarkerdenduhittenmsusst = math.random(1,#theMissiPizzaMarker)
							setMarkerColor(theMissiPizzaMarker[damarkerdenduhittenmsusst], 95, 255, 0,100)
							setElementDimension(theMissiPizzaMarker[damarkerdenduhittenmsusst], 0)
							thePizzamissionblip = createBlip(getElementPosition(theMissiPizzaMarker[damarkerdenduhittenmsusst]))
							addEventHandler("onClientMarkerHit", theMissiPizzaMarker[damarkerdenduhittenmsusst], markerhitofitititi1)
						else
							if isTimer(thebishergestartedtimer) then killTimer(thebishergestartedtimer) end
								setElementData(getLocalPlayer(), "isMiniMissionActivatedPizza", false)
								theminiPizzamissiontext = "Tour wurde abgebrochen!"
								if killermission and isTimer(killermission) then killTimer(killermission) end
								destroyElement(thePizzamissionblip)
								setMarkerColor(theMissiPizzaMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
								setElementDimension(theMissiPizzaMarker[damarkerdenduhittenmsusst], 1234)
								removeEventHandler("onClientMarkerHit", theMissiPizzaMarker[damarkerdenduhittenmsusst], markerhitofitititi1)
								pizzaCooldown = true
								setTimer(function() pizzaCooldown = false end, 15000, 1)
								theverdienstgeldtimer = setTimer(
								function()
									neuesgeldblub = math.floor(neuesgeldblub)
									theminiPizzamissiontext = "Du hast "..neuesgeldblub.. " Vero verdient!"
									triggerServerEvent("giveTheMiniMissionPrize", getLocalPlayer(),getLocalPlayer(), neuesgeldblub)
									erreichteziele = 0
									showPlayerHudComponent ( "radar", false )
									theverdienstgeldtimer = setTimer(function() theminiPizzamissiontext = ""  neuesgeldblub = 0 removeEventHandler("onClientRender", getRootElement(), startmissi1) end , 2000,1)
								end
								,3000,1)
			
					end
					end
								else
				theminiPizzamissiontext = "Du brauchst einen 'Sweeper' oder 'Pizzaboy' um diese Tour zu starten!"
				if isTimer(theshitcarisfalschtimer) then
					killTimer(theshitcarisfalschtimer)
				end
				theshitcarisfalschtimer = setTimer(
				function()
					theminiPizzamissiontext = ""
					end
				,3000,1)
				end
			end
		end
	end
end



function leftthemarkerofthemissi1(source)
	if source == getLocalPlayer() then
		if isTimer(theidletimerstart) then
			killTimer(theidletimerstart)
			theminiPizzamissiontext = "Liefern unterbrochen! Bitte wiederholen!"
			removeEventHandler("onClientMarkerLeave", theMissiPizzaMarker[damarkerdenduhittenmsusst],leftthemarkerofthemissi1)
		end
	end
end
function markerhitofitititi1(player)
	if player == getLocalPlayer() then
		veh = getPedOccupiedVehicle(player)
		if veh then
			if getVehicleName(veh) ==  "Sweeper" or getVehicleName(veh) ==  "Pizzaboy" then
				theminiPizzamissiontext = "Wird abgeliefert!"
				theidletimerstart = setTimer(acceptthedurin1, 3000,1, player)
				addEventHandler("onClientMarkerLeave", theMissiPizzaMarker[damarkerdenduhittenmsusst], leftthemarkerofthemissi1)
			end
		end
	end
end
function acceptthedurin1(source)
	destroyElement(thePizzamissionblip)
	setMarkerColor(theMissiPizzaMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
	removeEventHandler("onClientMarkerHit", theMissiPizzaMarker[damarkerdenduhittenmsusst], markerhitofitititi1)
	erreichteziele = erreichteziele+1
	local theveh = getElementHealth(veh)
	neuesgeldblub = neuesgeldblub+((theveh/1000)*160)
	theminiPizzamissiontext = "Bisher erreichte Kunden: "..erreichteziele
	showTutorialMessage("pizza_2", "Der erste Kunde ist satt, doch viele warten noch auf ihre Pizza. Fahre entweder zurück zum Startpunkt um den Job zu beenden oder beliefere gleich den nächsten.")
	setElementData(getLocalPlayer(), "isMiniMissionActivatedPizza", "neuensuchen")
	startminimission1(getLocalPlayer())	
end


addEventHandler("onClientVehicleExit", getRootElement(),
	function(thePlayer,seat)
		if thePlayer == getLocalPlayer() and seat == 0 and getElementData(getLocalPlayer(), "isMiniMissionActivatedPizza") == true then
			if source == pizzaTourVehicle then
				timemissi = 30
				theminiPizzamissiontext = "Tour wird beendet in 30 Sekunden"
				killermission = setTimer(function()
				timemissi = timemissi-1
				theminiPizzamissiontext = "Tour wird beendet in "..timemissi.." Sekunden"
				if timemissi == 0 then
					killTimer(killermission)
					theminiPizzamissiontext = "Tour fehlgeschlagen!"
					setTimer(function()
							removeEventHandler("onClientRender", getRootElement(), startmissi1)
							theminiPizzamissiontext = ""
							timemissi = 30
							erreichteziele = 0
							neuesgeldblub = 0
							destroyElement(thePizzamissionblip)
							setMarkerColor(theMissiPizzaMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
							setElementDimension(theMissiPizzaMarker[damarkerdenduhittenmsusst], 1234)
							removeEventHandler("onClientMarkerHit", theMissiPizzaMarker[damarkerdenduhittenmsusst], markerhitofitititi1)
							setElementData(getLocalPlayer(), "isMiniMissionActivatedPizza", false)
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
		if theplayer == getLocalPlayer() and seat == 0 and getElementData(getLocalPlayer(), "isMiniMissionActivatedPizza") == true then
			if source == pizzaTourVehicle then
				if isTimer(killermission) then
					killTimer(killermission)
					theminiPizzamissiontext = "Tour wird fortgefahren!"
					setTimer(
							function()
								theminiPizzamissiontext = "Bisher erreichte Kunden: "..erreichteziele
							end
						,3000,1)
				end
			end
		end
	end
)
addEventHandler("onClientPlayerWasted", getLocalPlayer(),
	function()
		if getElementData(getLocalPlayer(), "isMiniMissionActivatedPizza") == true then
			theminiPizzamissiontext = "Tour fehlgeschlagen!"
			setTimer(
				function()
					removeEventHandler("onClientRender", getRootElement(), startmissi1)
					theminiPizzamissiontext = ""
					timemissi = 30
					erreichteziele = 0
					neuesgeldblub = 0
					destroyElement(thePizzamissionblip)
					setMarkerColor(theMissiPizzaMarker[damarkerdenduhittenmsusst], 95, 255, 0,0)
					removeEventHandler("onClientMarkerHit", theMissiPizzaMarker[damarkerdenduhittenmsusst], markerhitofitititi1)
					setElementData(getLocalPlayer(), "isMiniMissionActivatedPizza", false)
					showPlayerHudComponent ( "radar", false )
				end 
			,3500,1)
		end
	end
)