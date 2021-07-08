%--------------------------------
% Grzegorz Fotyga, ETI, PG
%--------------------------------

function [Edges] = generate_network(N, density)

Edges = randi(N, 2, N * density) ;

Edges(:, find((Edges(1,:) - Edges(2,:))==0))=[];    

Edges_temp = sortrows(Edges'); 
d_connections = find(sum(abs(Edges_temp(2:end,:) - Edges_temp(1:end-1,:)),2) == 0);  
Edges_temp(d_connections,:) = [];   
Edges = Edges_temp';

Sites_uniq = unique(Edges(1,:));
nr_of_end_sites = 0;

  for k = 1:N
      if ~ismember(k, Sites_uniq)
          nr_of_end_sites = nr_of_end_sites + 1;
          Edges = [Edges [[ones(1,N-1) * k]; [1:k-1 k+1:N]]];
      end
  end

end