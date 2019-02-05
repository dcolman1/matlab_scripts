%Script requires a list of metagenome names in 'metagenome_names', a table
%of KEGG orthology assignments (all_keggs), with one column given as 'ID'
%with the KEGG KO assignments
%The script first identifies the assignments based on metagenome name
%identifiers within the protein IDs

%Space pre-allocation for kegg_table
kegg_table=zeros(9,22062);


%Cycle through metagenomes and identify KO assignments for each. 
for z=1:length(metagenome_list)
    metagenome_inds=find(strncmp(metagenome_names(z),all_keggs.ID,length(metagenome_names{z})));

    
    %find where kegg id's have been assigned
    keggmatches=find(~isnan(all_keggs.KEGG_ID(metagenome_inds)));
    
    %Build table. 
    for k=1:22062
        abund=length(find(all_keggs.KEGG_ID(metagenome_inds(keggmatches))==k));
        kegg_table(z,k)=abund;
    end
    
    
    
    
end

%Generate subset for those KEGGs only involved in metabolism. Requires a
%second table with the KO nums associated with the 'Metabolism' category. 

metab_only_table=kegg_table(:,metab_kegg_ids);
