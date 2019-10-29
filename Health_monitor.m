function varargout = Health_monitor(varargin)
% HEALTH_MONITOR MATLAB code for Health_monitor.fig
%      HEALTH_MONITOR, by itself, creates a new HEALTH_MONITOR or raises the existing
%      singleton*.
%
%      H = HEALTH_MONITOR returns the handle to a new HEALTH_MONITOR or the handle to
%      the existing singleton*.
%
%      HEALTH_MONITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HEALTH_MONITOR.M with the given input arguments.
%
%      HEALTH_MONITOR('Property','Value',...) creates a new HEALTH_MONITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Health_monitor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Health_monitor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Health_monitor

% Last Modified by GUIDE v2.5 01-May-2018 07:39:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Health_monitor_OpeningFcn, ...
                   'gui_OutputFcn',  @Health_monitor_OutputFcn, ...
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


% --- Executes just before Health_monitor is made visible.
function Health_monitor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Health_monitor (see VARARGIN)

% Choose default command line output for Health_monitor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Health_monitor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Health_monitor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ECGButton.
function ECGButton_Callback(hObject, eventdata, handles)
% hObject    handle to ECGButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ECG_f


% --- Executes on button press in EMGbutton.
function EMGbutton_Callback(hObject, eventdata, handles)
% hObject    handle to EMGbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
EMG_f

% --- Executes on button press in Airflowbutton.
function Airflowbutton_Callback(hObject, eventdata, handles)
% hObject    handle to Airflowbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Aiflow_f
