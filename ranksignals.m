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

% Last Modified by GUIDE v2.5 13-May-2014 13:25:23

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

global vvdatafilename;
global vvresultsfilename;

vvdatafilename = 'Data.mat';
vvresultsfilename = 'Results.mat';

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
