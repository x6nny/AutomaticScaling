--> Main
local Scaler = {}

--> function
function Scaler.Size(Object: GuiObject)
	if not Object:IsA('GuiBase2d') then return end
	
	local Camera = workspace.CurrentCamera
	local Parent = (Object:FindFirstAncestorWhichIsA('GuiBase2d')) or (Object:FindFirstAncestorWhichIsA('ScreenGui'))
	
	local AbsSize
	
	if Parent:IsA('ScreenGui') then
		AbsSize = Camera.ViewportSize
	else
		AbsSize = Parent.AbsoluteSize
	end
	
	local X = Object.Size.X.Offset
	local Y = Object.Size.Y.Offset
	
	local _X = X / AbsSize.X
	local _Y = Y / AbsSize.Y
	
	Object.Size = UDim2.fromScale(_X, _Y)
end

function Scaler.Position(Object: GuiObject)
	if not Object:IsA('GuiBase2d') then return end

	local Camera = workspace.CurrentCamera
	local Parent = (Object:FindFirstAncestorWhichIsA('GuiBase2d')) or (Object:FindFirstAncestorWhichIsA('ScreenGui'))

	local AbsSize

	if Parent:IsA('ScreenGui') then
		AbsSize = Camera.ViewportSize
	else
		AbsSize = Parent.AbsoluteSize
	end

	local PositionX = Object.Position.X.Offset
	local PositionY = Object.Position.Y.Offset
	
	local X = PositionX / AbsSize.X + Object.Position.X.Scale
	local Y = PositionY / AbsSize.Y + Object.Position.Y.Scale
	
	Object.Position = UDim2.fromScale(X, Y)
end

function Scaler.ScaleCorner(Object: UICorner?)
	if Object:IsA('UICorner') then
		local Offset = Object.CornerRadius.Offset
		local X = Object.CornerRadius.Scale + (1 / Offset)
		
		Object.CornerRadius = UDim.new(X, 0)
	end
end

function Scaler.ScaleText(Object: TextLabel? | TextButton?)
	if Object:IsA('TextLabel') or Object:IsA('TextButton') then
		if Object.TextScaled == false and not Object:FindFirstChildWhichIsA("UITextSizeConstraint") then
			local Scale = Instance.new('UITextSizeConstraint')
			
			Scale.MaxTextSize = Object.TextSize
			Scale.Parent = Object
			
			Object.TextScaled = true
		elseif Object.TextScaled == true and not Object:FindFirstChildWhichIsA("UITextSizeConstraint") then
			local Scale = Instance.new('UITextSizeConstraint')

			Scale.MaxTextSize = Object.TextBounds.Y
			Scale.Parent = Object

		end
	end
end

function Scaler.Ratio(Object: GuiObject)
	if not Object:IsA('GuiBase2d') then return end

	local X = Object.AbsoluteSize.X
	local Y = Object.AbsoluteSize.Y
	
	local Ratio = X / Y
	
	local Aspect = Instance.new('UIAspectRatioConstraint')
	
	Aspect.AspectRatio = Ratio
	
	Aspect.Parent = Object
end

function Scaler.Scale(Object: GuiObject)
	Scaler.Position(Object)
	Scaler.Size(Object)
	Scaler.Ratio(Object)
	Scaler.ScaleText(Object)
	Scaler.ScaleCorner(Object)
end

function Scaler.ScaleAll(Object: GuiObject)
	if not Object:IsA('ScreenGui') then
		Scaler.Scale(Object)
	end
	for _, v in pairs(Object:GetDescendants()) do
		if v:IsA('GuiBase2d') or v:IsA('UICorner') then
			Scaler.Scale(v)
		end
	end
end

--> return
return Scaler