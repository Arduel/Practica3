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

% Last Modified by GUIDE v2.5 31-May-2021 03:55:48

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
cla
ax.Color = [0.15 0.15 0.15];
ax.XColor = [1 0.27 0];
ax.YColor = [1 0.27 0];
ax.ZColor = [1 0.27 0];
grid on

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Practica_3_OutputFcn(hObject, eventdata, handles) 


varargout{1} = handles.output;


% --- Executes on button press in B_G.
function B_G_Callback(hObject, eventdata, handles)
syms x y
F_xy=str2sym(get(handles.Fxy,'String'));
Xmin=str2double(get(handles.xmin,'String'));
Xmax=str2double(get(handles.xmax,'String'));
Xdiv=str2double(get(handles.xdiv,'String'));
Ymin=str2double(get(handles.ymin,'String'));
Ymax=str2double(get(handles.ymax,'String'));
Ydiv=str2double(get(handles.ydiv,'String'));

Xx=linspace(Xmin,Xmax,Xdiv+1);
Yy=linspace(Ymin,Ymax,Ydiv+1);

[Vol,A,dx,dy,Px,Py,X,Y,Z] = Calc(F_xy,Xx,Yy,Xdiv,Ydiv);

%Grafica 1
axes(handles.g_fxy);
ax = gca;   
cla
ax.Color = [0.15 0.15 0.15];
ax.XColor = [1 0.27 0];
ax.YColor = [1 0.27 0];
ax.ZColor = [1 0.27 0];
grid on
hold on
mesh(X,Y,Z)
plot(Px,Py,'r.','MarkerSize',10)
fmesh(F_xy,[Xmin Xmax Ymin Ymax])

%Grafica 2
axes(handles.g_cu);
ax = gca;   
cla
ax.Color = [0.15 0.15 0.15];
ax.XColor = [1 0.27 0];
ax.YColor = [1 0.27 0];
ax.ZColor = [1 0.27 0];
hold on
mesh(X,Y,Z)
plot(Px,Py,'r.','MarkerSize',10)

%Grafica 3
axes(handles.g_zoom);
ax = gca;   
cla
ax.Color = [0.15 0.15 0.15];
ax.XColor = [1 0.27 0];
ax.YColor = [1 0.27 0];
ax.ZColor = [1 0.27 0];
axis([Xx(3)-0.1 Xx(3)+dx+0.1 Yy(3)-0.1 Yy(3)+dy+0.1]);
hold on
mesh(X,Y,Z)
plot(Px,Py,'r.','MarkerSize',20)


% --- Executes on button press in B_L.
function B_L_Callback(hObject, eventdata, handles)
% hObject    handle to B_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in B_Ls.
function B_Ls_Callback(hObject, eventdata, handles)
%


% --- Executes on button press in B_Ps.
function B_Ps_Callback(hObject, eventdata, handles)
%