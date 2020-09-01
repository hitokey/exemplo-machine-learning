clc;
clear;

x = [ 1.0 1.0
      1.1 1.5
      2.5 1.7
      1.0 2.0
      0.3 1.4
      2.8 1.0
      0.8 1.5
      2.5 0.5
      2.3 1.0
      0.5 1.1
      1.9 1.3
      2.0 0.9
      0.5 1.8
      2.1 0.6];
      
t = [1 1 -1 1 1 -1 1 -1 -1 1 -1 -1 1 -1];
/*
clf();
set(gca(), "auto_scale", "on");
set(gca(), "data_bounds", [-3,-3; 3,3]);
title("Dados trabalho 2");
xlabel("s1");
ylabel("s2");
da=gda();
da.y_location="origin";
da.x_location="origin";
for point=1:14
    if t(point)==1
       plot(x(point,1),x(point,2), 'bpentagram');
    else
       plot(x(point,1),x(point,2), 'rpentagram');
    end
end
*/
wa = 0.5 - rand(1,2,"uniform");
ba = 0.5 - rand();
teta =0;
alfa = 0.4;
ncli=300;
ciclos=0;
mprintf("Train");
while ciclos<ncli
    erroq = 0;
    ciclos=ciclos+1;
    for inp = 1:14
        yl = wa(1)*x(inp,1)+wa(2)*x(inp,2)+ba;
        y=yl;
        erroq = erroq+(t(inp)-y)^2;
        wn(1)=wa(1)+alfa*(t(inp)-y)*x(inp,1);
        wn(2)=wa(2)+alfa*(t(inp)-y)*x(inp,2);
        bn = ba + alfa*(t(inp)-y);
        wa=wn;
        ba=bn
    end
    //plot(ciclos,erroq,'r*');
    
end
mprintf('Wn: %d %d - bn %d\n', wn(1),wn(2),bn);
mprintf('Test');
for inp=1:14
    yl = wn(1)*x(inp,1)+wn(2)*x(inp,2)+bn;
    if yl >= teta
        y=1;
    else
        y=-1;
    end
    mprintf('t(%d)= %d %d\n',inp,t(inp),y)
end
/*
for abc = -3:0.1:3
    ord = (-abc*wn(1)-bn)/wn(2);
    plot(abc,ord,'g.');
end
*/
