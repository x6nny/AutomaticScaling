--> Services
local Plugin = plugin or getfenv().PluginManager():CreatePlugin()

--> Scaler
local Scaler = require(script.Scaler)

--> ToolBar
local toolbar = plugin:CreateToolbar('Automatic Scaling')

--> Button
local Scale = toolbar:CreateButton(
	"Scale Selection",
	"Automaticly scales the selected gui and its descendants.",
	"http://www.roblox.com/asset/?id=18726763633"
)

--> Main
Scale.Click:Connect(function()
	for _, v in pairs(game:GetService("Selection"):Get()) do
		if v:IsA('ScreenGui') or v:IsA('GuiObject') then
			Scaler.ScaleAll(v)
		end
	end
end)