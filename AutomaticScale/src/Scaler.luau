--> Main
local Scaler = {}

--> function
function Scaler.Size(Object: GuiObject)
	if not Object:IsA('GuiBase2d') then return end
	if Object.Size.X.Offset == 0 and Object.Size.Y.Offset == 0 then return end
	
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
	
	local XScale = Object.Size.X.Scale
	local YScale = Object.Size.Y.Scale
	
	local _X = XScale + if X ~= 0 then (X / AbsSize.X) else 0
	local _Y = YScale + if Y ~= 0 then (Y / AbsSize.Y) else 0
	
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
	
	local X = Object.Position.X.Scale + if PositionX ~= 0 then PositionX / AbsSize.X else 0
	local Y = Object.Position.Y.Scale + if PositionY ~= 0 then PositionY / AbsSize.Y else 0
	
	Object.Position = UDim2.fromScale(X, Y)
end

function Scaler.ScaleCorner(Object: UICorner?)
	if Object:IsA('UICorner') then
		local Offset = Object.CornerRadius.Offset
		
		if Offset == 0 then return end
		
		local X = Object.CornerRadius.Scale + if Offset ~= 0 then (1 / Offset) else 0
		
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
	
	local Aspect
	
	if Object:FindFirstChildWhichIsA('UIAspectRatioConstraint') then
		Aspect = Object:FindFirstChildWhichIsA('UIAspectRatioConstraint')
	else
		Aspect = Instance.new('UIAspectRatioConstraint')
	end
	
	Aspect.Parent = Object

	local X = Object.AbsoluteSize.X
	local Y = Object.AbsoluteSize.Y
	
	local Ratio = X / Y
	
	
	Aspect.AspectRatio = Ratio
end

function Scaler.ScaleListLayout(Object: UIListLayout?)
	if not Object:IsA('UIListLayout') then return end
	
	local Padding = Object.Padding
	local PaddingScale = Padding.Scale
	local PaddingOffset = Padding.Offset
	
	local Parent = Object.Parent
	local AbsSize = Parent.AbsoluteSize
	
	local Divider
	
	if Object.FillDirection == Enum.FillDirection.Vertical then
		Divider = AbsSize.Y
	else
		Divider = AbsSize.X
	end
	
	local Scale = PaddingScale + if PaddingOffset ~= 0 then (PaddingOffset / Divider) else 0
	
	Object.Padding = UDim.new(Scale, 0)
end

function Scaler.ScaleGridLayout(Object: UIGridLayout?)
	if not Object:IsA('UIGridLayout') then return end
	
	local Parent = Object.Parent
	local AbsoluteSize: Vector2 = Parent.AbsoluteSize
	
	--> Scale Padding
	local CellPadding = Object.CellPadding
	
	do
		local ScaleX = CellPadding.X.Scale
		local OffsetX = CellPadding.X.Offset
		local ScaleY = CellPadding.Y.Scale
		local OffsetY = CellPadding.Y.Offset
		
		local X = ScaleX + if OffsetX ~= 0 then (OffsetX / AbsoluteSize.X) else 0
		local Y = ScaleY + if OffsetY ~= 0 then (OffsetY / AbsoluteSize.Y) else 0
		
		Object.CellPadding = UDim2.fromScale(X, Y)
	end
	
	--> Scale Cell Size
	local CellSize = Object.CellSize
	
	do
		local ScaleX = CellSize.X.Scale
		local OffsetX = CellSize.X.Offset
		local ScaleY = CellSize.Y.Scale
		local OffsetY = CellSize.Y.Offset
		
		local X = ScaleX + if OffsetX ~= 0 then (OffsetX / AbsoluteSize.X) else 0
		local Y = ScaleY + if OffsetY ~= 0 then (OffsetY / AbsoluteSize.Y) else 0
		
		Object.CellSize = UDim2.fromScale(X, Y)
	end
end

function Scaler.ScalePadding(Object: UIPadding)
	if not Object:IsA('UIPadding') then return end
	
	local Parent = Object.Parent
	local AbsSize: Vector2 = Parent.AbsoluteSize
	
	local BottomPadding = Object.PaddingBottom
	local TopPadding = Object.PaddingTop
	local LeftPadding = Object.PaddingLeft
	local RightPadding = Object.PaddingRight
	
	local BottomOffset = BottomPadding.Offset
	local BottomScale = BottomPadding.Scale
	
	local TopOffset = TopPadding.Offset
	local TopScale = TopPadding.Scale
	
	local LeftOffset = LeftPadding.Offset
	local LeftScale = LeftPadding.Scale
	
	local RightOffset = RightPadding.Offset
	local RightScale = RightPadding.Scale
	
	--> Bottom
	do
		local X = BottomScale + if BottomOffset ~= 0 then (BottomOffset / AbsSize.Y) else 0
		
		Object.PaddingBottom = UDim.new(X, 0)
	end
	
	--> Top
	do
		local X = TopScale + if TopOffset ~= 0 then (TopOffset / AbsSize.Y) else 0

		Object.PaddingTop = UDim.new(X, 0)
	end
	
	--> Left
	do
		local X = LeftScale + if LeftOffset ~= 0 then (LeftOffset / AbsSize.X) else 0

		Object.PaddingLeft = UDim.new(X, 0)
	end
	
	--> Right
	do
		local X = RightScale + if RightOffset ~= 0 then (RightOffset / AbsSize.X) else 0

		Object.PaddingRight = UDim.new(X, 0)
	end
end

function Scaler.Scale(Object: GuiObject)
	Scaler.Position(Object)
	Scaler.Size(Object)
	Scaler.ScaleText(Object)
	Scaler.ScaleCorner(Object)
	Scaler.ScaleListLayout(Object)
	Scaler.ScaleGridLayout(Object)
	Scaler.ScalePadding(Object)
	Scaler.Ratio(Object)
end

function Scaler.ScaleAll(Object: GuiObject)
	if not Object:IsA('ScreenGui') then
		Scaler.Scale(Object)
	end
	for _, v in pairs(Object:GetDescendants()) do
		if v:IsA('GuiBase2d') or v:IsA('UICorner') or v:IsA('UILayout') or v:IsA('UIPadding') then
			Scaler.Scale(v)
		end
	end
end

--> return
return Scaler
