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
		function moe = get_moe(obj,strain)
			moe = feval(obj.material_func,strain,obj.e_base);
		end
		function stress = get_stress(obj,strain)
			p_strain = abs(strain)-36/obj.e_base;
			if p_strain>0
				stress = sign(strain)*36+sign(strain)*p_strain*obj.get_moe(strain);
			else
				stress = strain*obj.get_moe(strain);
			end
		end

	end
end