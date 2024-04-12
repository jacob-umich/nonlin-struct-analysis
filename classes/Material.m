classdef Material < handle
	properties(SetAccess=public)
		id
		e_base
		area
		moi
		material_func
	end
	methods
		function obj = Material(id,e_base,area,moi,material_func)
			obj.id = id;
			obj.e_base = e_base;
			obj.area = area;
			obj.moi = moi;
			obj.material_func=material_func;
		end
		function moe = get_moe(obj,strain);
			moe = obj.material_func(strain,obj.e_base);
		end
	end
end