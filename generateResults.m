function varargout = generateResults(varargin)
% GENERATERESULTS MATLAB code for generateResults.fig
%      GENERATERESULTS, by itself, creates a new GENERATERESULTS or raises the existing
%      singleton*.
%
%      H = GENERATERESULTS returns the handle to a new GENERATERESULTS or the handle to
%      the existing singleton*.
%
%      GENERATERESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GENERATERESULTS.M with the given input arguments.
%
%      GENERATERESULTS('Property','Value',...) creates a new GENERATERESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before generateResults_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to generateResults_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help generateResults

% Last Modified by GUIDE v2.5 25-Jun-2014 13:27:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @generateResults_OpeningFcn, ...
                   'gui_OutputFcn',  @generateResults_OutputFcn, ...
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


% --- Executes just before generateResults is made visible.
function generateResults_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to generateResults (see VARARGIN)

% Choose default command line output for generateResults
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes generateResults wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = generateResults_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

global img_inputimg;
global str_inputimgname;

[FILENAME, PATHNAME, FILTERINDEX] = uigetfile();
str_imgfilename = FILENAME;
str_imgfilepath = PATHNAME;

str_inputimgname = str_imgfilename;

img_inputimg = imread([str_imgfilepath str_imgfilename]);
set(handles.text1,'String',[str_imgfilepath str_imgfilename]);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

global struct_data;

[FILENAME, PATHNAME, FILTERINDEX] = uigetfile();
str_imgfilename = FILENAME;
str_imgfilepath = PATHNAME;

struct_data = load([str_imgfilepath str_imgfilename]);
set(handles.text2,'String',[str_imgfilepath str_imgfilename]);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

global str_inputimgname;
global struct_data;

Data = struct_data.Records;
Data_Temp = [];

for i = 1:length(Data)
    if strcmp(getfield(Data, {i},'img'), str_inputimgname)
        Data_Temp = [Data_Temp i];
    end
end
Data = Data(Data_Temp);
Cells = squeeze(struct2cell(Data));
User_Names = unique(Cells(4,:)');
Cells_Names = Cells(4,:);
Peak_Details = Cells(1,:);

ImageData = zeros(1,199);

for k = 1:length(User_Names)
    index = find(strcmp(Cells_Names, User_Names{k}));
    index = index(1:199);
    index = cell2mat(Peak_Details(index));
    ImageData = ImageData + index;
end

figure; bar (ImageData)

figure; plot(ImageData); hold on; ylim([0 10]); plot(1:199, ones(1,199)*2, 'r');






