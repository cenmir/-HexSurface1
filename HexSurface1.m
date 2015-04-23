classdef HexSurface1 < matlab.mixin.Copyable
    %HexSurface1 Hexahedral embedded P1 Surface
    %   o = HexSurface1(H, phi, level)
    %   Input:
    %   H               Hex1 mesh object
    %   phi             surface function m-by-1
    %   level           Iso surface level
    % 
    %   Created by Mirza Cenanovic 2015-04-23
    
    properties
        Surface
        Points
        CutElements
        nCutEle
        nele
        nnod
        Connectivity
    end
    
    methods
        
        function o = HexSurface1(H, phi, level)
            %% Check if proper data has been sent
            if ~(isa(H,'Mesh.Hex1'))
                error('Object is not Mesh.Hex1!')
            end
            
            if (length(phi) ~= H.nnod)
                error('Number of elements in phi must match number of vertices')
            end
            
            %% Cut element
            disp('Extracting surface points...')
            tic
            [o.Surface , o.Points, o.CutElements , o.nCutEle  ] = CutP1(H, phi, level);
            toc
            
            %% Triangulate
            [tri,X,surfh] = TriangulateP1(o,H);
            o.Connectivity = tri;
            o.Points = X;
            o.Surface = surfh;
            o.nele = size(tri,1);
            o.nnod = size(X,1);
        end
        
    end
    
end

