function varargout = Practica_3(varargin)
% PRACTICA_3 MATLAB code for Practica_3.fig
%      PRACTICA_3, by itself, creates a new PRACTICA_3 or raises the existing
%      singleton*.
%
%      H = PRACTICA_3 returns the handle to a new PRACTICA_3 or the handle to
%      the existing singleton*.
%
%      PRACTICA_3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRACTICA_3.M with the given input arguments.
%
%      PRACTICA_3('Property','Value',...) creates a new PRACTICA_3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Practica_3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Practica_3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Practica_3

% Last Modified by GUIDE v2.5 01-Jun-2021 21:57:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Practica_3_OpeningFcn, ...
                   'gui_OutputFcn',  @Practica_3_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Practica_3 is made visible.
function Practica_3_OpeningFcn(hObject, eventdata, handles, varargin)
axes(handles.axes1);
bkg=imread('IPN.png');
imshow(bkg);
axes(handles.axes2);
bkg2=imread('UPIITA.png');
imshow(bkg2);

axes(handles.g_fxy);
ax = gca;
plot3(1,1,1,'r.')
grid on
cla
axes(handles.g_cu)
cla
axes(handles.g_zoom)
cla
ax.Color = [0.15 0.15 0.15];
ax.XColor = [1 0.27 0];
ax.YColor = [1 0.27 0];
ax.ZColor = [1 0.27 0];

set(handles.CB_C,'Value',1);
set(handles.CB_P,'Value',1);

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Practica_3_OutputFcn(hObject, eventdata, handles) 


varargout{1} = handles.output;


% --- Executes on button press in B_G.
function B_G_Callback(hObject, eventdata, handles)
global PPx PPy Dx Dy Cc Ff Cx Cy Cz
syms x y

F_xy=size(get(handles.Fxy,'String'),2);
Xmin=size(get(handles.xmin,'String'),2);
Xmax=size(get(handles.xmax,'String'),2);
Ymin=size(get(handles.ymin,'String'),2);
Ymax=size(get(handles.ymax,'String'),2);

if F_xy ~= 0 && Xmin ~= 0 && Xmax ~= 0 && Ymin ~= 0 && Ymax~=0
    P=get(handles.CB_P,'Value');
    Cn=get(handles.CB_C,'Value');
    F_xy=str2sym(get(handles.Fxy,'String'));
    Xmin=str2double(get(handles.xmin,'String'));
    Xmax=str2double(get(handles.xmax,'String'));
    Xdiv=str2double(get(handles.xdiv,'String'));
    Ymin=str2double(get(handles.ymin,'String'));
    Ymax=str2double(get(handles.ymax,'String'));
    Ydiv=str2double(get(handles.ydiv,'String'));

    Xx=linspace(Xmin,Xmax,Xdiv+1);
    Yy=linspace(Ymin,Ymax,Ydiv+1);

    [Vol,A,dx,dy,Px,Py,X,Y,Z,C,F] = Calc(F_xy,Xx,Yy,Xdiv,Ydiv);

    PPx=Px;
    PPy=Py;
    Dx=dx;
    Dy=dy;
    Cx=X;
    Cy=Y;
    Cz=Z;
    Cc=C;
    Ff=F;

    Reg=1;

    Fxy(x,y)=F_xy;
    F_Ev=char(vpa(Fxy(PPx(Reg),PPy(Reg))));

    set(handles.Vol,'String',char(Vol))
    set(handles.DX,'String',num2str(dx))
    set(handles.DY,'String',num2str(dy))
    set(handles.A,'String',num2str(A))
    set(handles.Reg,'String',num2str(Reg))
    set(handles.VolP,'String',char(abs(vpa(Fxy(Px(Reg),Py(Reg))))*A))

    %Grafica 1
    axes(handles.g_fxy);
    ax = gca;   
    cla
    grid on
    hold on
    mesh(Cx,Cy,Cz)
    fmesh(F_xy,[Xmin Xmax Ymin Ymax])
    if P == 1
        plot(Px,Py,'r.','MarkerSize',10)
    end
    if Cn == 1
        fcontour(F_xy,[Xmin Xmax Ymin Ymax])
    end

    %Grafica 2
    axes(handles.g_cu);
    ax = gca;   
    cla
    hold on
    mesh(Cx,Cy,Cz)
    if P == 1
        plot(Px,Py,'r.','MarkerSize',10)
    end
    if Cn == 1
        fcontour(F_xy,[Xmin Xmax Ymin Ymax])
    end

    %Grafica 3
    axes(handles.g_zoom)
    ax = gca;   
    cla
    axis([Cc(Reg) Cc(Reg)+Dx Ff(Reg) Ff(Reg)+Dy]);
    hold on
    mesh(Cx,Cy,Cz)
    plot(Px,Py,'r.','MarkerSize',30)
    if Cn == 1
        fcontour(F_xy,[Xmin Xmax Ymin Ymax])
    end
    set(handles.CPx,'String',mat2str(round(PPx(Reg),6,'significant')))
    set(handles.CPy,'String',mat2str(round(PPy(Reg),6,'significant')))
    set(handles.FEval,'String',F_Ev)
else
    disp("No hay datos")
end

% --- Executes on button press in B_L.
function B_L_Callback(hObject, eventdata, handles)
global PPx PPy Dx Dy Cc Ff Cx Cy Cz

set(handles.A,'String','')
set(handles.DX,'String','')
set(handles.DY,'String','')
set(handles.Fxy,'String','')
set(handles.Vol,'String','')
set(handles.CPx,'String','')
set(handles.CPy,'String','')
set(handles.xmin,'String','')
set(handles.xmax,'String','')
set(handles.ymin,'String','')
set(handles.ymax,'String','')
set(handles.VolP,'String','')
set(handles.Reg,'String','1')
set(handles.FEval,'String','')
set(handles.xdiv,'String','10')
set(handles.ydiv,'String','10')
axes(handles.g_fxy)
cla
axes(handles.g_cu)
cla
axes(handles.g_zoom)
cla

PPx=0;
PPy=0;
Dx=0;
Dy=0;
Cx=0;
Cy=0;
Cz=0;
Cc=0;
Ff=0;

% --- Executes on button press in B_Ls.
function B_Ls_Callback(hObject, eventdata, handles)
global PPx PPy Dx Dy Cc Ff Cx Cy Cz
syms x y

F_xy=size(get(handles.Fxy,'String'),2);
Xmin=size(get(handles.xmin,'String'),2);
Xmax=size(get(handles.xmax,'String'),2);
Ymin=size(get(handles.ymin,'String'),2);
Ymax=size(get(handles.ymax,'String'),2);

if F_xy ~= 0 && Xmin ~= 0 && Xmax ~= 0 && Ymin ~= 0 && Ymax~=0
    Cn=get(handles.CB_C,'Value');
    F_xy=str2sym(get(handles.Fxy,'String'));
    Xmin=str2double(get(handles.xmin,'String'));
    Xmax=str2double(get(handles.xmax,'String'));
    Ymin=str2double(get(handles.ymin,'String'));
    Ymax=str2double(get(handles.ymax,'String'));
    Reg=str2double(get(handles.Reg,'String'));
    Px=transpose(PPx);
    Py=transpose(PPy);
    Fxy(x,y)=F_xy;
    if Reg > 1
        Reg=Reg-1;
        set(handles.Reg,'String',num2str(Reg))
    end
    F_Ev=char(vpa(Fxy(PPx(Reg),PPy(Reg))));
    axes(handles.g_zoom);
    ax = gca;   
    cla
    axis([Cc(Reg) Cc(Reg)+Dx Ff(Reg) Ff(Reg)+Dy]);
    hold on
    mesh(Cx,Cy,Cz)
    plot(Px,Py,'r.','MarkerSize',30)
    if Cn == 1
        fcontour(F_xy,[Xmin Xmax Ymin Ymax])
    end
    set(handles.CPx,'String',mat2str(round(PPx(Reg),6,'significant')))
    set(handles.CPy,'String',mat2str(round(PPy(Reg),6,'significant')))
    set(handles.FEval,'String',F_Ev)
    set(handles.VolP,'String',char(abs(vpa(Fxy(PPx(Reg),PPy(Reg))))*Dx*Dy))
else
    disp("No hay datos")
end


% --- Executes on button press in B_Ps.
function B_Ps_Callback(hObject, eventdata, handles)
global PPx PPy Dx Dy Cc Ff Cx Cy Cz
syms x y

F_xy=size(get(handles.Fxy,'String'),2);
Xmin=size(get(handles.xmin,'String'),2);
Xmax=size(get(handles.xmax,'String'),2);
Ymin=size(get(handles.ymin,'String'),2);
Ymax=size(get(handles.ymax,'String'),2);

if F_xy ~= 0 && Xmin ~= 0 && Xmax ~= 0 && Ymin ~= 0 && Ymax~=0
    Cn=get(handles.CB_C,'Value');
    F_xy=str2sym(get(handles.Fxy,'String'));
    Xmin=str2double(get(handles.xmin,'String'));
    Xmax=str2double(get(handles.xmax,'String'));
    Ymin=str2double(get(handles.ymin,'String'));
    Ymax=str2double(get(handles.ymax,'String'));
    xd=str2double(get(handles.xdiv,'String'));
    yd=str2double(get(handles.ydiv,'String'));
    Reg=str2double(get(handles.Reg,'String'));
    Px=transpose(PPx);
    Py=transpose(PPy);
    Fxy(x,y)=F_xy;
    if Reg < xd*yd
        Reg=Reg+1;
        set(handles.Reg,'String',num2str(Reg))
    end
    F_Ev=char(vpa(Fxy(PPx(Reg),PPy(Reg))));
    axes(handles.g_zoom);
    ax = gca;   
    cla
    mesh(Cx,Cy,Cz)
    axis([Cc(Reg) Cc(Reg)+Dx Ff(Reg) Ff(Reg)+Dy]);
    hold on
    plot(Px,Py,'r.','MarkerSize',30)
    if Cn == 1
        fcontour(F_xy,[Xmin Xmax Ymin Ymax])
    end
    set(handles.CPx,'String',mat2str(round(PPx(Reg),6,'significant')))
    set(handles.CPy,'String',mat2str(round(PPy(Reg),6,'significant')))
    set(handles.FEval,'String',F_Ev)
    set(handles.VolP,'String',char(abs(vpa(Fxy(PPx(Reg),PPy(Reg))))*Dx*Dy))
else
    disp("No hay datos")
end

% --- Executes on button press in CB_P.
function CB_P_Callback(hObject, eventdata, handles)
global PPx PPy Dx Dy Cx Cy Cz Cc Ff
syms x y

F_xy=size(get(handles.Fxy,'String'),2);
Xmin=size(get(handles.xmin,'String'),2);
Xmax=size(get(handles.xmax,'String'),2);
Ymin=size(get(handles.ymin,'String'),2);
Ymax=size(get(handles.ymax,'String'),2);

if F_xy ~= 0 && Xmin ~= 0 && Xmax ~= 0 && Ymin ~= 0 && Ymax~=0
    Cn=get(handles.CB_C,'Value');
    F_xy=str2sym(get(handles.Fxy,'String'));
    Xmin=str2double(get(handles.xmin,'String'));
    Xmax=str2double(get(handles.xmax,'String'));
    Ymin=str2double(get(handles.ymin,'String'));
    Ymax=str2double(get(handles.ymax,'String'));
    xd=str2double(get(handles.xdiv,'String'));
    yd=str2double(get(handles.ydiv,'String'));
    Reg=str2double(get(handles.Reg,'String'));
    Px=transpose(PPx);
    Py=transpose(PPy);
    Fxy(x,y)=F_xy;

    %Grafica 1
    axes(handles.g_fxy);
    ax = gca;   
    cla
    grid on
    hold on
    mesh(Cx,Cy,Cz)
    fmesh(F_xy,[Xmin Xmax Ymin Ymax])
    if hObject.Value == 1
        plot(Px,Py,'r.','MarkerSize',10)
    end
    if Cn == 1
        fcontour(F_xy,[Xmin Xmax Ymin Ymax])
    end

    %Grafica 2
    axes(handles.g_cu);
    ax = gca;   
    cla
    hold on
    mesh(Cx,Cy,Cz)
    if hObject.Value == 1
        plot(Px,Py,'r.','MarkerSize',10)
    end
    if Cn == 1
        fcontour(F_xy,[Xmin Xmax Ymin Ymax])
    end

    %Grafica 3
    axes(handles.g_zoom)
    ax = gca;   
    cla
    axis([Cc(Reg) Cc(Reg)+Dx Ff(Reg) Ff(Reg)+Dy]);
    hold on
    mesh(Cx,Cy,Cz)
    plot(Px,Py,'r.','MarkerSize',30)
    if Cn == 1
        fcontour(F_xy,[Xmin Xmax Ymin Ymax])
    end
else
    disp("No hay datos");
end


% --- Executes on button press in CB_C.
function CB_C_Callback(hObject, eventdata, handles)
global PPx PPy Dx Dy Cx Cy Cz Cc Ff
syms x y

F_xy=size(get(handles.Fxy,'String'),2);
Xmin=size(get(handles.xmin,'String'),2);
Xmax=size(get(handles.xmax,'String'),2);
Ymin=size(get(handles.ymin,'String'),2);
Ymax=size(get(handles.ymax,'String'),2);

if F_xy ~= 0 && Xmin ~= 0 && Xmax ~= 0 && Ymin ~= 0 && Ymax~=0
    P=get(handles.CB_P,'Value');
    F_xy=str2sym(get(handles.Fxy,'String'));
    Xmin=str2double(get(handles.xmin,'String'));
    Xmax=str2double(get(handles.xmax,'String'));
    Ymin=str2double(get(handles.ymin,'String'));
    Ymax=str2double(get(handles.ymax,'String'));
    xd=str2double(get(handles.xdiv,'String'));
    yd=str2double(get(handles.ydiv,'String'));
    Reg=str2double(get(handles.Reg,'String'));
    Px=transpose(PPx);
    Py=transpose(PPy);
    Fxy(x,y)=F_xy;

    %Grafica 1
    axes(handles.g_fxy);
    ax = gca;   
    cla
    grid on
    hold on
    mesh(Cx,Cy,Cz)
    fmesh(F_xy,[Xmin Xmax Ymin Ymax])
    if P == 1
        plot(Px,Py,'r.','MarkerSize',10)
    end
    if hObject.Value == 1
        fcontour(F_xy,[Xmin Xmax Ymin Ymax])
    end

    %Grafica 2
    axes(handles.g_cu);
    ax = gca;   
    cla
    hold on
    mesh(Cx,Cy,Cz)
    if P == 1
        plot(Px,Py,'r.','MarkerSize',10)
    end
    if hObject.Value == 1
        fcontour(F_xy,[Xmin Xmax Ymin Ymax])
    end

    %Grafica 3
    axes(handles.g_zoom)
    ax = gca;   
    cla
    axis([Cc(Reg) Cc(Reg)+Dx Ff(Reg) Ff(Reg)+Dy]);
    hold on
    mesh(Cx,Cy,Cz)
    plot(Px,Py,'r.','MarkerSize',30)
    if hObject.Value == 1
        fcontour(F_xy,[Xmin Xmax Ymin Ymax])
    end
else
    disp("No hay datos");
end


function ymax_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function ymax_CreateFcn(hObject, eventdata, handles)


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ymin_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function ymin_CreateFcn(hObject, eventdata, handles)


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ydiv_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function ydiv_CreateFcn(hObject, eventdata, handles)


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xmin_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function xmin_CreateFcn(hObject, eventdata, handles)


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xmax_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function xmax_CreateFcn(hObject, eventdata, handles)


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xdiv_Callback(hObject, eventdata, handles)


function xdiv_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Fxy_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Fxy_CreateFcn(hObject, eventdata, handles)


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function Vol_CreateFcn(hObject, eventdata, handles)


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

