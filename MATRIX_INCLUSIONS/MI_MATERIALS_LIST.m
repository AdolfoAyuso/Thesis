% If 'procedure' in MI_CALLER is 1, it uses this table:

% Units: [Cp km/s], [Cs km/s], [rho gr/cm3]

materiales =[...         
2.63	1.32	1.16;		%	1. PMMA		
2.64    1.20    1.202;      %   2. Epon 828Z epoxy
2.21	0.86	11.3;		%	3. Plomo				 
5.94	3.22	7.80;		%	4. Steel                    
0.00	0.00	0.00;		%	5. Vacio				 
2.64	1.198	1.19;		%	6. Epoxy	Termo			 
5.90	3.83	2.78;		%	7. Talc	de	Luzenac		 
6.05	4.09	2.65;		%	8. Cuarzo	Plutonico		 
6.17	3.73	3.30;		%	9. Biotita				 
7.34	3.96	2.93;		%	10. Dolomita				 
6.64	3.44	2.71;		%	11 Calcita	Cabonato			 
6.05	4.10	2.65;		%	12 Arena				 
1.1215	0.614	2.65;		%	13 Arcilla	
5.63	3.48	2.64;		%	14 Quarcita	
1.50	0.00	1.04;		%	15 liquido	(Agua salada)			 
1.2991	0.00	0.9725;		%	16 Heavy	Oil					 
0.50523	0.00	0.0517;		%	17 Gas seco (Metano)				 
0.387	0.00	0.0934;		%	18 Aire				 
2.25	1.45	1.30;		%	19 Kerogeno		
1.926   0.001    1.26;      %   20 Glycerina
3.5 	  2.10	2.15;       %   21 Ficticio
5.52    3.5626  2.6;        %   22 Chinos 
3.91    2.2500   2.2;       %   23 Olfato 2  Berea
5.52    3.4600   2.21;      %   24
0.02811 0.0152   1.3;       %   25 Hules2
1.46642 0.0173   1.0;       %   26 Agua  fjs
0.022   0.0050   1.3;       %   27 Silicon
6.3344 6.3245 8;            %   28 Strong Proposal 
1.7056 1.4142 1.1;          %   29 Intermediate Proposal 1
1.3484 0.9535 1.1;          %   30 Intermediate Proposal 2
1.0444 0.4264 1.1;          %   31 Intermediate Proposal 3
0.9629 0.1348 1.1;          %   32 Intermediate Proposal 4
2.8671 2.7153 1.18;         %   33 Matrix Proposal 
9.0000 6.0000 8];           %   34

% Else, if it is 2, it uses this table:

% Units: [k GPa],  [mu GPa],  [rho g/cm^3]

materiales2 =[...         
5.9670e-04,	3.2500e-05,	1.3;		%1 Silicon		
6.6466, 1.7309, 1.2020;             %2 Epon 828Z epoxy
46.8329, 8.3575, 11.3000;           %3 Lead
6, 8.7, 1.18; %4 Amarillo
6, 2.2, 1.10; %5 Negro 1
6, 1.0, 1.10; %6 Negro 2
6, 0.2, 1.10; %7 Negro 3
6, 0.02, 1.10;%8 Negro 4
500, 320, 8; %9 Rojo
1, 0.002, 1.10;%10 Negro 5
42.64, 8.7, 1.18; %11 Amarillo k~=1
4.4, 2.2, 1.10; %12 Negro 1 k~=1
4, 1.0, 1.10; %13 Negro 2 k~=1
0.4, 0.2, 1.10; %14 Negro 3 k~=1
0.04, 0.02, 1.10;%15 Rojo 4 k~=1
590.9, 320, 8; %16 Rojo k~=1
0.004, 0.002, 1.10; %17 Negro 5 k~=1
25.0725, 8.3575, 11.3000]; %18 test
