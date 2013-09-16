function varargout = tankGUI(varargin)
% TANKGUI MATLAB code for tankGUI.fig
%      TANKGUI, by itself, creates a new TANKGUI or raises the existing
%      singleton*.
%
%      H = TANKGUI returns the handle to a new TANKGUI or the handle to
%      the existing singleton*.
%
%      TANKGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TANKGUI.M with the given input arguments.
%
%      TANKGUI('Property','Value',...) creates a new TANKGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tankGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tankGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tankGUI

% Last Modified by GUIDE v2.5 05-Mar-2013 17:27:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tankGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @tankGUI_OutputFcn, ...
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

function model_open(handles)
% Make sure the diagram is still open
  if  isempty(find_system('Name','quadtank')),
    open_system('quadtank'); open_system('quadtank/Tank controller')
    open_system('quadtank/QuadTank')
    
  


  %  set_param('f14/Controller/Gain','Position',[275 14 340 56])
   % figure(handles.F14ControllerEditor)
    % Put  values of Kf and Ki from the GUI into the Block dialogs
   % set_param('f14/Controller/Gain','Gain',...
    %                        get(handles.KfCurrentValue,'String'))
   % set_param('f14/Controller/Proportional plus integral compensator',...
     %         'Numerator',...
      %        get(handles.KiCurrentValue,'String'))
  end


% --- Executes just before tankGUI is made visible.
function tankGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tankGUI (see VARARGIN)

% Choose default command line output for tankGUI
val=get(handles.popupmenu1,'Value');
mpc_prob=tankinformation(val);
  assignin('base', 'mpc_prob', mpc_prob);

handles.output = hObject;

  model_open(handles)
% Update handles structure
guidata(hObject, handles);
set_param('quadtank/Tank controller/reference/reset_ref','Value',num2str(0))
% UIWAIT makes tankGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
mpc_prob = evalin('base','mpc_prob');
set(handles.ref_h1, 'String', num2str(mpc_prob.ref.h1))
set(handles.ref_h2, 'String', num2str(mpc_prob.ref.h2))
set(handles.ref_h3, 'String', num2str(mpc_prob.ref.h3))
set(handles.ref_h4, 'String', num2str(mpc_prob.ref.h4))
set(handles.ref_q_a, 'String', num2str(mpc_prob.ref.q_a))
set(handles.ref_q_b, 'String', num2str(mpc_prob.ref.q_b))


set(handles.h1_0, 'String', num2str(mpc_prob.init.h1))
set(handles.h2_0, 'String', num2str(mpc_prob.init.h2))
set(handles.h3_0, 'String', num2str(mpc_prob.init.h3))
set(handles.h4_0, 'String', num2str(mpc_prob.init.h4))
set(handles.q_a_0, 'String', num2str(mpc_prob.init.q_a))
set(handles.q_b_0, 'String', num2str(mpc_prob.init.q_b))


 h1=str2num(get(handles.ref_h1,'String'))
 h2=str2num(get(handles.ref_h2,'String'))
 h3=str2num(get(handles.ref_h3,'String'))
 h4=str2num(get(handles.ref_h4,'String'))
 q_a=str2num(get(handles.ref_q_a,'String'))
 q_b=str2num(get(handles.ref_q_b,'String'))

 
 x_ref=[h1;h2;h3;h4];
 u_ref=[q_a;q_b];
 [x_e , u_e]=equilibrium(x_ref,u_ref);
  set(handles.edit1, 'String', num2str(x_e(1)))
 set(handles.edit2, 'String', num2str(x_e(2)))
 set(handles.edit3, 'String', num2str(x_e(3)))
 set(handles.edit4, 'String', num2str(x_e(4)))
 set(handles.edit5, 'String', num2str(u_e(1)))
 set(handles.edit6, 'String', num2str(u_e(2)))

 set_param('quadtank/Tank controller/reference/h1','Value',num2str(mpc_prob.ref.h1))
 set_param('quadtank/Tank controller/reference/h2','Value',num2str(mpc_prob.ref.h2))
 set_param('quadtank/Tank controller/reference/h3','Value',num2str(mpc_prob.ref.h3))
 set_param('quadtank/Tank controller/reference/h4','Value',num2str(mpc_prob.ref.h4))
 set_param('quadtank/Tank controller/reference/q_a','Value',num2str(mpc_prob.ref.q_a))
 set_param('quadtank/Tank controller/reference/q_b','Value',num2str(mpc_prob.ref.q_b))
 set_param('quadtank/Tank controller/reference/reset_ref','Value',num2str(0))
 set_param('quadtank/QuadTank/h1_ref','Value',num2str(mpc_prob.ref.h1))
 set_param('quadtank/QuadTank/h2_ref','Value',num2str(mpc_prob.ref.h2))
 set_param('quadtank/QuadTank/h3_ref','Value',num2str(mpc_prob.ref.h3))
 set_param('quadtank/QuadTank/h4_ref','Value',num2str(mpc_prob.ref.h4))
 
  set_param('quadtank/QuadTank/h1_eq','Value',num2str(x_e(1)))
 set_param('quadtank/QuadTank/h2_eq','Value',num2str(x_e(2)))
 set_param('quadtank/QuadTank/h3_eq','Value',num2str(x_e(3)))
 set_param('quadtank/QuadTank/h4_eq','Value',num2str(x_e(4)))
 



% --- Outputs from this function are returned to the command line.
function varargout = tankGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
model_open(handles)




% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
model_open(handles)


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%set(handles.edit1, 'String', num2str(mpc_prob.ref.h1))


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset_references.
function reset_references_Callback(hObject, eventdata, handles)
  model_open(handles)
   %ref1= get(handles.edit1,'String')
 %  set_param('example/References/h1','Constant value',str2num(get(handles.edit1,'String')))
 h1=str2num(get(handles.ref_h1,'String'))
 h2=str2num(get(handles.ref_h2,'String'))
 h3=str2num(get(handles.ref_h3,'String'))
 h4=str2num(get(handles.ref_h4,'String'))
 q_a=str2num(get(handles.ref_q_a,'String'))
 q_b=str2num(get(handles.ref_q_b,'String'))
 mpc_prob.ref.h1=h1;
 mpc_prob.ref.h2=h2;
 x_ref=[h1;h2;h3;h4];
 u_ref=[q_a;q_b];
 [x_e , u_e]=equilibrium(x_ref,u_ref);
 set(handles.edit1, 'String', num2str(x_e(1)))
 set(handles.edit2, 'String', num2str(x_e(2)))
 set(handles.edit3, 'String', num2str(x_e(3)))
 set(handles.edit4, 'String', num2str(x_e(4)))
 set(handles.edit5, 'String', num2str(u_e(1)))
 set(handles.edit6, 'String', num2str(u_e(2)))
 set_param('quadtank/Tank controller/reference/h1','Value',num2str(h1))
 set_param('quadtank/Tank controller/reference/h2','Value',num2str(h2))
 set_param('quadtank/Tank controller/reference/h3','Value',num2str(h3))
 set_param('quadtank/Tank controller/reference/h4','Value',num2str(h4))
 set_param('quadtank/Tank controller/reference/q_a','Value',num2str(q_a))
 set_param('quadtank/Tank controller/reference/q_b','Value',num2str(q_b))
  set_param('quadtank/Tank controller/reference/reset_ref','Value',num2str(1))
   set_param('quadtank/QuadTank/h1_ref','Value',num2str(h1))
 set_param('quadtank/QuadTank/h2_ref','Value',num2str(h2))
 set_param('quadtank/QuadTank/h3_ref','Value',num2str(h3))
 set_param('quadtank/QuadTank/h4_ref','Value',num2str(h4))
   set_param('quadtank/QuadTank/h1_eq','Value',num2str(x_e(1)))
 set_param('quadtank/QuadTank/h2_eq','Value',num2str(x_e(2)))
 set_param('quadtank/QuadTank/h3_eq','Value',num2str(x_e(3)))
 set_param('quadtank/QuadTank/h4_eq','Value',num2str(x_e(4)))
 
disp('reference is true')

 
 
   %set_param('example/Gain','Gain',(get(handles.edit1,'String')))
   %set_param('example/References/h1','Value',(get(handles.edit1,'String')))
   %set_param('example/References/h2','Value',(get(handles.edit1,'String')))

% hObject    handle to reset_references (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
 model_open(handles)
 val=get(handles.popupmenu1,'Value')
mpc_prob = evalin('base','mpc_prob');
mpc_prob=tankinformation(val);
 
 
set_param('quadtank/Tank controller/reference/reset_ref','Value',num2str(0))
set(handles.h1_0,'Enable','inactive');
set(handles.h2_0,'Enable','inactive');
set(handles.h3_0,'Enable','inactive');
set(handles.h4_0,'Enable','inactive');
set(handles.q_a_0,'Enable','inactive');
set(handles.q_b_0,'Enable','inactive');
set(handles.popupmenu1,'Enable','off');

h1=str2num(get(handles.ref_h1,'String'))
 h2=str2num(get(handles.ref_h2,'String'))
 h3=str2num(get(handles.ref_h3,'String'))
 h4=str2num(get(handles.ref_h4,'String'))
 q_a=str2num(get(handles.ref_q_a,'String'))
 q_b=str2num(get(handles.ref_q_b,'String'))
 
 
 h1_0=str2num(get(handles.h1_0,'String'))
 h2_0=str2num(get(handles.h2_0,'String'))
 h3_0=str2num(get(handles.h3_0,'String'))
 h4_0=str2num(get(handles.h4_0,'String'))
 q_a_0=str2num(get(handles.q_a_0,'String'))
 q_b_0=str2num(get(handles.q_b_0,'String'))
 h_0=[h1_0;h2_0;h3_0;h4_0];
 q_0=[q_a_0;q_b_0];
 mpc_prob.x_init=h_0-mpc_prob.xlin;
 mpc_prob.u_init=q_0-mpc_prob.ulin;
 mpc_prob.init.h1=h1_0;
 mpc_prob.init.h2=h2_0;
 mpc_prob.init.h3=h3_0;
 mpc_prob.init.h4=h4_0;
 mpc_prob.init.q_a=q_a_0;
 mpc_prob.init.q_b=q_b_0;
 
 
 mpc_prob.ref.h1=h1;
 mpc_prob.ref.h2=h2;
  mpc_prob.ref.h3=h3;
 mpc_prob.ref.h4=h4;
  mpc_prob.ref.q_a=q_a;
 mpc_prob.ref.q_b=q_b;
 mpc_prob.xref=[h1;h2;h3;h4]-mpc_prob.xlin;
 mpc_prob.uref=[q_a;q_b]-mpc_prob.ulin;
  mpc_prob=compute_QP(mpc_prob);
  assignin('base', 'mpc_prob', mpc_prob);
 x_ref=[h1;h2;h3;h4];
 u_ref=[q_a;q_b];
 [x_e , u_e]=equilibrium(x_ref,u_ref);
  set(handles.edit1, 'String', num2str(x_e(1)))
 set(handles.edit2, 'String', num2str(x_e(2)))
 set(handles.edit3, 'String', num2str(x_e(3)))
 set(handles.edit4, 'String', num2str(x_e(4)))
 set(handles.edit5, 'String', num2str(u_e(1)))
 set(handles.edit6, 'String', num2str(u_e(2)))
 set_param('quadtank/Tank controller/reference/h1','Value',num2str(h1))
 set_param('quadtank/Tank controller/reference/h2','Value',num2str(h2))
 set_param('quadtank/Tank controller/reference/h3','Value',num2str(h3))
 set_param('quadtank/Tank controller/reference/h4','Value',num2str(h4))
 set_param('quadtank/Tank controller/reference/q_a','Value',num2str(q_a))
 set_param('quadtank/Tank controller/reference/q_b','Value',num2str(q_b))
   set_param('quadtank/QuadTank/h1_ref','Value',num2str(h1))
 set_param('quadtank/QuadTank/h2_ref','Value',num2str(h2))
 set_param('quadtank/QuadTank/h3_ref','Value',num2str(h3))
 set_param('quadtank/QuadTank/h4_ref','Value',num2str(h4))
   set_param('quadtank/QuadTank/h1_eq','Value',num2str(x_e(1)))
 set_param('quadtank/QuadTank/h2_eq','Value',num2str(x_e(2)))
 set_param('quadtank/QuadTank/h3_eq','Value',num2str(x_e(3)))
 set_param('quadtank/QuadTank/h4_eq','Value',num2str(x_e(4)))

%states_mem=[];
  %assignin('base', 'states_mem', states_mem);
options=simset('SrcWorkspace','base','DstWorkspace','base');
sim('quadtank',[0 50],options)
 %sim('quadtank')
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
 model_open(handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set_param('quadtank','SimulationCommand','stop');
set(handles.h1_0,'Enable','on');
set(handles.h2_0,'Enable','on');
set(handles.h3_0,'Enable','on');
set(handles.h4_0,'Enable','on');
set(handles.q_a_0,'Enable','on');
set(handles.q_b_0,'Enable','on');
set(handles.popupmenu1,'Enable','on');






% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
 model_open(handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set_param('quadtank','SimulationCommand','pause');

% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function h1_0_Callback(hObject, eventdata, handles)
% hObject    handle to h1_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h1_0 as text
%        str2double(get(hObject,'String')) returns contents of h1_0 as a double
  model_open(handles)
val=str2double(get(hObject,'String'))

if(val>0.60)||(val==NaN)
    val=0.60;
   set(handles.h1_0,'String',num2str(val));
end
%mpc_prob.init.h1=val;
%{
v=evalin('base', 'mpc_prob');
v.x_init(1)=val-v.xlin(1);
v.init.h1=val;
assignin('base', 'mpc_prob', v);
%mpc_prob.x_init(1)=val-mpc_prob.xlin(1);
%}
% --- Executes during object creation, after setting all properties.
function h1_0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h1_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h2_0_Callback(hObject, eventdata, handles)
% hObject    handle to h2_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h2_0 as text
%        str2double(get(hObject,'String')) returns contents of h2_0 as a double
%{
val=str2double(get(hObject,'String'));
  model_open(handles)
if(val>0.60)
    val=0.60;
   set(handles.h2_0,'String',num2str(val));
end
v=evalin('base', 'mpc_prob');
v.x_init(2)=val-v.xlin(2);
v.init.h2=val;
assignin('base', 'mpc_prob', v);
%}

% --- Executes during object creation, after setting all properties.
function h2_0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h2_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h3_0_Callback(hObject, eventdata, handles)
% hObject    handle to h3_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h3_0 as text
%        str2double(get(hObject,'String')) returns contents of h3_0 as a double
%{
val=str2double(get(hObject,'String'));
  model_open(handles)
if(val>0.60)
    val=0.60;
   set(handles.h3_0,'String',num2str(val));
end
v=evalin('base', 'mpc_prob');
v.x_init(3)=val-v.xlin(3);
v.init.h3=val;
assignin('base', 'mpc_prob', v);
%}

% --- Executes during object creation, after setting all properties.
function h3_0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h3_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h4_0_Callback(hObject, eventdata, handles)
% hObject    handle to h4_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h4_0 as text
%        str2double(get(hObject,'String')) returns contents of h4_0 as a double
val=str2double(get(hObject,'String'));
  model_open(handles)
if(val>0.60)
    val=0.60;
   set(handles.h4_0,'String',num2str(val));
end
v=evalin('base', 'mpc_prob');
v.x_init(4)=val-v.xlin(4);
v.init.h4=val;
assignin('base', 'mpc_prob', v);

% --- Executes during object creation, after setting all properties.
function h4_0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h4_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_a_0_Callback(hObject, eventdata, handles)
% hObject    handle to q_a_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_a_0 as text
%        str2double(get(hObject,'String')) returns contents of q_a_0 as a double

%{
val=str2double(get(hObject,'String'));
  model_open(handles)
if(val>0.39)
    val=0.39;
   set(handles.q_a_0,'String',num2str(val));
end
v=evalin('base', 'mpc_prob');
v.u_init(1)=val-v.ulin(1);
v.init.q_a=val;
assignin('base', 'mpc_prob', v);
%}

% --- Executes during object creation, after setting all properties.
function q_a_0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_a_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function q_b_0_Callback(hObject, eventdata, handles)
% hObject    handle to q_b_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of q_b_0 as text
%        str2double(get(hObject,'String')) returns contents of q_b_0 as a double
%{
val=str2double(get(hObject,'String'));
  model_open(handles)
if(val>0.39)
    val=0.39;
   set(handles.q_b_0,'String',num2str(val));
end
v=evalin('base', 'mpc_prob');
v.u_init(2)=val-v.ulin(2);
v.init.q_b=val;
assignin('base', 'mpc_prob', v);
%}

% --- Executes during object creation, after setting all properties.
function q_b_0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to q_b_0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ref_h1_Callback(hObject, eventdata, handles)
% hObject    handle to ref_h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ref_h1 as text
%        str2double(get(hObject,'String')) returns contents of ref_h1 as a double
val=str2double(get(hObject,'String'));
  model_open(handles)
if(val>0.60)
    val=0.60;
   set(handles.ref_h1,'String',num2str(val));
end

% --- Executes during object creation, after setting all properties.
function ref_h1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ref_h2_Callback(hObject, eventdata, handles)
% hObject    handle to ref_h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ref_h2 as text
%        str2double(get(hObject,'String')) returns contents of ref_h2 as a double
val=str2double(get(hObject,'String'));
  model_open(handles)
if(val>0.60)
    val=0.60;
   set(handles.ref_h2,'String',num2str(val));
end

% --- Executes during object creation, after setting all properties.
function ref_h2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ref_h3_Callback(hObject, eventdata, handles)
% hObject    handle to ref_h3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ref_h3 as text
%        str2double(get(hObject,'String')) returns contents of ref_h3 as a double
val=str2double(get(hObject,'String'));
  model_open(handles)
if(val>0.60)
    val=0.60;
   set(handles.ref_h3,'String',num2str(val));
end

% --- Executes during object creation, after setting all properties.
function ref_h3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_h3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ref_h4_Callback(hObject, eventdata, handles)
% hObject    handle to ref_h4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ref_h4 as text
%        str2double(get(hObject,'String')) returns contents of ref_h4 as a double
val=str2double(get(hObject,'String'));
  model_open(handles)
if(val>0.60)
    val=0.60;
   set(handles.ref_h4,'String',num2str(val));
end

% --- Executes during object creation, after setting all properties.
function ref_h4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_h4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ref_q_a_Callback(hObject, eventdata, handles)
% hObject    handle to ref_q_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ref_q_a as text
%        str2double(get(hObject,'String')) returns contents of ref_q_a as a double
val=str2double(get(hObject,'String'));
  model_open(handles)
if(val>0.39)
    val=0.39;
   set(handles.ref_q_a,'String',num2str(val));
end

% --- Executes during object creation, after setting all properties.
function ref_q_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_q_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ref_q_b_Callback(hObject, eventdata, handles)
% hObject    handle to ref_q_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ref_q_b as text
%        str2double(get(hObject,'String')) returns contents of ref_q_b as a double
val=str2double(get(hObject,'String'));
  model_open(handles)
if(val>0.39)
    val=0.39;
   set(handles.ref_q_b,'String',num2str(val));
end

% --- Executes during object creation, after setting all properties.
function ref_q_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ref_q_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

val=get(hObject,'Value')
mpc_prob = evalin('base','mpc_prob');
mpc_prob=tankinformation(val)
assignin('base', 'mpc_prob', mpc_prob);
mpc_prob

%{
if(val=='PCDM')
    option=3;
end
if(val=='ADMM')
    option=1;
end
if(val=='DDECOMP')
    option=2;
end
option
%}

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Results.
function Results_Callback(hObject, eventdata, handles)
% hObject    handle to Results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mpc_prob=evalin('base','mpc_prob');
states=evalin('base','states_mem');
eq_points=evalin('base','states_eq');
ref_points=evalin('base','ref_mem');
inputs=evalin('base','inputs');
t=evalin('base','tout');
disp('these are the states')

state_ub=[];
state_lb=[];
state_lb=[state_lb;mpc_prob.constr(1).lb_x+mpc_prob.xlin(1:2)];
state_lb=[state_lb;mpc_prob.constr(2).lb_x+mpc_prob.xlin(3:4)];
state_ub=[state_ub;mpc_prob.constr(1).ub_x+mpc_prob.xlin(1:2)];
state_ub=[state_ub;mpc_prob.constr(2).ub_x+mpc_prob.xlin(3:4)];


input_lb=zeros(2,1);
input_ub=zeros(2,1);

input_lb(1)=mpc_prob.constr(1).lb_u+mpc_prob.ulin(1);
input_lb(2)=mpc_prob.constr(2).lb_u+mpc_prob.ulin(2);

input_ub(1)=mpc_prob.constr(1).ub_u+mpc_prob.ulin(1);
input_ub(2)=mpc_prob.constr(2).ub_u+mpc_prob.ulin(2);
bound_option=1;
if((mpc_prob.solve_option==4)||(mpc_prob.solve_option==5))
    bound_option=0;
end
states_lb=[];
states_ub=[];
if(bound_option==1)
    for i=1:4
        states_lb=[states_lb ones(length(t),1)*state_lb(i)];
        states_ub=[states_ub ones(length(t),1)*state_ub(i)];
    end
end
inputs_lb=[];
inputs_ub=[];
inputs_lb=[inputs_lb ones(length(t),1)*input_lb(1)];
inputs_lb=[inputs_lb ones(length(t),1)*input_lb(2)];

inputs_ub=[inputs_ub ones(length(t),1)*input_ub(1)];
inputs_ub=[inputs_ub ones(length(t),1)*input_ub(2)];

length(states)
length(t)
length(ref_points)

figure(1)
subplot(6,1,1)
legend('plant states','equilibrium points','reference points')
hold on
axis([t(1) t(end) 0 0.8])
plot(t,states(:,1),'--r')
plot(t,eq_points(:,1),'--g')
plot(t,ref_points(:,1),'--b')
if(bound_option==1)
plot(t,states_lb(:,1),'-.k')
plot(t,states_ub(:,1),'-.k')
end
hold off
subplot(6,1,2)
legend('plant states','equilibrium points','reference points')
hold on
axis([t(1) t(end) 0 0.8])
plot(t,states(:,2),'--r')
plot(t,eq_points(:,2),'--g')
plot(t,ref_points(:,2),'--b')
if(bound_option==1)
plot(t,states_lb(:,2),'-.k')
plot(t,states_ub(:,2),'-.k')
end

hold off
subplot(6,1,3)
hold on
axis([t(1) t(end) 0 0.8])
plot(t,states(:,3),'--r')
plot(t,eq_points(:,3),'--g')
plot(t,ref_points(:,3),'--b')
if(bound_option==1)
plot(t,states_lb(:,3),'-.k')
plot(t,states_ub(:,3),'-.k')
end

hold off
subplot(6,1,4)
hold on
axis([t(1) t(end) 0 0.8])
plot(t,states(:,4),'--r')
plot(t,eq_points(:,4),'--g')
plot(t,ref_points(:,4),'--b')
if(bound_option==1)
plot(t,states_lb(:,4),'-.k')
plot(t,states_ub(:,4),'-.k')
end
hold off

subplot(6,1,5)
hold on
axis([t(1) t(end) 0 0.9])
plot(t,inputs(:,1),'--r')
plot(t,inputs_lb(:,1),'-.k')
plot(t,inputs_ub(:,1),'-.k')
hold off
subplot(6,1,6)
hold on
axis([t(1) t(end) 0 0.9])
plot(t,inputs(:,2),'--r')
plot(t,inputs_lb(:,2),'-.k')
plot(t,inputs_ub(:,2),'-.k')
hold off
