--never lose v0.1

do
	local Constant = 'L'..'P'..'H'..'_NO_VIRTUALIZE';
	getfenv()[Constant] = getfenv()[Constant] or function(f) return f end;
end;

cloneref = cloneref or function(i) return i end;
gethui = gethui or get_hidden_gui;
getcustomasset = getcustomasset or getsynasset;
getgenv = getgenv or getfenv;

local LOAD_ENV = LPH_NO_VIRTUALIZE(function()
	if game:GetService('RunService'):IsStudio() then
		local BaseWorkspace = game:GetService("ReplicatedFirst"):FindFirstChild('PRI_WORKSPACE') or Instance.new('Folder',game:GetService("ReplicatedFirst"));

		BaseWorkspace.Name = 'PRI\0.'..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)))..tostring(string.char(math.random(50,120)));

		local __get_path_c = function(path)
			return (string.find(path,'/',1,true) and string.split(path,'/')) or (string.find(path,'\\',1,true) and string.split(path,'\\')) or {path};
		end;

		local __get_path = function(path)
			local main = __get_path_c(path);

			local block = BaseWorkspace;

			for i,v in next , main do
				block = block[v];
			end;

			return block;
		end;

		getgenv().readfile = function(path)
			local path : StringValue = __get_path(path);

			return path.Value;
		end;

		getgenv().isfile = function(path)
			local success , message = pcall(function()
				return __get_path(path);
			end);

			if success and not message:IsA("Folder") then
				return true;
			end;

			return false;
		end;

		getgenv().isfolder = function(path)
			local success , message = pcall(function()
				return __get_path(path);
			end);

			if success and message:IsA("Folder") then
				return true;
			end;

			return false;
		end;

		getgenv().writefile = function(path,content)
			local main = __get_path_c(path);

			local block = BaseWorkspace;

			for i,v in next , main do
				local item = block:FindFirstChild(v);
				if not item then
					local c = Instance.new('StringValue',block);

					c.Name = tostring(v);
					c.Value = content;
				else
					if item:IsA('StringValue') and tostring(item) == v then
						item.Name = tostring(v);
						item.Value = content;
					end;

					block = item;
				end;
			end;
		end;

		getgenv().listfiles = function(path)
			local fold = __get_path(path);
			local pa = {};

			for i,v in next , fold:GetChildren() do
				if v:IsA('StringValue') then
					table.insert(pa,path..'/'..tostring(v));
				end;
			end;

			return pa;
		end;

		getgenv().makefolder = function(path)
			local main = __get_path_c(path);

			local block = BaseWorkspace;

			for i,v in next , main do
				local item = block:FindFirstChild(v);
				if not item then
					local c = Instance.new('Folder',block);

					c.Name = tostring(v);
				else
					block = item;
				end;
			end;
		end;

		getgenv().delfile = function(path)
			local main = __get_path_c(path);

			local block = BaseWorkspace;

			for i,v in next , main do
				local item = block:FindFirstChild(v);
				if item and item:IsA('StringValue') then
					item:Destroy();
				else
					block = item;
				end;
			end;
		end;
	end;
end)

LOAD_ENV();

writefile = writefile or getgenv().writefile;
makefolder = makefolder or getgenv().makefolder;
readfile = readfile or getgenv().readfile;
delfolder = delfolder or getgenv().delfolder;
delfile = delfile or getgenv().delfile;
listfiles = listfiles or getgenv().listfiles;
isfolder = isfolder or getgenv().isfolder;
isfile = isfile or getgenv().isfile;

local NeverLose = {};

NeverLose.BuiltInRegular = Font.new('rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json',Enum.FontWeight.Regular,Enum.FontStyle.Normal);
NeverLose.BuiltInBold = Font.new('rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json',Enum.FontWeight.Bold,Enum.FontStyle.Normal);
NeverLose.GlobalSignals = {};
NeverLose.UnloadEnabled = false;

local cloneref: cloneref = cloneref or function(f) return f end;
local TweenService: TweenService = cloneref(game:GetService('TweenService'));
local UserInputService: UserInputService = cloneref(game:GetService('UserInputService'));
local TextService: TextService = cloneref(game:GetService('TextService'));
local RunService: RunService = cloneref(game:GetService('RunService'));
local Players: Players = cloneref(game:GetService('Players'));
local HttpService: HttpService = cloneref(game:GetService('HttpService'));
local LocalPlayer: Player = Players.LocalPlayer;
local CoreGui: PlayerGui = (gethui and gethui()) or (get_hidden_gui and get_hidden_gui()) or cloneref(game:FindFirstChild('CoreGui')) or cloneref(LocalPlayer.PlayerGui);
local Mouse: Mouse = LocalPlayer:GetMouse();
local CurrentCamera: Camera = cloneref(workspace.CurrentCamera);
local ProtectGui = protect_gui or protectgui or (syn and syn.protect_gui) or function(s) return s; end;
local GlobalWindow = Instance.new('ScreenGui');
local ManualTween = TweenInfo.new(0.1);
local SlowyTween = TweenInfo.new(0.175);
local FastTween = TweenInfo.new(0.05);
local VSlowTween = TweenInfo.new(0.5,Enum.EasingStyle.Quint);
local Encryption = {};

NeverLose.UserProfile = Players:GetUserThumbnailAsync(LocalPlayer.UserId , Enum.ThumbnailType.HeadShot , Enum.ThumbnailSize.Size150x150)
NeverLose.RandomString = LPH_NO_VIRTUALIZE(function()
	return string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4))..string.rep(string.char(math.random(1,7)),math.random(1,4));
end);

ProtectGui(GlobalWindow);

GlobalWindow.Name = NeverLose.RandomString();
GlobalWindow.IgnoreGuiInset = true;
GlobalWindow.ZIndexBehavior = Enum.ZIndexBehavior.Global;
GlobalWindow.ResetOnSpawn = false;
GlobalWindow.Parent = CoreGui;

NeverLose.Scales = {
	Small = UDim2.fromOffset(540,380),
	Mobile = UDim2.fromOffset(640,385),
	Default = UDim2.fromOffset(640 , 480),
	Large = UDim2.fromOffset(800 , 600)
};

NeverLose.IconColor = Color3.fromRGB(255, 255, 255);
NeverLose.ScreenGui = GlobalWindow;
NeverLose.Flags = {};
NeverLose.AccentColor = Color3.fromRGB(78, 127, 252);
NeverLose.MainColor = Color3.fromRGB(19, 19, 21);
NeverLose.RegisiteryColor = {};
NeverLose.NameRegisitry = {};
NeverLose.IsMosueOverOtherFrame = false;
NeverLose.GlobalLogo = "nil";
NeverLose.ImageColorMapping = "nil";

if getcustomasset then
	local link = "https://github.com/4lpaca-pin/NeverLose/blob/main/assets/%s?raw=true";
	local dir = 'NLAssets';

	if not isfolder(dir) then
		makefolder(dir);
	end;

	

	pcall(function()
		if not isfile(dir..'/'..'saturation_value_gradient.png') then
			local byte = game:HttpGet(string.format(link,'saturation_value_gradient.png'));

			writefile(dir..'/'..'saturation_value_gradient.png' , byte);
			task.wait();
		end;

		if isfile(dir..'/'..'saturation_value_gradient.png') then
			NeverLose.ImageColorMapping = getcustomasset(dir..'/'..'saturation_value_gradient.png')
		end;
	end);
end;

function NeverLose:AddSignal(RBXSignal)
	if NeverLose.UnloadEnabled then
		table.insert(NeverLose.GlobalSignals,RBXSignal);
	end;

	return RBXSignal;
end;

function NeverLose:AddQuery(ItemRoot: Frame , Name : string)
	table.insert(NeverLose.NameRegisitry , {
		Root = ItemRoot,
		Idx = Name,
	});
end;

function Encryption.new(data: string)
	local bytes = {};
	local encrypt_seed = ((#data + 3782) % 111) + 1;

	string.gsub(data , '.', LPH_NO_VIRTUALIZE(function(dt)
		table.insert(bytes , tostring(dt:byte() + encrypt_seed));
	end));

	local concatbyte = table.concat(bytes,'?');

	table.clear(bytes);

	return "{"..tostring(encrypt_seed + 72667).."}?"..concatbyte;
end;

function Encryption.reverse(data: string)
	local main_data = string.split(data,'?');
	local seed_str = main_data[1]:gsub('{',''):gsub('}','');
	local seed = tonumber(seed_str);

	local ks = {};
	local real_seed = seed - 72667;

	for i,v in next , main_data do
		if i > 1 then
			local fake_byte = tonumber(v);
			table.insert(ks , string.char(fake_byte - real_seed))	
		end;
	end;

	local data = table.concat(ks);

	table.clear(ks);

	return data;
end;

do
	local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

	NeverLose.Base64Encode = LPH_NO_VIRTUALIZE(function(data)
		return ((data:gsub('.', function(x) 
			local r,b='',x:byte()
			for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
			return r;
		end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
			if (#x < 6) then return '' end
			local c=0
			for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
			return b:sub(c+1,c+1)
		end)..({ '', '==', '=' })[#data%3+1])
	end);

	NeverLose.Base64Decode = LPH_NO_VIRTUALIZE(function(data)
		data = string.gsub(data, '[^'..b..'=]', '')
		return (data:gsub('.', function(x)
			if (x == '=') then return '' end
			local r,f='',(b:find(x)-1)
			for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
			return r;
		end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
			if (#x ~= 8) then return '' end
			local c=0
			for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
			return string.char(c)
		end))
	end);
end;

NeverLose.LoadIcon = LPH_NO_VIRTUALIZE(function()
	NeverLose.RobloxIcon = {
		["3d-cube-arrow-left"] = "3d-cube-arrow-left",
		["amazon"] = "amazon",
		["arm-left"] = "arm-left",
		["arm-right"] = "arm-right",
		["arrow-curl-to-left"] = "arrow-curl-to-left",
		["arrow-curl-to-right"] = "arrow-curl-to-right",
		["arrow-down-to-line"] = "arrow-down-to-line",
		["arrow-large-down"] = "arrow-large-down",
		["arrow-large-left"] = "arrow-large-left",
		["arrow-large-right"] = "arrow-large-right",
		["arrow-large-up"] = "arrow-large-up",
		["arrow-right-from-portrait-rectangle"] = "arrow-right-from-portrait-rectangle",
		["arrow-right-to-portrait-rectangle"] = "arrow-right-to-portrait-rectangle",
		["arrow-rotate-down-dashed"] = "arrow-rotate-down-dashed",
		["arrow-rotate-right"] = "arrow-rotate-right",
		["arrow-rotate-right-dashed"] = "arrow-rotate-right-dashed",
		["arrow-small-down"] = "arrow-small-down",
		["arrow-small-left"] = "arrow-small-left",
		["arrow-small-right"] = "arrow-small-right",
		["arrow-small-up"] = "arrow-small-up",
		["arrow-spin-clockwise"] = "arrow-spin-clockwise",
		["arrow-spin-clockwise-10"] = "arrow-spin-clockwise-10",
		["arrow-spin-clockwise-15"] = "arrow-spin-clockwise-15",
		["arrow-spin-clockwise-30"] = "arrow-spin-clockwise-30",
		["arrow-spin-counter-clockwise-10"] = "arrow-spin-counter-clockwise-10",
		["arrow-spin-counter-clockwise-15"] = "arrow-spin-counter-clockwise-15",
		["arrow-spin-counter-clockwise-30"] = "arrow-spin-counter-clockwise-30",
		["arrow-thick-to-left"] = "arrow-thick-to-left",
		["arrow-thick-to-right"] = "arrow-thick-to-right",
		["arrow-up-from-landscape-rectangle"] = "arrow-up-from-landscape-rectangle",
		["arrow-up-right-from-square"] = "arrow-up-right-from-square",
		["arrow-wide-short-down"] = "arrow-wide-short-down",
		["arrow-wide-short-left"] = "arrow-wide-short-left",
		["arrow-wide-short-right"] = "arrow-wide-short-right",
		["arrow-wide-short-up"] = "arrow-wide-short-up",
		["arrows-small-directional"] = "arrows-small-directional",
		["audio-wave-dotted-line"] = "audio-wave-dotted-line",
		["backpack"] = "backpack",
		["beard"] = "beard",
		["bell"] = "bell",
		["bell-clock"] = "bell-clock",
		["bell-plus"] = "bell-plus",
		["bell-slash"] = "bell-slash",
		["belt"] = "belt",
		["binoculars"] = "binoculars",
		["book-closed"] = "book-closed",
		["bookmark"] = "bookmark",
		["bow-tie"] = "bow-tie",
		["building-store"] = "building-store",
		["bullet-flying"] = "bullet-flying",
		["butterfly-wings"] = "butterfly-wings",
		["calendar"] = "calendar",
		["calendar-plus"] = "calendar-plus",
		["calendar-star"] = "calendar-star",
		["camera-small"] = "camera-small",
		["caret-small-down"] = "caret-small-down",
		["caret-small-left"] = "caret-small-left",
		["caret-small-right"] = "caret-small-right",
		["caret-small-up"] = "caret-small-up",
		["chain-link"] = "chain-link",
		["chart-four-vertical-bars"] = "chart-four-vertical-bars",
		["chart-line"] = "chart-line",
		["chart-pie"] = "chart-pie",
		["chart-scatter-plot"] = "chart-scatter-plot",
		["chart-three-vertical-bars"] = "chart-three-vertical-bars",
		["check"] = "check",
		["check-large"] = "check-large",
		["check-small"] = "check-small",
		["chevron-large-down"] = "chevron-large-down",
		["chevron-large-down-to-line"] = "chevron-large-down-to-line",
		["chevron-large-left"] = "chevron-large-left",
		["chevron-large-left-to-line"] = "chevron-large-left-to-line",
		["chevron-large-right"] = "chevron-large-right",
		["chevron-large-right-to-line"] = "chevron-large-right-to-line",
		["chevron-large-up"] = "chevron-large-up",
		["chevron-large-up-to-line"] = "chevron-large-up-to-line",
		["chevron-small-down"] = "chevron-small-down",
		["chevron-small-down-to-line"] = "chevron-small-down-to-line",
		["chevron-small-left"] = "chevron-small-left",
		["chevron-small-left-to-line"] = "chevron-small-left-to-line",
		["chevron-small-right"] = "chevron-small-right",
		["chevron-small-right-to-line"] = "chevron-small-right-to-line",
		["chevron-small-up"] = "chevron-small-up",
		["chevron-small-up-to-line"] = "chevron-small-up-to-line",
		["circle-check"] = "circle-check",
		["circle-i"] = "circle-i",
		["circle-minus"] = "circle-minus",
		["circle-person"] = "circle-person",
		["circle-person-three-horizontal-bars-wrapping-right"] = "circle-person-three-horizontal-bars-wrapping-right",
		["circle-play"] = "circle-play",
		["circle-plus"] = "circle-plus",
		["circle-question"] = "circle-question",
		["circle-slash"] = "circle-slash",
		["circle-star"] = "circle-star",
		["circle-three-dots-horizontal"] = "circle-three-dots-horizontal",
		["circle-three-dots-vertical"] = "circle-three-dots-vertical",
		["circle-x"] = "circle-x",
		["clock"] = "clock",
		["clock-dashed"] = "clock-dashed",
		["clock-spin-reverse"] = "clock-spin-reverse",
		["clock-spin-reverse-dashed"] = "clock-spin-reverse-dashed",
		["clothes-hanger"] = "clothes-hanger",
		["cloud"] = "cloud",
		["cloud-arrow-down"] = "cloud-arrow-down",
		["code"] = "code",
		["compact-makeup-brush"] = "compact-makeup-brush",
		["compass"] = "compass",
		["controller-with-cog"] = "controller-with-cog",
		["crop"] = "crop",
		["crosshairs"] = "crosshairs",
		["crosshairs-slash"] = "crosshairs-slash",
		["cube-vertexes"] = "cube-vertexes",
		["curved-rectangle-megaphone"] = "curved-rectangle-megaphone",
		["diagonal-line-pattern"] = "diagonal-line-pattern",
		["diagonal-line-pattern-sticker"] = "diagonal-line-pattern-sticker",
		["diamond-simplified"] = "diamond-simplified",
		["discord"] = "discord",
		["disguise-nose-glasses"] = "disguise-nose-glasses",
		["document-circle-slash"] = "document-circle-slash",
		["document-list-heart"] = "document-list-heart",
		["door-open-arrow-to-bottom-right"] = "door-open-arrow-to-bottom-right",
		["dress"] = "dress",
		["dual-arrows-horizontal"] = "dual-arrows-horizontal",
		["dual-arrows-to-corners"] = "dual-arrows-to-corners",
		["dual-arrows-vertical"] = "dual-arrows-vertical",
		["envelope"] = "envelope",
		["eraser"] = "eraser",
		["eye"] = "eye",
		["eye-slash"] = "eye-slash",
		["eye-with-eyeliner"] = "eye-with-eyeliner",
		["eyebrows"] = "eyebrows",
		["eyelashes"] = "eyelashes",
		["face-winking"] = "face-winking",
		["facebook"] = "facebook",
		["file-box"] = "file-box",
		["fingerprint"] = "fingerprint",
		["flag"] = "flag",
		["flame"] = "flame",
		["folder"] = "folder",
		["fountain-pen-nib"] = "fountain-pen-nib",
		["four-bars-horizontal-center-aligned"] = "four-bars-horizontal-center-aligned",
		["four-bars-horizontal-chevron-left"] = "four-bars-horizontal-chevron-left",
		["four-bars-horizontal-chevron-right"] = "four-bars-horizontal-chevron-right",
		["four-bars-horizontal-justified-aligned"] = "four-bars-horizontal-justified-aligned",
		["four-bars-horizontal-left-aligned"] = "four-bars-horizontal-left-aligned",
		["four-bars-horizontal-right-aligned"] = "four-bars-horizontal-right-aligned",
		["frame-bubble-slash"] = "frame-bubble-slash",
		["frame-bubble-soundwave"] = "frame-bubble-soundwave",
		["frame-camera"] = "frame-camera",
		["frame-camera-center"] = "frame-camera-center",
		["frame-collapsed"] = "frame-collapsed",
		["frame-corners"] = "frame-corners",
		["frame-expanded"] = "frame-expanded",
		["frame-face"] = "frame-face",
		["frame-person-torso"] = "frame-person-torso",
		["frame-record"] = "frame-record",
		["frame-single-bar-horizontal"] = "frame-single-bar-horizontal",
		["frame-soundwave"] = "frame-soundwave",
		["frame-video-camera"] = "frame-video-camera",
		["gear"] = "gear",
		["generic-dpad"] = "generic-dpad",
		["gift-box"] = "gift-box",
		["gift-card"] = "gift-card",
		["glasses"] = "glasses",
		["globe-detailed"] = "globe-detailed",
		["globe-simplified"] = "globe-simplified",
		["globe-simplipfied-speech-bubble"] = "globe-simplipfied-speech-bubble",
		["grid"] = "grid",
		["guilded"] = "guilded",
		["hack-week"] = "hack-week",
		["hammer-code"] = "hammer-code",
		["hand-curved-arrow-left"] = "hand-curved-arrow-left",
		["hand-dual-arrows"] = "hand-dual-arrows",
		["hand-ellipse"] = "hand-ellipse",
		["hand-half-ellipse"] = "hand-half-ellipse",
		["hand-two-arrows-horizontal"] = "hand-two-arrows-horizontal",
		["hashtag"] = "hashtag",
		["hat-fedora"] = "hat-fedora",
		["hat-toque"] = "hat-toque",
		["head-blank"] = "head-blank",
		["head-blush"] = "head-blush",
		["head-female"] = "head-female",
		["head-freckles"] = "head-freckles",
		["head-lips"] = "head-lips",
		["head-male"] = "head-male",
		["headphones"] = "headphones",
		["headphones-arrow-up"] = "headphones-arrow-up",
		["headphones-arrow-up-lock"] = "headphones-arrow-up-lock",
		["headphones-slash"] = "headphones-slash",
		["headphones-x"] = "headphones-x",
		["headphones-x-lock"] = "headphones-x-lock",
		["heart"] = "heart",
		["house"] = "house",
		["image"] = "image",
		["image-stacked"] = "image-stacked",
		["instagram"] = "instagram",
		["jacket"] = "jacket",
		["key"] = "key",
		["key-alt"] = "key-alt",
		["key-apostrophe"] = "key-apostrophe",
		["key-arrow-down"] = "key-arrow-down",
		["key-arrow-right"] = "key-arrow-right",
		["key-arrow-up"] = "key-arrow-up",
		["key-asterisk"] = "key-asterisk",
		["key-backspace"] = "key-backspace",
		["key-caps-lock"] = "key-caps-lock",
		["key-caret"] = "key-caret",
		["key-comma"] = "key-comma",
		["key-command"] = "key-command",
		["key-control"] = "key-control",
		["key-grave-accent"] = "key-grave-accent",
		["key-period"] = "key-period",
		["key-return"] = "key-return",
		["key-shift"] = "key-shift",
		["key-space"] = "key-space",
		["key-tab"] = "key-tab",
		["language-characters"] = "language-characters",
		["leg-left"] = "leg-left",
		["leg-right"] = "leg-right",
		["lightning-bolt"] = "lightning-bolt",
		["linkedin"] = "linkedin",
		["lips"] = "lips",
		["lipstick"] = "lipstick",
		["list-bulleted"] = "list-bulleted",
		["location-pin"] = "location-pin",
		["location-pin-map"] = "location-pin-map",
		["lock-closed"] = "lock-closed",
		["lollipop"] = "lollipop",
		["magnifying-glass"] = "magnifying-glass",
		["magnifying-glass-minus"] = "magnifying-glass-minus",
		["magnifying-glass-plus"] = "magnifying-glass-plus",
		["mascara"] = "mascara",
		["megaphone"] = "megaphone",
		["memory-card"] = "memory-card",
		["messenger"] = "messenger",
		["microphone"] = "microphone",
		["microphone-slash"] = "microphone-slash",
		["microphone-text-box"] = "microphone-text-box",
		["microphone-triangle-exclamation"] = "microphone-triangle-exclamation",
		["minus"] = "minus",
		["minus-small"] = "minus-small",
		["mirror-standing"] = "mirror-standing",
		["moments"] = "moments",
		["moon"] = "moon",
		["mouse-button-left"] = "mouse-button-left",
		["mouse-button-right"] = "mouse-button-right",
		["mouse-scrollwheel"] = "mouse-scrollwheel",
		["music-note"] = "music-note",
		["nebula"] = "nebula",
		["necklace"] = "necklace",
		["nine-dots-grid"] = "nine-dots-grid",
		["ninja"] = "ninja",
		["nose"] = "nose",
		["page"] = "page",
		["paint-brush"] = "paint-brush",
		["paint-bucket"] = "paint-bucket",
		["pants"] = "pants",
		["pants-2d-text"] = "pants-2d-text",
		["paper-airplane"] = "paper-airplane",
		["parrot"] = "parrot",
		["pause-large"] = "pause-large",
		["pause-small"] = "pause-small",
		["pencil"] = "pencil",
		["pencil-square"] = "pencil-square",
		["person"] = "person",
		["person-arrow-from-bottom-right"] = "person-arrow-from-bottom-right",
		["person-check"] = "person-check",
		["person-circle-slash"] = "person-circle-slash",
		["person-climbing"] = "person-climbing",
		["person-clock"] = "person-clock",
		["person-falling"] = "person-falling",
		["person-graduate"] = "person-graduate",
		["person-jumping"] = "person-jumping",
		["person-magnifying-glass"] = "person-magnifying-glass",
		["person-photo-camera"] = "person-photo-camera",
		["person-play"] = "person-play",
		["person-play-clock"] = "person-play-clock",
		["person-plus"] = "person-plus",
		["person-racing"] = "person-racing",
		["person-running"] = "person-running",
		["person-standing"] = "person-standing",
		["person-standing-arrow-reverse"] = "person-standing-arrow-reverse",
		["person-standing-dual-arrows-vertical"] = "person-standing-dual-arrows-vertical",
		["person-standing-gear"] = "person-standing-gear",
		["person-swimming"] = "person-swimming",
		["person-teleport"] = "person-teleport",
		["person-trash-can"] = "person-trash-can",
		["person-walking"] = "person-walking",
		["person-with-smaller-person"] = "person-with-smaller-person",
		["phone"] = "phone",
		["phone-down"] = "phone-down",
		["phone-plus"] = "phone-plus",
		["phone-volume"] = "phone-volume",
		["phone-x"] = "phone-x",
		["photo-camera"] = "photo-camera",
		["photo-camera-face"] = "photo-camera-face",
		["photo-camera-slash"] = "photo-camera-slash",
		["picture-in-picture"] = "picture-in-picture",
		["pig"] = "pig",
		["pin"] = "pin",
		["pin-slash"] = "pin-slash",
		["play-large"] = "play-large",
		["play-small"] = "play-small",
		["plus-large"] = "plus-large",
		["plus-small"] = "plus-small",
		["premium"] = "premium",
		["ps-circle"] = "ps-circle",
		["ps-dpad-down"] = "ps-dpad-down",
		["ps-dpad-left"] = "ps-dpad-left",
		["ps-dpad-right"] = "ps-dpad-right",
		["ps-dpad-up"] = "ps-dpad-up",
		["ps-l1"] = "ps-l1",
		["ps-l2"] = "ps-l2",
		["ps-l3"] = "ps-l3",
		["ps-r1"] = "ps-r1",
		["ps-r2"] = "ps-r2",
		["ps-r3"] = "ps-r3",
		["ps-square"] = "ps-square",
		["ps-stick-left"] = "ps-stick-left",
		["ps-stick-right"] = "ps-stick-right",
		["ps-triagle"] = "ps-triagle",
		["ps-x"] = "ps-x",
		["ps4-options"] = "ps4-options",
		["ps4-share"] = "ps4-share",
		["ps4-touchpad"] = "ps4-touchpad",
		["ps5-options"] = "ps5-options",
		["ps5-share"] = "ps5-share",
		["ps5-touchpad"] = "ps5-touchpad",
		["pumpkin"] = "pumpkin",
		["purse"] = "purse",
		["rectangle-list"] = "rectangle-list",
		["rectangle-numbers-counting"] = "rectangle-numbers-counting",
		["rectangle-person-with-three-horizontal-lines"] = "rectangle-person-with-three-horizontal-lines",
		["robux"] = "robux",
		["rosette-seven-point"] = "rosette-seven-point",
		["rosette-ten-point"] = "rosette-ten-point",
		["seven-point-rosette"] = "seven-point-rosette",
		["shield-check"] = "shield-check",
		["shield-lock"] = "shield-lock",
		["shirt"] = "shirt",
		["shirt-2d-text"] = "shirt-2d-text",
		["shirt-pants"] = "shirt-pants",
		["shoe-left"] = "shoe-left",
		["shoe-right"] = "shoe-right",
		["shopping-basket"] = "shopping-basket",
		["shopping-basket-check"] = "shopping-basket-check",
		["shopping-cart"] = "shopping-cart",
		["shorts"] = "shorts",
		["sidebar"] = "sidebar",
		["signal-exclamation"] = "signal-exclamation",
		["six-dots-two-column-grid"] = "six-dots-two-column-grid",
		["skip-end-large"] = "skip-end-large",
		["skip-end-small"] = "skip-end-small",
		["skip-next-large"] = "skip-next-large",
		["skip-next-small"] = "skip-next-small",
		["skip-previous-large"] = "skip-previous-large",
		["skip-previous-small"] = "skip-previous-small",
		["skip-start-large"] = "skip-start-large",
		["skip-start-small"] = "skip-start-small",
		["smartphone-portrait"] = "smartphone-portrait",
		["speaker"] = "speaker",
		["speaker-slash"] = "speaker-slash",
		["speaker-triangle-exclamation"] = "speaker-triangle-exclamation",
		["speaker-x"] = "speaker-x",
		["speech-bubble-align-center"] = "speech-bubble-align-center",
		["speech-bubble-align-left"] = "speech-bubble-align-left",
		["speech-bubble-exclamation"] = "speech-bubble-exclamation",
		["speech-bubble-round"] = "speech-bubble-round",
		["square-bone"] = "square-bone",
		["square-books"] = "square-books",
		["square-check"] = "square-check",
		["square-code"] = "square-code",
		["square-dashed-person-standing"] = "square-dashed-person-standing",
		["square-dual-arrows-horizontal"] = "square-dual-arrows-horizontal",
		["square-dual-arrows-to-corner"] = "square-dual-arrows-to-corner",
		["square-face-sound"] = "square-face-sound",
		["square-face-waving-hand"] = "square-face-waving-hand",
		["square-face-winking"] = "square-face-winking",
		["square-minus"] = "square-minus",
		["square-person"] = "square-person",
		["squares-grid-plus"] = "squares-grid-plus",
		["squares-grid-qr"] = "squares-grid-qr",
		["stacked-squares-arrow-down-left"] = "stacked-squares-arrow-down-left",
		["stacked-squares-arrow-up-right"] = "stacked-squares-arrow-up-right",
		["stacked-squares-plus"] = "stacked-squares-plus",
		["star"] = "star",
		["stop-large"] = "stop-large",
		["stop-small"] = "stop-small",
		["studio"] = "studio",
		["sun"] = "sun",
		["sweater"] = "sweater",
		["sword"] = "sword",
		["tag-sparkle"] = "tag-sparkle",
		["teletype"] = "teletype",
		["tencent-qq"] = "tencent-qq",
		["text-b-bold"] = "text-b-bold",
		["text-box-microphone"] = "text-box-microphone",
		["text-h-subscript-1"] = "text-h-subscript-1",
		["text-h-subscript-2"] = "text-h-subscript-2",
		["text-h-subscript-3"] = "text-h-subscript-3",
		["text-i-italic"] = "text-i-italic",
		["text-s-strikethrough"] = "text-s-strikethrough",
		["text-u-underline"] = "text-u-underline",
		["text-uppercase-a-lowercase-a"] = "text-uppercase-a-lowercase-a",
		["text-x-subscript-2"] = "text-x-subscript-2",
		["text-x-superscript-2"] = "text-x-superscript-2",
		["three-bars-horizontal"] = "three-bars-horizontal",
		["three-bars-horizontal-chevron-left"] = "three-bars-horizontal-chevron-left",
		["three-bars-horizontal-narrowing"] = "three-bars-horizontal-narrowing",
		["three-bars-horizontal-triangles-vertical"] = "three-bars-horizontal-triangles-vertical",
		["three-bars-vertical-triangles-horizontal"] = "three-bars-vertical-triangles-horizontal",
		["three-chevrons-enlarging-down"] = "three-chevrons-enlarging-down",
		["three-chevrons-enlarging-up"] = "three-chevrons-enlarging-up",
		["three-dots-horizontal"] = "three-dots-horizontal",
		["three-dots-vertical"] = "three-dots-vertical",
		["three-horizontal-bars-wrapping-right"] = "three-horizontal-bars-wrapping-right",
		["three-people"] = "three-people",
		["three-ring-note"] = "three-ring-note",
		["three-sliders-horizontal"] = "three-sliders-horizontal",
		["three-stacked-squares-tilted"] = "three-stacked-squares-tilted",
		["thumb-down"] = "thumb-down",
		["thumb-up"] = "thumb-up",
		["tik-tok"] = "tik-tok",
		["tilt"] = "tilt",
		["torso"] = "torso",
		["trash-can"] = "trash-can",
		["triangle-exclamation"] = "triangle-exclamation",
		["trophy"] = "trophy",
		["tshirt"] = "tshirt",
		["tshirt-2d-text"] = "tshirt-2d-text",
		["tshirt-dual-arrows"] = "tshirt-dual-arrows",
		["twitch"] = "twitch",
		["twitter"] = "twitter",
		["two-arrows-down-and-up"] = "two-arrows-down-and-up",
		["two-arrows-from-center"] = "two-arrows-from-center",
		["two-arrows-left-right"] = "two-arrows-left-right",
		["two-arrows-loop-clockwise"] = "two-arrows-loop-clockwise",
		["two-arrows-loop-clockwise-1"] = "two-arrows-loop-clockwise-1",
		["two-arrows-loop-clockwise-infinity"] = "two-arrows-loop-clockwise-infinity",
		["two-arrows-spin-clockwise"] = "two-arrows-spin-clockwise",
		["two-arrows-spin-clockwise-plus"] = "two-arrows-spin-clockwise-plus",
		["two-arrows-switch-right"] = "two-arrows-switch-right",
		["two-arrows-to-center"] = "two-arrows-to-center",
		["two-folders"] = "two-folders",
		["two-location-pins-connecting-arrow"] = "two-location-pins-connecting-arrow",
		["two-makeup-brushes"] = "two-makeup-brushes",
		["two-people"] = "two-people",
		["two-people-speech-bubble"] = "two-people-speech-bubble",
		["two-stacked-squares"] = "two-stacked-squares",
		["two-switches-horizontal"] = "two-switches-horizontal",
		["verified-backplate"] = "verified-backplate",
		["verified-check"] = "verified-check",
		["verified-mono"] = "verified-mono",
		["video-camera"] = "video-camera",
		["video-camera-arrow-to-bottom-left"] = "video-camera-arrow-to-bottom-left",
		["video-camera-arrow-to-top-right"] = "video-camera-arrow-to-top-right",
		["video-camera-slash"] = "video-camera-slash",
		["video-camera-triangle-exclamation"] = "video-camera-triangle-exclamation",
		["video-camera-x"] = "video-camera-x",
		["wallet"] = "wallet",
		["we-chat"] = "we-chat",
		["whatsapp"] = "whatsapp",
		["x"] = "x",
		["x-small"] = "x-small",
		["xbox-a"] = "xbox-a",
		["xbox-a-pressed"] = "xbox-a-pressed",
		["xbox-a-unpressed"] = "xbox-a-unpressed",
		["xbox-b"] = "xbox-b",
		["xbox-dpad"] = "xbox-dpad",
		["xbox-dpad-down"] = "xbox-dpad-down",
		["xbox-dpad-left"] = "xbox-dpad-left",
		["xbox-dpad-right"] = "xbox-dpad-right",
		["xbox-dpad-up"] = "xbox-dpad-up",
		["xbox-lb"] = "xbox-lb",
		["xbox-lt"] = "xbox-lt",
		["xbox-menu"] = "xbox-menu",
		["xbox-rb"] = "xbox-rb",
		["xbox-rt"] = "xbox-rt",
		["xbox-stick-left"] = "xbox-stick-left",
		["xbox-stick-left-directional"] = "xbox-stick-left-directional",
		["xbox-stick-left-horizontal"] = "xbox-stick-left-horizontal",
		["xbox-stick-left-vertical"] = "xbox-stick-left-vertical",
		["xbox-stick-right"] = "xbox-stick-right",
		["xbox-stick-right-directional"] = "xbox-stick-right-directional",
		["xbox-stick-right-horizontal"] = "xbox-stick-right-horizontal",
		["xbox-stick-right-vertical"] = "xbox-stick-right-vertical",
		["xbox-view"] = "xbox-view",
		["xbox-x"] = "xbox-x",
		["xbox-y"] = "xbox-y",
		["xr-headset"] = "xr-headset",
		["youtube"] = "youtube"
	};
end);

NeverLose.IsMouseOverFrame = LPH_NO_VIRTUALIZE(function(self , Frame)
	if not Frame then
		return;
	end;

	if NeverLose.Global3DRenderMode then
		if Frame.GuiState == Enum.GuiState.Hover or Frame.GuiState == Enum.GuiState.Press then
			return true;
		end;

		return false;
	end;

	local AbsPos: Vector2, AbsSize: Vector2 = Frame.AbsolutePosition, Frame.AbsoluteSize;

	if Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X and Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y then
		return true;
	end;
end);

NeverLose.CreateSignal = LPH_NO_VIRTUALIZE(function(self , DefaultValue)
	local __cache = Instance.new('BindableEvent');
	local bind = {
		Value = DefaultValue,
		__event = __cache
	};

	function bind:GetValue()
		return bind.Value;
	end;

	function bind:SetValue(f)
		bind.Value = f;

		return __cache:Fire(f);
	end;

	function bind:Connect(f)
		local signal = __cache.Event:Connect(f);

		NeverLose:AddSignal(signal);

		return signal;
	end;

	return bind;
end);

NeverLose.SetIconMode = LPH_NO_VIRTUALIZE(function(self , Label: TextLabel , Icon: string)
	local useBold = string.lower(string.sub(Icon , -5)) == '-bold';

	if useBold then
		Label.Text = Icon:sub(1,-6);
		Label.FontFace = NeverLose.BuiltInBold;
	else
		Label.Text = Icon;
		Label.FontFace = NeverLose.BuiltInRegular;
	end;
end);

function NeverLose:GetIconFont(icon: string)
	local useBold = string.lower(string.sub(icon , -5)) == '-bold';

	if useBold then
		return NeverLose.BuiltInBold;
	end;

	return NeverLose.BuiltInRegular;
end;

function NeverLose:MoreThanHalfY(Value: number)
	return (NeverLose.ScreenGui.AbsoluteSize.Y / 2) < Value
end;

NeverLose.IsStudio = RunService:IsStudio();
NeverLose.IsMobile = UserInputService.TouchEnabled;

NeverLose.CreateInput = LPH_NO_VIRTUALIZE(function(self , Frame , Callback)
	local Button = Instance.new('ImageButton',Frame);

	Button.ZIndex = Frame.ZIndex + 10;
	Button.Size = UDim2.fromScale(1,1);
	Button.BackgroundTransparency = 1;
	Button.ImageTransparency = 1;
	Button.Image = "rbxasset://textuers/translateIcon.png";

	if Callback then
		local bth_signal = Button.MouseButton1Click:Connect(Callback);

		return Button , bth_signal;
	end;

	return Button;
end);

NeverLose.PlayAnimate = LPH_NO_VIRTUALIZE(function(Self , Info , Property)
	local Tween = TweenService:Create(Self , Info or TweenInfo.new(0.25) , Property);

	Tween:Play();

	return Tween;
end);

NeverLose.Drag = LPH_NO_VIRTUALIZE(function(InputFrame: Frame, MoveFrame: Frame, Speed : number)
	local dragToggle: boolean = false;
	local dragStart: Vector3 = nil;
	local startPos: UDim2 = nil;
	local Tween = TweenInfo.new(Speed);

	local updateInput = function(input)
		local delta = input.Position - dragStart;
		local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y);

		if NeverLose.Global3DRenderMode then
			NeverLose.PlayAnimate(MoveFrame,Tween,{
				Position = UDim2.fromScale(0.5,0.5)
			});
		else
			NeverLose.PlayAnimate(MoveFrame,Tween,{
				Position = position
			});
		end;
	end;

	NeverLose:AddSignal(InputFrame.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
			dragToggle = true;
			dragStart = input.Position;
			startPos = MoveFrame.Position;

			local input_end;
			input_end = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false;

					input_end:Disconnect();
				end
			end)
		end
	end));

	NeverLose:AddSignal(UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			if dragToggle then
				updateInput(input)
			end
		end
	end));
end);

NeverLose.Rounding = LPH_NO_VIRTUALIZE(function(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0);
	return math.floor(num * mult + 0.5) / mult;
end);

NeverLose.ProcessParams = LPH_NO_VIRTUALIZE(function(self , Params , Fixed)
	Params = Params or {};

	local k = Params or {};

	for i,v in next , Fixed do
		k[i] = Params[i] or v;
	end;

	table.clear(Fixed);

	return k;
end);

NeverLose.EnabledBlur = true;
NeverLose.BlurModuleParent = workspace.CurrentCamera;

NeverLose.GetCalculatePosition = LPH_NO_VIRTUALIZE(function(planePos, planeNormal, rayOrigin, rayDirection)
	local n = planeNormal;
	local d = rayDirection;
	local v = rayOrigin - planePos;

	local num = (n.x * v.x) + (n.y * v.y) + (n.z * v.z);
	local den = (n.x * d.x) + (n.y * d.y) + (n.z * d.z);
	local a = -num / den;

	return rayOrigin + (a * rayDirection);
end);

NeverLose.CreateBlurModule = LPH_NO_VIRTUALIZE(function(self , Frame , Signal)
	if not NeverLose.EnabledBlur then
		return NeverLose:AddSignal(Instance.new('BindableEvent').Event:Connect(function() return "nl"; end));	
	end;

	local Part = Instance.new('Part',NeverLose.BlurModuleParent);
	local DepthOfField = Instance.new('DepthOfFieldEffect',cloneref(game:GetService('Lighting')));
	local BlockMesh = Instance.new("BlockMesh");

	BlockMesh.Parent = Part;

	Part.Material = Enum.Material.Glass;
	Part.Transparency = 1;
	Part.Reflectance = 1;
	Part.CastShadow = false;
	Part.Anchored = true;
	Part.CanCollide = false;
	Part.CanQuery = false;
	Part.CollisionGroup = NeverLose.RandomString();
	Part.Size = Vector3.new(1, 1, 1) * 0.01;
	Part.Color = Color3.fromRGB(0,0,0);

	DepthOfField.Enabled = true;
	DepthOfField.FarIntensity = 0;
	DepthOfField.FocusDistance = 0;
	DepthOfField.InFocusRadius = 1000;
	DepthOfField.NearIntensity = 1;
	DepthOfField.Name = NeverLose.RandomString();

	Part.Name = NeverLose.RandomString();

	local disconnect;

	local UpdateFunction = function()
		local IsWindowActive = Signal:GetValue();

		if IsWindowActive and not NeverLose.Global3DRenderMode then

			NeverLose.PlayAnimate(DepthOfField,TweenInfo.new(0.1),{
				NearIntensity = 1
			})

			NeverLose.PlayAnimate(Part,TweenInfo.new(0.1),{
				Transparency = 0.97,
				Size = Vector3.new(1, 1, 1) * 0.01;
			})

			Part.Parent = NeverLose.BlurModuleParent;
		else
			NeverLose.PlayAnimate(DepthOfField,TweenInfo.new(0.1),{
				NearIntensity = 0
			})

			NeverLose.PlayAnimate(Part,TweenInfo.new(0.1),{
				Size = Vector3.zero,
				Transparency = 1.5,
			})

			Part.Parent = nil;

			return false;
		end;

		if IsWindowActive then
			local corner0 = Frame.AbsolutePosition;
			local corner1 = corner0 + Frame.AbsoluteSize;

			local ray0 = CurrentCamera.ScreenPointToRay(CurrentCamera,corner0.X, corner0.Y, 1);
			local ray1 = CurrentCamera.ScreenPointToRay(CurrentCamera,corner1.X, corner1.Y, 1);

			local planeOrigin = CurrentCamera.CFrame.Position + CurrentCamera.CFrame.LookVector * (0.05 - CurrentCamera.NearPlaneZ);

			local planeNormal = CurrentCamera.CFrame.LookVector;

			local pos0 = NeverLose.GetCalculatePosition(planeOrigin, planeNormal, ray0.Origin, ray0.Direction);
			local pos1 = NeverLose.GetCalculatePosition(planeOrigin, planeNormal, ray1.Origin, ray1.Direction);

			pos0 = CurrentCamera.CFrame:PointToObjectSpace(pos0);
			pos1 = CurrentCamera.CFrame:PointToObjectSpace(pos1);

			local size   = pos1 - pos0;
			local center = (pos0 + pos1) / 2;

			BlockMesh.Offset = center
			BlockMesh.Scale  = size / 0.0101;
			Part.CFrame = CurrentCamera.CFrame;
		end;
	end;

	local rbxsignal = NeverLose:AddSignal(CurrentCamera:GetPropertyChangedSignal('CFrame'):Connect(UpdateFunction))
	local loopThread = NeverLose:AddSignal(UserInputService.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
			pcall(UpdateFunction);
		end;
	end));

	local THREAD = task.spawn(function()
		while true do task.wait(0.1)
			pcall(UpdateFunction);
		end;
	end);

	disconnect = function()
		rbxsignal:Disconnect();
		loopThread:Disconnect();
		task.cancel(THREAD);
		Part:Destroy();
		DepthOfField:Destroy();
	end;

	Frame.Destroying:Connect(disconnect);

	return rbxsignal;
end);

local EmptyFunction = function() end;

function NeverLose:RollingEffect(parent)
	local UIGradient = Instance.new("UIGradient")

	UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.4), NumberSequenceKeypoint.new(1.00, 0.00)}
	UIGradient.Parent = parent

	return UIGradient;
end;

function NeverLose:CreateShadow(parent , RollingEffect)
	local Shadow = {};

	local UIShadowSafe85 = Instance.new("UIStroke")
	local UIShadowSafe65 = Instance.new("UIStroke")
	local UIShadowSafe50 = Instance.new("UIStroke")
	local UIShadowSafe45 = Instance.new("UIStroke")

	UIShadowSafe85.Thickness = 6.000
	UIShadowSafe85.Transparency = 1
	UIShadowSafe85.Parent = parent

	UIShadowSafe65.Thickness = 5.000
	UIShadowSafe65.Transparency = 1
	UIShadowSafe65.Parent = parent

	UIShadowSafe50.Thickness = 4.000
	UIShadowSafe50.Transparency = 1
	UIShadowSafe50.Parent = parent

	UIShadowSafe45.Thickness = 3.000
	UIShadowSafe45.Transparency = 1
	UIShadowSafe45.Parent = parent

	local RollingEffectThread;
	local r1,r2,r3,r4;

	if RollingEffect then
		r1 = NeverLose:RollingEffect(UIShadowSafe85);
		r2 = NeverLose:RollingEffect(UIShadowSafe65);
		r3 = NeverLose:RollingEffect(UIShadowSafe50);
		r4 = NeverLose:RollingEffect(UIShadowSafe45);
	end;

	Shadow.Render = LPH_NO_VIRTUALIZE(function(self , value)
		if RollingEffectThread then
			task.cancel(RollingEffectThread);
			RollingEffectThread = nil;
		end;

		if value then
			NeverLose.PlayAnimate(UIShadowSafe85 , SlowyTween , {
				Transparency = 0.900
			})

			NeverLose.PlayAnimate(UIShadowSafe65 , SlowyTween , {
				Transparency = 0.900
			})

			NeverLose.PlayAnimate(UIShadowSafe50 , SlowyTween , {
				Transparency = 0.900
			})

			NeverLose.PlayAnimate(UIShadowSafe45 , SlowyTween , {
				Transparency = 0.900
			})

			if RollingEffect then
				RollingEffectThread = task.spawn(function()
					local level = 20;
					while true do task.wait(0.025)
						NeverLose.PlayAnimate(r1 , SlowyTween , {
							Rotation = r1.Rotation + level
						});

						NeverLose.PlayAnimate(r2 , SlowyTween , {
							Rotation = r2.Rotation + level
						});

						NeverLose.PlayAnimate(r3 , SlowyTween , {
							Rotation = r3.Rotation + level
						});

						NeverLose.PlayAnimate(r4 , SlowyTween , {
							Rotation = r4.Rotation + level
						});
					end;
				end);
			end;
		else
			NeverLose.PlayAnimate(UIShadowSafe85 , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(UIShadowSafe65 , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(UIShadowSafe50 , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(UIShadowSafe45 , SlowyTween , {
				Transparency = 1
			})
		end;
	end);

	return Shadow;
end;

function NeverLose:CreateOptionWindow(Frame: Frame , Zindex)
	Zindex = Zindex or 9;

	local Window = {
		Signal = NeverLose:CreateSignal(false),
	};

	local OptionHandler = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIListLayout = Instance.new("UIListLayout")
	local UIStroke = Instance.new("UIStroke")
	local shadow = NeverLose:CreateShadow(OptionHandler);

	OptionHandler.Name = NeverLose.RandomString();
	OptionHandler.Parent = NeverLose.ScreenGui
	OptionHandler.AnchorPoint = Vector2.new(0, 0)
	OptionHandler.BackgroundColor3 = Color3.fromRGB(19, 19, 21)
	OptionHandler.BackgroundTransparency = 0.035
	OptionHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
	OptionHandler.BorderSizePixel = 0
	OptionHandler.ClipsDescendants = true
	OptionHandler.Position = UDim2.new(255,255,255,255)
	OptionHandler.Size = UDim2.new(0, 220, 0, 75)
	OptionHandler.ZIndex = Zindex + 9

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = OptionHandler

	UIListLayout.Parent = OptionHandler
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = OptionHandler

	NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
		NeverLose.PlayAnimate(OptionHandler , SlowyTween , {
			Size = UDim2.new(0, 220, 0, UIListLayout.AbsoluteContentSize.Y - 1)
		})
	end)));

	NeverLose:AddSignal(OptionHandler:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
		if OptionHandler.BackgroundTransparency > 0.9 then
			OptionHandler.Visible = false;
			UIListLayout.Parent = nil;
			OptionHandler.Parent = nil;
		else
			OptionHandler.Visible = true;
			UIListLayout.Parent = OptionHandler

			if NeverLose.Global3DRenderMode then
				OptionHandler.Parent = NeverLose.GlobalSurfaceGui;
			else
				OptionHandler.Parent = NeverLose.ScreenGui;
			end;
		end
	end)));

	local FollowingThread;
	local SetPosition = LPH_NO_VIRTUALIZE(function()
		if NeverLose:MoreThanHalfY(Frame.AbsolutePosition.Y + 65) then
			OptionHandler.AnchorPoint = Vector2.new(0,1)
		else
			OptionHandler.AnchorPoint = Vector2.new(0,0)
		end;

		OptionHandler.Position = UDim2.fromOffset(Frame.AbsolutePosition.X + 18 , Frame.AbsolutePosition.Y + 65);
	end);

	Window.SetRender = LPH_NO_VIRTUALIZE(function(value)
		if FollowingThread then
			task.cancel(FollowingThread);
			FollowingThread = nil;
		end;

		if value then
			SetPosition();

			NeverLose.PlayAnimate(OptionHandler , SlowyTween , {
				BackgroundTransparency = 0.035
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			})

			shadow:Render(true);

			if NeverLose.Global3DRenderMode then
				OptionHandler.Parent = NeverLose.GlobalSurfaceGui;
			else
				OptionHandler.Parent = NeverLose.ScreenGui;
			end;

			FollowingThread = task.spawn(function()
				while true do task.wait()
					SetPosition();
				end
			end)
		else
			NeverLose.PlayAnimate(OptionHandler , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})

			shadow:Render(false);
		end;
	end);

	Window.SetRender(false);
	Window.Signal:Connect(Window.SetRender)

	local Payback = NeverLose:RegisiterItem(OptionHandler , Window.Signal);

	Payback.Winbdow = Window;
	Payback.Root = OptionHandler;
	Payback.Signal = Window.Signal;

	return Payback;
end;

function NeverLose:CreateColorPicker(HandleFrame: Frame)
	local ZIndex = HandleFrame.ZIndex;

	local ColorPickerLib = {};

	local ColorPickerHandler = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local SaViMap = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local ColorZoneSelection = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local UIStroke_2 = Instance.new("UIStroke")
	local ColorMap = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local UICorner_4 = Instance.new("UICorner")
	local ColorMapSelection = Instance.new("Frame")
	local UIStroke_3 = Instance.new("UIStroke")
	local UICorner_5 = Instance.new("UICorner")
	local RGBLabel = Instance.new("TextLabel")
	local UICorner_6 = Instance.new("UICorner")
	local Shadow = NeverLose:CreateShadow(ColorPickerHandler);

	ColorPickerHandler.Name = NeverLose.RandomString();
	ColorPickerHandler.Parent = NeverLose.ScreenGui
	ColorPickerHandler.AnchorPoint = Vector2.new(0, 0)
	ColorPickerHandler.BackgroundColor3 = Color3.fromRGB(19, 19, 21)
	ColorPickerHandler.BackgroundTransparency = 0.035
	ColorPickerHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorPickerHandler.BorderSizePixel = 0
	ColorPickerHandler.ClipsDescendants = true
	ColorPickerHandler.Position = UDim2.new(255, 0, 255, 20)
	ColorPickerHandler.Size = UDim2.new(0, 200, 0, 240)
	ColorPickerHandler.ZIndex = ZIndex + 125

	NeverLose:AddSignal(ColorPickerHandler:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
		if ColorPickerHandler.BackgroundTransparency > 0.9 then
			ColorPickerHandler.Visible = false;
			ColorPickerHandler.Parent = nil
		else
			ColorPickerHandler.Visible = true;

			if NeverLose.Global3DRenderMode then
				ColorPickerHandler.Parent = NeverLose.GlobalSurfaceGui;
			else
				ColorPickerHandler.Parent = NeverLose.ScreenGui;
			end;
		end;
	end)));

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = ColorPickerHandler

	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = ColorPickerHandler

	SaViMap.Name = NeverLose.RandomString();
	SaViMap.Parent = ColorPickerHandler
	SaViMap.AnchorPoint = Vector2.new(0.5, 0)
	SaViMap.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
	SaViMap.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SaViMap.BorderSizePixel = 0
	SaViMap.Position = UDim2.new(0.5, 0, 0, 5)
	SaViMap.Size = UDim2.new(0, 185, 0, 185)
	SaViMap.ZIndex = ZIndex + 126
	SaViMap.Image = NeverLose.ImageColorMapping -- UNSAFE IMAGE

	UICorner_2.CornerRadius = UDim.new(0, 5)
	UICorner_2.Parent = SaViMap

	ColorZoneSelection.Name = NeverLose.RandomString();
	ColorZoneSelection.Parent = SaViMap
	ColorZoneSelection.AnchorPoint = Vector2.new(0.5, 0.5)
	ColorZoneSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorZoneSelection.BackgroundTransparency = 1.000
	ColorZoneSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorZoneSelection.BorderSizePixel = 0
	ColorZoneSelection.Position = UDim2.new(0.5, 0, 0.5, 0)
	ColorZoneSelection.Size = UDim2.new(0, 10, 0, 10)
	ColorZoneSelection.ZIndex = ZIndex + 127

	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = ColorZoneSelection

	UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
	UIStroke_2.Parent = ColorZoneSelection

	ColorMap.Name = NeverLose.RandomString();
	ColorMap.Parent = ColorPickerHandler
	ColorMap.AnchorPoint = Vector2.new(0.5, 0)
	ColorMap.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorMap.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorMap.BorderSizePixel = 0
	ColorMap.Position = UDim2.new(0.5, 0, 0, 200)
	ColorMap.Size = UDim2.new(1, -15, 0, 10)
	ColorMap.ZIndex = ZIndex + 126

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 153, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(203, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(50, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 102)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 101, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(50, 0, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(204, 0, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 153)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))}
	UIGradient.Parent = ColorMap

	UICorner_4.CornerRadius = UDim.new(0, 3)
	UICorner_4.Parent = ColorMap

	ColorMapSelection.Name = NeverLose.RandomString();
	ColorMapSelection.Parent = ColorMap
	ColorMapSelection.AnchorPoint = Vector2.new(0.5, 0.5)
	ColorMapSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ColorMapSelection.BackgroundTransparency = 1.000
	ColorMapSelection.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ColorMapSelection.BorderSizePixel = 0
	ColorMapSelection.Position = UDim2.new(0, 0, 0.5, 0)
	ColorMapSelection.Size = UDim2.new(0, 5, 1, 0)
	ColorMapSelection.ZIndex = ZIndex + 126

	UIStroke_3.Thickness = 2.000
	UIStroke_3.Color = Color3.fromRGB(255, 255, 255)
	UIStroke_3.Parent = ColorMapSelection

	UICorner_5.CornerRadius = UDim.new(0, 3)
	UICorner_5.Parent = ColorMapSelection

	RGBLabel.Name = NeverLose.RandomString();
	RGBLabel.Parent = ColorPickerHandler
	RGBLabel.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
	RGBLabel.BackgroundTransparency = 0.750
	RGBLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RGBLabel.BorderSizePixel = 0
	RGBLabel.Position = UDim2.new(0, 10, 0, 217)
	RGBLabel.Size = UDim2.new(1, -20, 0, 15)
	RGBLabel.ZIndex = ZIndex + 127
	RGBLabel.Font = Enum.Font.GothamBold
	RGBLabel.Text = "#FFFFFF"
	RGBLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	RGBLabel.TextSize = 12.000
	RGBLabel.TextTransparency = 0.400
	RGBLabel.TextXAlignment = Enum.TextXAlignment.Left

	UICorner_6.CornerRadius = UDim.new(0, 4)
	UICorner_6.Parent = RGBLabel

	ColorPickerLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
		if value then
			ColorPickerHandler.Position = UDim2.new(0,HandleFrame.AbsolutePosition.X + 20 , 0 ,HandleFrame.AbsolutePosition.Y + 75);

			NeverLose.PlayAnimate(ColorPickerHandler,SlowyTween , {
				BackgroundTransparency = 0.035
			})

			NeverLose.PlayAnimate(UIStroke,SlowyTween , {
				Transparency = 0.650
			})

			NeverLose.PlayAnimate(SaViMap,SlowyTween , {
				BackgroundTransparency = 0,
				ImageTransparency = 0
			})

			NeverLose.PlayAnimate(UIStroke_2,SlowyTween , {
				Transparency = 0
			})

			NeverLose.PlayAnimate(ColorMap,SlowyTween , {
				BackgroundTransparency = 0
			})

			NeverLose.PlayAnimate(UIStroke_3,SlowyTween , {
				Transparency = 0
			})

			NeverLose.PlayAnimate(RGBLabel,SlowyTween , {
				BackgroundTransparency = 0.750,
				TextTransparency = 0.400
			})

			Shadow:Render(true)
		else
			NeverLose.PlayAnimate(ColorPickerHandler,SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke,SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(SaViMap,SlowyTween , {
				BackgroundTransparency = 1,
				ImageTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke_2,SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(ColorMap,SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke_3,SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(RGBLabel,SlowyTween , {
				BackgroundTransparency = 1,
				TextTransparency = 1
			})

			Shadow:Render(false)
		end;
	end);

	ColorPickerLib.SetRender(false);
	ColorPickerLib.Root = ColorPickerHandler;
	ColorPickerLib.H = 1;
	ColorPickerLib.S = 1;
	ColorPickerLib.V = 1;
	ColorPickerLib.Callback = EmptyFunction;

	function ColorPickerLib:Update()
		local RealColor = Color3.fromHSV(ColorPickerLib.H , ColorPickerLib.S , ColorPickerLib.V);

		NeverLose.PlayAnimate(ColorZoneSelection,ManualTween,{
			Position = UDim2.fromScale(ColorPickerLib.S , 1 - ColorPickerLib.V)
		});

		NeverLose.PlayAnimate(SaViMap,ManualTween,{
			BackgroundColor3 = Color3.fromHSV(ColorPickerLib.H , 1 , 1)
		});

		NeverLose.PlayAnimate(ColorMapSelection,ManualTween,{
			Position = UDim2.fromScale(ColorPickerLib.H,0.5)
		});

		RGBLabel.Text = "#"..RealColor:ToHex();

		ColorPickerLib.Callback(RealColor);
	end;

	function ColorPickerLib:SetValue(Color)
		if typeof(Color) == 'string' then
			Color = Color3.fromHex(Color);
		end;

		local H , S , V = Color:ToHSV();

		ColorPickerLib.H = H;
		ColorPickerLib.S = S;
		ColorPickerLib.V = V;

		ColorPickerLib:Update();
	end;

	ColorPickerLib.IsHold = false;

	NeverLose:AddSignal(ColorPickerHandler.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			ColorPickerLib.IsHold = true;
		end;
	end));

	NeverLose:AddSignal(ColorPickerHandler.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			ColorPickerLib.IsHold = false;
		end;
	end));

	NeverLose:AddSignal(ColorMap.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			ColorPickerLib.IsHold = true;

			while (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or ColorPickerLib.IsHold) do task.wait()
				local ColorY = ColorMap.AbsolutePosition.X
				local ColorYM = ColorY + ColorMap.AbsoluteSize.X;
				local Value = math.clamp(Mouse.X, ColorY, ColorYM)
				local Code = ((Value - ColorY) / (ColorYM - ColorY));

				ColorPickerLib.H = Code;
				ColorPickerLib:Update();
			end;
		end;
	end)));

	NeverLose:AddSignal(SaViMap.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			ColorPickerLib.IsHold = true;

			while (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or ColorPickerLib.IsHold) do task.wait();
				local PosX = SaViMap.AbsolutePosition.X;
				local ScaleX = PosX + SaViMap.AbsoluteSize.X;
				local Value, PosY = math.clamp(Mouse.X, PosX, ScaleX), SaViMap.AbsolutePosition.Y;
				local ScaleY = PosY + SaViMap.AbsoluteSize.Y;
				local Vals = math.clamp(Mouse.Y, PosY, ScaleY);

				ColorPickerLib.S = (Value - PosX) / (ScaleX - PosX);
				ColorPickerLib.V = (1 - ((Vals - PosY) / (ScaleY - PosY)));
				ColorPickerLib:Update();
			end
		end
	end)));

	return ColorPickerLib;
end;

NeverLose.KeyEnum = {
	One = '1',
	Two = '2',
	Three = '3',
	Four = '4',
	Five = '5',
	Six = '6',
	Seven = '7',
	Eight = '8',
	Nine = '9',
	Zero = '0',
	['Minus'] = "-",
	['Plus'] = "+",
	BackSlash = "\\",
	Slash = "/",
	Period = '.',
	Semicolon = ';',
	Colon = ":",
	LeftControl = "LCtrl",
	RightControl = "RCtrl",
	LeftShift = "LShift",
	RightShift = "RShift",
	Return = "Enter",
	LeftBracket = "[",
	RightBracket = "]",
	Quote = "'",
	Comma = ",",
	Equals = "=",
	LeftSuper = "Super",
	RightSuper = "Super",
	LeftAlt = "LAlt",
	RightAlt = "RAlt",
	Escape = "Esc",
};

NeverLose.EnumReverse = {};

for i,v in next , NeverLose.KeyEnum do
	NeverLose.EnumReverse[v] = i;
end;

function NeverLose:KeyCodeToStr(K: Enum.KeyCode)
	if typeof(K) == 'string' then
		if NeverLose.KeyEnum[K] then
			return NeverLose.KeyEnum[K];
		end;

		return K;
	end;

	return (NeverLose.KeyEnum[K.Name] or K.Name);
end;

function NeverLose:StrToKeyCode(str: string)
	if NeverLose.EnumReverse[str] then
		return Enum.KeyCode[NeverLose.EnumReverse[str]];
	end;

	return Enum.KeyCode[str];
end;

function NeverLose:RegisiterHandler(Handler: Frame , Signal)
	local handle = {};
	local ZINdex = Handler.ZIndex;

	function handle:AddToggle(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = false,
			Flag = nil,
			Callback = EmptyFunction,
		});

		local Toggle = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Circle = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")

		Toggle.Name = NeverLose.RandomString();
		Toggle.Parent = Handler
		Toggle.BackgroundColor3 = Color3.fromRGB(10, 13, 21)
		Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Toggle.BorderSizePixel = 0
		Toggle.ClipsDescendants = true
		Toggle.Size = UDim2.new(0, 30, 0, 18)
		Toggle.ZIndex = ZINdex + 13
		Toggle.LayoutOrder = -(#Handler:GetChildren() + 5);

		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = Toggle

		Circle.Name = NeverLose.RandomString();
		Circle.Parent = Toggle
		Circle.AnchorPoint = Vector2.new(0.5, 0.5)
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.BackgroundTransparency = 0.500
		Circle.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Circle.BorderSizePixel = 0
		Circle.Position = UDim2.new(0.300000012, 0, 0.5, 0)
		Circle.Size = UDim2.new(0, 16, 0, 16)
		Circle.ZIndex = ZINdex + 14

		UICorner_2.CornerRadius = UDim.new(1, 0)
		UICorner_2.Parent = Circle

		local ToggleLib = {
			Root = Toggle	
		};

		ToggleLib.SetUI = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(Toggle,SlowyTween,{
					BackgroundTransparency = 0,
					BackgroundColor3 = NeverLose.AccentColor
				})

				NeverLose.PlayAnimate(Circle,SlowyTween,{
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0,
					Position = UDim2.new(0.7, 0, 0.5, 0)
				})
			else
				NeverLose.PlayAnimate(Toggle,SlowyTween,{
					BackgroundTransparency = 0,
					BackgroundColor3 = Color3.fromRGB(10, 13, 21)
				})

				NeverLose.PlayAnimate(Circle,SlowyTween,{
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.500,
					Position = UDim2.new(0.300000012, 0, 0.5, 0)
				})
			end;
		end);

		ToggleLib.SetVisible = LPH_NO_VIRTUALIZE(function(value)
			if value then
				ToggleLib.SetUI(Config.Default);
			else
				NeverLose.PlayAnimate(Toggle,SlowyTween,{
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.fromRGB(10, 13, 21)
				})

				NeverLose.PlayAnimate(Circle,SlowyTween,{
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.300000012, 0, 0.5, 0)
				})
			end;
		end);

		ToggleLib.SetUI(Config.Default);
		ToggleLib.SetVisible(Signal:GetValue());

		NeverLose:CreateInput(Toggle , LPH_NO_VIRTUALIZE(function()
			Config.Default = not Config.Default;

			ToggleLib.SetUI(Config.Default);

			Config.Callback(Config.Default)
		end))

		ToggleLib.Signal = Signal:Connect(ToggleLib.SetVisible);

		function ToggleLib:GetValue()
			return Config.Default;
		end;

		function ToggleLib:SetValue(v)
			Config.Default = v;

			if Signal:GetValue() then
				ToggleLib.SetUI(Config.Default);
			end;

			Config.Callback(Config.Default)
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = ToggleLib;
		end;

		return ToggleLib;
	end;

	function handle:AddSlider(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = 50,
			Min = 0,
			Max = 10,
			Type = "",
			Rounding = 0,
			Nums = {},
			Flag = nil,
			Size = 125,
			Callback = EmptyFunction,
		});

		local SliderLib = {};

		SliderLib.GetSize = LPH_NO_VIRTUALIZE(function()
			return (Config.Default - Config.Min) / (Config.Max - Config.Min);
		end);

		local FullNumSize = TextService:GetTextSize(string.rep("0",(Config.Rounding + #tostring(Config.Max))+1)..tostring(Config.Type),10,Enum.Font.GothamMedium,Vector2.new(math.huge,math.huge));

		SliderLib.MaximumSize = FullNumSize.X;

		if Config.Nums then
			local nszie = 0;

			for i,ns in next , Config.Nums do
				local size = TextService:GetTextSize(string.rep("m",string.len(tostring(ns))),10,Enum.Font.GothamMedium,Vector2.new(math.huge,math.huge));

				if nszie < size.X then
					nszie = size.X;
				end
			end;

			if SliderLib.MaximumSize < nszie then
				SliderLib.MaximumSize = nszie;
			end;
		end;

		local Slider = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local ValueFrame = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ValueLabel = Instance.new("TextBox")
		local SlideMain = Instance.new("Frame")
		local SlideFrame = Instance.new("Frame")
		local UICorner_3 = Instance.new("UICorner")
		local SlideMoving = Instance.new("Frame")
		local UICorner_4 = Instance.new("UICorner")
		local Frame = Instance.new("Frame")
		local UICorner_5 = Instance.new("UICorner")
		local boxSize = 2;

		Slider.Name = NeverLose.RandomString();
		Slider.Parent = Handler
		Slider.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		Slider.BackgroundTransparency = 1.000
		Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Slider.BorderSizePixel = 0
		Slider.ClipsDescendants = false
		Slider.Size = UDim2.new(0, Config.Size, 0, 18)
		Slider.ZIndex = ZINdex + 13
		Slider.LayoutOrder = -(#Handler:GetChildren() + 5);

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Slider

		ValueFrame.Name = NeverLose.RandomString();
		ValueFrame.Parent = Slider
		ValueFrame.AnchorPoint = Vector2.new(1, 0)
		ValueFrame.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		ValueFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueFrame.BorderSizePixel = 0
		ValueFrame.ClipsDescendants = true
		ValueFrame.Position = UDim2.new(1, 0, 0, 0)
		ValueFrame.Size = UDim2.new(0, SliderLib.MaximumSize + boxSize, 0, 18)
		ValueFrame.ZIndex = ZINdex + 13

		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = ValueFrame

		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = ValueFrame

		ValueLabel.Name = NeverLose.RandomString();
		ValueLabel.Parent = ValueFrame
		ValueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.BackgroundTransparency = 1.000
		ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueLabel.BorderSizePixel = 0
		ValueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		ValueLabel.Size = UDim2.new(1, 0, 1, 0)
		ValueLabel.ZIndex = ZINdex + 14
		ValueLabel.Font = Enum.Font.GothamMedium
		ValueLabel.Text = tostring(Config.Default)..tostring(Config.Type);
		ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.TextSize = 10.000
		ValueLabel.ClearTextOnFocus = false;
		ValueLabel.TextTransparency = 0.350

		SlideMain.Name = NeverLose.RandomString();
		SlideMain.Parent = Slider
		SlideMain.AnchorPoint = Vector2.new(0, 0.5)
		SlideMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SlideMain.BackgroundTransparency = 1.000
		SlideMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SlideMain.BorderSizePixel = 0
		SlideMain.Position = UDim2.new(0, 0, 0.5, 0)
		SlideMain.Size = UDim2.new(1, -((SliderLib.MaximumSize + 11)), 0, 18)
		SlideMain.ZIndex = ZINdex + 13

		SlideFrame.Name = NeverLose.RandomString();
		SlideFrame.Parent = SlideMain
		SlideFrame.AnchorPoint = Vector2.new(0, 0.5)
		SlideFrame.BackgroundColor3 = Color3.fromRGB(30, 29, 36)
		SlideFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SlideFrame.BorderSizePixel = 0
		SlideFrame.Position = UDim2.new(0, 0, 0.5, 0)
		SlideFrame.Size = UDim2.new(1, 0, 0, 5)
		SlideFrame.ZIndex = ZINdex + 13

		UICorner_3.CornerRadius = UDim.new(1, 0)
		UICorner_3.Parent = SlideFrame

		SlideMoving.Name = NeverLose.RandomString();
		SlideMoving.Parent = SlideFrame
		SlideMoving.BackgroundColor3 = NeverLose.AccentColor
		SlideMoving.BorderColor3 = Color3.fromRGB(0, 0, 0)
		SlideMoving.BorderSizePixel = 0
		SlideMoving.Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
		SlideMoving.ZIndex = ZINdex + 14

		UICorner_4.CornerRadius = UDim.new(1, 0)
		UICorner_4.Parent = SlideMoving

		Frame.Parent = SlideMoving
		Frame.AnchorPoint = Vector2.new(1, 0.5)
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(1, 5, 0.5, 0)
		Frame.Size = UDim2.new(0, 10, 0, 10)
		Frame.ZIndex = ZINdex + 15

		UICorner_5.CornerRadius = UDim.new(1, 0)
		UICorner_5.Parent = Frame

		local LoadText = LPH_NO_VIRTUALIZE(function()
			if Config.Nums[Config.Default] then
				ValueLabel.Text = Config.Nums[Config.Default]

			else
				ValueLabel.Text = tostring(Config.Default)..tostring(Config.Type);

			end;
		end);

		ValueLabel.FocusLost:Connect(LPH_NO_VIRTUALIZE(function()
			local OutVal = NeverLose:ParseInput(ValueLabel.Text , true);
			if OutVal then
				local rx = math.clamp(OutVal , Config.Min , Config.Max);
				local Value = NeverLose.Rounding(rx,Config.Rounding);

				if Value then
					Config.Default = Value;

					TweenService:Create(SlideMoving , ManualTween ,{
						Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
					}):Play();

					LoadText();

					Config.Callback(Config.Default)
				else
					LoadText();
				end;

			else
				LoadText()
			end;
		end));

		SliderLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(ValueFrame,SlowyTween,{
					BackgroundTransparency = 0,
					Size = UDim2.new(0, SliderLib.MaximumSize + boxSize, 0, 18)
				});

				NeverLose.PlayAnimate(UIStroke,SlowyTween,{
					Transparency = 0.650
				});

				NeverLose.PlayAnimate(ValueLabel,SlowyTween,{
					TextTransparency = 0.350
				});

				NeverLose.PlayAnimate(SlideFrame,SlowyTween,{
					BackgroundTransparency = 0
				});

				NeverLose.PlayAnimate(SlideMoving,SlowyTween,{
					BackgroundTransparency = 0,
					Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
				});

				NeverLose.PlayAnimate(Frame,SlowyTween,{
					BackgroundTransparency = 0
				});
			else
				NeverLose.PlayAnimate(ValueFrame,SlowyTween,{
					BackgroundTransparency = 1,
				});

				NeverLose.PlayAnimate(UIStroke,SlowyTween,{
					Transparency = 1
				});

				NeverLose.PlayAnimate(ValueLabel,SlowyTween,{
					TextTransparency = 1
				});

				NeverLose.PlayAnimate(SlideFrame,SlowyTween,{
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(SlideMoving,SlowyTween,{
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 1, 0)
				});

				NeverLose.PlayAnimate(Frame,SlowyTween,{
					BackgroundTransparency = 1
				});
			end;
		end);

		SliderLib.SetRender(Signal:GetValue());
		SliderLib.Signal = Signal:Connect(SliderLib.SetRender);

		local Update = function(Input)
			local SizeScale = math.clamp((((Input.Position.X) - SlideMain.AbsolutePosition.X) / SlideMain.AbsoluteSize.X), 0, 1);
			local Main = ((Config.Max - Config.Min) * SizeScale) + Config.Min;
			local Value = NeverLose.Rounding(Main,Config.Rounding);
			local PositionX = UDim2.fromScale(SizeScale, 1);
			local Size = ((Value - Config.Min) / (Config.Max - Config.Min)) + 0.02;

			Config.Default = Value;

			TweenService:Create(SlideMoving , ManualTween ,{
				Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
			}):Play();

			LoadText()


			Config.Callback(Value)
		end;

		local IsHold = false;

		do
			SlideMain.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					IsHold = true
					Update(Input)
				end
			end))

			SlideMain.InputEnded:Connect(LPH_NO_VIRTUALIZE(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if UserInputService.TouchEnabled then
						if not NeverLose:IsMouseOverFrame(SlideMain) then
							IsHold = false
						end;
					else
						IsHold = false
					end;
				end
			end))

			UserInputService.InputChanged:Connect(LPH_NO_VIRTUALIZE(function(Input)
				if IsHold then
					if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch)  then
						if UserInputService.TouchEnabled then
							if not NeverLose:IsMouseOverFrame(SlideMain) then
								IsHold = false
							else
								Update(Input)
							end;
						else
							Update(Input)
						end;
					end;
				end;
			end));
		end;

		function SliderLib:GetValue()
			return Config.Default;
		end;

		function SliderLib:SetValue(v)
			Config.Default = v;

			if Signal:GetValue() then
				NeverLose.PlayAnimate(SlideMoving,SlowyTween,{
					BackgroundTransparency = 0,
					Size = UDim2.new(SliderLib.GetSize(), 0, 1, 0)
				});
			end;

			LoadText()

			Config.Callback(Config.Default);
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = SliderLib;
		end;

		return SliderLib;
	end;

	function handle:AddOption(GearIcon)
		local Option = Instance.new("Frame")
		local Icon = Instance.new("TextLabel")
		local UICorner = Instance.new("UICorner")

		Option.Name = NeverLose.RandomString();
		Option.Parent = Handler
		Option.BackgroundColor3 = Color3.fromRGB(19, 19, 21)
		Option.BackgroundTransparency = 1.000
		Option.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Option.BorderSizePixel = 0
		Option.ClipsDescendants = true
		Option.Size = UDim2.new(0, 20, 0, 18)
		Option.ZIndex = ZINdex + 13
		Option.LayoutOrder = -(#Handler:GetChildren() + 5);

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = Option
		Icon.AnchorPoint = Vector2.new(0.5, 0.5)
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		Icon.Size = UDim2.new(1, 0, 1, 0)
		Icon.ZIndex = ZINdex + 14
		Icon.FontFace = NeverLose.BuiltInBold
		Icon.Text = (GearIcon == 1 and 'gear') or (GearIcon == 2 and 'chevron-large-right') or "three-dots-horizontal";
		Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
		Icon.TextSize = 16.000
		Icon.TextTransparency = 0.400
		Icon.TextWrapped = true

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Option

		local Window = NeverLose:CreateOptionWindow(Option , ZINdex + 13);
		local reciveSignal;

		Window.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 0.400
				})
			else
				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 1
				})
			end;
		end);

		Window.SetRender(Signal:GetValue());
		Signal:Connect(Window.SetRender);

		local bthg = NeverLose:CreateInput(Option , LPH_NO_VIRTUALIZE(function()
			if reciveSignal then
				reciveSignal:Disconnect();
				reciveSignal = nil;	
			end;

			Window.Signal:SetValue(true);

			reciveSignal = UserInputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if not NeverLose:IsMouseOverFrame(Window.Root) and not NeverLose:IsMouseOverFrame(Option) then
						if reciveSignal then
							reciveSignal:Disconnect();
							reciveSignal = nil;	
						end;

						Window.Signal:SetValue(false);
					end
				end
			end)
		end));

		NeverLose:AddSignal(bthg.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(Option , SlowyTween , {
				BackgroundTransparency = 0.5
			})

			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.25
			})
		end)));

		NeverLose:AddSignal(bthg.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(Option , SlowyTween , {
				BackgroundTransparency = 1.000
			})

			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.400
			})
		end)));

		return Window;
	end;

	function handle:AddColorPicker(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = Color3.fromRGB(255, 255, 255),
			Callback  = EmptyFunction,
		});

		if typeof(Config.Default) == 'string' then
			Config.Default = Color3.fromHex(Config.Default:gsub('#',''));
		end;

		local ColorPickerLib = {};
		local ColorPicker = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ImageLabel = Instance.new("ImageLabel")
		local UICorner_2 = Instance.new("UICorner")

		ColorPicker.Name = NeverLose.RandomString();
		ColorPicker.Parent = Handler
		ColorPicker.BackgroundColor3 = Config.Default;
		ColorPicker.BackgroundTransparency = 0
		ColorPicker.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ColorPicker.BorderSizePixel = 0
		ColorPicker.ClipsDescendants = true
		ColorPicker.Size = UDim2.new(0, 18, 0, 18)
		ColorPicker.ZIndex = ZINdex + 13
		ColorPicker.LayoutOrder = -(#Handler:GetChildren() + 5);

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = ColorPicker

		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = ColorPicker

		ImageLabel.Parent = ColorPicker
		ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ImageLabel.BorderSizePixel = 0
		ImageLabel.Size = UDim2.new(1, 0, 1, 0)
		ImageLabel.ZIndex = ZINdex + 11
		ImageLabel.Image = "rbxasset://textures/meshPartFallback.png"
		ImageLabel.ImageTransparency = 0.9
		ImageLabel.BackgroundTransparency = 1;
		ImageLabel.ScaleType = Enum.ScaleType.Crop

		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = ImageLabel

		local BackendM = NeverLose:CreateColorPicker(ColorPicker);

		BackendM:SetValue(Config.Default)
		BackendM.Callback = function(color)
			ColorPicker.BackgroundColor3 = color;
			Config.Default = color;
			Config.Callback(Config.Default);
		end;

		local signal;
		NeverLose:CreateInput(ColorPicker , LPH_NO_VIRTUALIZE(function()
			if signal then
				signal:Disconnect();
				signal = nil;
			end;

			BackendM.SetRender(true);

			signal = UserInputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if not NeverLose:IsMouseOverFrame(ColorPicker) and not NeverLose:IsMouseOverFrame(BackendM.Root) then
						if signal then
							signal:Disconnect();
							signal = nil;
						end;

						BackendM.SetRender(false);
					end;
				end;
			end)
		end));

		ColorPickerLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(ColorPicker , SlowyTween , {
					BackgroundTransparency = 0
				})

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 0.650
				})

				NeverLose.PlayAnimate(ImageLabel , SlowyTween , {
					ImageTransparency = 0.9
				})
			else
				NeverLose.PlayAnimate(ColorPicker , SlowyTween , {
					BackgroundTransparency = 1
				})

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 1
				})

				NeverLose.PlayAnimate(ImageLabel , SlowyTween , {
					ImageTransparency = 1
				})
			end;
		end);

		ColorPickerLib.SetRender(Signal:GetValue());
		Signal:Connect(ColorPickerLib.SetRender);

		function ColorPickerLib:GetValue()
			return Config.Default;
		end;

		function ColorPickerLib:SetValue(v)
			Config.Default = v;
			BackendM:SetValue(Config.Default)
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = ColorPickerLib;
		end;

		return ColorPickerLib;
	end;

	function handle:AddKeybind(Config)
		Config = NeverLose:ProcessParams(Config,{
			Default = nil,
			Blacklist = {},
			Callback = EmptyFunction,
			Flag = nil
		});

		local KeybindLib = {};

		local Keybind = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local ValueLabel = Instance.new("TextLabel")

		Keybind.Name = NeverLose.RandomString();
		Keybind.Parent = Handler
		Keybind.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Keybind.BorderSizePixel = 0
		Keybind.ClipsDescendants = true
		Keybind.Size = UDim2.new(0, 45, 0, 18)
		Keybind.ZIndex = ZINdex + 13
		Keybind.LayoutOrder = -(#Handler:GetChildren() + 5);

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Keybind

		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = Keybind

		ValueLabel.Name = NeverLose.RandomString();
		ValueLabel.Parent = Keybind
		ValueLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.BackgroundTransparency = 1.000
		ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ValueLabel.BorderSizePixel = 0
		ValueLabel.ClipsDescendants = true
		ValueLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		ValueLabel.Size = UDim2.new(1, 0, 1, 0)
		ValueLabel.ZIndex = ZINdex + 14
		ValueLabel.Font = Enum.Font.GothamMedium
		ValueLabel.Text = NeverLose:KeyCodeToStr(Config.Default or "None")
		ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		ValueLabel.TextSize = 10.000
		ValueLabel.TextTransparency = 0.500

		KeybindLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(Keybind,SlowyTween, {
					BackgroundTransparency = 0
				})

				NeverLose.PlayAnimate(UIStroke,SlowyTween, {
					Transparency = 0.650
				})

				NeverLose.PlayAnimate(ValueLabel,SlowyTween, {
					TextTransparency = 0.500
				})
			else
				NeverLose.PlayAnimate(Keybind,SlowyTween, {
					BackgroundTransparency = 1
				})

				NeverLose.PlayAnimate(UIStroke,SlowyTween, {
					Transparency = 1
				})

				NeverLose.PlayAnimate(ValueLabel,SlowyTween, {
					TextTransparency = 1
				})
			end;
		end);

		function KeybindLib:Update()
			local size = TextService:GetTextSize(ValueLabel.Text,ValueLabel.TextSize,ValueLabel.Font,Vector2.new(math.huge,math.huge));

			NeverLose.PlayAnimate(Keybind , SlowyTween , {
				Size = UDim2.new(0, size.X + 7, 0, 18)
			})
		end;

		local IsBlacklist = LPH_NO_VIRTUALIZE(function(v)
			return Config.Blacklist and (Config.Blacklist[v] or table.find(Config.Blacklist,v))
		end);

		KeybindLib:Update()

		KeybindLib.SetRender(Signal:GetValue());
		Signal:Connect(KeybindLib.SetRender);

		local IsBinding = false;
		NeverLose:CreateInput(Keybind , function()
			if IsBinding then
				return;
			end;

			IsBinding = true;

			ValueLabel.Text = "...";

			KeybindLib:Update();

			local Selected = nil;

			while not Selected do
				local Key = UserInputService.InputBegan:Wait();

				if Key.KeyCode ~= Enum.KeyCode.Unknown and not IsBlacklist(Key.KeyCode) and not IsBlacklist(Key.KeyCode.Name) then
					Selected = Key.KeyCode;
				else
					if Key.UserInputType == Enum.UserInputType.MouseButton1 and not IsBlacklist(Enum.UserInputType.MouseButton1) and not IsBlacklist("M1B") then
						Selected = "M1B";
					elseif Key.UserInputType == Enum.UserInputType.MouseButton2 and not IsBlacklist(Enum.UserInputType.MouseButton2) and not IsBlacklist("M2B") then
						Selected = "M2B";
					end;
				end;
			end;

			IsBinding = false;

			local KeyName = typeof(Selected) == "string" and Selected or Selected.Name;

			Config.Default = KeyName;

			ValueLabel.Text = NeverLose:KeyCodeToStr(KeyName);

			KeybindLib:Update();

			Config.Callback(KeyName)
		end)

		function KeybindLib:GetValue()
			return Config.Default;
		end;

		function KeybindLib:SetValue(v)
			Config.Default = v;
			ValueLabel.Text = NeverLose:KeyCodeToStr(v);
			KeybindLib:Update();
			Config.Callback(Config.Default);
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = KeybindLib;
		end;

		return KeybindLib;
	end;

	function handle:AddTextInput(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = "",
			Placeholder = "Placeholder",
			Callback = print,
			Flag = nil,
			Size = 100,
			Numeric = false,
		});

		local TextBoxLib = {};

		local TextInput = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local TextBox = Instance.new("TextBox")

		TextInput.Name = NeverLose.RandomString();
		TextInput.Parent = Handler
		TextInput.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		TextInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextInput.BorderSizePixel = 0
		TextInput.ClipsDescendants = true
		TextInput.Size = UDim2.new(0, Config.Size, 0, 18)
		TextInput.ZIndex = ZINdex + 13
		TextInput.LayoutOrder = -(#Handler:GetChildren() + 5);

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = TextInput

		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = TextInput

		TextBox.Parent = TextInput
		TextBox.AnchorPoint = Vector2.new(0, 0.5)
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0, 5, 0.5, 0)
		TextBox.Size = UDim2.new(1, -5, 0, 17)
		TextBox.ZIndex = ZINdex + 14
		TextBox.ClearTextOnFocus = false
		TextBox.Font = Enum.Font.GothamMedium
		TextBox.PlaceholderText = Config.Placeholder
		TextBox.Text = tostring(Config.Default)
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.TextSize = 11.000
		TextBox.TextTransparency = 0.350
		TextBox.TextXAlignment = Enum.TextXAlignment.Left

		TextBoxLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(TextInput , SlowyTween ,{
					BackgroundTransparency = 0
				})	

				NeverLose.PlayAnimate(UIStroke , SlowyTween ,{
					Transparency = 0.650
				})	

				NeverLose.PlayAnimate(TextBox , SlowyTween ,{
					TextTransparency = 0.350
				})	
			else
				NeverLose.PlayAnimate(TextInput , SlowyTween ,{
					BackgroundTransparency = 1
				})	

				NeverLose.PlayAnimate(UIStroke , SlowyTween ,{
					Transparency = 1
				})	

				NeverLose.PlayAnimate(TextBox , SlowyTween ,{
					TextTransparency = 1
				})
			end;
		end);

		NeverLose:AddSignal(TextBox:GetPropertyChangedSignal('Text'):Connect(LPH_NO_VIRTUALIZE(function()
			local valout = NeverLose:ParseInput(TextBox.Text , Config.Numeric);

			if Config.Numeric then
				TextBox.Text = string.gsub(TextBox.Text , '[^0-9.]','')
			end;

			if valout then
				Config.Default = valout;
				Config.Callback(valout);
			end
		end)));

		TextBoxLib.SetRender(Signal:GetValue());
		Signal:Connect(TextBoxLib.SetRender);

		function TextBoxLib:GetValue()
			return Config.Default;
		end;

		function TextBoxLib:SetValue(v)
			Config.Default = v;
			TextBox.Text = tostring(v);
			Config.Callback(Config.Default);
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = TextBoxLib;
		end;

		return TextBoxLib;
	end;

	function handle:AddDropdown(Config)
		Config = NeverLose:ProcessParams(Config , {
			Default = nil,
			Values = {},
			Multi = false,
			Callback = EmptyFunction,
			AutoUpdate = false,
			Flag = nil,
			Size = 100
		})

		Config.Default = NeverLose.ProcessDropdown(Config.Default);

		local Dropdown = Instance.new("Frame")
		local DropdownIcon = Instance.new("TextLabel")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local BasedLabel = Instance.new("TextLabel")

		Dropdown.Name = NeverLose.RandomString();
		Dropdown.Parent = Handler
		Dropdown.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Dropdown.BorderSizePixel = 0
		Dropdown.ClipsDescendants = true
		Dropdown.Size = UDim2.new(0, Config.Size, 0, 18)
		Dropdown.ZIndex = ZINdex + 13
		Dropdown.LayoutOrder = -(#Handler:GetChildren() + 5);

		DropdownIcon.Name = NeverLose.RandomString();
		DropdownIcon.Parent = Dropdown
		DropdownIcon.AnchorPoint = Vector2.new(1, 0.5)
		DropdownIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownIcon.BackgroundTransparency = 1.000
		DropdownIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		DropdownIcon.BorderSizePixel = 0
		DropdownIcon.Position = UDim2.new(1, -2, 0.5, 0)
		DropdownIcon.Size = UDim2.new(0, 18, 0, 18)
		DropdownIcon.ZIndex = ZINdex + 14
		DropdownIcon.FontFace = NeverLose.BuiltInBold
		DropdownIcon.Text = "chevron-small-down"
		DropdownIcon.TextColor3 = Color3.fromRGB(223, 223, 223)
		DropdownIcon.TextSize = 16.000
		DropdownIcon.TextTransparency = 0.250
		DropdownIcon.TextWrapped = true

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Dropdown

		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = Dropdown

		BasedLabel.Name = NeverLose.RandomString();
		BasedLabel.Parent = Dropdown
		BasedLabel.AnchorPoint = Vector2.new(0, 0.5)
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.ClipsDescendants = true
		BasedLabel.Position = UDim2.new(0, 5, 0.5, 0)
		BasedLabel.Size = UDim2.new(1, -25, 0, 15)
		BasedLabel.ZIndex = ZINdex + 14
		BasedLabel.Font = Enum.Font.GothamMedium
		BasedLabel.Text = NeverLose.ParseDropdown(Config.Default);
		BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.TextSize = 12.000
		BasedLabel.TextTransparency = 0.5
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

		do
			local UIGradient = Instance.new("UIGradient")

			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.85, 0.23), NumberSequenceKeypoint.new(1.00, 1.00)}
			UIGradient.Parent = BasedLabel;
		end;

		NeverLose:AddSignal(Dropdown.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.200
			})
		end)));

		NeverLose:AddSignal(Dropdown.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.5
			})
		end)));

		local DropdownLib = {
			OpenSignal = NeverLose:CreateSignal(false),
			Signals = {},
			Refuse = {},
		};

		DropdownLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(Dropdown , SlowyTween , {
					BackgroundTransparency = 0
				});

				NeverLose.PlayAnimate(DropdownIcon , SlowyTween , {
					TextTransparency = 0.250
				});

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 0.650
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.5
				});
			else
				NeverLose.PlayAnimate(Dropdown , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(DropdownIcon , SlowyTween , {
					TextTransparency = 1
				});

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				});
			end
		end);

		DropdownLib.SetRender(Signal:GetValue())
		Signal:Connect(DropdownLib.SetRender);
		DropdownLib.ExtentSize = 0;

		do
			local DropdownHandler = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIStroke = Instance.new("UIStroke")
			local DropdownScrollFrame = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local Shadow = NeverLose:CreateShadow(DropdownHandler);

			DropdownHandler.Name = NeverLose.RandomString();
			DropdownHandler.Parent = NeverLose.ScreenGui;
			DropdownHandler.AnchorPoint = Vector2.new(0.5, 0)
			DropdownHandler.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
			DropdownHandler.BackgroundTransparency = 0.5
			DropdownHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropdownHandler.BorderSizePixel = 0
			DropdownHandler.ClipsDescendants = true
			DropdownHandler.Position = UDim2.new(255,255,255,255)
			DropdownHandler.Size = UDim2.new(0, 125, 0, 50)
			DropdownHandler.ZIndex = ZINdex + 125
			DropdownLib.BlockRoot = DropdownHandler;

			NeverLose:AddSignal(DropdownHandler:GetPropertyChangedSignal('BackgroundTransparency'):Connect(function()
				if DropdownHandler.BackgroundTransparency > 0.9 then
					DropdownHandler.Visible = false;
					DropdownHandler.Parent = nil;
				else
					DropdownHandler.Visible = true;

					if NeverLose.Global3DRenderMode then
						DropdownHandler.Parent = NeverLose.GlobalSurfaceGui;
					else
						DropdownHandler.Parent = NeverLose.ScreenGui;
					end;
				end;
			end));

			UICorner.CornerRadius = UDim.new(0, 10)
			UICorner.Parent = DropdownHandler

			UIStroke.Transparency = 0.650
			UIStroke.Color = Color3.fromRGB(45, 48, 58)
			UIStroke.Parent = DropdownHandler

			DropdownScrollFrame.Name = NeverLose.RandomString();
			DropdownScrollFrame.Parent = DropdownHandler
			DropdownScrollFrame.Active = true
			DropdownScrollFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			DropdownScrollFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropdownScrollFrame.BackgroundTransparency = 1.000
			DropdownScrollFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropdownScrollFrame.BorderSizePixel = 0
			DropdownScrollFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
			DropdownScrollFrame.Size = UDim2.new(1, -5, 1, -5)
			DropdownScrollFrame.ZIndex = ZINdex + 127
			DropdownScrollFrame.ScrollBarThickness = 0

			DropdownLib.RootItem = DropdownScrollFrame;

			UIListLayout.Parent = DropdownScrollFrame
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

			NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
				DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y)
				NeverLose.PlayAnimate(DropdownHandler , SlowyTween , {
					Size = UDim2.new(0, (Dropdown.AbsoluteSize.X + 5) + DropdownLib.ExtentSize, 0, math.min(UIListLayout.AbsoluteContentSize.Y + 5, 250));
				})
			end)));

			local SetPosition = LPH_NO_VIRTUALIZE(function()
				if NeverLose:MoreThanHalfY(Dropdown.AbsolutePosition.Y + 85) then
					DropdownHandler.AnchorPoint = Vector2.new(0.5,1)
				else
					DropdownHandler.AnchorPoint = Vector2.new(0.5,0)
				end;

				DropdownHandler.Position = UDim2.fromOffset(Dropdown.AbsolutePosition.X + (DropdownHandler.AbsoluteSize.X / 2), Dropdown.AbsolutePosition.Y + 85);

			end);

			DropdownLib.SetFrameRender = LPH_NO_VIRTUALIZE(function(value)
				DropdownLib.OpenSignal:SetValue(value);

				if value then
					Shadow:Render(true);

					DropdownHandler.Size = UDim2.new(0, (Dropdown.AbsoluteSize.X + 5) + DropdownLib.ExtentSize, 0, math.min(UIListLayout.AbsoluteContentSize.Y + 5, 250));

					SetPosition();

					NeverLose.PlayAnimate(DropdownHandler , SlowyTween , {
						BackgroundTransparency = 0.035
					})

					if Config.AutoUpdate then
						DropdownLib:Generate();
					end;
				else

					NeverLose.PlayAnimate(DropdownHandler , SlowyTween , {
						BackgroundTransparency = 1
					})

					Shadow:Render(false);
				end;
			end);

			DropdownLib.SetFrameRender(false);
		end;

		local SecureSignal;
		NeverLose:CreateInput(Dropdown , LPH_NO_VIRTUALIZE(function()
			if SecureSignal then
				SecureSignal:Disconnect();
				SecureSignal = nil;
			end;

			DropdownLib.SetFrameRender(true);
			NeverLose.IsMosueOverOtherFrame = true;

			SecureSignal = UserInputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if not NeverLose:IsMouseOverFrame(DropdownLib.BlockRoot) and not NeverLose:IsMouseOverFrame(Dropdown) then
						if SecureSignal then
							SecureSignal:Disconnect();
							SecureSignal = nil;
						end;

						NeverLose.IsMosueOverOtherFrame = false;
						DropdownLib.SetFrameRender(false);
					end;
				end
			end)
		end))

		DropdownLib.IsMatch = LPH_NO_VIRTUALIZE(function(v1)
			if typeof(Config.Default) =='table' then
				if Config.Default[v1] or table.find(Config.Default , v1) then
					return true;
				end
			end

			if Config.Default == v1 then
				return true;
			end;
		end);

		function DropdownLib:Generate()
			for i,v in next , DropdownLib.RootItem:GetChildren() do
				if v:IsA('Frame') then
					v:Destroy();
				end;
			end;

			for i,v in next , DropdownLib.Signals do
				v:Disconnect();
			end;

			table.clear(DropdownLib.Signals);
			table.clear(DropdownLib.Refuse);

			local Lastone;
			for i,Value in next , Config.Values do
				local ItemFrame = Instance.new("Frame")
				local ItemLabel = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")

				ItemFrame.Name = NeverLose.RandomString();
				ItemFrame.Parent = DropdownLib.RootItem
				ItemFrame.BackgroundColor3 = Color3.fromRGB(29, 31, 38)
				ItemFrame.BackgroundTransparency = 1.000
				ItemFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ItemFrame.BorderSizePixel = 0
				ItemFrame.Size = UDim2.new(1, 0, 0, 25)
				ItemFrame.ZIndex = ZINdex + 1258

				ItemLabel.Name = NeverLose.RandomString();
				ItemLabel.Parent = ItemFrame
				ItemLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ItemLabel.BackgroundTransparency = 1.000
				ItemLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ItemLabel.BorderSizePixel = 0
				ItemLabel.Position = UDim2.new(0, 15, 0, 4)
				ItemLabel.Size = UDim2.new(0,1, 0, 15)
				ItemLabel.ZIndex = ZINdex + 1258
				ItemLabel.Font = Enum.Font.GothamMedium
				ItemLabel.Text = tostring(Value);
				ItemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				ItemLabel.TextSize = 13.000
				ItemLabel.TextTransparency = 0.200
				ItemLabel.TextXAlignment = Enum.TextXAlignment.Left

				UICorner.CornerRadius = UDim.new(0, 10)
				UICorner.Parent = ItemFrame
				local sizetext = TextService:GetTextSize(ItemLabel.Text , ItemLabel.TextSize,ItemLabel.Font,Vector2.new(math.huge,math.huge));

				DropdownLib.ExtentSize = math.max(DropdownLib.ExtentSize , sizetext.X);

				local MIcon , MarkItem = nil , nil;

				if Config.Multi then
					local Icon = Instance.new("TextLabel")

					Icon.Parent = ItemFrame;
					Icon.AnchorPoint = Vector2.new(0, 0.5)
					Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Icon.BackgroundTransparency = 1.000
					Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Icon.BorderSizePixel = 0
					Icon.Position = UDim2.new(0, 5, 0.5, 0)
					Icon.Size = UDim2.new(0, 20, 0, 20)
					Icon.ZIndex = ZINdex + 1259
					Icon.FontFace = NeverLose.BuiltInBold;
					Icon.Text = "check"
					Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
					Icon.TextSize = 18.000
					Icon.TextTransparency = 1
					Icon.TextWrapped = true;

					local VisiblewOfMult = LPH_NO_VIRTUALIZE(function()
						if DropdownLib.IsMatch(Value) then
							NeverLose.PlayAnimate(ItemLabel , VSlowTween , {
								TextTransparency = 0.200,
								Position = UDim2.new(0, 30, 0, 4)
							})

							NeverLose.PlayAnimate(Icon , vs , {
								TextTransparency = 0.250
							})

							Lastone = ItemLabel;
						else

							NeverLose.PlayAnimate(Icon , SlowyTween , {
								TextTransparency = 1
							})

							NeverLose.PlayAnimate(ItemLabel , VSlowTween , {
								TextTransparency = 0.5,
								Position = UDim2.new(0, 15, 0, 4)
							})
						end;
					end);

					MIcon = Icon;
					MarkItem = VisiblewOfMult;
				else
					local DefaultVisible = LPH_NO_VIRTUALIZE(function()
						if DropdownLib.IsMatch(Value) then
							NeverLose.PlayAnimate(ItemLabel , SlowyTween , {
								TextTransparency = 0.200
							})

							Lastone = ItemLabel;
						else
							NeverLose.PlayAnimate(ItemLabel , SlowyTween , {
								TextTransparency = 0.5
							})
						end;
					end);

					MarkItem = DefaultVisible;
				end;

				MarkItem();

				table.insert(DropdownLib.Refuse , MarkItem)

				table.insert(DropdownLib.Signals,ItemFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(ItemFrame , SlowyTween , {
						BackgroundTransparency = 0.1
					})
				end)));

				table.insert(DropdownLib.Signals,ItemFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(ItemFrame , SlowyTween , {
						BackgroundTransparency = 1
					})
				end)));

				table.insert(DropdownLib.Signals , DropdownLib.OpenSignal:Connect(LPH_NO_VIRTUALIZE(function(val)
					if val then
						MarkItem();
					else
						NeverLose.PlayAnimate(ItemLabel , SlowyTween , {
							TextTransparency = 1
						})

						if MIcon then
							NeverLose.PlayAnimate(MIcon , SlowyTween , {
								TextTransparency = 1
							})
						end;
					end;
				end)));

				if Config.Multi then
					local _,bth_signal = NeverLose:CreateInput(ItemFrame , LPH_NO_VIRTUALIZE(function()
						Config.Default[Value] = not Config.Default[Value];

						MarkItem();

						BasedLabel.Text = NeverLose.ParseDropdown(Config.Default);

						Config.Callback(Config.Default);
					end));

					table.insert(DropdownLib.Signals , bth_signal);
				else
					local _,bth_signal = NeverLose:CreateInput(ItemFrame , LPH_NO_VIRTUALIZE(function()
						Config.Default = Value;

						for i,v in next , DropdownLib.Refuse do
							task.spawn(v);
						end;

						BasedLabel.Text = NeverLose.ParseDropdown(Config.Default);

						Config.Callback(Config.Default);
					end));

					table.insert(DropdownLib.Signals , bth_signal);
				end;
			end;
		end;

		DropdownLib:Generate();

		function DropdownLib:GetValue()
			return Config.Default;
		end;

		function DropdownLib:SetValue(v)
			Config.Default = v;

			BasedLabel.Text = NeverLose.ParseDropdown(Config.Default);

			for i,v in next , DropdownLib.Refuse do
				task.spawn(v);
			end;

			Config.Callback(Config.Default);
		end;

		function DropdownLib:SetValues(a)
			Config.Values = a;

			if not Config.AutoUpdate then
				DropdownLib:Generate();
			end;
		end;

		if Config.Flag then
			NeverLose.Flags[Config.Flag] = DropdownLib;
		end;

		return DropdownLib;
	end;

	return handle;
end;

NeverLose.ProcessDropdown = LPH_NO_VIRTUALIZE(function(value)
	if typeof(value) == 'table' then
		local data = {};

		for i,v in next , value do
			if typeof(v) == 'boolean' and typeof(i) ~= 'number' then
				data[i] = v;
			else
				data[v] = true;
			end;
		end;

		return data;
	else
		return value;
	end;
end);

NeverLose.ParseDropdown = LPH_NO_VIRTUALIZE(function(value)
	if not value then return 'Select'; end;

	local Out;

	if typeof(value) == 'table' then
		if #value > 0 then
			local x = {};

			for i,v in next , value do
				table.insert(x , tostring(v))
			end;

			Out = table.concat(x,' , ');

			table.clear(x);
		else
			local x = {};

			for i,v in next , value do
				if v == true then
					table.insert(x , tostring(i));
				end			
			end;

			Out = table.concat(x,' , ');

			table.clear(x)

			if not Out:byte() then
				Out = 'Select';
			end
		end;
	else
		Out = tostring(value or 'Select');
	end;

	return Out;
end);

function NeverLose:ParseInput(Value , Numeric)
	if not Value then
		return (Numeric and nil) or "";	
	end;

	if Numeric then
		local out = string.gsub(tostring(Value), '[^0-9.%-]', '')

		if tonumber(out) then
			return tonumber(out);
		end;

		return nil;
	end;

	return Value;
end;

function NeverLose:CreateToolTips(Container: Frame , Name: string , Content: string)
	local Tooltips = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local TooltipName = Instance.new("TextLabel")
	local TooltipContent = Instance.new("TextLabel")
	local Shadow = NeverLose:CreateShadow(Tooltips);

	Tooltips.Name = NeverLose.RandomString();
	Tooltips.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
	Tooltips.BackgroundTransparency = 0.075
	Tooltips.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tooltips.BorderSizePixel = 0
	Tooltips.ClipsDescendants = true
	Tooltips.Position = UDim2.new(255,255,255,255)
	Tooltips.Size = UDim2.new(0,0,0,0)
	Tooltips.ZIndex = 130

	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = Tooltips

	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = Tooltips

	TooltipName.Name = NeverLose.RandomString();
	TooltipName.Parent = Tooltips
	TooltipName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TooltipName.BackgroundTransparency = 1.000
	TooltipName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TooltipName.BorderSizePixel = 0
	TooltipName.Position = UDim2.new(0, 15, 0, 5)
	TooltipName.Size = UDim2.new(0, 1, 0, 20)
	TooltipName.ZIndex = 132
	TooltipName.Font = Enum.Font.GothamBold
	TooltipName.Text = Name
	TooltipName.TextColor3 = Color3.fromRGB(255, 255, 255)
	TooltipName.TextSize = 15.000
	TooltipName.TextXAlignment = Enum.TextXAlignment.Left

	TooltipContent.Name = NeverLose.RandomString();
	TooltipContent.Parent = Tooltips
	TooltipContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TooltipContent.BackgroundTransparency = 1.000
	TooltipContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TooltipContent.BorderSizePixel = 0
	TooltipContent.Position = UDim2.new(0, 15, 0, 30)
	TooltipContent.Size = UDim2.new(0, 1, 0, 15)
	TooltipContent.ZIndex = 132
	TooltipContent.Font = Enum.Font.GothamBold
	TooltipContent.Text = Content
	TooltipContent.TextColor3 = Color3.fromRGB(255, 255, 255)
	TooltipContent.TextSize = 12.000
	TooltipContent.TextTransparency = 0.650
	TooltipContent.TextXAlignment = Enum.TextXAlignment.Left
	TooltipContent.TextYAlignment = Enum.TextYAlignment.Top

	local ToolTip = {};

	ToolTip.Update = LPH_NO_VIRTUALIZE(function()
		local SizeName = TextService:GetTextSize(TooltipName.Text , TooltipName.TextSize , TooltipName.Font , Vector2.new(math.huge,math.huge));
		local SizeContent = TextService:GetTextSize(TooltipContent.Text , TooltipContent.TextSize , TooltipContent.Font , Vector2.new(math.huge,math.huge));

		local MaxX = math.max(SizeName.X , SizeContent.X) + 65;
		local MaxY = SizeName.Y + SizeContent.Y + 30;

		NeverLose.PlayAnimate(Tooltips,SlowyTween , {
			Size = UDim2.new(0,MaxX,0,MaxY)
		})
	end)

	NeverLose:AddSignal(Tooltips:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
		if Tooltips.BackgroundTransparency > 0.9 then
			Tooltips.Visible = false;
			Tooltips.Parent = nil;
		else
			Tooltips.Visible = true;

			if NeverLose.Global3DRenderMode then
				Tooltips.Parent = NeverLose.GlobalSurfaceGui;
			else
				Tooltips.Parent = NeverLose.ScreenGui;
			end;
		end
	end)));

	ToolTip.SetRender = LPH_NO_VIRTUALIZE(function(value)
		if value then
			Tooltips.Position = UDim2.fromOffset(Container.AbsolutePosition.X + Container.AbsoluteSize.X , Container.AbsolutePosition.Y + (Container.AbsoluteSize.Y + 25));

			NeverLose.PlayAnimate(Tooltips , SlowyTween , {
				BackgroundTransparency = 0.075
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			})

			NeverLose.PlayAnimate(TooltipName , SlowyTween , {
				TextTransparency = 0
			})

			NeverLose.PlayAnimate(TooltipContent , SlowyTween , {
				TextTransparency = 0.650
			})

			ToolTip.Update();
			Shadow:Render(true);
		else
			NeverLose.PlayAnimate(Tooltips , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(TooltipName , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(TooltipContent , SlowyTween , {
				TextTransparency = 1
			})

			Shadow:Render(false);
		end;
	end);

	ToolTip.SetRender(false);
	ToolTip.Update();

	local DelayThread;
	NeverLose:AddSignal(Container.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
		if DelayThread then
			task.cancel(DelayThread);
			DelayThread = nil;
		end;

		DelayThread = task.delay(1,ToolTip.SetRender,true);
	end)));

	NeverLose:AddSignal(Container.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
		if DelayThread then
			task.cancel(DelayThread);
			DelayThread = nil;
		end;

		ToolTip.SetRender(false);
		ToolTip.Update();
	end)))

	return ToolTip;
end;

function NeverLose:RegisiterItem(Frame: Frame , Signel)
	local idx = {};
	local LayerIndex = Frame.ZIndex;

	function idx:AddLabel(Name: string,Warp: boolean)
		local BasedFrame = Instance.new("Frame")
		local BasedLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local BasedHandler = Instance.new("Frame")
		local UIListLayout = Instance.new("UIListLayout")
		local UICorner = Instance.new("UICorner")

		BasedFrame.Name = NeverLose.RandomString();
		BasedFrame.Parent = Frame
		BasedFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		BasedFrame.BackgroundTransparency = 1.000
		BasedFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedFrame.BorderSizePixel = 0
		BasedFrame.Size = UDim2.new(1, 0, 0, 30)
		BasedFrame.ZIndex = LayerIndex + 8

		NeverLose:AddQuery(BasedFrame , Name);

		BasedLabel.Name = NeverLose.RandomString();
		BasedLabel.Parent = BasedFrame
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.Position = UDim2.new(0, 11, 0, 6)
		BasedLabel.Size = UDim2.new(0,1, 0, 15)
		BasedLabel.ZIndex = LayerIndex + 9
		BasedLabel.Font = Enum.Font.GothamMedium
		BasedLabel.Text = Name
		BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.TextSize = 13.000
		BasedLabel.TextTransparency = 0.35
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

		LineFrame.Name = NeverLose.RandomString();
		LineFrame.Parent = BasedFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11

		BasedHandler.Name = NeverLose.RandomString();
		BasedHandler.Parent = BasedFrame
		BasedHandler.AnchorPoint = Vector2.new(1, 0)
		BasedHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedHandler.BackgroundTransparency = 1.000
		BasedHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedHandler.BorderSizePixel = 0
		BasedHandler.Position = UDim2.new(1, -11, 0, 2)
		BasedHandler.Size = UDim2.new(1, -20, 0, 25)
		BasedHandler.ZIndex = LayerIndex + 12

		UIListLayout.Parent = BasedHandler
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout.Padding = UDim.new(0, 5)

		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = BasedFrame

		local UpdateWarp = LPH_NO_VIRTUALIZE(function()
			local size = TextService:GetTextSize(BasedLabel.Text , BasedLabel.TextSize , BasedLabel.Font , Vector2.new(math.huge,math.huge));
			NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
				Size = UDim2.new(1, 0, 0, size.Y + 13);
			})

			BasedLabel.Size = UDim2.new(1, -35, 1, 0)
			BasedLabel.TextYAlignment = Enum.TextYAlignment.Top;
		end);

		if Warp then
			UpdateWarp();
		end;

		local handle = NeverLose:RegisiterHandler(BasedHandler , Signel);

		handle.Root = BasedFrame;

		handle.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.35
				})

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 0.650
				})
			else
				NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				})

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 1
				})
			end;
		end);

		function handle:SetVisible(val)
			BasedFrame.Visible = val;
		end;

		NeverLose:AddSignal(BasedFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
				BackgroundTransparency = 0.35
			});

			NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.25
			})

		end)))

		NeverLose:AddSignal(BasedFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(BasedFrame , SlowyTween , {
				BackgroundTransparency = 1
			});

			NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
				TextTransparency = 0.35
			})
		end)))

		function handle:SetText(t)
			local oldtxt = BasedLabel.Text;

			BasedLabel.Text = t;

			if Warp and oldtxt ~= t then
				UpdateWarp();
			end;
		end;

		function handle:ToolTip(Content: string)
			handle.ToolTip = NeverLose:CreateToolTips(BasedFrame , Name , Content);

			return handle;
		end;

		handle.SetRender(Signel:GetValue());
		Signel:Connect(handle.SetRender);

		return handle;
	end;

	function idx:AddButton(Config)
		Config = NeverLose:ProcessParams(Config , {
			Icon = 'chevron-large-left',
			Name = "Button",
			Callback = EmptyFunction,
			ToolTip = nil,
		});

		local Button = {};
		local ButtonFrame = Instance.new("Frame")
		local BasedLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Icon = Instance.new("TextLabel")

		NeverLose:AddQuery(ButtonFrame , Config.Name);

		ButtonFrame.Name = NeverLose.RandomString();
		ButtonFrame.Parent = Frame
		ButtonFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		ButtonFrame.BackgroundTransparency = 1.000
		ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ButtonFrame.BorderSizePixel = 0
		ButtonFrame.Size = UDim2.new(1, 0, 0, 30)
		ButtonFrame.ZIndex = LayerIndex + 8

		BasedLabel.Name = NeverLose.RandomString();
		BasedLabel.Parent = ButtonFrame
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.Position = UDim2.new(0, 35, 0, 6)
		BasedLabel.Size = UDim2.new(0,1, 0, 15)
		BasedLabel.ZIndex = LayerIndex + 9
		BasedLabel.Font = Enum.Font.GothamMedium
		BasedLabel.Text = Config.Name;
		BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.TextSize = 13.000
		BasedLabel.TextTransparency = 0.200
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

		LineFrame.Name = NeverLose.RandomString();
		LineFrame.Parent = ButtonFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11

		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = ButtonFrame

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = ButtonFrame
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 11, 0, 5)
		Icon.Size = UDim2.new(0, 18, 0, 18)
		Icon.ZIndex = LayerIndex + 9
		Icon.FontFace = NeverLose.BuiltInBold
		Icon.Text = Config.Icon
		Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
		Icon.TextSize = 16.000
		Icon.TextTransparency = 0.250
		Icon.TextWrapped = true

		function Button:SetText(t)
			BasedLabel.Text = t;
		end;

		function Button:SetIcon(t)
			Icon.Text = t
		end;

		local bth = NeverLose:CreateInput(ButtonFrame , LPH_NO_VIRTUALIZE(function()
			Config.Callback();
		end));

		NeverLose:AddSignal(bth.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(ButtonFrame , SlowyTween , {
				BackgroundTransparency = 0.35
			});
		end)))

		NeverLose:AddSignal(bth.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(ButtonFrame , SlowyTween , {
				BackgroundTransparency = 1
			});
		end)))

		Button.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(ButtonFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.200
				});

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 0.650
				});

				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 0.250
				});
			else
				NeverLose.PlayAnimate(ButtonFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				});

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 1
				});
			end;
		end);

		if Config.ToolTip then
			Button.ToolTip = NeverLose:CreateToolTips(ButtonFrame , Config.Name , Config.ToolTip);
		end;

		Button.SetRender(Signel:GetValue())
		Signel:Connect(Button.SetRender);

		return Button;
	end;

	function idx:AddUserFrame(Name : string , Profile: string , Expires : string)
		local UserFrame = Instance.new("Frame")
		local UserLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local LogoImage = Instance.new("ImageLabel")
		local UICorner_2 = Instance.new("UICorner")
		local UserStatusLabel = Instance.new("TextLabel")

		UserFrame.Name = NeverLose.RandomString();
		UserFrame.Parent = Frame
		UserFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		UserFrame.BackgroundTransparency = 1.000
		UserFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UserFrame.BorderSizePixel = 0
		UserFrame.Size = UDim2.new(1, 0, 0, 60)
		UserFrame.ZIndex = LayerIndex + 8

		UserLabel.Name = NeverLose.RandomString();
		UserLabel.Parent = UserFrame
		UserLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		UserLabel.BackgroundTransparency = 1.000
		UserLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UserLabel.BorderSizePixel = 0
		UserLabel.Position = UDim2.new(0, 65, 0, 10)
		UserLabel.Size = UDim2.new(1, -35, 0, 15)
		UserLabel.ZIndex = LayerIndex + 9
		UserLabel.Font = Enum.Font.GothamMedium
		UserLabel.Text = Name or 'User'
		UserLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		UserLabel.TextSize = 13.000
		UserLabel.TextTransparency = 0.200
		UserLabel.TextXAlignment = Enum.TextXAlignment.Left

		LineFrame.Name = NeverLose.RandomString();
		LineFrame.Parent = UserFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = LayerIndex + 11

		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = UserFrame

		LogoImage.Name = NeverLose.RandomString();
		LogoImage.Parent = UserFrame
		LogoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LogoImage.BackgroundTransparency = 1.000
		LogoImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogoImage.BorderSizePixel = 0
		LogoImage.Position = UDim2.new(0, 10, 0, 5)
		LogoImage.Size = UDim2.new(0, 45, 0, 45)
		LogoImage.ZIndex = LayerIndex + 9
		LogoImage.Image = Profile or "rbxasset://textures/ui/clb_robux_20@3x.png";

		UICorner_2.CornerRadius = UDim.new(1, 0)
		UICorner_2.Parent = LogoImage

		UserStatusLabel.Name = NeverLose.RandomString();
		UserStatusLabel.Parent = UserFrame
		UserStatusLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		UserStatusLabel.BackgroundTransparency = 1.000
		UserStatusLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		UserStatusLabel.BorderSizePixel = 0
		UserStatusLabel.Position = UDim2.new(0, 65, 0, 25)
		UserStatusLabel.Size = UDim2.new(1, -35, 0, 15)
		UserStatusLabel.ZIndex = LayerIndex + 9
		UserStatusLabel.Font = Enum.Font.GothamMedium
		UserStatusLabel.Text = Expires or 'Never'
		UserStatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		UserStatusLabel.TextSize = 13.000
		UserStatusLabel.TextTransparency = 0.200
		UserStatusLabel.TextXAlignment = Enum.TextXAlignment.Left

		local UserFrameItem = {};

		UserFrameItem.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				NeverLose.PlayAnimate(UserLabel,SlowyTween,{
					TextTransparency = 0.200
				})

				NeverLose.PlayAnimate(LineFrame,SlowyTween,{
					BackgroundTransparency = 0.650
				})

				NeverLose.PlayAnimate(LogoImage,SlowyTween,{
					ImageTransparency = 0
				})

				NeverLose.PlayAnimate(UserStatusLabel,SlowyTween,{
					TextTransparency = 0.200
				})
			else
				NeverLose.PlayAnimate(UserLabel,SlowyTween,{
					TextTransparency = 1
				})

				NeverLose.PlayAnimate(LineFrame,SlowyTween,{
					BackgroundTransparency = 1
				})

				NeverLose.PlayAnimate(LogoImage,SlowyTween,{
					ImageTransparency = 1
				})

				NeverLose.PlayAnimate(UserStatusLabel,SlowyTween,{
					TextTransparency = 1
				})
			end;
		end);

		UserFrameItem.SetRender(Signel:GetValue())
		Signel:Connect(UserFrameItem.SetRender);

		function UserFrameItem:SetUsername(name)
			UserLabel.Text = name or 'User'
		end;

		function UserFrameItem:SetProfile(Profile)
			LogoImage.Image = Profile or "rbxasset://textures/ui/clb_robux_20@3x.png";
		end;

		function UserFrameItem:SetExpires(Exp)
			UserStatusLabel.Text = Exp or 'Never';
		end;

		return UserFrameItem;
	end;

	return idx;
end;

function NeverLose:CreateWindow(Config)
	Config = NeverLose:ProcessParams(Config , {
		Logo = NeverLose.GlobalLogo,
		Name = "Neverlose",
		Content = "Counter-Strike 2",
		Size = UDim2.new(0, 640, 0, 480),
		ConfigFolder = "NeverLoseConfigs",
		Enable3DRenderer = false,
		Keybind = "Insert"
	});

	
	-- Auto-size for mobile
if NeverLose.IsMobile then
    Config.Size = NeverLose.Scales.Mobile
end


	local Window = {
		Logo = Config.Logo,
		Name = Config.Name,
		Content = Config.Content,
		Size = Config.Size,
		ConfigFolder = Config.ConfigFolder,
		Signal = NeverLose:CreateSignal(true),
		Tabs = {},
		CurrentTab = 1,
		Keybind = Config.Keybind,
		Enable3DRenderer = Config.Enable3DRenderer
	};

	NeverLose.GlobalLogo = Window.Logo;

	local Logging = NeverLose:CreateLogger();
	if not isfolder(Window.ConfigFolder) then
		makefolder(Window.ConfigFolder);
	end;

	local WindowFrame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local LeftMenuFrame = Instance.new("Frame")
	local HeadFrame = Instance.new("Frame")
	local LogoImage = Instance.new("ImageLabel")
	local UICorner_2 = Instance.new("UICorner")
	local WindowName = Instance.new("TextLabel")
	local WindowContent = Instance.new("TextLabel")
	local LineFrame = Instance.new("Frame")
	local LeftScrollingFrame = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local BottomFrame = Instance.new("Frame")
	local AccountProfile = Instance.new("ImageLabel")
	local UICorner_3 = Instance.new("UICorner")
	local AccountName = Instance.new("TextLabel")
	local ExpireLabel = Instance.new("TextLabel")
	local LineFrame_2 = Instance.new("Frame")
	local UserSettingButton = Instance.new("TextLabel")
	local RightMenuFrame = Instance.new("Frame")
	local UIStroke = Instance.new("UIStroke")
	local UICorner_4 = Instance.new("UICorner")
	local RightHeader = Instance.new("Frame")
	local LineFrame_3 = Instance.new("Frame")
	local ConfigFrame = Instance.new("Frame")
	local UIStroke_2 = Instance.new("UIStroke")
	local UICorner_5 = Instance.new("UICorner")
	local ConfigIcon = Instance.new("TextLabel")
	local LineFrame_4 = Instance.new("Frame")
	local ConfigName = Instance.new("TextLabel")
	local ConfigBthIcon = Instance.new("TextLabel")
	local SearchFrame = Instance.new("Frame")
	local SearchIcon = Instance.new("TextLabel")
	local SearchBox = Instance.new("TextBox")
	local TabContainer = Instance.new("Frame")

	WindowFrame.Name = NeverLose.RandomString();
	WindowFrame.Parent = NeverLose.ScreenGui;
	WindowFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	WindowFrame.BackgroundColor3 = Color3.fromRGB(19, 19, 21)
	WindowFrame.BackgroundTransparency = 0
	WindowFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowFrame.BorderSizePixel = 0
	WindowFrame.ClipsDescendants = true
	WindowFrame.Position = UDim2.new(255, 0, 255, 0)
	WindowFrame.Size = Window.Size
	WindowFrame.Active = true;

	if not NeverLose.EnabledBlur then
		WindowFrame.BackgroundTransparency = 0
	end;

	local renderParentWindow = LPH_NO_VIRTUALIZE(function()
		if Window.__3DRender then
			if WindowFrame.BackgroundTransparency > 0.9 then
				WindowFrame.Visible = false;
				WindowFrame.Parent = nil
			else
				WindowFrame.Visible = true;

				NeverLose.PlayAnimate(WindowFrame,VSlowTween , {
					Position = UDim2.fromScale(0.5,0.5);
				});

				WindowFrame.Parent = Window.SurfaceGui;
			end;
		else
			if WindowFrame.BackgroundTransparency > 0.9 then
				WindowFrame.Visible = false;
				WindowFrame.Parent = nil
			else
				WindowFrame.Visible = true;
				WindowFrame.Parent = NeverLose.ScreenGui


			end;
		end;
	end);

	NeverLose:AddSignal(WindowFrame:GetPropertyChangedSignal('BackgroundTransparency'):Connect(renderParentWindow))

	Window.SetRender = LPH_NO_VIRTUALIZE(function(self , value)
		if value then
			NeverLose.PlayAnimate(WindowFrame , SlowyTween , {
				BackgroundTransparency = 0,
				Size = Window.Size
			})

			NeverLose.PlayAnimate(LogoImage , SlowyTween , {
				ImageTransparency = 0
			})

			NeverLose.PlayAnimate(WindowName , SlowyTween , {
				TextTransparency = 0
			})

			NeverLose.PlayAnimate(WindowContent , SlowyTween , {
				TextTransparency = 0.650
			})

			NeverLose.PlayAnimate(LineFrame , SlowyTween , {
				BackgroundTransparency = 0.650
			})

			NeverLose.PlayAnimate(AccountProfile , SlowyTween , {
				ImageTransparency = 0
			})

			NeverLose.PlayAnimate(AccountName , SlowyTween , {
				TextTransparency = 0
			})

			NeverLose.PlayAnimate(ExpireLabel , SlowyTween , {
				TextTransparency = 0.650
			})

			NeverLose.PlayAnimate(LineFrame_2 , SlowyTween , {
				BackgroundTransparency = 0.650
			})

			NeverLose.PlayAnimate(UserSettingButton , SlowyTween , {
				TextTransparency = 0.5
			})

			NeverLose.PlayAnimate(RightMenuFrame , SlowyTween , {
				BackgroundTransparency = 0.600
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			})

			NeverLose.PlayAnimate(LineFrame_3 , SlowyTween , {
				BackgroundTransparency = 0.650
			})

			NeverLose.PlayAnimate(ConfigFrame , SlowyTween , {
				BackgroundTransparency = 0.750
			})

			NeverLose.PlayAnimate(UIStroke_2 , SlowyTween , {
				Transparency = 0.650
			})

			NeverLose.PlayAnimate(ConfigIcon , SlowyTween , {
				TextTransparency = 0.250
			})

			NeverLose.PlayAnimate(LineFrame_4 , SlowyTween , {
				BackgroundTransparency = 0.650
			})

			NeverLose.PlayAnimate(ConfigName , SlowyTween , {
				TextTransparency = 0.350
			})

			NeverLose.PlayAnimate(ConfigBthIcon , SlowyTween , {
				TextTransparency = 0.250
			})

			NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
				TextTransparency = 0.250
			})

			NeverLose.PlayAnimate(SearchBox , SlowyTween , {
				TextTransparency = 0.350
			})

			--Window.Shadow:Render(true);
		else

			NeverLose.PlayAnimate(WindowFrame , SlowyTween , {
				BackgroundTransparency = 1,
				Size = Window.Size + UDim2.fromOffset(-15,-15)
			})

			NeverLose.PlayAnimate(LogoImage , SlowyTween , {
				ImageTransparency = 1
			})

			NeverLose.PlayAnimate(WindowName , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(WindowContent , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(LineFrame , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(AccountProfile , SlowyTween , {
				ImageTransparency = 1
			})

			NeverLose.PlayAnimate(AccountName , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(ExpireLabel , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(LineFrame_2 , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UserSettingButton , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(RightMenuFrame , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(LineFrame_3 , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(ConfigFrame , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(UIStroke_2 , SlowyTween , {
				Transparency = 1
			})

			NeverLose.PlayAnimate(ConfigIcon , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(LineFrame_4 , SlowyTween , {
				BackgroundTransparency = 1
			})

			NeverLose.PlayAnimate(ConfigName , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(ConfigBthIcon , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
				TextTransparency = 1
			})

			NeverLose.PlayAnimate(SearchBox , SlowyTween , {
				TextTransparency = 1
			})

			--Window.Shadow:Render(false);
		end;
	end);

	-- Shadow disabled
Window.Shadow = { Render = function() end };  -- dummy object

	task.delay(0.25,function()
		WindowFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		Window:SetRender(true);
		NeverLose:AddSignal(Window.Signal:Connect(LPH_NO_VIRTUALIZE(function(...)
			Window:SetRender(...);
		end)))
	end)

	if NeverLose.EnabledBlur then
		NeverLose:CreateBlurModule(WindowFrame,Window.Signal);
	end;

	do
		local Frame = Instance.new("Frame")

		Frame.Parent = WindowFrame
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Size = UDim2.new(1, 0, 0, 50)
		Frame.ZIndex = 7
		Frame.BackgroundTransparency = 1;

		NeverLose.Drag(Frame , WindowFrame , 0.15)
	end

	UICorner.Parent = WindowFrame

	LeftMenuFrame.Name = NeverLose.RandomString();
	LeftMenuFrame.Parent = WindowFrame
	LeftMenuFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftMenuFrame.BackgroundTransparency = 1.000
	LeftMenuFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LeftMenuFrame.BorderSizePixel = 0
	LeftMenuFrame.Size = UDim2.new(0, 175, 1, 0)

	HeadFrame.Name = NeverLose.RandomString();
	HeadFrame.Parent = LeftMenuFrame
	HeadFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HeadFrame.BackgroundTransparency = 1.000
	HeadFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HeadFrame.BorderSizePixel = 0
	HeadFrame.Size = UDim2.new(1, 0, 0, 50)
	HeadFrame.ZIndex = 7

	LogoImage.Name = NeverLose.RandomString();
	LogoImage.Parent = HeadFrame
	LogoImage.AnchorPoint = Vector2.new(0, 0.5)
	LogoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LogoImage.BackgroundTransparency = 1.000
	LogoImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LogoImage.BorderSizePixel = 0
	LogoImage.Position = UDim2.new(0, 10, 0.5, 0)
	LogoImage.Size = UDim2.new(0, 35, 0, 35)
	LogoImage.ZIndex = 7
	LogoImage.Image = Window.Logo
	LogoImage.ImageColor3 = NeverLose.IconColor

	UICorner_2.CornerRadius = UDim.new(0, 7)
	UICorner_2.Parent = LogoImage

	WindowName.Name = NeverLose.RandomString();
	WindowName.Parent = HeadFrame
	WindowName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	WindowName.BackgroundTransparency = 1.000
	WindowName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowName.BorderSizePixel = 0
	WindowName.Position = UDim2.new(0, 55, 0, 4)
	WindowName.Size = UDim2.new(0, 200, 0, 25)
	WindowName.ZIndex = 7
	WindowName.Font = Enum.Font.GothamBold
	WindowName.Text = Window.Name
	WindowName.TextColor3 = Color3.fromRGB(255, 255, 255)
	WindowName.TextSize = 18.000
	WindowName.TextXAlignment = Enum.TextXAlignment.Left

	WindowContent.Name = NeverLose.RandomString();
	WindowContent.Parent = HeadFrame
	WindowContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	WindowContent.BackgroundTransparency = 1.000
	WindowContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
	WindowContent.BorderSizePixel = 0
	WindowContent.Position = UDim2.new(0, 55, 0, 25)
	WindowContent.Size = UDim2.new(0, 200, 0, 15)
	WindowContent.ZIndex = 7
	WindowContent.Font = Enum.Font.GothamBold
	WindowContent.Text = Window.Content
	WindowContent.TextColor3 = Color3.fromRGB(255, 255, 255)
	WindowContent.TextSize = 9.000
	WindowContent.TextTransparency = 0.650
	WindowContent.TextXAlignment = Enum.TextXAlignment.Left

	LineFrame.Name = NeverLose.RandomString();
	LineFrame.Parent = HeadFrame
	LineFrame.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame.BackgroundTransparency = 0.650
	LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame.BorderSizePixel = 0
	LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame.Size = UDim2.new(1, -10, 0, 1)
	LineFrame.ZIndex = 5

	LeftScrollingFrame.Name = NeverLose.RandomString();
	LeftScrollingFrame.Parent = LeftMenuFrame
	LeftScrollingFrame.Active = true
	LeftScrollingFrame.AnchorPoint = Vector2.new(0.5, 0)
	LeftScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftScrollingFrame.BackgroundTransparency = 1.000
	LeftScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LeftScrollingFrame.BorderSizePixel = 0
	LeftScrollingFrame.Position = UDim2.new(0.5, 0, 0, 60)
	LeftScrollingFrame.Size = UDim2.new(1, -10, 1, -115)
	LeftScrollingFrame.ZIndex = 7
	LeftScrollingFrame.ScrollBarThickness = 0

	UIListLayout.Parent = LeftScrollingFrame
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
		LeftScrollingFrame.CanvasSize = UDim2.fromOffset(0,UIListLayout.AbsoluteContentSize.Y + 1)
	end)))

	BottomFrame.Name = NeverLose.RandomString();
	BottomFrame.Parent = LeftMenuFrame
	BottomFrame.AnchorPoint = Vector2.new(0, 1)
	BottomFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BottomFrame.BackgroundTransparency = 1.000
	BottomFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BottomFrame.BorderSizePixel = 0
	BottomFrame.Position = UDim2.new(0, 0, 1, 0)
	BottomFrame.Size = UDim2.new(1, 0, 0, 50)
	BottomFrame.ZIndex = 7

	AccountProfile.Name = NeverLose.RandomString();
	AccountProfile.Parent = BottomFrame
	AccountProfile.AnchorPoint = Vector2.new(0, 0.5)
	AccountProfile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AccountProfile.BackgroundTransparency = 1.000
	AccountProfile.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AccountProfile.BorderSizePixel = 0
	AccountProfile.Position = UDim2.new(0, 10, 0.5, 0)
	AccountProfile.Size = UDim2.new(0, 35, 0, 35)
	AccountProfile.ZIndex = 7
	AccountProfile.Image = NeverLose.UserProfile or ""

	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = AccountProfile

	AccountName.Name = NeverLose.RandomString();
	AccountName.Parent = BottomFrame
	AccountName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	AccountName.BackgroundTransparency = 1.000
	AccountName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	AccountName.BorderSizePixel = 0
	AccountName.Position = UDim2.new(0, 55, 0, 5)
	AccountName.Size = UDim2.new(0, 100, 0, 25)
	AccountName.ZIndex = 7
	AccountName.Font = Enum.Font.GothamBold
	AccountName.Text = ""
	AccountName.TextColor3 = Color3.fromRGB(255, 255, 255)
	AccountName.TextSize = 14.000
	AccountName.TextXAlignment = Enum.TextXAlignment.Left
	AccountName.TextTruncate = Enum.TextTruncate.SplitWord;

	ExpireLabel.Name = NeverLose.RandomString();
	ExpireLabel.Parent = BottomFrame
	ExpireLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ExpireLabel.BackgroundTransparency = 1.000
	ExpireLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ExpireLabel.BorderSizePixel = 0
	ExpireLabel.Position = UDim2.new(0, 55, 0, 25)
	ExpireLabel.Size = UDim2.new(0, 200, 0, 15)
	ExpireLabel.ZIndex = 7
	ExpireLabel.Font = Enum.Font.GothamBold
	ExpireLabel.Text = "never"
	ExpireLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	ExpireLabel.TextSize = 10.000
	ExpireLabel.TextTransparency = 0.650
	ExpireLabel.TextXAlignment = Enum.TextXAlignment.Left

	LineFrame_2.Name = NeverLose.RandomString();
	LineFrame_2.Parent = BottomFrame
	LineFrame_2.AnchorPoint = Vector2.new(0.5, 0)
	LineFrame_2.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame_2.BackgroundTransparency = 0.650
	LineFrame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame_2.BorderSizePixel = 0
	LineFrame_2.Position = UDim2.new(0.5, 0, 0, 0)
	LineFrame_2.Size = UDim2.new(1, -10, 0, 1)
	LineFrame_2.ZIndex = 5

	UserSettingButton.Name = NeverLose.RandomString();
	UserSettingButton.Parent = BottomFrame
	UserSettingButton.AnchorPoint = Vector2.new(1, 0.5)
	UserSettingButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserSettingButton.BackgroundTransparency = 1.000
	UserSettingButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserSettingButton.BorderSizePixel = 0
	UserSettingButton.Position = UDim2.new(1, -7, 0.5, 0)
	UserSettingButton.Size = UDim2.new(0, 25, 0, 25)
	UserSettingButton.ZIndex = 7
	UserSettingButton.FontFace = NeverLose.BuiltInBold
	UserSettingButton.Text = "chevron-large-right"
	UserSettingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	UserSettingButton.TextSize = 13.000
	UserSettingButton.TextTransparency = 0.5

	NeverLose:AddSignal(BottomFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
		NeverLose.PlayAnimate(UserSettingButton,SlowyTween , {
			TextTransparency = 0.25
		})		
	end)))

	NeverLose:AddSignal(BottomFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
		NeverLose.PlayAnimate(UserSettingButton,SlowyTween , {
			TextTransparency = 0.5
		})		
	end)))

	RightMenuFrame.Name = NeverLose.RandomString();
	RightMenuFrame.Parent = WindowFrame
	RightMenuFrame.BackgroundColor3 = Color3.fromRGB(19,19,21)
	RightMenuFrame.BackgroundTransparency = 0
	RightMenuFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RightMenuFrame.BorderSizePixel = 0
	RightMenuFrame.ClipsDescendants = true
	RightMenuFrame.Position = UDim2.new(0, 176, 0, 0)
	RightMenuFrame.Size = UDim2.new(1, -176, 1, 0)
	RightMenuFrame.ZIndex = 8

	UIStroke.Transparency = 0.650
	UIStroke.Color = Color3.fromRGB(45, 48, 58)
	UIStroke.Parent = RightMenuFrame

	UICorner_4.CornerRadius = UDim.new(0, 13)
	UICorner_4.Parent = RightMenuFrame

	RightHeader.Name = NeverLose.RandomString();
	RightHeader.Parent = RightMenuFrame
	RightHeader.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RightHeader.BackgroundTransparency = 1.000
	RightHeader.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RightHeader.BorderSizePixel = 0
	RightHeader.Size = UDim2.new(1, 0, 0, 50)
	RightHeader.ZIndex = 9

	LineFrame_3.Name = NeverLose.RandomString();
	LineFrame_3.Parent = RightHeader
	LineFrame_3.AnchorPoint = Vector2.new(0.5, 1)
	LineFrame_3.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame_3.BackgroundTransparency = 0.650
	LineFrame_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame_3.BorderSizePixel = 0
	LineFrame_3.Position = UDim2.new(0.5, 0, 1, 0)
	LineFrame_3.Size = UDim2.new(1, -10, 0, 1)
	LineFrame_3.ZIndex = 9

	ConfigFrame.Name = NeverLose.RandomString();
	ConfigFrame.Parent = RightHeader
	ConfigFrame.AnchorPoint = Vector2.new(0, 0.5)
	ConfigFrame.BackgroundColor3 = Color3.fromRGB(13, 17, 22)
	ConfigFrame.BackgroundTransparency = 0.750
	ConfigFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigFrame.BorderSizePixel = 0
	ConfigFrame.Position = UDim2.new(0, 10, 0.5, 0)
	ConfigFrame.Size = UDim2.new(0, 115, 0, 30)
	ConfigFrame.ZIndex = 9

	UIStroke_2.Transparency = 0.650
	UIStroke_2.Color = Color3.fromRGB(45, 48, 58)
	UIStroke_2.Parent = ConfigFrame

	UICorner_5.CornerRadius = UDim.new(0, 4)
	UICorner_5.Parent = ConfigFrame

	ConfigIcon.Name = NeverLose.RandomString();
	ConfigIcon.Parent = ConfigFrame
	ConfigIcon.AnchorPoint = Vector2.new(0, 0.5)
	ConfigIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ConfigIcon.BackgroundTransparency = 1.000
	ConfigIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigIcon.BorderSizePixel = 0
	ConfigIcon.Position = UDim2.new(0, 2, 0.5, 0)
	ConfigIcon.Size = UDim2.new(0, 25, 0, 25)
	ConfigIcon.ZIndex = 9
	ConfigIcon.FontFace = NeverLose.BuiltInBold
	ConfigIcon.Text = "floppy-disk"
	ConfigIcon.TextColor3 = Color3.fromRGB(223, 223, 223)
	ConfigIcon.TextSize = 16.000
	ConfigIcon.TextTransparency = 0.250
	ConfigIcon.TextWrapped = true

	LineFrame_4.Name = NeverLose.RandomString();
	LineFrame_4.Parent = ConfigFrame
	LineFrame_4.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
	LineFrame_4.BackgroundTransparency = 0.650
	LineFrame_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrame_4.BorderSizePixel = 0
	LineFrame_4.Position = UDim2.new(0, 30, 0, 0)
	LineFrame_4.Size = UDim2.new(0, 1, 1, 0)

	ConfigName.Name = NeverLose.RandomString();
	ConfigName.Parent = ConfigFrame
	ConfigName.AnchorPoint = Vector2.new(0, 0.5)
	ConfigName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ConfigName.BackgroundTransparency = 1.000
	ConfigName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigName.BorderSizePixel = 0
	ConfigName.Position = UDim2.new(0, 40, 0.5, 0)
	ConfigName.Size = UDim2.new(1, -7, 0, 15)
	ConfigName.ZIndex = 9
	ConfigName.Font = Enum.Font.GothamMedium
	ConfigName.Text = "Default"
	ConfigName.TextColor3 = Color3.fromRGB(255, 255, 255)
	ConfigName.TextSize = 12.000
	ConfigName.TextTransparency = 0.350
	ConfigName.TextXAlignment = Enum.TextXAlignment.Left

	ConfigBthIcon.Name = NeverLose.RandomString();
	ConfigBthIcon.Parent = ConfigFrame
	ConfigBthIcon.AnchorPoint = Vector2.new(1, 0.5)
	ConfigBthIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ConfigBthIcon.BackgroundTransparency = 1.000
	ConfigBthIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ConfigBthIcon.BorderSizePixel = 0
	ConfigBthIcon.Position = UDim2.new(1, -2, 0.5, 0)
	ConfigBthIcon.Size = UDim2.new(0, 25, 0, 25)
	ConfigBthIcon.ZIndex = 9
	ConfigBthIcon.FontFace = NeverLose.BuiltInBold
	ConfigBthIcon.Text = "chevron-small-down"
	ConfigBthIcon.TextColor3 = Color3.fromRGB(223, 223, 223)
	ConfigBthIcon.TextSize = 16.000
	ConfigBthIcon.TextTransparency = 0.250
	ConfigBthIcon.TextWrapped = true

	SearchFrame.Name = NeverLose.RandomString();
	SearchFrame.Parent = RightHeader
	SearchFrame.AnchorPoint = Vector2.new(1, 0.5)
	SearchFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SearchFrame.BackgroundTransparency = 1.000
	SearchFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchFrame.BorderSizePixel = 0
	SearchFrame.ClipsDescendants = true
	SearchFrame.Position = UDim2.new(1, -10, 0.5, 0)
	SearchFrame.Size = UDim2.new(0, 30, 0, 30)
	SearchFrame.ZIndex = 12

	SearchIcon.Name = NeverLose.RandomString();
	SearchIcon.Parent = SearchFrame
	SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
	SearchIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SearchIcon.BackgroundTransparency = 1.000
	SearchIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchIcon.BorderSizePixel = 0
	SearchIcon.Position = UDim2.new(0, 2, 0.5, 0)
	SearchIcon.Size = UDim2.new(0, 25, 0, 25)
	SearchIcon.ZIndex = 12
	SearchIcon.FontFace = NeverLose.BuiltInBold
	SearchIcon.Text = "magnifying-glass"
	SearchIcon.TextColor3 = Color3.fromRGB(223, 223, 223)
	SearchIcon.TextSize = 14.000
	SearchIcon.TextTransparency = 0.45
	SearchIcon.TextWrapped = true

	SearchBox.Name = NeverLose.RandomString();
	SearchBox.Parent = SearchFrame
	SearchBox.AnchorPoint = Vector2.new(0, 0.5)
	SearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SearchBox.BackgroundTransparency = 1.000
	SearchBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchBox.BorderSizePixel = 0
	SearchBox.Position = UDim2.new(0, 35, 0.5, 0)
	SearchBox.Size = UDim2.new(1, -35, 0, 25)
	SearchBox.ZIndex = 12
	SearchBox.ClearTextOnFocus = false
	SearchBox.Font = Enum.Font.GothamMedium
	SearchBox.PlaceholderText = "Search"
	SearchBox.Text = ""
	SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	SearchBox.TextSize = 13.000
	SearchBox.TextTransparency = 1
	SearchBox.TextXAlignment = Enum.TextXAlignment.Left

	TabContainer.Name = NeverLose.RandomString();
	TabContainer.Parent = RightMenuFrame
	TabContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabContainer.BackgroundTransparency = 1.000
	TabContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabContainer.BorderSizePixel = 0
	TabContainer.ClipsDescendants = true
	TabContainer.Position = UDim2.new(0, 0, 0, 50)
	TabContainer.Size = UDim2.new(1, 0, 1, -50)
	TabContainer.ZIndex = 5

	do
		Window.Searching = false;
		local Input = NeverLose:CreateInput(SearchIcon , LPH_NO_VIRTUALIZE(function()
			Window.Searching = not Window.Searching;

			if Window.Searching then
				NeverLose.PlayAnimate(SearchFrame , VSlowTween , {
					Size = UDim2.new(0, 220, 0, 30)
				})

				NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.25
				})

				NeverLose.PlayAnimate(SearchBox , VSlowTween , {
					TextTransparency = 0.350
				})
			else
				NeverLose.PlayAnimate(SearchFrame , VSlowTween , {
					Size = UDim2.new(0, 30, 0, 30)
				})

				NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.45
				})

				NeverLose.PlayAnimate(SearchBox , SlowyTween , {
					TextTransparency = 1
				})

				SearchBox.Text = "";
			end;
		end));	

		local wati_for_finish = tick();
		local last_thread;
		local max_time = 0.2;

		NeverLose:AddSignal(SearchBox:GetPropertyChangedSignal('Text'):Connect(LPH_NO_VIRTUALIZE(function()
			if not SearchBox.Text:byte() then
				for i,v in next , NeverLose.NameRegisitry do
					v.Root.Visible = true;
				end;

				return;	
			end;

			wati_for_finish = tick();

			if last_thread then
				task.cancel(last_thread);
				last_thread = nil;
			end;

			last_thread = task.delay(max_time,function()
				if SearchBox.Text:byte() and (tick() - wati_for_finish) > max_time then
					for i,v in next , NeverLose.NameRegisitry do
						if string.find(string.lower(v.Idx) , string.lower(SearchBox.Text), 1, true) then
							v.Root.Visible = true;
						else
							v.Root.Visible = false;
						end;
					end;
				end;
			end);
		end)));

		NeverLose:AddSignal(Input.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
				TextTransparency = 0.25
			})
		end)))

		NeverLose:AddSignal(Input.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			if Window.Searching then
				NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.25
				})
			else
				NeverLose.PlayAnimate(SearchIcon , SlowyTween , {
					TextTransparency = 0.45
				})
			end;
		end)));
	end;

	if Window.Enable3DRenderer then
		local Part = Instance.new('Part');

		Part.Name = NeverLose.RandomString();
		Part.Anchored = true;
		Part.Transparency = 1;
		Part.CanCollide = false;
		Part.CanTouch = false;
		Part.AudioCanCollide = false;
		Part.CollisionGroup = NeverLose.RandomString();
		Part.CFrame = CFrame.new(0,0,0);
		Part.Size = Vector3.zero;

		local SurfaceGui = Instance.new("SurfaceGui")

		SurfaceGui.Parent = NeverLose.ScreenGui;
		SurfaceGui.Adornee = Part;
		SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		SurfaceGui.AlwaysOnTop = true
		SurfaceGui.LightInfluence = 1.000
		SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
		SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize;
		SurfaceGui.PixelsPerStud = 40;

		Window.SurfaceGui = SurfaceGui;
		NeverLose.GlobalSurfaceGui = SurfaceGui;

		local PerfectScale = Vector2.new(1920 , 1080 + 300)

		Window.Load3DBlock = LPH_NO_VIRTUALIZE(function()
			if not Window.Signal:GetValue() then
				local _,OnScreen = CurrentCamera:WorldToViewportPoint(Part.Position);

				if OnScreen then
					NeverLose.PlayAnimate(Part,VSlowTween , {
						CFrame = CurrentCamera.CFrame * CFrame.new(0,0,-15) * CFrame.Angles(0,math.rad(180),0);
					});
				end;

				return
			end;

			local Dimensions = 50;

			local XY_Incom = Vector2.new(PerfectScale.X + 5, PerfectScale.Y * 1.35) / (Dimensions / 2);
			local PerfectDistance = XY_Incom.Magnitude;
			local SizeIndicator = PerfectDistance / 1.35;

			Part.Parent = NeverLose.BlurModuleParent or workspace;

			NeverLose.PlayAnimate(Part,VSlowTween , {
				CFrame = (CurrentCamera.CFrame * CFrame.new(0,0,-25)) * CFrame.Angles(0,math.rad(180),0);
			});

			Part.Size = Vector3.new(PerfectScale.X / SizeIndicator,PerfectScale.Y / SizeIndicator,0);
		end);

		function Window:Set3DRender(val)
			Window.__3DRender = val;
			NeverLose.Global3DRenderMode = val;

			if val then
				Window.Load3DBlock();
			else


				Part.Parent = nil;
			end;

			renderParentWindow();
		end;
	end;

	function Window:AddTabLabel(Name: string)
		local TabLabel = Instance.new("TextLabel")

		TabLabel.Name = NeverLose.RandomString()
		TabLabel.Parent = LeftScrollingFrame
		TabLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabLabel.BackgroundTransparency = 1.000
		TabLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabLabel.BorderSizePixel = 0
		TabLabel.Size = UDim2.new(1, -7, 0, 15)
		TabLabel.ZIndex = 8
		TabLabel.Font = Enum.Font.GothamMedium
		TabLabel.Text = Name
		TabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabLabel.TextSize = 11.000
		TabLabel.TextTransparency = 0.500
		TabLabel.TextXAlignment = Enum.TextXAlignment.Left

		local SetRender = LPH_NO_VIRTUALIZE(function(val)
			if val then
				NeverLose.PlayAnimate(TabLabel , SlowyTween,{
					TextTransparency = 0.500
				})
			else
				NeverLose.PlayAnimate(TabLabel , SlowyTween,{
					TextTransparency = 1
				})
			end
		end)

		SetRender(Window.Signal:GetValue());

		return Window.Signal:Connect(SetRender);
	end;

	function Window:AddTab(Config)
    Config = NeverLose:ProcessParams(Config , {
        Icon = "crosshairs",
        Name = "Tab",
        Type = "Double"
    });

    local Tab = {
        Signal = NeverLose:CreateSignal(false);
    };

    local TabButton = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TabIcon = Instance.new("TextLabel")
    local TabContentLabel = Instance.new("TextLabel")

    Tab.Idx = TabButton;

    TabButton.Name = NeverLose.RandomString();
    TabButton.Parent = LeftScrollingFrame
    TabButton.BackgroundColor3 = Color3.fromRGB(41, 45, 49)
    TabButton.BackgroundTransparency = 0.500
    TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(1, -1, 0, 30)
    TabButton.ZIndex = 8

    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = TabButton

    TabIcon.Name = NeverLose.RandomString();
    TabIcon.Parent = TabButton
    TabIcon.AnchorPoint = Vector2.new(0, 0.5)
    TabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabIcon.BackgroundTransparency = 1.000
    TabIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabIcon.BorderSizePixel = 0
    TabIcon.Position = UDim2.new(0, 2, 0.5, 0)
    TabIcon.Size = UDim2.new(0, 25, 0, 25)
    TabIcon.ZIndex = 9
    TabIcon.FontFace = NeverLose.BuiltInBold
    TabIcon.Text = Config.Icon;
    TabIcon.TextColor3 = NeverLose.AccentColor
    TabIcon.TextSize = 16.000
    TabIcon.TextWrapped = true

    TabContentLabel.Name = NeverLose.RandomString();
    TabContentLabel.Parent = TabButton
    TabContentLabel.AnchorPoint = Vector2.new(0, 0.5)
    TabContentLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabContentLabel.BackgroundTransparency = 1.000
    TabContentLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabContentLabel.BorderSizePixel = 0
    TabContentLabel.Position = UDim2.new(0, 30, 0.5, 0)
    TabContentLabel.Size = UDim2.new(1, -7, 0, 15)
    TabContentLabel.ZIndex = 9
    TabContentLabel.Font = Enum.Font.GothamMedium
    TabContentLabel.Text = Config.Name
    TabContentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabContentLabel.TextSize = 12.000
    TabContentLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- ===== MAIN TAB FRAME (container for all sections) =====
    local TabFrame = Instance.new("Frame")
    TabFrame.Name = NeverLose.RandomString()
    TabFrame.Parent = TabContainer
    TabFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    TabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabFrame.BackgroundTransparency = 1.000
    TabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TabFrame.BorderSizePixel = 0
    TabFrame.ClipsDescendants = true
    TabFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.Visible = true

    -- Vertical layout inside TabFrame
    local TabVerticalLayout = Instance.new("UIListLayout")
    TabVerticalLayout.Parent = TabFrame
    TabVerticalLayout.FillDirection = Enum.FillDirection.Vertical
    TabVerticalLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabVerticalLayout.Padding = UDim.new(0, 0)
    TabVerticalLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    -- Full‑width container (for sections with Position = "Full")
    local FullContainer = Instance.new("Frame")
    FullContainer.Name = NeverLose.RandomString()
    FullContainer.Parent = TabFrame
    FullContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FullContainer.BackgroundTransparency = 1.000
    FullContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    FullContainer.BorderSizePixel = 0
    FullContainer.ClipsDescendants = true
    FullContainer.Size = UDim2.new(1, 0, 0, 0)   -- height set dynamically
    FullContainer.LayoutOrder = 1

    local FullScroll = Instance.new("ScrollingFrame")
    FullScroll.Name = NeverLose.RandomString()
    FullScroll.Parent = FullContainer
    FullScroll.Active = true
    FullScroll.AnchorPoint = Vector2.new(0.5, 0.5)
    FullScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FullScroll.BackgroundTransparency = 1.000
    FullScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
    FullScroll.BorderSizePixel = 0
    FullScroll.Position = UDim2.new(0.5, 0, 0.5, 0)
    FullScroll.Size = UDim2.new(1, 0, 1, 0)
    FullScroll.ScrollBarThickness = 0
    FullScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

    local FullListLayout = Instance.new("UIListLayout")
    FullListLayout.Parent = FullScroll
    FullListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    FullListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    FullListLayout.Padding = UDim.new(0, 5)

    -- Auto‑resize FullContainer when content changes
    FullListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
        local contentHeight = FullListLayout.AbsoluteContentSize.Y + 5
        FullContainer.Size = UDim2.new(1, 0, 0, contentHeight)
        FullScroll.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
    end)

    -- Container for left/right split
    local SplitContainer = Instance.new("Frame")
    SplitContainer.Name = NeverLose.RandomString()
    SplitContainer.Parent = TabFrame
    SplitContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SplitContainer.BackgroundTransparency = 1.000
    SplitContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SplitContainer.BorderSizePixel = 0
    SplitContainer.ClipsDescendants = true
    SplitContainer.Size = UDim2.new(1, 0, 1, 0)   -- takes remaining height
    SplitContainer.LayoutOrder = 2

    -- LeftScroll (now parented to SplitContainer)
    local LeftScroll = Instance.new("ScrollingFrame")
    LeftScroll.Name = NeverLose.RandomString()
    LeftScroll.Parent = SplitContainer
    LeftScroll.Active = true
    LeftScroll.AnchorPoint = Vector2.new(0.5, 0.5)
    LeftScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LeftScroll.BackgroundTransparency = 1.000
    LeftScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
    LeftScroll.BorderSizePixel = 0
    LeftScroll.ClipsDescendants = false
    LeftScroll.Position = UDim2.new(0.25, 0, 0.5, 0)
    LeftScroll.Size = UDim2.new(0.5, 0, 1, -5)
    LeftScroll.ScrollBarThickness = 0

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = LeftScroll
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    -- RightScroll
    local RightScroll = Instance.new("ScrollingFrame")
    RightScroll.Name = NeverLose.RandomString()
    RightScroll.Parent = SplitContainer
    RightScroll.Active = true
    RightScroll.AnchorPoint = Vector2.new(0.5, 0.5)
    RightScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    RightScroll.BackgroundTransparency = 1.000
    RightScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
    RightScroll.BorderSizePixel = 0
    RightScroll.ClipsDescendants = false
    RightScroll.Position = UDim2.new(0.75, 0, 0.5, 0)
    RightScroll.Size = UDim2.new(0.5, 0, 1, -5)
    RightScroll.ScrollBarThickness = 0

    local UIListLayout_2 = Instance.new("UIListLayout")
    UIListLayout_2.Parent = RightScroll
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_2.Padding = UDim.new(0, 5)

    -- Handle Single vs Double layout
    if Config.Type == "Single" then
        SplitContainer.Visible = false
        FullContainer.Size = UDim2.new(1, 0, 1, 0)   -- full height
    else
        -- Double column: keep both
        NeverLose:AddSignal(UIListLayout_2:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
            RightScroll.CanvasSize = UDim2.fromOffset(0, UIListLayout_2.AbsoluteContentSize.Y + 1)
        end)))
    end

    -- (remaining code for tab visibility, selection, etc.)
    NeverLose:AddSignal(TabIcon:GetPropertyChangedSignal('TextTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
        if TabIcon.TextTransparency > 0.4 then
            UIListLayout.Parent = nil;
            UIListLayout_2.Parent = nil;
            TabFrame.Visible = false;
            TabFrame.Parent = nil
        else
            UIListLayout.Parent = LeftScroll;
            UIListLayout_2.Parent = RightScroll;
            TabFrame.Visible = true;
            TabFrame.Parent = TabContainer;
        end;
    end)));

    Tab.SetValue = LPH_NO_VIRTUALIZE(function(value)
        Tab.Signal:SetValue(value);
        if value then
            NeverLose.PlayAnimate(TabButton , SlowyTween , { BackgroundTransparency = 0.500 })
            NeverLose.PlayAnimate(TabIcon , SlowyTween , { TextTransparency = 0, TextColor3 = NeverLose.AccentColor })
            NeverLose.PlayAnimate(TabContentLabel , SlowyTween , { TextTransparency = 0 })
        else
            NeverLose.PlayAnimate(TabButton , SlowyTween , { BackgroundTransparency = 1 })
            NeverLose.PlayAnimate(TabIcon , SlowyTween , { TextTransparency = 0.5, TextColor3 = Color3.fromRGB(252, 252, 252) })
            NeverLose.PlayAnimate(TabContentLabel , SlowyTween , { TextTransparency = 0.5 })
        end;
    end);

    table.insert(Window.Tabs, Tab);

    if Window.Tabs[Window.CurrentTab] == Tab then
        Tab.SetValue(true)
    else
        Tab.SetValue(false);
    end;

    local over = NeverLose:CreateInput(TabButton, LPH_NO_VIRTUALIZE(function()
        for i, v in next, Window.Tabs do
            if v.Idx == TabButton then
                v.SetValue(true);
                Window.CurrentTab = i;
            else
                v.SetValue(false);
            end;
        end;
    end));

    NeverLose:AddSignal(over.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
        if Window.Tabs[Window.CurrentTab] == Tab then
            NeverLose.PlayAnimate(TabButton, SlowyTween, { BackgroundTransparency = 0.500 })
        else
            NeverLose.PlayAnimate(TabButton, SlowyTween, { BackgroundTransparency = 0.8 })
        end;
    end)))

    NeverLose:AddSignal(over.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
        if Window.Tabs[Window.CurrentTab] == Tab then
            NeverLose.PlayAnimate(TabButton, SlowyTween, { BackgroundTransparency = 0.500 })
        else
            NeverLose.PlayAnimate(TabButton, SlowyTween, { BackgroundTransparency = 1 })
        end;
    end)))

    Window.Signal:Connect(LPH_NO_VIRTUALIZE(function(value)
        if value then
            if Window.Tabs[Window.CurrentTab] == Tab then
                Tab.SetValue(true)
            else
                Tab.SetValue(false);
            end;
        else
            Tab.SetValue(false);
            NeverLose.PlayAnimate(TabButton, SlowyTween, { BackgroundTransparency = 1 })
            NeverLose.PlayAnimate(TabIcon, SlowyTween, { TextTransparency = 1 })
            NeverLose.PlayAnimate(TabContentLabel, SlowyTween, { TextTransparency = 1 })
        end;
    end));

    -- ===== Tab:AddSection (modified to support "full") =====
    function Tab:AddSection(Config)
        Config = NeverLose:ProcessParams(Config , {
            Name = "SECTION",
            Position = 'left'   -- can be 'left', 'right', or 'full'
        })

        local SectionFrame = Instance.new("Frame")
        local SectionLabel = Instance.new("TextLabel")
        local SectionHandler = Instance.new("Frame")
        local UIStroke = Instance.new("UIStroke")
        local UICorner = Instance.new("UICorner")
        local UIListLayout = Instance.new("UIListLayout")

        -- Choose the parent scroll frame based on Position
        local parentScroll
        if string.lower(Config.Position) == 'full' then
            parentScroll = FullScroll
            FullContainer.Visible = true   -- ensure it's shown
        elseif string.lower(Config.Position) == 'right' then
            parentScroll = RightScroll
        else
            parentScroll = LeftScroll
        end

        SectionFrame.Name = NeverLose.RandomString()
        SectionFrame.Parent = parentScroll
        SectionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SectionFrame.BackgroundTransparency = 1.000
        SectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SectionFrame.BorderSizePixel = 0
        SectionFrame.ClipsDescendants = true
        SectionFrame.Size = UDim2.new(1, -5, 0, 0)
        SectionFrame.ZIndex = 9

        SectionLabel.Name = NeverLose.RandomString()
        SectionLabel.Parent = SectionFrame
        SectionLabel.AnchorPoint = Vector2.new(0.5, 0)
        SectionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SectionLabel.BackgroundTransparency = 1.000
        SectionLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SectionLabel.BorderSizePixel = 0
        SectionLabel.Position = UDim2.new(0.5, 0, 0, 0)
        SectionLabel.Size = UDim2.new(1, -35, 0, 15)
        SectionLabel.ZIndex = 9
        SectionLabel.Font = Enum.Font.GothamMedium
        SectionLabel.Text = Config.Name
        SectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        SectionLabel.TextSize = 11.000
        SectionLabel.TextTransparency = 0.500
        SectionLabel.TextXAlignment = Enum.TextXAlignment.Left

        SectionHandler.Name = NeverLose.RandomString()
        SectionHandler.Parent = SectionFrame
        SectionHandler.AnchorPoint = Vector2.new(0.5, 0)
        SectionHandler.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
        SectionHandler.BackgroundTransparency = 0.500
        SectionHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SectionHandler.BorderSizePixel = 0
        SectionHandler.ClipsDescendants = true
        SectionHandler.Position = UDim2.new(0.5, 0, 0, 20)
        SectionHandler.Size = UDim2.new(1, -10, 1, -21)
        SectionHandler.ZIndex = 9

        UIStroke.Transparency = 0.650
        UIStroke.Color = Color3.fromRGB(45, 48, 58)
        UIStroke.Parent = SectionHandler

        UICorner.CornerRadius = UDim.new(0, 10)
        UICorner.Parent = SectionHandler

        UIListLayout.Parent = SectionHandler
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

        UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
            if UIListLayout.AbsoluteContentSize.Y <= 1 then
                NeverLose.PlayAnimate(SectionFrame , VSlowTween , {
                    Size = UDim2.new(1, -5, 0, 0)
                })
            else
                NeverLose.PlayAnimate(SectionFrame , VSlowTween , {
                    Size = UDim2.new(1, -5, 0, UIListLayout.AbsoluteContentSize.Y + 19.5)
                })
            end
            -- Update parent scroll canvas size
            local parent = SectionFrame.Parent
            if parent:IsA("ScrollingFrame") then
                local listLayout = parent:FindFirstChildOfClass("UIListLayout")
                if listLayout then
                    parent.CanvasSize = UDim2.fromOffset(0, listLayout.AbsoluteContentSize.Y + 5)
                end
            end
        end))

        local Section = NeverLose:RegisiterItem(SectionHandler , Tab.Signal)

        Section.SetRender = LPH_NO_VIRTUALIZE(function(value)
            if value then
                NeverLose.PlayAnimate(SectionLabel,SlowyTween,{
                    TextTransparency = 0.500
                })
                NeverLose.PlayAnimate(SectionHandler,SlowyTween,{
                    BackgroundTransparency = 0.500
                })
                NeverLose.PlayAnimate(UIStroke,SlowyTween,{
                    Transparency = 0.650
                })
            else
                NeverLose.PlayAnimate(SectionLabel,SlowyTween,{
                    TextTransparency = 1
                })
                NeverLose.PlayAnimate(SectionHandler,SlowyTween,{
                    BackgroundTransparency = 1
                })
                NeverLose.PlayAnimate(UIStroke,SlowyTween,{
                    Transparency = 1
                })
            end
        end)

        Section.SetRender(Tab.Signal:GetValue())
        Tab.Signal:Connect(Section.SetRender)

        return Section
    end

    return Tab;
end


	function Window:_InitConfig()
		local ConfigSignal = NeverLose:CreateSignal(false);
		local ConfigLib = {
			Signals = {},
		};

		local ConfigMenu = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIListLayout = Instance.new("UIListLayout")
		local UIStroke = Instance.new("UIStroke")
		local InputFrame = Instance.new("Frame")
		local BasedLabel = Instance.new("TextLabel")
		local LineFrame = Instance.new("Frame")
		local BasedHandler = Instance.new("Frame")
		local UIListLayout_2 = Instance.new("UIListLayout")
		local TextInput = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIStroke_2 = Instance.new("UIStroke")
		local TextBox = Instance.new("TextBox")
		local LoadConfig = Instance.new("Frame")
		local Icon = Instance.new("TextLabel")
		local UICorner_3 = Instance.new("UICorner")
		local UICorner_4 = Instance.new("UICorner")

		local shadow = NeverLose:CreateShadow(ConfigMenu);

		ConfigLib.SetRender = LPH_NO_VIRTUALIZE(function(value)
			if value then
				ConfigMenu.Position = UDim2.fromOffset(ConfigFrame.AbsolutePosition.X + 110 , ConfigFrame.AbsolutePosition.Y + 96)

				NeverLose.PlayAnimate(ConfigMenu , SlowyTween , {
					BackgroundTransparency = 0.035,
					Position = UDim2.fromOffset(ConfigFrame.AbsolutePosition.X + 110 , ConfigFrame.AbsolutePosition.Y + 95)
				})	

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 0.650
				})
				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 0.200
				})	

				NeverLose.PlayAnimate(UIStroke_2 , SlowyTween , {
					Transparency = 0.65
				})	

				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 0.650
				})	
				NeverLose.PlayAnimate(TextInput , SlowyTween , {
					BackgroundTransparency = 0
				})	
				NeverLose.PlayAnimate(TextBox , SlowyTween , {
					TextTransparency = 0.350
				})	
				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 0.350
				})	

				NeverLose.PlayAnimate(ConfigBthIcon , SlowyTween , {
					Rotation = 180
				})	

				shadow:Render(true)
			else
				NeverLose.PlayAnimate(ConfigBthIcon , SlowyTween , {
					Rotation = 0
				})

				NeverLose.PlayAnimate(ConfigMenu , SlowyTween , {
					BackgroundTransparency = 1,
					Position = UDim2.fromOffset(ConfigFrame.AbsolutePosition.X + 110 , ConfigFrame.AbsolutePosition.Y + 96)
				})	

				NeverLose.PlayAnimate(UIStroke_2 , SlowyTween , {
					Transparency = 1
				})	

				NeverLose.PlayAnimate(UIStroke , SlowyTween , {
					Transparency = 1
				})
				NeverLose.PlayAnimate(BasedLabel , SlowyTween , {
					TextTransparency = 1
				})	
				NeverLose.PlayAnimate(LineFrame , SlowyTween , {
					BackgroundTransparency = 1
				})	
				NeverLose.PlayAnimate(TextInput , SlowyTween , {
					BackgroundTransparency = 1
				})	
				NeverLose.PlayAnimate(TextBox , SlowyTween , {
					TextTransparency = 1
				})	
				NeverLose.PlayAnimate(Icon , SlowyTween , {
					TextTransparency = 1
				})	

				shadow:Render(false)
			end;
		end);

		NeverLose:AddSignal(ConfigMenu:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
			if ConfigMenu.BackgroundTransparency > 0.9 then
				ConfigMenu.Visible = false;
				UIListLayout.Parent = nil;
				ConfigMenu.Parent = nil;
			else

				ConfigMenu.Visible = true;
				UIListLayout.Parent = ConfigMenu

				if NeverLose.Global3DRenderMode then
					ConfigMenu.Parent = NeverLose.GlobalSurfaceGui;
				else
					ConfigMenu.Parent = NeverLose.ScreenGui;
				end;
			end
		end)))

		ConfigMenu.Name = NeverLose.RandomString();
		ConfigMenu.Parent = NeverLose.ScreenGui;
		ConfigMenu.AnchorPoint = Vector2.new(0.5, 0)
		ConfigMenu.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		ConfigMenu.BackgroundTransparency = 0.035
		ConfigMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ConfigMenu.BorderSizePixel = 0
		ConfigMenu.ClipsDescendants = true
		ConfigMenu.Position = UDim2.new(255,255,255,255)
		ConfigMenu.Size = UDim2.new(0, 220,0, 110)
		ConfigMenu.ZIndex = 151

		UICorner.CornerRadius = UDim.new(0, 10)
		UICorner.Parent = ConfigMenu

		UIListLayout.Parent = ConfigMenu
		UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 4)

		UIStroke.Transparency = 0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = ConfigMenu

		InputFrame.Name = NeverLose.RandomString();
		InputFrame.Parent = ConfigMenu
		InputFrame.BackgroundColor3 = Color3.fromRGB(25, 27, 33)
		InputFrame.BackgroundTransparency = 1.000
		InputFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InputFrame.BorderSizePixel = 0
		InputFrame.Size = UDim2.new(1, 0, 0, 30)
		InputFrame.ZIndex = 154

		BasedLabel.Name = NeverLose.RandomString();
		BasedLabel.Parent = InputFrame
		BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.BackgroundTransparency = 1.000
		BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedLabel.BorderSizePixel = 0
		BasedLabel.Position = UDim2.new(0, 11, 0, 6)
		BasedLabel.Size = UDim2.new(0,1, 0, 15)
		BasedLabel.ZIndex = 154
		BasedLabel.Font = Enum.Font.GothamMedium
		BasedLabel.Text = "Config"
		BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		BasedLabel.TextSize = 13.000
		BasedLabel.TextTransparency = 0.200
		BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

		LineFrame.Name = NeverLose.RandomString();
		LineFrame.Parent = InputFrame
		LineFrame.AnchorPoint = Vector2.new(0.5, 1)
		LineFrame.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
		LineFrame.BackgroundTransparency = 0.650
		LineFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LineFrame.BorderSizePixel = 0
		LineFrame.Position = UDim2.new(0.5, 0, 1, 0)
		LineFrame.Size = UDim2.new(1, -20, 0, 1)
		LineFrame.ZIndex = 154

		BasedHandler.Name = NeverLose.RandomString();
		BasedHandler.Parent = InputFrame
		BasedHandler.AnchorPoint = Vector2.new(1, 0)
		BasedHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BasedHandler.BackgroundTransparency = 1.000
		BasedHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
		BasedHandler.BorderSizePixel = 0
		BasedHandler.Position = UDim2.new(1, -11, 0, 2)
		BasedHandler.Size = UDim2.new(1, -20, 0, 25)
		BasedHandler.ZIndex = 154

		UIListLayout_2.Parent = BasedHandler
		UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Right
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
		UIListLayout_2.Padding = UDim.new(0, 5)

		NeverLose:AddSignal(UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(LPH_NO_VIRTUALIZE(function()
			if #ConfigLib.Signals <= 0 then
				NeverLose.PlayAnimate(ConfigMenu , SlowyTween , {
					Size = UDim2.new(0, 220,0, UIListLayout.AbsoluteContentSize.Y + 0);
				})
			else
				NeverLose.PlayAnimate(ConfigMenu , SlowyTween , {
					Size = UDim2.new(0, 220,0, UIListLayout.AbsoluteContentSize.Y + 5);
				})
			end;

		end)));

		TextInput.Name = NeverLose.RandomString();
		TextInput.Parent = BasedHandler
		TextInput.BackgroundColor3 = Color3.fromRGB(26, 28, 36)
		TextInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextInput.BorderSizePixel = 0
		TextInput.ClipsDescendants = true
		TextInput.Size = UDim2.new(0, 100, 0, 18)
		TextInput.ZIndex = 154

		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = TextInput

		UIStroke_2.Transparency = 0.650
		UIStroke_2.Color = Color3.fromRGB(45, 48, 58)
		UIStroke_2.Parent = TextInput

		TextBox.Parent = TextInput
		TextBox.AnchorPoint = Vector2.new(0, 0.5)
		TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.BackgroundTransparency = 1.000
		TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0, 5, 0.5, 0)
		TextBox.Size = UDim2.new(1, -5, 0, 17)
		TextBox.ZIndex = 154
		TextBox.ClearTextOnFocus = false
		TextBox.Font = Enum.Font.GothamMedium
		TextBox.PlaceholderText = "Config Name ..."
		TextBox.Text = ""
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.TextSize = 11.000
		TextBox.TextTransparency = 0.350
		TextBox.TextXAlignment = Enum.TextXAlignment.Left

		LoadConfig.Name = NeverLose.RandomString();
		LoadConfig.Parent = BasedHandler
		LoadConfig.BackgroundColor3 = Color3.fromRGB(39, 40, 49)
		LoadConfig.BackgroundTransparency = 1.000
		LoadConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LoadConfig.BorderSizePixel = 0
		LoadConfig.ClipsDescendants = true
		LoadConfig.Size = UDim2.new(0, 20, 0, 18)
		LoadConfig.ZIndex = 153

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = LoadConfig
		Icon.AnchorPoint = Vector2.new(0.5, 0.5)
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
		Icon.Size = UDim2.new(1, 0, 1, 0)
		Icon.ZIndex = 153
		Icon.FontFace = NeverLose.BuiltInBold
		Icon.Text = "plus-large"
		Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
		Icon.TextSize = 16.000
		Icon.TextTransparency = 0.350
		Icon.TextWrapped = true

		UICorner_3.CornerRadius = UDim.new(0, 4)
		UICorner_3.Parent = LoadConfig

		UICorner_4.CornerRadius = UDim.new(0, 10)
		UICorner_4.Parent = InputFrame

		local OpenButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")

		OpenButton.Name = NeverLose.RandomString();
		OpenButton.Parent = ConfigFrame
		OpenButton.AnchorPoint = Vector2.new(0, 0.5)
		OpenButton.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		OpenButton.BackgroundTransparency = 1.000
		OpenButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		OpenButton.BorderSizePixel = 0
		OpenButton.Position = UDim2.new(0, 31, 0.5, 0)
		OpenButton.Size = UDim2.new(1, -31, 1, 0)
		OpenButton.ZIndex = 10
		OpenButton.Font = Enum.Font.SourceSans
		OpenButton.Text = ""
		OpenButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		OpenButton.TextSize = 14.000

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = OpenButton

		ConfigLib.SetRender(false);
		ConfigSignal:Connect(ConfigLib.SetRender);
		ConfigLib.UnsafeThread = nil;
		ConfigLib.SelectedConfig = "Default";

		local UpdateSize = LPH_NO_VIRTUALIZE(function()
			local size = TextService:GetTextSize(ConfigName.Text , ConfigName.TextSize,ConfigName.Font,Vector2.new(math.huge,math.huge));

			NeverLose.PlayAnimate(ConfigFrame,SlowyTween , {
				Size = UDim2.fromOffset(size.X + 75, 30)
			});
		end);

		UpdateSize();

		function ConfigLib:GetData(performance)
			local ikc = {};
			
			local cd = 0;
			for Flag,v in next , NeverLose.Flags do
				if v and v.GetValue then
					local data = v:GetValue();

					if typeof(data) == 'Color3' then
						table.insert(ikc,{
							Idx = Flag,
							Value = data:ToHex(),
						});
					else
						table.insert(ikc,{
							Idx = Flag,
							Value = data
						});
					end;
				end;
				
				if performance then
					if cd % 35 == 1 then
						task.wait()
					end
				end;
				
				cd += 1;
			end;

			return NeverLose.Base64Encode(Encryption.new(HttpService:JSONEncode(ikc)));
		end;

		function ConfigLib:LoadData(data)
			local coded = HttpService:JSONDecode(Encryption.reverse(NeverLose.Base64Decode(data)));

			for i,v in next , coded do
				if v.Idx then
					if NeverLose.Flags[v.Idx] then
						task.spawn(function()
							NeverLose.Flags[v.Idx]:SetValue(v.Value)
						end)
					end;
				end;
			end;
		end;

		function ConfigLib:RefreshConfig()
			if not isfolder(Window.ConfigFolder) then
				makefolder(Window.ConfigFolder);
			end;
			
			if not isfile(Window.ConfigFolder..'/Default') then
				writefile(Window.ConfigFolder..'/Default',ConfigLib:GetData());
			end;
			
			for i,v in next,ConfigMenu:GetChildren() do
				if v:GetAttribute('ConfigItem') then
					v:Destroy();
				end;
			end;

			for i,v in next , ConfigLib.Signals do
				v:Disconnect();
			end

			table.clear(ConfigLib.Signals);

			local ConfigList = {};
			for i,v in next , listfiles(Window.ConfigFolder) do

				local name = string.sub(v , #Window.ConfigFolder + 2);

				table.insert(ConfigList , name)
			end;

			for i,ConfigNameStr in next , ConfigList do
				local ConfigItemFrame = Instance.new("Frame")
				local BasedHandler = Instance.new("Frame")
				local UIListLayout = Instance.new("UIListLayout")
				local DeleteConfig = Instance.new("Frame")
				local Icon = Instance.new("TextLabel")
				local UICorner = Instance.new("UICorner")
				local LoadConfig = Instance.new("Frame")
				local Icon_2 = Instance.new("TextLabel")
				local UICorner_2 = Instance.new("UICorner")
				local UICorner_3 = Instance.new("UICorner")
				local BasedLabel = Instance.new("TextLabel")
				local UIStroke = Instance.new("UIStroke")

				ConfigItemFrame.Name = NeverLose.RandomString();
				ConfigItemFrame.Parent = ConfigMenu
				ConfigItemFrame.BackgroundColor3 = Color3.fromRGB(21, 20, 27)
				ConfigItemFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ConfigItemFrame.BorderSizePixel = 0
				ConfigItemFrame.Size = UDim2.new(1, -10, 0, 30)
				ConfigItemFrame.ZIndex = 153
				ConfigItemFrame:SetAttribute('ConfigItem',true);

				BasedHandler.Name = NeverLose.RandomString();
				BasedHandler.Parent = ConfigItemFrame
				BasedHandler.AnchorPoint = Vector2.new(1, 0)
				BasedHandler.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BasedHandler.BackgroundTransparency = 1.000
				BasedHandler.BorderColor3 = Color3.fromRGB(0, 0, 0)
				BasedHandler.BorderSizePixel = 0
				BasedHandler.Position = UDim2.new(1, -11, 0, 2)
				BasedHandler.Size = UDim2.new(1, -20, 0, 25)
				BasedHandler.ZIndex = 153

				UIListLayout.Parent = BasedHandler
				UIListLayout.FillDirection = Enum.FillDirection.Horizontal
				UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				UIListLayout.Padding = UDim.new(0, 5)

				DeleteConfig.Name = NeverLose.RandomString();
				DeleteConfig.Parent = BasedHandler
				DeleteConfig.BackgroundColor3 = Color3.fromRGB(39, 40, 49)
				DeleteConfig.BackgroundTransparency = 1.000
				DeleteConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
				DeleteConfig.BorderSizePixel = 0
				DeleteConfig.ClipsDescendants = true
				DeleteConfig.Size = UDim2.new(0, 20, 0, 18)
				DeleteConfig.ZIndex = 153

				Icon.Name = NeverLose.RandomString();
				Icon.Parent = DeleteConfig
				Icon.AnchorPoint = Vector2.new(0.5, 0.5)
				Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon.BackgroundTransparency = 1.000
				Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon.BorderSizePixel = 0
				Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
				Icon.Size = UDim2.new(1, 0, 1, 0)
				Icon.ZIndex = 153
				Icon.FontFace = NeverLose.BuiltInBold
				Icon.Text = "trash-can"
				Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
				Icon.TextSize = 16.000
				Icon.TextTransparency = 0.400
				Icon.TextWrapped = true

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = DeleteConfig

				LoadConfig.Name = NeverLose.RandomString();
				LoadConfig.Parent = BasedHandler
				LoadConfig.BackgroundColor3 = Color3.fromRGB(39, 40, 49)
				LoadConfig.BackgroundTransparency = 1.000
				LoadConfig.BorderColor3 = Color3.fromRGB(0, 0, 0)
				LoadConfig.BorderSizePixel = 0
				LoadConfig.ClipsDescendants = true
				LoadConfig.Size = UDim2.new(0, 20, 0, 18)
				LoadConfig.ZIndex = 153

				Icon_2.Name = NeverLose.RandomString();
				Icon_2.Parent = LoadConfig
				Icon_2.AnchorPoint = Vector2.new(0.5, 0.5)
				Icon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon_2.BackgroundTransparency = 1.000
				Icon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon_2.BorderSizePixel = 0
				Icon_2.Position = UDim2.new(0.5, 0, 0.5, 0)
				Icon_2.Size = UDim2.new(1, 0, 1, 0)
				Icon_2.ZIndex = 153
				Icon_2.FontFace = NeverLose.BuiltInBold
				Icon_2.Text = "arrow-right-from-portrait-rectangle"
				Icon_2.TextColor3 = Color3.fromRGB(223, 223, 223)
				Icon_2.TextSize = 16.000
				Icon_2.TextTransparency = 0.400
				Icon_2.TextWrapped = true

				UICorner_2.CornerRadius = UDim.new(0, 4)
				UICorner_2.Parent = LoadConfig

				UICorner_3.CornerRadius = UDim.new(0, 5)
				UICorner_3.Parent = ConfigItemFrame

				BasedLabel.Name = NeverLose.RandomString();
				BasedLabel.Parent = ConfigItemFrame
				BasedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BasedLabel.BackgroundTransparency = 1.000
				BasedLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				BasedLabel.BorderSizePixel = 0
				BasedLabel.Position = UDim2.new(0, 11, 0, 7)
				BasedLabel.Size = UDim2.new(0, 1, 0, 15)
				BasedLabel.ZIndex = 153
				BasedLabel.Font = Enum.Font.GothamMedium
				BasedLabel.Text = ConfigNameStr
				BasedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				BasedLabel.TextSize = 13.000
				BasedLabel.TextTransparency = 0.200
				BasedLabel.TextXAlignment = Enum.TextXAlignment.Left

				UIStroke.Transparency = 0.500
				UIStroke.Color = Color3.fromRGB(45, 48, 58)
				UIStroke.Parent = ConfigItemFrame

				local Render = LPH_NO_VIRTUALIZE(function(rst)
					if rst then
						NeverLose.PlayAnimate(ConfigItemFrame,SlowyTween,{
							BackgroundTransparency = 0
						})

						NeverLose.PlayAnimate(Icon,SlowyTween,{
							TextTransparency = 0.400
						})

						NeverLose.PlayAnimate(Icon_2,SlowyTween,{
							TextTransparency = 0.400
						})

						NeverLose.PlayAnimate(BasedLabel,SlowyTween,{
							TextTransparency = 0.200
						})

						NeverLose.PlayAnimate(UIStroke,SlowyTween,{
							Transparency = 0.500
						})
					else
						NeverLose.PlayAnimate(ConfigItemFrame,SlowyTween,{
							BackgroundTransparency = 1
						})

						NeverLose.PlayAnimate(Icon,SlowyTween,{
							TextTransparency = 1
						})

						NeverLose.PlayAnimate(Icon_2,SlowyTween,{
							TextTransparency = 1
						})

						NeverLose.PlayAnimate(BasedLabel,SlowyTween,{
							TextTransparency = 1
						})

						NeverLose.PlayAnimate(UIStroke,SlowyTween,{
							Transparency = 1
						})
					end;
				end)

				Render(ConfigSignal:GetValue());
				table.insert(ConfigLib.Signals , ConfigSignal:Connect(Render));

				table.insert(ConfigLib.Signals , ConfigItemFrame.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 0.25
					})
				end)));

				table.insert(ConfigLib.Signals , ConfigItemFrame.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(UIStroke,SlowyTween,{
						Transparency = 0.500
					})
				end)));

				local deleter,signal = NeverLose:CreateInput(DeleteConfig,function()
					if ConfigNameStr == "Default" then
						Logging.new("trash-can","You can't delete default config!",3.5)
						return;
					end;
					
					delfile(Window.ConfigFolder..'/'..ConfigNameStr);

					UpdateSize();

					ConfigLib:RefreshConfig();

					Logging.new("trash-can",'Deleted '..tostring(ConfigNameStr),3.5)
				end);


				local _,load_signal = NeverLose:CreateInput(LoadConfig,function()
					local path = Window.ConfigFolder..'/'..ConfigNameStr;

					if isfile(path) then
						local data = readfile(path);

						ConfigLib:LoadData(data);

						ConfigLib.SelectedConfig = ConfigNameStr;
						ConfigName.Text = ConfigNameStr;

						UpdateSize();

						ConfigLib:RefreshConfig();

						Logging.new("folder",'Loaded '..tostring(ConfigNameStr),3.5)
					end
				end);

				table.insert(ConfigLib.Signals , signal);
				table.insert(ConfigLib.Signals , load_signal);

				table.insert(ConfigLib.Signals , deleter.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(Icon,SlowyTween,{
						TextTransparency = 0.2,
						TextColor3 = Color3.fromRGB(223, 125, 125)
					})
				end)))

				table.insert(ConfigLib.Signals , deleter.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(Icon,SlowyTween,{
						TextTransparency = 0.400,
						TextColor3 = Color3.fromRGB(223, 223, 223)
					})
				end)))

				table.insert(ConfigLib.Signals , LoadConfig.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(Icon_2,SlowyTween,{
						TextTransparency = 0.2,
						TextColor3 = NeverLose.AccentColor
					})
				end)))

				table.insert(ConfigLib.Signals , LoadConfig.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
					NeverLose.PlayAnimate(Icon_2,SlowyTween,{
						TextTransparency = 0.400,
						TextColor3 = Color3.fromRGB(223, 223, 223)
					})
				end)))
			end;

			table.clear(ConfigList);
		end;
		
		task.delay(1,function()
			if ConfigLib.SelectedConfig == "Default" then
				local path = Window.ConfigFolder..'/Default';
				local ConfigNameStr = "Default";
				
				if isfile(path) then
					local data = readfile(path);

					ConfigLib:LoadData(data);

					ConfigLib.SelectedConfig = ConfigNameStr;
					ConfigName.Text = ConfigNameStr;

					UpdateSize();

					ConfigLib:RefreshConfig();

					Logging.new("folder","Loaded Default Config",3.5);
					
					task.spawn(function()
						while true do task.wait(5.75);
							if isfile(path) and ConfigLib.SelectedConfig == "Default" then
								writefile(Window.ConfigFolder..'/Default',ConfigLib:GetData(true));
							end;
						end;
					end);
				end;
			end;
		end);

		local hover_write = NeverLose:CreateInput(ConfigIcon,function()
			local path = Window.ConfigFolder..'/'..(ConfigLib.SelectedConfig or "Default");

			if isfile(path) then
				writefile(Window.ConfigFolder..'/'..(ConfigLib.SelectedConfig or "Default"),ConfigLib:GetData());

				Logging.new("folder",'Saved '..tostring(ConfigLib.SelectedConfig),3.5)
			end;
		end);

		NeverLose:AddSignal(hover_write.MouseEnter:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(ConfigIcon,SlowyTween,{
				TextTransparency = 0.1
			})
		end)));

		NeverLose:AddSignal(hover_write.MouseLeave:Connect(LPH_NO_VIRTUALIZE(function()
			NeverLose.PlayAnimate(ConfigIcon,SlowyTween,{
				TextTransparency = 0.25
			})
		end)));


		local mv = NeverLose:CreateInput(LoadConfig , function()
			local cfg_name = TextBox.Text;

			if cfg_name and cfg_name:byte() and not cfg_name:find('/',1,true) and not cfg_name:find('\\',1,true) then
				cfg_name = string.sub(cfg_name , 1 , 24);

				writefile(Window.ConfigFolder..'/'..cfg_name,ConfigLib:GetData());
				ConfigLib.SelectedConfig = cfg_name;
				ConfigName.Text = cfg_name;

				Logging.new("folder",'Created '..tostring(cfg_name),3.5)

				TextBox.Text = "";

				UpdateSize();

				ConfigLib:RefreshConfig();
			end;
		end);

		NeverLose:AddSignal(mv.MouseEnter:Connect(function()
			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.1
			})
		end))

		NeverLose:AddSignal(mv.MouseLeave:Connect(function()
			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.35
			})
		end))

		ConfigLib:RefreshConfig();

		OpenButton.MouseButton1Click:Connect(LPH_NO_VIRTUALIZE(function()
			if ConfigLib.UnsafeThread then
				ConfigLib.UnsafeThread:Disconnect();
				ConfigLib.UnsafeThread = nil;
			end;

			ConfigSignal:SetValue(true);

			ConfigLib.UnsafeThread = UserInputService.InputBegan:Connect(function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					if not NeverLose:IsMouseOverFrame(ConfigMenu) then
						if ConfigLib.UnsafeThread then
							ConfigLib.UnsafeThread:Disconnect();
							ConfigLib.UnsafeThread = nil;
						end;

						ConfigSignal:SetValue(false);
					end;
				end;
			end)
		end));

		return ConfigLib;
	end;

	Window:_InitConfig();

	local UserSettings = NeverLose:CreateOptionWindow(BottomFrame , BottomFrame.ZIndex + 13);
	local reciveSignal;
	NeverLose:CreateInput(BottomFrame , LPH_NO_VIRTUALIZE(function()
		if reciveSignal then
			reciveSignal:Disconnect();
			reciveSignal = nil;	
		end;

		UserSettings.Signal:SetValue(true);

		reciveSignal = UserInputService.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if not NeverLose:IsMouseOverFrame(UserSettings.Root) and not NeverLose:IsMouseOverFrame(BottomFrame) and not NeverLose.IsMosueOverOtherFrame then
					if reciveSignal then
						reciveSignal:Disconnect();
						reciveSignal = nil;	
					end;

					UserSettings.Signal:SetValue(false);
				end
			end
		end);
	end))

	Window.UserSettings = UserSettings;

	function Window:SetAccount(Config)
		Config = NeverLose:ProcessParams(Config , {
			Profile = NeverLose.UserProfile,
			Username = LocalPlayer.DisplayName,
			Expires = "Never",
		});

		AccountName.Text = Config.Username;
		AccountProfile.Image = Config.Profile;
		ExpireLabel.Text = Config.Expires;

		Window.Username = Config.Username or Window.Username;
		Window.Profile = Config.Profile or Window.Profile;
		Window.Expires = Config.Expires or Window.Expires;

		if Window.UserSettings.UserFrame then
			Window.UserSettings.UserFrame:SetUsername(Window.Username);
			Window.UserSettings.UserFrame:SetProfile(Window.Profile);
			Window.UserSettings.UserFrame:SetExpires(Window.Expires);
		else
			Window.UserSettings.UserFrame = UserSettings:AddUserFrame(Window.Username , Window.Profile , Window.Expires);
		end;
	end;

	function Window:SetSize(newsize)
		Window.Size = newsize;

		if Window.Signal:GetValue() then
			NeverLose.PlayAnimate(WindowFrame , VSlowTween , {
				Size = Window.Size
			})
		end
	end;

	Window:SetAccount();

	NeverLose:AddSignal(UserInputService.InputBegan:Connect(LPH_NO_VIRTUALIZE(function(value,ISTYPING)
    if value.KeyCode == Window.Keybind or value.KeyCode.Name == Window.Keybind then
        if not ISTYPING then
            Window:ToggleInterface()
        end
    end;
end)));




	function Window:ToggleInterface()
		Window.Signal:SetValue(not Window.Signal:GetValue());

		if Window.__3DRender then
			Window.Load3DBlock();
		end;
	end;

-- ===== UPDATED WATERMARK WITH TITLE =====
-- ===== UPDATED WATERMARK (no icon, fully opaque) =====
function NeverLose:Watermark(Config)
    Config = Config or {}
    if NeverLose.__WatermarkCache then
        return NeverLose.__WatermarkCache
    end

    local Watermark = {}
    local RunService = cloneref(game:GetService('RunService'))
    local StatsService = cloneref(game:GetService('Stats'))
    local MarketplaceService = cloneref(game:GetService('MarketplaceService'))

    -- Main bar – fully opaque
    local Bar = Instance.new('Frame')
    Bar.Name = NeverLose.RandomString()
    Bar.Parent = NeverLose.ScreenGui
    Bar.AnchorPoint = Vector2.new(0.5, 0)
    Bar.Position = UDim2.new(0.5, 0, 0, 14)
    Bar.Size = UDim2.new(0, 0, 0, 30)
    Bar.BackgroundColor3 = NeverLose.MainColor
    Bar.BackgroundTransparency = 0   -- fully opaque
    Bar.BorderSizePixel = 0
    Bar.ClipsDescendants = true
    Bar.ZIndex = 60
    Bar.AutomaticSize = Enum.AutomaticSize.X

    local Corner = Instance.new('UICorner')
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Bar

    local shadow = NeverLose:CreateShadow(Bar)

    local Padding = Instance.new('UIPadding')
    Padding.PaddingLeft = UDim.new(0, 12)
    Padding.PaddingRight = UDim.new(0, 12)
    Padding.Parent = Bar

    local Layout = Instance.new('UIListLayout')
    Layout.FillDirection = Enum.FillDirection.Horizontal
    Layout.VerticalAlignment = Enum.VerticalAlignment.Center
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 10)
    Layout.Parent = Bar

    local order = 0
    local function nextOrder()
        order = order + 1
        return order
    end

    -- Title label (big white text) – no icon
    local TitleLabel = nil
    if Config.Title and Config.Title ~= '' then
        TitleLabel = Instance.new('TextLabel')
        TitleLabel.Name = NeverLose.RandomString()
        TitleLabel.Parent = Bar
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Size = UDim2.new(0, 0, 0, 28)
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.Text = Config.Title
        TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TitleLabel.TextSize = 20
        TitleLabel.TextTransparency = 0
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        TitleLabel.LayoutOrder = nextOrder()
        TitleLabel.ZIndex = 61
        TitleLabel.AutomaticSize = Enum.AutomaticSize.X
    end

    -- Separator function
    local function separator()
        local sep = Instance.new('Frame')
        sep.Name = NeverLose.RandomString()
        sep.Parent = Bar
        sep.Size = UDim2.new(0, 1, 0, 14)
        sep.BackgroundColor3 = Color3.fromRGB(45, 48, 58)
        sep.BackgroundTransparency = 0
        sep.BorderSizePixel = 0
        sep.LayoutOrder = nextOrder()
        sep.ZIndex = 61
        return sep
    end

    separator()

    -- Game Name
    local GameLabel = Instance.new('TextLabel')
    GameLabel.Name = NeverLose.RandomString()
    GameLabel.Parent = Bar
    GameLabel.BackgroundTransparency = 1
    GameLabel.Size = UDim2.new(0, 0, 0, 16)
    GameLabel.Font = Enum.Font.GothamMedium
    GameLabel.Text = 'Loading...'
    GameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    GameLabel.TextSize = 14
    GameLabel.TextTransparency = 0.4
    GameLabel.TextXAlignment = Enum.TextXAlignment.Left
    GameLabel.LayoutOrder = nextOrder()
    GameLabel.ZIndex = 61
    GameLabel.AutomaticSize = Enum.AutomaticSize.X

    separator()

    -- FPS
    local FpsLabel = Instance.new('TextLabel')
    FpsLabel.Name = NeverLose.RandomString()
    FpsLabel.Parent = Bar
    FpsLabel.BackgroundTransparency = 1
    FpsLabel.Size = UDim2.new(0, 0, 0, 16)
    FpsLabel.Font = Enum.Font.GothamMedium
    FpsLabel.Text = '0 fps'
    FpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    FpsLabel.TextSize = 14
    FpsLabel.TextTransparency = 0.4
    FpsLabel.TextXAlignment = Enum.TextXAlignment.Left
    FpsLabel.LayoutOrder = nextOrder()
    FpsLabel.ZIndex = 61
    FpsLabel.AutomaticSize = Enum.AutomaticSize.X

    separator()

    -- Ping
    local PingLabel = Instance.new('TextLabel')
    PingLabel.Name = NeverLose.RandomString()
    PingLabel.Parent = Bar
    PingLabel.BackgroundTransparency = 1
    PingLabel.Size = UDim2.new(0, 0, 0, 16)
    PingLabel.Font = Enum.Font.GothamMedium
    PingLabel.Text = '0 ms'
    PingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    PingLabel.TextSize = 14
    PingLabel.TextTransparency = 0.4
    PingLabel.TextXAlignment = Enum.TextXAlignment.Left
    PingLabel.LayoutOrder = nextOrder()
    PingLabel.ZIndex = 61
    PingLabel.AutomaticSize = Enum.AutomaticSize.X

    separator()

    -- Time
    local TimeLabel = Instance.new('TextLabel')
    TimeLabel.Name = NeverLose.RandomString()
    TimeLabel.Parent = Bar
    TimeLabel.BackgroundTransparency = 1
    TimeLabel.Size = UDim2.new(0, 0, 0, 16)
    TimeLabel.Font = Enum.Font.GothamMedium
    TimeLabel.Text = os.date('%I:%M %p')
    TimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TimeLabel.TextSize = 14
    TimeLabel.TextTransparency = 0.4
    TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
    TimeLabel.LayoutOrder = nextOrder()
    TimeLabel.ZIndex = 61
    TimeLabel.AutomaticSize = Enum.AutomaticSize.X

    -- Drag
    NeverLose.Drag(Bar, Bar, 0.15)

    -- Fetch game name
    task.spawn(function()
        local success, info = pcall(function()
            return MarketplaceService:GetProductInfo(game.PlaceId)
        end)
        if success and info and info.Name then
            GameLabel.Text = info.Name
        else
            GameLabel.Text = 'Unknown Game'
        end
    end)

    -- Update loop
    local frames = 0
    local renderConnection = RunService.RenderStepped:Connect(function()
        frames = frames + 1
    end)
    NeverLose:AddSignal(renderConnection)

    local updateThread = task.spawn(function()
        while true do
            task.wait(0.5)
            if not Bar.Parent then break end
            FpsLabel.Text = tostring(frames * 2) .. ' fps'
            frames = 0

            local ping = 0
            pcall(function()
                local stat = StatsService.Network.ServerStatsItem['Data Ping']
                ping = math.floor(stat:GetValue())
            end)
            PingLabel.Text = tostring(ping) .. ' ms'

            TimeLabel.Text = os.date('%I:%M %p')
        end
    end)
    NeverLose:AddSignal(updateThread)

    -- Public methods
    function Watermark:SetGameName(name)
        GameLabel.Text = name
    end

    function Watermark:SetTitle(text)
        if TitleLabel then
            TitleLabel.Text = text
        end
    end

    function Watermark:SetVisible(bool)
        if bool then
            Bar.Visible = true
            Bar.BackgroundTransparency = 0
        else
            Bar.Visible = false
            Bar.BackgroundTransparency = 1
        end
    end

    -- Make the title clickable to toggle the interface
    if TitleLabel then
        local btn = Instance.new('TextButton')
        btn.Name = NeverLose.RandomString()
        btn.Parent = TitleLabel
        btn.BackgroundTransparency = 1
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.ZIndex = 100
        btn.Text = ''
        btn.MouseButton1Click:Connect(function()
            if window and window.ToggleInterface then
                window:ToggleInterface()
            end
        end)
    end

    -- Cache
    NeverLose.__WatermarkCache = Watermark
    Watermark.Bar = Bar
    Watermark.TitleLabel = TitleLabel
    Watermark.GameLabel = GameLabel
    Watermark.FpsLabel = FpsLabel
    Watermark.PingLabel = PingLabel
    Watermark.TimeLabel = TimeLabel

    return Watermark
end

	Window:SetRender(false);

	return Window;
end;

local NeverLose = loadstring(game:HttpGet("https://raw.githubusercontent.com/ValuesScripts/GUilibrary-/refs/heads/main/source.lua"))()

local Notification = NeverLose:CreateNotification()
local Logging = NeverLose:CreateLogger()
local Indicator = NeverLose:CreateIndicator()

local window = NeverLose:CreateWindow({
    Logo = nil,
    
    Name = "Ruthless Hub",
    Content = "Made By Value",
    Size = NeverLose.Scales.Default,
    ConfigFolder = "RuthlessHubConfigs",
    Enable3DRenderer = false,
    Keybind = "LeftControl"
})

-- ============================================================
--  WATERMARK (top‑right)
-- ============================================================
local wm = NeverLose:Watermark({
    Title = 'RuthlessHub'  -- big white text on the left
})
wm:SetGameName('mm2')
wm:SetVisible(true)

-- Make the title clickable
if wm.TitleLabel then
    local btn = Instance.new("TextButton")
    btn.Name = NeverLose.RandomString()
    btn.Parent = wm.TitleLabel
    btn.BackgroundTransparency = 1
    btn.Size = UDim2.new(1, 0, 1, 0)  -- covers the whole title label
    btn.ZIndex = 100
    btn.Text = ""
    btn.MouseButton1Click:Connect(function()
        window:ToggleInterface()
    end)
end

local function Notify(title, content, _, _, duration)
    Notification.new({ Title = title, Content = content, Duration = duration or 3 })
end

-- ============================================================
--  GAME SERVICES & GLOBALS (copied from Fluent version)
-- ============================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")

_G.WalkSpeed = 16
_G.GlitchSpeed = 35
_G.JumpPower = 50
_G.FlySpeed = 50
_G.NamesESP = false
_G.BoxESP = false
_G.TracerESP = false
_G.HighlightEnabled = false
_G.DistanceESP = false
_G.GunEspEnabled = false
_G.TrapESP = false
_G.SilentAimEnabled = false
_G.SilentAimKey = "E"
_G.SilentAimOffset = 2.8
_G.SilentAimPingMult = 1
_G.SilentAimMobile = false
_G.KnifeMobileEnabled = false
_G.GrabGunMobile = false
_G.SelectedMobileButton = "SilentAim"
_G.SilentAimSize = 85
_G.FlingMurdererSize = 40
_G.FlingSheriffSize = 40
_G.LockMobileButtons = false
_G.PlayerSpinSpeed = 20
_G.PlayerSpinEnabled = false
_G.BombJump = { Enabled = false, PCKeybind = "B", MobileButton = false }
_G.TargetTracking = {}

-- Remotes
local FadeRemote = nil
local RoundEndFadeRemote = nil
local PlayEmoteRemote = nil
pcall(function()
    local gameplay = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Gameplay")
    FadeRemote = gameplay:WaitForChild("Fade")
    RoundEndFadeRemote = gameplay:WaitForChild("RoundEndFade")
    PlayEmoteRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Misc"):WaitForChild("PlayEmote")
end)

-- ============================================================
--  GAME STATE VARIABLES
-- ============================================================
local roleCache = {}
local playerRoleInfo = {}
local droppedGuns = {}
local flingedPlayers = {}
local killAllActive = false
local spectateEnabled = false
local extremeFlingActive = false
local ctrlClickTeleportEnabled = false
local spectateDropdown = nil
local aimbotActive = false
local silentAimConnection = nil
local noclipConnection = nil
local antiFlingConnection1 = nil
local antiFlingConnection2 = nil
local antiAfkConnection = nil
local knifeAuraConnection = nil
local korbloxConnection = nil
local headlessConnection = nil
local spinConnection = nil
local fpsDescendantConnection = nil
local roundTimerLabel = nil
local roundTimerTask = nil
local xrayConnection = nil
local antiTrapConnection = nil
local extremeFlingCoroutine = nil
local roles = {}
local configFileName = "RuthlessHub_FluentPro_Settings.json"

-- ============================================================
--  SAVE / LOAD (copied from Fluent)
-- ============================================================
local function saveSettings()
    if not writefile then return end
    local data = {}
    for k, v in pairs(_G) do
        local typ = type(v)
        if typ == "string" or typ == "number" or typ == "boolean" then
            data[k] = v
        elseif typ == "table" and k == "WhitelistPlayers" then
            local list = {}
            for name in pairs(v) do table.insert(list, name) end
            data.WhitelistPlayers = list
        elseif typ == "userdata" and typeof(v) == "Color3" then
            data[k] = { v.R, v.G, v.B }
        end
    end
    writefile(configFileName, HttpService:JSONEncode(data))
end

local function loadSettings()
    if not readfile or (not isfile or not isfile(configFileName)) then return false end
    local ok, content = pcall(readfile, configFileName)
    if not ok or not content then return false end
    local ok2, data = pcall(HttpService.JSONDecode, HttpService, content)
    if not ok2 or not data then return false end
    for k, v in pairs(data) do
        if k == "WhitelistPlayers" then
            local tbl = {}
            for _, name in ipairs(v) do tbl[name] = true end
            _G.WhitelistPlayers = tbl
        elseif type(v) == "table" and #v == 3 then
            _G[k] = Color3.new(v[1], v[2], v[3])
        else
            _G[k] = v
        end
    end
    return true
end

local function getPlayerNames()
    local names = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then table.insert(names, player.Name) end
    end
    table.sort(names)
    return names
end

local function isWhitelisted(player)
    if not _G.WhitelistEnabled then return false end
    if _G.WhitelistFriends then
        local ok, result = pcall(function() return LocalPlayer:IsFriendsWith(player.UserId) end)
        if ok and result then return true end
    end
    if _G.WhitelistPlayers and _G.WhitelistPlayers[player.Name] then return true end
    return false
end

-- ============================================================
--  ESP / ROLE FUNCTIONS (copied from Fluent)
-- ============================================================
local function IsAlive(player)
    for name, info in pairs(roles or {}) do
        if player.Name == name then
            return not info.Killed and not info.Dead
        end
    end
    return false
end

local function clearPlayerEsp(player)
    if not player or not player.Character then return end
    local char = player.Character
    local h = char:FindFirstChild("Highlight")
    if h then h:Destroy() end
    local tag = char:FindFirstChild("EspNameTag")
    if tag then tag:Destroy() end
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then
        local box = root:FindFirstChild("EspBox")
        if box then box:Destroy() end
    end
    if player:FindFirstChild("EspDrawings") then
        for _, line in pairs(player.EspDrawings:GetChildren()) do
            if line:IsA("Drawing") then line:Destroy() end
        end
        player.EspDrawings:Destroy()
    end
end

local function NewLine(color)
    local line = Drawing.new("Line")
    line.Visible = false
    line.From = Vector2.new(0, 0)
    line.To = Vector2.new(0, 0)
    line.Color = color or Color3.fromRGB(255, 0, 0)
    line.Thickness = 2
    line.Transparency = 1
    return line
end

-- ============================================================
--  UNIFIED ESP UPDATE (runs every frame)
-- ============================================================
local espDrawings = {}  -- per player: { box, healthbar, name, distance, tracer }

local function getESPForPlayer(player)
    if not espDrawings[player] then
        espDrawings[player] = {
            box = Drawing.new("Square"),
            healthbar = Drawing.new("Line"),
            name = Drawing.new("Text"),
            distance = Drawing.new("Text"),
            tracer = Drawing.new("Line"),
            initialized = false
        }
        -- Setup defaults
        local d = espDrawings[player]
        d.box.Visible = false
        d.box.Thickness = 2
        d.box.Filled = false
        d.healthbar.Visible = false
        d.healthbar.Thickness = 2
        d.name.Visible = false
        d.name.Size = 12
        d.name.Center = true
        d.name.Outline = true
        d.name.OutlineColor = Color3.new(0,0,0)
        d.distance.Visible = false
        d.distance.Size = 10
        d.distance.Center = true
        d.distance.Outline = true
        d.distance.OutlineColor = Color3.new(0,0,0)
        d.tracer.Visible = false
        d.tracer.Thickness = 2
        d.initialized = true
    end
    return espDrawings[player]
end

local function updateESP()
    local myChar = LocalPlayer.Character
    if not myChar then return end
    local myHead = myChar:FindFirstChild("Head")
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myHead or not myRoot then return end

    -- Determine roles (Murder, Sheriff, Hero)
    local Murder, Sheriff, Hero
    for name, info in pairs(roles) do
        local role = info.Role or info
        if role == "Murderer" then Murder = name
        elseif role == "Sheriff" then Sheriff = name
        elseif role == "Hero" then Hero = name end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local char = player.Character
        if not char then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then 
            -- Clear drawings if player dead
            local drawings = espDrawings[player]
            if drawings then
                drawings.box.Visible = false
                drawings.healthbar.Visible = false
                drawings.name.Visible = false
                drawings.distance.Visible = false
                drawings.tracer.Visible = false
            end
local boxGui = root:FindFirstChild("EspBoxBillboard")
if boxGui then boxGui.Enabled = false end
            -- Also remove highlight if present
            local h = char:FindFirstChild("Highlight")
            if h then h.Enabled = false end
-- Destroy tracer beam on death
            local beam = char:FindFirstChild("ESPBeam")
            if beam then beam:Destroy() end
            continue
        end

        local root = char:FindFirstChild("HumanoidRootPart")
        local head = char:FindFirstChild("Head")
        if not root or not head then continue end

        -- Determine role color
        local role = (roles[player.Name] and roles[player.Name].Role) or roleCache[player.Name]
local fillColor = Color3.fromRGB(0, 225, 0) -- default innocent

if player.Name == Murder and IsAlive(player) then
    fillColor = Color3.fromRGB(225, 0, 0) -- murderer
elseif player.Name == Sheriff and IsAlive(player) then
    fillColor = Color3.fromRGB(0, 0, 225) -- sheriff
elseif player.Name == Hero and IsAlive(player) then
    local sheriffPlayer = Sheriff and Players:FindFirstChild(Sheriff)
    if not sheriffPlayer or not IsAlive(sheriffPlayer) then
        fillColor = Color3.fromRGB(255, 250, 0) -- hero (only if sheriff is dead or absent)
    end
end

        -- ===== HIGHLIGHT =====
        -- ===== HIGHLIGHT =====
        if _G.HighlightEnabled then
            local h = char:FindFirstChild("Highlight")
            if not h then
                h = Instance.new("Highlight")
                h.Name = "Highlight"
                h.Parent = char
            end
            h.FillColor = fillColor
            h.FillTransparency = 0.5
            h.OutlineColor = Color3.fromRGB(255,255,255)
            h.OutlineTransparency = 0.3
            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- <--- ADDED THIS LINE
            h.Enabled = true
        else
            local h = char:FindFirstChild("Highlight")
            if h then h.Enabled = false end
        end

        -- ===== DRAWING ELEMENTS =====
        if _G.BoxESP or _G.TracerESP or _G.NamesESP or _G.DistanceESP then
            local d = getESPForPlayer(player)
            local rootPos, rootVis = CurrentCamera:WorldToViewportPoint(root.Position)
            local headPos, headVis = CurrentCamera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
            local legPos = CurrentCamera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
            if not rootVis or not headVis then
                d.box.Visible = false
                d.healthbar.Visible = false
                d.name.Visible = false
                d.distance.Visible = false
                d.tracer.Visible = false
            else
                -- Box ESP (Billboard with corners - Fixed)
                -- Box ESP (Bigger, White corners, Fill inside)
                if _G.BoxESP then
                    -- Find or create the BillboardGui (parented to the ROOT part)
                    local boxGui = root:FindFirstChild("EspBoxBillboard")
                    if not boxGui then
                        boxGui = Instance.new("BillboardGui")
                        boxGui.Name = "EspBoxBillboard"
                        boxGui.Parent = root -- MUST be parented to HumanoidRootPart!
                        boxGui.AlwaysOnTop = true
                        
                        -- Size to cover head to feet (3 wide, 6 tall)
                        boxGui.Size = UDim2.new(3, 0, 6, 0) 
                        boxGui.StudsOffset = Vector3.new(0, 0, 0) -- Centers it on the torso
                        boxGui.MaxDistance = 500

                        -- ===== FILL INSIDE (Very faint) =====
                        local fill = Instance.new("Frame")
                        fill.Name = "Fill"
                        fill.Size = UDim2.new(1, 0, 1, 0)
                        fill.Position = UDim2.new(0, 0, 0, 0)
                        fill.BackgroundColor3 = Color3.fromRGB(32, 32, 97) -- blue tint
                        fill.BackgroundTransparency = 0.45 -- Very faint so it doesn't block view
                        fill.BorderSizePixel = 0
                        fill.Parent = boxGui

                        -- ===== WHITE CORNER LINES (Thin) =====
                        local cornerThickness = 0.01 -- Thin
                        local cornerLength = 0.1   -- Corner length

                        local function createCorner(parent, posX, posY)
                            -- Horizontal white line
                            local h = Instance.new("Frame")
                            h.Size = UDim2.new(cornerLength, 0, cornerThickness, 0)
                            h.Position = UDim2.new(posX, 0, posY, 0)
                            h.AnchorPoint = Vector2.new(posX, posY)
                            h.BackgroundColor3 = Color3.new(1, 1, 1) -- White
                            h.BorderSizePixel = 0
                            h.Parent = parent

                            -- Vertical white line
                            local v = Instance.new("Frame")
                            v.Size = UDim2.new(cornerThickness, 0, cornerLength, 0)
                            v.Position = UDim2.new(posX, 0, posY, 0)
                            v.AnchorPoint = Vector2.new(posX, posY)
                            v.BackgroundColor3 = Color3.new(1, 1, 1) -- White
                            v.BorderSizePixel = 0
                            v.Parent = parent
                        end

                        createCorner(boxGui, 0, 0) -- Top Left
                        createCorner(boxGui, 1, 0) -- Top Right
                        createCorner(boxGui, 0, 1) -- Bottom Left
                        createCorner(boxGui, 1, 1) -- Bottom Right
                    end

                    boxGui.Enabled = true
                    
                    -- (Optional) If you ever want the fill to match the role color, uncomment this:
                    -- local fill = boxGui:FindFirstChild("Fill")
                    -- if fill then fill.BackgroundColor3 = fillColor end

                    -- Keep 2D calculations hidden for the healthbar to work
                    local boxSize = Vector2.new(1000 / rootPos.Z, headPos.Y - legPos.Y)
                    d.box.Size = boxSize
                    d.box.Position = Vector2.new(rootPos.X - boxSize.X/2, rootPos.Y - boxSize.Y/2)
                    d.box.Color = fillColor
                    d.box.Visible = false -- Hidden because it's replaced by the billboard
                else
                    d.box.Visible = false
                    local boxGui = root:FindFirstChild("EspBoxBillboard")
                    if boxGui then boxGui.Enabled = false end
                end               -- Name
                if _G.NamesESP then
            if head then
                local tag = char:FindFirstChild("EspNameTag")
                if not tag then
                    tag = Instance.new("BillboardGui")
                    tag.Name = "EspNameTag"
                    tag.Parent = char
                    tag.AlwaysOnTop = true
                    tag.Size = UDim2.new(0, 200, 0, 50)
                    tag.StudsOffset = Vector3.new(0, 2.5, 0)
                    tag.MaxDistance = 500
                    local label = Instance.new("TextLabel")
                    label.Name = "TextLabel"
                    label.Parent = tag
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.TextScaled = false
                    label.TextSize = 15
                    label.Font = Enum.Font.SourceSansBold
                    label.TextStrokeTransparency = 0.5
                    label.Text = player.Name
                    label.TextColor3 = fillColor
                else
                    tag.TextLabel.TextColor3 = fillColor
                    tag.TextLabel.Text = player.Name
                end
            end
        else
            local tag = char:FindFirstChild("EspNameTag")
            if tag then tag:Destroy() end
        end

                -- Distance
                if _G.DistanceESP then
                    local dist = (myRoot.Position - root.Position).Magnitude
                    d.distance.Position = Vector2.new(rootPos.X, rootPos.Y + 20)
                    d.distance.Text = tostring(math.floor(dist)) .. "m"
                    d.distance.Color = fillColor
                    d.distance.Visible = true
                else
                    d.distance.Visible = false
                end

                -- Tracer
                -- Tracer (3D Beam)
                if _G.TracerESP and hum and hum.Health > 0 then
                    local beam = char:FindFirstChild("ESPBeam")
                    if not beam then
                        -- Create attachments (only once per character)
                        local attach0 = Instance.new("Attachment")
                        attach0.Name = "ESPBeamAttach0"
                        attach0.Parent = myRoot
                        
                        local attach1 = Instance.new("Attachment")
                        attach1.Name = "ESPBeamAttach1"
                        attach1.Parent = root
                        
                        beam = Instance.new("Beam")
                        beam.Name = "ESPBeam"
                        beam.Attachment0 = attach0
                        beam.Attachment1 = attach1
                        beam.FaceCamera = true
                        beam.Width0 = 0.1
                        beam.Width1 = 0.1
                        beam.Parent = char
                    end
                    
                    -- Update Color and Enabled
                    beam.Color = ColorSequence.new(fillColor)
                    beam.Enabled = true
                else
                    -- Disable beam if toggle is off
                    local beam = char:FindFirstChild("ESPBeam")
                    if beam then
                        beam.Enabled = false
                    end
                end
            end
        else
            -- If all drawing ESPs are off, hide all drawings for this player
            local drawings = espDrawings[player]
            if drawings then
                drawings.box.Visible = false
                drawings.healthbar.Visible = false
                drawings.name.Visible = false
                drawings.distance.Visible = false
                drawings.tracer.Visible = false
            end
        end
    end
end

-- Hook to RenderStepped
RunService.RenderStepped:Connect(updateESP)



local function clearEsp()
    for _, player in ipairs(Players:GetPlayers()) do clearPlayerEsp(player) end
end

local function updateRoles()
    for _, player in ipairs(Players:GetPlayers()) do
        local char = player.Character
        if char then
            local backpack = player:FindFirstChild("Backpack")
            if char:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife")) then
                roleCache[player.Name] = "Murderer"
            elseif char:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun")) then
                roleCache[player.Name] = "Sheriff"
            else
                roleCache[player.Name] = nil
            end
        else
            roleCache[player.Name] = nil
        end
    end
end

-- ============================================================
--  BACKGROUND ROLE UPDATER (runs every second)
-- ============================================================
task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            local success, data = pcall(function()
                return ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
            end)
            if success and data and next(data) then
                roles = data
                for name, info in pairs(data) do
                    if info.Role then roleCache[name] = info.Role end
                    playerRoleInfo[name] = info
                end
                -- Optional: notify once
                if not _G._roleNotified then
                    _G._roleNotified = true
                    Notify("ESP", "Roles loaded", "Info", nil, 2)
                end
            else
                updateRoles()
            end
        end)
    end
end)

local function findMurderer()
    for name, role in pairs(roles) do
        local roleName = role.Role or role
        if roleName == "Murderer" then
            return Players:FindFirstChild(name)
        end
    end
    for name, role in pairs(roleCache) do
        if role == "Murderer" then
            return Players:FindFirstChild(name)
        end
    end
    return nil
end

local function findSheriff()
    for name, role in pairs(roles) do
        local roleName = role.Role or role
        if roleName == "Sheriff" then
            return Players:FindFirstChild(name)
        end
    end
    for name, role in pairs(roleCache) do
        if role == "Sheriff" then
            return Players:FindFirstChild(name)
        end
    end
    return nil
end

local function findPlayerByRole(role)
    for name, data in pairs(roles) do
        local roleName = data.Role or data
        if roleName == role then
            local player = Players:FindFirstChild(name)
            if player and player ~= LocalPlayer then
                return player
            end
        end
    end
    for name, cachedRole in pairs(roleCache) do
        if cachedRole == role then
            local player = Players:FindFirstChild(name)
            if player and player ~= LocalPlayer then
                return player
            end
        end
    end
    return nil
end

local function getMyRole()
    local myRole = roleCache[LocalPlayer.Name]
    if not myRole and playerRoleInfo[LocalPlayer.Name] then
        myRole = playerRoleInfo[LocalPlayer.Name].Role
    end
    return myRole or "Unknown"
end

-- ============================================================
--  ALL GAME LOGIC FUNCTIONS (copied from Fluent)
-- ============================================================
local function toggleXray(enabled)
    _G.XrayEnabled = enabled
    local function applyTransparency(obj, trans)
        for _, child in pairs(obj:GetChildren()) do
            if child:IsA("BasePart") and not child.Parent:FindFirstChild("Humanoid") and not child.Parent.Parent:FindFirstChild("Humanoid") then
                child.LocalTransparencyModifier = trans
            end
            applyTransparency(child, trans)
        end
    end
    applyTransparency(workspace, enabled and 0.9 or 0)
end

local function toggleAntiTrap(enabled)
    _G.AntiTrapEnabled = enabled
    if enabled then
        antiTrapConnection = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum.WalkSpeed == 0.01 then
                    hum.WalkSpeed = _G.WalkSpeed
                end
            end
        end)
    else
        if antiTrapConnection then
            antiTrapConnection:Disconnect()
            antiTrapConnection = nil
        end
    end
end

local function toggleAntiFling(enabled)
    _G.AntiFlingEnabled = enabled
    if enabled then
        antiFlingConnection1 = RunService.Heartbeat:Connect(function()
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character and player.Character:IsDescendantOf(workspace) and player.Character.PrimaryPart then
                    local angVel = player.Character.PrimaryPart.AssemblyAngularVelocity.Magnitude
                    local linVel = player.Character.PrimaryPart.AssemblyLinearVelocity.Magnitude
                    if angVel > 50 or linVel > 100 then
                        if not flingedPlayers[player.Name] then
                            Notify("Anti-Fling", "Flinger detected: " .. player.Name, "Warning", nil, 5)
                            flingedPlayers[player.Name] = true
                        end
                        for _, part in ipairs(player.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                                part.AssemblyAngularVelocity = Vector3.zero
                                part.AssemblyLinearVelocity = Vector3.zero
                                part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
                            end
                        end
                    end
                end
            end
        end)
        antiFlingConnection2 = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
                local pp = LocalPlayer.Character.PrimaryPart
                if pp.AssemblyLinearVelocity.Magnitude > 250 or pp.AssemblyAngularVelocity.Magnitude > 250 then
                    pp.AssemblyLinearVelocity = Vector3.zero
                    pp.AssemblyAngularVelocity = Vector3.zero
                    if getgenv().OldPos then
                        pp.CFrame = getgenv().OldPos
                        return
                    end
                else
                    getgenv().OldPos = pp.CFrame
                end
            end
        end)
    else
        if antiFlingConnection1 then antiFlingConnection1:Disconnect() end
        if antiFlingConnection2 then antiFlingConnection2:Disconnect() end
        flingedPlayers = {}
    end
end

local function toggleKnifeAura(enabled)
    _G.KnifeAuraEnabled = enabled
    if enabled then
        knifeAuraConnection = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end
            local knife = char:FindFirstChild("Knife") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Knife"))
            if not knife then return end
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and not isWhitelisted(player) then
                    local root = player.Character:FindFirstChild("HumanoidRootPart")
                    if root and (root.Position - char.HumanoidRootPart.Position).Magnitude < _G.KnifeAuraRange then
                        if knife.Parent ~= char then
                            LocalPlayer.Character.Humanoid:EquipTool(knife)
                        end
                        local stab = knife:FindFirstChild("Stab")
                        if stab then stab:FireServer("Down") end
                        firetouchinterest(root, knife.Handle, 1)
                        firetouchinterest(root, knife.Handle, 0)
                    end
                end
            end
        end)
    else
        if knifeAuraConnection then
            knifeAuraConnection:Disconnect()
            knifeAuraConnection = nil
        end
    end
end

local function throwKnife()
    local char = LocalPlayer.Character
    if not char then return end
    local knife = char:FindFirstChild("Knife") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Knife"))
    if not knife then
        Notify("Throw", "No knife found", "Warning", nil, 2)
        return
    end
    local target = nil
    local dist = math.huge
    local rootPos = char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart.Position or Vector3.zero
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local d = (rootPos - player.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then
                target = player
                dist = d
            end
        end
    end
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        Notify("Throw", "No target found", "Warning", nil, 2)
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if knife.Parent == LocalPlayer.Backpack then
        hum:EquipTool(knife)
        task.wait(0.1)
        knife = char:FindFirstChild("Knife")
        if not knife then return end
    end
    local targetRoot = target.Character.HumanoidRootPart
    local throwRemote = knife:FindFirstChild("Throw") or knife:FindFirstChild("Remote")
    if not throwRemote then
        local events = knife:FindFirstChild("Events")
        if events then
            throwRemote = events:FindFirstChild("KnifeThrown") or events:FindFirstChild("Throw")
        end
    end
    if not throwRemote then
        Notify("Throw", "Throw remote not found", "Error", nil, 2)
        return
    end
    local look = CFrame.lookAt(char.HumanoidRootPart.Position, targetRoot.Position)
    local cframe = CFrame.new(targetRoot.Position)
    pcall(function()
        throwRemote:FireServer(look, cframe)
    end)
end

local function knifeSilentAim()
    throwKnife()
end

local function silentAimShoot()
    local char = LocalPlayer.Character
    if not char then
        Notify("SilentAim", "No character", "Error", nil, 2)
        return
    end

    local gun = char:FindFirstChild("Gun") or char:FindFirstChild("Revolver") or char:FindFirstChild("Pistol")
    if not gun then
        Notify("SilentAim", "No gun equipped", "Error", nil, 2)
        return
    end

    local murderer = findMurderer()
    if not murderer or not murderer.Character then
        Notify("SilentAim", "No murderer found", "Error", nil, 2)
        return
    end

    local targetPart = murderer.Character:FindFirstChild("Torso") or murderer.Character:FindFirstChild("HumanoidRootPart")
    if not targetPart then
        Notify("SilentAim", "Target has no body part", "Error", nil, 2)
        return
    end

    local rootPart = murderer.Character:FindFirstChild("HumanoidRootPart")
    local hum = murderer.Character:FindFirstChildOfClass("Humanoid")
    if not rootPart or not hum then
        Notify("SilentAim", "Target has no root or humanoid", "Error", nil, 2)
        return
    end

    local gunPos = (gun:FindFirstChild("Handle") or gun:FindFirstChild("Gun") or char.HumanoidRootPart).Position
    local targetPos = rootPart.Position

    local ping = LocalPlayer:GetNetworkPing() * 1000
    local pingFactor = math.clamp(ping / 100, 0.5, 3.0)
    local userPingMult = _G.SilentAimPingMult or 1
    pingFactor = pingFactor * userPingMult

    local distance = (targetPos - gunPos).Magnitude
    local bulletSpeed = 2000
    local travelTime = distance / bulletSpeed + 0.08
    local totalDelay = travelTime + (pingFactor * 0.02)

    local velocity = rootPart.AssemblyLinearVelocity
    local moveDirection = hum.MoveDirection

    local predictedVelocity = velocity
    if moveDirection.Magnitude > 0.1 then
        local walkSpeed = hum.WalkSpeed
        predictedVelocity = (moveDirection * walkSpeed) + velocity
    end

    local predictedPos = targetPos + (predictedVelocity * totalDelay)
    local offset = _G.SilentAimOffset or 2.8
    predictedPos = predictedPos + (moveDirection * offset * 0.2)

    local tracking = _G.TargetTracking[murderer.Name]
    local now = os.clock()

    if tracking then
        local dt = now - tracking.prevTime
        if dt > 0 and dt < 0.3 then
            local actualVelocity = (rootPart.Position - tracking.prevPos) / dt
            local smoothVelocity = (actualVelocity * 0.7) + (tracking.velocity * 0.3)
            local smoothPrediction = targetPos + (smoothVelocity * totalDelay)
            predictedPos = predictedPos:Lerp(smoothPrediction, 0.5)
        end
        tracking.prevPos = rootPart.Position
        tracking.prevTime = now
        tracking.velocity = (rootPart.Position - tracking.prevPos) / (now - tracking.prevTime + 0.001)
    else
        _G.TargetTracking[murderer.Name] = {
            prevPos = rootPart.Position,
            prevTime = now,
            velocity = Vector3.zero
        }
    end

    local maxOffset = 15 + (pingFactor * 2)
    if (predictedPos - targetPos).Magnitude > maxOffset then
        predictedPos = targetPos + (predictedPos - targetPos).Unit * maxOffset
    end

    local headOffset = 1.5
    predictedPos = predictedPos + Vector3.new(0, headOffset, 0)

    local shootRemote = gun:FindFirstChild("Shoot") or gun:FindFirstChild("Fire")
    if shootRemote then
        local cframe = CFrame.lookAt(gunPos, predictedPos)
        pcall(function() 
            shootRemote:FireServer(cframe, CFrame.new(predictedPos)) 
        end)
        pcall(function() 
            shootRemote:FireServer(cframe) 
        end)
        if ping > 100 then
            Notify("SilentAim", "Ping: " .. math.floor(ping) .. "ms | Offset: " .. math.floor((predictedPos - targetPos).Magnitude * 10) / 10, "Info", nil, 1)
        end
    else
        Notify("SilentAim", "Shoot remote not found", "Error", nil, 2)
    end
end

local function toggleAimbot(enabled)
    _G.AimbotEnabled = enabled
    if enabled then
        aimbotActive = true
        task.spawn(function()
            while aimbotActive do
                if findPlayerByRole("Sheriff") ~= LocalPlayer then
                    local murderer = findPlayerByRole("Murderer")
                    if murderer and murderer.Character then
                        local root = murderer.Character:FindFirstChild("HumanoidRootPart")
                        if root then
                            CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, root.Position)
                        end
                    end
                end
                task.wait()
            end
        end)
    else
        aimbotActive = false
    end
end

local function flingPlayer(target)
    if not target or target == LocalPlayer then return end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = hum and hum.RootPart
    if not char or not root then return end
    local targetChar = target.Character
    if not targetChar then return end
    local targetHum = targetChar:FindFirstChildOfClass("Humanoid")
    local targetRoot = targetHum and targetHum.RootPart
    local targetHead = targetChar:FindFirstChild("Head")
    if not targetHum or not targetRoot then return end
    if targetHum.Sit then return end

    if root.Velocity.Magnitude < 50 then getgenv().OldPos = root.CFrame end

    local oldSubject = CurrentCamera.CameraSubject
    if targetHead then CurrentCamera.CameraSubject = targetHead
    elseif targetHum then CurrentCamera.CameraSubject = targetHum end

    workspace.FallenPartsDestroyHeight = 0/0
    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)

    local angle = 0
    local basePart = targetHead or targetRoot

    local function FPos(BasePart, Pos, Ang)
        root.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
        char:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
        root.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
        root.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
    end

    local TimeToWait = 2
    local Time = tick()
    repeat
        if root and targetHum then
            if basePart.Velocity.Magnitude < 50 then
                angle = angle + 100
                FPos(basePart, CFrame.new(0, 1.5, 0) + targetHum.MoveDirection * basePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle), 0, 0))
                task.wait()
                FPos(basePart, CFrame.new(0, -1.5, 0) + targetHum.MoveDirection * basePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle), 0, 0))
                task.wait()
                FPos(basePart, CFrame.new(2.25, 1.5, -2.25) + targetHum.MoveDirection * basePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle), 0, 0))
                task.wait()
                FPos(basePart, CFrame.new(-2.25, -1.5, 2.25) + targetHum.MoveDirection * basePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle), 0, 0))
                task.wait()
            else
                FPos(basePart, CFrame.new(0, 1.5, targetHum.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                task.wait()
                FPos(basePart, CFrame.new(0, -1.5, -targetHum.WalkSpeed), CFrame.Angles(0, 0, 0))
                task.wait()
                FPos(basePart, CFrame.new(0, 1.5, targetRoot.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                task.wait()
            end
        else break end
    until basePart.Velocity.Magnitude > 500 or basePart.Parent ~= targetChar or tick() > Time + TimeToWait

    local BV = Instance.new("BodyVelocity")
    BV.Name = "EpixVel"
    BV.Parent = root
    BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
    BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
    BV:Destroy()

    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    workspace.FallenPartsDestroyHeight = getgenv().FPDH or -500

    if oldSubject and oldSubject.Parent then CurrentCamera.CameraSubject = oldSubject else CurrentCamera.CameraSubject = hum end

    if getgenv().OldPos then
        local attempts = 0
        repeat
            root.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0)
            char:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 0.5, 0))
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            for _, part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then part.Velocity = Vector3.zero; part.RotVelocity = Vector3.zero end end
            task.wait()
            attempts += 1
        until (root.Position - getgenv().OldPos.p).Magnitude < 25 or attempts > 50
    end
    hum.PlatformStand = false
    hum:ChangeState(Enum.HumanoidStateType.Running)
    task.wait(0.1)
    hum.WalkSpeed = _G.WalkSpeed or 16
end

local function flingByRole(role)
    local target = findPlayerByRole(role)
    if target then
        task.spawn(function() flingPlayer(target) end)
        return
    end
    Notify("Error", "No " .. role .. " found", "Error", nil, 2)
end

local function extremeFlingLoop()
    local player = LocalPlayer
    local direction = 0.1
    while extremeFlingActive do
        RunService.Heartbeat:Wait()
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local vel = root.Velocity
            root.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
            RunService.RenderStepped:Wait()
            if root then root.Velocity = vel end
            RunService.Stepped:Wait()
            if root then                root.Velocity = vel + Vector3.new(0, direction, 0)
                direction = -direction
            end
        end
    end
end

local function toggleExtremeFling(enabled)
    extremeFlingActive = enabled
    if enabled then
        if extremeFlingCoroutine then coroutine.close(extremeFlingCoroutine) end
        extremeFlingCoroutine = coroutine.create(extremeFlingLoop)
        coroutine.resume(extremeFlingCoroutine)
        Notify("Extreme Fling", "ON", "Success", nil, 2)
    else
        if extremeFlingCoroutine then coroutine.close(extremeFlingCoroutine) end
        local char = LocalPlayer.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.Velocity = Vector3.zero
                root.RotVelocity = Vector3.zero
            end
        end
        Notify("Extreme Fling", "OFF", "Info", nil, 2)
    end
end

local function refreshSpectateList()
    if spectateDropdown then
        local names = getPlayerNames()
        spectateDropdown:SetValues(names)
        spectateDropdown:SetValue(nil)
        Notify("Spectate", "Player list refreshed", "Info", nil, 2)
    end
end

local function spectatePlayer(name)
    if not spectateEnabled then
        Notify("Spectate", "Enable Spectate first!", "Warning", nil, 2)
        return
    end
    if not name or name == "" then
        CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        Notify("Spectate", "Stopped", "Info", nil, 2)
        return
    end
    local player = Players:FindFirstChild(name)
    if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        CurrentCamera.CameraSubject = player.Character:FindFirstChildOfClass("Humanoid")
        Notify("Spectate", "Now spectating: " .. player.Name, "Info", nil, 2)
    else
        Notify("Spectate", "Player not found or no character", "Error", nil, 2)
    end
end

local function toggleRoundTimer(enabled)
    _G.RoundTimer = enabled
    if enabled then
        roundTimerLabel = Instance.new("TextLabel")
        roundTimerLabel.Parent = CoreGui
        roundTimerLabel.BackgroundTransparency = 1
        roundTimerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        roundTimerLabel.TextScaled = true
        roundTimerLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        roundTimerLabel.Position = UDim2.fromScale(0.5, 0.15)
        roundTimerLabel.Size = UDim2.fromOffset(200, 50)
        roundTimerLabel.Font = Enum.Font.GothamBold
        roundTimerLabel.Text = "Round Timer: --"
        roundTimerTask = task.spawn(function()
            while _G.RoundTimer do
                pcall(function()
                    local getTimer = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Extras") and ReplicatedStorage.Remotes.Extras:FindFirstChild("GetTimer")
                    if getTimer then
                        local timer = getTimer:InvokeServer()
                        if timer and timer ~= -1 then
                            local mins = math.floor(timer / 60)
                            local secs = timer % 60
                            roundTimerLabel.Text = string.format("Round Timer: %02d:%02d", mins, secs)
                            return
                        end
                        roundTimerLabel.Text = "Round Timer: --"
                    end
                end)
                task.wait(0.5)
            end
        end)
    else
        if roundTimerLabel then roundTimerLabel:Destroy() end
        if roundTimerTask then task.cancel(roundTimerTask) end
    end
end

local function toggleKorblox(enabled)
    _G.KorbloxEnabled = enabled
    if enabled then
        if korbloxConnection then korbloxConnection:Disconnect() end
        korbloxConnection = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
            if char then
                for _, partName in ipairs({ "RightLowerLeg", "RightUpperLeg", "RightFoot" }) do
                    local part = char:FindFirstChild(partName)
                    if part then
                        if partName == "RightLowerLeg" then
                            part.MeshId = "http://www.roblox.com/asset/?id=902942093"
                            part.Transparency = 1
                        elseif partName == "RightUpperLeg" then
                            part.MeshId = "http://www.roblox.com/asset/?id=902942096"
                            part.TextureID = "http://www.roblox.com/asset/?id=902843398"
                        elseif partName == "RightFoot" then
                            part.MeshId = "http://www.roblox.com/asset/?id=902942089"
                            part.Transparency = 1
                        end
                    end
                end
            end
        end)
    else
        if korbloxConnection then
            korbloxConnection:Disconnect()
            korbloxConnection = nil
        end
    end
end

local function togglePlayerSpin(enabled)
    _G.PlayerSpinEnabled = enabled
    if enabled then
        if spinConnection then spinConnection:Disconnect() end
        spinConnection = RunService.RenderStepped:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then return end
            local speed = _G.PlayerSpinSpeed or 20
            local rotation = math.rad(speed * 3)
            root.CFrame = root.CFrame * CFrame.Angles(0, -rotation, 0)
        end)
    else
        if spinConnection then
            spinConnection:Disconnect()
            spinConnection = nil
        end
    end
end

local function toggleHeadless(enabled)
    _G.HeadlessEnabled = enabled
    if enabled then
        if headlessConnection then headlessConnection:Disconnect() end
        headlessConnection = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
            if char then
                local head = char:FindFirstChild("Head")
                if head then
                    head.MeshId = "http://www.roblox.com/asset/?id=6686307858"
                    head.TextureID = "http://www.roblox.com/asset/?id=6686307858"
                    head.Transparency = 1
                end
            end
        end)
    else
        if headlessConnection then
            headlessConnection:Disconnect()
            headlessConnection = nil
        end
    end
end

local function setupSilentAimKeybind()
    if silentAimConnection then silentAimConnection:Disconnect() end
    local key = _G.SilentAimKey
    if type(key) ~= "string" then key = "E"; _G.SilentAimKey = "E" end
    if _G.SilentAimEnabled and key ~= "NONE" then
        local enumKey = Enum.KeyCode[key] or Enum.KeyCode.E
        silentAimConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == enumKey then
                silentAimShoot()
            end
        end)
    end
end

local function trapPlayer(target)
    if not target or not target.Character then return end
    local trap = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Trap")
    if not trap then return end
    local activate = trap:FindFirstChild("Activate")
    if activate then
        activate:FireServer(target.Character.HumanoidRootPart.CFrame)
    end
end

local function updateMovement()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end
    local isFalling = hum:GetState() == Enum.HumanoidStateType.Freefall or hum:GetState() == Enum.HumanoidStateType.Jumping
    hum.WalkSpeed = _G.SpeedGlitchEnabled and (isFalling and _G.GlitchSpeed or _G.WalkSpeed) or _G.WalkSpeed
    hum.JumpPower = _G.JumpPower
    hum.UseJumpPower = true
end

-- ============================================================
--  HOLD EVERYONE HOSTAGE (from YARHM)
-- ============================================================
local function holdEveryoneHostage()
    local myRole = getMyRole()
    if myRole ~= "Murderer" then
        Notify("Hostage", "You must be the murderer!", "Error", nil, 2)
        return
    end
    local char = LocalPlayer.Character
    if not char then
        Notify("Hostage", "No character!", "Error", nil, 2)
        return
    end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local anchored = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local prt = player.Character:FindFirstChild("HumanoidRootPart")
            if prt then
                prt.Anchored = true
                prt.CFrame = root.CFrame + root.CFrame.LookVector * 5
                table.insert(anchored, prt)
            end
        end
    end
    Notify("Hostage", "All players are now hostage!", "Success", nil, 3)

    -- Auto‑release after 5 seconds
    task.delay(5, function()
        for _, prt in ipairs(anchored) do
            if prt and prt.Parent then
                prt.Anchored = false
            end
        end
        Notify("Hostage", "Players released", "Info", nil, 2)
    end)
end

-- ============================================================
--  KILL EVERYONE (INSTANT) (from YARHM)
-- ============================================================
local function killEveryone()
    local myRole = getMyRole()
    if myRole ~= "Murderer" then
        Notify("Kill All", "You must be the murderer!", "Error", nil, 2)
        return
    end

    local char = LocalPlayer.Character
    if not char then return end

    -- Find and equip knife
    local knife = char:FindFirstChild("Knife") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Knife"))
    if not knife then
        Notify("Kill All", "No knife found!", "Error", nil, 2)
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if knife.Parent == LocalPlayer.Backpack then
        hum:EquipTool(knife)
        task.wait(0.1)
        knife = char:FindFirstChild("Knife")
        if not knife then return end
    end

    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- Anchor all players and pull them close
    local anchored = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local prt = player.Character:FindFirstChild("HumanoidRootPart")
            if prt then
                prt.Anchored = true
                prt.CFrame = root.CFrame + root.CFrame.LookVector * 2
                table.insert(anchored, prt)
            end
        end
    end

    -- Fire stab remote
    local stab = knife:FindFirstChild("Stab")
    if stab then
        stab:FireServer("Slash")
        Notify("Kill All", "All players killed!", "Success", nil, 3)
    else
        Notify("Kill All", "Stab remote not found!", "Error", nil, 2)
    end

    -- Unanchor after a moment
    task.delay(1, function()
        for _, prt in ipairs(anchored) do
            if prt and prt.Parent then
                prt.Anchored = false
            end
        end
    end)
end

-- Continuous speed glitch updater
local speedGlitchConnection = nil
local function startSpeedGlitchUpdater()
    if speedGlitchConnection then speedGlitchConnection:Disconnect() end
    speedGlitchConnection = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health > 0 and _G.SpeedGlitchEnabled then
            local isFalling = hum:GetState() == Enum.HumanoidStateType.Freefall or 
                              hum:GetState() == Enum.HumanoidStateType.Jumping
            hum.WalkSpeed = isFalling and _G.GlitchSpeed or _G.WalkSpeed
        end
    end)
end

local flyConnection = nil
local flyBodyVelocity = nil
local flyBodyGyro = nil

local function toggleFly(enabled)
    _G.FlyEnabled = enabled
    local char = LocalPlayer.Character
    if not char then return end

    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if not torso then return end

    if enabled then
        -- Disable humanoid states and set PlatformStand
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.PlatformStand = true
            for _, state in pairs(Enum.HumanoidStateType:GetEnumItems()) do
                hum:SetStateEnabled(state, false)
            end
            hum:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
            hum:ChangeState(Enum.HumanoidStateType.Swimming)
        end

        local animate = char:FindFirstChild("Animate")
        if animate then animate.Disabled = true end

        -- BodyGyro (rotation)
        flyBodyGyro = Instance.new("BodyGyro")
        flyBodyGyro.P = 9e4
        flyBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        flyBodyGyro.CFrame = torso.CFrame
        flyBodyGyro.Parent = torso

        -- BodyVelocity (movement)
        flyBodyVelocity = Instance.new("BodyVelocity")
        flyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        flyBodyVelocity.Parent = torso

        -- Fly loop
        flyConnection = RunService.RenderStepped:Connect(function()
            if not _G.FlyEnabled or not char.Parent or not torso.Parent then
                toggleFly(false)
                return
            end

            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end

            local cam = CurrentCamera
            local forward = cam.CFrame.LookVector
            local right = cam.CFrame.RightVector
            local up = Vector3.new(0, 1, 0)

            -- Get joystick direction (mobile) or WASD (PC) via MoveDirection
            local moveDir = hum.MoveDirection  -- vector in world space, normalized

            -- Horizontal velocity: project moveDir onto camera's horizontal plane
            local forwardComp = moveDir:Dot(forward)
            local rightComp = moveDir:Dot(right)
            local vel = (forward * forwardComp + right * rightComp) * _G.FlySpeed

            -- Vertical control: jump (Space) for up, crouch (LeftControl) for down
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                vel = vel + up * _G.FlySpeed
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                vel = vel - up * _G.FlySpeed
            end

            -- If no input, stop completely
            if moveDir.Magnitude == 0 and not UserInputService:IsKeyDown(Enum.KeyCode.Space) and not UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                vel = Vector3.zero
            end

            flyBodyVelocity.Velocity = vel
            flyBodyGyro.CFrame = cam.CFrame
        end)

    else
        -- Cleanup
        if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
        if flyBodyVelocity then flyBodyVelocity:Destroy(); flyBodyVelocity = nil end
        if flyBodyGyro then flyBodyGyro:Destroy(); flyBodyGyro = nil end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.PlatformStand = false
            for _, state in pairs(Enum.HumanoidStateType:GetEnumItems()) do
                hum:SetStateEnabled(state, true)
            end
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end

        local animate = char:FindFirstChild("Animate")
        if animate then animate.Disabled = false end
    end
end

local function toggleNoclip(enabled)
    _G.NoclipEnabled = enabled
    if enabled then
        noclipConnection = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() end
    end
end

local function toggleAntiAfk(enabled)
    _G.AntiAfkEnabled = enabled
    if enabled then
        antiAfkConnection = LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    else
        if antiAfkConnection then antiAfkConnection:Disconnect() end
    end
end

local function toggleEasyGlitch(enabled)
    _G.EasyGlitch = enabled
    if not enabled then return end

    local function canGlitch()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return false end
        local root = char.HumanoidRootPart
        local look = root.CFrame.LookVector * Vector3.new(1, 0, 1)
        return workspace:Raycast(root.Position, look.Unit * 0.4) ~= nil
    end

    local function doGlitch()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local root = char.HumanoidRootPart
        local offset = root.CFrame.LookVector * Vector3.new(1, 0, 1).Unit * 1.2
        root.Position = root.Position + offset
    end

    local function setupToolEquip(char)
        for _, child in pairs(char:GetChildren()) do
            if child:IsA("Tool") then
                child.Equipped:Connect(function()
                    if _G.EasyGlitch and canGlitch() then doGlitch() end
                end)
            end
        end
        local backpack = LocalPlayer:WaitForChild("Backpack")
        for _, tool in pairs(backpack:GetChildren()) do
            if tool:IsA("Tool") then
                tool.Equipped:Connect(function()
                    if _G.EasyGlitch and canGlitch() then doGlitch() end
                end)
            end
        end
        backpack.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                child.Equipped:Connect(function()
                    if _G.EasyGlitch and canGlitch() then doGlitch() end
                end)
            end
        end)
        char.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                child.Equipped:Connect(function()
                    if _G.EasyGlitch and canGlitch() then doGlitch() end
                end)
            end
        end)
    end

    if LocalPlayer.Character then
        setupToolEquip(LocalPlayer.Character)
    end
    LocalPlayer.CharacterAdded:Connect(setupToolEquip)
end

-- ============================================================
--  COIN FARM (copied from Fluent)
-- ============================================================
_G.CoinFarmEnabled = false
_G.CoinFarmSpeed = 25
_G.CoinFarmRadius = 200
_G._coinFarmThread = nil
_G._collectedCoins = 0
_G._farmStartTime = 0
_G._currentRoundFarm = 0
_G._roundStartTimeFarm = 0

local OctreeModule = _G._OctreeModule or loadstring(game:HttpGet("https://raw.githubusercontent.com/Sleitnick/rbxts-octo-tree/main/src/init.lua", true))()
_G._OctreeModule = OctreeModule

local function getMapContainer()
    for _, child in ipairs(workspace:GetChildren()) do
        if child:GetAttribute("MapID") and child:FindFirstChild("CoinContainer") then
            return child
        end
    end
    return nil
end

local function getMurdererFromData()
    local ok, data = pcall(function() return ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer() end)
    if ok and data then
        for name, info in pairs(data) do
            if info.Role == "Murderer" then
                return Players:FindFirstChild(name)
            end
        end
    end
    return nil
end

local function findNearestCoin(pos, radius)
    local map = getMapContainer()
    if not map or not map:FindFirstChild("CoinContainer") then return nil end
    local octree = OctreeModule.new()
    for _, coin in ipairs(map.CoinContainer:GetChildren()) do
        local visual = coin:FindFirstChild("CoinVisual")
        if visual and not visual:GetAttribute("Collected") then
            octree:CreateNode(coin.Position, coin)
        end
    end
    local nearest = octree:GetNearest(pos, radius, 10)
    if not nearest or #nearest == 0 then return nil end
    local murderer = getMurdererFromData()
    local murdererPos
    if murderer and murderer.Character then
        local root = murderer.Character:FindFirstChild("HumanoidRootPart")
        if root then murdererPos = root.Position end
    end
    if not murdererPos then return nearest[1] and nearest[1].Object or nil end
    local farthestDist = -1
    local chosen
    for _, node in ipairs(nearest) do
        local obj = node.Object
        if obj and obj.Position then
            local d = (obj.Position - murdererPos).Magnitude
            if d > farthestDist then
                chosen = obj
                farthestDist = d
            end
        end
    end
    return chosen or (nearest[1] and nearest[1].Object or nil)
end

local function moveToCoin(char, targetPos, duration)
    if not char or not targetPos then return end
    local startPos = char:GetPivot().Position
    local startTime = tick()
    while _G.CoinFarmEnabled do
        local elapsed = tick() - startTime
        local progress = math.min(elapsed / duration, 1)
        local pos = startPos:Lerp(targetPos, progress)
        char:PivotTo(CFrame.new(pos))
        if progress >= 1 then
            task.wait(0.2)
            return
        end
        task.wait()
    end
end

local function getCharacterAndParts()
    while _G.CoinFarmEnabled do
        local char = LocalPlayer.Character
        if char and LocalPlayer:GetAttribute("Alive") then
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if root and hum then
                return char, root, hum
            end
        end
        task.wait(0.5)
    end
    return nil, nil, nil
end

local function startCoinFarm()
    if _G._coinFarmThread then return end
    _G.CoinFarmEnabled = true
    _G._collectedCoins = 0
    _G._farmStartTime = tick()
    _G._roundStartTimeFarm = tick()
    _G._currentRoundFarm = 0

    ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("RoundStart").OnClientEvent:Connect(function()
        if _G.CoinFarmEnabled then
            _G._currentRoundFarm += 1
            _G._roundStartTimeFarm = tick()
            Notify("Coin Farm", "Round " .. _G._currentRoundFarm .. " started", "Info", nil, 3)
        end
    end)

    _G._coinFarmThread = task.spawn(function()
        repeat
            local shouldStop = false
            while _G.CoinFarmEnabled do
                local char, root, hum = getCharacterAndParts()
                if not char then break end

                local map = getMapContainer()
                while _G.CoinFarmEnabled and not map do
                    task.wait(1)
                    map = getMapContainer()
                end
                if not _G.CoinFarmEnabled then break end

                repeat
                    if not _G.CoinFarmEnabled or not char.Parent or not LocalPlayer:GetAttribute("Alive") or not char:FindFirstChildOfClass("Humanoid") then
                        shouldStop = true
                        break
                    end

                    local rootPos = char:GetPivot().Position
                    local coin = findNearestCoin(rootPos, _G.CoinFarmRadius)
                    if coin then
                        local targetPos = coin.Position
                        local duration = math.max(0.5, (rootPos - targetPos).Magnitude / _G.CoinFarmSpeed)
                        pcall(function() moveToCoin(char, targetPos, duration) end)
                        local visual = coin:FindFirstChild("CoinVisual")
                        local waitTime = 0
                        while _G.CoinFarmEnabled and visual and not visual:GetAttribute("Collected") and visual.Parent and waitTime < 10 do
                            local newCoin = findNearestCoin(char:GetPivot().Position, _G.CoinFarmRadius)
                            if newCoin and newCoin ~= coin then break end
                            task.wait(0.1)
                            waitTime += 0.1
                        end
                        _G._collectedCoins += 1
                        Notify("Coin Farm", "Collected " .. _G._collectedCoins .. " coins", "Info", nil, 2)
                    else
                        task.wait(2)
                    end
                until not coin and tick() - _G._roundStartTimeFarm > 30

                if shouldStop then break end
                Notify("Coin Farm", "No coins for 30s, respawning...", "Warning", nil, 3)
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                    LocalPlayer.Character.Humanoid.Health = 0
                end
                task.wait(3)
            end
        until not shouldStop
        _G._coinFarmThread = nil
    end)
    Notify("Coin Farm", "Started (Speed: " .. _G.CoinFarmSpeed .. ")", "Success", nil, 3)
end

local function stopCoinFarm()
    _G.CoinFarmEnabled = false
    if _G._coinFarmThread then
        task.cancel(_G._coinFarmThread)
        _G._coinFarmThread = nil
    end
    Notify("Coin Farm", "Stopped", "Info", nil, 2)
end

function toggleCoinFarm(enabled)
    if enabled then startCoinFarm() else stopCoinFarm() end
    saveSettings()
end

-- ============================================================
--  DROPKICK AND RUN (copied from Fluent)
-- ============================================================
local dropkickPower = 50
local runSpeedPercent = 20
local baseWalkSpeed = 16
local dropkickActive = false
local dropkickRunning = false
local runActive = false
local dropkickAnimTrack = nil
local runAnimTrack = nil
local runRenderConnection = nil
local dropkickAnimId = "rbxassetid://133566007754001"
local runAnimId = "rbxassetid://70636286183373"
local dropkickEnabled = false
local runEnabled = false
local mobileDropkickUI = nil

local function getHumanoid()
    return (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("Humanoid", 5)
end

local function playDropkickAnim()
    local hum = getHumanoid()
    if not hum then return end
    local anim = Instance.new("Animation")
    anim.AnimationId = dropkickAnimId
    dropkickAnimTrack = hum:LoadAnimation(anim)
    dropkickAnimTrack.Priority = Enum.AnimationPriority.Action
    dropkickAnimTrack.Looped = false
    dropkickAnimTrack:Play()
end

local function startDropkickMovement()
    dropkickRunning = true
    task.spawn(function()
        local dir = 0.1
        while dropkickRunning do
            RunService.Heartbeat:Wait()
            local char = LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                local vel = root.Velocity
                root.Velocity = vel * dropkickPower + Vector3.new(0, 0, dropkickPower)
                RunService.RenderStepped:Wait()
                if root then root.Velocity = vel end
                RunService.Stepped:Wait()
                if root then
                    root.Velocity = vel + Vector3.new(0, 0.1, 0)
                end
            end
        end
    end)
end

local function stopDropkickMovement() end

local function activateDropkick()
    if not dropkickEnabled then
        Notify("Dropkick", "Enable in menu first!", "Warning", nil, 2)
        return
    end
    if dropkickActive then return end
    if dropkickAnimTrack then dropkickAnimTrack:Stop() end

    playDropkickAnim()
    startDropkickMovement()
    task.delay(2, function()
        stopDropkickMovement()
        if dropkickAnimTrack then
            dropkickAnimTrack:Stop()
            dropkickAnimTrack = nil
        end
    end)
    task.spawn(function()
        for i = 3, 1, -1 do
            Notify("Dropkick", "Wait " .. i, "Info", nil, 1)
            task.wait(1)
        end
        Notify("Dropkick", "Ready", "Success", nil, 1)
    end)
end

local function toggleRun()
    if not runEnabled then
        Notify("Run", "Enable in menu first!", "Warning", nil, 2)
        return
    end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    if runActive then
        runActive = false
        hum.WalkSpeed = baseWalkSpeed
        if runRenderConnection then runRenderConnection:Disconnect() end
        if runAnimTrack then
            runAnimTrack:Stop()
            runAnimTrack = nil
        end
        Notify("Run", "Disabled", "Info", nil, 1)
    else
        runActive = true
        hum.WalkSpeed = math.max(0.5, baseWalkSpeed * (runSpeedPercent / 100))
        local anim = Instance.new("Animation")
        anim.AnimationId = runAnimId
        runAnimTrack = hum:LoadAnimation(anim)
        runAnimTrack.Priority = Enum.AnimationPriority.Action
        runAnimTrack.Looped = true
        runRenderConnection = RunService.RenderStepped:Connect(function()
            local hum2 = char:FindFirstChildOfClass("Humanoid")
            if not hum2 or not runAnimTrack then return end
            local moving = hum2.MoveDirection.Magnitude > 0 and hum2.FloorMaterial ~= Enum.Material.Air
            if moving and not runAnimTrack.IsPlaying then
                runAnimTrack:Play()
                runAnimTrack:AdjustSpeed(1)
            elseif not moving and runAnimTrack.IsPlaying then
                runAnimTrack:Stop()
            end
        end)
        Notify("Run", "Enabled (Speed: " .. runSpeedPercent .. "%)", "Success", nil, 2)
    end
    refreshMobileButtons()
end

local function updateMobileRunButton()
    if mobileDropkickUI then
        local btn = mobileDropkickUI:FindFirstChild("RunButton")
        if btn then
            btn.Text = runActive and "RUN ON" or "RUN OFF"
            btn.BackgroundColor3 = runActive and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(220, 40, 40)
        end
    end
end

local function refreshMobileButtons()
    if not isMobile then return end
    if mobileDropkickUI then
        mobileDropkickUI:Destroy()
        mobileDropkickUI = nil
    end
    if not dropkickEnabled and not runEnabled then return end

    mobileDropkickUI = Instance.new("ScreenGui")
    mobileDropkickUI.Name = "DropkickMobileUI"
    mobileDropkickUI.Parent = LocalPlayer.PlayerGui
    mobileDropkickUI.ResetOnSpawn = false
    mobileDropkickUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    mobileDropkickUI.DisplayOrder = 100

    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Size = UDim2.new(0, 170, 0, 75)
    container.Position = UDim2.new(1, -180, 0, 20)
    container.BackgroundTransparency = 1
    container.Parent = mobileDropkickUI

    local function createButton(name, text, callback, isToggle)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Size = UDim2.new(0, 75, 0, 75)
        btn.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
        btn.Text = text
        btn.Font = Enum.Font.SourceSansBold
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.TextSize = 14
        btn.TextWrapped = true
        btn.BorderSizePixel = 0
        btn.ZIndex = 10
        btn.Active = true
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0.2, 0)
        btn.Parent = container
        if isToggle then
            btn.MouseButton1Click:Connect(function()
                callback()
                updateMobileRunButton()
            end)
        else
            btn.MouseButton1Click:Connect(callback)
        end
        return btn
    end

    if runEnabled then
        local runBtn = createButton("RunButton", "RUN", toggleRun, true)
        runBtn.Position = UDim2.new(0, 5, 0, 0)
        updateMobileRunButton()
    end
    if dropkickEnabled then
        local dropBtn = createButton("DropButton", "DROP\nKICK", activateDropkick, false)
        dropBtn.Position = UDim2.new(1, -80, 0, 0)
        if runEnabled then
            dropBtn.Position = UDim2.new(0, 90, 0, 0)
            local runBtn = container:FindFirstChild("RunButton")
            if runBtn then
                runBtn.Position = UDim2.new(0, 5, 0, 0)
            end
        end
    end
end

local dropkickHotkey = Enum.KeyCode.K
local runHotkey = Enum.KeyCode.J

if _G.dropkickHotkeyConn then _G.dropkickHotkeyConn:Disconnect() end
if _G.runHotkeyConn then _G.runHotkeyConn:Disconnect() end

_G.dropkickHotkeyConn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == dropkickHotkey and dropkickEnabled then
        activateDropkick()
    elseif input.KeyCode == runHotkey and runEnabled then
        toggleRun()
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    runActive = false
    if dropkickAnimTrack then dropkickAnimTrack:Stop() end
    if runAnimTrack then runAnimTrack:Stop() end
    if runRenderConnection then runRenderConnection:Disconnect() end
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = baseWalkSpeed end
    refreshMobileButtons()
end)

_G.Dropkick = {
    activate = activateDropkick,
    toggleRun = toggleRun,
    getPower = function() return dropkickPower end,
    setPower = function(v) dropkickPower = v end,
    getRunSpeed = function() return runSpeedPercent end,
    setRunSpeed = function(v) runSpeedPercent = v end,
    getDropkickHotkey = function() return dropkickHotkey end,
    setDropkickHotkey = function(v) dropkickHotkey = v end,
    getRunHotkey = function() return runHotkey end,
    setRunHotkey = function(v) runHotkey = v end,
    isRunActive = function() return runActive end,
    setDropkickEnabled = function(v)
        dropkickEnabled = v
        if not v and dropkickAnimTrack then
            dropkickAnimTrack:Stop()
            dropkickAnimTrack = nil
        end
        refreshMobileButtons()
    end,
    setRunEnabled = function(v)
        runEnabled = v
        if not v and runActive then
            runActive = false
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = baseWalkSpeed end
            if runRenderConnection then runRenderConnection:Disconnect() end
            if runAnimTrack then
                runAnimTrack:Stop()
                runAnimTrack = nil
            end
        end
        refreshMobileButtons()
    end,
    isDropkickEnabled = function() return dropkickEnabled end,
    isRunEnabled = function() return runEnabled end,
    refreshMobileButtons = refreshMobileButtons,
    updateMobileRunButton = updateMobileRunButton
}

-- ============================================================
--  MOBILE BUTTON FUNCTIONS (copied from Fluent)
-- ============================================================
local function makeDraggable(btn)
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    btn.InputBegan:Connect(function(input)
        if _G.LockMobileButtons then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = btn.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    btn.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function equipToolAndFire(toolNames, action)
    local char = LocalPlayer.Character
    if not char then
        action()
        return
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then
        action()
        return
    end

    local wasEquipped = false
    local equippedTool = nil

    -- Find and equip the tool if it's not already in hand
    for _, toolName in ipairs(toolNames) do
        local tool = char:FindFirstChild(toolName) or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild(toolName))
        if tool then
            if tool.Parent ~= char then
                hum:EquipTool(tool)
                task.wait(0.1)          -- give time for the tool to be equipped
                wasEquipped = true
            else
                wasEquipped = false     -- already equipped, we won't unequip it
            end
            equippedTool = tool
            break
        end
    end

    -- Execute the action (shoot / throw)
    action()

    -- Wait a bit so the action registers on the server
    task.wait(0.05)

    -- Unequip only if we equipped it temporarily
    if equippedTool and wasEquipped and equippedTool.Parent == char then
        equippedTool.Parent = LocalPlayer.Backpack   -- move back to backpack → unequips
    end
end

-- ============================================================
--  GRAB GUN FUNCTION
-- ============================================================
function grabGun()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then
        Notify("Grab Gun", "No character root", "Error", nil, 2)
        return
    end

    local nearestGun = nil
    local minDist = math.huge

    for gun, _ in pairs(droppedGuns) do
        if gun and gun.Parent then
            local pos = gun:IsA("Model") and gun:GetPivot().Position or gun.Position
            local dist = (pos - root.Position).Magnitude
            if dist < minDist then
                nearestGun = gun
                minDist = dist
            end
        end
    end

    if nearestGun then
        -- Teleport gun to player and trigger touch
        nearestGun:PivotTo(root.CFrame * CFrame.new(0, 2, 3))
        task.wait(0.1)
        if nearestGun:FindFirstChild("TouchInterest") or nearestGun:FindFirstChildWhichIsA("TouchTransmitter") then
            firetouchinterest(root, nearestGun, 0)
            task.wait()
            firetouchinterest(root, nearestGun, 1)
        end
        -- Remove from tracking so ESP disappears
        droppedGuns[nearestGun] = nil
        Notify("Grab Gun", "Grabbed gun", "Success", nil, 2)
    else
        Notify("Grab Gun", "No gun found nearby", "Error", nil, 2)
    end
end

-- ============================================================
--  IMPROVED GUN DROP DETECTION
-- ============================================================

-- Gun drop detection
local function onGunDrop(obj)
    if obj.Name == "GunDrop" then
        droppedGuns[obj] = true
    end
end
for _, obj in ipairs(workspace:GetDescendants()) do
    onGunDrop(obj)
end
workspace.DescendantAdded:Connect(onGunDrop)
workspace.DescendantRemoving:Connect(function(obj)
    if droppedGuns[obj] then droppedGuns[obj] = nil end
end)

-- ============================================================
--  MAIN LOOP (now only for movement and gun ESP)
-- ============================================================
task.spawn(function()
    while true do
        pcall(function()
            updateMovement()
            local myRole = getMyRole()
            for gun, _ in pairs(droppedGuns) do
                if gun and gun.Parent then
                    if _G.AutoGrabEnabled and myRole ~= "Murderer" and myRole ~= "Sheriff" then
                        local char = LocalPlayer.Character
                        local root = char and char:FindFirstChild("HumanoidRootPart")
                        if root then
                            gun:PivotTo(root.CFrame)
                            if gun:FindFirstChild("TouchInterest", true) or gun:FindFirstChildWhichIsA("TouchTransmitter", true) then
                                firetouchinterest(root, gun, 0)
                                task.wait()
                                firetouchinterest(root, gun, 1)
                            end
                        end
                    end
                    if _G.GunEspEnabled then
                        local highlight = gun:FindFirstChild("GunDropHighlight") or Instance.new("Highlight", gun)
                        highlight.Name = "GunDropHighlight"
                        highlight.FillColor = _G.GunFill or Color3.fromRGB(255, 255, 0)
                        highlight.FillTransparency = _G.GunFillTrans or 0.5
                        highlight.OutlineColor = _G.GunOutline or Color3.fromRGB(255, 255, 255)
                        highlight.OutlineTransparency = _G.GunOutlineTrans or 0.3
                    else
                        local highlight = gun:FindFirstChild("GunDropHighlight")
                        if highlight then highlight:Destroy() end
                    end
                end
            end
        end)
        task.wait(0.1)
    end
end)

-- Silent Aim
local function createSilentAimMobileButton()
    if _G.SilentAimMobileBtnCreated then return end
    _G.SilentAimMobileBtnCreated = true

    local gui = Instance.new("ScreenGui")
    gui.Name = "SilentAimStandalone"
    gui.Parent = LocalPlayer.PlayerGui
    gui.ResetOnSpawn = false

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromOffset(_G.SilentAimSize or 85, _G.SilentAimSize or 85)
    btn.Position = UDim2.new(0.5, 0, 0.5, 0)
    btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.BackgroundColor3 = Color3.fromRGB(0, 105, 148)
    btn.BackgroundTransparency = 0.75
    btn.Text = ""
    btn.TextTransparency = 1
    btn.Parent = gui

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.2, 0)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.LineJoinMode = Enum.LineJoinMode.Round

    local spin = Instance.new("Frame", btn)
    spin.Size = UDim2.fromScale(0.6, 0.6)
    spin.Position = UDim2.fromScale(0.5, 0.4)
    spin.AnchorPoint = Vector2.new(0.5, 0.5)
    spin.BackgroundTransparency = 1
    spin.ZIndex = 2

    local function makeLine(name, size, pos)
        local line = Instance.new("Frame", spin)
        line.Name = name
        line.Size = size
        line.Position = pos
        line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        line.BackgroundTransparency = 0
        line.BorderSizePixel = 0
        local c = Instance.new("UICorner", line)
        c.CornerRadius = UDim.new(1, 0)
        return line
    end
    makeLine("Left", UDim2.fromScale(0.3, 0.04), UDim2.fromScale(0, 0.48))
    makeLine("Right", UDim2.fromScale(0.3, 0.04), UDim2.fromScale(0.7, 0.48))
    makeLine("Top", UDim2.fromScale(0.04, 0.3), UDim2.fromScale(0.48, 0))
    makeLine("Bottom", UDim2.fromScale(0.04, 0.3), UDim2.fromScale(0.48, 0.7))

    TweenService:Create(spin, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, math.huge, false), { Rotation = 360 }):Play()

    local label = Instance.new("TextLabel", btn)
    label.Size = UDim2.new(1, 0, 0.3, 0)
    label.Position = UDim2.new(0, 0, 0.7, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.Text = "SHOOT"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.ZIndex = 3

    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    btn.InputBegan:Connect(function(input)
        if _G.LockMobileButtons then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = btn.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    btn.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    btn.MouseButton1Click:Connect(function()
        equipToolAndFire({"Gun", "Revolver", "Pistol"}, silentAimShoot)
    end)
end

local function destroySilentAimMobileButton()
    if _G.SilentAimMobileBtnCreated then
        local gui = LocalPlayer.PlayerGui:FindFirstChild("SilentAimStandalone")
        if gui then gui:Destroy() end
        _G.SilentAimMobileBtnCreated = false
    end
end

-- Knife
local function createKnifeMobileButton()
    if _G.KnifeMobileBtnCreated then return end
    _G.KnifeMobileBtnCreated = true

    local gui = Instance.new("ScreenGui")
    gui.Name = "KnifeMobileStandalone"
    gui.Parent = LocalPlayer.PlayerGui
    gui.ResetOnSpawn = false

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromOffset(_G.KnifeSize or 85, _G.KnifeSize or 85)
    btn.Position = UDim2.new(0.5, 0, 0.5, 100)
    btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.BackgroundTransparency = 0.75
    btn.Text = ""
    btn.TextTransparency = 1
    btn.Parent = gui

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.2, 0)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.LineJoinMode = Enum.LineJoinMode.Round

    local knife = Instance.new("TextLabel", btn)
    knife.Size = UDim2.new(1, 0, 0.5, 0)
    knife.Position = UDim2.new(0, 0, 0.1, 0)
    knife.BackgroundTransparency = 1
    knife.Font = Enum.Font.GothamBold
    knife.Text = "🔪"
    knife.TextColor3 = Color3.fromRGB(255, 255, 255)
    knife.TextScaled = true
    knife.ZIndex = 3
    TweenService:Create(knife, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, math.huge, false), { Rotation = 360 }):Play()

    local label = Instance.new("TextLabel", btn)
    label.Size = UDim2.new(1, 0, 0.3, 0)
    label.Position = UDim2.new(0, 0, 0.7, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.Text = "THROW"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.ZIndex = 3

    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    btn.InputBegan:Connect(function(input)
        if _G.LockMobileButtons then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = btn.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    btn.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    btn.MouseButton1Click:Connect(function()
        equipToolAndFire({"Knife"}, knifeSilentAim)
    end)
end

local function destroyKnifeMobileButton()
    if _G.KnifeMobileBtnCreated then
        local gui = LocalPlayer.PlayerGui:FindFirstChild("KnifeMobileStandalone")
        if gui then gui:Destroy() end
        _G.KnifeMobileBtnCreated = false
    end
end

-- Grab Gun
local function createGrabGunMobileButton()
    if _G.GrabGunMobileBtnCreated then return end
    _G.GrabGunMobileBtnCreated = true
    local gui = Instance.new("ScreenGui"); gui.Name = "GrabGunMobileStandalone"; gui.Parent = LocalPlayer.PlayerGui; gui.ResetOnSpawn = false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromOffset(_G.GrabGunSize or 85, _G.GrabGunSize or 85)
    btn.Position = UDim2.new(1, -110, 0.5, 80); btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.Text =""
    btn.BackgroundColor3 = Color3.fromRGB(35,35,35); btn.BackgroundTransparency = 0.75
    btn.Parent = gui
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.2, 0)
    local stroke = Instance.new("UIStroke", btn); stroke.Color = Color3.fromRGB(255,255,255); stroke.Thickness = 2; stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; stroke.LineJoinMode = Enum.LineJoinMode.Round
    local text = Instance.new("TextLabel", btn); text.Size = UDim2.new(1,0,1,0); text.BackgroundTransparency = 1; text.Font = Enum.Font.GothamBold; text.Text = "GRAB GUN"; text.TextColor3 = Color3.new(1,1,1); text.TextScaled = true; text.ZIndex = 3
    makeDraggable(btn)
    btn.MouseButton1Click:Connect(grabGun)
end
local function destroyGrabGunMobileButton()
    if _G.GrabGunMobileBtnCreated then local gui = LocalPlayer.PlayerGui:FindFirstChild("GrabGunMobileStandalone"); if gui then gui:Destroy() end; _G.GrabGunMobileBtnCreated = false end
end

-- Fling Murderer
local function createFlingMurdererButton()
    if _G.FlingMurdererBtnCreated then return end
    _G.FlingMurdererBtnCreated = true
    local gui = Instance.new("ScreenGui"); gui.Name = "FlingMurdererStandalone"; gui.Parent = LocalPlayer.PlayerGui; gui.ResetOnSpawn = false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromOffset(_G.FlingMurdererSize or 85, _G.FlingMurdererSize or 85)
    btn.Position = UDim2.new(0.5, 0, 0.5, 100); btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.BackgroundColor3 = Color3.fromRGB(200,0,0); btn.BackgroundTransparency = 0.75
    btn.Text = ""; btn.Parent = gui
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.2, 0)
    local stroke = Instance.new("UIStroke", btn); stroke.Color = Color3.fromRGB(255,255,255); stroke.Thickness = 2; stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; stroke.LineJoinMode = Enum.LineJoinMode.Round
    local label = Instance.new("TextLabel", btn); label.Size = UDim2.new(1,0,1,0); label.BackgroundTransparency = 1; label.Font = Enum.Font.GothamBold; label.Text = "FLING M"; label.TextColor3 = Color3.new(1,1,1); label.TextScaled = true; label.ZIndex = 3
    makeDraggable(btn)
    btn.MouseButton1Click:Connect(function()
        local murderer = findPlayerByRole("Murderer")
        if murderer then task.spawn(function() flingPlayer(murderer) end) else Notify("Fling", "No murderer found!", "Error", nil, 2) end
    end)
end
local function destroyFlingMurdererButton()
    if _G.FlingMurdererBtnCreated then local gui = LocalPlayer.PlayerGui:FindFirstChild("FlingMurdererStandalone"); if gui then gui:Destroy() end; _G.FlingMurdererBtnCreated = false end
end

-- Fling Sheriff
local function createFlingSheriffButton()
    if _G.FlingSheriffBtnCreated then return end
    _G.FlingSheriffBtnCreated = true
    local gui = Instance.new("ScreenGui"); gui.Name = "FlingSheriffStandalone"; gui.Parent = LocalPlayer.PlayerGui; gui.ResetOnSpawn = false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromOffset(_G.FlingSheriffSize or 85, _G.FlingSheriffSize or 85)
    btn.Position = UDim2.new(0.5, 0, 0.5, -100); btn.AnchorPoint = Vector2.new(0.5, 0.5)
    btn.BackgroundColor3 = Color3.fromRGB(0,0,200); btn.BackgroundTransparency = 0.75
    btn.Text = ""; btn.Parent = gui
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0.2, 0)
    local stroke = Instance.new("UIStroke", btn); stroke.Color = Color3.fromRGB(255,255,255); stroke.Thickness = 2; stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; stroke.LineJoinMode = Enum.LineJoinMode.Round
    local label = Instance.new("TextLabel", btn); label.Size = UDim2.new(1,0,1,0); label.BackgroundTransparency = 1; label.Font = Enum.Font.GothamBold; label.Text = "FLING S"; label.TextColor3 = Color3.new(1,1,1); label.TextScaled = true; label.ZIndex = 3
    makeDraggable(btn)
    btn.MouseButton1Click:Connect(function()
        local sheriff = findPlayerByRole("Sheriff")
        if sheriff then task.spawn(function() flingPlayer(sheriff) end) else Notify("Fling", "No sheriff found!", "Error", nil, 2) end
    end)
end -- <-- This end was missing!

local function destroyFlingSheriffButton()
    if _G.FlingSheriffBtnCreated then local gui = LocalPlayer.PlayerGui:FindFirstChild("FlingSheriffStandalone"); if gui then gui:Destroy() end; _G.FlingSheriffBtnCreated = false end
end

local function addSection(tab, name, position)
    return tab:AddSection({ Name = name, Position = position or "left" })
end

-- ====== LEGIT TAB ======
local legitTab = window:AddTab({ Icon = "house", Name = "Main" })

local protectionSec = addSection(legitTab, "Protection", "left")
protectionSec:AddLabel("Anti-Fling (Enhanced)"):AddToggle({
    Default = false, Flag = "AntiFling",
    Callback = function(v) toggleAntiFling(v); saveSettings() end
})
protectionSec:AddLabel("Anti-Trap"):AddToggle({
    Default = false, Flag = "AntiTrap",
    Callback = function(v) toggleAntiTrap(v); saveSettings() end
})

local whitelistSec = addSection(legitTab, "Whitelist", "left")
whitelistSec:AddLabel("Enable"):AddToggle({
    Default = false, Flag = "WhitelistOn",
    Callback = function(v) _G.WhitelistEnabled = v; saveSettings() end
})
whitelistSec:AddLabel("Friends"):AddToggle({
    Default = false, Flag = "WhitelistFriends",
    Callback = function(v) _G.WhitelistFriends = v; saveSettings() end
})
whitelistSec:AddLabel("Players"):AddDropdown({
    Default = {}, Values = getPlayerNames(), Multi = true, Flag = "WhitelistPlayers",
    Callback = function(v) _G.WhitelistPlayers = v; saveSettings() end
})

local antiAfkSec = addSection(legitTab, "Anti-AFK", "left")
antiAfkSec:AddLabel("Anti AFK"):AddToggle({
    Default = true, Flag = "AntiAfk",
    Callback = function(v) _G.AntiAfkEnabled = v; toggleAntiAfk(v); saveSettings() end
})

local notifySec = addSection(legitTab, "Notifications", "right")
notifySec:AddLabel("Show role on round start"):AddToggle({
    Default = false, Flag = "SayRole",
    Callback = function(v) _G.SayRoleEnabled = v; saveSettings() end
})
notifySec:AddLabel("Round Timer (MM2)"):AddToggle({
    Default = false, Flag = "RoundTimer",
    Callback = function(v) toggleRoundTimer(v); saveSettings() end
})

local serverSec = addSection(legitTab, "Server", "right")
serverSec:AddButton({
    Icon = "arrow-rotate-right", Name = "Rejoin Server",
    Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end
})
serverSec:AddButton({
    Icon = "arrow-right", Name = "Server Hop (Random)",
    Callback = function() hopRandom() end
})
serverSec:AddButton({
    Icon = "users", Name = "Join Small Server",
    Callback = function() joinSmallest() end
})

-- ====== VISUAL TAB ======
local visTab = window:AddTab({ Icon = "eye", Name = "Visual" })

local espSec = addSection(visTab, "ESP Options", "left")
espSec:AddLabel("Highlight (Glow)"):AddToggle({
    Default = false, Flag = "Highlight",
    Callback = function(v) _G.HighlightEnabled = v; saveSettings() end
})
espSec:AddLabel("Box ESP"):AddToggle({
    Default = false, Flag = "BoxESP",
    Callback = function(v) _G.BoxESP = v; saveSettings() end
})
espSec:AddLabel("Tracer ESP"):AddToggle({
    Default = false, Flag = "TracerESP",
    Callback = function(v) _G.TracerESP = v; saveSettings() end
})
espSec:AddLabel("Name ESP"):AddToggle({
    Default = false, Flag = "NamesESP",
    Callback = function(v) _G.NamesESP = v; saveSettings() end
})
espSec:AddLabel("Distance ESP"):AddToggle({
    Default = false, Flag = "DistanceESP",
    Callback = function(v) _G.DistanceESP = v; saveSettings() end
})
espSec:AddLabel("Gun Drop ESP"):AddToggle({
    Default = false, Flag = "GunESP",
    Callback = function(v) _G.GunEspEnabled = v; saveSettings() end
})
espSec:AddLabel("Rainbow ESP"):AddToggle({
    Default = false, Flag = "RainbowESP",
    Callback = function(v) _G.RainbowESP = v; saveSettings() end
})

local camSec = addSection(visTab, "Camera", "right")
camSec:AddLabel("FOV"):AddSlider({
    Min = 30, Max = 120, Default = 70, Rounding = 0, Flag = "FOV",
    Callback = function(v) _G.FOVValue = v; CurrentCamera.FieldOfView = v; saveSettings() end
})
camSec:AddLabel("X-Ray"):AddToggle({
    Default = false, Flag = "Xray",
    Callback = function(v) toggleXray(v); saveSettings() end
})

local visModSec = addSection(visTab, "Visual Mods", "right")
visModSec:AddLabel("Korblox Leg"):AddToggle({
    Default = false, Flag = "Korblox",
    Callback = function(v) toggleKorblox(v); saveSettings() end
})
visModSec:AddLabel("Headless"):AddToggle({
    Default = false, Flag = "Headless",
    Callback = function(v) toggleHeadless(v); saveSettings() end
})

local skySec = addSection(visTab, "Sky Presets", "left")
local activeSkyToggle = nil
local function clearSky()
    for _, child in ipairs(Lighting:GetChildren()) do if child:IsA("Sky") then child:Destroy() end end
end
local function applySky(asset)
    clearSky()
    local sky = Instance.new("Sky")
    sky.Parent = Lighting
    sky.CelestialBodiesShown = false
    sky.SkyboxBk = asset; sky.SkyboxDn = asset; sky.SkyboxFt = asset; sky.SkyboxLf = asset; sky.SkyboxRt = asset; sky.SkyboxUp = asset
end
local function createSkyToggle(name, asset)
    skySec:AddLabel(name):AddToggle({
        Default = false, Flag = name .. "Sky",
        Callback = function(v)
            if v then
                if activeSkyToggle and activeSkyToggle ~= NeverLose.Flags[name .. "Sky"] then
                    activeSkyToggle:SetValue(false)
                end
                activeSkyToggle = NeverLose.Flags[name .. "Sky"]
                applySky(asset)
                Notify("Sky", name .. " applied", "Success", nil, 2)
            else
                if activeSkyToggle == NeverLose.Flags[name .. "Sky"] then
                    clearSky()
                    Notify("Sky", "Sky restored to default", "Info", nil, 2)
                end
            end
        end
    })
end
createSkyToggle("Full Night", "http://www.roblox.com/asset/?id=17055447520")
createSkyToggle("Black Hole", "http://www.roblox.com/asset/?id=17108753749")
createSkyToggle("Neptune", "http://www.roblox.com/asset/?id=17108745046")
createSkyToggle("Lofy Sky", "http://www.roblox.com/asset/?id=17108732394")
createSkyToggle("Aurora Boreal", "http://www.roblox.com/asset/?id=17108721907")


local envSec = addSection(visTab, "Environment Controls", "right")
local originalClockTime = Lighting.ClockTime
local originalFogStart = Lighting.FogStart
local originalFogEnd = Lighting.FogEnd
local originalFogColor = Lighting.FogColor
local fogEnabled = false
local fogDensity = 50
local fogColor = Color3.fromRGB(255, 255, 255)

local function updateFog()
    if fogEnabled then
        Lighting.FogStart = 0
        Lighting.FogEnd = 1000 - fogDensity * 10
        Lighting.FogColor = fogColor
    else
        Lighting.FogStart = originalFogStart
        Lighting.FogEnd = originalFogEnd
        Lighting.FogColor = originalFogColor
    end
end

envSec:AddLabel("Time of Day"):AddSlider({
    Min = 0, Max = 24, Default = Lighting.ClockTime, Rounding = 0.5, Flag = "TimeOfDay",
    Callback = function(v) Lighting.ClockTime = v end
})
envSec:AddLabel("Enable Fog"):AddToggle({
    Default = false, Flag = "Fog",
    Callback = function(v) fogEnabled = v; updateFog(); saveSettings() end
})
envSec:AddLabel("Fog Density"):AddSlider({
    Min = 0, Max = 100, Default = 50, Rounding = 0, Flag = "FogDensity",
    Callback = function(v) if fogEnabled then fogDensity = v; updateFog() end; saveSettings() end
})
envSec:AddLabel("Fog Color"):AddDropdown({
    Default = "White", Values = { "White", "Gray", "Black", "Blue", "Red", "Green", "Purple", "Orange" }, Flag = "FogColor",
    Callback = function(v)
        local colors = { White = Color3.fromRGB(255,255,255), Gray = Color3.fromRGB(128,128,128), Black = Color3.fromRGB(0,0,0),
                        Blue = Color3.fromRGB(100,150,255), Red = Color3.fromRGB(255,80,80), Green = Color3.fromRGB(80,255,80),
                        Purple = Color3.fromRGB(200,100,255), Orange = Color3.fromRGB(255,180,50) }
        fogColor = colors[v] or Color3.fromRGB(255,255,255)
        if fogEnabled then updateFog() end
        saveSettings()
    end
})
envSec:AddButton({
    Icon = "rotate", Name = "Reset Environment",
    Callback = function()
        Lighting.ClockTime = originalClockTime
        Lighting.FogStart = originalFogStart
        Lighting.FogEnd = originalFogEnd
        Lighting.FogColor = originalFogColor
        fogColor = Color3.fromRGB(255,255,255)
        if NeverLose.Flags["TimeOfDay"] then NeverLose.Flags["TimeOfDay"]:SetValue(originalClockTime) end
        if NeverLose.Flags["Fog"] then NeverLose.Flags["Fog"]:SetValue(false) end
        if NeverLose.Flags["FogDensity"] then NeverLose.Flags["FogDensity"]:SetValue(50) end
        if NeverLose.Flags["FogColor"] then NeverLose.Flags["FogColor"]:SetValue("White") end
        Notify("Environment", "Reset to defaults", "Info", nil, 2)
    end
})

-- ====== FLING TAB ======
local flingTab = window:AddTab({ Icon = "person", Name = "Fling" })
local flingSec = addSection(flingTab, "Fling Player", "left")
flingSec:AddLabel("Target"):AddDropdown({
    Default = "", Values = getPlayerNames(), Flag = "FlingTarget",
    Callback = function(v) _G.FlingTarget = v end
})
flingSec:AddButton({
    Icon = "arrow-rotate-right", Name = "Refresh Players",
    Callback = function()
        local names = getPlayerNames()
        if NeverLose.Flags["FlingTarget"] then
            NeverLose.Flags["FlingTarget"]:SetValues(names)
            NeverLose.Flags["FlingTarget"]:SetValue(names[1] or "")
        end
        Notify("Refresh", "Player list updated", "Info", nil, 2)
    end
})
flingSec:AddButton({
    Icon = "rocket", Name = "Fling Selected (Enhanced)",
    Callback = function()
        local name = _G.FlingTarget
        if not name then Notify("Error", "Select a player", "Error", nil, 2) return end
        local player = Players:FindFirstChild(name)
        if not player then return end
        if isWhitelisted(player) then Notify("Error", "Whitelisted", "Error", nil, 2) return end
        task.spawn(function() flingPlayer(player) end)
    end
})
flingSec:AddButton({
    Icon = "skull", Name = "Fling Murderer",
    Callback = function() flingByRole("Murderer") end
})
flingSec:AddButton({
    Icon = "badge", Name = "Fling Sheriff",
    Callback = function() flingByRole("Sheriff") end
})

local extremeFlingSec = addSection(flingTab, "Touch Fling", "right")
extremeFlingSec:AddLabel("Touch Fling"):AddToggle({
    Default = false, Flag = "ExtremeFling",
    Callback = function(v) _G.ExtremeFlingEnabled = v; toggleExtremeFling(v); saveSettings() end
})

local mobileFlingSec = addSection(flingTab, "Mobile Fling Buttons", "right")
mobileFlingSec:AddLabel("Fling Murderer (Mobile)"):AddToggle({
    Default = false, Flag = "FlingMurdererMobile",
    Callback = function(v)
        _G.FlingMurdererMobile = v
        if v then createFlingMurdererButton() else destroyFlingMurdererButton() end
        saveSettings()
    end
})
mobileFlingSec:AddLabel("Fling Sheriff (Mobile)"):AddToggle({
    Default = false, Flag = "FlingSheriffMobile",
    Callback = function(v)
        _G.FlingSheriffMobile = v
        if v then createFlingSheriffButton() else destroyFlingSheriffButton() end
        saveSettings()
    end
})

-- ====== MOVEMENT TAB ======
local moveTab = window:AddTab({ Icon = "shoe-left", Name = "Movement" })

local moveSec = addSection(moveTab, "Movement", "left")
moveSec:AddLabel("Walk Speed"):AddSlider({
    Min = 16, Max = 200, Default = 16, Rounding = 0, Flag = "WalkSpeed",
    Callback = function(v) _G.WalkSpeed = v; updateMovement(); saveSettings() end
})
moveSec:AddLabel("Jump Power"):AddSlider({
    Min = 50, Max = 300, Default = 50, Rounding = 0, Flag = "JumpPower",
    Callback = function(v) _G.JumpPower = v; updateMovement(); saveSettings() end
})
moveSec:AddLabel("Speed Glitch"):AddToggle({
    Default = false, Flag = "SpeedGlitch",
    Callback = function(v)
        _G.SpeedGlitchEnabled = v
        if v then
            startSpeedGlitchUpdater()
        else
            if speedGlitchConnection then speedGlitchConnection:Disconnect() end
            -- Reset to normal speed
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = _G.WalkSpeed end
        end
        saveSettings()
    end
})
moveSec:AddLabel("Glitch Speed"):AddSlider({
    Min = 16, Max = 300, Default = 35, Rounding = 0, Flag = "GlitchSpeed",
    Callback = function(v) _G.GlitchSpeed = v; saveSettings() end
})

local flySec = addSection(moveTab, "Fly & Noclip", "left")
flySec:AddLabel("Fly"):AddToggle({
    Default = false, Flag = "Fly",
    Callback = function(v) toggleFly(v); saveSettings() end
})
flySec:AddLabel("Fly Speed"):AddSlider({
    Min = 10, Max = 200, Default = 50, Rounding = 0, Flag = "FlySpeed",
    Callback = function(v) _G.FlySpeed = v; saveSettings() end
})
flySec:AddLabel("Noclip"):AddToggle({
    Default = false, Flag = "Noclip",
    Callback = function(v) toggleNoclip(v); saveSettings() end
})

local easyGlitchSec = addSection(moveTab, "Easy Glitching", "right")
easyGlitchSec:AddLabel("Easy Glitching"):AddToggle({
    Default = false, Flag = "EasyGlitch",
    Callback = function(v) _G.EasyGlitch = v; toggleEasyGlitch(v); saveSettings() end
})

local spinSec = addSection(moveTab, "Player Spin", "right")
spinSec:AddLabel("Enable Spin"):AddToggle({
    Default = false, Flag = "PlayerSpin",
    Callback = function(v) _G.PlayerSpinEnabled = v; togglePlayerSpin(v); saveSettings() end
})
spinSec:AddLabel("Spin Speed"):AddSlider({
    Min = 1, Max = 500, Default = 20, Rounding = 0, Flag = "SpinSpeed",
    Callback = function(v) _G.PlayerSpinSpeed = v; saveSettings() end
})

local drSec = addSection(moveTab, "Dropkick & Run", "right")
drSec:AddLabel("Dropkick (Enable)"):AddToggle({
    Default = false, Flag = "DropkickEnable",
    Callback = function(v) if _G.Dropkick then _G.Dropkick.setDropkickEnabled(v) end; saveSettings() end
})
drSec:AddLabel("Run (Enable)"):AddToggle({
    Default = false, Flag = "RunEnable",
    Callback = function(v) if _G.Dropkick then _G.Dropkick.setRunEnabled(v) end; saveSettings() end
})
drSec:AddLabel("Dropkick Power"):AddSlider({
    Min = 0, Max = 1000, Default = 50, Rounding = 0, Flag = "DropkickPower",
    Callback = function(v) if _G.Dropkick then _G.Dropkick.setPower(v) end end
})
drSec:AddButton({
    Icon = "play", Name = "Activate Dropkick (K)",
    Callback = function() if _G.Dropkick then _G.Dropkick.activate() end end
})
drSec:AddLabel("Run Speed %"):AddSlider({
    Min = 0, Max = 500, Default = 20, Rounding = 0, Flag = "RunSpeed",
    Callback = function(v)
        if _G.Dropkick then
            _G.Dropkick.setRunSpeed(v)
            if _G.Dropkick.isRunActive() then
                local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = math.max(0.5, 16 * (v / 100)) end
            end
        end
    end
})
drSec:AddButton({
    Icon = "play", Name = "Toggle Run (J)",
    Callback = function() if _G.Dropkick then _G.Dropkick.toggleRun() end end
})

-- ====== COMBAT TAB ======
local combatTab = window:AddTab({ Icon = "crosshairs", Name = "Combat" })

-- Silent Aim & Aimbot
local saSec = addSection(combatTab, "Sheriff section", "left")
saSec:AddLabel("Silent Aim (PC)"):AddToggle({
    Default = false, Flag = "SilentAimPC",
    Callback = function(v) _G.SilentAimEnabled = v; setupSilentAimKeybind(); saveSettings() end
})
saSec:AddButton({
    Icon = "bullet", Name = "Shoot Murderer (Silent Aim)",
    Callback = function() silentAimShoot() end
})
saSec:AddLabel("Prediction Offset"):AddSlider({
    Min = 0, Max = 10, Default = 2.8, Rounding = 0.1, Flag = "SilentOffset",
    Callback = function(v) _G.SilentAimOffset = v; saveSettings() end
})
saSec:AddLabel("Ping Multiplier"):AddSlider({
    Min = 0.5, Max = 3, Default = 1, Rounding = 0.1, Flag = "PingMult",
    Callback = function(v) _G.SilentAimPingMult = v; saveSettings() end
})
saSec:AddLabel("Silent Aim Key"):AddKeybind({
    Default = "E", Flag = "SilentKey",
    Callback = function(v) _G.SilentAimKey = v; setupSilentAimKeybind(); saveSettings() end
})
saSec:AddLabel("Silent Aim (Mobile)"):AddToggle({
    Default = false, Flag = "SilentMobile",
    Callback = function(v)
        _G.SilentAimMobile = v
        if v then createSilentAimMobileButton() else destroySilentAimMobileButton() end
        saveSettings()
    end
})
saSec:AddLabel("Aimbot (Sheriff)"):AddToggle({
    Default = false, Flag = "Aimbot",
    Callback = function(v) toggleAimbot(v); saveSettings() end
})

-- Knife & Kill All
local knifeSec = addSection(combatTab, "Murderer section", "right")
knifeSec:AddButton({
    Icon = "sword", Name = "Kill All (Instant)",
    Callback = killEveryone
})

knifeSec:AddButton({
    Icon = "users", Name = "Hold Everyone Hostage",
    Callback = holdEveryoneHostage
})
knifeSec:AddLabel("Knife Aura"):AddToggle({
    Default = false, Flag = "KnifeAura",
    Callback = function(v) toggleKnifeAura(v); saveSettings() end
})
knifeSec:AddLabel("Aura Range"):AddSlider({
    Min = 5, Max = 100, Default = 20, Rounding = 0, Flag = "KnifeRange",
    Callback = function(v) _G.KnifeAuraRange = v; saveSettings() end
})
knifeSec:AddLabel("Knife Silent Aim (PC)"):AddToggle({
    Default = false, Flag = "KnifeSilentPC",
    Callback = function(v) _G.KnifeSilentAimEnabled = v; saveSettings() end
})
knifeSec:AddLabel("Knife Silent Aim Key"):AddKeybind({
    Default = "R", Flag = "KnifeSilentKey",
    Callback = function(v) _G.KnifeSilentAimKey = v; saveSettings() end
})
knifeSec:AddLabel("Knife Silent Aim (Mobile)"):AddToggle({
    Default = false, Flag = "KnifeMobile",
    Callback = function(v)
        _G.KnifeMobileEnabled = v
        if v then createKnifeMobileButton() else destroyKnifeMobileButton() end
        saveSettings()
    end
})
knifeSec:AddButton({
    Icon = "plus", Name = "Create Fake Knife",
    Callback = function() createFakeKnife() end
})

-- Trap, Grab Gun, Godmode
local miscCombatSec = addSection(combatTab, "Other Combat", "right")
miscCombatSec:AddButton({
    Icon = "shield", Name = "Godmode",
    Callback = function() activateGodmode() end
})
miscCombatSec:AddLabel("Trap Target"):AddDropdown({
    Default = "", Values = getPlayerNames(), Flag = "TrapTarget",
    Callback = function(v) _G.TrapTarget = v end
})
miscCombatSec:AddButton({
    Icon = "trap", Name = "Trap Selected",
    Callback = function()
        local name = _G.TrapTarget
        if name then
            local player = Players:FindFirstChild(name)
            if player then trapPlayer(player) end
        end
    end
})
miscCombatSec:AddLabel("Grab Gun (Mobile)"):AddToggle({
    Default = false, Flag = "GrabGunMobile",
    Callback = function(v)
        _G.GrabGunMobile = v
        if v then createGrabGunMobileButton() else destroyGrabGunMobileButton() end
        saveSettings()
    end
})
miscCombatSec:AddButton({
    Icon = "hand", Name = "Grab Gun Now",
    Callback = function() grabGun() end
})

-- ====== MISC TAB ======
local miscTab = window:AddTab({ Icon = "sword", Name = "Misc" })

-- Utilities (moved from old Player tab)
local utilSec = addSection(miscTab, "Utilities", "left")
utilSec:AddLabel("Enable Spectate"):AddToggle({
    Default = false, Flag = "Spectate",
    Callback = function(v)
        spectateEnabled = v
        if not v then CurrentCamera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") end
        saveSettings()
    end
})
utilSec:AddLabel("Spectate Player"):AddDropdown({
    Default = "", Values = getPlayerNames(), Flag = "SpectateTarget",
    Callback = function(v) spectatePlayer(v) end
})
utilSec:AddButton({
    Icon = "arrow-rotate-right", Name = "Refresh Spectate List",
    Callback = function()
        local names = getPlayerNames()
        if NeverLose.Flags["SpectateTarget"] then
            NeverLose.Flags["SpectateTarget"]:SetValues(names)
            NeverLose.Flags["SpectateTarget"]:SetValue(names[1] or "")
        end
        Notify("Refresh", "Player list updated", "Info", nil, 2)
    end
})
utilSec:AddLabel("CTRL+Click Teleport (PC)"):AddToggle({
    Default = false, Flag = "CtrlTeleport",
    Callback = function(v) ctrlClickTeleportEnabled = v; saveSettings() end
})
utilSec:AddButton({
    Icon = "message", Name = "Send Sheriff & Murderer names",
    Callback = function() sendRoleNames() end
})
utilSec:AddButton({
    Icon = "bed", Name = "Lay On Back",
    Callback = function() layOnBack() end
})
utilSec:AddButton({
    Icon = "chair", Name = "Sit Down",
    Callback = function()
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.Sit = true end
    end
})
utilSec:AddButton({
    Icon = "map", Name = "Teleport to Map Spawn",
    Callback = function()
local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local root = char.HumanoidRootPart
        local spawns = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            if (obj.Name == "Spawn" or obj.Name == "PlayerSpawn") and obj:IsA("BasePart") then
                table.insert(spawns, obj)
            end
        end
        if #spawns > 0 then
            root.CFrame = spawns[1].CFrame * CFrame.new(0, 2.5, 0)
        else
            Notify("Teleport", "No spawn found", "Error", nil, 2)
        end
end
})
utilSec:AddButton({
    Icon = "building", Name = "Teleport to Lobby",
    Callback = function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local root = char.HumanoidRootPart

        -- First, try to find regular Lobby
        local spawnsFolder = workspace:FindFirstChild("Lobby")
        if spawnsFolder then
            spawnsFolder = spawnsFolder:FindFirstChild("Spawns")
        end

        -- If regular Lobby not found, search for SummerLobby
        if not spawnsFolder then
            local summerLobby = workspace:FindFirstChild("SummerLobby")
            if summerLobby then
                spawnsFolder = summerLobby:FindFirstChild("Spawns")
            end
        end

        if not spawnsFolder then
            Notify("Teleport", "Lobby or SummerLobby not found", "Error", nil, 2)
            return
        end

        local spawnParts = spawnsFolder:GetChildren()
        local targetPart = nil
        for _, obj in ipairs(spawnParts) do
            if obj:IsA("BasePart") then
                targetPart = obj
                break
            end
        end

        if targetPart then
            root.CFrame = targetPart.CFrame * CFrame.new(0, 2.5, 0)
        else
            Notify("Teleport", "No spawn part found", "Error", nil, 2)
        end
    end
})

utilSec:AddLabel("Target Player"):AddDropdown({
    Default = "", Values = getPlayerNames(), Flag = "TeleportTarget",
    Callback = function(v) _G.TeleportTarget = v end
})
utilSec:AddButton({
    Icon = "arrow-rotate-right", Name = "Refresh Players",
    Callback = function()
        local names = getPlayerNames()
        if NeverLose.Flags["TeleportTarget"] then
            NeverLose.Flags["TeleportTarget"]:SetValues(names)
            NeverLose.Flags["TeleportTarget"]:SetValue(names[1] or "")
        end
        Notify("Refresh", "Player list updated", "Info", nil, 2)
    end
})
utilSec:AddButton({
    Icon = "user", Name = "Teleport to Player",
    Callback = function()
        local name = _G.TeleportTarget
        if not name then Notify("Teleport", "Select a player", "Error", nil, 2) return end
        local target = Players:FindFirstChild(name)
        if target and target.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 2.5, 0)
        end
    end
})
utilSec:AddButton({
    Icon = "skull", Name = "Teleport to Murderer",
    Callback = function()
        local m = findPlayerByRole("Murderer")
        if m and m.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = m.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
})
utilSec:AddButton({
    Icon = "badge", Name = "Teleport to Sheriff",
    Callback = function()
        local s = findPlayerByRole("Sheriff")
        if s and s.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = s.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
})

local autoGrabSec = addSection(miscTab, "Auto Grab Gun", "left")
autoGrabSec:AddLabel("Auto Grab Gun"):AddToggle({
    Default = false, Flag = "AutoGrab",
    Callback = function(v) _G.AutoGrabEnabled = v; saveSettings() end
})
autoGrabSec:AddLabel("Manual Grab Key"):AddKeybind({
    Default = "G", Flag = "GrabKey",
    Callback = function(v) _G.GrabKey = v; saveSettings() end
})

local bombSec = addSection(miscTab, "Bomb Jump", "left")
bombSec:AddLabel("Enable Bomb Jump"):AddToggle({
    Default = false, Flag = "BombJump",
    Callback = function(v) _G.BombJump.Enabled = v; saveSettings() end
})
bombSec:AddLabel("PC Keybind"):AddKeybind({
    Default = "B", Flag = "BombKey",
    Callback = function(v) _G.BombJump.PCKeybind = v; saveSettings() end
})
bombSec:AddLabel("Show Mobile Button"):AddToggle({
    Default = false, Flag = "BombMobile",
    Callback = function(v)
        _G.BombJump.MobileButton = v
        if v then
            if not draggableButtons["BombJump"] then
                createDraggableButton({
                    name = "BombJump",
                    text = "💣",
                    size = UDim2.fromOffset(55,55),
                    position = UDim2.new(0.12,0,0.12,0),
                    backgroundColor = Color3.fromRGB(200,100,0),
                    callback = function() bombJump() end
                })
            end
        end
        saveSettings()
    end
})

local emoteSec = addSection(miscTab, "Emotes & Animations", "right")
emoteSec:AddButton({ Icon = "chair", Name = "Sit", Callback = function() playEmote("sit") end })
emoteSec:AddButton({ Icon = "meditation", Name = "Zen", Callback = function() playEmote("zen") end })
emoteSec:AddButton({ Icon = "hand", Name = "Dab", Callback = function() playEmote("dab") end })
emoteSec:AddButton({ Icon = "dance", Name = "Floss", Callback = function() playEmote("floss") end })
emoteSec:AddButton({ Icon = "skull", Name = "Zombie", Callback = function() playEmote("zombie") end })
emoteSec:AddButton({ Icon = "user-minus", Name = "Headless", Callback = function() playEmote("headless") end })

local normalAnimSec = addSection(miscTab, "Normal Animations", "right")
local animations = {
    { name = "Astronaut", idle1 = "891621366", idle2 = "891633237", walk = "891667138", run = "891636393", jump = "891627522", climb = "891609353", fall = "891617961" },
    { name = "Bubbly", idle1 = "910004836", idle2 = "910009958", walk = "910034870", run = "910025107", jump = "910016857", climb = "", fall = "910001910", swimIdle = "910030921", swim = "910028158" },
    { name = "Cartoony", idle1 = "742637544", idle2 = "742638445", walk = "742640026", run = "742638842", jump = "742637942", climb = "742636889", fall = "742637151" },
    { name = "Elder", idle1 = "845397899", idle2 = "845400520", walk = "845403856", run = "845386501", jump = "845398858", climb = "845392038", fall = "845396048" },
    { name = "Knight", idle1 = "657595757", idle2 = "657568135", walk = "657552124", run = "657564596", jump = "658409194", climb = "658360781", fall = "657600338" },
    { name = "Levitation", idle1 = "616006778", idle2 = "616008087", walk = "616013216", run = "616010382", jump = "616008936", climb = "616003713", fall = "616005863" },
    { name = "Mage", idle1 = "707742142", idle2 = "707855907", walk = "707897309", run = "707861613", jump = "707853694", climb = "707826056", fall = "707829716" },
    { name = "Ninja", idle1 = "656117400", idle2 = "656118341", walk = "656121766", run = "656118852", jump = "656117878", climb = "656114359", fall = "656115606" },
    { name = "Pirate", idle1 = "750781874", idle2 = "750782770", walk = "750785693", run = "750783738", jump = "750782230", climb = "750779899", fall = "750780242" },
    { name = "Robot", idle1 = "616088211", idle2 = "616089559", walk = "616095330", run = "616091570", jump = "616090535", climb = "616086039", fall = "616087089" },
    { name = "Stylish", idle1 = "616136790", idle2 = "616138447", walk = "616146177", run = "616140816", jump = "616139451", climb = "616133594", fall = "616134815" },
    { name = "SuperHero", idle1 = "616111295", idle2 = "616113536", walk = "616122287", run = "616117076", jump = "616115533", climb = "616104706", fall = "616108001" },
    { name = "Toy", idle1 = "782841498", idle2 = "782845736", walk = "782843345", run = "782842708", jump = "782847020", climb = "782843869", fall = "782846423" },
    { name = "Vampire", idle1 = "1083445855", idle2 = "1083450166", walk = "1083473930", run = "1083462077", jump = "1083455352", climb = "1083439238", fall = "1083443587" },
    { name = "Werewolf", idle1 = "1083195517", idle2 = "1083214717", walk = "1083178339", run = "1083216690", jump = "1083218792", climb = "1083182000", fall = "1083189019" },
    { name = "Zombie", idle1 = "616158929", idle2 = "616160636", walk = "616168032", run = "616163682", jump = "616161997", climb = "616156119", fall = "616157476" },
}
for _, anim in ipairs(animations) do
    normalAnimSec:AddButton({
        Icon = "play",
        Name = anim.name,
        Callback = function()
            applyAnimation(
                "http://www.roblox.com/asset/?id=" .. anim.idle1,
                "http://www.roblox.com/asset/?id=" .. (anim.idle2 or anim.idle1),
                "http://www.roblox.com/asset/?id=" .. (anim.walk or ""),
                "http://www.roblox.com/asset/?id=" .. (anim.run or ""),
                "http://www.roblox.com/asset/?id=" .. (anim.jump or ""),
                "http://www.roblox.com/asset/?id=" .. (anim.climb or ""),
                "http://www.roblox.com/asset/?id=" .. (anim.fall or ""),
                "http://www.roblox.com/asset/?id=" .. (anim.swimIdle or ""),
                "http://www.roblox.com/asset/?id=" .. (anim.swim or "")
            )
            Notify("Animation", "Changed to " .. anim.name, "Success", nil, 2)
        end
    })
end

local specialAnimSec = addSection(miscTab, "Special Animations", "right")
local specialAnims = {
    { name = "Patrol", idle1 = "1149612882", idle2 = "1150842221", walk = "1151231493", run = "1150967949", jump = "1148811837", climb = "1148811837", fall = "1148863382" },
    { name = "Confident", idle1 = "1069977950", idle2 = "1069987858", walk = "1070017263", run = "1070001516", jump = "1069984524", climb = "1069946257", fall = "1069973677" },
    { name = "Popstar", idle1 = "1212900985", idle2 = "1150842221", walk = "1212980338", run = "1212980348", jump = "1212954642", climb = "1213044953", fall = "1212900995" },
    { name = "Cowboy", idle1 = "1014390418", idle2 = "1014398616", walk = "1014421541", run = "1014401683", jump = "1014394726", climb = "1014380606", fall = "1014384571" },
    { name = "Ghost", idle1 = "616006778", idle2 = "616008087", walk = "616013216", run = "616013216", jump = "616008936", climb = "", fall = "616005863", swimIdle = "616012453", swim = "616011509" },
    { name = "Sneaky", idle1 = "1132473842", idle2 = "1132477671", walk = "1132510133", run = "1132494274", jump = "1132489853", climb = "1132461372", fall = "1132469004" },
    { name = "Princess", idle1 = "941003647", idle2 = "941013098", walk = "941028902", run = "941015281", jump = "941008832", climb = "940996062", fall = "941000007" },
}
for _, anim in ipairs(specialAnims) do
    specialAnimSec:AddButton({
        Icon = "play",
        Name = anim.name,
        Callback = function()
            applyAnimation(
                "http://www.roblox.com/asset/?id=" .. anim.idle1,
                "http://www.roblox.com/asset/?id=" .. (anim.idle2 or anim.idle1),
                "http://www.roblox.com/asset/?id=" .. (anim.walk or ""),
                "http://www.roblox.com/asset/?id=" .. (anim.run or ""),
                "http://www.roblox.com/asset/?id=" .. (anim.jump or ""),
                "http://www.roblox.com/asset/?id=" .. (anim.climb or ""),
                "http://www.roblox.com/asset/?id=" .. (anim.fall or ""),
                "http://www.roblox.com/asset/?id=" .. (anim.swimIdle or ""),
                "http://www.roblox.com/asset/?id=" .. (anim.swim or "")
            )
            Notify("Animation", "Changed to " .. anim.name, "Success", nil, 2)
        end
    })
end

local otherAnimSec = addSection(miscTab, "Other Animations", "right")
otherAnimSec:AddButton({
    Icon = "x", Name = "None (Clear)",
    Callback = function()
        applyAnimation("", "", "", "", "", "", "", "", "")
        Notify("Animation", "Cleared all animations", "Info", nil, 2)
    end
})
otherAnimSec:AddButton({
    Icon = "rotate", Name = "Anthro (Default)",
    Callback = function()
        applyAnimation(
            "http://www.roblox.com/asset/?id=2510196951",
            "http://www.roblox.com/asset/?id=2510197257",
            "http://www.roblox.com/asset/?id=2510202577",
            "http://www.roblox.com/asset/?id=2510198475",
            "http://www.roblox.com/asset/?id=2510197830",
            "http://www.roblox.com/asset/?id=2510192778",
            "http://www.roblox.com/asset/?id=2510195892",
            "",
            ""
        )
        Notify("Animation", "Set to Anthro default", "Success", nil, 2)
    end
})

local themeSec = addSection(miscTab, "Theme", "left")
themeSec:AddLabel("UI Theme"):AddDropdown({
    Default = "Blue", Values = { "Blue", "Red", "Green", "Purple" }, Flag = "Theme",
    Callback = function(v)
        local colors = { Blue = Color3.fromRGB(78,127,252), Red = Color3.fromRGB(255,90,90), Green = Color3.fromRGB(90,255,90), Purple = Color3.fromRGB(200,100,255) }
        NeverLose.AccentColor = colors[v] or Color3.fromRGB(78,127,252)
        saveSettings()
    end
})

local mobileCustomSec = addSection(miscTab, "Mobile Button Customization", "left")
mobileCustomSec:AddLabel("Select Button"):AddDropdown({
    Default = "SilentAim", Values = { "SilentAim", "KnifeAim", "GrabGun" }, Flag = "SelectedMobile",
    Callback = function(v) _G.SelectedMobileButton = v; saveSettings() end
})
mobileCustomSec:AddButton({
    Icon = "rotate", Name = "Reset Button Position",
    Callback = function()
        local name = _G.SelectedMobileButton or "SilentAim"
        if draggableButtons[name] then
            local positions = { SilentAim = UDim2.new(1,-100,0.5,-50), KnifeAim = UDim2.new(1,-100,0.5,-150), GrabGun = UDim2.new(1,-100,0.5,80) }
            if positions[name] then
                draggableButtons[name].container.Position = positions[name]
                Notify("Mobile Button", name .. " position reset", "Success", nil, 2)
            end
        end
    end
})
mobileCustomSec:AddLabel("Lock All Mobile Buttons"):AddToggle({
    Default = false, Flag = "LockMobile",
    Callback = function(v) _G.LockMobileButtons = v; saveSettings() end
})
mobileCustomSec:AddLabel("Silent Aim Button Size"):AddSlider({
    Min = 60, Max = 150, Default = 85, Rounding = 0, Flag = "SASize",
    Callback = function(v)
        _G.SilentAimSize = v
        local g = LocalPlayer.PlayerGui:FindFirstChild("SilentAimStandalone")
        if g and g:FindFirstChildWhichIsA("TextButton") then g:FindFirstChildWhichIsA("TextButton").Size = UDim2.fromOffset(v,v) end
        saveSettings()
    end
})
mobileCustomSec:AddButton({
    Icon = "eye", Name = "Toggle Spinner (Silent Aim)",
    Callback = function()
        local name = _G.SelectedMobileButton or "SilentAim"
        if name ~= "SilentAim" then Notify("Mobile Button", "Spinner only for Silent Aim", "Warning", nil, 2) return end
        if draggableButtons[name] and draggableButtons[name].spinContainer then
            local visible = not draggableButtons[name].spinContainer.Visible
            draggableButtons[name].spinContainer.Visible = visible
            Notify("Mobile Button", "Spinner " .. (visible and "shown" or "hidden"), "Info", nil, 2)
        end
    end
})
mobileCustomSec:AddButton({
    Icon = "list", Name = "List All Buttons",
    Callback = function()
        local names = {}
        for name,_ in pairs(draggableButtons) do table.insert(names, name) end
        Notify("Mobile Buttons", "Buttons: " .. table.concat(names, ", "), "Info", nil, 3)
    end
})

local configSec = addSection(miscTab, "Config", "left")
configSec:AddButton({
    Icon = "floppy-disk", Name = "Save Settings",
    Callback = function() saveSettings(); Notify("Saved", "", "Success", nil, 2) end
})
configSec:AddButton({
    Icon = "folder", Name = "Load Settings",
    Callback = function()
        if loadSettings() then Notify("Loaded", "", "Success", nil, 2) else Notify("No save file", "", "Error", nil, 2) end
    end
})

local creditsSec = addSection(miscTab, "Credits", "right")
creditsSec:AddLabel("Tiktok: @valuescripts\nYoutube: @8sm9\nDiscord: Still in progress", true)
local warningSec = addSection(miscTab, "WARNING", "right")
warningSec:AddLabel("WARNING:\nIF THE SCRIPT IS NOT FROM THESE ACCOUNT THAT IS MENTIONED PLEASE LEAVE THE GAME AS FAST AS POSSIBLE IT MIGHT CONTAIN A STEALER", true)

-- ====== AUTOFARM TAB ======
local farmTab = window:AddTab({ Icon = "crop", Name = "Autofarm" })
local farmSection = farmTab:AddSection({ Name = "Coin Farm", Position = "full"})
farmSection:AddLabel("Enable Coin Farm"):AddToggle({
    Default = false, Flag = "CoinFarm",
    Callback = function(v) toggleCoinFarm(v) end
})
farmSection:AddLabel("Farm Speed"):AddSlider({
    Min = 1, Max = 30, Default = 25, Rounding = 0, Flag = "FarmSpeed",
    Callback = function(v) _G.CoinFarmSpeed = v; saveSettings() end
})
farmSection:AddLabel("Search Radius"):AddSlider({
    Min = 50, Max = 500, Default = 200, Rounding = 0, Flag = "FarmRadius",
    Callback = function(v) _G.CoinFarmRadius = v; saveSettings() end
})
farmSection:AddLabel("Collect Method"):AddDropdown({
    Default = "Normal", Values = { "Normal", "Head" }, Flag = "CollectMethod",
    Callback = function(v) _G.CoinCollectMethod = v; saveSettings() end
})
farmSection:AddLabel("Max Coins Before Reset"):AddSlider({
    Min = 10, Max = 100, Default = 40, Rounding = 0, Flag = "MaxCoins",
    Callback = function(v) _G.MaxCoinsPerRound = v; saveSettings() end
})
farmSection:AddLabel("Auto Fling Murderer on Reset"):AddToggle({
    Default = false, Flag = "AutoFlingMurderer",
    Callback = function(v) _G.AutoFlingMurderer = v; saveSettings() end
})
farmSection:AddButton({
    Icon = "rocket", Name = "Fling Murderer Now",
    Callback = function()
        local murderer = findPlayerByRole("Murderer") or getMurdererFromData()
        if murderer then
            task.spawn(function() flingPlayer(murderer) end)
            Notify("Fling", "Flinged murderer: " .. murderer.Name, "Success", nil, 3)
        else
            Notify("Fling", "Murderer not found!", "Error", nil, 2)
        end
    end
})

-- ====== CHANGE LOGS TAB (full width) ======
local logsTab = window:AddTab({ Icon = "key", Name = "Change Logs" })
local logsSection = logsTab:AddSection({ Name = "Change Logs", Position = "full" })
logsSection:AddLabel("2026/9/1 - Fixed 15 bugs\nRemoved: RTX Shader, Boombox and Static Texture\nAdded: Mobile Support", true)
logsSection:AddLabel("2026/8/31 - Deleted Over 1000+ Line of code. To improve code.", true)
logsSection:AddLabel("2026/8/30 - Changed Gui Design from FluentModded To RuthlessUI.", true)
logsSection:AddLabel("2026/8/26 - fixed bugs.", true)
logsSection:AddLabel("2026/8/25 - Added Player spin.", true)
logsSection:AddLabel("2026/8/24 - Changed Combat Button UI design, Added fling Sheriff and\nMurderer.", true)
logsSection:AddLabel("2026/8/23 - Published the script", true)
logsSection:AddLabel("2026/8/3 - Added all the modules\nRemoved: Herobrine.", true)
logsSection:AddLabel("2026/8/2 - Added Tabs: Main, Visual, Combat, Player, AutoFarm, Whitelist,\nEmotes, Teleport, Misc, Atmosphere, Credits, Settings\nRemoved: bugs and errors...", true)
logsSection:AddLabel("2026/8/1 - Created The Project.", true)

-- ====== SETTINGS / UI CONTROLS ======

window.UserSettings:AddLabel("Watermark"):AddToggle({
    Default = true,          -- true = visible
    Callback = function(state)
        wm:SetVisible(state)
    end,
})

window.UserSettings:AddLabel('Menu Scale'):AddDropdown({
	Default = "Default",
	Values = {"Default",'Large','Mobile','Small'},
	Callback = function(v)
		window:SetSize(NeverLose.Scales[v]);
		Logging.new("crop",'Changed ui size to '..tostring(v),5)
	end,
})

window.UserSettings:AddLabel('3D Menu'):AddToggle({
	Default = false,
	Callback = function(v)
		window:Set3DRender(v);
	end,
})

window.UserSettings:AddButton({
	Icon = 'discord',
	Name = 'Discord',
	Callback = function()
		setclipboard("https://discord.gg/neaWW3ggwY")
		
		Logging.new("discord",'Copied discord invite link',5)
	end,
})



loadSettings()
toggleAntiAfk(_G.AntiAfkEnabled)

task.spawn(function()
    task.wait(0.5)
    if _G.SilentAimMobile then createSilentAimMobileButton() end
    if _G.KnifeMobileEnabled then createKnifeMobileButton() end
    if _G.GrabGunMobile then createGrabGunMobileButton() end
end)


task.delay(1, function()
    Notification.new({ Title = "Ruthless Hub", Content = "Click the watermark to toggle the interface", Duration = 10 })
end)

task.delay(1, function()
    Notification.new({ Title = "Ruthless Hub", Content = "LControl to toggle the interface", Duration = 10 })
end)
function NeverLose:CreateLogger()
	if NeverLose.__LogSystem then
		return 	NeverLose.__LogSystem;
	end;

	local Logging = {};
	local Log = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	Log.Name = NeverLose.RandomString();
	Log.Parent = NeverLose.ScreenGui
	Log.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Log.BackgroundTransparency = 1.000
	Log.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Log.BorderSizePixel = 0
	Log.Position = UDim2.new(0, 25, 0, 5 + math.abs(NeverLose.ScreenGui.AbsolutePosition.Y))
	Log.Size = UDim2.new(0, 25, 0, 25)

	UIListLayout.Parent = Log
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 12)

	NeverLose.__LogSystem = Logging;

	function Logging.new(IconStr: string , Message: string , Duration: number)
		Duration = Duration or 3;
		Message = Message or "Log";
		IconStr = IconStr or "crosshairs";

		local LogFrame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local LogContent = Instance.new("TextLabel")
		local Line = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local Icon = Instance.new("TextLabel")
		local Shadow = NeverLose:CreateShadow(LogFrame , true);

		LogFrame.Name = NeverLose.RandomString();
		LogFrame.Parent = Log
		LogFrame.AnchorPoint = Vector2.new(0.5, 0)
		LogFrame.BackgroundColor3 = Color3.fromRGB(20, 22, 27)
		LogFrame.BackgroundTransparency =  1--0.075
		LogFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogFrame.BorderSizePixel = 0
		LogFrame.ClipsDescendants = true
		LogFrame.Position = UDim2.new(0,0,0,0)
		LogFrame.Size = UDim2.new(0, 0, 0, 20)
		LogFrame.ZIndex = 130

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = LogFrame

		UIStroke.Transparency = 1--0.650
		UIStroke.Color = Color3.fromRGB(45, 48, 58)
		UIStroke.Parent = LogFrame

		LogContent.Name = NeverLose.RandomString();
		LogContent.Parent = LogFrame
		LogContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LogContent.BackgroundTransparency = 1.000
		LogContent.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogContent.BorderSizePixel = 0
		LogContent.Position = UDim2.new(0, 25, 0, 2)
		LogContent.Size = UDim2.new(0, 200, 0, 15)
		LogContent.ZIndex = 132
		LogContent.Font = Enum.Font.GothamBold
		LogContent.Text = Message
		LogContent.TextColor3 = Color3.fromRGB(255, 255, 255)
		LogContent.TextSize = 12.000
		LogContent.TextTransparency = 1--0.250
		LogContent.TextXAlignment = Enum.TextXAlignment.Left

		Line.Name = NeverLose.RandomString();
		Line.Parent = LogFrame
		Line.AnchorPoint = Vector2.new(0, 0.5)
		Line.BackgroundColor3 = NeverLose.AccentColor
		Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Line.BackgroundTransparency = 1 --0
		Line.BorderSizePixel = 0
		Line.Position = UDim2.new(0, -2, 0.5, 0)
		Line.Size = UDim2.new(0, 5, 1, 0)
		Line.ZIndex = 131

		UICorner_2.CornerRadius = UDim.new(0, 4)
		UICorner_2.Parent = Line

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = LogFrame
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 7, 0, 3)
		Icon.Size = UDim2.new(0, 15, 0, 15)
		Icon.ZIndex = 133
		Icon.FontFace = NeverLose.BuiltInBold
		Icon.Text = IconStr
		Icon.TextColor3 = Color3.fromRGB(223, 223, 223)
		Icon.TextSize = 13.000
		Icon.TextTransparency = 1--0.250
		Icon.TextWrapped = true

		local size = TextService:GetTextSize(LogContent.Text,LogContent.TextSize,LogContent.Font,Vector2.new(math.huge,math.huge));

		NeverLose.PlayAnimate(LogFrame , SlowyTween , {
			Size = UDim2.new(0, size.X + 35, 0, 20),
			BackgroundTransparency =  0.075
		});

		task.delay(0.15,LPH_NO_VIRTUALIZE(function()
			Shadow:Render(true);

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 0.650
			});

			NeverLose.PlayAnimate(LogContent , SlowyTween , {
				TextTransparency = 0.25
			});

			NeverLose.PlayAnimate(Line , SlowyTween , {
				BackgroundTransparency = 0
			});

			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 0.25
			});

			task.wait(Duration + 0.1);

			Shadow:Render(false);

			NeverLose.PlayAnimate(LogFrame , SlowyTween , {
				BackgroundTransparency =  1
			});

			NeverLose.PlayAnimate(UIStroke , SlowyTween , {
				Transparency = 1
			});

			NeverLose.PlayAnimate(LogContent , SlowyTween , {
				TextTransparency = 1
			});

			NeverLose.PlayAnimate(Line , SlowyTween , {
				BackgroundTransparency = 1
			});

			NeverLose.PlayAnimate(Icon , SlowyTween , {
				TextTransparency = 1
			});

			task.wait(0.25);

			LogFrame:Destroy();
		end))
	end;

	return Logging
end;

function NeverLose:CreateIndicator()
	local IndicatorFrame = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")

	IndicatorFrame.Name = NeverLose.RandomString();
	IndicatorFrame.Parent = NeverLose.ScreenGui;
	IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
	IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	IndicatorFrame.BackgroundTransparency = 1.000
	IndicatorFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	IndicatorFrame.BorderSizePixel = 0
	IndicatorFrame.Position = UDim2.new(0, 15, 0.5, 0)
	IndicatorFrame.Size = UDim2.new(0, 100, 0, 100)
	IndicatorFrame.ZIndex = 15

	UIListLayout.Parent = IndicatorFrame
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 10)

	local Indicators = {};

	Indicators.Color = {
		Red = Color3.fromRGB(255, 102, 105),
		Green = Color3.fromRGB(135, 255, 143),
		White = Color3.fromRGB(186, 186, 186),
	};

	Indicators.Root = IndicatorFrame;

	function Indicators.new(Config)
		Config = NeverLose:ProcessParams(Config , {
			Name = "Indicator",
			Icon = 'crosshairs',
			Color = 'Red',
		});

		local Indicator = {
			CurrentColor = Config.Color,	
			Visible = false,
		};

		local IndicatorItem = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Line = Instance.new("Frame")
		local UICorner_2 = Instance.new("UICorner")
		local UIGradient = Instance.new("UIGradient")
		local Icon = Instance.new("TextLabel")
		local Content = Instance.new("TextLabel")
		local Shadow = NeverLose:CreateShadow(IndicatorItem);

		IndicatorItem.Name = NeverLose.RandomString();
		IndicatorItem.BackgroundColor3 = Color3.fromRGB(19, 19, 21)
		IndicatorItem.BackgroundTransparency = 1
		IndicatorItem.BorderColor3 = Color3.fromRGB(0, 0, 0)
		IndicatorItem.BorderSizePixel = 0
		IndicatorItem.ClipsDescendants = true
		IndicatorItem.Size = UDim2.new(0, 85, 0, 40)
		IndicatorItem.ZIndex = 16
		IndicatorItem.Visible = false;

		IndicatorItem:GetPropertyChangedSignal('BackgroundTransparency'):Connect(LPH_NO_VIRTUALIZE(function()
			if IndicatorItem.BackgroundTransparency > 0.9 then
				IndicatorItem.Parent = nil;
				IndicatorItem.Visible = false;
			else
				IndicatorItem.Parent = IndicatorFrame;
				IndicatorItem.Visible = true;
			end;
		end))

		UICorner.CornerRadius = UDim.new(0, 25)
		UICorner.Parent = IndicatorItem

		Line.Name = NeverLose.RandomString();
		Line.Parent = IndicatorItem
		Line.AnchorPoint = Vector2.new(0, 0.5)
		Line.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
		Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Line.BorderSizePixel = 0
		Line.Position = UDim2.new(0, 2, 0.5, 0)
		Line.BackgroundTransparency = 1;
		Line.Size = UDim2.new(0, 3, 0.649999976, 0)
		Line.ZIndex = 17

		UICorner_2.CornerRadius = UDim.new(0, 25)
		UICorner_2.Parent = Line

		UIGradient.Rotation = 90
		UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 1.00), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(1.00, 1.00)}
		UIGradient.Parent = Line

		Icon.Name = NeverLose.RandomString();
		Icon.Parent = IndicatorItem
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
		Icon.BackgroundTransparency = 1.000
		Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Icon.BorderSizePixel = 0
		Icon.Position = UDim2.new(0, 10, 0.5, 0)
		Icon.Size = UDim2.new(0, 25, 0, 25)
		Icon.ZIndex = 17
		Icon.FontFace = NeverLose.BuiltInBold;
		Icon.Text = Config.Icon
		Icon.TextColor3 = Color3.fromRGB(186, 186, 186)
		Icon.TextSize = 21.000
		Icon.TextTransparency = 1
		Icon.TextWrapped = true

		Content.Name = NeverLose.RandomString();
		Content.Parent = IndicatorItem
		Content.AnchorPoint = Vector2.new(0, 0.5)
		Content.BackgroundColor3 = Color3.fromRGB(186, 186, 186)
		Content.BackgroundTransparency = 1.000
		Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Content.BorderSizePixel = 0
		Content.Position = UDim2.new(0, 40, 0.5, 0)
		Content.Size = UDim2.new(1, -40, 0, 25)
		Content.ZIndex = 17
		Content.Font = Enum.Font.GothamBold
		Content.Text = Config.Name
		Content.TextColor3 = Color3.fromRGB(186, 186, 186)
		Content.TextSize = 20.000
		Content.TextTransparency = 1
		Content.TextXAlignment = Enum.TextXAlignment.Left

		Indicator.Update = LPH_NO_VIRTUALIZE(function()
			local text = TextService:GetTextSize(Content.Text,Content.TextSize , Content.Font , Vector2.new(math.huge,math.huge));

			NeverLose.PlayAnimate(IndicatorItem , SlowyTween , {
				Size = UDim2.new(0, text.X + 60, 0, 40);
			})
		end);

		Indicator.SetRender = LPH_NO_VIRTUALIZE(function(self , value)
			Indicator.Visible = value;

			if value then
				NeverLose.PlayAnimate(IndicatorItem , SlowyTween , {
					BackgroundTransparency = 0.200
				});

				NeverLose.PlayAnimate(Line , SlowyTween , {
					BackgroundTransparency = 0,
					BackgroundColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				NeverLose.PlayAnimate(Icon , VSlowTween , {
					TextTransparency = 0.250,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				NeverLose.PlayAnimate(Content , VSlowTween , {
					TextTransparency = 0.2,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				Shadow:Render(true);
			else
				NeverLose.PlayAnimate(IndicatorItem , SlowyTween , {
					BackgroundTransparency = 1
				});

				NeverLose.PlayAnimate(Line , SlowyTween , {
					BackgroundTransparency = 1,
					BackgroundColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				NeverLose.PlayAnimate(Icon , VSlowTween , {
					TextTransparency = 1,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				NeverLose.PlayAnimate(Content , VSlowTween , {
					TextTransparency = 1,
					TextColor3 = Indicators.Color[Indicator.CurrentColor]
				});

				Shadow:Render(false);
			end;

			Indicator.Update();
		end);

		Indicator.Update();
		Indicator:SetRender(false);

		function Indicator:SetColor(new_color)
			Indicator.CurrentColor = new_color;

			if Indicator.Visible then
				Indicator:SetRender(true);
			end;
		end;

		function Indicator:SetText(name)
			Config.Name = name;

			Content.Text = Config.Name;

			Indicator.Update();
		end;

		return Indicator;
	end;

	return Indicators;
end;

function NeverLose:Unload()
	if not NeverLose.UnloadEnabled then
		return;	
	end;

	NeverLose.ScreenGui:Destroy();

	for i,v in next , NeverLose.GlobalSignals do
		pcall(v.Disconnect,v)
	end;
end;

return NeverLose;
