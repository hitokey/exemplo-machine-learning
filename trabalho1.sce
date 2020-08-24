// Aluno: Pedro Fernandes
// Hebb rules algorithms. Logic Bipolar.
// 17/08/2020

clc; // clean comand line
clear; // remove variable

// Input Table

s = [ 1  1
     -1  1
      1 -1 
     -1 -1];
     
// Output
t = [[-1 -1 -1 -1] // bits 0000
     [-1 -1 -1  1] // bits 0001
     [-1 -1  1 -1] // bits 0010
     [-1 -1  1  1] // bits 0011
     [-1  1 -1 -1] // bits 0100
     [-1  1 -1  1] // bits 0101
     [-1  1  1 -1] // bits 0110
     [-1  1  1  1] // bits 0111
     [ 1 -1 -1 -1] // bits 1000
     [ 1 -1 -1  1] // bits 1001
     [ 1 -1  1 -1] // bits 1010
     [ 1 -1  1  1] // bits 1011
     [ 1  1 -1 -1] // bits 1100
     [ 1  1 -1  1] // bits 1101
     [ 1  1  1 -1] // bits 1110
     [ 1  1  1  1]] // bits 1111


// train
// initial prices

results = [];
bl = [];
liniar =0
for bit=1:16
    wb = [0,0]; // resetando valores pesos w1 e w2
    b = 0;// resetando valores unitario valor 
    bn = 0; // resetando valores
    wb = [0,0]; // resetando valores
    for inp=1:4 
      x(inp,:)=s(inp,:); //get linha de sources
      y=t(bit,inp); // atribuindo valors de sainda a y
      wn(1)=wb(1)+x(inp,1)*y; // calculando pesos input 1
      wn(2)=wb(2)+x(inp,2)*y; // calculando pesos input 2
      bn = b + y; // atribuindo no valor a base
      wb = wn; // novo valore pesos base
      b = bn; // atualizando valor de base
    end
    bl = lstcat(bl,bn); //amazenado os valores da entrada base
    results=lstcat(results,wn); // amazenando os pesos
end 

// Testando Resultados
for bit=2:17
    wx = results(bit); // get valores dos pesos para um das target
    bx = bl(bit); // get base valor para um dos target
    mprintf('\nTarget binary(%d): Pesos: w1=%d w2=%d\n--------------\n',bit-2,wx(1),wx(2));
    for inp = 1:4
        yl = wx(1)*x(inp,1)+wx(2)*x(inp,2)+bx; // calculando y
        if yl >= liniar // verificado y com linear
            y = 1;
        else
            y = -1;
        end
        // print resultado formatado
        if x(inp,1) == -1
            mprintf('%d',x(inp,1));
        else
            mprintf(' %d',x(inp,1));
        end
        if x(inp,2) == -1
            mprintf('&%d',x(inp,2));
        else
            mprintf('& %d',x(inp,2));
        end
        if y == -1
            mprintf('&%d\\\\\n',y);
        else
            mprintf('& %d\\\\\n',y);
        end
    end

end
