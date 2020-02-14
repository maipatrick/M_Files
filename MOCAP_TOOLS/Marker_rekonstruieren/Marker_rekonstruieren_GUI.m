function varargout = Marker_rekonstruieren_GUI(varargin)
% MARKER_REKONSTRUIEREN_GUI M-file for Marker_rekonstruieren_GUI.fig
%      MARKER_REKONSTRUIEREN_GUI, by itself, creates a new MARKER_REKONSTRUIEREN_GUI or raises the existing
%      singleton*.
%
%      H = MARKER_REKONSTRUIEREN_GUI returns the handle to a new MARKER_REKONSTRUIEREN_GUI or the handle to
%      the existing singleton*.
%
%      MARKER_REKONSTRUIEREN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MARKER_REKONSTRUIEREN_GUI.M with the given input arguments.
%
%      MARKER_REKONSTRUIEREN_GUI('Property','Value',...) creates a new MARKER_REKONSTRUIEREN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Marker_rekonstruieren_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Marker_rekonstruieren_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Marker_rekonstruieren_GUI

% Last Modified by GUIDE v2.5 08-Nov-2013 11:03:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Marker_rekonstruieren_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Marker_rekonstruieren_GUI_OutputFcn, ...
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


% --- Executes just before Marker_rekonstruieren_GUI is made visible.
function Marker_rekonstruieren_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Marker_rekonstruieren_GUI (see VARARGIN)

% Choose default command line output for Marker_rekonstruieren_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Marker_rekonstruieren_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Marker_rekonstruieren_GUI_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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
set(handles.pushbutton3, 'BackgroundColor', 'r');

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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.c3d', 'Daten bitte', 'Z:\Leguano\Vicon\Daten_sortiert_Barfuss\leguano\');
assignin('base', 'filename', filename);
assignin('base', 'pathname', pathname);
set(handles.edit5, 'String', [pathname, filename]);
set(handles.pushbutton3, 'BackgroundColor', 'r');


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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name = get(handles.edit5, 'String');
ustrich = findstr(name, '\');

[filename, pathname] = uigetfile('*.c3d', 'Daten bitte', name(1:ustrich(end)));
set(handles.edit6, 'String', [pathname, filename]);
set(handles.pushbutton3, 'BackgroundColor', 'r');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton3, 'BackgroundColor', 'y');
if get(handles.radiobutton5, 'Value')
    set(handles.pushbutton3, 'BackgroundColor', 'r');
    M1 = char(get(handles.edit1, 'String'));
    M2 = char(get(handles.edit2, 'String'));
    M3 = char(get(handles.edit3, 'String'));
    MR = char(get(handles.edit4, 'String'));
    F_GUT = char(get(handles.edit5, 'String'));
    F_SCHLECHT = char(get(handles.edit6, 'String'));
    changename = get(handles.radiobutton2, 'Value');
    
    assignin('base', 'M1', M1);
    assignin('base', 'M2', M2);
    assignin('base', 'M3', M3);
    assignin('base', 'MR', MR);
    assignin('base', 'F_GUT', F_GUT);
    assignin('base', 'F_SCHLECHT', F_SCHLECHT);
    assignin('base', 'changename', changename);
    
    reconstruct_marker_GUI(F_GUT, F_SCHLECHT, M1, M2, M3, MR, changename);
    set(handles.pushbutton3, 'BackgroundColor', 'g');
else
    filename = get(handles.listbox1, 'String');
    for i = 1:length(filename)
        set(handles.pushbutton3, 'BackgroundColor', 'r');
        M1 = char(get(handles.edit1, 'String'));
        M2 = char(get(handles.edit2, 'String'));
        M3 = char(get(handles.edit3, 'String'));
        MR = char(get(handles.edit4, 'String'));
        F_GUT = char(get(handles.edit5, 'String'));
        F_SCHLECHT = char(filename(i));
        changename = get(handles.radiobutton2, 'Value');
        
        assignin('base', 'M1', M1);
        assignin('base', 'M2', M2);
        assignin('base', 'M3', M3);
        assignin('base', 'MR', MR);
        assignin('base', 'F_GUT', F_GUT);
        assignin('base', 'F_SCHLECHT', F_SCHLECHT);
        assignin('base', 'changename', changename);
        
        reconstruct_marker_GUI(F_GUT, F_SCHLECHT, M1, M2, M3, MR, changename);
        set(handles.pushbutton3, 'BackgroundColor', 'g');
    end
end

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2




% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name = get(handles.edit5, 'String');
ustrich = findstr(name, '\');

[filename, pathname] = uigetfile('*.c3d', 'Daten bitte',  name(1:ustrich(end)), 'MultiSelect', 'on');
for i = 1:length(filename)
   filename2(i) = {[pathname, char(filename(1,i))]};
end

set(handles.listbox1, 'String', filename2);

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
if get(handles.radiobutton5, 'Value') == 0
    set(handles.radiobutton6, 'Value', 1);
else
    set(handles.radiobutton6, 'Value', 0);
end

set(handles.pushbutton4, 'Enable', 'off');
set(handles.text7, 'Enable', 'off');
set(handles.listbox1, 'Enable', 'off');
set(handles.pushbutton2, 'Enable', 'on');
set(handles.edit6, 'Enable', 'on');
set(handles.text6, 'Enable', 'on');

% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6
if get(handles.radiobutton6, 'Value') == 0
    set(handles.radiobutton5, 'Value', 1);
else
    set(handles.radiobutton5, 'Value', 0);
end
set(handles.pushbutton4, 'Enable', 'on');

set(handles.listbox1, 'Enable', 'on');
set(handles.text7, 'Enable', 'on');
set(handles.pushbutton2, 'Enable', 'off');
set(handles.edit6, 'Enable', 'off');
set(handles.text6, 'Enable', 'off');
