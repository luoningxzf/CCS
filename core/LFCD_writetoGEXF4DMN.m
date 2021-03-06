function LFCD_writetoGEXF4DMN(CIJ, fname, view, arcs, node_size)
%IPN_WRITETOGEXF         Write to Gephi format
%
%   IPN_writetoGEXF(CIJ, fname, labels, arcs);
%
%   This function writes a Gephi .gexf file from a MATLAB matrix
%
%   Inputs:     CIJ,        adjacency matrix with a fixed order of nodes
%                           (see the order of labels)  
%               fname,      filename minus .gexf extension
%               view,       2D/3D
%               arcs,       1 for directed network
%                           0 for an undirected network
%
%   Xi-Nian Zuo, IPCAS, 2011.


CIJ(isnan(CIJ))=0; N = size(CIJ,1); % numer of nodes: 11 seeds of default network
if nargin < 5
    node_size = sum(CIJ); % degree or weighted degree for sizing nodes
end
labels = {'TPJ','LTC','TempP','dMPFC',...
    'aMPFC','PCC',...
    'vMPFC','pIPL','Rsp','PHC','HF'};
coords3D = [-28,-40,-12;-54,-54,28;-14,-52,8;-8,-56,26;...
    -6,52,-2;-60,-24,-18;...
    -22,-20,-26;0,26,-18;-44,-74,32;-50,14,-40;0,52,26];
coords = [45 18; 33 34; 21 39; 85 42; ...
    85 52; 46 44; ...
    76 58; 53 17; 46 52; 50 60; 59 63];
%% Write to the Gexf file
fid = fopen(cat(2,fname,'.gexf'), 'w');
% HEADER
hdl1 = '<?xml version="1.0" encoding="UTF-8"?>';
fprintf(fid, '%s \r', hdl1);
hdl2 = '<gexf xmlns="http://www.gexf.net/1.1draft"';
fprintf(fid, '%s \r', hdl2);
hdl2enhanced = 'xmlns:viz="http://www.gexf.net/1.2draft/viz"';%vis extension
fprintf(fid, '    %s \r', hdl2enhanced);
hdl3 = '      xmlns:xsi="http://www.w3.org/2001/XMLSchema−instance"';
fprintf(fid, '%s \r', hdl3);
hdl4 = '     xsi:schemaLocation="http://www.gexf.net/1.1draft';
fprintf(fid, '%s \r', hdl4);
hdl5 = '                        http://www.gexf.net/1.1draft/gexf.xsd"';
fprintf(fid, '%s \r', hdl5);
hdl6 = '     version="1.1">';
fprintf(fid, '%s \r', hdl6);
hdl7 = ' <meta lastmodifieddate="2009−03−20">';
fprintf(fid, '%s \r', hdl7);
hdl8 = '   <creator>Gephi.org</creator>';
fprintf(fid, '%s \r', hdl8);
hdl9 = '   <description>A Gephi file generated by Xi-Nian Zuo</description>';
fprintf(fid, '%s \r', hdl9);
hdl10 = '   <keywords>Gephi, Graph, Network</keywords>';
fprintf(fid, '%s \r', hdl10);
hdl11 = '  </meta>';
fprintf(fid, '%s \r', hdl11);
if arcs
	hdl12 = ' <graph defaultedgetype="directed">';
else
	hdl12 = ' <graph defaultedgetype="undirected">';
end
fprintf(fid, '%s \r', hdl12);
if strcmp(view, '3D')
    [dmn_sph_theta, dmn_sph_phi] = cart2sph(coords3D(:,1), coords3D(:,2), coords3D(:,3));
    hdl13 = ' <attributes class="node" mode="static">';
    fprintf(fid, '%s \r', hdl13);
    hdl14 = '  <attribute id="latitude" title="latitude" type="double"></attribute>';
    fprintf(fid, '%s \r', hdl14);
    hdl15 = '  <attribute id="longitude" title="longitude" type="double"></attribute>';
    fprintf(fid, '%s \r', hdl15);
    hdl16 = ' </attributes>';
    fprintf(fid, '%s \r', hdl16);
end
% NODES
fprintf(fid, '  <nodes> \r');
for ii = 1:N
	ndl = ['   <node id="' num2str(ii-1) '" label="' labels{ii} '">'];
    fprintf(fid, '%s \r', ndl);
    if ii < 5
        ndlcolor = '     <viz:color r="0" g="255" b="0" a="0.5"/>';%dMPFC subsystem
    elseif ii > 6
        ndlcolor = '     <viz:color r="0" g="0" b="255" a="0.5"/>';%MTL subsystem
    else
        ndlcolor = '     <viz:color r="255" g="0" b="0" a="0.5"/>';%aMPFC-PCC core
    end
    fprintf(fid, '%s \r', ndlcolor);
    switch view
        case '3D'
            ndlatt = '     <attvalues>';
            fprintf(fid, '%s \r', ndlatt);
            attval = ['      <attvalue for="latitude" value="' num2str(dmn_sph_theta(ii)*180/pi) '"/>'];
            fprintf(fid, '%s \r', attval);
            attval = ['      <attvalue for="longitude" value="' num2str(dmn_sph_phi(ii)*180/pi) '"/>'];
            fprintf(fid, '%s \r', attval);
            ndlatt = '     </attvalues>';
            fprintf(fid, '%s \r', ndlatt);
        case '2D'
            ndlposition = ['     <viz:position x="' num2str(coords(ii,1)) ...
                '" y="' num2str(coords(ii,2)) '" z="0"/>'];
    end
    if ~strcmp(view, '3D')
        fprintf(fid, '%s \r', ndlposition);
    end
    ndlsize = ['     <viz:size value="' num2str(node_size(ii)) '"/>'];
    fprintf(fid, '%s \r', ndlsize);
    fprintf(fid, '    </node> \r');
end
fprintf(fid, '   </nodes> \r');
%% EDGES
fprintf(fid, '  <edges> \r');
k=1;
for ii = 1:N
    for jj = 1:N
        if CIJ(ii,jj) ~= 0
			edl = ['   <edge id="' num2str(k-1) '" source="' num2str(ii-1) '" target="' ...
                num2str(jj-1) '" weight="' num2str(CIJ(ii,jj)) '" />'];
            fprintf(fid, '%s \r', edl);
			k = k + 1;
        end
    end
end
%% CLOSE
fprintf(fid, '  </edges> \r');
fprintf(fid, ' </graph> \r');
fprintf(fid, '</gexf> \r');
fclose(fid);
