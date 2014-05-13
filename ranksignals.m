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

% Last Modified by GUIDE v2.5 13-May-2014 14:04:05

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

% Get file info from the user
[FILENAME, PATHNAME, FILTERINDEX] = uigetfile();
str_imgfilename = FILENAME;
str_imgfilepath = PATHNAME;

% Read img file
img_inputimg = imread([str_imgfilepath str_imgfilename]);

% Load the Data file
if exist(str_datafilename, 'file')
    % Data file exists, therefore ...
    
    % ... Load all the data.
    struct_data = load(str_datafilename);
    
    % THIS LINE SHOULD BE REMOVED AFTER TESTING
    % THIS LINE SHOULD BE REMOVED AFTER TESTING
    % THIS LINE SHOULD BE REMOVED AFTER TESTING
    struct_data = struct_data.Data; 
    % THIS LINE SHOULD BE REMOVED AFTER TESTING
    % THIS LINE SHOULD BE REMOVED AFTER TESTING
    % THIS LINE SHOULD BE REMOVED AFTER TESTING
    
    % ... Find if the image has already been added to the database.
    [nummatches] = find([struct_data.imgname] == str_imgfilename);
        % ...If match found
        
        % ... If match not found... process the image for the first time
        [img_output] = firstprocimg(img_inputimg);
    
else    
    % Part of code to be executed if no Data.mat database exists...
    
    % ... Process the img for the first time
    [img_output] = firstprocimg(img_inputimg);
    
    % ... Copy the data
    struct_data = img_output;
    save(str_datafilename, 'struct_data');
    
    % ... Now let the user perform the forced choice experiments.
    
    
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
[int_linearindices] = find(img_peakpositions == 1  & img_double > 450);
[int_R, int_C] = find(img_peakpositions == 1  & img_double > 450);
img_peakpositions = zeros(size(img_peakpositions));
img_peakpositions(int_linearindices) = 1;
% ... Grade these peak positions
img_grade = gradepeaks2D(img_double, img_peakpositions, 3, 11);

% ... Load the data structure
Data = [];
for k = 1:length(int_linearindices)
    Data(k).img = str_imgfilename;
    Data(k).peak = sum(img_grade(int_R(k), int_C(k), :));
    assert(length(img_grade(int_R(k), int_C(k), :)) == 5, 'Length mismatch in firstprocimg');
    Data(k).r = int_R(k);
    Data(k).c = int_C(k);
    Data(k).ispeak = 1;
end

img_output = Data;




