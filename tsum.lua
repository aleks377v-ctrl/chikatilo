local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

-- ============================================
-- БАЗА ДАННЫХ ПРЕДМЕТОВ (ПОЛНАЯ)
-- ============================================
local ITEM_DATABASE = {}

local function AddItems(items, typeName)
	for _, item in ipairs(items) do
		local id = item.templateId:match("id=(%d+)")
		if id then
			ITEM_DATABASE[id] = {
				name = item.name,
				rarity = item.rarity,
				fairPrice = item.fairPrice,
				spawnChance = item.spawnChance,
				economyProfile = item.economyProfile,
				type = typeName,
				fullId = "rbxassetid://" .. id
			}
		end
	end
end

-- ============================================
-- ВСЕ ФУТБОЛКИ (ПОЛНЫЙ СПИСОК)
-- ============================================
local ShirtData = {
	-- Common
	{name = "Белая футболка", rarity = "Common", fairPrice = 120, spawnChance = 55, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=1352050964"},
	{name = "Черная футболка", rarity = "Common", fairPrice = 120, spawnChance = 55, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=6174845141"},
	{name = "Серая футболка", rarity = "Common", fairPrice = 180, spawnChance = 45, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=114724376"},
	{name = "Nike Черная", rarity = "Common", fairPrice = 900, spawnChance = 40, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=12820715391"},
	{name = "Gutta Opiu White", rarity = "Common", fairPrice = 500, spawnChance = 38, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=93381359644374"},
	{name = "Amiri Футболка Черная2", rarity = "Common", fairPrice = 3200, spawnChance = 20, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=90954923523898"},
	-- Uncommon
	{name = "Gutta Longsleeve Pink Blue", rarity = "Uncommon", fairPrice = 1200, spawnChance = 35, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=120813667025195"},
	{name = "Gutta Opiu Tee", rarity = "Uncommon", fairPrice = 1200, spawnChance = 35, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=107914136867077"},
	{name = "Gutta Classic White Longsleeve", rarity = "Uncommon", fairPrice = 1200, spawnChance = 35, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=111087241265731"},
	{name = "Stussy Stock Logo Tee", rarity = "Uncommon", fairPrice = 1600, spawnChance = 32, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=1352050964"},
	{name = "Carhartt Hoodie", rarity = "Uncommon", fairPrice = 2000, spawnChance = 30, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=6174845141"},
	{name = "Palace Tri-Ferg Tee", rarity = "Uncommon", fairPrice = 2200, spawnChance = 30, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=1352050964"},
	{name = "Nike x Stussy", rarity = "Uncommon", fairPrice = 1400, spawnChance = 28, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=17303641828"},
	{name = "Граффити футболка", rarity = "Uncommon", fairPrice = 450, spawnChance = 25, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=6877956794"},
	{name = "Nike Hoodie", rarity = "Uncommon", fairPrice = 1800, spawnChance = 22, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=4746292567"},
	{name = "Gutta Opiu Black", rarity = "Uncommon", fairPrice = 1000, spawnChance = 10, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=111466339599131"},
	{name = "Gutta Coffee Longsleeve", rarity = "Uncommon", fairPrice = 1800, spawnChance = 6, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=120726161817919"},
	{name = "Amiri Худи Зеленое", rarity = "Uncommon", fairPrice = 11000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=130852157455760"},
	{name = "Amiri Футболка Paint", rarity = "Uncommon", fairPrice = 7500, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=128205133147892"},
	-- Rare
	{name = "Rick Owens Zip", rarity = "Rare", fairPrice = 18500, spawnChance = 25, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=123736496180880"},
	{name = "Carhartt Detroit Jacket", rarity = "Rare", fairPrice = 3500, spawnChance = 20, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=1352050964"},
	{name = "BAPE Camo", rarity = "Rare", fairPrice = 4500, spawnChance = 20, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=3131452069"},
	{name = "Gutta Hoodie Black", rarity = "Rare", fairPrice = 3200, spawnChance = 20, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=107935919483658"},
	{name = "Gutta Hoodie Grey", rarity = "Rare", fairPrice = 3200, spawnChance = 18, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=6877956794"},
	{name = "Nike Tech", rarity = "Rare", fairPrice = 2800, spawnChance = 16, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=11554103573"},
	{name = "Stussy 8 Ball Hoodie", rarity = "Rare", fairPrice = 3800, spawnChance = 16, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=6174845141"},
	{name = "Palace Hoodie", rarity = "Rare", fairPrice = 4800, spawnChance = 16, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=6174845141"},
	{name = "Supreme Box Logo", rarity = "Rare", fairPrice = 12000, spawnChance = 15, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=1499082672"},
	{name = "Cav Empt Свитшот Черный", rarity = "Rare", fairPrice = 4500, spawnChance = 14, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=140286930400511"},
	{name = "BAPE Shark", rarity = "Rare", fairPrice = 6200, spawnChance = 14, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=82349397721807"},
	{name = "Burberry Classic", rarity = "Rare", fairPrice = 11000, spawnChance = 14, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=14182270409"},
	{name = "Stone Island Default", rarity = "Rare", fairPrice = 14500, spawnChance = 14, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=15177463491"},
	{name = "Amiri Футболка Черная", rarity = "Rare", fairPrice = 5500, spawnChance = 12, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=18694595610"},
	{name = "Carhartt Shirt Jacket", rarity = "Rare", fairPrice = 4200, spawnChance = 12, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=114724376"},
	{name = "Palm Angels", rarity = "Rare", fairPrice = 14500, spawnChance = 12, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=112272253222050"},
	{name = "Acne Studios Face Tee", rarity = "Rare", fairPrice = 9500, spawnChance = 12, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=1352050964"},
	{name = "Гоша Рубчинский x Fila", rarity = "Rare", fairPrice = 12000, spawnChance = 10, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=438195462"},
	{name = "CP.Company Свитшот", rarity = "Rare", fairPrice = 16500, spawnChance = 10, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=14077919266"},
	{name = "NeNet Футболка Черная", rarity = "Rare", fairPrice = 4500, spawnChance = 9, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=127325204834130"},
	{name = "CP.Company Rose", rarity = "Rare", fairPrice = 15500, spawnChance = 9, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=98248135872247"},
	{name = "Drip футболка", rarity = "Rare", fairPrice = 1200, spawnChance = 8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=6384915757"},
	{name = "Black Milo Shark Tee", rarity = "Rare", fairPrice = 7800, spawnChance = 8, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=4695588508"},
	{name = "Gutta Zip-Hoodie", rarity = "Rare", fairPrice = 3800, spawnChance = 8, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=83357763098810"},
	{name = "Comme des Garcons Футболка", rarity = "Rare", fairPrice = 11000, spawnChance = 8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=14582695250"},
	{name = "CP.Company Blue Hoodie", rarity = "Rare", fairPrice = 17500, spawnChance = 8, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=16974592344"},
	{name = "NeNet Футболка Черный v2", rarity = "Rare", fairPrice = 4800, spawnChance = 6, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=15015469127"},
	{name = "NeNet Футболка Белая", rarity = "Rare", fairPrice = 5200, spawnChance = 5, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=12089573201"},
	{name = "Stone Island Свитшот", rarity = "Rare", fairPrice = 32000, spawnChance = 3.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=1315352899"},
	{name = "Racer WorldWide Свитшот", rarity = "Rare", fairPrice = 14500, spawnChance = 3.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=11831115132"},
	{name = "Racer WorldWide Свитшот Красный", rarity = "Rare", fairPrice = 14500, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=123860661501395"},
	{name = "BAPE Футболка", rarity = "Rare", fairPrice = 5500, spawnChance = 2.5, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=117963451144600"},
	{name = "Gutta Black-White Longsleeve", rarity = "Rare", fairPrice = 2800, spawnChance = 2.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=140094741889782"},
	{name = "Racer WorldWide Aphex Футболка", rarity = "Rare", fairPrice = 9500, spawnChance = 1.8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=16579558738"},
	-- Epic (все)
	{name = "Vetements Лонгслив", rarity = "Epic", fairPrice = 13000, spawnChance = 18, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=81816103259800"},
	{name = "Rick Owens Футболка", rarity = "Epic", fairPrice = 28000, spawnChance = 15, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=107265387437198"},
	{name = "Prada Linea Rossa", rarity = "Epic", fairPrice = 38000, spawnChance = 15, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=6174845141"},
	{name = "CP.Company Orange Майка", rarity = "Epic", fairPrice = 11500, spawnChance = 12, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=80771437228755"},
	{name = "Gucci Logo Tee", rarity = "Epic", fairPrice = 32000, spawnChance = 12, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=2464334395"},
	{name = "Rick Owens DRKSHDW", rarity = "Epic", fairPrice = 35000, spawnChance = 12, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=15422438885"},
	{name = "CP.Company Blanc Майка", rarity = "Epic", fairPrice = 11500, spawnChance = 11, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=129889312647824"},
	{name = "Gucci Sweatshirt Tiger", rarity = "Epic", fairPrice = 28000, spawnChance = 10, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=2672925830"},
	{name = "LV Shirts", rarity = "Epic", fairPrice = 32000, spawnChance = 10, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=117258695702692"},
	{name = "Balenciaga Logo Print Tee", rarity = "Epic", fairPrice = 24000, spawnChance = 10, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=135490816603089"},
	{name = "Rick Owens Джинсовка", rarity = "Epic", fairPrice = 50000, spawnChance = 10, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=131068890254681"},
	{name = "Chrome Hearts Tee Black", rarity = "Epic", fairPrice = 36000, spawnChance = 10, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=126339476342932"},
	{name = "Cav Empt Зип-Худи", rarity = "Epic", fairPrice = 6200, spawnChance = 8, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=2944205626"},
	{name = "Gallery Dept Футболка Черная", rarity = "Epic", fairPrice = 4800, spawnChance = 8, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=11725889250"},
	{name = "Gallery Dept Футболка Белая", rarity = "Epic", fairPrice = 5200, spawnChance = 8, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=13835053047"},
	{name = "Supreme Свитшот", rarity = "Epic", fairPrice = 18500, spawnChance = 8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=3463183825"},
	{name = "Gucci Lamb", rarity = "Epic", fairPrice = 34000, spawnChance = 8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=5023083293"},
	{name = "Balenciaga Logo", rarity = "Epic", fairPrice = 28000, spawnChance = 8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=11386091933"},
	{name = "Rick Owens Джинсовка Черная", rarity = "Epic", fairPrice = 55000, spawnChance = 8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=102566337000579"},
	{name = "Chrome Hearts Blue", rarity = "Epic", fairPrice = 32000, spawnChance = 8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=15705156179"},
	{name = "Moncler White Polo", rarity = "Epic", fairPrice = 26000, spawnChance = 8, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=124671601426429"},
	{name = "Moncler Black Polo", rarity = "Epic", fairPrice = 26000, spawnChance = 8, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=10793538497"},
	{name = "Vetements Худи", rarity = "Epic", fairPrice = 20000, spawnChance = 8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=18983373477"},
	{name = "Vetements Лонгслив Черный", rarity = "Epic", fairPrice = 26000, spawnChance = 8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=115871686256175"},
	{name = "Vetements Худи Черное", rarity = "Epic", fairPrice = 26000, spawnChance = 7, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=103890230535014"},
	{name = "Maison Margiela Лонгслив Белая", rarity = "Epic", fairPrice = 57000, spawnChance = 7, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=88711396053183"},
	{name = "Maison Margiela Лонгслив Черный", rarity = "Epic", fairPrice = 57000, spawnChance = 7, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=113716739106419"},
	{name = "Cav Empt Chemical Engineering", rarity = "Epic", fairPrice = 8500, spawnChance = 6, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=3652598256"},
	{name = "Гоша Рубчинский Flag", rarity = "Epic", fairPrice = 18500, spawnChance = 6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=5809785803"},
	{name = "Гоша Рубчинский Белая Футболка", rarity = "Epic", fairPrice = 9500, spawnChance = 6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=1435177618"},
	{name = "Off-White Черная", rarity = "Epic", fairPrice = 18500, spawnChance = 6, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=4464224755"},
	{name = "Palm Angels Bear", rarity = "Epic", fairPrice = 16000, spawnChance = 6, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=7724732717"},
	{name = "Gucci LOVE", rarity = "Epic", fairPrice = 36000, spawnChance = 6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=956388271"},
	{name = "Rick Owens Джинсовка Синюю", rarity = "Epic", fairPrice = 60000, spawnChance = 6, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=121915748396165"},
	{name = "Moncler Yellow Mini Puffer", rarity = "Epic", fairPrice = 28000, spawnChance = 6, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=8171196068"},
	{name = "Moncler Big Logo", rarity = "Epic", fairPrice = 32000, spawnChance = 6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=11998504129"},
	{name = "1017 ALYX 9SM Футболка Белая", rarity = "Epic", fairPrice = 9000, spawnChance = 6, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=13607073545"},
	{name = "Vetements Vamp Футболка", rarity = "Epic", fairPrice = 34000, spawnChance = 6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=79055634746752"},
	{name = "Off-White Белая Футболка", rarity = "Epic", fairPrice = 18500, spawnChance = 5.5, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=77648065328093"},
	{name = "Cav Empt Свитшот Черный v2", rarity = "Epic", fairPrice = 7200, spawnChance = 5, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=133833701471231"},
	{name = "BAPE Tiger Диолетовый", rarity = "Epic", fairPrice = 8500, spawnChance = 5, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=89850552047032"},
	{name = "BAPE Shark Диоловая", rarity = "Epic", fairPrice = 8800, spawnChance = 5, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=76608523493879"},
	{name = "NeNet Свитшот", rarity = "Epic", fairPrice = 9500, spawnChance = 5, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=86371946444108"},
	{name = "CP.Company Noir Default", rarity = "Epic", fairPrice = 22000, spawnChance = 5, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=129750675911936"},
	{name = "Moncler Black Full Sleeve", rarity = "Epic", fairPrice = 32000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=3163582972"},
	{name = "Moncler Vest Orange", rarity = "Epic", fairPrice = 34000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=8162777336"},
	{name = "1017 ALYX 9SM Свитшот", rarity = "Epic", fairPrice = 10000, spawnChance = 5, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=12014837043"},
	{name = "Maison Margiela Свитер", rarity = "Epic", fairPrice = 92000, spawnChance = 5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=18270211818"},
	{name = "BAPE Holographic Tiger Черная", rarity = "Epic", fairPrice = 9500, spawnChance = 4.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=131149018267727"},
	{name = "Palm Angels Zip Классик", rarity = "Epic", fairPrice = 24000, spawnChance = 4.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=15161522216"},
	{name = "Cav Empt Свитшот Серый", rarity = "Epic", fairPrice = 9500, spawnChance = 4, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=82253574783227"},
	{name = "Gallery Dept Футболка Зеленая", rarity = "Epic", fairPrice = 4800, spawnChance = 4, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=112767657076967"},
	{name = "Stussy World Tour", rarity = "Epic", fairPrice = 7200, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=114724376"},
	{name = "BAPE Зеленый/Оранжевый Tiger Белый", rarity = "Epic", fairPrice = 7800, spawnChance = 4, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=116494230472293"},
	{name = "NeNet Свитшот Синий", rarity = "Epic", fairPrice = 12000, spawnChance = 4, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=136751660202947"},
	{name = "HBA Морф", rarity = "Epic", fairPrice = 12000, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=16452154205"},
	{name = "Burberry London", rarity = "Epic", fairPrice = 26000, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=14961358287"},
	{name = "Palm Angels Zip Серая", rarity = "Epic", fairPrice = 26000, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=15616127658"},
	{name = "Comme des Garcons Свитшот Серый", rarity = "Epic", fairPrice = 18500, spawnChance = 4, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=11602203762"},
	{name = "Comme des Garcons Camo Футболка", rarity = "Epic", fairPrice = 12500, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=5575894957"},
	{name = "Moncler Orange Jacket", rarity = "Epic", fairPrice = 34000, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=5960853091"},
	{name = "Moncler Black Jacket Alt", rarity = "Epic", fairPrice = 34000, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=5964807949"},
	{name = "Moncler Yellow Puffer", rarity = "Epic", fairPrice = 34000, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=8162975482"},
	{name = "Vetements Лонгслив Темно-Синий", rarity = "Epic", fairPrice = 26000, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=121286505120011"},
	{name = "Nike Tech Blue", rarity = "Epic", fairPrice = 4800, spawnChance = 3.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=12757775209"},
	{name = "BAPE Tiger Red", rarity = "Epic", fairPrice = 11500, spawnChance = 3.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=2783959077"},
	{name = "BAPE Tiger Colors Черный", rarity = "Epic", fairPrice = 8200, spawnChance = 3.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=111468952224383"},
	{name = "Acne Studios Oversized Hoodie", rarity = "Epic", fairPrice = 28000, spawnChance = 3.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=6174845141"},
	{name = "Comme des Garcons Лонгслив Белый-Черный", rarity = "Epic", fairPrice = 14500, spawnChance = 3.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=5699364075"},
	{name = "Gallery Dept Лонгслив", rarity = "Epic", fairPrice = 6200, spawnChance = 3, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=86930388641426"},
	{name = "Palace x Adidas", rarity = "Epic", fairPrice = 9500, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=114724376"},
	{name = "Bape Tiger Зеленый/Оранжевый", rarity = "Epic", fairPrice = 9200, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=118096380460829"},
	{name = "NeNet Свитшот Черный", rarity = "Epic", fairPrice = 10500, spawnChance = 3, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=133923738688296"},
	{name = "Off-White Синюю", rarity = "Epic", fairPrice = 24000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=2744313453"},
	{name = "Palm Angels Футболка Bear", rarity = "Epic", fairPrice = 18000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=12257396284"},
	{name = "Palm Angels Zip", rarity = "Epic", fairPrice = 22000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=5973979369"},
	{name = "Moncler Green Jacket", rarity = "Epic", fairPrice = 34000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=6722978600"},
	{name = "1017 ALYX 9SM Рубашка", rarity = "Epic", fairPrice = 18000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=77789781458157"},
	{name = "Gallery Dept Футболка Синюю", rarity = "Epic", fairPrice = 5500, spawnChance = 2.5, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=97383980071706"},
	{name = "Gallery Dept Футболка", rarity = "Epic", fairPrice = 5200, spawnChance = 2.5, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=81097819443421"},
	{name = "BAPE Dubai Camo Shark Белый", rarity = "Epic", fairPrice = 11000, spawnChance = 2.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=92578246025874"},
	{name = "Yohji Yamamoto Спортивная Куртка Poison", rarity = "Epic", fairPrice = 38000, spawnChance = 2.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=14606133191"},
	{name = "BAPE Panda Диолетовый камуфляж", rarity = "Epic", fairPrice = 9800, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=92408188189593"},
	{name = "NeNet Футболка Белая v2", rarity = "Epic", fairPrice = 11000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=96601307210853"},
	{name = "HBA Face Свитшот", rarity = "Epic", fairPrice = 14000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=136339034847316"},
	{name = "HBA Зип-Худи", rarity = "Epic", fairPrice = 13000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=18588070429"},
	{name = "Гоша Рубчинский Футбол", rarity = "Epic", fairPrice = 22000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=4909082166"},
	{name = "Balenciaga Tiger", rarity = "Epic", fairPrice = 36000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=128548008556726"},
	{name = "1017 ALYX 9SM x Moncler Свитшот", rarity = "Epic", fairPrice = 18000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=14307548976"},
	{name = "1017 ALYX 9SM Свитшот Красный", rarity = "Epic", fairPrice = 18000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=10253718440"},
	{name = "Vetements Худи v2", rarity = "Epic", fairPrice = 42000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=138522176771814"},
	{name = "Goyard Классическая Футболка", rarity = "Epic", fairPrice = 48000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=907988292"},
	{name = "Goyard Классическая Футболка v2", rarity = "Epic", fairPrice = 48000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=6131796935"},
	{name = "BAPE x Stussy", rarity = "Epic", fairPrice = 15000, spawnChance = 1.8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=836376692"},
	{name = "Золотая цепь", rarity = "Epic", fairPrice = 3800, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=12001043338"},
	{name = "HBA Aphex Свитшот", rarity = "Epic", fairPrice = 16000, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=16579558738"},
	{name = "Stone Island Termo Longsleave", rarity = "Epic", fairPrice = 42000, spawnChance = 1.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=13948309734"},
	{name = "Racer WorldWide Свитер В Полоску", rarity = "Epic", fairPrice = 24000, spawnChance = 1.2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=8633623311"},
	{name = "Yohji Yamamoto Свитшот Зеленый", rarity = "Epic", fairPrice = 65000, spawnChance = 1, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=7023449505"},
	{name = "Yohji Yamamoto Свитшот", rarity = "Epic", fairPrice = 115000, spawnChance = 0.8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=81236192398007"},
	{name = "CP.Company DD Shell Noir", rarity = "Epic", fairPrice = 45000, spawnChance = 0.7, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=140211743181343"},
	-- Legendary (все)
	{name = "ERD Белый Лонг", rarity = "Legendary", fairPrice = 38000, spawnChance = 12, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=123606003052906"},
	{name = "ERD Лонгслив", rarity = "Legendary", fairPrice = 45000, spawnChance = 10, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=121570221608171"},
	{name = "Number(N)ine Коричневое Худи", rarity = "Legendary", fairPrice = 92000, spawnChance = 10, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=18632819218"},
	{name = "Number(N)ine Красный Лонгслив", rarity = "Legendary", fairPrice = 62000, spawnChance = 10, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=92179729406275"},
	{name = "Dior Футболка", rarity = "Legendary", fairPrice = 72000, spawnChance = 8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=18370037012"},
	{name = "Dior Лонгслив", rarity = "Legendary", fairPrice = 72000, spawnChance = 8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=90616242454062"},
	{name = "Dior Свитшот", rarity = "Legendary", fairPrice = 72000, spawnChance = 8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=18147276987"},
	{name = "Dior Худи", rarity = "Legendary", fairPrice = 72000, spawnChance = 8, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=97862381126886"},
	{name = "Dior Свитер", rarity = "Legendary", fairPrice = 72000, spawnChance = 8, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=123326322310262"},
	{name = "Dior Зип Худи", rarity = "Legendary", fairPrice = 72000, spawnChance = 8, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=97916957692926"},
	{name = "Dior Зип", rarity = "Legendary", fairPrice = 72000, spawnChance = 8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=10371714762"},
	{name = "Comme des Garcons Футболка Черная", rarity = "Legendary", fairPrice = 8000, spawnChance = 6, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=15121388489"},
	{name = "Gucci Polo Shake", rarity = "Legendary", fairPrice = 38000, spawnChance = 6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=5469366382"},
	{name = "Chrome Hearts Rainbow Cross", rarity = "Legendary", fairPrice = 42000, spawnChance = 6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=10322816389"},
	{name = "Chrome Hearts Grunge", rarity = "Legendary", fairPrice = 45000, spawnChance = 6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=18968804436"},
	{name = "Chrome Hearts Tee", rarity = "Legendary", fairPrice = 32000, spawnChance = 6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=105944594585999"},
	{name = "Vetements Футболка Оранжевая", rarity = "Legendary", fairPrice = 36000, spawnChance = 6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=72319118602062"},
	{name = "Гоша Рубчинский Свитер Синий", rarity = "Legendary", fairPrice = 34000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=9545499621"},
	{name = "Palm Angels Футболка v3", rarity = "Legendary", fairPrice = 26000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=11511640225"},
	{name = "CP.Company Cardigan Black", rarity = "Legendary", fairPrice = 24000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=114059977011418"},
	{name = "Chrome Hearts Red Shirt", rarity = "Legendary", fairPrice = 34000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=96426276627952"},
	{name = "Chrome Hearts Cyan Alt", rarity = "Legendary", fairPrice = 38000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=6447552136"},
	{name = "Chrome Hearts Zip Up Hoodie Black", rarity = "Legendary", fairPrice = 34000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=18400219160"},
	{name = "Number(N)ine Серое Худи", rarity = "Legendary", fairPrice = 98000, spawnChance = 5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=18632881138"},
	{name = "Vetements Футболка Зеленая Polizei", rarity = "Legendary", fairPrice = 30000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=87574055123730"},
	{name = "Maison Margiela Зеленый Лонгслив", rarity = "Legendary", fairPrice = 65532, spawnChance = 5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=122013146968984"},
	{name = "Palm Angels Футболка v2", rarity = "Legendary", fairPrice = 28000, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=137602728499501"},
	{name = "Comme des Garcons Футболка Love Белая", rarity = "Legendary", fairPrice = 12000, spawnChance = 4, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=2098915062"},
	{name = "Balenciaga Campaign", rarity = "Legendary", fairPrice = 45000, spawnChance = 4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=10890916959"},
	{name = "Balenciaga Grey Jumper", rarity = "Legendary", fairPrice = 34000, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=3785693742"},
	{name = "Chrome Hearts Cyan", rarity = "Legendary", fairPrice = 42000, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=14127820281"},
	{name = "Chrome Hearts Orange Sweater", rarity = "Legendary", fairPrice = 42000, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=7381767617"},
	{name = "CP.Company Teal Jumper", rarity = "Legendary", fairPrice = 24000, spawnChance = 3.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=100202806030453"},
	{name = "Off-White Белая Футболка v3", rarity = "Legendary", fairPrice = 32000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=128971329287614"},
	{name = "Comme des Garcons Play Футболка Черная", rarity = "Legendary", fairPrice = 10000, spawnChance = 3, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=84910845680321"},
	{name = "Comme des Garcons Футболка Белый-Красный", rarity = "Legendary", fairPrice = 10000, spawnChance = 3, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=1079296698"},
	{name = "Gucci Tiger Tracksuit", rarity = "Legendary", fairPrice = 72000, spawnChance = 3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=5680301038"},
	{name = "Gucci Star Sweater", rarity = "Legendary", fairPrice = 42000, spawnChance = 3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=6181344218"},
	{name = "LV x TNF", rarity = "Legendary", fairPrice = 62000, spawnChance = 3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=5836356608"},
	{name = "Balenciaga Distressed Hoodie", rarity = "Legendary", fairPrice = 28000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=13676876559"},
	{name = "Balenciaga Hoodie Alien", rarity = "Legendary", fairPrice = 38000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=121457728585002"},
	{name = "Chrome Hearts Rainbow Sweatshirt", rarity = "Legendary", fairPrice = 45000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=88657092267618"},
	{name = "Chrome Hearts Red & Green Sweater", rarity = "Legendary", fairPrice = 38000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=91736052828109"},
	{name = "ERD Destroyed Hoodie", rarity = "Legendary", fairPrice = 92000, spawnChance = 3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=96169343442413"},
	{name = "Off-White Черная Футболка v2", rarity = "Legendary", fairPrice = 32000, spawnChance = 2.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=15084872855"},
	{name = "Off-White Белая Футболка v2", rarity = "Legendary", fairPrice = 32000, spawnChance = 2.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=4809072517"},
	{name = "CP.Company Crewneck", rarity = "Legendary", fairPrice = 28000, spawnChance = 2.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=15783597806"},
	{name = "Chrome Hearts Gray Sweater", rarity = "Legendary", fairPrice = 62000, spawnChance = 2.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=6678207948"},
	{name = "Гоша Рубчинский Свитер Зелёный", rarity = "Legendary", fairPrice = 25000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=5549063522"},
	{name = "Gucci X Tee", rarity = "Legendary", fairPrice = 62000, spawnChance = 2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=3370348998"},
	{name = "Balenciaga x Fortnite", rarity = "Legendary", fairPrice = 62000, spawnChance = 2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=139098321562151"},
	{name = "Balenciaga X Under Armor", rarity = "Legendary", fairPrice = 38000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=17747885598"},
	{name = "Balenciaga Logo Print Hoodie Blue", rarity = "Legendary", fairPrice = 48000, spawnChance = 2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=15825720917"},
	{name = "Rick Owens x Moncler", rarity = "Legendary", fairPrice = 95000, spawnChance = 2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=8573407381"},
	{name = "Chrome Hearts Yellow Hoodie", rarity = "Legendary", fairPrice = 62000, spawnChance = 2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=11454813839"},
	{name = "Moncler Vest Classic", rarity = "Legendary", fairPrice = 36000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=6488586195"},
	{name = "Moncler Gray Sweater", rarity = "Legendary", fairPrice = 36000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=5341316022"},
	{name = "Moncler Gray Vest", rarity = "Legendary", fairPrice = 38000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=6142390555"},
	{name = "Moncler Red Puffer", rarity = "Legendary", fairPrice = 38000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=6455447817"},
	{name = "Raf Simons Поле Красное", rarity = "Legendary", fairPrice = 45000, spawnChance = 2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=86535840755601"},
	{name = "Number(N)ine Черный Лонгслив", rarity = "Legendary", fairPrice = 110000, spawnChance = 2, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=12274864949"},
	{name = "Maison Margiela Рубашка", rarity = "Legendary", fairPrice = 62000, spawnChance = 2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=116378390555375"},
	{name = "Cav Empt Футболка Spring Delivery", rarity = "Legendary", fairPrice = 14000, spawnChance = 1.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=2887711508"},
	{name = "Gallery Dept Красный Зип-Худи", rarity = "Legendary", fairPrice = 7500, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=106768419883339"},
	{name = "Гоша Рубчинский Враг Свитер Черный", rarity = "Legendary", fairPrice = 28000, spawnChance = 1.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=5487023082"},
	{name = "Гоша Рубчинский Вдруг Красный", rarity = "Legendary", fairPrice = 26000, spawnChance = 1.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=2118764675"},
	{name = "Palm Angels Свитшот Голубой", rarity = "Legendary", fairPrice = 38000, spawnChance = 1.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=6274614445"},
	{name = "Comme des Garcons Лонгслив Белый-Синий", rarity = "Legendary", fairPrice = 14000, spawnChance = 1.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=962194501"},
	{name = "Stone Island Orange", rarity = "Legendary", fairPrice = 38000, spawnChance = 1.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=14840856734"},
	{name = "Stone Island Pink", rarity = "Legendary", fairPrice = 38000, spawnChance = 1.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=14984408071"},
	{name = "Gucci Sweatshirt Planet", rarity = "Legendary", fairPrice = 58000, spawnChance = 1.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=1083553645"},
	{name = "Balenciaga x Gucci", rarity = "Legendary", fairPrice = 72000, spawnChance = 1.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=3138759109"},
	{name = "Balenciaga Speed Runner Hoodie", rarity = "Legendary", fairPrice = 55000, spawnChance = 1.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=15453420607"},
	{name = "Balenciaga Paris Moon Sweater", rarity = "Legendary", fairPrice = 42000, spawnChance = 1.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=4590342417"},
	{name = "Rick Owens Джинсовка Красная", rarity = "Legendary", fairPrice = 110000, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=104312480723109"},
	{name = "Moncler Red Tracksuit", rarity = "Legendary", fairPrice = 42000, spawnChance = 1.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=6488509541"},
	{name = "Moncler TriColor Windbreaker", rarity = "Legendary", fairPrice = 42000, spawnChance = 1.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=4831711963"},
	{name = "Moncler Puffer Logo", rarity = "Legendary", fairPrice = 45000, spawnChance = 1.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=6488495444"},
	{name = "Moncler Black Jacket", rarity = "Legendary", fairPrice = 38000, spawnChance = 1.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=9375216024"},
	{name = "ERD Bully Худи", rarity = "Legendary", fairPrice = 110000, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=101084350202088"},
	{name = "Raf Simons Hoodie", rarity = "Legendary", fairPrice = 150000, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=15570425228"},
	{name = "Raf Simons Brian Calvin Beer Girl", rarity = "Legendary", fairPrice = 135000, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=111577229615749"},
	{name = "Raf Simons Худи Серый", rarity = "Legendary", fairPrice = 68000, spawnChance = 1.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=78423426771931"},
	{name = "Number(N)ine Shield Серое Худи", rarity = "Legendary", fairPrice = 140000, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=93772836697005"},
	{name = "Number(N)ine Футболка", rarity = "Legendary", fairPrice = 150000, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=14885532600"},
	{name = "Vetements Antwerpen Белая v2", rarity = "Legendary", fairPrice = 34000, spawnChance = 1.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=15564674128"},
	{name = "Гоша Рубчинский Zip Красный/Синий", rarity = "Legendary", fairPrice = 24000, spawnChance = 1.2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=4996937424"},
	{name = "Off-White Зеленый", rarity = "Legendary", fairPrice = 42000, spawnChance = 1.2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=3224293748"},
	{name = "Palm Angels Zip Красная", rarity = "Legendary", fairPrice = 42000, spawnChance = 1.2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=82632223116206"},
	{name = "Comme des Garcons Футболка Camo Love", rarity = "Legendary", fairPrice = 16000, spawnChance = 1.2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=8128676567"},
	{name = "Stone Island Zip-Hoodie", rarity = "Legendary", fairPrice = 48000, spawnChance = 1.2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=76328541032905"},
	{name = "Rick Owens Джинсовка Желтая", rarity = "Legendary", fairPrice = 115000, spawnChance = 1.2, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=126666180709430"},
	{name = "Гоша Рубчинский Гибридный", rarity = "Legendary", fairPrice = 32000, spawnChance = 1, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=14578854612"},
	{name = "Off-White Бежевая", rarity = "Legendary", fairPrice = 48000, spawnChance = 1, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=590131467"},
	{name = "Yohji Yamamoto Project Футболка", rarity = "Legendary", fairPrice = 45000, spawnChance = 1, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=80317503110912"},
	{name = "Gucci Blind For Love Hoodie", rarity = "Legendary", fairPrice = 72000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=135570927510919"},
	{name = "Balenciaga Tokyo Cut", rarity = "Legendary", fairPrice = 52000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=129646863766412"},
	{name = "Balenciaga Runway Polo Hoodie", rarity = "Legendary", fairPrice = 72000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=121852578331304"},
	{name = "Chrome Hearts Matty Boy Space", rarity = "Legendary", fairPrice = 95000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=18428381620"},
	{name = "Chrome Hearts Matty Boy Sweatshirt", rarity = "Legendary", fairPrice = 98000, spawnChance = 1, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=99648384101964"},
	{name = "Chrome Hearts Cross Patch Dog", rarity = "Legendary", fairPrice = 72000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=138131982318663"},
	{name = "Moncler Black Tapered Tracksuit", rarity = "Legendary", fairPrice = 52000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=15338842140"},
	{name = "Moncler Parka Coat", rarity = "Legendary", fairPrice = 55000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=8446274538"},
	{name = "Moncler x Palm Angels Red Zip", rarity = "Legendary", fairPrice = 58000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=5964876790"},
	{name = "Moncler x Palm Angels Jacket", rarity = "Legendary", fairPrice = 58000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=8165648352"},
	{name = "Moncler Blue Zip-Up", rarity = "Legendary", fairPrice = 60000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=6505230098"},
	{name = "Moncler Blue Coat", rarity = "Legendary", fairPrice = 58000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=9384199608"},
	{name = "Moncler Maroon Jacket", rarity = "Legendary", fairPrice = 62000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=6787299886"},
	{name = "Moncler x Palm Angels Black", rarity = "Legendary", fairPrice = 48000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=13876237671"},
	{name = "ERD Голубой Лонгслив", rarity = "Legendary", fairPrice = 150000, spawnChance = 1, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=89912258455155"},
	{name = "Raf Simons Красный Лонгслив", rarity = "Legendary", fairPrice = 98000, spawnChance = 1, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=101022741927139"},
	{name = "Raf Simons Красный Лонгслив v2", rarity = "Legendary", fairPrice = 82000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=82418962692790"},
	{name = "Vetements Antwerp Красный", rarity = "Legendary", fairPrice = 34000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=18720565312"},
	{name = "Vetements Antwerpen Белая v1", rarity = "Legendary", fairPrice = 34000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=137359038396430"},
	{name = "Yohji Yamamoto Свитшот Supreme", rarity = "Legendary", fairPrice = 92000, spawnChance = 0.9, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=101719135948655"},
	{name = "Gallery Dept Свитшот Синий", rarity = "Legendary", fairPrice = 14500, spawnChance = 0.8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=78229573413073"},
	{name = "Гоша Рубчинский Fila Yellow LS", rarity = "Legendary", fairPrice = 32000, spawnChance = 0.8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=124794708387683"},
	{name = "Гоша Рубчинский Спорт Куртка Russian", rarity = "Legendary", fairPrice = 32000, spawnChance = 0.8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=607550977"},
	{name = "Polo Burberry", rarity = "Legendary", fairPrice = 42000, spawnChance = 0.8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=15903662481"},
	{name = "Stone Island Turtleneck", rarity = "Legendary", fairPrice = 55000, spawnChance = 0.8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=12624379863"},
	{name = "Stone Island Desert Camo", rarity = "Legendary", fairPrice = 45000, spawnChance = 0.8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=8631687937"},
	{name = "CP.Company Blue Puffer Jacket", rarity = "Legendary", fairPrice = 52000, spawnChance = 0.8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=136328494966050"},
	{name = "Balenciaga 3B Sports Deutsche Bahn", rarity = "Legendary", fairPrice = 72000, spawnChance = 0.8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=95032444256650"},
	{name = "Rick Owens Зип Джинсовка Розовая", rarity = "Legendary", fairPrice = 135000, spawnChance = 0.8, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=73715775795954"},
	{name = "1017 ALYX 9SM Куртка Зип", rarity = "Legendary", fairPrice = 22000, spawnChance = 0.8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=16949566048"},
	{name = "Vetements Зип-Худи", rarity = "Legendary", fairPrice = 72000, spawnChance = 0.8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=79406613328258"},
	{name = "Vetements Antwerp Темно-Красное", rarity = "Legendary", fairPrice = 34000, spawnChance = 0.8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=4552458056"},
	{name = "Гоша Рубчинский X Kappa Свитер", rarity = "Legendary", fairPrice = 36000, spawnChance = 0.7, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=15311273887"},
	{name = "Off-White Свитер", rarity = "Legendary", fairPrice = 58000, spawnChance = 0.7, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=2518177899"},
	{name = "Cav Empt Свитшот Желтый Symptom Heavy", rarity = "Legendary", fairPrice = 18500, spawnChance = 0.6, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=3244925420"},
	{name = "NeNet Футболка Серая", rarity = "Legendary", fairPrice = 22000, spawnChance = 0.6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=80169471492515"},
	{name = "Гоша Рубчинский Худи ColorBrick", rarity = "Legendary", fairPrice = 38000, spawnChance = 0.6, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=560325375"},
	{name = "Acne Studios Jacket", rarity = "Legendary", fairPrice = 68000, spawnChance = 0.6, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=114724376"},
	{name = "Stone Island Urban Black Yellow", rarity = "Legendary", fairPrice = 62000, spawnChance = 0.6, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=7249098498"},
	{name = "CP.Company Carbone Noir", rarity = "Legendary", fairPrice = 42000, spawnChance = 0.6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=89000210931232"},
	{name = "Yohji Yamamoto AW 2001 Godzilla Свитшот", rarity = "Legendary", fairPrice = 95000, spawnChance = 0.6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=4794620883"},
	{name = "Gallery Dept Lanvin", rarity = "Legendary", fairPrice = 32000, spawnChance = 0.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=131469345785671"},
	{name = "BAPE Red Panda", rarity = "Legendary", fairPrice = 18000, spawnChance = 0.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=119505659829019"},
	{name = "HBA Creepy Свитшот", rarity = "Legendary", fairPrice = 32000, spawnChance = 0.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=110327323437539"},
	{name = "Comme des Garcons Рубашка", rarity = "Legendary", fairPrice = 32000, spawnChance = 0.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=106858564910643"},
	{name = "Gucci Tiger Hoodie", rarity = "Legendary", fairPrice = 135000, spawnChance = 0.5, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=1518645601"},
	{name = "Gucci x LV Jacket", rarity = "Legendary", fairPrice = 95000, spawnChance = 0.5, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=2109554074"},
	{name = "Supreme x LV", rarity = "Legendary", fairPrice = 92000, spawnChance = 0.5, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=5226567361"},
	{name = "Balenciaga GAMER", rarity = "Legendary", fairPrice = 92000, spawnChance = 0.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=12774350595"},
	{name = "Balenciaga Resort 2023", rarity = "Legendary", fairPrice = 62000, spawnChance = 0.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=16648534737"},
	{name = "Rick Owens Футболка Vamp", rarity = "Legendary", fairPrice = 150000, spawnChance = 0.5, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=118047677275927"},
	{name = "Chrome Hearts Black Pink LS", rarity = "Legendary", fairPrice = 110000, spawnChance = 0.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=132675671197247"},
	{name = "Chrome Hearts Miami Hoodie", rarity = "Legendary", fairPrice = 118000, spawnChance = 0.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=12852126142"},
	{name = "Moncler Green Zip-up", rarity = "Legendary", fairPrice = 55000, spawnChance = 0.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=6505230906"},
	{name = "Moncler Multi Colored Jacket", rarity = "Legendary", fairPrice = 60000, spawnChance = 0.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=3689506848"},
	{name = "Moncler X PA Blue Tracksuit Top", rarity = "Legendary", fairPrice = 72000, spawnChance = 0.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=12636365033"},
	{name = "Moncler Purple Bubble Jacket", rarity = "Legendary", fairPrice = 72000, spawnChance = 0.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=6455444988"},
	{name = "ERD Distressed Zip Jacket", rarity = "Legendary", fairPrice = 170000, spawnChance = 0.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=12001043338"},
	{name = "Raf Simons Black Christiane F AW18", rarity = "Legendary", fairPrice = 92000, spawnChance = 0.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=128994040799428"},
	{name = "Raf Simons Brian Calvin Beer Girl Tee", rarity = "Legendary", fairPrice = 145000, spawnChance = 0.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=138441760917041"},
	{name = "Vetements Бомбер", rarity = "Legendary", fairPrice = 95000, spawnChance = 0.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=85918020485117"},
	{name = "Vetements 204 Hyoma Raf Reconstructed", rarity = "Legendary", fairPrice = 42000, spawnChance = 0.5, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=132864531993350"},
	{name = "Goyard Зеленая Футболка", rarity = "Legendary", fairPrice = 75000, spawnChance = 0.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=6763195390"},
	{name = "Nike Tech Dark Light Blue", rarity = "Legendary", fairPrice = 9500, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=8801995608"},
	{name = "Gallery Dept Свитшот Коричневый", rarity = "Legendary", fairPrice = 11000, spawnChance = 0.4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=124744117453032"},
	{name = "Gutta Raiders Camo shirt", rarity = "Legendary", fairPrice = 18000, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=116825151038506"},
	{name = "Гоша Рубчинский x Kappa Винтаж", rarity = "Legendary", fairPrice = 41000, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=1162019942"},
	{name = "Гоша Рубчинский x Kappa", rarity = "Legendary", fairPrice = 45000, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=884721412"},
	{name = "Palm Angels Flame", rarity = "Legendary", fairPrice = 52000, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=5611331856"},
	{name = "Comme des Garcons Синий Зип-Худи", rarity = "Legendary", fairPrice = 28000, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=1074658733"},
	{name = "CP.Company DD Shell Green", rarity = "Legendary", fairPrice = 65000, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=86384443721939"},
	{name = "Yohji Yamamoto Ys for Men AW2001 Godzilla", rarity = "Legendary", fairPrice = 135000, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=6046174003"},
	{name = "Yohji Yamamoto Свитшот Spider Knit", rarity = "Legendary", fairPrice = 98000, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=10515393661"},
	{name = "Yohji Yamamoto Свитшот Smoke", rarity = "Legendary", fairPrice = 125000, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=8826223533"},
	{name = "Vetements Anarchy", rarity = "Legendary", fairPrice = 85000, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=17508312479"},
	{name = "Vetements Clothing Green", rarity = "Legendary", fairPrice = 82000, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=95196500046820"},
	{name = "Гоша Рубчинский Флаги", rarity = "Legendary", fairPrice = 48000, spawnChance = 0.35, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=101736067946702"},
	{name = "Stone Island Off Day Blue", rarity = "Legendary", fairPrice = 72000, spawnChance = 0.35, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=113679737601896"},
	{name = "Stone Island Red Hoodie Off Dye", rarity = "Legendary", fairPrice = 68000, spawnChance = 0.35, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=81220837440974"},
	{name = "Gallery Dept Худи Зеленое", rarity = "Legendary", fairPrice = 18000, spawnChance = 0.3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=115370689540260"},
	{name = "BAPE Yellow Camo Shark", rarity = "Legendary", fairPrice = 28000, spawnChance = 0.3, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=4843433312"},
	{name = "Gutta Snake Year", rarity = "Legendary", fairPrice = 15000, spawnChance = 0.3, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=123206690688862"},
	{name = "Stone Island Desert Camo Jacket", rarity = "Legendary", fairPrice = 72000, spawnChance = 0.3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=8631651969"},
	{name = "CP.Company DD Shell Red", rarity = "Legendary", fairPrice = 75000, spawnChance = 0.3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=132013565350632"},
	{name = "Yohji Yamamoto Rei Ayanami Evangelion Button up", rarity = "Legendary", fairPrice = 145000, spawnChance = 0.3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=14484000375"},
	{name = "Yohji Yamamoto Свитшот Avant Garde", rarity = "Legendary", fairPrice = 155000, spawnChance = 0.3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=98806393103327"},
	{name = "Yohji Yamamoto Свитшот Skull", rarity = "Legendary", fairPrice = 110000, spawnChance = 0.3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=5166805183"},
	{name = "Balenciaga GAMER Denim Jacket", rarity = "Legendary", fairPrice = 115000, spawnChance = 0.3, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=16648632262"},
	{name = "Balenciaga Red Crimson Windbreaker", rarity = "Legendary", fairPrice = 95000, spawnChance = 0.3, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=109182717388810"},
	{name = "Rick Owens Runway", rarity = "Legendary", fairPrice = 180000, spawnChance = 0.3, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=8502567661"},
	{name = "Chrome Hearts Multi-Colour Hoodie", rarity = "Legendary", fairPrice = 125000, spawnChance = 0.3, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=16919855211"},
	{name = "Moncler X PA Forest Green Top", rarity = "Legendary", fairPrice = 75000, spawnChance = 0.3, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=12621049069"},
	{name = "Moncler x PA Puffer Jacket", rarity = "Legendary", fairPrice = 85000, spawnChance = 0.3, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=14396989862"},
	{name = "Raf Simons Christiane F Tees AW18", rarity = "Legendary", fairPrice = 195000, spawnChance = 0.3, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=123791858080621"},
	{name = "Raf Simons Бомбер Белый", rarity = "Legendary", fairPrice = 160000, spawnChance = 0.3, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=117354704887130"},
	{name = "Number(N)ine Zip Jacket", rarity = "Legendary", fairPrice = 220000, spawnChance = 0.3, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=133885913046054"},
	{name = "Off-White MonoLisa", rarity = "Legendary", fairPrice = 75000, spawnChance = 0.25, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=2474144248"},
	{name = "CP.Company Black Windbreaker", rarity = "Legendary", fairPrice = 88000, spawnChance = 0.25, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=139489138382284"},
	{name = "Racer WorldWide Леопардовая Зип-Худи", rarity = "Legendary", fairPrice = 42000, spawnChance = 0.25, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=97015229289733"},
	{name = "Yohji Yamamoto J-PT Иллюстрация", rarity = "Legendary", fairPrice = 115000, spawnChance = 0.25, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=126677760564089"},
	{name = "Vetements Бомбер Зеленый", rarity = "Legendary", fairPrice = 110000, spawnChance = 0.25, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=137163050708182"},
	{name = "Vetements Бомбер Тёмно-Зеленый", rarity = "Legendary", fairPrice = 110000, spawnChance = 0.25, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=83260757337933"},
	{name = "Vetements Бомбер Красный", rarity = "Legendary", fairPrice = 110000, spawnChance = 0.25, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=76107508359689"},
	{name = "HBA Рубашка", rarity = "Legendary", fairPrice = 28000, spawnChance = 0.2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=100120983911427"},
	{name = "Гоша Рубчинский Camo Спаси Сохрани", rarity = "Legendary", fairPrice = 52000, spawnChance = 0.2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=576444463"},
	{name = "CP.Company DD Shell Beige", rarity = "Legendary", fairPrice = 78000, spawnChance = 0.2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=133857925190529"},
	{name = "Balenciaga Jean Jacket X Gosha", rarity = "Legendary", fairPrice = 110000, spawnChance = 0.2, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=5314403312"},
	{name = "Moncler Striped Technical", rarity = "Legendary", fairPrice = 95000, spawnChance = 0.2, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=5029449211"},
	{name = "Maison Margiela Женская Меховая Куртка", rarity = "Legendary", fairPrice = 100000, spawnChance = 0.2, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=78070667368419"},
	{name = "Cav Empt Not Impossible Crewneck", rarity = "Legendary", fairPrice = 12000, spawnChance = 0.15, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=322189905"},
	{name = "NeNet Футболка Диоловая", rarity = "Legendary", fairPrice = 38000, spawnChance = 0.15, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=9930373233"},
	{name = "Гоша Рубчинский x Rassvet", rarity = "Legendary", fairPrice = 45000, spawnChance = 0.15, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=15706847529"},
	{name = "Off-White Camo", rarity = "Legendary", fairPrice = 92000, spawnChance = 0.15, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=1213373788"},
	{name = "Comme des Garcons X Rolling Stones Футболка", rarity = "Legendary", fairPrice = 42000, spawnChance = 0.15, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=98965932254784"},
	{name = "Stone Island WATRO-TC Jacket", rarity = "Legendary", fairPrice = 88000, spawnChance = 0.15, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=8631755137"},
	{name = "CP.Company Navy Windbreaker", rarity = "Legendary", fairPrice = 92000, spawnChance = 0.15, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=98404573180892"},
	{name = "Yohji Yamamoto Heroes Leather Байкерская Куртка", rarity = "Legendary", fairPrice = 185000, spawnChance = 0.15, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=4895301291"},
	{name = "Balenciaga GAMER Bomber", rarity = "Legendary", fairPrice = 140000, spawnChance = 0.15, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=17750429116"},
	{name = "Number(N)ine Серая Zip Jacket", rarity = "Legendary", fairPrice = 245000, spawnChance = 0.15, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=121413776309543"},
	{name = "Vetements Бомбер Полиция", rarity = "Legendary", fairPrice = 135000, spawnChance = 0.15, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=11290616968"},
	{name = "Cav Empt Свитшот MD Document Crewneck", rarity = "Legendary", fairPrice = 16000, spawnChance = 0.1, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=1002344601"},
	{name = "Stone Island Reflective", rarity = "Legendary", fairPrice = 85000, spawnChance = 0.1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=111577510738468"},
	{name = "Stone Island Comfort Tech Blue", rarity = "Legendary", fairPrice = 75000, spawnChance = 0.1, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=72581419227405"},
	{name = "Stone Island Comfort Tech Red", rarity = "Legendary", fairPrice = 82000, spawnChance = 0.1, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=72056909985955"},
	{name = "Yohji Yamamoto Зеленая Куртка", rarity = "Legendary", fairPrice = 88000, spawnChance = 0.1, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=98522239109315"},
	{name = "Supreme x Bape x LV", rarity = "Legendary", fairPrice = 140000, spawnChance = 0.1, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=1565502110"},
	{name = "Balenciaga Reversible Bomber Jacket", rarity = "Legendary", fairPrice = 150000, spawnChance = 0.1, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=18813584909"},
	{name = "Moncler Spider", rarity = "Legendary", fairPrice = 105000, spawnChance = 0.1, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=11674658197"},
	{name = "Moncler x PA Kelsey Puffer Blue", rarity = "Legendary", fairPrice = 110000, spawnChance = 0.1, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=11484662800"},
	{name = "Raf Simons SS10 Sterling Ruby Shirt", rarity = "Legendary", fairPrice = 280000, spawnChance = 0.1, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=92202912411173"},
	{name = "Gallery Dept Футболка Шамана", rarity = "Legendary", fairPrice = 28000, spawnChance = 0.08, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=109387384568369"},
	{name = "Stone Island Skin Touch Purple", rarity = "Legendary", fairPrice = 98000, spawnChance = 0.08, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=13778721234"},
	{name = "Racer WorldWide Куртка из Овечьи Шкуры", rarity = "Legendary", fairPrice = 68000, spawnChance = 0.08, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=93929061709529"},
	{name = "Cav Empt Свитшот Joker", rarity = "Legendary", fairPrice = 22000, spawnChance = 0.07, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=18280893501"},
	{name = "BAPE Tiger Camo", rarity = "Legendary", fairPrice = 52000, spawnChance = 0.06, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=3052304804"},
	{name = "Cav Empt Свитшот FW 17", rarity = "Legendary", fairPrice = 38000, spawnChance = 0.05, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=914784451"},
	{name = "Nike Tech Windrunner Black", rarity = "Legendary", fairPrice = 22000, spawnChance = 0.05, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=7397565254"},
	{name = "Chrome Hearts Camo Matty", rarity = "Legendary", fairPrice = 190000, spawnChance = 0.05, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=80849817692916"},
	{name = "ERD Archive Худи Красный", rarity = "Legendary", fairPrice = 310000, spawnChance = 0.05, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=112414916707189"},
	{name = "ERD Archive Лонгслив", rarity = "Legendary", fairPrice = 290000, spawnChance = 0.05, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=117808202442208"},
	{name = "Number(N)ine Серый Лонгслив", rarity = "Legendary", fairPrice = 310000, spawnChance = 0.05, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=17573405255"},
	{name = "Cav Empt Бомбер", rarity = "Legendary", fairPrice = 42000, spawnChance = 0.04, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=297942902"},
	{name = "Гоша Рубчинский X Thrasher", rarity = "Legendary", fairPrice = 88000, spawnChance = 0.04, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=436720175"},
	{name = "Stone Island Shadow Tiger Camo", rarity = "Legendary", fairPrice = 125000, spawnChance = 0.04, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=99587740919956"},
	{name = "Гоша Рубчинский Зеленый Свитер", rarity = "Legendary", fairPrice = 95000, spawnChance = 0.03, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=772695234"},
	{name = "Gutta Opiy Shirt", rarity = "Legendary", fairPrice = 52000, spawnChance = 0.02, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=116197719499900"},
	{name = "Stone Island Comfort Tech Purple", rarity = "Legendary", fairPrice = 145000, spawnChance = 0.02, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=96072265863113"},
	{name = "Gucci Coco Capitan", rarity = "Legendary", fairPrice = 245000, spawnChance = 0.02, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=1081054865"},
	{name = "TH Hoodie X Balenciaga x RAF", rarity = "Legendary", fairPrice = 220000, spawnChance = 0.02, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=2074367249"},
	{name = "Balenciaga Paris", rarity = "Legendary", fairPrice = 245000, spawnChance = 0.02, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=130342095571450"},
	{name = "Chrome Hearts T Logo USA Hoodie", rarity = "Legendary", fairPrice = 245000, spawnChance = 0.02, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=97057584627432"},
	{name = "ERD Красная Джинсовка", rarity = "Legendary", fairPrice = 450000, spawnChance = 0.02, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=72161303025169"},
	{name = "Гоша Рубчинский Рождественский", rarity = "Legendary", fairPrice = 115000, spawnChance = 0.015, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=5972477551"},
	{name = "Гоша Рубчинский Вдруг Друг", rarity = "Legendary", fairPrice = 115000, spawnChance = 0.015, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=126602708675680"},
	{name = "Racer WorldWide ЛонгСлив Катя Кищук", rarity = "Legendary", fairPrice = 125000, spawnChance = 0.015, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=101546483409686"},
	{name = "Balenciaga Nasa Bomber Jacket", rarity = "Legendary", fairPrice = 350000, spawnChance = 0.01, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=118565360972858"},
	{name = "Balenciaga Runway", rarity = "Legendary", fairPrice = 300000, spawnChance = 0.01, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=16662225319"},
	{name = "Chrome Hearts x Off-White Hoodie", rarity = "Legendary", fairPrice = 320000, spawnChance = 0.01, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=5944585412"},
	{name = "Number(N)ine Shield Черное Худи", rarity = "Legendary", fairPrice = 420000, spawnChance = 0.01, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=126218652868749"},
	{name = "Palm Angels Zip Цветок", rarity = "Legendary", fairPrice = 145000, spawnChance = 0.009, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=6501833581"},
	{name = "Palm Angels Zip Диолетовый", rarity = "Legendary", fairPrice = 145000, spawnChance = 0.009, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=119801182639139"},
	{name = "Stone Island x Supreme Белые", rarity = "Legendary", fairPrice = 165000, spawnChance = 0.008, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=78339652684003"},
	{name = "Stone Island x Supreme", rarity = "Legendary", fairPrice = 165000, spawnChance = 0.008, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=116321915070400"},
	{name = "Bape x Supreme", rarity = "Legendary", fairPrice = 125000, spawnChance = 0.007, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=1103783722"},
	{name = "Palm Angels Zip Кислотный", rarity = "Legendary", fairPrice = 155000, spawnChance = 0.007, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=7205233873"},
	{name = "BAPE Full Zip Shark", rarity = "Legendary", fairPrice = 135000, spawnChance = 0.005, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=1329266661"},
	{name = "Off-White Virgil Abloh Красный", rarity = "Legendary", fairPrice = 285000, spawnChance = 0.005, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=6071739641"},
	{name = "Yohji Yamamoto Свитшот Кожанка", rarity = "Legendary", fairPrice = 450000, spawnChance = 0.005, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=92502686962334"},
	{name = "Chrome Hearts x LV Jacket", rarity = "Legendary", fairPrice = 380000, spawnChance = 0.005, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=7369775832"},
	{name = "Moncler x PA Fiber Light Puffer", rarity = "Legendary", fairPrice = 400000, spawnChance = 0.005, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=13429337006"},
	{name = "Maison Margiela Куртка из Ремней", rarity = "Legendary", fairPrice = 120000, spawnChance = 0.005, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=85073157438003"},
	{name = "Yohji Yamamoto Куртка Красная", rarity = "Legendary", fairPrice = 480000, spawnChance = 0.004, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=130162125639664"},
	{name = "Haliky Gang Bears", rarity = "Legendary", fairPrice = 72000, spawnChance = 0.003, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=6676412078"},
	{name = "Yohji Yamamoto Куртка Темно-Синюю", rarity = "Legendary", fairPrice = 520000, spawnChance = 0.003, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=71906531939193"},
	{name = "Stone Island Big Loom Camo-Tc", rarity = "Legendary", fairPrice = 350000, spawnChance = 0.002, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=8631708414"},
	{name = "Raf Simons AW01 Runway", rarity = "Legendary", fairPrice = 950000, spawnChance = 0.002, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=10443560332"},
	{name = "Haliky Худи", rarity = "Legendary", fairPrice = 85000, spawnChance = 0.001, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=6004029863"},
	{name = "Яндекс Доставка Футболка", rarity = "Legendary", fairPrice = 0, spawnChance = 0, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=18662896554"},
	{name = "redvetements", rarity = "Legendary", fairPrice = 777, spawnChance = 0, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=82427332093486"},
}

-- ============================================
-- ВСЕ ШТАНЫ (ПОЛНЫЙ СПИСОК)
-- ============================================
local PantsData = {
	-- Common
	{name = "Синие джинсы", rarity = "Common", fairPrice = 150, spawnChance = 50, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=9367316386"},
	-- Uncommon
	{name = "Carhartt Double Knee", rarity = "Uncommon", fairPrice = 2500, spawnChance = 28, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=8425198346"},
	{name = "Stussy Work Pants", rarity = "Uncommon", fairPrice = 2200, spawnChance = 28, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=8425198346"},
	{name = "Palace Track Pants", rarity = "Uncommon", fairPrice = 2800, spawnChance = 25, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=8425198346"},
	{name = "Рваные джинсы", rarity = "Uncommon", fairPrice = 550, spawnChance = 20, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=15617408738"},
	-- Rare
	{name = "Rick Owens Штаны", rarity = "Rare", fairPrice = 22000, spawnChance = 22, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=14220615385"},
	{name = "BAPE Camo Штаны", rarity = "Rare", fairPrice = 3800, spawnChance = 20, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=4947216606"},
	{name = "Rick Owens Джинсы", rarity = "Rare", fairPrice = 25000, spawnChance = 20, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=18477705687"},
	{name = "Carhartt Cargo", rarity = "Rare", fairPrice = 3800, spawnChance = 14, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=9367316386"},
	{name = "Burberry Штаны", rarity = "Rare", fairPrice = 12500, spawnChance = 14, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=16218939447"},
	{name = "Palm Angels Классик", rarity = "Rare", fairPrice = 12000, spawnChance = 14, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=18660217262"},
	{name = "Palm Angels Серые", rarity = "Rare", fairPrice = 12000, spawnChance = 14, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=10468675774"},
	{name = "Stone Island Default", rarity = "Rare", fairPrice = 14500, spawnChance = 14, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=15177463491"},
	{name = "Nike Tech Pants", rarity = "Rare", fairPrice = 3200, spawnChance = 12, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=11410851428"},
	{name = "Stussy Nylon Pants", rarity = "Rare", fairPrice = 4000, spawnChance = 12, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=9367316386"},
	{name = "Supreme Pants", rarity = "Rare", fairPrice = 6500, spawnChance = 12, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=7092331502"},
	{name = "Гоша Рубчинский Base", rarity = "Rare", fairPrice = 9500, spawnChance = 12, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=15056443107"},
	{name = "CP.Company Default Pants", rarity = "Rare", fairPrice = 12500, spawnChance = 12, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=6664977414"},
	{name = "Stone Island Joggers", rarity = "Rare", fairPrice = 16500, spawnChance = 11, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=83460274043697"},
	{name = "Gallery Dept Спортивки Серые", rarity = "Rare", fairPrice = 4200, spawnChance = 8, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=12792854120"},
	{name = "Gallery Dept Спортивки Голубой", rarity = "Rare", fairPrice = 4200, spawnChance = 8, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=92372331673725"},
	{name = "CP.Company Gray Pants", rarity = "Rare", fairPrice = 19500, spawnChance = 8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=15783604615"},
	{name = "Nike Air Pants", rarity = "Rare", fairPrice = 4200, spawnChance = 7, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=14343129813"},
	{name = "Nenet Штаны", rarity = "Rare", fairPrice = 3800, spawnChance = 6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=126614167471817"},
	{name = "CP.Company Short Yellow", rarity = "Rare", fairPrice = 16000, spawnChance = 6, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=13476230863"},
	{name = "Designer джинсы", rarity = "Rare", fairPrice = 1400, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=18391375923"},
	{name = "CP.Company Blue Pants", rarity = "Rare", fairPrice = 21000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=14050651141"},
	{name = "Gallery Dept Спортивки Розовая", rarity = "Rare", fairPrice = 6500, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=80485661963807"},
	{name = "Gallery Dept Спортивки Бежевый", rarity = "Rare", fairPrice = 6500, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=103986963611679"},
	-- Epic
	{name = "Chrome Hearts Logo White", rarity = "Epic", fairPrice = 24000, spawnChance = 15, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=14502536733"},
	{name = "Maison Margiela Светлые Джинсы", rarity = "Epic", fairPrice = 45000, spawnChance = 15, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=137387299352418"},
	{name = "Prada Cargo", rarity = "Epic", fairPrice = 42000, spawnChance = 15, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=8425198346"},
	{name = "Rick Drkshdw Pants", rarity = "Epic", fairPrice = 38000, spawnChance = 12, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=12517077376"},
	{name = "LV Jeans", rarity = "Epic", fairPrice = 34000, spawnChance = 10, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=15292591723"},
	{name = "Gucci shorts x Blue Lubz", rarity = "Epic", fairPrice = 36000, spawnChance = 8, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=5634486962"},
	{name = "Rick Owens Джинсы Зип", rarity = "Epic", fairPrice = 45000, spawnChance = 8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=91026451304170"},
	{name = "Moncler Tech Pants", rarity = "Epic", fairPrice = 28000, spawnChance = 8, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=11382056472"},
	{name = "Acne Studios Jeans", rarity = "Epic", fairPrice = 22000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=8425198346"},
	{name = "Rick Owens Штаны X Champion", rarity = "Epic", fairPrice = 55000, spawnChance = 5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=105899121032942"},
	{name = "Moncler Classic Pants", rarity = "Epic", fairPrice = 34000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=78578971457655"},
	{name = "Stone Island Gray Pants", rarity = "Epic", fairPrice = 28000, spawnChance = 4.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=13781107731"},
	{name = "Goyard Джинсы", rarity = "Epic", fairPrice = 55000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=1226570796"},
	{name = "Goyard Джинсы v2", rarity = "Epic", fairPrice = 58000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=993568642"},
	{name = "HBA Face Шорты", rarity = "Epic", fairPrice = 14000, spawnChance = 2, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=18588053300"},
	{name = "Nike Tech Blue", rarity = "Epic", fairPrice = 6500, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=12757775209"},
	{name = "Gallery Dept Спортивки Серые v2", rarity = "Epic", fairPrice = 9000, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=84143282861081"},
	{name = "BAPE Hellstar", rarity = "Epic", fairPrice = 12500, spawnChance = 1.2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=15059936385"},
	-- Legendary
	{name = "ERD Потёртые Джинсы v1", rarity = "Legendary", fairPrice = 55000, spawnChance = 14, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=134667894646939"},
	{name = "Number(N)ine Черные Джинсы", rarity = "Legendary", fairPrice = 55000, spawnChance = 14, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=18323948073"},
	{name = "Vetements Джинсы Потёртые", rarity = "Legendary", fairPrice = 20000, spawnChance = 14, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=140407383932406"},
	{name = "Vetements Спортивки Белые", rarity = "Legendary", fairPrice = 16000, spawnChance = 14, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=76125724763039"},
	{name = "Chrome Hearts Sweats Black", rarity = "Legendary", fairPrice = 38000, spawnChance = 10, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=104233925082759"},
	{name = "Vetements Спортивки Черные", rarity = "Legendary", fairPrice = 16000, spawnChance = 10, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=83309274927695"},
	{name = "Vetements Синие-Джинсы Потёртые", rarity = "Legendary", fairPrice = 24000, spawnChance = 10, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=119701709069263"},
	{name = "Raf Simons Replicant Черный", rarity = "Legendary", fairPrice = 62000, spawnChance = 6, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=130901526860219"},
	{name = "Yohji Yamamoto Брюки", rarity = "Legendary", fairPrice = 78000, spawnChance = 5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=18606916273"},
	{name = "Balenciaga Jeans", rarity = "Legendary", fairPrice = 38000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=106747850464319"},
	{name = "Chrome Hearts Jeans", rarity = "Legendary", fairPrice = 38000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=15696366766"},
	{name = "ERD Потёртые Джинсы v2", rarity = "Legendary", fairPrice = 8000, spawnChance = 5, economyProfile = "safe", templateId = "http://www.roblox.com/asset/?id=121920454802593"},
	{name = "Raf Simons Antei Purple", rarity = "Legendary", fairPrice = 48000, spawnChance = 5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=90331150141619"},
	{name = "Number(N)ine Потёртые Джинсы", rarity = "Legendary", fairPrice = 42000, spawnChance = 5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=74773415025845"},
	{name = "Chrome Hearts Grey Jeans", rarity = "Legendary", fairPrice = 42000, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=138849171597664"},
	{name = "Chrome Hearts Blue Jeans", rarity = "Legendary", fairPrice = 42000, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=7136404055"},
	{name = "Chrome Hearts Gray Denim Jeans", rarity = "Legendary", fairPrice = 38000, spawnChance = 4, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=16733661093"},
	{name = "Chrome Hearts Multi Color Cargos", rarity = "Legendary", fairPrice = 52000, spawnChance = 3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=16430470261"},
	{name = "Chrome Hearts Pink-Black Jeans", rarity = "Legendary", fairPrice = 45000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=10946069856"},
	{name = "Chrome Hearts Blue Jeans Chrome", rarity = "Legendary", fairPrice = 24000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=7902431224"},
	{name = "Chrome Hearts X LV Jeans", rarity = "Legendary", fairPrice = 42000, spawnChance = 3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=7248675948"},
	{name = "Chrome Hearts Red And Blue", rarity = "Legendary", fairPrice = 28000, spawnChance = 3, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=9026168961"},
	{name = "Raf Simons Ozweego Metallic Pink", rarity = "Legendary", fairPrice = 58000, spawnChance = 3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=94733727431242"},
	{name = "Raf Simons Ozweego 3 Black Scarlett", rarity = "Legendary", fairPrice = 68000, spawnChance = 3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=111846279148302"},
	{name = "Raf Simons Ozweego 3 Bunny Cream", rarity = "Legendary", fairPrice = 65000, spawnChance = 3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=126634936837558"},
	{name = "Maison Margiela Темные Джинсы", rarity = "Legendary", fairPrice = 49000, spawnChance = 3, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=110732769471130"},
	{name = "Balenciaga Grey Skater Sweatpants", rarity = "Legendary", fairPrice = 45000, spawnChance = 2.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=126517779663023"},
	{name = "Balenciaga Blue Skater Sweatpants", rarity = "Legendary", fairPrice = 45000, spawnChance = 2.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=91597530501326"},
	{name = "Balenciaga Red Skater Sweatpants", rarity = "Legendary", fairPrice = 45000, spawnChance = 2.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=15732426795"},
	{name = "Chrome Hearts Red Jeans", rarity = "Legendary", fairPrice = 45000, spawnChance = 2.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=15167782987"},
	{name = "Stone Island Navy", rarity = "Legendary", fairPrice = 34000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=831537196"},
	{name = "LV Balmains", rarity = "Legendary", fairPrice = 72000, spawnChance = 2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=967030312"},
	{name = "Balenciaga Under Armor", rarity = "Legendary", fairPrice = 52000, spawnChance = 2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=80892498626861"},
	{name = "Rick Owens Джинсы Розовые", rarity = "Legendary", fairPrice = 85000, spawnChance = 2, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=107120598536058"},
	{name = "Chrome Hearts Orange Pants", rarity = "Legendary", fairPrice = 48000, spawnChance = 2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=7548737350"},
	{name = "Moncler Red Tracksuit Bottom", rarity = "Legendary", fairPrice = 36000, spawnChance = 2, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=6488509541"},
	{name = "Raf Simons Ultrasceptre Black", rarity = "Legendary", fairPrice = 65000, spawnChance = 2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=75557197142540"},
	{name = "Raf Simons Ozweego 2 Yellow Navy", rarity = "Legendary", fairPrice = 58000, spawnChance = 2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=92971638700357"},
	{name = "Raf Simons Cylon 21 Red", rarity = "Legendary", fairPrice = 70000, spawnChance = 2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=137535052172555"},
	{name = "Moncler Black Tracksuit Bottom", rarity = "Legendary", fairPrice = 42000, spawnChance = 1.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=15338842140"},
	{name = "Raf Simons Ozweego 2 Khaki Gold", rarity = "Legendary", fairPrice = 120000, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=111916884328976"},
	{name = "Raf Simons Ozweego 2 Gray Green", rarity = "Legendary", fairPrice = 68000, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=106963684303925"},
	{name = "Raf Simons Ozweego 2 Blue Red Lucora", rarity = "Legendary", fairPrice = 75000, spawnChance = 1.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=74807243654778"},
	{name = "Rick Leather", rarity = "Legendary", fairPrice = 125000, spawnChance = 1, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=113528327971525"},
	{name = "Chrome Hearts Rolling Stones", rarity = "Legendary", fairPrice = 72000, spawnChance = 1, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=76648512722512"},
	{name = "Raf Simons Ozweego Replicant Green", rarity = "Legendary", fairPrice = 62000, spawnChance = 1, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=72166817530697"},
	{name = "Raf Simons Ozweego Replicant Brown", rarity = "Legendary", fairPrice = 58000, spawnChance = 1, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=90321397681781"},
	{name = "Supreme x BB", rarity = "Legendary", fairPrice = 28000, spawnChance = 0.8, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=13444831655"},
	{name = "Moncler X PA Trackpants", rarity = "Legendary", fairPrice = 52000, spawnChance = 0.8, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=5459824215"},
	{name = "BAPE Tiger Штаны Синие", rarity = "Legendary", fairPrice = 24000, spawnChance = 0.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=136214158712256"},
	{name = "BAPE Tiger Штаны Красные", rarity = "Legendary", fairPrice = 24000, spawnChance = 0.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=91431686212610"},
	{name = "Гоша Рубчинский x Kappa", rarity = "Legendary", fairPrice = 38000, spawnChance = 0.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=884721412"},
	{name = "Stone Island Desert Camo", rarity = "Legendary", fairPrice = 52000, spawnChance = 0.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=8631687937"},
	{name = "Racer Worldwide Светлые Джинсы", rarity = "Legendary", fairPrice = 18000, spawnChance = 0.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=116384868903033"},
	{name = "Racer Worldwide Спортивные Штаны", rarity = "Legendary", fairPrice = 18000, spawnChance = 0.5, economyProfile = "normal", templateId = "http://www.roblox.com/asset/?id=97856540262333"},
	{name = "SS04 Yohji Yamamoto Y-3 x 3S Spotted Джинсы", rarity = "Legendary", fairPrice = 85000, spawnChance = 0.5, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=82141496081351"},
	{name = "Zapatillas Gucci X Amiri", rarity = "Legendary", fairPrice = 110000, spawnChance = 0.5, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=70522682896000"},
	{name = "Balenciaga Gamer Jeans", rarity = "Legendary", fairPrice = 95000, spawnChance = 0.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=14072460151"},
	{name = "Chrome Hearts Ryft Davis", rarity = "Legendary", fairPrice = 85000, spawnChance = 0.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=135762991942060"},
	{name = "Moncler X PA Blue Tracksuit Bot", rarity = "Legendary", fairPrice = 58000, spawnChance = 0.5, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=12636365033"},
	{name = "ERD x Rick Owens Джинсы", rarity = "Legendary", fairPrice = 140000, spawnChance = 0.5, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=96427517504184"},
	{name = "ERD Красные Джинсы", rarity = "Legendary", fairPrice = 145000, spawnChance = 0.5, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=105784899081783"},
	{name = "BAPE Tiger Штаны Темно-Зелен", rarity = "Legendary", fairPrice = 26000, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=105050054678663"},
	{name = "CP.Company Orange Pants", rarity = "Legendary", fairPrice = 48000, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=16974632350"},
	{name = "Racer Worldwide Металлик Спортивные Штаны", rarity = "Legendary", fairPrice = 34000, spawnChance = 0.4, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=83178088059705"},
	{name = "Moncler X PA Forest Green Bot", rarity = "Legendary", fairPrice = 60000, spawnChance = 0.3, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=12621050748"},
	{name = "Moncler X PA FG Tracksuit Bot", rarity = "Legendary", fairPrice = 62000, spawnChance = 0.3, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=12621049069"},
	{name = "Palm Angels Диолетовые", rarity = "Legendary", fairPrice = 62000, spawnChance = 0.25, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=9084664817"},
	{name = "Stone Island WATRO-TC", rarity = "Legendary", fairPrice = 68000, spawnChance = 0.25, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=8631779021"},
	{name = "Burberry x Bape", rarity = "Legendary", fairPrice = 68000, spawnChance = 0.2, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=13868676194"},
	{name = "Racer Worldwide Трансформ Зип Джинсы", rarity = "Legendary", fairPrice = 48000, spawnChance = 0.15, economyProfile = "risky", templateId = "http://www.roblox.com/asset/?id=124770374642522"},
	{name = "Balenciaga NASA", rarity = "Legendary", fairPrice = 140000, spawnChance = 0.1, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=108319716834601"},
	{name = "ERD Archive Trousers", rarity = "Legendary", fairPrice = 220000, spawnChance = 0.1, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=18391375923"},
	{name = "Raf Simons LSD White", rarity = "Legendary", fairPrice = 225000, spawnChance = 0.1, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=81190837714692"},
	{name = "BAPE Tiger Штаны Диолетовые", rarity = "Legendary", fairPrice = 38000, spawnChance = 0.08, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=126486170842278"},
	{name = "Stone Island Purple Skin Touch", rarity = "Legendary", fairPrice = 85000, spawnChance = 0.08, economyProfile = "trap", templateId = "http://www.roblox.com/asset/?id=13779001394"},
	{name = "Гоша Рубчинский Рождест", rarity = "Legendary", fairPrice = 62000, spawnChance = 0.06, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=11796928274"},
	{name = "Raf Simons 2-CB GHB Patchwork", rarity = "Legendary", fairPrice = 270000, spawnChance = 0.05, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=84894983746398"},
	{name = "Palm Angels x Raf Blue Red", rarity = "Legendary", fairPrice = 110000, spawnChance = 0.02, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=102649937877868"},
	{name = "Stone Island x Supreme White", rarity = "Legendary", fairPrice = 115000, spawnChance = 0.01, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=112790132457513"},
	{name = "Stone Island x Supreme", rarity = "Legendary", fairPrice = 115000, spawnChance = 0.01, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=116321915070400"},
	{name = "Balenciaga Leather", rarity = "Legendary", fairPrice = 320000, spawnChance = 0.01, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=127906814275652"},
	{name = "Stone Island Big Loom Camo-Tc", rarity = "Legendary", fairPrice = 280000, spawnChance = 0.005, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=8631708414"},
	{name = "Raf Simons Pharaxus Green Black", rarity = "Legendary", fairPrice = 680000, spawnChance = 0.005, economyProfile = "jackpot", templateId = "http://www.roblox.com/asset/?id=74621497123361"},
}

-- ============================================
-- ДОБАВЛЯЕМ ВСЕ В БАЗУ
-- ============================================
AddItems(ShirtData, "Shirt")
AddItems(PantsData, "Pants")

-- ============================================
-- MESH
-- ============================================
ITEM_DATABASE["74310436963141"] = {
	name = "Legendary Item Name",
	rarity = "Legendary",
	fairPrice = 25000,
	spawnChance = 18,
	economyProfile = "risky",
	type = "Mesh",
	fullId = "rbxassetid://74310436963141"
}

-- ============================================
-- ЦВЕТА
-- ============================================
local RARITY_COLORS = {
	Common = Color3.fromRGB(128, 128, 128),
	Uncommon = Color3.fromRGB(0, 176, 80),
	Rare = Color3.fromRGB(0, 112, 221),
	Epic = Color3.fromRGB(163, 53, 238),
	Legendary = Color3.fromRGB(255, 170, 0)
}

local RARITY_COLORS_HEX = {
	Common = "808080",
	Uncommon = "00B050",
	Rare = "0070DD",
	Epic = "A335EE",
	Legendary = "FFAA00"
}

local ECONOMY_COLORS_HEX = {
	safe = "00FF00",
	moderate = "FFFF00",
	risky = "FF0000",
	normal = "00BFFF",
	trap = "FF4500",
	jackpot = "FF1493"
}

-- ============================================
-- GUI
-- ============================================
local espScreenGui = Instance.new("ScreenGui")
espScreenGui.Name = "ItemESP"
espScreenGui.ResetOnSpawn = false
espScreenGui.IgnoreGuiInset = true
espScreenGui.Parent = PlayerGui

local CachedItems = {}
local HRP = nil
local scanning = false
local lastWasOpens = false

-- ============================================
-- ОПТИМИЗАЦИЯ: кэш магазинов
-- ============================================
local ShopCache = nil

local function GetShops()
	if ShopCache then return ShopCache end
	ShopCache = {}
	for _, shop in ipairs(workspace:GetChildren()) do
		if shop:IsA("Model") and shop.Name:match("^Shop_ShopZone_%d+$") then
			table.insert(ShopCache, shop)
		end
	end
	return ShopCache
end

-- ============================================
-- ФУНКЦИИ
-- ============================================
local function getHRP()
	if not HRP or not HRP.Parent then
		local char = player.Character
		if char then
			HRP = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char.PrimaryPart
		end
	end
	return HRP
end

local function getObjPosition(obj)
	if obj:IsA("Model") then
		local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
		if primary then return primary.Position end
	elseif obj:IsA("BasePart") then
		return obj.Position
	end
	return nil
end

-- ============================================
-- ИСПРАВЛЕННАЯ ФУНКЦИЯ checkMatch
-- ============================================
local function checkMatch(clothing)
	if not clothing then return false, nil end
	
	local template = nil
	if clothing:IsA("Shirt") then
		template = clothing.ShirtTemplate
	elseif clothing:IsA("Pants") then
		template = clothing.PantsTemplate
	else
		return false, nil
	end
	
	if template then
		local id = template:match("rbxassetid://(%d+)")
		if id then
			local data = ITEM_DATABASE[id]
			if data then
				return true, data
			end
		end
	end
	
	return false, nil
end

-- ============================================
-- СОЗДАНИЕ МЕТКИ (С МИНИМАЛЬНЫМ UIStroke)
-- ============================================
local function CreateLabel(adornee, itemData)
	if not adornee then return end
	if CachedItems[adornee] then return end
	
	-- Пропускаем Common и Uncommon
	if itemData.rarity == "Common" or itemData.rarity == "Uncommon" then
		return
	end
	
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamBold
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.RichText = true
	label.AnchorPoint = Vector2.new(0.5, 1)
	label.AutomaticSize = Enum.AutomaticSize.XY
	label.Visible = false
	label.Parent = espScreenGui
	
	-- МИНИМАЛЬНЫЙ UIStroke (толщина 1, прозрачность 0.3)
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 1
	stroke.Color = Color3.fromRGB(0, 0, 0)
	stroke.Transparency = 0  -- Почти прозрачный, но читаемость сохраняется
	stroke.Parent = label
	
	CachedItems[adornee] = {
		Data = itemData,
		Label = label,
		Object = adornee,
		LastText = "",
		CachedPosition = nil,
		LastUpdateTime = 0
	}
	
	return label
end

-- ============================================
-- СКАН (ПО ЧАСТЯМ)
-- ============================================
local function ScanShopsBatch()
	if scanning then return end
	scanning = true
	
	local shops = GetShops()
	local allSlots = {}
	local totalItems = 0
	
	-- Собираем все слоты
	for _, shop in ipairs(shops) do
		local itemSlots = shop:FindFirstChild("ItemSlots")
		if itemSlots then
			for _, slot in ipairs(itemSlots:GetChildren()) do
				if slot:IsA("BasePart") and slot.Name:match("^Slot_%d+$") then
					table.insert(allSlots, slot)
				end
			end
		end
		
		-- Mesh предметы
		for _, obj in ipairs(shop:GetChildren()) do
			if obj:IsA("Model") and obj.Name:match("^M_%d+$") then
				local mesh = obj:FindFirstChildWhichIsA("MeshPart", true)
				if mesh then
					local id = mesh.MeshId:match("rbxassetid://(%d+)")
					if id then
						local data = ITEM_DATABASE[id]
						if data and data.type == "Mesh" and data.rarity ~= "Common" and data.rarity ~= "Uncommon" then
							CreateLabel(mesh, data)
							totalItems += 1
						end
					end
				end
			end
		end
	end
	
	-- Сканируем слотами (по 5 за раз)
	local batchSize = 5
	local currentBatch = 1
	
	local function ProcessBatch()
		local startIdx = (currentBatch - 1) * batchSize + 1
		local endIdx = math.min(startIdx + batchSize - 1, #allSlots)
		
		if startIdx > #allSlots then
			scanning = false
			print("===== СКАНИРОВАНИЕ ЗАВЕРШЕНО =====")
			print("Найдено предметов:", totalItems)
			return
		end
		
		for i = startIdx, endIdx do
			local slot = allSlots[i]
			local mannequin = slot:FindFirstChild("Mannequin")
			if mannequin then
				local clothing = mannequin:FindFirstChild("Clothing")
				local matched, itemData = checkMatch(clothing)
				if matched and itemData then
					local adornee = mannequin:FindFirstChild("Head") or mannequin.PrimaryPart or slot
					CreateLabel(adornee, itemData)
					totalItems += 1
				end
			end
		end
		
		currentBatch += 1
		task.wait(0.1)
		task.spawn(ProcessBatch)
	end
	
	ProcessBatch()
end

-- ============================================
-- ОПТИМИЗИРОВАННАЯ ОТРИСОВКА ESP
-- ============================================
local frameCounter = 0
local UPDATE_INTERVAL = 40

RunService.RenderStepped:Connect(function()
	frameCounter = frameCounter + 1
	if frameCounter % UPDATE_INTERVAL ~= 0 then return end
	
	local hrp = getHRP()
	if not hrp then return end
	
	local hrpPos = hrp.Position
	
	for obj, cData in pairs(CachedItems) do
		-- Проверяем существование объекта
		if not obj or not obj.Parent then
			if cData.Label then cData.Label:Destroy() end
			CachedItems[obj] = nil
			continue
		end
		
		local itemData = cData.Data
		if not itemData then continue end
		
		-- Получаем позицию (с кэшем)
		local position = cData.CachedPosition
		if not position then
			position = getObjPosition(obj)
			cData.CachedPosition = position
		end
		
		if not position then
			cData.Label.Visible = false
			continue
		end
		
		-- СНАЧАЛА проверяем дистанцию (400)
		local dist = (hrpPos - position).Magnitude
		if dist > 400 then
			cData.Label.Visible = false
			continue
		end
		
		-- ПОТОМ WorldToViewportPoint
		local pos2d, onScreen = Camera:WorldToViewportPoint(position)
		
		-- Culling - проверяем видимость на экране
		if not onScreen or pos2d.Z <= 0 then
			cData.Label.Visible = false
			continue
		end
		
		-- Вычисляем смещение по Y
		local yOffset = 0
		if obj:IsA("Model") then
			local success, size = pcall(function() return obj:GetExtentsSize() end)
			if success then yOffset = size.Y / 2 + 1 end
		elseif obj:IsA("BasePart") then
			yOffset = obj.Size.Y / 2 + 0.5
		end
		
		local topPos = Camera:WorldToViewportPoint(position + Vector3.new(0, yOffset, 0))
		
		-- Формируем текст
		local rarityHex = RARITY_COLORS_HEX[itemData.rarity] or "FFFFFF"
		local economyColor = ECONOMY_COLORS_HEX[itemData.economyProfile] or "FFFFFF"
		
		local parts = {
			string.format('<font color="#00FF64">$%s</font>', tostring(itemData.fairPrice or 0)),
			string.format('<font color="#FFD700">Шанс: %s%%</font>', tostring(itemData.spawnChance or 0)),
			string.format('<font color="#%s">[%s]</font>', economyColor, string.upper(itemData.economyProfile or "SAFE")),
			string.format('<font color="#FFFFFF">%s</font>', itemData.name or "Неизвестно"),
			string.format('<font color="#B4B4B4">[%d st]</font>', math.floor(dist)),
			string.format('<font color="#%s">%s</font>', rarityHex, string.upper(itemData.rarity or "COMMON"))
		}
		
		local newText = table.concat(parts, "\n")
		
		-- Проверяем изменение текста
		if cData.LastText ~= newText then
			cData.Label.Text = newText
			cData.LastText = newText
		end
		
		-- Позиционируем лейбл
		cData.Label.Position = UDim2.new(0, topPos.X, 0, topPos.Y - 5)
		cData.Label.ZIndex = math.floor(10000 - pos2d.Z * 10)
		cData.Label.Visible = true
	end
end)

-- ============================================
-- РЕСТОК
-- ============================================
local label = player:WaitForChild("PlayerGui"):WaitForChild("ShopTimerGUI"):WaitForChild("TimerLabel")

label:GetPropertyChangedSignal("Text"):Connect(function()
	local text = label.Text
	if text:find("Opens") and not lastWasOpens then
		lastWasOpens = true
		print("")
		task.delay(1.5, function() 
			ShopCache = nil
			-- Очищаем старые лейблы
			for obj, cData in pairs(CachedItems) do
				if cData.Label then cData.Label:Destroy() end
			end
			CachedItems = {}
			ScanShopsBatch() 
		end)
	elseif text:find("Restock") then
		lastWasOpens = false
	end
end)

-- ============================================
-- СТАРТ
-- ============================================
task.wait(2)
print("")
ScanShopsBatch()
