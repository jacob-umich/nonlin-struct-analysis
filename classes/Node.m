classdef Node
	properties(SetAccess=public)
		dof
		pos
		loads
		fixity
	end

	methods
		function obj = Node(position)
			obj.pos=position
		end
		function set_fixity(fixity)
			obj.fixity = fixity
		function set_load(loads)
			obj.loads = loads
  	end
end
