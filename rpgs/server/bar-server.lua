--[[
Project: VitaOnline
File: bar-server.lua
Author(s):	Sebihunter
]]--

setInteriorSoundsEnabled ( false )

-- Adminhaus
ped = createInvinciblePed(85, 2399.8000488281, 1374.8000488281, -0.15000000596046) 
setPedRotation(ped,0)
setElementData(ped, "isBarPed", true)
setElementData(ped, "PedName", "Miss Feucht")
setElementFrozen(ped,true)
setElementData(ped, "cinfo", {"Getränk bestellen"})


--Schlumps Haus
ped = createInvinciblePed(197 , -453.20,1149.39,5.091)
setPedRotation(ped,0)
setElementData(ped, "isBarPed", true)
setElementData(ped, "PedName", "Schlumpfs dicke Berta")
setElementFrozen(ped,true)
setElementData(ped, "cinfo", {"Getränk bestellen"})


--Casino
ped = createInvinciblePed(169 , 1952.591,1018.466,992.468)
setPedRotation(ped,-90)
setElementInterior(ped, 10)
setElementData(ped, "isBarPed", true)
setElementData(ped, "PedName", "Barista Yamata Fu-Long")
setElementFrozen(ped,true)
setElementData(ped, "cinfo", {"Getränk bestellen"})

ped = createInvinciblePed(169 , 1947.941,1018.466,992.468)
setPedRotation(ped,90)
setElementInterior(ped, 10)
setElementData(ped, "isBarPed", true)
setElementData(ped, "PedName", "Barista Saskia Jin")
setElementFrozen(ped,true)
setElementData(ped, "cinfo", {"Getränk bestellen"})

-- Baumhaus
ped = createInvinciblePed(130 , -967.855,-977.039,151.0559) 
setPedRotation(ped,4.9199829101563)
setElementData(ped, "isBarPed", true)
setElementData(ped, "PedName", "Haushälterin Berta")
setElementFrozen(ped,true)
setElementData(ped, "cinfo", {"Getränk bestellen"})


--Freibad
ped = createInvinciblePed(45 , 1906.1958,-1358.2620,13.49796) 
setPedRotation(ped,180)
setElementData(ped, "isBarPed", true)
setElementData(ped, "PedName", "Bademeister Horst Hansen")
setElementFrozen(ped,true)
setElementData(ped, "cinfo", {"Getränk bestellen"})

--Rocker Base
ped = createInvinciblePed(199 , -220.3203125, 1212.8505859375, 19.735198974609 ) 
setPedRotation(ped,355.701538085948)
setElementData(ped, "isBarPed", true)
setElementData(ped, "PedName", "Fesche Babsi")
setElementFrozen(ped,true)
setElementData(ped, "cinfo", {"Getränk bestellen"})

--Wilder Ösi
ped = createInvinciblePed(161 , 886.24176025391, 1915.5100097656, 12 ) 
setPedRotation(ped,180)
setElementData(ped, "isBarPed", true)
setElementData(ped, "PedName", "Barkeeper Alois Steggenberger")
setElementFrozen(ped,true)
setElementData(ped, "cinfo", {"Getränk bestellen"})

--PBC Dachterasse	
ped = createInvinciblePed(171 , 1904.712890625, 1916.2265625, 121.55862426758 ) 
setPedRotation(ped,275.5)
setElementData(ped, "isBarPed", true)
setElementData(ped, "PedName", "Barkeeper Daniel Müller")
setElementFrozen(ped,true)
setElementData(ped, "cinfo", {"Getränk bestellen"})

--PBC	
ped = createInvinciblePed(171 , -2656.29296875, 1410.2138671875, 905.6734375 ) 
setElementInterior(ped, 3)
setPedRotation(ped, 274)
setElementData(ped, "isBarPed", true)
setElementData(ped, "PedName", "Barkeeper Frank Herzog")
setElementFrozen(ped,true)
setElementData(ped, "cinfo", {"Getränk bestellen"})

--Die Werkstatt
ped = createInvinciblePed(50 , -2042.5107421875, 163.583984375, 28.8359375 ) 
setPedRotation(ped,  28.8359375)
setElementData(ped, "isBarPed", true)
setElementData(ped, "PedName", "Barkeeper Jarno van Besen")
setElementFrozen(ped,true)
setElementData(ped, "cinfo", {"Getränk bestellen"})

-----
createObject(3526, 1946.135, 1924.045, 123.568, 0.0, 0.0, 90.000);
createObject(3526, 1945.942, 1908.346, 123.568, 0.0, 0.0, -90.000);
createObject(3526, 1941.637, 1924.031, 123.568, 0.0, 0.0, 90.000);
createObject(3526, 1941.519, 1908.311, 123.579, 0.0, 0.0, -90.000);
createObject(3526, 1936.482, 1908.348, 123.568, 0.0, 0.0, -90.000);
createObject(3526, 1936.459, 1924.000, 123.572, 0.0, 0.0, -270.000);
createObject(3526, 1931.081, 1908.356, 123.568, 0.0, 0.0, -90.000);
createObject(3526, 1931.126, 1924.035, 123.553, 0.0, 0.0, -270.000);
createObject(3526, 1925.919, 1908.354, 123.568, 0.0, 0.0, -90.000);
createObject(3526, 1925.819, 1924.020, 123.572, 0.0, 0.0, -270.000);
createObject(3526, 1919.423, 1908.360, 123.568, 0.0, 0.0, 270.000);
createObject(3526, 1919.533, 1924.052, 123.571, 0.0, 0.0, 90.000);
createObject(3526, 1912.045, 1908.370, 123.568, 0.0, 0.0, -90.000);
createObject(3526, 1912.589, 1924.036, 123.579, 0.0, 0.0, -270.000);
createObject(3526, 1905.868, 1924.040, 123.568, 0.0, 0.0, 90.000);
createObject(3526, 1905.239, 1908.358, 123.585, 0.0, 0.0, -90.000);
createObject(3526, 1900.374, 1908.369, 123.568, 0.0, 0.0, -90.000);
createObject(3526, 1900.343, 1924.031, 123.579, 0.0, 0.0, -270.000);
createObject(3526, 1894.648, 1908.371, 123.568, 0.0, 0.0, -90.000);
createObject(3526, 1894.703, 1924.007, 123.569, 0.0, 0.0, -270.000);
createObject(3526, 1888.972, 1908.338, 123.568, 0.0, 0.0, -90.000);
createObject(3526, 1888.965, 1923.996, 123.570, 0.0, 0.0, -270.000);
createObject(17574, 1904.262, 1916.110, 120.604, 0.0, 0.0, 0.0);
createObject(17574, 1939.754, 1916.027, 120.579, 0.0, -0.859, 0.0);
createObject(3522, 1924.422, 1909.816, 121.044, 0.0, 0.0, 90.000);
createObject(1215, 1922.103, 1910.553, 121.530, 0.0, 0.0, 0.0);
createObject(1215, 1924.393, 1910.709, 121.580, 0.0, 0.0, 0.0);
createObject(1215, 1927.364, 1909.650, 121.582, 0.0, 0.0, 0.0);
createObject(629, 1924.481, 1909.766, 120.986, 0.0, 0.0, 0.0);
createObject(629, 1927.979, 1909.531, 121.089, 0.0, 0.0, 0.0);
createObject(14537, 1901.610, 1916.460, 123.000, 0.0, 0.0, 0.0);
createObject(1646, 1919.107, 1911.287, 121.356, 0.0, 0.0, -135.000);
createObject(1646, 1919.808, 1914.230, 121.359, 0.0, 0.0, -135.000);
createObject(1646, 1914.803, 1911.379, 121.354, 0.0, 0.0, 135.000);
createObject(1646, 1914.075, 1914.640, 121.355, 0.0, 0.0, 135.000);
createObject(621, 1922.112, 1915.469, 104.405, 0.0, 0.0, 0.0);
createObject(1215, 1919.135, 1909.644, 121.580, 0.0, 0.0, 0.0);
createObject(1215, 1916.938, 1909.626, 121.580, 0.0, 0.0, 0.0);
createObject(1215, 1914.562, 1909.604, 121.580, 0.0, 0.0, 0.0);
createObject(1215, 1906.801, 1915.706, 125.515, 0.0, 0.0, 0.0);
createObject(1215, 1906.756, 1917.016, 125.515, 0.0, 0.0, 0.0);
createObject(1215, 1900.950, 1911.555, 125.515, 0.0, 0.0, 0.0);
createObject(1215, 1902.311, 1911.475, 125.515, 0.0, 0.0, 0.0);
createObject(1215, 1896.727, 1915.719, 125.515, 0.0, 0.0, 0.0);
createObject(1215, 1896.659, 1917.058, 125.515, 0.0, 0.0, 0.0);
createObject(1215, 1902.259, 1921.462, 125.515, 0.0, 0.0, 0.0);
createObject(1215, 1900.962, 1921.525, 125.515, 0.0, 0.0, 0.0);
createObject(1231, 1929.631, 1909.795, 123.630, 0.0, 0.0, 0.0);
createObject(1231, 1935.035, 1909.601, 123.616, 0.0, 0.0, 0.0);
createObject(1231, 1940.630, 1909.741, 123.648, 0.0, 0.0, 0.0);
createObject(1726, 1933.153, 1910.019, 121.025, 0.0, 0.0, -180.000);
createObject(1726, 1938.761, 1909.938, 121.039, 0.0, 0.0, -180.000);
createObject(1727, 1935.583, 1910.545, 121.033, 0.0, 0.0, -180.000);
createObject(1727, 1941.097, 1910.731, 121.035, 0.0, 0.0, -180.000);
createObject(1727, 1930.175, 1910.806, 121.022, 0.0, 0.0, -180.000);
createObject(1231, 1918.002, 1909.667, 123.646, 0.0, 0.0, 0.0);
createObject(1231, 1915.533, 1909.551, 123.676, 0.0, 0.0, 0.0);
createObject(1646, 1920.919, 1916.708, 121.395, 0.0, 0.0, 225.000);
createObject(1646, 1913.508, 1917.698, 121.355, 0.0, 0.0, 135.000);
createObject(1231, 1926.487, 1922.911, 123.669, 0.0, 0.0, 0.0);
createObject(1231, 1935.385, 1923.059, 123.696, 0.0, 0.0, -11.250);
createObject(1231, 1939.461, 1922.984, 123.672, 0.0, 0.0, 0.0);
createObject(1231, 1943.822, 1923.026, 123.664, 0.0, 0.0, 0.0);
createObject(650, 1942.119, 1922.153, 121.222, 0.0, 0.0, 0.0);
createObject(651, 1937.362, 1922.460, 121.162, 0.0, 0.0, -112.500);
createObject(629, 1934.676, 1922.229, 120.994, 0.0, 0.0, 0.0);
createObject(634, 1929.886, 1922.409, 120.881, 0.0, 0.0, 0.0);
createObject(641, 1920.111, 1922.427, 118.870, 0.0, 0.0, 0.0);
createObject(718, 1888.356, 1922.479, 121.238, 0.0, 0.0, 0.0);
createObject(718, 1888.221, 1910.286, 121.219, 0.0, 0.0, 0.0);
createObject(1231, 1888.382, 1919.953, 123.924, 0.0, 0.0, 90.000);
createObject(1231, 1888.399, 1912.471, 123.890, 0.0, 0.0, 90.000);
createObject(1215, 1888.465, 1918.910, 121.854, 0.0, 0.0, 0.0);
createObject(1215, 1888.464, 1913.440, 121.856, 0.0, 0.0, 0.0);
createObject(1215, 1888.475, 1916.225, 121.853, 0.0, 0.0, 0.0);
createObject(1646, 1889.020, 1914.959, 121.623, 0.0, 0.0, 90.000);
createObject(1646, 1888.978, 1917.648, 121.623, 0.0, 0.0, 90.000);
createObject(1646, 1890.764, 1911.427, 121.582, 0.0, 0.0, 146.250);
createObject(1646, 1890.560, 1920.578, 121.613, 0.0, 0.0, 45.000);
createObject(9831, 1978.890, 1909.391, 124.496, 6.875, 0.0, -90.859);
createObject(9831, 1978.984, 1916.827, 124.529, 6.875, 0.0, -90.859);
createObject(9831, 1979.035, 1921.400, 124.479, 6.875, 0.0, -90.859);
createObject(12839, 1942.988, 1915.974, 123.945, 0.0, 0.0, 90.000);
createObject(1215, 1938.592, 1916.614, 121.604, 0.0, 0.0, 0.0);
createObject(1215, 1938.532, 1915.329, 121.604, 0.0, 0.0, 0.0);
createObject(1215, 1954.027, 1925.512, 127.150, 0.0, 0.0, 0.0);
createObject(1215, 1946.882, 1925.372, 127.150, 0.0, 0.0, 0.0);
createObject(1215, 1946.903, 1907.160, 127.150, 0.0, 0.0, 0.0);
createObject(1215, 1953.859, 1906.932, 127.150, 0.0, 0.0, 0.0);
createObject(3437, 1917.191, 1909.003, 122.187, 0.0, 89.381, 0.0);
createObject(3437, 1905.492, 1909.074, 122.133, 0.0, 89.381, 0.0);
createObject(3437, 1893.724, 1909.137, 122.088, 0.0, 89.381, 0.0);
createObject(3437, 1892.625, 1923.678, 122.150, 0.0, 90.241, 0.0);
createObject(3437, 1904.308, 1923.656, 122.073, 0.0, 90.241, 0.0);
createObject(3437, 1915.995, 1923.645, 122.035, 0.0, 90.241, 0.0);
createObject(3437, 1927.643, 1923.678, 122.025, 0.0, 90.241, 0.0);
createObject(3437, 1939.385, 1923.682, 121.958, 0.0, 90.241, 0.0);
createObject(3437, 1928.777, 1908.955, 122.197, 0.0, 90.241, 0.0);
createObject(3437, 1940.517, 1909.021, 122.168, 0.0, 90.241, 0.0);
createObject(3437, 1887.134, 1916.270, 122.420, 0.0, 89.381, -90.000);
createObject(3437, 1946.430, 1916.143, 122.130, 0.0, 90.241, 90.000);
createObject(1231, 1915.897, 1923.053, 123.764, 0.0, 0.0, -11.250);
createObject(1231, 1921.323, 1922.901, 123.781, 0.0, 0.0, -11.250);
createObject(1231, 1910.167, 1923.006, 123.750, 0.0, 0.0, -11.250);
createObject(984, 1954.330, 1919.587, 130.533, 0.0, 0.0, 0.0);
createObject(983, 1954.305, 1909.963, 130.586, 0.0, 0.0, 0.0);
createObject(3472, 1910.765, 1910.062, 120.260, 0.0, 0.0, 78.750);
createObject(3472, 1930.624, 1909.739, 120.378, 0.0, 0.0, 78.750);
createObject(3472, 1912.197, 1922.546, 120.291, 0.0, 0.0, 78.750);
createObject(3472, 1931.118, 1922.687, 120.333, 0.0, 0.0, 78.750);
createObject(3472, 1893.516, 1922.772, 120.445, 0.0, 0.0, 101.250);
createObject(3472, 1893.515, 1910.399, 120.479, 0.0, 0.0, 146.250);
createObject(3472, 1950.463, 1925.479, 125.855, 0.0, 0.0, 213.750);
createObject(3472, 1950.458, 1906.948, 125.805, 0.0, 0.0, 270.000);