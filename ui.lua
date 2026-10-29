--[[
    SmoothUI - a lightweight, animated Roblox UI library
    Works as a ModuleScript (require) or paste into a LocalScript.
 
    Usage:
        local SmoothUI = require(path.to.SmoothUI)
        local Window = SmoothUI:CreateWindow({
            Title = "My Hub",
            Subtitle = "v1.0",
            Accent = Color3.fromRGB(110, 90, 255),
            ToggleKey = Enum.KeyCode.RightShift,
        })
        local Main = Window:AddTab("Main")
        Main:AddSection("Combat")
        Main:AddButton({Name = "Click me", Callback = function() print("hi") end})
        Main:AddToggle({Name = "Enabled", Default = false, Callback = print})
        Main:AddSlider({Name = "Speed", Min = 0, Max = 100, Default = 16, Callback = print})
        Main:AddDropdown({Name = "Mode", Options = {"A", "B", "C"}, Default = "A", Callback = print})
        Main:AddTextBox({Name = "Name", Placeholder = "type...", Callback = print})
        Main:AddKeybind({Name = "Key", Default = Enum.KeyCode.E, Callback = print})
        Window:Notify({Title = "Loaded", Content = "Welcome!", Duration = 4})
]]
 
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
 
local SmoothUI = {}
 
local Theme = {
	Background = Color3.fromRGB(16, 16, 20),
	Sidebar = Color3.fromRGB(21, 21, 26),
	Element = Color3.fromRGB(28, 28, 35),
	ElementHover = Color3.fromRGB(36, 36, 45),
	Accent = Color3.fromRGB(110, 90, 255),
	Text = Color3.fromRGB(236, 236, 242),
	SubText = Color3.fromRGB(140, 140, 156),
	Stroke = Color3.fromRGB(42, 42, 52),
}
 
local FONT = Enum.Font.GothamMedium
local FONT_BOLD = Enum.Font.GothamBold
local EASE = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local EASE_SLOW = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
 
---------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------
local function tween(obj, props, info)
	local t = TweenService:Create(obj, info or EASE, props)
	t:Play()
	return t
end
 
local function new(class, props, children)
	local inst = Instance.new(class)
	for k, v in pairs(props or {}) do
		inst[k] = v
	end
	for _, c in ipairs(children or {}) do
		c.Parent = inst
	end
	return inst
end
 
local function corner(r)
	return new("UICorner", {CornerRadius = UDim.new(0, r or 8)})
end
 
local function stroke(color, thickness, transparency)
	return new("UIStroke", {
		Color = color or Theme.Stroke,
		Thickness = thickness or 1,
		Transparency = transparency or 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	})
end
 
local function padding(p)
	return new("UIPadding", {
		PaddingTop = UDim.new(0, p), PaddingBottom = UDim.new(0, p),
		PaddingLeft = UDim.new(0, p), PaddingRight = UDim.new(0, p),
	})
end
 
local function isPress(input)
	return input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch
end
 
local function hoverable(frame)
	frame.MouseEnter:Connect(function()
		tween(frame, {BackgroundColor3 = Theme.ElementHover})
	end)
	frame.MouseLeave:Connect(function()
		tween(frame, {BackgroundColor3 = Theme.Element})
	end)
end
 
local function makeDraggable(handle, target)
	local dragging, startPos, startInput
	handle.InputBegan:Connect(function(input)
		if isPress(input) then
			dragging = true
			startInput = input.Position
			startPos = target.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch) then
			local d = input.Position - startInput
			-- tween for a smooth, slightly eased drag
			tween(target, {Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + d.X,
				startPos.Y.Scale, startPos.Y.Offset + d.Y)},
				TweenInfo.new(0.08, Enum.EasingStyle.Quad))
		end
	end)
end
 
---------------------------------------------------------------------
-- Window
---------------------------------------------------------------------
function SmoothUI:CreateWindow(config)
	config = config or {}
	Theme.Accent = config.Accent or Theme.Accent
	local size = config.Size or UDim2.fromOffset(580, 400)
 
	local Window = {Tabs = {}, Connections = {}, ActiveTab = nil}
 
	local parent = config.Parent
		or (Players.LocalPlayer and Players.LocalPlayer:WaitForChild("PlayerGui"))
	local gui = new("ScreenGui", {
		Name = "SmoothUI",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Parent = parent,
	})
	Window.Gui = gui
 
	local main = new("Frame", {
		Name = "Main",
		Size = size,
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Theme.Background,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		Parent = gui,
	}, {corner(12), stroke(Theme.Stroke, 1)})
	local scale = new("UIScale", {Scale = 0.85, Parent = main})
	main.BackgroundTransparency = 1
	tween(scale, {Scale = 1}, EASE_SLOW)
	tween(main, {BackgroundTransparency = 0}, EASE_SLOW)
 
	-- Top bar
	local top = new("Frame", {
		Size = UDim2.new(1, 0, 0, 44),
		BackgroundColor3 = Theme.Sidebar,
		BorderSizePixel = 0,
		Parent = main,
	})
	new("TextLabel", {
		Size = UDim2.new(1, -90, 1, 0),
		Position = UDim2.fromOffset(16, 0),
		BackgroundTransparency = 1,
		Text = config.Title or "SmoothUI",
		Font = FONT_BOLD,
		TextSize = 15,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = top,
	})
	if config.Subtitle then
		new("TextLabel", {
			Size = UDim2.new(1, -32, 1, 0),
			Position = UDim2.fromOffset(0, 0),
			BackgroundTransparency = 1,
			Text = config.Subtitle,
			Font = FONT,
			TextSize = 12,
			TextColor3 = Theme.SubText,
			TextXAlignment = Enum.TextXAlignment.Right,
			Parent = top,
		})
	end
	new("Frame", { -- divider
		Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -1),
		BackgroundColor3 = Theme.Stroke, BorderSizePixel = 0, Parent = top,
	})
	makeDraggable(top, main)
 
	-- Sidebar
	local sidebar = new("ScrollingFrame", {
		Size = UDim2.new(0, 140, 1, -44),
		Position = UDim2.fromOffset(0, 44),
		BackgroundColor3 = Theme.Sidebar,
		BorderSizePixel = 0,
		ScrollBarThickness = 0,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(),
		Parent = main,
	}, {
		padding(8),
		new("UIListLayout", {Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder}),
	})
 
	local pages = new("Frame", {
		Size = UDim2.new(1, -140, 1, -44),
		Position = UDim2.fromOffset(140, 44),
		BackgroundTransparency = 1,
		Parent = main,
	})
 
	-- Toggle visibility
	local visible = true
	function Window:SetVisible(v)
		visible = v
		if v then
			main.Visible = true
			tween(scale, {Scale = 1}, EASE_SLOW)
		else
			local t = tween(scale, {Scale = 0.9}, EASE)
			t.Completed:Once(function() if not visible then main.Visible = false end end)
		end
	end
	table.insert(Window.Connections, UserInputService.InputBegan:Connect(function(input, gpe)
		if not gpe and input.KeyCode == (config.ToggleKey or Enum.KeyCode.RightShift) then
			Window:SetVisible(not visible)
		end
	end))
 
	function Window:Destroy()
		for _, c in ipairs(self.Connections) do c:Disconnect() end
		gui:Destroy()
	end
 
	-- Notifications
	local notifHolder = new("Frame", {
		Size = UDim2.new(0, 280, 1, -20),
		Position = UDim2.new(1, -290, 0, 10),
		BackgroundTransparency = 1,
		Parent = gui,
	}, {new("UIListLayout", {
		Padding = UDim.new(0, 8),
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		SortOrder = Enum.SortOrder.LayoutOrder,
	})})
 
	function Window:Notify(opts)
		local card = new("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Theme.Sidebar,
			BackgroundTransparency = 1,
			Parent = notifHolder,
		}, {
			corner(10), stroke(Theme.Stroke), padding(12),
			new("UIListLayout", {Padding = UDim.new(0, 2)}),
		})
		local bar = new("Frame", {
			Size = UDim2.new(0, 3, 1, -16), Position = UDim2.fromOffset(-6, 8),
			BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Parent = card,
		}, {corner(2)})
		new("TextLabel", {
			Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1,
			Text = opts.Title or "Notification", Font = FONT_BOLD, TextSize = 14,
			TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
		})
		new("TextLabel", {
			Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1, Text = opts.Content or "", Font = FONT,
			TextSize = 13, TextColor3 = Theme.SubText, TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left, Parent = card,
		})
		local s = new("UIScale", {Scale = 0.8, Parent = card})
		tween(card, {BackgroundTransparency = 0}, EASE_SLOW)
		tween(s, {Scale = 1}, EASE_SLOW)
		task.delay(opts.Duration or 4, function()
			tween(card, {BackgroundTransparency = 1}, EASE)
			local t = tween(s, {Scale = 0.8}, EASE)
			t.Completed:Wait()
			card:Destroy()
		end)
	end
 
	---------------------------------------------------------------------
	-- Tabs
	---------------------------------------------------------------------
	function Window:AddTab(name)
		local Tab = {}
 
		local btn = new("TextButton", {
			Size = UDim2.new(1, 0, 0, 34),
			BackgroundColor3 = Theme.Element,
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Text = "",
			Parent = sidebar,
		}, {corner(8)})
		local indicator = new("Frame", {
			Size = UDim2.new(0, 3, 0, 0), Position = UDim2.new(0, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = Theme.Accent,
			BorderSizePixel = 0, Parent = btn,
		}, {corner(2)})
		local label = new("TextLabel", {
			Size = UDim2.new(1, -20, 1, 0), Position = UDim2.fromOffset(14, 0),
			BackgroundTransparency = 1, Text = name, Font = FONT, TextSize = 14,
			TextColor3 = Theme.SubText, TextXAlignment = Enum.TextXAlignment.Left, Parent = btn,
		})
 
		local page = new("ScrollingFrame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = Theme.Accent,
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(),
			Visible = false,
			Parent = pages,
		}, {
			padding(12),
			new("UIListLayout", {Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder}),
		})
 
		local function select()
			if Window.ActiveTab == Tab then return end
			if Window.ActiveTab then Window.ActiveTab.Deselect() end
			Window.ActiveTab = Tab
			page.Visible = true
			page.Position = UDim2.fromOffset(0, 12)
			tween(page, {Position = UDim2.fromOffset(0, 0)}, EASE_SLOW)
			tween(btn, {BackgroundTransparency = 0})
			tween(indicator, {Size = UDim2.new(0, 3, 0, 18)})
			tween(label, {TextColor3 = Theme.Text})
		end
		function Tab.Deselect()
			page.Visible = false
			tween(btn, {BackgroundTransparency = 1})
			tween(indicator, {Size = UDim2.new(0, 3, 0, 0)})
			tween(label, {TextColor3 = Theme.SubText})
		end
		btn.MouseButton1Click:Connect(select)
		if not Window.ActiveTab then select() end
		table.insert(Window.Tabs, Tab)
 
		-- Element base
		local function base(height)
			local f = new("Frame", {
				Size = UDim2.new(1, 0, 0, height or 38),
				BackgroundColor3 = Theme.Element,
				BorderSizePixel = 0,
				ClipsDescendants = true,
				Parent = page,
			}, {corner(8), stroke(Theme.Stroke, 1, 0.4)})
			hoverable(f)
			return f
		end
		local function title(parent, text, w)
			return new("TextLabel", {
				Size = UDim2.new(w or 1, -24, 0, 38),
				Position = UDim2.fromOffset(12, 0),
				BackgroundTransparency = 1, Text = text, Font = FONT, TextSize = 14,
				TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = parent,
			})
		end
 
		function Tab:AddSection(text)
			new("TextLabel", {
				Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1,
				Text = string.upper(text), Font = FONT_BOLD, TextSize = 11,
				TextColor3 = Theme.Accent, TextXAlignment = Enum.TextXAlignment.Left, Parent = page,
			})
		end
 
		function Tab:AddLabel(text)
			local f = base(32)
			local l = title(f, text)
			l.Size = UDim2.new(1, -24, 1, 0)
			l.TextColor3 = Theme.SubText
			return {Set = function(_, t) l.Text = t end}
		end
 
		function Tab:AddButton(o)
			local f = base()
			title(f, o.Name or "Button")
			local hit = new("TextButton", {
				Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", Parent = f,
			})
			hit.MouseButton1Down:Connect(function()
				tween(f, {BackgroundColor3 = Theme.Accent})
			end)
			hit.MouseButton1Up:Connect(function()
				tween(f, {BackgroundColor3 = Theme.ElementHover})
			end)
			hit.MouseButton1Click:Connect(function()
				if o.Callback then task.spawn(o.Callback) end
			end)
		end
 
		function Tab:AddToggle(o)
			local state = o.Default or false
			local f = base()
			title(f, o.Name or "Toggle")
			local track = new("Frame", {
				Size = UDim2.fromOffset(40, 22), Position = UDim2.new(1, -52, 0.5, -11),
				BackgroundColor3 = state and Theme.Accent or Theme.Stroke,
				BorderSizePixel = 0, Parent = f,
			}, {new("UICorner", {CornerRadius = UDim.new(1, 0)})})
			local knob = new("Frame", {
				Size = UDim2.fromOffset(16, 16),
				Position = state and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3),
				BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Parent = track,
			}, {new("UICorner", {CornerRadius = UDim.new(1, 0)})})
			local function set(v, silent)
				state = v
				tween(track, {BackgroundColor3 = v and Theme.Accent or Theme.Stroke})
				tween(knob, {Position = v and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3)},
					TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
				if not silent and o.Callback then task.spawn(o.Callback, v) end
			end
			new("TextButton", {
				Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", Parent = f,
			}).MouseButton1Click:Connect(function() set(not state) end)
			return {Set = function(_, v) set(v) end, Get = function() return state end}
		end
 
		function Tab:AddSlider(o)
			local min, max = o.Min or 0, o.Max or 100
			local step = o.Step or 1
			local value = math.clamp(o.Default or min, min, max)
			local f = base(54)
			title(f, o.Name or "Slider").Size = UDim2.new(1, -90, 0, 30)
			local valLabel = new("TextLabel", {
				Size = UDim2.fromOffset(70, 30), Position = UDim2.new(1, -82, 0, 0),
				BackgroundTransparency = 1, Text = tostring(value), Font = FONT, TextSize = 13,
				TextColor3 = Theme.SubText, TextXAlignment = Enum.TextXAlignment.Right, Parent = f,
			})
			local track = new("Frame", {
				Size = UDim2.new(1, -24, 0, 6), Position = UDim2.new(0, 12, 0, 36),
				BackgroundColor3 = Theme.Stroke, BorderSizePixel = 0, Parent = f,
			}, {new("UICorner", {CornerRadius = UDim.new(1, 0)})})
			local fill = new("Frame", {
				Size = UDim2.fromScale((value - min) / (max - min), 1),
				BackgroundColor3 = Theme.Accent, BorderSizePixel = 0, Parent = track,
			}, {new("UICorner", {CornerRadius = UDim.new(1, 0)})})
 
			local function set(v, silent)
				v = math.clamp(math.floor(v / step + 0.5) * step, min, max)
				value = v
				valLabel.Text = tostring(v)
				tween(fill, {Size = UDim2.fromScale((v - min) / (max - min), 1)},
					TweenInfo.new(0.08, Enum.EasingStyle.Quad))
				if not silent and o.Callback then task.spawn(o.Callback, v) end
			end
			local function fromX(x)
				local rel = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
				set(min + (max - min) * rel)
			end
 
			local dragging = false
			track.InputBegan:Connect(function(i)
				if isPress(i) then dragging = true; fromX(i.Position.X) end
			end)
			table.insert(Window.Connections, UserInputService.InputChanged:Connect(function(i)
				if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
					or i.UserInputType == Enum.UserInputType.Touch) then
					fromX(i.Position.X)
				end
			end))
			table.insert(Window.Connections, UserInputService.InputEnded:Connect(function(i)
				if isPress(i) then dragging = false end
			end))
			return {Set = function(_, v) set(v) end, Get = function() return value end}
		end
 
		function Tab:AddDropdown(o)
			local options = o.Options or {}
			local current = o.Default
			local f = base(38)
			local head = title(f, (o.Name or "Dropdown") .. (current and (": " .. tostring(current)) or ""))
			local arrow = new("TextLabel", {
				Size = UDim2.fromOffset(20, 38), Position = UDim2.new(1, -30, 0, 0),
				BackgroundTransparency = 1, Text = "v", Font = FONT_BOLD, TextSize = 12,
				TextColor3 = Theme.SubText, Parent = f,
			})
			local open = false
			local listH = #options * 30 + 8
			local list = new("Frame", {
				Size = UDim2.new(1, -16, 0, #options * 30), Position = UDim2.fromOffset(8, 42),
				BackgroundTransparency = 1, Parent = f,
			}, {new("UIListLayout", {})})
			for _, opt in ipairs(options) do
				local b = new("TextButton", {
					Size = UDim2.new(1, 0, 0, 28), BackgroundColor3 = Theme.Background,
					BackgroundTransparency = 0.3, AutoButtonColor = false,
					Text = tostring(opt), Font = FONT, TextSize = 13,
					TextColor3 = Theme.SubText, Parent = list,
				}, {corner(6)})
				b.MouseEnter:Connect(function() tween(b, {TextColor3 = Theme.Text}) end)
				b.MouseLeave:Connect(function() tween(b, {TextColor3 = Theme.SubText}) end)
				b.MouseButton1Click:Connect(function()
					current = opt
					head.Text = (o.Name or "Dropdown") .. ": " .. tostring(opt)
					open = false
					tween(f, {Size = UDim2.new(1, 0, 0, 38)}, EASE_SLOW)
					tween(arrow, {Rotation = 0})
					if o.Callback then task.spawn(o.Callback, opt) end
				end)
			end
			new("TextButton", {
				Size = UDim2.new(1, 0, 0, 38), BackgroundTransparency = 1, Text = "", Parent = f,
			}).MouseButton1Click:Connect(function()
				open = not open
				tween(f, {Size = UDim2.new(1, 0, 0, open and (38 + listH) or 38)}, EASE_SLOW)
				tween(arrow, {Rotation = open and 180 or 0})
			end)
			return {Get = function() return current end}
		end
 
		function Tab:AddTextBox(o)
			local f = base()
			title(f, o.Name or "Input", 0.5)
			local box = new("TextBox", {
				Size = UDim2.new(0.5, -20, 0, 26), Position = UDim2.new(0.5, 8, 0.5, -13),
				BackgroundColor3 = Theme.Background, Text = o.Default or "",
				PlaceholderText = o.Placeholder or "", PlaceholderColor3 = Theme.SubText,
				Font = FONT, TextSize = 13, TextColor3 = Theme.Text, ClearTextOnFocus = false,
				BorderSizePixel = 0, Parent = f,
			}, {corner(6), stroke(Theme.Stroke)})
			local s = box:FindFirstChildOfClass("UIStroke")
			box.Focused:Connect(function() tween(s, {Color = Theme.Accent}) end)
			box.FocusLost:Connect(function(enter)
				tween(s, {Color = Theme.Stroke})
				if o.Callback then task.spawn(o.Callback, box.Text, enter) end
			end)
			return {Get = function() return box.Text end}
		end
 
		function Tab:AddKeybind(o)
			local key = o.Default or Enum.KeyCode.E
			local listening = false
			local f = base()
			title(f, o.Name or "Keybind", 0.6)
			local kb = new("TextButton", {
				Size = UDim2.fromOffset(80, 26), Position = UDim2.new(1, -92, 0.5, -13),
				BackgroundColor3 = Theme.Background, AutoButtonColor = false,
				Text = key.Name, Font = FONT, TextSize = 12, TextColor3 = Theme.SubText,
				BorderSizePixel = 0, Parent = f,
			}, {corner(6), stroke(Theme.Stroke)})
			kb.MouseButton1Click:Connect(function()
				listening = true
				kb.Text = "..."
				tween(kb, {TextColor3 = Theme.Accent})
			end)
			table.insert(Window.Connections, UserInputService.InputBegan:Connect(function(input, gpe)
				if listening and input.UserInputType == Enum.UserInputType.Keyboard then
					listening = false
					key = input.KeyCode
					kb.Text = key.Name
					tween(kb, {TextColor3 = Theme.SubText})
				elseif not gpe and not listening and input.KeyCode == key then
					if o.Callback then task.spawn(o.Callback, key) end
				end
			end))
			return {Get = function() return key end}
		end
 
		return Tab
	end
 
	return Window
end
 
return SmoothUI
