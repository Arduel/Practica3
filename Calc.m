function [Vol,A,dx,dy,Px,Py,X,Y,Z] = Calc(F,Xx,Yy,xdiv,ydiv)
% Funcion que realiza los calculos correspondientes del volumen y los
% puntos considerados para el calculo
    syms x y
    Fxy(x,y)=F;

    %Calculo de puntos
    Px=zeros(xdiv,ydiv);
    Py=zeros(xdiv,ydiv);
    for i=1:1:xdiv
        for j=1:1:ydiv
            Px(i,j)= Xx(i) + (Xx(i+1)-Xx(i)).*rand(1,1); %Puntos en x
            Py(i,j)= Yy(j) + (Yy(j+1)-Yy(j)).*rand(1,1); %Puntos en y
        end
    end
     
    %Suma de puntos
    s=0;
    for i=1:1:xdiv
        for j=1:1:ydiv
            s=double(Fxy(Px(i,j),Py(i,j)))+s; %Puntos evaluados en la función
        end
    end
    
    dx = diff([Xx(1) Xx(2)]); %Base de región
    dy = diff([Yy(1) Yy(2)]); %Largo de región
    A = dx.*dy; %Área de la región 
    Vol = s.*A; %Volumen aproximado bajo la función
    
    if size(Xx,2) == size(Yy,2)
        n=size(Xx,2);
    elseif size(Xx,2) > size(Yy,2)
        n=size(Xx,2);
        aux=zeros(1,n);
        aux(1,1:n)=min(Yy);
        aux(1,1:size(Yy,2))=Yy;
        Yy=aux;
    elseif size(Yy,2) > size(Xx,2)
        n=size(Yy,2);
        aux=zeros(1,n);
        aux(1,1:n)=min(Xx);
        aux(1,1:size(Xx,2))=Xx;
        Xx=aux;
    end
    [X,Y] = meshgrid(Xx,Yy);
    Z = zeros(n);

end

