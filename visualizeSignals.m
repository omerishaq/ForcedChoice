function varargout = visualizeSignals(varargin)
% VISUALIZESIGNALS MATLAB code for visualizeSignals.fig
%      VISUALIZESIGNALS, by itself, creates a new VISUALIZESIGNALS or raises the existing
%      singleton*.
%
%      H = VISUALIZESIGNALS returns the handle to a new VISUALIZESIGNALS or the handle to
%      the existing singleton*.
%
%      VISUALIZESIGNALS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VISUALIZESIGNALS.M with the given input arguments.
%
%      VISUALIZESIGNALS('Property','Value',...) creates a new VISUALIZESIGNALS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before visualizeSignals_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to visualizeSignals_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help visualizeSignals

% Last Modified by GUIDE v2.5 24-Jun-2014 14:22:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @visualizeSignals_OpeningFcn, ...
                   'gui_OutputFcn',  @visualizeSignals_OutputFcn, ...
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


% --- Executes just before visualizeSignals is made visible.
function visualizeSignals_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to visualizeSignals (see VARARGIN)

% Choose default command line output for visualizeSignals
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.edit1,'String','');
set(handles.edit2,'String','');
set(handles.edit3,'String','');

set(handles.edit1,'Enable','off');
set(handles.edit2,'Enable','off');

% UIWAIT makes visualizeSignals wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = visualizeSignals_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

global struct_data;

[FILENAME, PATHNAME, FILTERINDEX] = uigetfile();
str_imgfilename = FILENAME;
str_imgfilepath = PATHNAME;

struct_data = load([str_imgfilepath str_imgfilename]);
set(handles.edit1,'String',[str_imgfilepath str_imgfilename]);



% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

global img_inputimg;
global str_inputimgname;

[FILENAME, PATHNAME, FILTERINDEX] = uigetfile();
str_imgfilename = FILENAME;
str_imgfilepath = PATHNAME;

str_inputimgname = str_imgfilename;

img_inputimg = imread([str_imgfilepath str_imgfilename]);
set(handles.edit2,'String',[str_imgfilepath str_imgfilename]);

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit3_Callback(hObject, eventdata, handles)

global int_number;
global struct_data;
global img_inputimg;
global str_inputimgname;

int_number = str2num(get(handles.edit3,'String'));

data = struct_data(1).struct_data;
img = [];

counter = 1;
for k = 1:length(data)
    if strcmp(data(k).img, str_inputimgname)
        temp_data(counter) = data(k);
        counter = counter + 1;
    end
end

for k = 1:int_number;
    
    img = [img img_inputimg(temp_data(k).r-3:temp_data(k).r+3, temp_data(k).c-3:temp_data(k).c+3);]
    img = [img ones(7,2)*2^15];
    
end

img = img(:,1:end-3);

figure; hold on; 
imagesc(img); axis image;
colormap gray;

imwrite(img, 'latest_save.tif');



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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
