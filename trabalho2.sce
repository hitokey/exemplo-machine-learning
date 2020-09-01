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

mprintf("Train\n");

wa=[0 0];
ba = 0;

wn = wa;
bn = ba;
teta = 0;
alfa = 1;
tp = 1;
ccli = 0;

while tp == 1
    tp = 0;
    ccli = ccli+1;
    mprintf("Ciclos: %d\n", ccli);
    for inp=1:14
        yl = wa(1)*x(inp,1)+wa(2)*x(inp,2)+ba;
        if yl >= teta
            y=1;
        else
            y=-1;
        end
        if y~= t(inp)
            tp=1;
            wn(1) = wa(1) + alfa*x(inp,1)*t(inp);
            wn(2) = wa(2) + alfa*x(inp,2)*t(inp);
            bn=ba+alfa*t(inp);
            wa=wn;
            ba=bn;
        end
    end
    mprintf('Wn: %d %d - bn %d\n', wn,bn);
end

mprintf('Test\n');

for inp=1:14
    yl = wa(1)*x(inp,1)+wa(2)*x(inp,2)+ba;
    if yl >= teta
        y=1;
    else
        y=-1;
    end
    mprintf('t(%d)= %d y= %d\n',inp,t(inp),y);
end

for abc=-3:0.1:3
    ord = (-abc*wn(1)-bn)/wn(2);
    plot(abc,ord,'g.');
end
