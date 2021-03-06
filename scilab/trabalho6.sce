clc;
clear;

csv = csvRead("sonar.all-data")

x = csv(:,1:60)
t = csv(:,61)

cor = input("INPUT COR: ")
neuinput = 60;
//neuesc = 3 //input('Neuro CM = ');
neuesc = input('Neuro CM = ');
neuout = 1;
//alfa = 0.001 //input('Taxa Learning: ');
alfa = input('Taxa Learning: ');
//erroadm = 0.95 // input('Erro Input: ');
erroadm = input('Erro Input: ');
//nciclo = 500 //input('Entre Ciclo: ');
nciclo = input('Entre Ciclo: ');
v = rand(neuinput,neuesc)-0.5;
bv = rand(neuesc,1)-0.5;
w = rand(neuesc,neuout)-0.5;
bw = rand()-0.5;

xlabel('Ciclos');
ylabel('ErroQ');


ciclo =0;
errot = 10;

mprintf('Train\n')


while (ciclo < nciclo) && (errot > erroadm)
    ciclo=ciclo+1;
    errot =0 ;
    for pad=1:208
        for j=1:neuesc
            zinp(j)=x(pad,:)*v(:,j)+bv(j);
            z(j) = (2/(1+%e^(-zinp(j))))-1;
        end
        yin=z'*w+bw;
        y=(2/1+%e^(-yin))-1;
        deltw = (t(pad)-y)*0.5*(1+y)*(1-y);
        for j=1:neuesc
            deltaw(j)=alfa*deltw*z(j);
        end
        deltbw = alfa*deltw;
        for j=1:neuesc
            deltv(j)=deltw*w(j)*0.5*(1+z(j))*(1-z(j));
        end
        
        for i=1:neuinput
            for j=1:neuesc
                deltav(i,j)=alfa*deltv(j)'*x(pad,i);
            end
        end
        
        for i=1:neuesc
            deltbv(i)=alfa*deltv(i);
        end
        
        w = w+deltaw
        bw = bw+deltbw
        for i=1:neuinput
            for j=1:neuesc
                v(i,j)=v(i,j)+deltav(i,j);
            end
        end
        for i=1:neuesc
            bv(i)=bv(i)+deltbv(i);
        end
        errot=(errot+0.5*((t(pad)-y)^2))/100;
   end
   plot(ciclo,errot,cor');
end

mprintf('Test:\n');
for pad=1:208
    for j=1:neuesc
        zinp(j)=x(pad,:)*v(:,j)+bv(j);
        z(j) = (2/(1+%e^(zinp(j))))-1;
    end
    yin = z'*w+bw
    y=(2/(1+%e^(-yin)))-1;
    if t(pad) == -1
        name = 'M'
    else
        name = 'R'
    end
    mprintf('Target: %s yLin: %f\n',name,y);
end
mprintf('Weights: %f - B: %f - ERROF: %f\n', w, bw, errot)
mprintf('ALL Weight')
disp(w)
