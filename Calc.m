function [Vol,A,dx,dy,Px,Py,X,Y,Z] = Calc(F,x,y,xdiv,ydiv)
% Funcion que realiza los calculos correspondientes del volumen y los
% puntos considerados para el calculo

    Fxy(x,y)=F;

    %Calculo de puntos
    Px=zeros(xdiv,ydiv);
    Py=zeros(xdiv,ydiv);
    for i=1:1:xdiv
        for j=1:1:ydiv
            Px(i,j)= x(i) + (x(i+1)-x(i)).*rand(1,1); %Puntos en x
            Py(i,j)= y(j) + (y(j+1)-y(j)).*rand(1,1); %Puntos en y
        end
    end
     
    %Suma de puntos
    s=0;
    for i=1:1:xdiv
        for j=1:1:ydiv
            s=double(Fxy(Px(i,j),Py(i,j)))+s; %Puntos evaluados en la funci�n
        end
    end
    
    dx = diff([x(1) x(2)]); %Base de regi�n
    dy = diff([y(1) y(2)]); %Largo de regi�n
    A = dx.*dy; %�rea de la regi�n 
    Vol = s.*A; %Volumen aproximado bajo la funci�n
    
    if size(x,2) == size(y,2)
        n=size(x,2);
    elseif size(x,2) > size(y,2)
        n=size(x,2);
        aux=zeros(1,n);
        aux(1,1:n)=min(y);
        aux(1,1:size(y,2))=y;
        y=aux;
    elseif size(y,2) > size(x,2)
        n=size(y,2);
        aux=zeros(1,n);
        aux(1,1:n)=min(x);
        aux(1,1:size(x,2))=x;
        x=aux;
    end
    [X,Y] = meshgrid(x,y);
    Z = zeros(n);

end

