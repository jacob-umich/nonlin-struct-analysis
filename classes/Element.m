classdef element
	properties(SetAccess=public)
		nodes
		material
		loads
	end
	methods
		function obj = Element(node_i,node_j,material)
			obj.nodes = [node_i,node_j]
			obj.material = material
		end
		function elem_len = get_elem_len()
			elem_len = sqrt(sum((obj.nodes[2].pos-obj.nodes[1].pos).^2))
		end
		function set_loads(loads)
			obj.loads = loads
		end
		function etran = get_etran()
			delta = (obj.nodes[2].pos-obj.nodes[1].pos)
			
			phi = atan2(delta[2], delta[1]);
			etran = [ cos(phi) sin(phi) 0 0;
                -sin(phi) cos(phi) 0 0;
                0 0 cos(phi) sin(phi);
                0 0 -sin(phi) cos(phi)];
		end

		function stiff = get_stiffness()
			stiff(1,:) = [e.*a./l, 0, -e.*a./l, 0];

			stiff(2,:) = [0, 0,0,0];

			stiff(3,:) = [-e.*a./l, 0, e.*a./l, 0];

			stiff(4,:) = [0, 0,0,0];
		end
		function loads = get_nodal_loads()
			elem_len = obj.get_elem_len();

			loads = [(obj.loads*elem_len)/2;
					0;
					(obj.loads*elem_len)/2;
					0];
		end
  	end
end