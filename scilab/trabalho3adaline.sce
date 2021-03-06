clc;
clear;

xx = [0.00 0.50 1.00 1.50 2.00 2.50 3.00 3.50 4.00 4.50 5.00]
yy = [2.26 3.80 4.43 5.91 6.18 7.26 8.15 9.14 10.87 11.58 12.55]


clf();
set(gca(),"auto_scale", "on");
set(gca(),"data_bounds", [-1,-1;7,14]);
title("Dados");
xlabel("X");
ylabel("Y");
dxa=gda();
dxa.y_location="origin";
dxa.x_location="origin";

plot(xx,yy,'bd');

wa = 0.5-rand(1,1,"uniform");
ba = 0.5-rand();

teta = 0;
alfa = 0.01;
nc=50;
cc=0;

mprintf("Train\n");

while cc<=nc
    erroq=0;
    cc=cc+1
    for inp=1:11
        yl=wa*xx(inp)+ba;
        yc=yl;
        erroq=erroq+(yy(inp)-yc)^2;
        wn=wa+alfa*(yy(inp)-yc)*xx(inp);
        bn=ba+alfa*(yy(inp)-yc);
        wa=wn;
        ba=bn;
    end
end

mprintf("y=%fx+%f", wn, bn);
for abc=0:0.1:6
    ord = abc*wn+bn;
    plot(abc,ord,'g.');
end
