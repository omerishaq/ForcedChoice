function varargout = ranksignals(varargin)
% RANKSIGNALS MATLAB code for ranksignals.fig
%      RANKSIGNALS, by itself, creates a new RANKSIGNALS or raises the existing
%      singleton*.
%
%      H = RANKSIGNALS returns the handle to a new RANKSIGNALS or the handle to
%      the existing singleton*.
%
%      RANKSIGNALS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RANKSIGNALS.M with the given input arguments.
%
%      RANKSIGNALS('Property','Value',...) creates a new RANKSIGNALS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ranksignals_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ranksignals_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ranksignals

% Last Modified by GUIDE v2.5 14-May-2014 01:07:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ranksignals_OpeningFcn, ...
                   'gui_OutputFcn',  @ranksignals_OutputFcn, ...
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

global str_datafilename;
global str_resultsfilename;

str_datafilename = 'Data.mat';
str_resultsfilename = 'Results.mat';

% --- Executes just before ranksignals is made visible.
function ranksignals_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ranksignals (see VARARGIN)

axis (handles.axes1, 'off');
axis (handles.axes2, 'off');
axis (handles.axes3, 'off');

% Choose default command line output for ranksignals
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Check if the database file exists




% UIWAIT makes ranksignals wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ranksignals_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

global str_datafilename;
global str_resultsfilename;
global str_imgfilename;
global str_imgfilepath;
global img_inputimg;
global str_username;
global struct_data;

global struct_UP;
global struct_DOWN;

% Get file info from the user
[FILENAME, PATHNAME, FILTERINDEX] = uigetfile();
str_imgfilename = FILENAME;
str_imgfilepath = PATHNAME;

% Read img file
img_inputimg = imread([str_imgfilepath str_imgfilename]);
imshow(img_inputimg, 'Parent', handles.axes1);

% Load the Data file
if exist(str_datafilename, 'file')
    % Data file exists, therefore ...
    
    % ... Load all the data.
    temp_data = load(str_datafilename);
%     struct_data = temp_data.struct_data;
    
    % ... Find if the image has already been added to the database.
    matchf = 0;
    for i = 1:length(temp_data.struct_data)
        if strcmp(temp_data.struct_data(i).img, str_imgfilename);
            matchf = 1;
            break
        end
    end
    
    % ...If match found
    if matchf == 1
        struct_data = [];
        for i = 1:length(temp_data.struct_data)
            if strcmp(temp_data.struct_data(i).img, str_imgfilename);
                struct_data = [struct_data temp_data.struct_data(i)];
            end
        end
        
        % ... Now let the user perform the forced choice experiments.
        [struct_H, struct_L] = performforcedchoice (struct_data)

        % Flip the data if required
        if rand > 0.5
            struct_UP = struct_H;
            struct_DOWN = struct_L;
        else
            struct_UP = struct_L;
            struct_DOWN = struct_H;
        end

        axes(handles.axes1) 
        curAxisProps=axis;
        rectangle('Position',[struct_UP.c-6,struct_UP.r-6,13,13],'EdgeColor','r');
        axis(curAxisProps)

        axes(handles.axes1) 
        curAxisProps=axis;
        rectangle('Position',[struct_DOWN.c-6,struct_DOWN.r-6,13,13],'EdgeColor','g');
        axis(curAxisProps)

        imshow(img_inputimg(struct_UP.r-3:struct_UP.r+3, struct_UP.c-3:struct_UP.c+3), 'Parent', handles.axes2);
        imshow(img_inputimg(struct_DOWN.r-3:struct_DOWN.r+3, struct_DOWN.c-3:struct_DOWN.c+3), 'Parent', handles.axes3);

        axes(handles.axes2) 
        curAxisProps=axis;
        rectangle('Position',[1,1,6,6],'EdgeColor','r');
        axis(curAxisProps)

        axes(handles.axes3) 
        curAxisProps=axis;
        rectangle('Position',[1,1,6,6],'EdgeColor','g');
        axis(curAxisProps)

 
        
        
    end
        
    % ... If match not found... process the image for the first time
    if matchf == 0
        [img_output] = firstprocimg(img_inputimg);
        struct_data = img_output;

        % ... Now let the user perform the forced choice experiments.
        [struct_H, struct_L] = performforcedchoice (struct_data)

        % Flip the data if required
        if rand > 0.5
            struct_UP = struct_H;
            struct_DOWN = struct_L;
        else
            struct_UP = struct_L;
            struct_DOWN = struct_H;
        end

        axes(handles.axes1) 
        curAxisProps=axis;
        rectangle('Position',[struct_UP.c-6,struct_UP.r-6,13,13],'EdgeColor','r');
        axis(curAxisProps)

        axes(handles.axes1) 
        curAxisProps=axis;
        rectangle('Position',[struct_DOWN.c-6,struct_DOWN.r-6,13,13],'EdgeColor','g');
        axis(curAxisProps)

        imshow(img_inputimg(struct_UP.r-3:struct_UP.r+3, struct_UP.c-3:struct_UP.c+3), 'Parent', handles.axes2);
        imshow(img_inputimg(struct_DOWN.r-3:struct_DOWN.r+3, struct_DOWN.c-3:struct_DOWN.c+3), 'Parent', handles.axes3);

        axes(handles.axes2) 
        curAxisProps=axis;
        rectangle('Position',[1,1,6,6],'EdgeColor','r');
        axis(curAxisProps)

        axes(handles.axes3) 
        curAxisProps=axis;
        rectangle('Position',[1,1,6,6],'EdgeColor','g');
        axis(curAxisProps)

        temp_data = load(str_datafilename);
        struct_data = [temp_data.struct_data struct_data];
        save(str_datafilename, 'struct_data');
    end
    
else    
    % Part of code to be executed if no Data.mat database exists...
    
    % ... Process the img for the first time
    [img_output] = firstprocimg(img_inputimg);
    
    % ... Copy the data
    struct_data = img_output;
    save(str_datafilename, 'struct_data');
    
    % ... Now let the user perform the forced choice experiments.
    [struct_H, struct_L] = performforcedchoice (struct_data)
    
    % Flip the data if required
    if rand > 0.5
        struct_UP = struct_H;
        struct_DOWN = struct_L;
    else
        struct_UP = struct_L;
        struct_DOWN = struct_H;
    end
    colormap(jet);
    axes(handles.axes1) 
    curAxisProps=axis;
    rectangle('Position',[struct_UP.c-6,struct_UP.r-6,13,13],'EdgeColor','r');
    axis(curAxisProps)
    
    axes(handles.axes1) 
    curAxisProps=axis;
    rectangle('Position',[struct_DOWN.c-6,struct_DOWN.r-6,13,13],'EdgeColor','g');
    axis(curAxisProps)
    
    imshow(img_inputimg(struct_UP.r-3:struct_UP.r+3, struct_UP.c-3:struct_UP.c+3), 'Parent', handles.axes2);
    imshow(img_inputimg(struct_DOWN.r-3:struct_DOWN.r+3, struct_DOWN.c-3:struct_DOWN.c+3), 'Parent', handles.axes3);
    
    axes(handles.axes2) 
    curAxisProps=axis;
    rectangle('Position',[1,1,6,6],'EdgeColor','r');
    axis(curAxisProps)
    
    axes(handles.axes3) 
    curAxisProps=axis;
    rectangle('Position',[1,1,6,6],'EdgeColor','g');
    axis(curAxisProps)
        
end


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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

global str_username;

% Copy contents of the edit box.
str_username = get(handles.edit1,'String');
set(handles.edit1,'Enable','off')

function [] = loadnext (handles)

    global struct_data;
    global struct_UP;
    global struct_DOWN;
    global img_inputimg;
    
    % ... Now let the user perform the forced choice experiments.
    [struct_H, struct_L] = performforcedchoice (struct_data)
    
    % Flip the data if required
    if rand > 0.5
        struct_UP = struct_H;
        struct_DOWN = struct_L;
    else
        struct_UP = struct_L;
        struct_DOWN = struct_H;
    end
    
    imshow(img_inputimg, 'Parent', handles.axes1);
    
    axes(handles.axes1) 
    curAxisProps=axis;
    rectangle('Position',[struct_UP.c-6,struct_UP.r-6,13,13],'EdgeColor','r');
    axis(curAxisProps)
    
    axes(handles.axes1) 
    curAxisProps=axis;
    rectangle('Position',[struct_DOWN.c-6,struct_DOWN.r-6,13,13],'EdgeColor','g');
    axis(curAxisProps)
    
    imshow(img_inputimg(struct_UP.r-3:struct_UP.r+3, struct_UP.c-3:struct_UP.c+3), 'Parent', handles.axes2);
    imshow(img_inputimg(struct_DOWN.r-3:struct_DOWN.r+3, struct_DOWN.c-3:struct_DOWN.c+3), 'Parent', handles.axes3);
    
    axes(handles.axes2) 
    curAxisProps=axis;
    rectangle('Position',[1,1,6,6],'EdgeColor','r');
    axis(curAxisProps)
    
    axes(handles.axes3) 
    curAxisProps=axis;
    rectangle('Position',[1,1,6,6],'EdgeColor','g');
    axis(curAxisProps)

function [struct_H, struct_L] = performforcedchoice (struct_input)

% Perform forced choice by ...
% ... Randomly select a high SNR datapoint.
[int_matches] = find([struct_input.ispeak] == 1);
struct_highSNR = struct_input(int_matches);
int_temp1 = round(rand * length(int_matches));
struct_H = struct_highSNR(int_temp1);

% ... Randomly select a low SNR datapoint.
[int_matches] = find([struct_input.ispeak] == 0);
struct_lowSNR = struct_input(int_matches);
int_temp2 = round(rand * length(int_matches));
struct_L = struct_lowSNR(int_temp2);

function [img_output] = firstprocimg (img_input)

global str_imgfilename;
    
% ... Remove image gain.
img_gaincorrected = img_input/54;
% ... Denoise image
img_denoised = func_denoise_dw2d(img_gaincorrected);
img_double = double(img_denoised);
% ... Find all local peaks in the image
img_peakpositions = findpeaks2D(img_double, 3, 1);
% ... Filter the peaks by the criterion below

% ...... First for the high peaks / signals
[int_linearindices_high] = find(img_peakpositions == 1  & img_double > 650); % SET to 450
[int_R_high, int_C_high] = find(img_peakpositions == 1  & img_double > 650);
img_peakpositions_high = zeros(size(img_peakpositions));
img_peakpositions_high(int_linearindices_high) = 1;
img_grade_high = gradepeaks2D(img_double, img_peakpositions_high, 3, 11);

% ...... Then for the low peaks / signals
[int_linearindices_low] = find(img_peakpositions == 1  & img_double < 350 & img_double > 340); % SET to 300
[int_R_low, int_C_low] = find(img_peakpositions == 1  & img_double < 350 & img_double > 340);
img_peakpositions_low = zeros(size(img_peakpositions));
img_peakpositions_low(int_linearindices_low) = 1;
img_grade_low = gradepeaks2D(img_double, img_peakpositions_low, 3, 11);

% ... Grade these peak positions
% img_grade = gradepeaks2D(img_double, img_peakpositions, 3, 11);

% ... Load the data structure with img name, peak fitness, rows and columns
% ... as well as whether it is treated as a peak or not.
Data = [];
for k = 1:length(int_linearindices_high)
    Data(k).img = str_imgfilename;
    Data(k).peak = sum(img_grade_high(int_R_high(k), int_C_high(k), :));
    assert(length(img_grade_high(int_R_high(k), int_C_high(k), :)) == 5, 'Length mismatch in firstprocimg');
    Data(k).r = int_R_high(k);
    Data(k).c = int_C_high(k);
    Data(k).ispeak = 1;
end


int_offset = length(Data);
for k = 1 : length(int_linearindices_low)
    Data(k+int_offset).img = str_imgfilename;
    Data(k+int_offset).peak = sum(img_grade_low(int_R_low(k), int_C_low(k), :));
    assert(length(img_grade_low(int_R_low(k), int_C_low(k), :)) == 5, 'Length mismatch in firstprocimg');
    Data(k+int_offset).r = int_R_low(k);
    Data(k+int_offset).c = int_C_low(k);
    Data(k+int_offset).ispeak = 0;
end

img_output = Data;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global struct_UP;
global struct_DOWN;
global str_imgfilename;
global str_username;
global str_resultsfilename;

struct_record.img = str_imgfilename;
struct_record.user = str_username;

if struct_UP.ispeak == 1
    struct_record.peak = 1;
    struct_record.r = struct_UP.r;
    struct_record.c = struct_UP.c;
else
    struct_record.peak = 0;
    struct_record.r = struct_DOWN.r;
    struct_record.c = struct_DOWN.c;
end

Records = load(str_resultsfilename);
ilength = length(Records.Records);
Records.Records(ilength + 1).peak = struct_record.peak;
Records.Records(ilength + 1).r = struct_record.r;
Records.Records(ilength + 1).c = struct_record.c;
Records.Records(ilength + 1).user = struct_record.user;
Records.Records(ilength + 1).img = struct_record.img;
save(str_resultsfilename, 'Records');

loadnext(handles);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global struct_UP;
global struct_DOWN;
global str_imgfilename;
global str_username;
global str_resultsfilename;

struct_record.img = str_imgfilename;
struct_record.user = str_username;

if struct_DOWN.ispeak == 1
    struct_record.peak = 1;
    struct_record.r = struct_DOWN.r;
    struct_record.c = struct_DOWN.c;
else
    struct_record.peak = 0;
    struct_record.r = struct_UP.r;
    struct_record.c = struct_UP.c;
end

Records = load(str_resultsfilename);
ilength = length(Records.Records);
Records.Records(ilength + 1).peak = struct_record.peak;
Records.Records(ilength + 1).r = struct_record.r;
Records.Records(ilength + 1).c = struct_record.c;
Records.Records(ilength + 1).user = struct_record.user;
Records.Records(ilength + 1).img = struct_record.img;
save(str_resultsfilename, 'Records');

loadnext(handles);
