classdef Node < handle
	properties(SetAccess=public)
		dof
		pos
		loads = [0,0]
		fixity = [0,0]
	end

	methods
		function obj = Node(position)
			obj.pos=position;
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