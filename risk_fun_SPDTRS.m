
%% risk computing
function risk = risk_fun_SPDTRS(data,label,zeta,Xcell)
% input:   data    the data set mxn
%          label   the decision attribute  mx1
%          zeta    the compesation coefficient   0< <=1
%          delta   the fuzzy neighborhood radius  0<= <=1
%          Xcell   the decision class set
% output:  risk    the global risk of data set
% The information of this paper is:
% M. Suo, L. Tao, B. Zhu, X. Miao, Z. Liang, Y. Ding, X. Zhang, T. Zhang, Single-parameter decision-theoretic rough set, Information Sciences (2020), 
% doi: https://doi.org/10.1016/j.ins.2020.05.12
risk = 0;
m = size(data,1);

P = zeros(m,1);
neighcell = cell(m,1);
interSetNCcell = cell(m,1);
diffSetcell = cell(m,1);
for i = 1:m
    current = data(i,:);
    currentMatrix = repmat(current,m,1); 
    subtractionCurrData = abs(currentMatrix - data); % absulute is to avoid the 0 offset of negative and positive.
    sumSubtraction = sum(subtractionCurrData,2);
    neigh = find(sumSubtraction == 0); % the difference of neighborhood is 0
    neighcell{i} = neigh;
    NC = label(i);
    interSetNCcell{i} = intersect(Xcell{NC,:}, neighcell{i,:});
    diffSetcell{i} = setdiff(neighcell{i}, interSetNCcell{i});
    P(i) = numel(interSetNCcell{i,:})/numel(neighcell{i,:});
end

S = zeros(m,1); % the significance of the sample with respect to its nominal decision class
Sc = zeros(m,1); % the significance of the sample with respect to the compensation decision class
alpha = zeros(m,1);
beta = zeros(m,1);
for i = 1:m
    NC = label(i);
    S(i) = numel(interSetNCcell{i}) / numel(Xcell{NC});
    Sc(i) = numel(diffSetcell{i}) / numel(Xcell{NC});
    if P(i) > zeta && P(i) + zeta < 1
        alpha(i) = ((zeta*S(i) + Sc(i) -zeta*Sc(i)) + sqrt((zeta*S(i) + Sc(i) - zeta*Sc(i))^2 + 4*zeta*Sc(i)*(Sc(i) + S(i)))) / (2*(S(i) + Sc(i)));
        beta(i) = ((2*Sc(i) - zeta*Sc(i) + S(i) + zeta*S(i)) - sqrt((2*Sc(i) - zeta*Sc(i) + S(i) + zeta*S(i))^2 + 4*(S(i) + Sc(i))*(zeta*Sc(i) - Sc(i)))) / (2*(S(i) + Sc(i)));
    elseif P(i) <= zeta && P(i) + zeta < 1
        alpha(i) = 1;
        beta(i) = ((2*Sc(i) - zeta*Sc(i) + S(i)) - sqrt((2*Sc(i) - zeta*Sc(i) + S(i))^2 + 4*Sc(i)*(Sc(i)*zeta - Sc(i)))) / (2*Sc(i));
    elseif P(i) > zeta && P(i) + zeta >= 1
        alpha(i) = ((S(i)*zeta - Sc(i)) + sqrt((S(i)*zeta - Sc(i))^2 + 4*S(i)*Sc(i))) / (2*S(i));
        beta(i) = 0;
    elseif P(i) <= zeta && P(i) + zeta >= 1
        alpha(i) = 1;
        beta(i) = 0;
    end

    if P(i) >= alpha(i)
        r = (1 - P(i))*Sc(i);
        risk = risk + r;
    elseif P(i) <= beta(i)
        r = P(i)*S(i);
        risk = risk + r;
    else
        r1 = P(i)*S(i)*(P(i) - zeta);
        if r1 < 0 % ensure the assumption holding
            r1 = 0;
        end
        r2 = (1 - P(i))*Sc(i)*(1 - P(i) - zeta);
        if r2 < 0
            r2 = 0;
        end
        risk = risk + r1 + r2;
    end
end
