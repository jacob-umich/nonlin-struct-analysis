classdef Structure < handle
	properties(SetAccess=public)
		elements = {}
		nodes = {}
		n_nodes
		n_sup
		n_mat
		n_free
		n_fix
		n_dof
	end
	methods
		function obj = Structure(nodes,elements)
			obj.nodes=nodes;
			obj.elements=elements; %object arrays
				
			dof_counter = 1;
			for i=1:numel(obj.nodes)
				if (sum(obj.nodes{i}.fixity)~=0)
					continue
				else
					obj.nodes{i}.set_dof([dof_counter, dof_counter+1]);
					dof_counter=dof_counter+2;
				end
			end	
			for i=1:numel(obj.nodes)
				mask = obj.nodes{i}.fixity!=0;
				if (!all(mask)&& !all(!mask))
					% n_free = length(obj.nodes(i).fixity(!mask))
					obj.nodes{i}.dof(!mask)=dof_counter;
					dof_counter=dof_counter+1;
				end
			end
			obj.n_free = dof_counter-1;
			for i=1:numel(obj.nodes) 
				mask = obj.nodes{i}.fixity!=0;
				if (all(mask))
					new_dof = [dof_counter, dof_counter+1];
					obj.nodes{i}.set_dof(new_dof);
					dof_counter=dof_counter+2;
				end
			end
			obj.n_fix = dof_counter-1-obj.n_free;
			for i=1:numel(obj.elements)
				obj.elements{i}.get_dofs();

			end 
			obj.n_dof = dof_counter-1;
		end


		function [P,PF]=get_loads(obj)
			P=zeros(obj.n_dof,1);
			PF=zeros(obj.n_dof,1);
			for i=1:numel(obj.nodes)
				node = obj.nodes{i};
				dof = node.dof;
				P(dof,1)=node.loads;
			end
			for i=1:numel(obj.elements)
				elem = obj.elements{i};
				dof = elem.dofs;
				PF(dof,:)=PF(dof,:)+elem.get_etran()'*elem.get_nodal_loads();
			end
		end

		function K=get_stiffness(obj)
			K=zeros(obj.n_dof,obj.n_dof);
			for i=1:numel(obj.elements)
				elem = obj.elements{i};
				dof = elem.dofs;
				K(dof,dof)=K(dof,dof)+elem.get_gstiffness();
			end
		end

		function update_disp(obj,pos)
			for i=1:numel(obj.nodes)
				node=obj.nodes{i};
				dof = node.dof;
				node.pos = reshape(pos[dof,1],1,2);
				disp(node.pos)
			end
		end

		function F = get_internal_force(obj)
			F = zeros(obj.n_dof,1);
			for i=1:numel(obj.elements)
				elem = obj.elements{i};
				dofs = elem.dofs;
				f = elem.get_etran()'*elem.get_internal();
				F(dofs,1)=F(dofs,1)+f;
			end
		end
	end
end