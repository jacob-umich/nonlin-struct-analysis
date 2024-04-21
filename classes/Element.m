classdef Element < handle
	properties(SetAccess=public)
		nodes= {}
		material
		loads=0
		dofs
		k
		original_length
		orig_pos
		id
	end
	methods
		function obj = Element(node_i,node_j,material)
			obj.nodes = {node_i,node_j};
			obj.material = material;
			obj.original_length=obj.get_elem_len();
			obj.orig_pos=obj.get_coords();
		end
		function elem_len = get_elem_len(obj)
			elem_len = sqrt(sum((obj.nodes{2}.pos-obj.nodes{1}.pos).^2));
		end
		function set_loads(obj, loads)
			obj.loads = loads;
		end
		function etran = get_etran(obj)
			delta = (obj.nodes{2}.pos-obj.nodes{1}.pos);
			
			phi = atan2(delta(2), delta(1));
			etran = [ cos(phi) sin(phi) 0 0;
                -sin(phi) cos(phi) 0 0;
                0 0 cos(phi) sin(phi);
                0 0 -sin(phi) cos(phi)];
		end

		function stiff = get_stiffness(obj)
			l = obj.get_elem_len();
			a = obj.material.area;
			e = obj.material.get_moe(obj.get_strain());
			stiff(1,:) = [e.*a./l, 0, -e.*a./l, 0];

			stiff(2,:) = [0, 0,0,0];

			stiff(3,:) = [-e.*a./l, 0, e.*a./l, 0];

			stiff(4,:) = [0, 0,0,0];
		end
		function stiff = get_g_e_stiffness(obj)
			stiff=obj.get_stiffness();
			etran = obj.get_etran();
			stiff = etran'*stiff*etran;
		end
		function loads = get_nodal_loads(obj)
			elem_len = obj.original_length;

			loads = [(obj.loads*elem_len)/2;
					0;
					(obj.loads*elem_len)/2;
					0];
		end
		function get_dofs(obj)
			obj.dofs = [
				obj.nodes{1}.dof(1),
				obj.nodes{1}.dof(2),
				obj.nodes{2}.dof(1), 
				obj.nodes{2}.dof(2)
			];
		end
		function coords = get_coords(obj)
			displ = [
				obj.nodes{1}.pos(1),
				obj.nodes{1}.pos(2),
				obj.nodes{2}.pos(1),
				obj.nodes{2}.pos(2)
			];

			coords = reshape(displ,4,1);
		end
		function strain = get_strain(obj)
			delta = obj.get_coords()-obj.orig_pos;
			local_pos = obj.get_etran()*delta;
			strain=(local_pos(3)-local_pos(1))/obj.original_length;
		end
		function force = get_internal(obj)
			strain = obj.get_strain();
			result = strain * (obj.material.area) * (obj.material.get_moe(strain));
			force = [-result;0;result;0];
		end

		function k_g = get_geometric_stiffness(obj)
			T = obj.get_internal()(3);
			cur_len = obj.get_elem_len();
			k_g = T/cur_len*[
				1,0,-1,0;
				0,1,0,-1;
				-1,0,1,0;
				0,-1,0,1;
			];
		end
		function k_m = get_material_stiffness(obj)
			py=36*obj.material.area
			n = [
				1/py,0;
				0,0;
				0,1/py;
				0,0;
			]
			F = obj.get_internal()
			T = F(3);

			if T>=py
				factor=1
			else
				factor=0

			EA = (obj.material.area) * (obj.material.get_moe(strain))
			k_p = factor/obj.get_elem_len*[
				EA,0,,0;
				0,0,0,0;
				0,0,EA,0;
				0,0,0,0;
			];
			cur_len = obj.get_elem_len();
			k_g = T/cur_len*[
				1,0,-1,0;
				0,1,0,-1;
				-1,0,1,0;
				0,-1,0,1;
			];
		end
  	end
end