classdef Material
	properties(SetAccess=Public)
		e_base
		area
		moi
	end
	methods
		function obj = Material(id,e_base,area,moi)
			obj.id = id
			obj.e_base = e_base
			obj.area = area
			obj.moi = moi
		end
end