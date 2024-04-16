classdef Node < handle
	properties(SetAccess=public)
		dof
		pos
		orig_pos
		loads = [0,0]
		fixity = [0,0]
		id
	end

	methods
		function obj = Node(coord)
			obj.pos=coord;
			obj.orig_pos = coord;
		end
		function set_fixity(obj,fixity)
			obj.fixity = fixity;
		end
		function set_load(obj,loads)
			obj.loads = loads;
		end
		function set_dof(obj,dof_in)
		 	obj.dof=dof_in;
		end
  	end
end
